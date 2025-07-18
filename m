Return-Path: <netdev+bounces-208075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CED2B099A1
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 04:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6A63BC62C
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 02:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7B135959;
	Fri, 18 Jul 2025 02:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S69TzomJ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7714B2E3711
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 02:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804441; cv=none; b=d9iZJAhvBEKmi+I8ICLtx/gwEhL1B8nxZq0aw+0+D1meH8XMna5WwnTW2oyiH9Tscxd/BnGuRaPbXOLzF+aqmBgNkxP8GXm3FdU2GHv2VLcduveEYSJUMCu/cpXccKDVmqh4H/Yjmbi3jKDcSQkl5eMTW8ax2Gh4LHZipjmCezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804441; c=relaxed/simple;
	bh=tQAe7m2iDE6jfHtq+UaVW+/kfvZHzELuP2n3Ut3T5/8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=ccq8B/9qVS5KJ+m2rvesV9x2Sjv8w8ljJpqFRAg7xFfRdCcIwTxcmEqZqVAki3dGBhbkU/9wN3xpwH8gPKSwuusJI4ingSPku1Nkp1Q+NRFf2XDCiuagDADMdZyTgHpMe7BvEiUUGbapYnX3tFsWKeFYhJojurAYNj299DUVw9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S69TzomJ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752804429; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=jxTS3uYPaQ5aWTonkraDvMwmllJOj8B57Xf8RErTeRQ=;
	b=S69TzomJY3S+psdHVkFY5cRsyk4NLVKsQFwYBvKv7EYpyOyXbPrk+q7J5QyQD+a2mjJeMj3pgAr5ZVUaDNJXL7cFDAyIxLIhmaKHPhtJ+rmhuMNckWoRXpwH+gwmrDpbhqodEbnfykA/DJhN7Lc2ffrjn1Bx0LWhITS2ist2Uog=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WjATzR6_1752804428 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 10:07:08 +0800
Message-ID: <1752803672.0477452-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Fri, 18 Jul 2025 09:54:32 +0800
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
 <1752733075.7055798-1-xuanzhuo@linux.alibaba.com>
 <161e69d8-eb8e-4a5d-9b4e-875fa6253c67@lunn.ch>
In-Reply-To: <161e69d8-eb8e-4a5d-9b4e-875fa6253c67@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 17 Jul 2025 19:27:03 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
> > > That is not a very good explanation. Do you see any other system in
> > > Linux were the firmware works around bug in Linux drivers using the
> > > kernel version?
> >
> > Actually, there is one, we noticed that the ena driver has a similar me=
chanism.
> >
> > 	struct ena_admin_host_info
> >
> > >
> > > You also need to think about enterprise kernels, like RedHat,
> > > Oracle. They don't give a truthful kernel version, they have thousands
> > > of patches on top fixing, and creating bugs. How will you handle that?
> > >
> > > Please drop all this, and just fix the bugs in the driver.
> >
> >
> > Fixing bugs in Linux is, of course, the necessary work. However, if cer=
tain bugs
> > already exist and customers are using such drivers, there is a risk inv=
olved. We
> > can record these buggy versions in the DPU, and notify users via dmesg =
when they
> > initialize the driver.
>
> This then references the next point. What does 5.4.296 actually mean?
> It is mainline 5.4.296? Is it Debian 5.4.296 with just a few patches
> on top? Is it Redhat with 1000s of patches on top? Is it a vendor
> patch which broke it, or is mainline broken? If the vendor broke it,
> are you going to apply workarounds in your DPU for mainline which is
> not broken? Does you DPU tell the world it is applying a workaround,
> so somebody trying to debug the issue knows the DPU is working against
> them?
>
> As you pointed out, there might be one driver amongst hundreds which
> reports the kernel version to the firmware. Does ENA actually do
> anything with it? I don't know. But since less an 1% of drivers
> actually do this, it cannot be a useful feature, because others would
> already be do it.

We have our own distribution "Anolis". I think we can distinguish different
distributions based on utsname()->release, and by combining it with the ker=
nel
version and driver version, we can locate the actual driver implementation.
Actually, this is just a reserved mechanism, designed in advance for possib=
le
future needs. If you want me to guarantee that this method will definitely =
work,
I can't answer that. Although I personally think this mechanism should
work. And as an attempt, I don't think there is a big problem with it.

>
> > However, once we've identified the problem, we would prefer for the ope=
ration to
> > time out and exit, so that we can reload the new .ko module. In this pr=
ocess, we
> > may adjust the module parameters to reduce the originally large timeout=
 value,
> > forcing it to exit faster. This use case is actually very helpful durin=
g our
> > development process and significantly improves our efficiency.
>
> No module parameters. You are doing development work, just use $EDITOR
> and change the timeout.

Our use case has already been explained. We will set a long timeout to help=
 with
issue diagnosis, and once the problem is identified, we will immediately ad=
just
the timeout to let the driver exit quickly. Honestly, this is a very useful
feature for us during the development process. Of course, it seems that you=
 are
strongly opposed to it, so we will remove it in the next version.

>
> > > So you will be submitting a patch for GregKH for every single stable
> > > kernel? That will be around 5 patches, every two weeks, for the next
> > > 30 years?
> >
> > Of course we won't be doing that. Our plan is that whenever we update t=
he code
> > =E2=80=94 for example, fixing a bug and updating the version from 1.0.0=
 to 1.0.1, or
> > introducing a new feature and bumping the version to 1.0.2 =E2=80=94 th=
en when this
> > change is backported to stable releases, the version should also be bac=
kported
> > accordingly.
>
> So the version is useless. This has long been agreed, and we have been
> NACKing such versions for years.

OK, we will change it in next version.

Thanks.


>
> 	Andrew
>

