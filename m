Return-Path: <netdev+bounces-178892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B64A9A79602
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 21:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BC5189644F
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB801DDC28;
	Wed,  2 Apr 2025 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leon.nu header.i=@leon.nu header.b="rCed+GLa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BETCzZCi"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357722AF19
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622713; cv=none; b=RMyyMiKqpOJ7lWYfideHU6GakADnd+LTH7oI+1GAj9Wr9B6BGibfloQmG9MFACNexPpOrsmVsPaYK01bvINrrwUzjVvsyVACxj410YlZad9JlR6qLrrRhqV2hqukAUG/oCGRXTeiIA47qLUfaaMvgGhijHcxT435tzdaXy2wtig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622713; c=relaxed/simple;
	bh=aNJJoXC1VfqtsR5KBwqo5a6xgeSKh/OX85NrpAEuF70=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rJFFptqC4F/b9qsQ9qh6oZC/DxuC9WMS6rE7uUsCi49UBSKe8tOtN85rbOESLk1Oe2G6o5F9o7hySqgioTzmHQ9ZQMaOZJbltDso/H8vR3Clrh/37OpxlpTao5dMt2ZE7qCoHG2JuxSz02A7VxLlIJMOfCx0dYhLU1ydqJyMLC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leon.nu; spf=pass smtp.mailfrom=leon.nu; dkim=pass (2048-bit key) header.d=leon.nu header.i=@leon.nu header.b=rCed+GLa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BETCzZCi; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leon.nu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leon.nu
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id EB6DF138014C;
	Wed,  2 Apr 2025 15:38:29 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-10.internal (MEProxy); Wed, 02 Apr 2025 15:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leon.nu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1743622709;
	 x=1743709109; bh=TT/6W1mDFfg0pyb46JJPLHV+JqN8Ruf2jJgBAY1ckQU=; b=
	rCed+GLaLdhfDwY+vzuOpOWbcO0tZI7PeTeGAk7on6WsDUnXUPHzKsoKOhDu79ll
	SCV1K4egn+NziXfqEl3S/4BDb/TVRg7oMxlNvP5AhegVtV1MYk79k0Hk7hxg2Dwp
	hbQTXIIRcUXaN/90YokORbB5LCyR+rx78phHBoRvtixO/EyxMZ5HMYK4WYg0Olnu
	t8jGIXWIJWvken2l8GdwE+CP8/GySUMpC4zFX0TvMMXMUy53xt8euZJoIovHVSdl
	GxOCU/wea9cF/p6U0U6UcDIkWgoHHbO+rNsum+8GmSntoBL/KMDLBl0/ydUVlwlD
	h/yGVoCum+b0YVd8I4dF/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743622709; x=
	1743709109; bh=TT/6W1mDFfg0pyb46JJPLHV+JqN8Ruf2jJgBAY1ckQU=; b=B
	ETCzZCi3THXnVKd0VJww+2KfyGDD2XpEAURy328so4gEuSZMmSD9DZZjKBiifh72
	SNYX/93Ka+aZ7JhYJwGxnOleBPaK5zwXC9ukIRLKiXoJ5ajwEOyUtAYOLIyUYmDJ
	8/jwUazA5tPkDZgRwSlbeze6lNSXuXqhOox0O9d2vvVWEuy1ALcS+IG/RA4ZGV9Y
	aPb2Kgfe8UJeauCFVpSmDj2h6eZSICZ8LrG3KxyDnVC5Cyv4Fl6iXJ7bmPir/Hl4
	wLRWujtfiCz6gygdWQr2k52wX6DJ1x2N3DiI67wIjMXXH1U+sUC2lnzc0D10prsI
	4M7R5I4rSvBHoHwp8PW/Q==
X-ME-Sender: <xms:NJLtZ583OYYvKhHnEKwnnMmwvmHsoTROTgHzrsTL2U3n-ncuoZluqQ>
    <xme:NJLtZ9uk3_7-UidOZuo5W7rvo9I-hFSJD3nBDVVIAJRZmS-54ARSPFUsbCN2uUgL4
    LuZHRmz2K6lwCDBRkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeeihedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfnfgvohhnucftohhmrghnohhvshhkhidfuceolhgvohhnsehlvg
    honhdrnhhuqeenucggtffrrghtthgvrhhnpeeggefggfejhfevfeeutddvjedujeelkeel
    geevgefgvdefffelhfdvkeduleelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehlvghonheslhgvohhnrdhnuhdpnhgspghrtghpthhtohep
    fedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhihigrnhhosegrmhgrii
    honhdrtghomhdprhgtphhtthhopegrlhhighhuohhrihesrghmrgiiohhnrdgtohhmpdhr
    tghpthhtoheprghlihhsrghiughisegrmhgriihonhdrtghomhdprhgtphhtthhopegrmh
    hithgsvghrnhesrghmrgiiohhnrdgtohhmpdhrtghpthhtohepsggvnhhhsegrmhgriiho
    nhdrtghomhdprhgtphhtthhopegurghrihhniihonhesrghmrgiiohhnrdgtohhmpdhrtg
    hpthhtohepugifmhifsegrmhgriihonhdrtghomhdprhgtphhtthhopegvvhhgvghnhihs
    segrmhgriihonhdrtghomhdprhgtphhtthhopegvvhhoshhtrhhovhesrghmrgiiohhnrd
    gtohhm
X-ME-Proxy: <xmx:NJLtZ3BLmk4vzadlxaFn65cz4zFex52VZtCqsk1OwXJYCydvtt93tA>
    <xmx:NJLtZ9cqnAdyQMhwpoOJk7_TxwbazS1M5qHvQjwOmWXd4tXgHK2Wjw>
    <xmx:NJLtZ-Mrc7hjn5LYby9lxWuuCruvXSYFKrFAuYJCO4H6cuGInP6XxA>
    <xmx:NJLtZ_k9otJQGp0-Yieq_PXGE2Q9xlS3kHbwLFJC9gdiiFi1Y7jBJw>
    <xmx:NZLtZ_RFGoglYrNe1juKm40PX6Mc3fnvuZWp-jxP9ZmWiW6XalA5tyXd>
Feedback-ID: ic38946fa:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A699B1C20066; Wed,  2 Apr 2025 15:38:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2b8d87196999db51
Date: Wed, 02 Apr 2025 22:38:09 +0300
From: "Leon Romanovsky" <leon@leon.nu>
To: "Jakub Kicinski" <kuba@kernel.org>,
 "David Woodhouse" <dwmw2@infradead.org>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "David Arinzon" <darinzon@amazon.com>,
 "David Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>,
 "Richard Cochran" <richardcochran@gmail.com>, "Woodhouse,
 David" <dwmw@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
 "Matushevsky, Alexander" <matua@amazon.com>,
 "Saeed Bshara" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, "Bshara,
 Nafea" <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>,
 "Belgazal, Netanel" <netanel@amazon.com>, "Saidi,
 Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
 "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan,
 Noam" <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
 "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
 "Machnikowski, Maciek" <maciek@machnikowski.net>,
 "Rahul Rameshbabu" <rrameshbabu@nvidia.com>,
 "Gal Pressman" <gal@nvidia.com>,
 "Vadim Fedorenko" <vadim.fedorenko@linux.dev>
Message-Id: <38966834-1267-4936-ae24-76289b3764d2@app.fastmail.com>
In-Reply-To: <20250402092344.5a12a26a@kernel.org>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-6-darinzon@amazon.com>
 <aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
 <55f9df6241d052a91dfde950af04c70969ea28b2.camel@infradead.org>
 <dc253b7be5082d5623ae8865d5d75eb3df788516.camel@infradead.org>
 <20250402092344.5a12a26a@kernel.org>
Subject: Re: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Apr 2, 2025, at 19:23, Jakub Kicinski wrote:
> On Tue, 01 Apr 2025 09:46:35 +0100 David Woodhouse wrote:
>> On Tue, 2025-04-01 at 09:02 +0100, David Woodhouse wrote:
>> > 
>> > I think the sysfs control is the best option here.  
>> 
>> Actually, it occurs to me that the best option is probably a module
>> parameter. If you have to take the network down and up to change the
>> mode, why not just unload and reload the module?
>
> We have something called devlink params, which support "configuration
> modes" (= what level of reset is required to activate the new setting).
> Maybe devlink param with cmode of "driver init" would be the best fit?

I had same feeling when I wrote my auxbus response. There is no reason to believe that ptp enable/disable knob won't be usable by other drivers 

It's universally usable, just not related to netdev sysfs layout.

Thanks 

>
> Module params are annoying because they are scoped to code / module not
> instances of the device.

