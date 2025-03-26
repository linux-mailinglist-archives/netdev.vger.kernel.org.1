Return-Path: <netdev+bounces-177704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2044A7154F
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE813B49D0
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A641B424A;
	Wed, 26 Mar 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KTAReiyQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8521D19CCF5
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742987245; cv=none; b=odo/hxxko3LAW91am/rVCgbvi0xw1bq9/jyqRpTQ7wH057vFsqyciAT6BUAazX1+Di3gPiuSOlrsrM/CIGD34EEeRtJvUkkj6ExCqqO0youwgj8hf1uTh3f5d116tcl8tXlRbo01D4Sp7ceHZ4UU9sFpp1tS2V39BUhZOpqAd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742987245; c=relaxed/simple;
	bh=nafXr4aQp9sPHj07wuZhnu1/C5uqTGqVAGhqAhzRZhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FH1h8GfF8X2LRWiZaCnCFsxzQ07K0H3qotvbwXnMAgpcPjPKJh3MDOOf4JzXrVC/ctMp04/rCobyXV55v6AqGtRVyg4XD9uGA5CBic7Fhajisg7GeQcweUhPwJBraPZER2wkf2W51l9lVHiYX+nSGrJjQYHWUMDomfBeSuvO+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KTAReiyQ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1A4644214;
	Wed, 26 Mar 2025 11:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742987241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atFjmQU0vexWer0Wg1LJYp7tc/TPq8eOvlDuSuLkmuI=;
	b=KTAReiyQkcwnJWfg7QvswLkEfhsK++8CrRBpSms/KKItRtydNnIqDFmwb0X+nIM/tKlGCr
	I3oe2SckM7WhzEtb2hYDpNM5ZuTjb6g3sYM0CsLUPnfapWIpQdsSGFzy/zmuukKMTm0fXF
	KDRfBUIhIhCaSkae1g2cewupAt0PD/Bwx8W+bcG9S1vDdH/Ks4BLbIcvxnwrPfmwUd1K45
	zXLOE88EqWfXq3rSm4W72Eq0pnGCtmbTIksd5xImtvgsbtiZIcuiu154QfrXDNJNHwLjG7
	JanUz7G4upnWayqSSlOSJ0frL7+fODQNJ9JsbNEzsx5kudAcDMV5+R+zmms71g==
Date: Wed, 26 Mar 2025 12:07:19 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, marcin.s.wojtas@gmail.com,
 linux@armlinux.org.uk, andrew@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net] net: mvpp2: Prevent parser TCAM memory
 corruption
Message-ID: <20250326120719.587afbf8@fedora.home>
In-Reply-To: <20250326103821.3508139-1-tobias@waldekranz.com>
References: <20250326103821.3508139-1-tobias@waldekranz.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudfgleelvddtffdvkeduieejudeuvedvveffheduhedvueduteehkeehiefgteehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepthhosghirghsseifrghluggvkhhrrghniidrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepk
 hhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrtghinhdrshdrfihojhhtrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Tobias,

On Wed, 26 Mar 2025 11:37:33 +0100
Tobias Waldekranz <tobias@waldekranz.com> wrote:

> Protect the parser TCAM/SRAM memory, and the cached (shadow) SRAM
> information, from concurrent modifications.
> 
> Both the TCAM and SRAM tables are indirectly accessed by configuring
> an index register that selects the row to read or write to. This means
> that operations must be atomic in order to, e.g., avoid spreading
> writes across multiple rows. Since the shadow SRAM array is used to
> find free rows in the hardware table, it must also be protected in
> order to avoid TOCTOU errors where multiple cores allocate the same
> row.
> 
> This issue was detected in a situation where `mvpp2_set_rx_mode()` ran
> concurrently on two CPUs. In this particular case the
> MVPP2_PE_MAC_UC_PROMISCUOUS entry was corrupted, causing the
> classifier unit to drop all incoming unicast - indicated by the
> `rx_classifier_drops` counter.
> 
> Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
> 
> @Andrew: I did finally manage to trigger sparse warnings that could be
> silenced with __must_hold() annotations, but I still do not understand
> how they work. I went back to the change that pulled this in:
> 
> https://lore.kernel.org/all/C5833F40-2EA6-43DA-B69C-AFF59E76E0C9@coraid.com/T/
> 
> The referenced function (tx()), still exists in aoenet.c. Using that
> as a template, I could construct an unlock+lock sequence that
> triggered a warning without __must_hold(). For example...
> 
> spin_unlock_bh(&priv->prs_spinlock);
> if (net_ratelimit())
> 	schedule();
> spin_lock_bh(&priv->prs_spinlock);
> 
> ...would generate a warning. But this...
> 
> spin_unlock_bh(&priv->prs_spinlock);
> net_ratelimit();
> schedule();
> spin_lock_bh(&priv->prs_spinlock);
> 
> ...would not.
> 
> Reading through the sparse validation suite, it does not seem to have
> any tests that covers this either:
> 
> https://web.git.kernel.org/pub/scm/devel/sparse/sparse.git/tree/validation/context.c
> 
> Therefore, I decided to take Jakub's advise and add lockdep assertions
> instead. That necessitated some more changes, since tables are updated
> in the init phase (where I originally omitted locking).
> 
> @Maxime: There was enough of a diff between v2->v3 that I did not feel
> comfortable including your signoff/testing tags. Would it be possible
> for you to run your tests again on this version?

Sure thing, although I do have some comments :)

[...]

>  /* Parser default initialization */
> @@ -2118,6 +2163,8 @@ int mvpp2_prs_default_init(struct platform_device *pdev, struct mvpp2 *priv)
>  {
>  	int err, index, i;
>  
> +	spin_lock_bh(&priv->prs_spinlock);
> +
>  	/* Enable tcam table */
>  	mvpp2_write(priv, MVPP2_PRS_TCAM_CTRL_REG, MVPP2_PRS_TCAM_EN_MASK);
>  
> @@ -2139,8 +2186,10 @@ int mvpp2_prs_default_init(struct platform_device *pdev, struct mvpp2 *priv)
>  	priv->prs_shadow = devm_kcalloc(&pdev->dev, MVPP2_PRS_TCAM_SRAM_SIZE,
>  					sizeof(*priv->prs_shadow),
>  					GFP_KERNEL);

GFP_KERNEL alloc while holding a spinlock isn't correct and triggers a
splat when building when CONFIG_DEBUG_ATOMIC_SLEEP :

[    4.380325] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
[    4.389217] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
[    4.397120] preempt_count: 201, expected: 0
[    4.401358] RCU nest depth: 0, expected: 0
[    4.405507] 2 locks held by swapper/0/1:
[    4.409488]  #0: ffff000100e168f8 (&dev->mutex){....}-{4:4}, at: __driver_attach+0x8c/0x1ac
[    4.417971]  #1: ffff00010ae15368 (&priv->prs_spinlock){+...}-{3:3}, at: mvpp2_prs_default_init+0x50/0x1570
[    4.427843] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc7-01963-g02bf787e4750 #68
[    4.427851] Hardware name: Marvell 8040 MACCHIATOBin Double-shot (DT)
[    4.427855] Call trace:
[    4.427858]  show_stack+0x18/0x24 (C)
[    4.427867]  dump_stack_lvl+0xd8/0xf0
[    4.427875]  dump_stack+0x18/0x24
[    4.427880]  __might_resched+0x148/0x24c
[    4.427890]  __might_sleep+0x48/0x7c
[    4.427897]  __kmalloc_node_track_caller_noprof+0x200/0x480
[    4.427903]  devm_kmalloc+0x54/0x118
[    4.427910]  mvpp2_prs_default_init+0x138/0x1570
[    4.427919]  mvpp2_probe+0x904/0xfa4
[    4.427926]  platform_probe+0x68/0xc8
[...]

I suggest you move that alloc and associated error handling outside of
the spinlock.

Thanks,

Maxime

