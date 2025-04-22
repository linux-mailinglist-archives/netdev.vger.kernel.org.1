Return-Path: <netdev+bounces-184690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B468A96DEC
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD2A18846B7
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDA4283CA5;
	Tue, 22 Apr 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GVrP4kuf"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982EF28152C;
	Tue, 22 Apr 2025 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330843; cv=none; b=oeVBGbqYfAnM3gVt+QBPWwYwTVfGRtI4TJ+0Ch3S239r3IyP75crxyRN26KypfcbVFHlOxlLMWcsftEmgRbgAlkTDVgypn/BpUCnvYnnjDZ2yaEVXAWBrS2BQKFlBsMIZKwGOPVn2vucSFyTty062uMuX46103GjMW/vRf/TjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330843; c=relaxed/simple;
	bh=L5vEqUZFBltBt3lqfvnd5aOABuONXKbvGy6cY8LQwss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxbnJlet7C5nV4bSaTeXYXAM2cje6+2noTotJbcQiW8Zrjcqai0HadieItRsWxRYe/fRdaUIcEmJnNNPBe2VlEj8fo7agMk2jSMQ4OL/7pxgDgGBCWTznKq1ttmJzqXntRlwA3adZvu4duiBUOSewz5PNt8fk6jQ6pZOMZYbxXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GVrP4kuf; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D08E438B8;
	Tue, 22 Apr 2025 14:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745330839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wQBSXq5gMB9p0PSlyEcreJi6xlp1HfzxXyQ7iVhE8Q=;
	b=GVrP4kufEZOfGy/tFnOMdXAbL6gaybEyWDMLGZCYQ/fFdj4b5H/ZekXPJpZ/Ki+gmoPhUh
	L4pS/IhCwrddCrYuK1xRcbtzNcLESF2KUJJPpDYgD9FJGp8h7/ABLh+LcJe1tB9jNFkNWY
	TneYE+e4JvIaPkJnvRqS8zk3xVjI7I3OGURn61KMED7wAnLgcyAU3hFnOhOIk7SNQ0r359
	/FrBaXE17Sg5Etx0fd3fsmvZ7ZP/dk65Y4fZoMETcYd6rlxiIzDWGuglBNUvlJy/RA4rQP
	cryNSs+C3asamzoSJTCVO828IJkIfAWCMDSqTT/bUnwp14GjlwthHkj3s5pKcQ==
Date: Tue, 22 Apr 2025 16:07:16 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Biao
 Huang <biao.huang@mediatek.com>, Yinghua Pan <ot_yinghua.pan@mediatek.com>,
 kernel@collabora.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] net: ethernet: mtk-star-emac: rearm interrupts in
 rx_poll only when advised
Message-ID: <20250422160716.71a16b1a@fedora.home>
In-Reply-To: <20250422-mtk_star_emac-fix-spinlock-recursion-issue-v1-2-1e94ea430360@collabora.com>
References: <20250422-mtk_star_emac-fix-spinlock-recursion-issue-v1-0-1e94ea430360@collabora.com>
	<20250422-mtk_star_emac-fix-spinlock-recursion-issue-v1-2-1e94ea430360@collabora.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtoheplhhouhhishgrlhgvgihishdrvgihrhgruhgusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepnhgsugesnhgsugdrnhgrmhgvpdhrtghpthhtohepshgvrghnrdifrghnghesmhgvughir
 ghtvghkrdgtohhmpdhrtghpthhtoheplhhorhgvnhiioheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Louis-Alexis,

On Tue, 22 Apr 2025 15:03:39 +0200
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> wrote:

> In mtk_star_rx_poll function, on event processing completion, the
> mtk_star_emac driver calls napi_complete_done but ignores its return
> code and enable RX DMA interrupts inconditionally. This return code
> gives the info if a device should avoid rearming its interrupts or not,
> so fix this behaviour by taking it into account.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Patch looks correct, however is it fixing a problematic behaviour
you've seen ? I'm asking because it lacks a Fixes: tag, as well as
targetting one of the net/net-next trees :)

Thanks,

Maxime


