Return-Path: <netdev+bounces-185015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B738A9823C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8731899EFD
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 08:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B988278E68;
	Wed, 23 Apr 2025 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zb7IRtov"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A46274FE4;
	Wed, 23 Apr 2025 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395080; cv=none; b=P3mbDAOpcN0XQDS/Ws/iu/DhGVrEeW/okRiHbXzkxylF+f0t5A22bqfcp2bRFMwzvHrpExowKsQlE0KbQ9PSyCkirp+Gr6T+pAapEO1awEVTN84+VN9hvMzFZypXSPg9EmV3d4E5x4iUlyndMMzolgisDpTNorsuhqLre3wfrZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395080; c=relaxed/simple;
	bh=xvCTwGtUFC858f1KgNGv7sZsYg3hjfjQ+nXetoTBO/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QU07MGc3Z5CkXK1OMf1YHmwbPRnj2eL/wcLRTTmKtrjhZM5wEH4Mjf31KCg/W6UwqbMB7iJwHmdRkWEhYbjHkjVsHDDgRwoO4QqBQixNkE0gS2WDgTu3l3r+6NcaxA/dY63MUUdSNRvp7HK83IPjy6R3lYRhj8Gcyek82RckEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zb7IRtov; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2A2C439A4;
	Wed, 23 Apr 2025 07:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745395075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtkZNQ17cKFFCTiKcAIQgpYD3/NobOf59bX2kwEJLCY=;
	b=Zb7IRtovuxsd9JaOunFs3+ta/ADlC64BPVhepGERbl+eblnFne61AH7PiuZbRENtN+jioS
	Mh2yu9MOtVm/hFqKMHQfasjiHBjtsPdBSYuHUaRy/XS3erfbrta+VVwR6n0t+a+ih97x3W
	5XoRtuEY094Qx7qZBOkCuRpAEKeNRK5fNnWPMlbYH0L2vEbsJ11sfobhw1R/kWXebarBKD
	hVyq/3LWFe4tfuf9EAHCKZyUcB4XNmULwB/ArTr0Qwd5lGEk+xOS+Y9B3gCtvJfJrYuVMV
	1JZht6u0zFzoI91P1SZixMf8tO4GLMxKe5eZCFsMs703WAXPxzV47UcxVZEU1Q==
Date: Wed, 23 Apr 2025 11:54:02 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Cc: dmurphy@ti.com, andrew@lunn.ch, davem@davemloft.net,
 f.fainelli@gmail.com, hkallweit1@gmail.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk, michael@walle.cc,
 netdev@vger.kernel.org, bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH net v3] net: dp83822: Fix OF_MDIO config check
Message-ID: <20250423115402.3adaab0c@device-40.home>
In-Reply-To: <20250423044724.1284492-1-johannes.schneider@leica-geosystems.com>
References: <20250423044724.1284492-1-johannes.schneider@leica-geosystems.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopeguvghvihgtvgdqgedtrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhnvghiuggvrheslhgvihgtrgdqghgvohhshihsthgvmhhsrdgtohhmpdhrtghpthhtohepughmuhhrphhhhiesthhirdgtohhmpdhrtghpthhtoheprghnu
 ghrvgifsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehfrdhfrghinhgvlhhlihesghhmrghilhdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 23 Apr 2025 06:47:24 +0200
Johannes Schneider <johannes.schneider@leica-geosystems.com> wrote:

> When CONFIG_OF_MDIO is set to be a module the code block is not
> compiled. Use the IS_ENABLED macro that checks for both built in as
> well as module.
> 
> Fixes: 5dc39fd5ef35 ("net: phy: DP83822: Add ability to advertise Fiber connection")
> Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

