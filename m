Return-Path: <netdev+bounces-217989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D1AB3AB73
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F1C3BBB7A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 20:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4CB275B0E;
	Thu, 28 Aug 2025 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvVQ/gu7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD9E21018A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412239; cv=none; b=NAYSlpnpuJgBPg1H9kKJ1fNHihewNUgZpi+LYD6Gsbm5MZEy0v6/EsH2sbAJqiRvi4T/84G7wbRcXCtPSO8BKE7VRc/ZsXZn4XveAnweA3mjhPirYiD9sJ4g1qS+P7TalKUV2Yuhz49sok4qBAUNL7nCe63H6+PR8xRDm2oDQmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412239; c=relaxed/simple;
	bh=5K6Qqjco+hpGx5ldkSFstji5FzSX1GcOTX5w3Mmsi5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgzFsuAdKyEfwXaypZjS/EudMDD5EgXQM8m1wcJN4RuI+c8Nw+DnJWQsFpH2mzsBjygwIgL2VAqRvJdlSNxex3O8HRcANZbJpgVB6NTx3wXC1v6vtdzXY0VkLfTv9tbxFEjRMg/hvNB1uf/0Iyvzoxy+nb6pmr2hMEmVIWU3PI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvVQ/gu7; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d5fb5e34cso13667967b3.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756412237; x=1757017037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVIYSzzBdtLqyz/cM9J+RNwMg0Uv4BHa2bjJlEe54ec=;
        b=IvVQ/gu7tWl43MJmsILwwD0k2UawIsLG76lzkR+Lv4el0OCt2nbn9kWOuvRKb7pqYe
         Y39BWjPeXGWIjkakb7bZ+3QSTnjtk1SJ59YIhblV+m876hiSECbVBNqPq+S2AHNxT0Ni
         YTSc7Gjq3qBcZ3+NVL1zLDmh9Fp7qg4HsJfMBVW4x1oUDtfyQyLYaRpxa+sSKfl8xlUY
         6rE+YE7gi6UXL95tapSL+1oLosimhS0qa/ARw9bc9GqfsIUjuCEQb+FYS9hRcJ7o28ZW
         77FvUmX2BgJVxrRMGEC/Suc8Ej7stPLX5TGvavRCFVOJBlrKSBnDhCp1nyUdnEcB+ItG
         ZrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756412237; x=1757017037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVIYSzzBdtLqyz/cM9J+RNwMg0Uv4BHa2bjJlEe54ec=;
        b=tPI/mFI0PI+X1mKxuy4DdcWOsIrznhKLmeIY40axgPyAOvKwO/o+xQkM4c3w77/c45
         RoI368jERVBgOe5MGyRD4JmUCzF/0WoD0l2AjXh/0OcbGzeBXRiBF8NQCiHCLyGnBCXd
         hLY4s/ZkwzAdnI4xSH0fkmka4J/REpQ1LNYDVqs6eD3DIJ36C//Wg4+jiqODn4kgyLhF
         n9TWtVIxguYYP/Mza/1wwnFyH1pJHzgArzBFCydseXBwE29eofNNdHfHNIZ3iYrdjWCC
         MBttv2muHMLrSD0LOdfK5PPqZxaeHltwI2voghZIjbnQ26qkP4UbFdlvvYanyG3J3gL7
         hRPg==
X-Gm-Message-State: AOJu0YzVSTdSu4maRzP+CtpzznBqProtAGuIgMEzElFTm54ueZxlT4oU
	fcvY32ytAraOoTYlU0zt8DKhict/n6bkxxD14+bHUgyIFPsVVwaV7vrMgb9uMU2qGDcxQRo/VCd
	MBy8X3MC97SLb1sC9/dkO/1WI0K6lUSc=
X-Gm-Gg: ASbGncv6snahTDMnsHZAKuiRUfzPZEBfWKjLqn3fhlDZkrJgNmLiBeitzufes2evfbd
	GKYUOn6PCof9Z4k7xLLvDoyHpb+z+9NQtVSoofQh0iXplBTsZhlQzvpGC+tROCU9j3/8zJlxczu
	CXa7SPPaGt6WR3WX80tfNzTIM/EMrmXDByazusp1gP6tNAv8boydNdcSmGIz8jQkvXKrXU0tx3i
	1jqbybt3yguWDABXx9OfBrrCM85td1YW84z9o5zRcXAXcwZ1X+ZK/LT3dTHLgpQgNw+xd8KIgx8
	39LO/w==
X-Google-Smtp-Source: AGHT+IEsL7mZOzAdQVDakrDRy5Za0m5mEtLGSlg13FEJDzY5ErO5vKoSx3gs6jC5Fw4ZZx7ovgbrwylEuQkaJHwYYOI=
X-Received: by 2002:a05:690c:45ca:b0:71e:6583:7d37 with SMTP id
 00721157ae682-72132cd6c16mr116423067b3.14.1756412236752; Thu, 28 Aug 2025
 13:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827215042.79843-1-rosenp@gmail.com> <20250827215042.79843-3-rosenp@gmail.com>
 <20250828111216.bruz7lq7dz5e6b6f@DEN-DL-M70577>
In-Reply-To: <20250828111216.bruz7lq7dz5e6b6f@DEN-DL-M70577>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 28 Aug 2025 13:17:05 -0700
X-Gm-Features: Ac12FXy1vFdwF22EsuhqQTgjNIxL_XF7D3fJm6a6AgFl5IBG4ZFzOj1EFS3ue68
Message-ID: <CAKxU2N-zuZfCwU83UA1SQ4c8JrJc+oGSg0Vu28P316uZsVMgcQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: lan966x: convert fwnode to of
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev@vger.kernel.org, horatiu.vultur@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:12=E2=80=AFAM Daniel Machon
<daniel.machon@microchip.com> wrote:
>
> > This is a purely OF driver. There's no need for fwnode to handle any of
> > this, with the exception being phylik_create. Use of_fwnode_handle for
> > that.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  .../ethernet/microchip/lan966x/lan966x_main.c | 32 ++++++++++---------
> >  .../ethernet/microchip/lan966x/lan966x_main.h |  2 +-
> >  2 files changed, 18 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/dr=
ivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > index 8bf28915c030..d778806dcfc6 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > @@ -183,7 +183,7 @@ static int lan966x_port_open(struct net_device *dev=
)
> >                 ANA_PORT_CFG_PORTID_VAL,
> >                 lan966x, ANA_PORT_CFG(port->chip_port));
> >
> > -       err =3D phylink_fwnode_phy_connect(port->phylink, port->fwnode,=
 0);
> > +       err =3D phylink_of_phy_connect(port->phylink, port->dnode, 0);
> >         if (err) {
> >                 netdev_err(dev, "Could not attach to PHY\n");
> >                 return err;
> > @@ -767,8 +767,8 @@ static void lan966x_cleanup_ports(struct lan966x *l=
an966x)
> >                         port->phylink =3D NULL;
> >                 }
> >
> > -               if (port->fwnode)
> > -                       fwnode_handle_put(port->fwnode);
> > +               if (port->dnode)
> > +                       of_node_put(port->dnode);
> >         }
> >
> >         disable_irq(lan966x->xtr_irq);
> > @@ -1081,7 +1081,7 @@ static int lan966x_reset_switch(struct lan966x *l=
an966x)
> >
> >  static int lan966x_probe(struct platform_device *pdev)
> >  {
> > -       struct fwnode_handle *ports, *portnp;
> > +       struct device_node *ports, *portnp;
> >         struct lan966x *lan966x;
> >         int err;
> >
> > @@ -1179,7 +1179,7 @@ static int lan966x_probe(struct platform_device *=
pdev)
> >                 }
> >         }
> >
> > -       ports =3D device_get_named_child_node(&pdev->dev, "ethernet-por=
ts");
> > +       ports =3D of_get_child_by_name(pdev->dev.of_node, "ethernet-por=
ts");
> >         if (!ports)
> >                 return dev_err_probe(&pdev->dev, -ENODEV,
> >                                      "no ethernet-ports child found\n")=
;
> > @@ -1191,25 +1191,27 @@ static int lan966x_probe(struct platform_device=
 *pdev)
> >         lan966x_stats_init(lan966x);
> >
> >         /* go over the child nodes */
> > -       fwnode_for_each_available_child_node(ports, portnp) {
> > +       for_each_available_child_of_node(ports, portnp) {
> >                 phy_interface_t phy_mode;
> >                 struct phy *serdes;
> >                 u32 p;
> >
> > -               if (fwnode_property_read_u32(portnp, "reg", &p))
> > +               if (of_property_read_u32(portnp, "reg", &p))
> >                         continue;
> >
> > -               phy_mode =3D fwnode_get_phy_mode(portnp);
> > -               err =3D lan966x_probe_port(lan966x, p, phy_mode, portnp=
);
> > +               err =3D of_get_phy_mode(portnp, &phy_mode);
> > +               if (err)
> > +                       goto cleanup_ports;
> > +
> > +               err =3D lan966x_probe_port(lan966x, p, phy_mode, of_fwn=
ode_handle(portnp));
>
> As I see it, you could change the signature of lan966x_probe_port() to ac=
cept a
> struct device_node, and instead pass that.  Then you can convert it to fw=
node
> for phylink_create, and ditch to_of_node().
Will fix.
>
> Same goes for lan966x_port_parse_delays(), here you can change
> fwnode_for_each_available_child_node() to for_each_available_child_of_nod=
e()
> and fwnode_property_read_u32() to of_property_read_u32().
I don't see this lan966x_port_parse_delays function.
>
> That will get rid of all the struct fwnode_handle uses and be more consis=
tent.
>
> >                 if (err)
> >                         goto cleanup_ports;
> >
> >                 /* Read needed configuration */
> >                 lan966x->ports[p]->config.portmode =3D phy_mode;
> > -               lan966x->ports[p]->fwnode =3D fwnode_handle_get(portnp)=
;
> > +               lan966x->ports[p]->dnode =3D of_node_get(portnp);
> >
> > -               serdes =3D devm_of_phy_optional_get(lan966x->dev,
> > -                                                 to_of_node(portnp), N=
ULL);
> > +               serdes =3D devm_of_phy_optional_get(lan966x->dev, portn=
p, NULL);
> >                 if (IS_ERR(serdes)) {
> >                         err =3D PTR_ERR(serdes);
> >                         goto cleanup_ports;
> > @@ -1222,7 +1224,7 @@ static int lan966x_probe(struct platform_device *=
pdev)
> >                         goto cleanup_ports;
> >         }
> >
> > -       fwnode_handle_put(ports);
> > +       of_node_put(ports);
> >
> >         lan966x_mdb_init(lan966x);
> >         err =3D lan966x_fdb_init(lan966x);
> > @@ -1255,8 +1257,8 @@ static int lan966x_probe(struct platform_device *=
pdev)
> >         lan966x_fdb_deinit(lan966x);
> >
> >  cleanup_ports:
> > -       fwnode_handle_put(ports);
> > -       fwnode_handle_put(portnp);
> > +       of_node_put(ports);
> > +       of_node_put(portnp);
> >
> >         lan966x_cleanup_ports(lan966x);
> >
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/dr=
ivers/net/ethernet/microchip/lan966x/lan966x_main.h
> > index 4f75f0688369..bafb8f5ee64d 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> > @@ -407,7 +407,7 @@ struct lan966x_port {
> >         struct lan966x_port_config config;
> >         struct phylink *phylink;
> >         struct phy *serdes;
> > -       struct fwnode_handle *fwnode;
> > +       struct device_node *dnode;
> >
> >         u8 ptp_tx_cmd;
> >         bool ptp_rx_cmd;
> > --
> > 2.51.0
> >
>
> /Daniel

