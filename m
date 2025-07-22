Return-Path: <netdev+bounces-208881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D24B0D7A3
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8C11AA731B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45C72BE051;
	Tue, 22 Jul 2025 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wuN5tHkA"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD8B28B3FD
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182117; cv=none; b=A1dvU6BMbcgWkF2KOkCMC64pSHGPOTQ0zI6EA23vCeB51RefKi97pUChZ8wVwNVFSMEGITfUqLuZxTnfXl6oQWofs3g401QcBKtLO2z7Mh18IyQtFQpfc4zAmyBBYmL03kk8poMaUaEnk90Vi+DEfreYcMonvwf4lffwMZb3UlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182117; c=relaxed/simple;
	bh=SO2hEIIygcqUmsfzqTzuYifhFtH/JQkR4TGs52igfY0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=pC0pb1UPbwa/7AMJ15BtUo/zsBl7c4Ff7vkjIyKFWkO96X8V/+R4pa12/Q2UT1nRTgeov35lSV89CHFsIdX6JaB5EO11X5hBDv0gxtuHJXI858v4QTT1vuZ7DKd0Psd1F3kM7SGSmLV2+OjEUXC2WhmSV5tnejgQySbJOb458LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wuN5tHkA; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753182111; h=Message-ID:Subject:Date:From:To;
	bh=i9av63v9ikh8fxngZ0AhF0nnehbnS74YVIRzE3DQcZE=;
	b=wuN5tHkAhbVYyPTsNU8TRc8x2i3XLMfKbl0Nfy7AxNP/SvRWE8Za6jRWF+kH/V6uyQyJ99O7gXdjJ8dOhU65myBTa+aTS7k1e97SVx4ZHQpPIVLVxnv8pa+4SBJPYzeWvRxPdQ4135UIqFB8vAvMfsgrUvzgYGM8xCEXQiH7CbQ=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WjW.xsl_1753182110 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 19:01:50 +0800
Message-ID: <1753181623.6635778-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Tue, 22 Jul 2025 18:53:43 +0800
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
 <1752803672.0477452-1-xuanzhuo@linux.alibaba.com>
 <9e208e97-23ef-41e7-94d0-0a391cba9b59@lunn.ch>
In-Reply-To: <9e208e97-23ef-41e7-94d0-0a391cba9b59@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 18 Jul 2025 18:59:32 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
> > We have our own distribution "Anolis".
>
> This driver can be used with any distribution. So it needs to work
> equally well for all distributions.
>
> If you want this feature in Anolis, you can take the upstream version
> and hack in the feature in your downstream kernel.

By inspecting the kernel release string (utsname()->release), we can identify
the Linux distribution in use, such as Anolis, Red Hat, or Ubuntu. This allows
us to provide support for these and other mainstream distributions. While we
plan to offer enhanced support on Anolis and these specific platforms, this
approach will not negatively impact other systems. Therefore, we see this as a
method that can only improve functionality without introducing any drawbacks.

Thanks.


>
> > > No module parameters. You are doing development work, just use $EDITOR
> > > and change the timeout.
> >
> > Our use case has already been explained. We will set a long timeout to help with
> > issue diagnosis, and once the problem is identified, we will immediately adjust
> > the timeout to let the driver exit quickly. Honestly, this is a very useful
> > feature for us during the development process. Of course, it seems that you are
> > strongly opposed to it, so we will remove it in the next version.
>
> We have been pushing back on module parameters for years. You should
> of seen this in multiple review comments on the netdev list.
>
> 	Andrew
>

