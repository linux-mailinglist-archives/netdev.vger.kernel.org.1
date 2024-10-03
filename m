Return-Path: <netdev+bounces-131438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3902B98E838
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92A0287FF7
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71E315E86;
	Thu,  3 Oct 2024 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRxSt/Ht"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48D112E7E
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921285; cv=none; b=iWO0Ig8aEpy6m/HZGjNOwBeRutmojtPlji3u+4RW3SRVmhlbs7qSe1MQ5FBn3LSDM5p51VcPq5UeAoWkxT8j4I7SYtfSq/tikkjaj1EopiryDE3sIKotDMQEP4ke+NJ7sc3xlsN0OJOMG4no7XMwGpLsQE4Qxz+CcQZPH0gX/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921285; c=relaxed/simple;
	bh=MRXbDv1NaCdJESKeYB3RYPjBlJ74d5vdelHYfALUsNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruYWj87TAx37xtf8d5j+qnVhK9f6A2AplQBqBTr8reXWxAew7+VeM/CkJheT2SSXNWrIcX1wWg3pugzmS0VbwRwZ6wgU7S6WwmushJslNEOU1TTANJdXuly4v6EbI671B1BGH2xbfIu3UJniZrfZoDUXNgVj5wObj0C0+9JLfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRxSt/Ht; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e0a74ce880so404440a91.2
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 19:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727921283; x=1728526083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFn95vS7Q//bSehLM3fIRXc40YPHD8PD97/q9J+CjhQ=;
        b=KRxSt/HtEaKt/2CKcd+e+64GIA5Y7uswOBiLxxBzVRQkhSVEZtpleqVPdVUtGmcWaU
         AoLZCXefnRI2OuXPtK+BKAvLrUrRQ1CK+U+C7dsz+yW/vj+sPQQiXT54kfMhK3qmU6wc
         xGKnwwYTjB2UxVVvuRGchB5ZwgMSE6lc89MeOPesXgMwr8tNE6GzBIX8OA5ysGqZDvYe
         YtnUjZnEkJDNMBcsf9uMNIZIB7NzR61c96xAD5DJG4CDpt+ol2bUe4Zy3IkAOYDFieAT
         L1W5JkFqXJX4dUs30zsnEdPWnxpUEmvEdizZGvKm5VcPj/rm2pRREfB7KNc3nVuqHjHJ
         IPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921283; x=1728526083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFn95vS7Q//bSehLM3fIRXc40YPHD8PD97/q9J+CjhQ=;
        b=QUFOHt9tItWrMHSsjQWty5xkooVqaMuInjClfXbw+0B4d07uGfVs3/nX6gMFz+/4s0
         /Hh2Nn46TfFBZxZxbMsJJXjavYxJq3jpdTl3YN4C6xLPNhBvDkSx0HyYb1F8ancIYHMr
         bOwIc4+bgkjffpMujfY6BJJrC9z49t+ft9xIZlcFiCQ06rQ60HbzM8HnvXQRGlZI5pxH
         sYs9uDHjj/eCyr5GUwO1/oxDigzGaHIaS71V3IIULbsq6dgTkfrv9cXytssqyOUFQXxF
         xFyN8PeFfzTL6VawJRrIjFq/B2a9KZZmWL4ABY5Hn7F6ivbhIQ96MYIeVyhcfL3K+BQL
         FNXw==
X-Forwarded-Encrypted: i=1; AJvYcCWwezL3qeuOBnHLM13AXBqoXh/FRK8Yuiwr/53TJMc/4kNaUcVDC4hHbTbZMWVT02oTdeXpXyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXlYm4nh3uIdhUGQeFLp8JuVfPUh519gWxKLBG8FTNscAl4mEp
	omHlZ4DRkq5rYF4uzKfIUBsC7fzUOzx2KCap9drSreTUqhfNXhcv1uTRC98udk19fROwACLzgXW
	pnuVpGSbERWA329JHE8iWEyz8Eku7Fdv6opQ9
X-Google-Smtp-Source: AGHT+IHx43AN5kZJguxelc3559dpVF+xXLIG4ELJ+qqVynNs+qc1JbBr0HSo54Wt9hg3oM29Yp+EwC/fcDXVAAb9c/w=
X-Received: by 2002:a17:90a:744a:b0:2d8:eba2:ac6e with SMTP id
 98e67ed59e1d1-2e18490a159mr6295395a91.29.1727921282773; Wed, 02 Oct 2024
 19:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930-phy-handle-fw-devlink-v1-1-4ea46acfcc12@redhat.com>
 <CAGETcx-z+Evd95QzhPePOf3=fZ7QUpWC2spA=q_ASyAfVHJD1A@mail.gmail.com>
 <rqn4kaogp2oukghm3hz7sbbvayj6aiflgbtoyk6mhxg4jss7ig@iv24my4iheij> <hnsjzxd4tgqdrol76qfzpl5fhesz4klqeurdwebflfshfrwpqb@r5iiiihplfgr>
In-Reply-To: <hnsjzxd4tgqdrol76qfzpl5fhesz4klqeurdwebflfshfrwpqb@r5iiiihplfgr>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 2 Oct 2024 19:07:22 -0700
Message-ID: <CAGETcx-FSawzAtQRbJrhc5XtxLDMz0TTVqdGC85YnLjKFsQ7dw@mail.gmail.com>
Subject: Re: [PATCH RFT] of: property: fw_devlink: Add support for the
 "phy-handle" binding
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Rob Herring <robh@kernel.org>, "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Serge Semin <fancer.lancer@gmail.com>, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:34=E2=80=AFPM Andrew Halaney <ahalaney@redhat.com=
> wrote:
>
> On Tue, Oct 01, 2024 at 02:22:23PM GMT, Andrew Halaney wrote:
> > On Mon, Sep 30, 2024 at 05:12:42PM GMT, Saravana Kannan wrote:
> > > On Mon, Sep 30, 2024 at 2:28=E2=80=AFPM Andrew Halaney <ahalaney@redh=
at.com> wrote:
> > > >
> > > > Add support for parsing the phy-handle binding so that fw_devlink c=
an
> > > > enforce the dependency. This prevents MACs (that use this binding t=
o
> > > > claim they're using the corresponding phy) from probing prior to th=
e
> > > > phy, unless the phy is a child of the MAC (which results in a
> > > > dependency cycle) or similar.
> > > >
> > > > For some motivation, imagine a device topology like so:
> > > >
> > > >     &ethernet0 {
> > > >             phy-mode =3D "sgmii";
> > > >             phy-handle =3D <&sgmii_phy0>;
> > > >
> > > >             mdio {
> > > >                     compatible =3D "snps,dwmac-mdio";
> > > >                     sgmii_phy0: phy@8 {
> > > >                             compatible =3D "ethernet-phy-id0141.0dd=
4";
> > > >                             reg =3D <0x8>;
> > > >                             device_type =3D "ethernet-phy";
> > > >                     };
> > > >
> > > >                     sgmii_phy1: phy@a {
> > > >                             compatible =3D "ethernet-phy-id0141.0dd=
4";
> > > >                             reg =3D <0xa>;
> > > >                             device_type =3D "ethernet-phy";
> > > >                     };
> > > >             };
> > > >     };
> > > >
> > > >     &ethernet1 {
> > > >             phy-mode =3D "sgmii";
> > > >             phy-handle =3D <&sgmii_phy1>;
> > > >     };
> > > >
> > > > Here ethernet1 depends on sgmii_phy1 to function properly. In the b=
elow
> > > > link an issue is reported where ethernet1 is probed and used prior =
to
> > > > sgmii_phy1, resulting in a failure to get things working for ethern=
et1.
> > > > With this change in place ethernet1 doesn't probe until sgmii_phy1 =
is
> > > > ready, resulting in ethernet1 functioning properly.
> > > >
> > > > ethernet0 consumes sgmii_phy0, but this dependency isn't enforced
> > > > via the device_links backing fw_devlink since ethernet0 is the pare=
nt of
> > > > sgmii_phy0. Here's a log showing that in action:
> > > >
> > > >     [    7.000432] qcom-ethqos 23040000.ethernet: Fixed dependency =
cycle(s) with /soc@0/ethernet@23040000/mdio/phy@8
> > > >
> > > > With this change in place ethernet1's dependency is properly descri=
bed,
> > > > and it doesn't probe prior to sgmii_phy1 being available.
> > > >
> > > > Link: https://lore.kernel.org/netdev/7723d4l2kqgrez3yfauvp2ueu6awbi=
zkrq4otqpsqpytzp45q2@rju2nxmqu4ew/
> > > > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > > ---
> > > > I've marked this as an RFT because when looking through old mailing
> > > > list discusssions and kernel tech talks on this subject, I was unab=
le
> > > > to really understand why in the past phy-handle had been left out. =
There
> > > > were some loose references to circular dependencies (which seem mor=
e or
> > > > less handled by fw_devlink to me), and the fact that a lot of behav=
ior
> > > > happens in ndo_open() (but I couldn't quite grok the concern there)=
.
> > > >
> > > > I'd appreciate more testing by others and some feedback from those =
who
> > > > know this a bit better to indicate whether fw_devlink is ready to h=
andle
> > > > this or not.
> > > >
> > > > At least in my narrow point of view, it's working well for me.
> > >
> > > I do want this to land and I'm fairly certain it'll break something.
> > > But it's been so long that I don't remember what it was. I think it
> > > has to do with the generic phy driver not working well with fw_devlin=
k
> > > because it doesn't go through the device driver model.
> >
> > Let me see if I can hack something up on this board (which has a decent
> > dependency tree for testing this stuff) to use the generic phy driver
> > instead of the marvell one that it needs and see how that goes. It won'=
t
> > *actually* work from a phy perspective, but it will at least test out
> > the driver core bits here I think.
> >
> > >
> > > But like you said, it's been a while and fw_devlink has improved sinc=
e
> > > then (I think). So please go ahead and give this a shot. If you can
> > > help fix any issues this highlights, I'd really appreciate it and I'd
> > > be happy to guide you through what I think needs to happen. But I
> > > don't think I have the time to fix it myself.
> >
> > Sure, I tend to agree. Let me check the generic phy driver path for any
> > issues and if that test seems to go okay I too am of the opinion that
> > without any solid reasoning against this we enable it and battle throug=
h
> > (revert and fix after the fact if necessary) any newly identified issue=
s
> > that prevent phy-handle and fw_devlink have with each other.
> >
>
> Hmmm, yes the generic phy driver path for this
> doesn't seem to work well. Its fine and dandy if there's
> no device_link (current situation), but if there is one
> (say with my patch and in my example above between ethernet1 and phy@a,
> you can ignore the ethernet0 relationship since its a cycle
> and therefore no device_link is created as mentioned in the patch)
> you run into problems with the generic phy driver.
>
> In my original test you can see I use the marvell driver
> for the phy. In that case things work well. In the generic phy
> case however, ethernet1's probe is actually delayed far past
> phy@a. Here's some logs that show that the device_link getting
> "relaxed" due to no driver being bound, which has fw_devlink
> thinking this supplier phy isn't going to get a driver ever,
> so it finally tries to unblock (probe) the consumer (ethernet1):
>
>     [   40.695570] platform 23000000.ethernet: Relaxing link with stmmac-=
0:0a
>     [   40.702274] CPU: 4 UID: 0 PID: 111 Comm: kworker/u34:1 Not tainted=
 6.12.0-rc1-next-20240930-00004-gb766c5527800-dirty #155
>     [   40.713605] Hardware name: Qualcomm SA8775P Ride (DT)
>     [   40.718789] Workqueue: events_unbound deferred_probe_work_func
>     [   40.724774] Call trace:
>     [   40.727295]  dump_backtrace+0x108/0x190
>     [   40.731233]  show_stack+0x24/0x38
>     [   40.734638]  dump_stack_lvl+0x40/0x88
>     [   40.738406]  dump_stack+0x18/0x28
>     [   40.741811]  fw_devlink_unblock_consumers+0x78/0xe8
>     [   40.746824]  device_add+0x290/0x3f8
>     [   40.750411]  phy_device_register+0x6c/0xd0
>     [   40.754615]  fwnode_mdiobus_phy_device_register+0xe8/0x178
>     [   40.760246]  fwnode_mdiobus_register_phy+0x214/0x268
>     [   40.765344]  __of_mdiobus_parse_phys+0x80/0x280
>     [   40.769995]  __of_mdiobus_register+0xd0/0x230
>     [   40.774465]  stmmac_mdio_register+0x220/0x3c8 [stmmac]
>     [   40.779755]  stmmac_dvr_probe+0x91c/0xd70 [stmmac]
>     [   40.784682]  devm_stmmac_pltfr_probe+0x54/0xe0 [stmmac_platform]
>     [   40.790846]  qcom_ethqos_probe+0x404/0x438 [dwmac_qcom_ethqos]
>     [   40.796830]  platform_probe+0x94/0xd8
>
> If I understand correctly that's because the generic phy driver
> is bound during a MAC's (like ethernet1 here) phylink_fwnode_phy_connect(=
) call
> in ndo_open() currently.. here's another dump_stack() (yes I abuse that a=
lot)
> showing when that happens:
>
>     [   42.980611] net end1: Before phylink_fwnode_phy_connect
>     [   42.986011] CPU: 4 UID: 0 PID: 310 Comm: NetworkManager Not tainte=
d 6.12.0-rc1-next-20240930-00004-gb766c5527800-dirty #156
>     [   42.997436] Hardware name: Qualcomm SA8775P Ride (DT)
>     [   43.002632] Call trace:
>     [   43.005152]  dump_backtrace+0x108/0x190
>     [   43.009106]  show_stack+0x24/0x38
>     [   43.012518]  dump_stack_lvl+0x40/0x88
>     [   43.016290]  dump_stack+0x18/0x28
>     [   43.019701]  phy_attach_direct+0x2d4/0x3e0
>     [   43.023918]  phylink_fwnode_phy_connect+0xc4/0x178
>     [   43.028848]  __stmmac_open+0x698/0x6e0 [stmmac]
>     [   43.033534]  stmmac_open+0x54/0xe0 [stmmac]
>     [   43.037850]  __dev_open+0x110/0x228
>     [   43.041442]  __dev_change_flags+0xbc/0x1d0
>
>
> And here's the code for the binding of the generic phy driver:
>
>     /**
>      * phy_attach_direct - attach a network device to a given PHY device =
pointer
>      * @dev: network device to attach
>      * @phydev: Pointer to phy_device to attach
>      * @flags: PHY device's dev_flags
>      * @interface: PHY device's interface
>      *
>      * Description: Called by drivers to attach to a particular PHY
>      *     device. The phy_device is found, and properly hooked up
>      *     to the phy_driver.  If no driver is attached, then a
>      *     generic driver is used.  The phy_device is given a ptr to
>      *     the attaching device, and given a callback for link status
>      *     change.  The phy_device is returned to the attaching driver.
>      *     This function takes a reference on the phy device.
>      */
>     int phy_attach_direct(struct net_device *dev, struct phy_device *phyd=
ev,
>                           u32 flags, phy_interface_t interface)
>     {
>             struct mii_bus *bus =3D phydev->mdio.bus;
>             struct device *d =3D &phydev->mdio.dev;
>             struct module *ndev_owner =3D NULL;
>             bool using_genphy =3D false;
>             int err;
>
>             /* For Ethernet device drivers that register their own MDIO b=
us, we
>              * will have bus->owner match ndev_mod, so we do not want to =
increment
>              * our own module->refcnt here, otherwise we would not be abl=
e to
>              * unload later on.
>              */
>             if (dev)
>                     ndev_owner =3D dev->dev.parent->driver->owner;
>             if (ndev_owner !=3D bus->owner && !try_module_get(bus->owner)=
) {
>                     phydev_err(phydev, "failed to get the bus module\n");
>                     return -EIO;
>             }
>
>             get_device(d);
>
>             /* Assume that if there is no driver, that it doesn't
>              * exist, and we should use the genphy driver.
>              */
>             if (!d->driver) {
>                     if (phydev->is_c45)
>                             d->driver =3D &genphy_c45_driver.mdiodrv.driv=
er;
>                     else
>                             d->driver =3D &genphy_driver.mdiodrv.driver;
>
>                     using_genphy =3D true;
>                     dump_stack();
>             }
>
>             if (!try_module_get(d->driver->owner)) {
>                     phydev_err(phydev, "failed to get the device driver m=
odule\n");
>                     err =3D -EIO;
>                     goto error_put_device;
>             }
>
>             if (using_genphy) {
>                     err =3D d->driver->probe(d);
>                     if (err >=3D 0)
>                             err =3D device_bind_driver(d);
>
>                     if (err)
>                             goto error_module_put;
>             }
>
>             ...
>     }
>
> Something will need to be done for the generic phy driver case before
> this patch could be considered acceptable as this would slow the boot tim=
e
> for the topology I described in the patch description if the generic phy
> driver was used.

Right. And the way to do that is to move the generic phy driver
matching to go through the normal probe model instead of doing a
direct driver attach or directly calling the probe function. It's
possible and I had a mental model a while ago, but didn't have the
time to get around to it. Basically, if we find that none of the
drivers match, we need to trigger something like -EPROBE_DEFER again
and then match it with the generic phy driver. Or figure out some
other way for the generic phy driver to NOT match if a better driver
is available. Once we do that, I think the rest should be easy to fix.

Let me know if there's anything I can do to help you move this forward.

-Saravana

