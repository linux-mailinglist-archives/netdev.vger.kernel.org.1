Return-Path: <netdev+bounces-183175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC4BA8B4A5
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124873ACB93
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11394233155;
	Wed, 16 Apr 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ae6wIsrj"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB3922FF2D;
	Wed, 16 Apr 2025 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794240; cv=none; b=Lt+6EAiMiKG2jRy3IJJA1zVandUpFzi1R7ofo7YjXD/r9A8A9mBqMpi3LYUnCiqqaqTQ5h5eBriAMI9PrTBnPbW2d0FCKTTwxVvJWxM0trykbQw00xKNpK4MVDxyOPrNoKlbYIesXf5JQfOy8WtrpwXEBTc0wr/xVwoJEEdNLuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794240; c=relaxed/simple;
	bh=xWX56MLkHZw/GZNOTxJ7M6xTx+/WmLb4gwBvJUYftZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6W3OHVeSmVr5EAKZ30ooNFj6r25J/blnpAXXhCIaz0uRzbdx32cmB6mAi+BX63Mykdm5TSWrcbrTd/4c6b3vnWlXBP78UOT/1DjZKwUSZp24hsTdtvxkQLJJCYqOh73sdy//dFksFeUUuwnF0DziuE8c11ScIczI+O4CvebpNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ae6wIsrj; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 87F754327A;
	Wed, 16 Apr 2025 09:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744794235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWX56MLkHZw/GZNOTxJ7M6xTx+/WmLb4gwBvJUYftZo=;
	b=Ae6wIsrj0/PLU4ol8EMC2g4AnIqshb3tRqVygY3H+leCF7pJwG/0XjRA8JvcGzoWhYdlBo
	kQpK7h+ZQVtnTQulWBk2+leKK9kCbYQQQmP7KBNwONPicRAqnIWKLXtbSHaeSbQVKo5aqd
	s6C0krPwfmcWlN/KDakkOItbDInATBSW5v1oQl3Ovc26dpJDL7Dq3O9bf2PPEnZohFHjFf
	jHaQ3W/qZKjmhwRVtwG6N5B8/dFUywB+ZV1Krtk+qWMSo0D2cRHqBvcd5U8606wu/i2YGB
	y0/dPy8cSarGEiXif9YexL7Z7wB8H1bqRqi/25m69TMPLou0A9DbD8tphNNZ0Q==
Date: Wed, 16 Apr 2025 11:03:51 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Kees Cook <kees@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Wei
 Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Jeroen de
 Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Simon Horman <horms@kernel.org>, Geoff
 Levand <geoff@infradead.org>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, Joshua
 Washington <joshwash@google.com>, Furong Xu <0x1207@gmail.com>, "Russell
 King (Oracle)" <rmk+kernel@armlinux.org.uk>, Jisheng Zhang
 <jszhang@kernel.org>, Petr Tesarik <petr@tesarici.cz>,
 netdev@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Richard Cochran
 <richardcochran@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Shannon Nelson <shannon.nelson@amd.com>, Ziwei Xiao <ziweixiao@google.com>,
 Shailend Chand <shailend@google.com>, Choong Yong Liang
 <yong.liang.choong@linux.intel.com>, Andrew Halaney <ahalaney@redhat.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: ethtool: Adjust exactly ETH_GSTRING_LEN-long stats
 to use memcpy
Message-ID: <20250416110351.1dbb7173@kmaincent-XPS-13-7390>
In-Reply-To: <20250416010210.work.904-kees@kernel.org>
References: <20250416010210.work.904-kees@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdehleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedupdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiiv
 ghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghlrghuughiuhdrmhgrnhhoihhlsehngihprdgtohhmpdhrtghpthhtohepvhhlrgguihhmihhrrdholhhtvggrnhesnhigphdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 15 Apr 2025 18:02:15 -0700
Kees Cook <kees@kernel.org> wrote:

> Many drivers populate the stats buffer using C-String based APIs (e.g.
> ethtool_sprintf() and ethtool_puts()), usually when building up the
> list of stats individually (i.e. with a for() loop). This, however,
> requires that the source strings be populated in such a way as to have
> a terminating NUL byte in the source.
>=20
> Other drivers populate the stats buffer directly using one big memcpy()
> of an entire array of strings. No NUL termination is needed here, as the
> bytes are being directly passed through. Yet others will build up the
> stats buffer individually, but also use memcpy(). This, too, does not
> need NUL termination of the source strings.
>=20
> However, there are cases where the strings that populate the
> source stats strings are exactly ETH_GSTRING_LEN long, and GCC
> 15's -Wunterminated-string-initialization option complains that the
> trailing NUL byte has been truncated. This situation is fine only if the
> driver is using the memcpy() approach. If the C-String APIs are used,
> the destination string name will have its final byte truncated by the
> required trailing NUL byte applied by the C-string API.
>=20
> For drivers that are already using memcpy() but have initializers that
> truncate the NUL terminator, mark their source strings as __nonstring to
> silence the GCC warnings.

Shouldn't we move on to ethtool_cpy in these drivers too to unify the code?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

