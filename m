Return-Path: <netdev+bounces-207991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 445C3B0932E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC86B1C470E5
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233C02FD59D;
	Thu, 17 Jul 2025 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4PMi9+5m"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A613298CCD
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773232; cv=none; b=lYo62LjFWeKMiS5ESoZvNysHh8YP4VStBwaKCzYo/AGF0lK4J/Ujy8Vf1+3XtKmvLCmifStKZRAYxggjzz0F2xOqOOalJFJIVko1TbdLDAFuPzFKPyFw6mCTWIaRhy7MZEaeVr3dG5YTVVwyFcsaSMxZK0/yaICzc3EDCJxBjoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773232; c=relaxed/simple;
	bh=RENz42Q8seLIJ2aNX+RNzlOsfx9EeYhCpLCdFsetAWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZN2z6VNifgFR2YusNLRjX4RPj5ouOjKigBDXsBZJrMKtY4OQX+1yO0VR3jto6T9NHvvEIwEAdB1TLOOlSfmWHjwsRgXqyBFvwoZCCFY5gL3jLOX2DQY6VU5oFQbcgsMxG0RPlZzl2Q4xuxyQ8hSWTzPnUYetVWWOv8IWZGlDDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4PMi9+5m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=CC5a/jcBKA0XOeQ219jfJn57rXndSHGi/bKJxTv6FpU=; b=4P
	Mi9+5mlXX5SEbpDOkTTcD9Yu16e4OrfZB5v8uXPE4cGMjuCT+ITaHci30ESgZJsspcXQFOYQFdUwY
	bVYLAE2dOF+zhgYthpk3UigHcCgHlRFu2+61pFZ7g1Ae1Ar/0tkwyiJNKaor0s6o5d8iGJbVZt4Bb
	P2WuQNclJWpjaC4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ucSNr-001usR-OC; Thu, 17 Jul 2025 19:27:03 +0200
Date: Thu, 17 Jul 2025 19:27:03 +0200
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
Message-ID: <161e69d8-eb8e-4a5d-9b4e-875fa6253c67@lunn.ch>
References: <20250710112817.85741-1-xuanzhuo@linux.alibaba.com>
 <7b957110-c675-438a-b0c2-ebc161a5d8e7@lunn.ch>
 <1752644852.1458855-1-xuanzhuo@linux.alibaba.com>
 <322af656-d359-44d8-9e40-4f997a8b7e0f@lunn.ch>
 <1752733075.7055798-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1752733075.7055798-1-xuanzhuo@linux.alibaba.com>

> > That is not a very good explanation. Do you see any other system in
> > Linux were the firmware works around bug in Linux drivers using the
> > kernel version?
> 
> Actually, there is one, we noticed that the ena driver has a similar mechanism.
> 
> 	struct ena_admin_host_info
> 
> >
> > You also need to think about enterprise kernels, like RedHat,
> > Oracle. They don't give a truthful kernel version, they have thousands
> > of patches on top fixing, and creating bugs. How will you handle that?
> >
> > Please drop all this, and just fix the bugs in the driver.
> 
> 
> Fixing bugs in Linux is, of course, the necessary work. However, if certain bugs
> already exist and customers are using such drivers, there is a risk involved. We
> can record these buggy versions in the DPU, and notify users via dmesg when they
> initialize the driver.

This then references the next point. What does 5.4.296 actually mean?
It is mainline 5.4.296? Is it Debian 5.4.296 with just a few patches
on top? Is it Redhat with 1000s of patches on top? Is it a vendor
patch which broke it, or is mainline broken? If the vendor broke it,
are you going to apply workarounds in your DPU for mainline which is
not broken? Does you DPU tell the world it is applying a workaround,
so somebody trying to debug the issue knows the DPU is working against
them?

As you pointed out, there might be one driver amongst hundreds which
reports the kernel version to the firmware. Does ENA actually do
anything with it? I don't know. But since less an 1% of drivers
actually do this, it cannot be a useful feature, because others would
already be do it.

> However, once we've identified the problem, we would prefer for the operation to
> time out and exit, so that we can reload the new .ko module. In this process, we
> may adjust the module parameters to reduce the originally large timeout value,
> forcing it to exit faster. This use case is actually very helpful during our
> development process and significantly improves our efficiency.

No module parameters. You are doing development work, just use $EDITOR
and change the timeout.

> > So you will be submitting a patch for GregKH for every single stable
> > kernel? That will be around 5 patches, every two weeks, for the next
> > 30 years?
> 
> Of course we won't be doing that. Our plan is that whenever we update the code
> — for example, fixing a bug and updating the version from 1.0.0 to 1.0.1, or
> introducing a new feature and bumping the version to 1.0.2 — then when this
> change is backported to stable releases, the version should also be backported
> accordingly.

So the version is useless. This has long been agreed, and we have been
NACKing such versions for years.

	Andrew

