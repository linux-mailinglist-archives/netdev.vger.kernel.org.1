Return-Path: <netdev+bounces-207702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DF0B0855A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 08:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8644517F9FD
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 06:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A0F21A421;
	Thu, 17 Jul 2025 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HjPg/0PI"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05301EE7B9
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734888; cv=none; b=EOVmk6pUpIVE5VQDMpI2iwYZlwfRSdoEb8wFxtxdRYUFFd4St7JGgoGMCWatm907w6uKK5RPpYYJkAX2VdHxUZoEMgo81BLzVjRYac/fwSllYTeH/e++AnExqdFYclWK9v7TfoLBEFfMogCtDMovxu2e9/ikskQCthsgHAFRslk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734888; c=relaxed/simple;
	bh=k3IOfqIHR0LNmbzW492JUqxcw7yfnJcbs15cVeL+ZfM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=eD8DbOeh53u0+jkXEIfr00T1j4cKK2w4exdNh4j4GPj+ESTgBn3Q/8saJO/whQ3Std0VmajMO5sHPmgX+oAHPfcS8sYH76uhk9MhAWZKLj6SAj4FEQABM7GeSfWbHlsr5z+Ww2dkk+KldupMQOHM5cyBGOojRLtEdkdfYaAz0PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HjPg/0PI; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752734883; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=mPaod5drLelf/0HvjwlrijNY1NSEwpTKbNA/WUD4u74=;
	b=HjPg/0PI0MuiVW+eCJQzUVLg5MRpgpLIN3XEjeK5Z3ciZ6jr6ojGPSwsdl+hYbfQjWEn8rwW47Zb9lhHUYNHCDQnMylFE7AuPssmIYcM3UQLYfVK7bjznuPa/2MKpoJYi5TvVvCRdm9yfXPa5pTcuKDStxndwCQdOPjvDlqn384=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wj75G.w_1752734881 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 14:48:02 +0800
Message-ID: <1752733075.7055798-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Thu, 17 Jul 2025 14:17:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20250710112817.85741-1-xuanzhuo@linux.alibaba.com>
 <7b957110-c675-438a-b0c2-ebc161a5d8e7@lunn.ch>
 <1752644852.1458855-1-xuanzhuo@linux.alibaba.com>
 <322af656-d359-44d8-9e40-4f997a8b7e0f@lunn.ch>
In-Reply-To: <322af656-d359-44d8-9e40-4f997a8b7e0f@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 16 Jul 2025 18:25:40 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Jul 16, 2025 at 01:47:32PM +0800, Xuan Zhuo wrote:
> > Thank you for your valuable feedback. We've addressed most of the comme=
nts
> > and will include the fixes in the next version. A few remaining items a=
re still
> > under discussion and listed below for reference.
> >
> > On Thu, 10 Jul 2025 15:45:38 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
> > > > +module_param(aq_timeout, uint, 0644);
> > >
> > > No module params please.
> > >
> > > > +struct eea_aq_host_info_cfg {
> > > > +#ifndef EEA_OS_DISTRO
> > > > +#define EEA_OS_DISTRO		0
> > > > +#endif
> > > > +
> > > > +#ifndef EEA_DRV_TYPE
> > > > +#define EEA_DRV_TYPE		0
> > > > +#endif
> > > > +
> > > > +#define EEA_OS_LINUX		1
> > > > +#define EEA_SPEC_VER_MAJOR	1
> > > > +#define EEA_SPEC_VER_MINOR	0
> > > > +	__le16	os_type;        /* Linux, Win.. */
> > > > +	__le16	os_dist;
> > > > +	__le16	drv_type;
> > > > +
> > > > +	__le16	kern_ver_major;
> > > > +	__le16	kern_ver_minor;
> > > > +	__le16	kern_ver_sub_minor;
> > > > +
> > > > +	__le16	drv_ver_major;
> > > > +	__le16	drv_ver_minor;
> > > > +	__le16	drv_ver_sub_minor;
> > > > +
> > > > +	__le16	spec_ver_major;
> > > > +	__le16	spec_ver_minor;
> > > > +	__le16	pci_bdf;
> > > > +	__le32	pci_domain;
> > > > +
> > > > +	u8      os_ver_str[64];
> > > > +	u8      isa_str[64];
> > >
> > > Why does it care about the OS, kernel version etc?
> >
> > Then the device can know the version, the dpu can do something for bug =
of the
> > driver.
>
> That is not a very good explanation. Do you see any other system in
> Linux were the firmware works around bug in Linux drivers using the
> kernel version?

Actually, there is one, we noticed that the ena driver has a similar mechan=
ism.

	struct ena_admin_host_info

>
> You also need to think about enterprise kernels, like RedHat,
> Oracle. They don't give a truthful kernel version, they have thousands
> of patches on top fixing, and creating bugs. How will you handle that?
>
> Please drop all this, and just fix the bugs in the driver.


Fixing bugs in Linux is, of course, the necessary work. However, if certain=
 bugs
already exist and customers are using such drivers, there is a risk involve=
d. We
can record these buggy versions in the DPU, and notify users via dmesg when=
 they
initialize the driver. This way, customers will be aware that the current
version might have issues, and they can be guided to upgrade their kernel.

Version-related issues are indeed quite tricky, and we do encounter various
complications because of them. Therefore, our plan is to manually update our
version tracking with every code change, combined with some additional
information.

In the end, if we cannot confidently determine the situation, we will simply
choose to do nothing =E2=80=94 after all, it won't make things any worse th=
an they
already are.

>
> > > > +	start =3D get_jiffies_64();
> > > > +	while (!(cdesc =3D ering_cq_get_desc(enet->adminq.ring))) {
> > > > +		cond_resched();
> > > > +		cpu_relax();
> > > > +
> > > > +		timeout =3D secs_to_jiffies(READ_ONCE(aq_timeout));
> > > > +		if (time_after64(get_jiffies_64(), start + timeout)) {
> > > > +			netdev_err(enet->netdev, "admin queue timeout. timeout %d\n",
> > > > +				   READ_ONCE(aq_timeout));
> > > > +			return -1;
> > > > +		}
> > > > +	}
> > >
> > > See if you can one of the macros from iopoll.h
> >
> > Here we do not access the pci register directly, if we use the iopoll.h
> > we need to break the api ering_cq_get_desc. So I think we should not use
> > the api of iopoll.h here.
>
> #define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
>                                 sleep_before_read, args...) \
> ({ \
>         u64 __timeout_us =3D (timeout_us); \
>         unsigned long __sleep_us =3D (sleep_us); \
>         ktime_t __timeout =3D ktime_add_us(ktime_get(), __timeout_us); \
>         might_sleep_if((__sleep_us) !=3D 0); \
>         if (sleep_before_read && __sleep_us) \
>                 usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
>         for (;;) { \
>                 (val) =3D op(args); \
>                 if (cond) \
>                         break; \
>
>
> op: ering_cq_get_desc.
> val: cdesc.
> args: enet->adminq.ring
> cond: !cdesc
>
> I might be wrong, but i think you can make this work.


Ohhh, You're right. I hadn't thought through this issue in detail before, a=
nd
yes, doing it this way is indeed feasible. During testing in certain scenar=
ios
=E2=80=94 especially in model environments =E2=80=94 the execution speed ca=
n be quite slow, so
we sometimes set a larger timeout value to accommodate that.

However, once we've identified the problem, we would prefer for the operati=
on to
time out and exit, so that we can reload the new .ko module. In this proces=
s, we
may adjust the module parameters to reduce the originally large timeout val=
ue,
forcing it to exit faster. This use case is actually very helpful during our
development process and significantly improves our efficiency.

That's why you see me using READ_ONCE() when comparing each timeout value =
=E2=80=94 to
ensure we always read the latest updated value.


>
> > > > +static void eea_get_drvinfo(struct net_device *netdev,
> > > > +			    struct ethtool_drvinfo *info)
> > > > +{
> > > > +	struct eea_net *enet =3D netdev_priv(netdev);
> > > > +	struct eea_device *edev =3D enet->edev;
> > > > +
> > > > +	strscpy(info->driver,   KBUILD_MODNAME,     sizeof(info->driver));
> > > > +	strscpy(info->bus_info, eea_pci_name(edev), sizeof(info->bus_info=
));
> > > > +	snprintf(info->version, sizeof(info->version), "%d.%d.%d",
> > > > +		 EEA_VER_MAJOR, EEA_VER_MINOR, EEA_VER_SUB_MINOR);
> > >
> > > A hard coded version is pointless, because it never changes, yet the
> > > kernel around the driver changes every week. Don't set version, and
> > > the core will fill in the git hash, which is useful.
> >
> > In our plan, we will increase this version when we change the code.
>
> So you will be submitting a patch for GregKH for every single stable
> kernel? That will be around 5 patches, every two weeks, for the next
> 30 years?

Of course we won't be doing that. Our plan is that whenever we update the c=
ode
=E2=80=94 for example, fixing a bug and updating the version from 1.0.0 to =
1.0.1, or
introducing a new feature and bumping the version to 1.0.2 =E2=80=94 then w=
hen this
change is backported to stable releases, the version should also be backpor=
ted
accordingly.

>
> As i said, the driver is not standalone, it is embedded within the
> kernel. Changes to the kernel can break the driver. When you get a bug
> report from a customer, and they say version v42 of the driver is
> broken, isn't the first thing you are going to ask is what kernel
> version? Is it a vendor kernel? Which vendor?
>
> If you leave version unfilled, ethtool will report something like:
>
> version: 6.12.29-amd64
>
> which is much more useful.

I actually think the approach you mentioned =E2=80=94 printing the hash val=
ue =E2=80=94 is
also useful. We may want to reconsider that method as well. But in my opini=
on,
this doesn=E2=80=99t affect the current patch. We might adjust that part la=
ter.

>
> > > > +	mtu =3D le16_to_cpu(cfg->mtu);
> > > > +	if (mtu < netdev->min_mtu) {
> > > > +		dev_err(edev->dma_dev, "device MTU too small. %d < %d", mtu, net=
dev->min_mtu);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	netdev->mtu =3D mtu;
> > > > +	netdev->max_mtu =3D mtu;
> > >
> > > Setting mtu the same as max_mtu is unusual? Are you defaulting to jum=
bo?
> >
> > In the cloud the dpu controls this.
>
> No, linux controls this. This driver controls this, using these line
> here. Userspace can change it later, but this is the default. And 99%
> of Linux systems default to 1500. Is max_mtu 1500? Or is it some jumbo
> value? You at last need to add a comment you are ignoring what
> everybody else does and are setting the MTU to something larger,
> because that is what your use case is.
>
> You are aiming to write an Ethenet driver which looks pretty much like
> every other Ethernet driver in Linux. When you do something different,
> you need to justify it, add a comment why your device is special and
> needs to do something different.

No problem, I'll add a comment to explain this. I didn't realize there was
anything special about it at first. However, in cloud scenarios, this issue=
 is
relatively straightforward =E2=80=94 it's a bit different from physical NIC=
 drivers.
When users purchase a machine or NIC, they=E2=80=99ve already decided wheth=
er the
working environment uses 1500 or jumbo frames. Our hardware will return eit=
her
1500 or 9000 based on whether jumbo frames are enabled in hardware.

The reason we wrote the driver this way is to automatically configure an MT=
U of
9000 in jumbo frame scenarios, so that users don=E2=80=99t have to do much =
manual
configuration.

Thanks.

>
> 	Andrew

