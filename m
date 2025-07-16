Return-Path: <netdev+bounces-207535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A01B07B28
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F388318861A0
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585061A01BF;
	Wed, 16 Jul 2025 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G4/0+YdK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D681A238C
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752683157; cv=none; b=Xz//TDGQ8v/ndjd8EtsEmauV1gBPbdCIHF4IiLUNp7FR3lqW8or7xEqLGEAj5KfCoG+QTAQInyyhzR4uV4VvHFcO9XmB2PG+2dRSrQesk1Lw9A+SCt+TBpn84+QTI+Deqe084cWwbS9tzfJWqVRXWaQKDqTNmxbt9/MXZ0oYH8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752683157; c=relaxed/simple;
	bh=fUCAaAUcl3fjvpfGRnuWqPaEjtirTBYGuwlRXzRdA1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMF/S6S7YKMaJ/9TsLIj2nn0XEffyC4HhD0Shp3Bj1uXfRRJvYN5zxYvT+XTy2DxCQ5Dz5tTGD1wvMzUC6QjBlpxFRFuLZpI24oV44Qkn7NZbVzKteAtfBGIKDWdxkgY9m4119UKA7fqeG7IeOT6aXjTixbkJnApovy2jAOwL7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G4/0+YdK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qjOzeZCl02wZqsFL8kImKs7arIdC+XCdDUfSQNPYotU=; b=G4/0+YdKKYd13y84VrOTEePrYA
	VAWkv20agae3JTzfHngPenofk6twr6/NQnMiHldJK/uAjbVp5YXzIlmpQd8GLjH1g1TzT0m0KPaSb
	co8LIXNBHFgJf0iBbXKT68ofxQa5mN/BEClLp4iIPLWNLE+T/W6nBvWDee905RexO/fg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uc4wu-001hp6-7I; Wed, 16 Jul 2025 18:25:40 +0200
Date: Wed, 16 Jul 2025 18:25:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
Message-ID: <322af656-d359-44d8-9e40-4f997a8b7e0f@lunn.ch>
References: <20250710112817.85741-1-xuanzhuo@linux.alibaba.com>
 <7b957110-c675-438a-b0c2-ebc161a5d8e7@lunn.ch>
 <1752644852.1458855-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752644852.1458855-1-xuanzhuo@linux.alibaba.com>

On Wed, Jul 16, 2025 at 01:47:32PM +0800, Xuan Zhuo wrote:
> Thank you for your valuable feedback. We've addressed most of the comments
> and will include the fixes in the next version. A few remaining items are still
> under discussion and listed below for reference.
> 
> On Thu, 10 Jul 2025 15:45:38 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
> > > +module_param(aq_timeout, uint, 0644);
> >
> > No module params please.
> >
> > > +struct eea_aq_host_info_cfg {
> > > +#ifndef EEA_OS_DISTRO
> > > +#define EEA_OS_DISTRO		0
> > > +#endif
> > > +
> > > +#ifndef EEA_DRV_TYPE
> > > +#define EEA_DRV_TYPE		0
> > > +#endif
> > > +
> > > +#define EEA_OS_LINUX		1
> > > +#define EEA_SPEC_VER_MAJOR	1
> > > +#define EEA_SPEC_VER_MINOR	0
> > > +	__le16	os_type;        /* Linux, Win.. */
> > > +	__le16	os_dist;
> > > +	__le16	drv_type;
> > > +
> > > +	__le16	kern_ver_major;
> > > +	__le16	kern_ver_minor;
> > > +	__le16	kern_ver_sub_minor;
> > > +
> > > +	__le16	drv_ver_major;
> > > +	__le16	drv_ver_minor;
> > > +	__le16	drv_ver_sub_minor;
> > > +
> > > +	__le16	spec_ver_major;
> > > +	__le16	spec_ver_minor;
> > > +	__le16	pci_bdf;
> > > +	__le32	pci_domain;
> > > +
> > > +	u8      os_ver_str[64];
> > > +	u8      isa_str[64];
> >
> > Why does it care about the OS, kernel version etc?
> 
> Then the device can know the version, the dpu can do something for bug of the
> driver.

That is not a very good explanation. Do you see any other system in
Linux were the firmware works around bug in Linux drivers using the
kernel version?

You also need to think about enterprise kernels, like RedHat,
Oracle. They don't give a truthful kernel version, they have thousands
of patches on top fixing, and creating bugs. How will you handle that?

Please drop all this, and just fix the bugs in the driver.

> > > +	start = get_jiffies_64();
> > > +	while (!(cdesc = ering_cq_get_desc(enet->adminq.ring))) {
> > > +		cond_resched();
> > > +		cpu_relax();
> > > +
> > > +		timeout = secs_to_jiffies(READ_ONCE(aq_timeout));
> > > +		if (time_after64(get_jiffies_64(), start + timeout)) {
> > > +			netdev_err(enet->netdev, "admin queue timeout. timeout %d\n",
> > > +				   READ_ONCE(aq_timeout));
> > > +			return -1;
> > > +		}
> > > +	}
> >
> > See if you can one of the macros from iopoll.h
> 
> Here we do not access the pci register directly, if we use the iopoll.h
> we need to break the api ering_cq_get_desc. So I think we should not use
> the api of iopoll.h here.

#define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
                                sleep_before_read, args...) \
({ \
        u64 __timeout_us = (timeout_us); \
        unsigned long __sleep_us = (sleep_us); \
        ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
        might_sleep_if((__sleep_us) != 0); \
        if (sleep_before_read && __sleep_us) \
                usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
        for (;;) { \
                (val) = op(args); \
                if (cond) \
                        break; \


op: ering_cq_get_desc.
val: cdesc.
args: enet->adminq.ring
cond: !cdesc

I might be wrong, but i think you can make this work.

> > > +static void eea_get_drvinfo(struct net_device *netdev,
> > > +			    struct ethtool_drvinfo *info)
> > > +{
> > > +	struct eea_net *enet = netdev_priv(netdev);
> > > +	struct eea_device *edev = enet->edev;
> > > +
> > > +	strscpy(info->driver,   KBUILD_MODNAME,     sizeof(info->driver));
> > > +	strscpy(info->bus_info, eea_pci_name(edev), sizeof(info->bus_info));
> > > +	snprintf(info->version, sizeof(info->version), "%d.%d.%d",
> > > +		 EEA_VER_MAJOR, EEA_VER_MINOR, EEA_VER_SUB_MINOR);
> >
> > A hard coded version is pointless, because it never changes, yet the
> > kernel around the driver changes every week. Don't set version, and
> > the core will fill in the git hash, which is useful.
> 
> In our plan, we will increase this version when we change the code.

So you will be submitting a patch for GregKH for every single stable
kernel? That will be around 5 patches, every two weeks, for the next
30 years?

As i said, the driver is not standalone, it is embedded within the
kernel. Changes to the kernel can break the driver. When you get a bug
report from a customer, and they say version v42 of the driver is
broken, isn't the first thing you are going to ask is what kernel
version? Is it a vendor kernel? Which vendor?

If you leave version unfilled, ethtool will report something like:

version: 6.12.29-amd64

which is much more useful.

> > > +	mtu = le16_to_cpu(cfg->mtu);
> > > +	if (mtu < netdev->min_mtu) {
> > > +		dev_err(edev->dma_dev, "device MTU too small. %d < %d", mtu, netdev->min_mtu);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	netdev->mtu = mtu;
> > > +	netdev->max_mtu = mtu;
> >
> > Setting mtu the same as max_mtu is unusual? Are you defaulting to jumbo?
> 
> In the cloud the dpu controls this.

No, linux controls this. This driver controls this, using these line
here. Userspace can change it later, but this is the default. And 99%
of Linux systems default to 1500. Is max_mtu 1500? Or is it some jumbo
value? You at last need to add a comment you are ignoring what
everybody else does and are setting the MTU to something larger,
because that is what your use case is.

You are aiming to write an Ethenet driver which looks pretty much like
every other Ethernet driver in Linux. When you do something different,
you need to justify it, add a comment why your device is special and
needs to do something different.

	Andrew

