Return-Path: <netdev+bounces-143659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C84F9C3830
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 07:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A06B20AC1
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 06:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D98149DF4;
	Mon, 11 Nov 2024 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AJqa2ko4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7BE1EA80
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 06:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731305350; cv=none; b=DhiI9e6pAuzoYvbwTN7YIs56PojB2zvcHb7V+aYpNyM9ZlcOHZV+21IWe1r8LggWQMiM0cQxK4l1L+0SLbeb8tQt7m/wULGd4SjZkAHAXodJmNbbgLqt7GJIsbAOXD5psvSW1iSmwxF+B8RYI52MshkMXjSFKhPY+6fDtb3MDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731305350; c=relaxed/simple;
	bh=ezWXgouObsZgOtHFRCMQBU1KxQrUacGZDKZX3OByKIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVcj73l2MBtATEz3WYaF13+PiY+9l7IHUP8uE+zgr9f1Zx057liSFCKHpbevGelj9WI7uO1RoQyKtqR+oCjFqqGfY0GHdpJEKp2zKeNqX6zy/C9tymFc9PE/8wP1Sm3zk1OBKSvazxGQMcnqlbgNGBZZWkBCt5Rr7Dr880olsIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AJqa2ko4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f84907caso4516247e87.3
        for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 22:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731305346; x=1731910146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3gKbZ5KtCHGq73Ti9awBakK+S1vvIGVvUjl93bYfFgU=;
        b=AJqa2ko4GHirx5NlmnJcVAVOCrrGZwY4LYmYbR21S24LTPmXaU+bWYk06OjudXb/gC
         DK/N0SIeztSFwCOo0sdIB0B9jG9a10vn/0ubDClAqidsKk3QAlTgoF1KEeb2RDAfi2Wt
         koeICHFR+JQzLved/2Tt3LUmAZgvESGZW+NC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731305346; x=1731910146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gKbZ5KtCHGq73Ti9awBakK+S1vvIGVvUjl93bYfFgU=;
        b=gFWyy9nWbri2SVQUlRm+Ck20ZtNRohC3VeBc4sb4j4sSSOxIFfMjN7ZDY9hObjsslT
         JO+HS66QyhJDXESP0TGjwrZog5bHXUmHVCRMI8Q/wW5IvwXx9JXbnD3/HGs9Jg81rt21
         GYQrzwIrsnvvF253C1EkmzBArp5om+NwpGgaDBApd/1PBbFh2AOZtOT1TkeVh7AHRZR1
         FT9qpyl24fxmEm5Xrkmtea4BVDytfktr9LXr6i3IGX6AXMr2sX42jUxtfRfLPAQiLDbF
         bz52+NU7jlwfG05+kZjKLNpxHRTKZfYEQ1ZOF1IrI/XZ13TSrXHiM9KUgah+ShV1mNJ1
         EXpg==
X-Gm-Message-State: AOJu0YxfvLHGDhQn/uCdQHkSclnRXlBQqgoUR6I/fydXjFaDfdLttSGQ
	i2VyZ4cGgpDHvwots5/Mp82GkoZQlOyMghvyrm65rcutO1gJfmjKVZaqaPL7TUHRTDcCZJxX32P
	wIms/KJ+ge/cJTzg5M9IQ84mBJx5FZRiMgn2/
X-Google-Smtp-Source: AGHT+IEnfO2StxBrmWnhMFWGmi+xwnKJAetjQkOpS36XJ4HiELKh/UuFNYBmx7o8pIyjJrN5CFqBjZyrXVey72WQVRQ=
X-Received: by 2002:a05:6512:3f17:b0:539:e94d:b490 with SMTP id
 2adb3069b0e04-53d862ebf33mr4008765e87.43.1731305346272; Sun, 10 Nov 2024
 22:09:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107121637.1117089-1-srasheed@marvell.com>
In-Reply-To: <20241107121637.1117089-1-srasheed@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 11 Nov 2024 11:38:58 +0530
Message-ID: <CAH-L+nO97YLd+gG1dGfyi=xZUCLJg+GsGAv=Dyf-4hA3-TP--A@mail.gmail.com>
Subject: Re: [PATCH net-next] octeon_ep: add ndo ops for VFs in PF driver
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com, 
	sedara@marvell.com, vimleshk@marvell.com, thaller@redhat.com, 
	wizhao@redhat.com, kheib@redhat.com, egallen@redhat.com, konguyen@redhat.com, 
	horms@kernel.org, frank.feng@synaxg.com, 
	Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000031044906269cf04a"

--00000000000031044906269cf04a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shinas,

On Thu, Nov 7, 2024 at 5:47=E2=80=AFPM Shinas Rasheed <srasheed@marvell.com=
> wrote:
>
> These APIs are needed to support applicaitons that use netlink to get VF
[d] typo in applications
> information from a PF driver.
>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
>  .../ethernet/marvell/octeon_ep/octep_main.c   | 98 +++++++++++++++++++
>  .../ethernet/marvell/octeon_ep/octep_main.h   |  1 +
>  .../marvell/octeon_ep/octep_pfvf_mbox.c       | 22 ++++-
>  .../marvell/octeon_ep/octep_pfvf_mbox.h       |  3 +
>  4 files changed, 122 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/driver=
s/net/ethernet/marvell/octeon_ep/octep_main.c
> index 549436efc204..129c68f5a4ba 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -1137,6 +1137,95 @@ static int octep_set_features(struct net_device *d=
ev, netdev_features_t features
>         return err;
>  }
>
> +static int octep_get_vf_config(struct net_device *dev, int vf, struct if=
la_vf_info *ivi)
> +{
> +       struct octep_device *oct =3D netdev_priv(dev);
> +
> +       ivi->vf =3D vf;
> +       ether_addr_copy(ivi->mac, oct->vf_info[vf].mac_addr);
> +       ivi->vlan =3D 0;
> +       ivi->qos =3D 0;
> +       ivi->spoofchk =3D 0;
> +       ivi->linkstate =3D IFLA_VF_LINK_STATE_ENABLE;
> +       ivi->trusted =3D true;
> +       ivi->max_tx_rate =3D 10000;
> +       ivi->min_tx_rate =3D 0;
> +
> +       return 0;
> +}
> +
> +static int octep_set_vf_mac(struct net_device *dev, int vf, u8 *mac)
> +{
> +       struct octep_device *oct =3D netdev_priv(dev);
> +       int i, err;
> +
> +       if (!is_valid_ether_addr(mac)) {
> +               dev_err(&oct->pdev->dev, "Invalid  MAC Address %pM\n", ma=
c);
> +               return -EADDRNOTAVAIL;
> +       }
> +
> +       dev_dbg(&oct->pdev->dev, "set vf-%d mac to %pM\n", vf, mac);
> +       for (i =3D 0; i < ETH_ALEN; i++)
> +               oct->vf_info[vf].mac_addr[i] =3D mac[i];
[Kalesh] Is there any reason to no do a memcpy here or a ether_addr_copy()?
> +       oct->vf_info[vf].flags |=3D  OCTEON_PFVF_FLAG_MAC_SET_BY_PF;
> +
> +       err =3D octep_ctrl_net_set_mac_addr(oct, vf, mac, true);
> +       if (err) {
> +               dev_err(&oct->pdev->dev, "Set VF%d MAC address failed via=
 host control Mbox\n", vf);
[d] looks like this return is unnecessary. You can "return rc" at the
end of the function.
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int octep_set_vf_vlan(struct net_device *dev, int vf, u16 vlan, u=
8 qos, __be16 vlan_proto)
> +{
> +       struct octep_device *oct =3D netdev_priv(dev);
> +
> +       dev_err(&oct->pdev->dev, "Setting VF VLAN not supported\n");
> +       return 0;
> +}
> +
> +static int octep_set_vf_spoofchk(struct net_device *dev, int vf, bool se=
tting)
> +{
> +       struct octep_device *oct =3D netdev_priv(dev);
> +
> +       dev_err(&oct->pdev->dev, "Setting VF spoof check not supported\n"=
);
> +       return 0;
> +}
> +
> +static int octep_set_vf_trust(struct net_device *dev, int vf, bool setti=
ng)
> +{
> +       struct octep_device *oct =3D netdev_priv(dev);
> +
> +       dev_err(&oct->pdev->dev, "Setting VF trust not supported\n");
> +       return 0;
> +}
> +
> +static int octep_set_vf_rate(struct net_device *dev, int vf, int min_tx_=
rate, int max_tx_rate)
> +{
> +       struct octep_device *oct =3D netdev_priv(dev);
> +
> +       dev_err(&oct->pdev->dev, "Setting VF rate not supported\n");
> +       return 0;
> +}
> +
> +static int octep_set_vf_link_state(struct net_device *dev, int vf, int l=
ink_state)
> +{
> +       struct octep_device *oct =3D netdev_priv(dev);
> +
> +       dev_err(&oct->pdev->dev, "Setting VF link state not supported\n")=
;
> +       return 0;
> +}
> +
> +static int octep_get_vf_stats(struct net_device *dev, int vf, struct ifl=
a_vf_stats *vf_stats)
> +{
> +       struct octep_device *oct =3D netdev_priv(dev);
> +
> +       dev_err(&oct->pdev->dev, "Getting VF stats not supported\n");
> +       return 0;
> +}
[Kalesh] Do not expose the support for these unsupported hooks in
struct net_device_ops. Stack has a check for the support before
invoking the callback.
> +
>  static const struct net_device_ops octep_netdev_ops =3D {
>         .ndo_open                =3D octep_open,
>         .ndo_stop                =3D octep_stop,
> @@ -1146,6 +1235,15 @@ static const struct net_device_ops octep_netdev_op=
s =3D {
>         .ndo_set_mac_address     =3D octep_set_mac,
>         .ndo_change_mtu          =3D octep_change_mtu,
>         .ndo_set_features        =3D octep_set_features,
> +       /* for VFs */
> +       .ndo_get_vf_config       =3D octep_get_vf_config,
> +       .ndo_set_vf_mac          =3D octep_set_vf_mac,
> +       .ndo_set_vf_vlan         =3D octep_set_vf_vlan,
> +       .ndo_set_vf_spoofchk     =3D octep_set_vf_spoofchk,
> +       .ndo_set_vf_trust        =3D octep_set_vf_trust,
> +       .ndo_set_vf_rate         =3D octep_set_vf_rate,
> +       .ndo_set_vf_link_state   =3D octep_set_vf_link_state,
> +       .ndo_get_vf_stats        =3D octep_get_vf_stats,
>  };
>
>  /**
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/driver=
s/net/ethernet/marvell/octeon_ep/octep_main.h
> index fee59e0e0138..3b56916af468 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
> @@ -220,6 +220,7 @@ struct octep_iface_link_info {
>  /* The Octeon VF device specific info data structure.*/
>  struct octep_pfvf_info {
>         u8 mac_addr[ETH_ALEN];
> +       u32 flags;
>         u32 mbox_version;
>  };
>
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/d=
rivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> index e6eb98d70f3c..be21ad5ec75e 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> @@ -156,12 +156,23 @@ static void octep_pfvf_set_mac_addr(struct octep_de=
vice *oct,  u32 vf_id,
>  {
>         int err;
>
> +       if (oct->vf_info[vf_id].flags & OCTEON_PFVF_FLAG_MAC_SET_BY_PF) {
> +               dev_err(&oct->pdev->dev,
> +                       "VF%d attampted to override administrative set MA=
C address\n",
[d] typo in "attempted"
> +                       vf_id);
> +               rsp->s_set_mac.type =3D OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> +               return;
> +       }
> +
>         err =3D octep_ctrl_net_set_mac_addr(oct, vf_id, cmd.s_set_mac.mac=
_addr, true);
>         if (err) {
>                 rsp->s_set_mac.type =3D OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> -               dev_err(&oct->pdev->dev, "Set VF MAC address failed via h=
ost control Mbox\n");
> +               dev_err(&oct->pdev->dev, "Set VF%d MAC address failed via=
 host control Mbox\n",
> +                       vf_id);
>                 return;
>         }
> +
> +       ether_addr_copy(oct->vf_info[vf_id].mac_addr, cmd.s_set_mac.mac_a=
ddr);
>         rsp->s_set_mac.type =3D OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
>  }
>
> @@ -171,10 +182,17 @@ static void octep_pfvf_get_mac_addr(struct octep_de=
vice *oct,  u32 vf_id,
>  {
>         int err;
>
> +       if (oct->vf_info[vf_id].flags & OCTEON_PFVF_FLAG_MAC_SET_BY_PF) {
> +               dev_dbg(&oct->pdev->dev, "VF%d MAC address set by PF\n", =
vf_id);
> +               ether_addr_copy(rsp->s_set_mac.mac_addr, oct->vf_info[vf_=
id].mac_addr);
> +               rsp->s_set_mac.type =3D OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
> +               return;
> +       }
>         err =3D octep_ctrl_net_get_mac_addr(oct, vf_id, rsp->s_set_mac.ma=
c_addr);
>         if (err) {
>                 rsp->s_set_mac.type =3D OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> -               dev_err(&oct->pdev->dev, "Get VF MAC address failed via h=
ost control Mbox\n");
> +               dev_err(&oct->pdev->dev, "Get VF%d MAC address failed via=
 host control Mbox\n",
> +                       vf_id);
>                 return;
>         }
>         rsp->s_set_mac.type =3D OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h b/d=
rivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
> index 0dc6eead292a..339977c7131a 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
> @@ -23,6 +23,9 @@ enum octep_pfvf_mbox_version {
>
>  #define OCTEP_PFVF_MBOX_VERSION_CURRENT        OCTEP_PFVF_MBOX_VERSION_V=
2
>
> +/* VF flags */
> +#define OCTEON_PFVF_FLAG_MAC_SET_BY_PF  BIT_ULL(0) /* PF has set VF MAC =
address */
> +
>  enum octep_pfvf_mbox_opcode {
>         OCTEP_PFVF_MBOX_CMD_VERSION,
>         OCTEP_PFVF_MBOX_CMD_SET_MTU,
> --
> 2.25.1
>
>


--=20
Regards,
Kalesh A P

--00000000000031044906269cf04a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIGWUlJNLx/fF86SgpO2KuJ067nKx/tmCCla12ItdBKARMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTExMTA2MDkwNlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCnDPG9W2Yq
mwTqtK8TSqzJZf8e8OjPGEM1LoH6EGnYG+1T++uiEzCdzxAFn6O3wX+wb/5MZa0DltoqUpgFaiHA
CsK0MB6T6ua6R2IY3k4pHXj/gv5krhkJWqvqs8WE09MKzi3QRX77RJQXBxD4a6tHmWIRR91jCTq5
m1dgpyWcb3T+uj1ZFkbX7E7QQ8kG+v9349DeavSO++a3aya/xl9AApcmRbghktR/fUZngl7e59qN
pMCTB7kpSa750vTCn3/Y9pKihQ2N45gTT0yLOxgS13UzKL5ZYRs6VJIOzW2rmKmKw05ZTULKpGPL
P3D5eDOnmisqrl2wO7tihLK0wQGK
--00000000000031044906269cf04a--

