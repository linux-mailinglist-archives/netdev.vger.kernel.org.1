Return-Path: <netdev+bounces-131348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4264D98E386
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7765B241D7
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 19:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF00216A0A;
	Wed,  2 Oct 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGAY5k1y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3C216A07
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897674; cv=none; b=jLyCdozw/9S0GexUqkgC8LlHvJgtaqkfWiY4te95OyBSStpOtbD1LbaD3hE6pXmdTc5isnMTPDl9e1Lgygh4EAy2d862U75CFnz/8Kxwdb1rDeWRxbdd9C4XceFInYbbkpJ1gip0WVpeF0JMjGqHCp6ffb79ImoMJIfJlqgmCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897674; c=relaxed/simple;
	bh=2+vEyTgqFwkWvfvYGoa8abT80T+sgTrAdgCfin2DnyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqiCBtV6zv3ZNEdNwtkE6K13D/GpVH3C9yucyisPP4+GsBymyKadSmBAeeWd7K/dfdnJeJCx1ids4gIugNm/Howkc+N3DF3917SFhyxkH6nSgec2dye5ICJnGfEom5jPvS8wVGrC60sZ1UufsiwZBUky7/aktJ4sPdxjvDanJY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LGAY5k1y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727897670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ec1NxEf4cUD1tlgHleEFcFBP8GH2hEq9TibQIYmFEg=;
	b=LGAY5k1yyhpxUqHYptx07lMsnB5w+a5mRd08SMWfAOK4Uurjc7EUy9sdflv4I9dDbcAoTi
	cPutzyxdrySfr1anlKsr7D6lYT+VLnikasR16QzO93KLJ4czOyFKFLcl3X5I/CYKn8Jiak
	mvG1VmRQFey9IlrpOjFhWXAEFjVzR0w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-ELt6whuOMvqimA5HKurmDg-1; Wed, 02 Oct 2024 15:34:29 -0400
X-MC-Unique: ELt6whuOMvqimA5HKurmDg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6c58e9bf10bso3166756d6.3
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 12:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727897669; x=1728502469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ec1NxEf4cUD1tlgHleEFcFBP8GH2hEq9TibQIYmFEg=;
        b=E/u6FlRLDnnhOF3RAEru7Au1xPiN384xlnYo/uoSE4EWUHiV9uf7oBOo2X7NgFj3e7
         7eArgNhuwyt0OV87svmsSXWds/3KAeGLLtuEok/T9SahBOBkl5GUy02I2FAerTaoTHjC
         m3g6EVjnFYYh0Coqatg455XLVRxZQ7GTuvDTWHpticspwoi7H0mpc7vVRyxYHbq/91QO
         x4U6HdSfWa9dG+sUmP6wK0r19zZfoUdUOALDyI3e4fqS5hMru8x3ImFC4JEfWVQkgpuF
         gj6XSfyuhGS3K+s3LdLoK5FAzksw7VdA6gj2+KXu47ml9fWSuG4meG96WBYQtHXH06Qe
         PaqA==
X-Forwarded-Encrypted: i=1; AJvYcCU3UdiHiVZeB/YvvUvnkaqzM6pYCRKgJjlvBGRDBJsZyMonImJhMF+P6xU8Ls0Xth0qGbrEiEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZyikoZwGDsmSXQgThs2ESqjFwsC1V98QMuai784CipEXHp18+
	dXbxCVbWztxTkDI1pR2/f2qF604rh/Ffro9E6VVxUUPY2Rzmjwv5VOz+83sN9vhhlT78fJPIOgp
	6TMSNaZFkVytvCxoYkV/dvUeUS77E++js9wkUFTr48Mc1esG8CpMzIg==
X-Received: by 2002:a05:6214:4604:b0:6cb:4a84:e02a with SMTP id 6a1803df08f44-6cb819dda70mr70688336d6.16.1727897668617;
        Wed, 02 Oct 2024 12:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJB6uBn4n+neMl08RDBU9++wfZdEzfnVhcS1bJM/L1t5Y3dEm5XFXOMjVQwS4a57zuVS8Oqg==
X-Received: by 2002:a05:6214:4604:b0:6cb:4a84:e02a with SMTP id 6a1803df08f44-6cb819dda70mr70688096d6.16.1727897668239;
        Wed, 02 Oct 2024 12:34:28 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b62d520sm63718966d6.67.2024.10.02.12.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 12:34:27 -0700 (PDT)
Date: Wed, 2 Oct 2024 14:34:25 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh@kernel.org>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Serge Semin <fancer.lancer@gmail.com>, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] of: property: fw_devlink: Add support for the
 "phy-handle" binding
Message-ID: <hnsjzxd4tgqdrol76qfzpl5fhesz4klqeurdwebflfshfrwpqb@r5iiiihplfgr>
References: <20240930-phy-handle-fw-devlink-v1-1-4ea46acfcc12@redhat.com>
 <CAGETcx-z+Evd95QzhPePOf3=fZ7QUpWC2spA=q_ASyAfVHJD1A@mail.gmail.com>
 <rqn4kaogp2oukghm3hz7sbbvayj6aiflgbtoyk6mhxg4jss7ig@iv24my4iheij>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rqn4kaogp2oukghm3hz7sbbvayj6aiflgbtoyk6mhxg4jss7ig@iv24my4iheij>

On Tue, Oct 01, 2024 at 02:22:23PM GMT, Andrew Halaney wrote:
> On Mon, Sep 30, 2024 at 05:12:42PM GMT, Saravana Kannan wrote:
> > On Mon, Sep 30, 2024 at 2:28 PM Andrew Halaney <ahalaney@redhat.com> wrote:
> > >
> > > Add support for parsing the phy-handle binding so that fw_devlink can
> > > enforce the dependency. This prevents MACs (that use this binding to
> > > claim they're using the corresponding phy) from probing prior to the
> > > phy, unless the phy is a child of the MAC (which results in a
> > > dependency cycle) or similar.
> > >
> > > For some motivation, imagine a device topology like so:
> > >
> > >     &ethernet0 {
> > >             phy-mode = "sgmii";
> > >             phy-handle = <&sgmii_phy0>;
> > >
> > >             mdio {
> > >                     compatible = "snps,dwmac-mdio";
> > >                     sgmii_phy0: phy@8 {
> > >                             compatible = "ethernet-phy-id0141.0dd4";
> > >                             reg = <0x8>;
> > >                             device_type = "ethernet-phy";
> > >                     };
> > >
> > >                     sgmii_phy1: phy@a {
> > >                             compatible = "ethernet-phy-id0141.0dd4";
> > >                             reg = <0xa>;
> > >                             device_type = "ethernet-phy";
> > >                     };
> > >             };
> > >     };
> > >
> > >     &ethernet1 {
> > >             phy-mode = "sgmii";
> > >             phy-handle = <&sgmii_phy1>;
> > >     };
> > >
> > > Here ethernet1 depends on sgmii_phy1 to function properly. In the below
> > > link an issue is reported where ethernet1 is probed and used prior to
> > > sgmii_phy1, resulting in a failure to get things working for ethernet1.
> > > With this change in place ethernet1 doesn't probe until sgmii_phy1 is
> > > ready, resulting in ethernet1 functioning properly.
> > >
> > > ethernet0 consumes sgmii_phy0, but this dependency isn't enforced
> > > via the device_links backing fw_devlink since ethernet0 is the parent of
> > > sgmii_phy0. Here's a log showing that in action:
> > >
> > >     [    7.000432] qcom-ethqos 23040000.ethernet: Fixed dependency cycle(s) with /soc@0/ethernet@23040000/mdio/phy@8
> > >
> > > With this change in place ethernet1's dependency is properly described,
> > > and it doesn't probe prior to sgmii_phy1 being available.
> > >
> > > Link: https://lore.kernel.org/netdev/7723d4l2kqgrez3yfauvp2ueu6awbizkrq4otqpsqpytzp45q2@rju2nxmqu4ew/
> > > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > ---
> > > I've marked this as an RFT because when looking through old mailing
> > > list discusssions and kernel tech talks on this subject, I was unable
> > > to really understand why in the past phy-handle had been left out. There
> > > were some loose references to circular dependencies (which seem more or
> > > less handled by fw_devlink to me), and the fact that a lot of behavior
> > > happens in ndo_open() (but I couldn't quite grok the concern there).
> > >
> > > I'd appreciate more testing by others and some feedback from those who
> > > know this a bit better to indicate whether fw_devlink is ready to handle
> > > this or not.
> > >
> > > At least in my narrow point of view, it's working well for me.
> > 
> > I do want this to land and I'm fairly certain it'll break something.
> > But it's been so long that I don't remember what it was. I think it
> > has to do with the generic phy driver not working well with fw_devlink
> > because it doesn't go through the device driver model.
> 
> Let me see if I can hack something up on this board (which has a decent
> dependency tree for testing this stuff) to use the generic phy driver
> instead of the marvell one that it needs and see how that goes. It won't
> *actually* work from a phy perspective, but it will at least test out
> the driver core bits here I think.
> 
> > 
> > But like you said, it's been a while and fw_devlink has improved since
> > then (I think). So please go ahead and give this a shot. If you can
> > help fix any issues this highlights, I'd really appreciate it and I'd
> > be happy to guide you through what I think needs to happen. But I
> > don't think I have the time to fix it myself.
> 
> Sure, I tend to agree. Let me check the generic phy driver path for any
> issues and if that test seems to go okay I too am of the opinion that
> without any solid reasoning against this we enable it and battle through
> (revert and fix after the fact if necessary) any newly identified issues
> that prevent phy-handle and fw_devlink have with each other.
> 

Hmmm, yes the generic phy driver path for this
doesn't seem to work well. Its fine and dandy if there's
no device_link (current situation), but if there is one
(say with my patch and in my example above between ethernet1 and phy@a,
you can ignore the ethernet0 relationship since its a cycle
and therefore no device_link is created as mentioned in the patch)
you run into problems with the generic phy driver.

In my original test you can see I use the marvell driver
for the phy. In that case things work well. In the generic phy
case however, ethernet1's probe is actually delayed far past
phy@a. Here's some logs that show that the device_link getting
"relaxed" due to no driver being bound, which has fw_devlink
thinking this supplier phy isn't going to get a driver ever,
so it finally tries to unblock (probe) the consumer (ethernet1):

    [   40.695570] platform 23000000.ethernet: Relaxing link with stmmac-0:0a
    [   40.702274] CPU: 4 UID: 0 PID: 111 Comm: kworker/u34:1 Not tainted 6.12.0-rc1-next-20240930-00004-gb766c5527800-dirty #155
    [   40.713605] Hardware name: Qualcomm SA8775P Ride (DT)
    [   40.718789] Workqueue: events_unbound deferred_probe_work_func
    [   40.724774] Call trace:
    [   40.727295]  dump_backtrace+0x108/0x190
    [   40.731233]  show_stack+0x24/0x38
    [   40.734638]  dump_stack_lvl+0x40/0x88
    [   40.738406]  dump_stack+0x18/0x28
    [   40.741811]  fw_devlink_unblock_consumers+0x78/0xe8
    [   40.746824]  device_add+0x290/0x3f8
    [   40.750411]  phy_device_register+0x6c/0xd0
    [   40.754615]  fwnode_mdiobus_phy_device_register+0xe8/0x178
    [   40.760246]  fwnode_mdiobus_register_phy+0x214/0x268
    [   40.765344]  __of_mdiobus_parse_phys+0x80/0x280
    [   40.769995]  __of_mdiobus_register+0xd0/0x230
    [   40.774465]  stmmac_mdio_register+0x220/0x3c8 [stmmac]
    [   40.779755]  stmmac_dvr_probe+0x91c/0xd70 [stmmac]
    [   40.784682]  devm_stmmac_pltfr_probe+0x54/0xe0 [stmmac_platform]
    [   40.790846]  qcom_ethqos_probe+0x404/0x438 [dwmac_qcom_ethqos]
    [   40.796830]  platform_probe+0x94/0xd8

If I understand correctly that's because the generic phy driver
is bound during a MAC's (like ethernet1 here) phylink_fwnode_phy_connect() call
in ndo_open() currently.. here's another dump_stack() (yes I abuse that alot)
showing when that happens:

    [   42.980611] net end1: Before phylink_fwnode_phy_connect
    [   42.986011] CPU: 4 UID: 0 PID: 310 Comm: NetworkManager Not tainted 6.12.0-rc1-next-20240930-00004-gb766c5527800-dirty #156
    [   42.997436] Hardware name: Qualcomm SA8775P Ride (DT)
    [   43.002632] Call trace:
    [   43.005152]  dump_backtrace+0x108/0x190
    [   43.009106]  show_stack+0x24/0x38
    [   43.012518]  dump_stack_lvl+0x40/0x88
    [   43.016290]  dump_stack+0x18/0x28
    [   43.019701]  phy_attach_direct+0x2d4/0x3e0
    [   43.023918]  phylink_fwnode_phy_connect+0xc4/0x178
    [   43.028848]  __stmmac_open+0x698/0x6e0 [stmmac]
    [   43.033534]  stmmac_open+0x54/0xe0 [stmmac]
    [   43.037850]  __dev_open+0x110/0x228
    [   43.041442]  __dev_change_flags+0xbc/0x1d0


And here's the code for the binding of the generic phy driver:

    /**
     * phy_attach_direct - attach a network device to a given PHY device pointer
     * @dev: network device to attach
     * @phydev: Pointer to phy_device to attach
     * @flags: PHY device's dev_flags
     * @interface: PHY device's interface
     *
     * Description: Called by drivers to attach to a particular PHY
     *     device. The phy_device is found, and properly hooked up
     *     to the phy_driver.  If no driver is attached, then a
     *     generic driver is used.  The phy_device is given a ptr to
     *     the attaching device, and given a callback for link status
     *     change.  The phy_device is returned to the attaching driver.
     *     This function takes a reference on the phy device.
     */
    int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
                          u32 flags, phy_interface_t interface)
    {
            struct mii_bus *bus = phydev->mdio.bus;
            struct device *d = &phydev->mdio.dev;
            struct module *ndev_owner = NULL;
            bool using_genphy = false;
            int err;

            /* For Ethernet device drivers that register their own MDIO bus, we
             * will have bus->owner match ndev_mod, so we do not want to increment
             * our own module->refcnt here, otherwise we would not be able to
             * unload later on.
             */
            if (dev)
                    ndev_owner = dev->dev.parent->driver->owner;
            if (ndev_owner != bus->owner && !try_module_get(bus->owner)) {
                    phydev_err(phydev, "failed to get the bus module\n");
                    return -EIO;
            }

            get_device(d);

            /* Assume that if there is no driver, that it doesn't
             * exist, and we should use the genphy driver.
             */
            if (!d->driver) {
                    if (phydev->is_c45)
                            d->driver = &genphy_c45_driver.mdiodrv.driver;
                    else
                            d->driver = &genphy_driver.mdiodrv.driver;

                    using_genphy = true;
                    dump_stack();
            }

            if (!try_module_get(d->driver->owner)) {
                    phydev_err(phydev, "failed to get the device driver module\n");
                    err = -EIO;
                    goto error_put_device;
            }

            if (using_genphy) {
                    err = d->driver->probe(d);
                    if (err >= 0)
                            err = device_bind_driver(d);

                    if (err)
                            goto error_module_put;
            }

            ...
    }

Something will need to be done for the generic phy driver case before
this patch could be considered acceptable as this would slow the boot time
for the topology I described in the patch description if the generic phy
driver was used.


