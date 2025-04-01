Return-Path: <netdev+bounces-178538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 921A3A777DB
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270773A7604
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E4B1624D5;
	Tue,  1 Apr 2025 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AJDCUGK8"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2681EBA14
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500064; cv=none; b=BnlCQEepNmXvofFH1JiTTibj6lHFOAkO7RI4MMnn7qxCDwN/YsiTATQoxRl6RmLK+k3cemA76qY1XRnMSN3UAG7gCqpJWaN6Z8Nb/iEWulJm0+/UH/ZqL7z3yCm7xhsq0Buxk6WKv1CSRPjHuBhcfZYsky2fq55ZofU4OWCMTeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500064; c=relaxed/simple;
	bh=HdOJjoxPx/EbF28f3Nu92fwR43QXRJchMEJWMWnyicY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+LZ2XQvcn4VP6KcDITeV2u6OB4rZ5sCwhAu3Z7cYViWhoDubXeK8pT2Ep2y6Cs9XxA5fN+H6k4q1o9X8kuxYjTRw8Kdg+m/TGbltegcraeP2/dO5usF2cRYkgBuBauThDPLrd9GK9I1rgT7povi0SwhAvUUJ0xQ07iZSKeDvqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AJDCUGK8; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F53443181;
	Tue,  1 Apr 2025 09:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743500060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IEEpqTIV2IfNfQZ4XX99c/ER5sqAOLBqoVSbkX+wjtw=;
	b=AJDCUGK8+i2V2aiAFWimcF7nf+JU0UlFZFFv4qC7LruSWRn890113lbR0XMkSFNT5DZxk8
	kxWLhUAj5VfapjI8AMywMa7uLLF1ljV07d4ZBBbG2zEt5csBtHMXr/iVk6qsLghhkh/XS2
	RcC9B2lWlvDZTVo2g+rG9CXLEXoaXD584jWt95sAgRqga3rk951c/yjMDUoZIg4hOVvsSK
	Jw7e2pJ6QvMVM5nQdECeqOTNJig642xwzGAhzs9qnLb/t4wsMvTD6/zcUM0SzuulOsZb0R
	i0MFMAGfqyZBYbam4SxR6GMcWpVaT4Prz1Ck49Z3q+BjZvKB80mBOsyyMkyL8g==
Date: Tue, 1 Apr 2025 11:34:18 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, marcin.s.wojtas@gmail.com,
 linux@armlinux.org.uk, andrew@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v5] net: mvpp2: Prevent parser TCAM memory corruption
Message-ID: <20250401113418.3af0279a@fedora.home>
In-Reply-To: <20250401065855.3113635-1-tobias@waldekranz.com>
References: <20250401065855.3113635-1-tobias@waldekranz.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvgeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehtohgsihgrshesfigrlhguvghkrhgrnhiirdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpt
 hhtohepmhgrrhgtihhnrdhsrdifohhjthgrshesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Tobias,

On Tue,  1 Apr 2025 08:58:04 +0200
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

It looks pretty good, I ran my no-so-stressfull tests to make sure
filtering / promisc paths still work and without warning, which is the
case :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks !

Maxime

