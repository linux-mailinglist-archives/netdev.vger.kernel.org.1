Return-Path: <netdev+bounces-176419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365F2A6A30D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C7A464CB3
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 09:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34D1221DBD;
	Thu, 20 Mar 2025 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nHvo4Utg"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA7221F24
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742464674; cv=none; b=sqWPGp7lfqYDXu44UtLA0MwoqIipl+kOQ4nZj0g+mq29GMXPjzjRqjTZAekJu4lY2lYkemoU4YmQzdpaJc0NhPMagmh5ed8JAjZXvsWyJ2+sOs8mT577iMSyOpq/BbheEiMFq0LBfMzxi7HiW8F7o/0mFdF6vsUix8Sw7f4i3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742464674; c=relaxed/simple;
	bh=EJiEh7iwtnAt6PKKnGI7ctASDZNETD8dBRpZkOc72Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHHTTvukc4TNmC+BsC70akPf+ab8/AZEqR2ZC0yFhfCsdoxWTz24F47Ee3y1/2nm1+nG39Z59/VtKhNZV52tMprXAwuJ7MdkdiR+f2lDpgXYL62TW7rHI1bsBEWcRicEBs5Kr4iERblpeePPp5vrKVvY61xBmcZVU+ULXLUi15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nHvo4Utg; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0DAE42E7E;
	Thu, 20 Mar 2025 09:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742464670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/q6ubIfg9EJm4OHTeYOPpSWPL5FCZwiD/0kbQinjU98=;
	b=nHvo4UtgZJuoirfgPFlwD2zWSnBNZcn12bTwM2upDimx62CvUCv3rr2gzFqwVkQe3qkkVX
	OH/5OP7/bHqDwOXxBbROsHZFxhrE/MjfKZU+GEnxXNpJLRMg8S3dPchL3JhwYHNohc+7RG
	XXbUkgrD7r27vwkgeuY4HQ5pFnbsOZI1qIgIAhub7l19HlR70j9aOQxrVn38y2QKVCeT8L
	tFmBcsUcaokM0IPA740Pu1pKn5uUxrHMSsK0ZaF5HHN7KLYa78rDQR4oRKdZC2NCgsHrD3
	9YjFHPXZdUQJ0HEfwZTg/IXDlPDmVRP7nRdnSPROU6eJ8gYbZS4XpWX/GjeJqg==
Date: Thu, 20 Mar 2025 10:57:47 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, marcin.s.wojtas@gmail.com,
 linux@armlinux.org.uk, andrew@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, ezequiel.garcia@free-electrons.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: Prevent parser TCAM memory corruption
Message-ID: <20250320105747.6f271fff@fedora.home>
In-Reply-To: <20250320092315.1936114-1-tobias@waldekranz.com>
References: <20250320092315.1936114-1-tobias@waldekranz.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveeiveeghefgkeegtdelvdelueeileehgeeiffdtuefhledvudefleehgeetveegnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepthhosghirghsseifrghluggvkhhrrghniidrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtp
 hhtthhopehmrghrtghinhdrshdrfihojhhtrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Tobias,

On Thu, 20 Mar 2025 10:17:00 +0100
Tobias Waldekranz <tobias@waldekranz.com> wrote:

> Protect the parser TCAM/SRAM memory, and the cached (shadow) SRAM
> information, from concurrent modifications.
>=20
> Both the TCAM and SRAM tables are indirectly accessed by configuring
> an index register that selects the row to read or write to. This means
> that operations must be atomic in order to, e.g., avoid spreading
> writes across multiple rows. Since the shadow SRAM array is used to
> find free rows in the hardware table, it must also be protected in
> order to avoid TOCTOU errors where multiple cores allocate the same
> row.
>=20
> This issue was detected in a situation where `mvpp2_set_rx_mode()` ran
> concurrently on two CPUs. In this particular case the
> MVPP2_PE_MAC_UC_PROMISCUOUS entry was corrupted, causing the
> classifier unit to drop all incoming unicast - indicated by the
> `rx_classifier_drops` counter.
>=20
> Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 net=
work unit")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

[...]

> +int mvpp2_prs_init_from_hw(struct mvpp2 *priv, struct mvpp2_prs_entry *p=
e,
> +			   int tid)
> +{
> +	unsigned long flags;
> +	int err;
> +
> +	spin_lock_irqsave(&priv->prs_spinlock, flags);
> +	err =3D mvpp2_prs_init_from_hw_unlocked(priv, pe, tid);
> +	spin_unlock_irqrestore(&priv->prs_spinlock, flags);

That's indeed an issue, I'm wondering however if you really need to
irqsave/irqrestore everytime you protect the accesses to the Parser.

=46rom what I remember we don't touch the Parser in the interrupt path,
it's mostly a consequence to netdev ops being called (promisc, vlan
add/kill, mc/uc filtering and a lot in the init path).

Maxime

