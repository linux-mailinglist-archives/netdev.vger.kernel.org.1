Return-Path: <netdev+bounces-229216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D01BD96BC
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7054F3B09D9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC4F313E01;
	Tue, 14 Oct 2025 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HszG6qEZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33EA31282E
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445814; cv=none; b=ivqZxAxePh6nk5xWgpVnfIHgil3kZLRN/cE8JjPvD4EOmVY1eWiWoMivvubwFqsONAQQP2pmMPwCcBLh8tRR9vv2H+4LVTZA6u+zLgWpmuS7JjDH3SuwpmJWdib/OWODeLXnofNQuV4DQ5MGDg4boUvKHIbfMlfuuXTSNxZ+BWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445814; c=relaxed/simple;
	bh=aun758XjXsavxlUOdhTmZDa4cnyGL+oy6vyIW57NBu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9xrnunkU7ZHioNWShVANk0CofpNlAzVr89jGyGmJSeAkdqzKr3Y8pW7fJBQD2/TZtEfyTlsZw6CSdwd1AidS2UMi03FdZhRq9PCX8qw2uVe6C8f/n3CrtsEFKuy+Powmn0W+Z5HacvXwDt1WhhI8mH6WNhrnczMb1LT845PfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HszG6qEZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iSoZPghPppYlVYccoAoi+S1SyqL5zo9Qqnbc1CiKQfY=; b=HszG6qEZ0ENWvKJlkRc1qHZsqz
	w1EN0NI78hmW4WDTsUfzm22mgyhvevczopIL7PYHsWsSKJo6Qs2NVshvbFF+yrpgUhKV5A0SHMa93
	Mp0wnD60rogZ+vs/Gg20/T+URFLwti4WtHmPKiMRRMHX40ePllDZ+tnDNpTvfQ1Zg/vY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8eMn-00AuSc-QX; Tue, 14 Oct 2025 14:43:01 +0200
Date: Tue, 14 Oct 2025 14:43:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>, alok.a.tiwari@oracle.com,
	kalesh-anakkur.purayil@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
Message-ID: <a8936e7e-da32-4562-a88e-af5d763a883e@lunn.ch>
References: <20251013021833.100459-1-xuanzhuo@linux.alibaba.com>
 <8b853379-1601-4387-adaf-31f786f306ca@redhat.com>
 <1760441688.9352384-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1760441688.9352384-1-xuanzhuo@linux.alibaba.com>

> > That also means that you require the reviewers to invest a lot of extra
> > effort here, which in turn does not help making progresses.
> 
> Indeed, it's been quite a while, but I haven't made any substantial progress on
> this patchset, and I'm really considering this. Would splitting up a few commits
> speed up the review process?

Flip the question around, say you where asked to review this work
mixed in with all your other work. Would you not find it easier to
review 15 small patches, one per coffee break, after lunch, before
setting off home, waiting for a kernel to compile, etc, than one huge
patch.

Also, good subject lines attacks reviews who have interests in
subsections. If the subject line says ethtool, i'm more likely to look
at that one patch, and you will get a review of it. When ethtool is
not obvious, i probably won't bother.

	Andrew

