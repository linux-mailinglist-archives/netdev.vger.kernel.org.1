Return-Path: <netdev+bounces-177914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AEDA72DFB
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8572B18991A2
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77431F583D;
	Thu, 27 Mar 2025 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bCiVsCqN"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1D613C8EA;
	Thu, 27 Mar 2025 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072234; cv=none; b=kWb+voCxVOF8dclDT8MJVKZFoZqlq0ee2HGG1na6OLL9YYAtACN05ZAnZcoYMnzCCuvyiBr4P5tHUhXq2SOg66OF5C+g6qiYdG6YsJC2KCWQpVPVeJP3ihRlmsrF7tICfUUPlpreROjUWi04TbxWg5i16/YMbULnkWx9fRAcGdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072234; c=relaxed/simple;
	bh=LNzFD4UKrFjJu57yMLhUZafPSls/yUwU6yVnfk6edUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqN6dWlCz37PHPbcXe1qi7kr5eY2TORwJFBboZLBKLMAIW2GK+fLuRvwCuLuvGpMNniVRP1T1om9yBvO9Z8sooGtP9bkxX10sfxNJKHLYZiZ8ovQknXSmo/3VbwKXv1XreLTX+APOcpY3FT8Cyek8XMx/G0F9MNbw8o/IU4GkOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bCiVsCqN; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 99E8C42E81;
	Thu, 27 Mar 2025 10:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743072224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36UvBXe9alYnqpKpGCxPQUT55PmtTW/p6TH6mKS5FV4=;
	b=bCiVsCqNE0XhFKT1KwTmhYF+8EA1WBtLvRM1cowo0R/jz4fOoc0WmrUote4241Co9GRcBs
	iAPFBgZw8z4jvQPe7cmkn8nQsIMmm6W7yNuZwtuYAVrBdmhO3JYvvGEl4vMvTz7o02SIVj
	X1SF6Y6bLXrrvlC7VZhKLuRZ20yLh+0xfb44yE/sDv6TDk1Q4XwDGA6mQuEN+02o30xikn
	mtxk61Kv/VlHuoi+CLiS877zDepr56kLIXqLZNcNfjY+JPk8OZcwnnU0f3sfWr6ROrji1A
	66/lRj4r5IZ2VC04isD88Qt0qlsaGsi1qz4PL41BcR6pF6ucHe+W/vNIcFMkNA==
Date: Thu, 27 Mar 2025 11:43:40 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Russell King <linux@armlinux.org.uk>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] MAINTAINERS: Add dedicated entries for
 phy_link_topology
Message-ID: <20250327114340.2b8d18a5@fedora-2.home>
In-Reply-To: <20250313153008.112069-1-maxime.chevallier@bootlin.com>
References: <20250313153008.112069-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdqvddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepv
 gguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 13 Mar 2025 16:30:06 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> The infrastructure to handle multi-phy devices is fairly standalone.
> Add myself as maintainer for that part as well as the netlink uAPI
> that exposes it.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

Thanks Jakub and Andrew for the Acks, I'll resend on the net tree as
per Paolo's instructions :)

Maxime

