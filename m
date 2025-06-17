Return-Path: <netdev+bounces-198395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90564ADBF14
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 04:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAE4188DDCC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 02:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9142F2116F6;
	Tue, 17 Jun 2025 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="vdulkUl7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b2pIhJiS"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECBB2BF013;
	Tue, 17 Jun 2025 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750126879; cv=none; b=lKduiUqsM/qzyQqOywwe4j41nWO7SdP9HSUu0wTnvbCWsp39PtyuI/m/oFJFo5+vnn0uF24KJ3A3EEpcFxFpHhqjudXF/H3KQ7HGDWK2lbhI9Q7tvnFcAcEJyxmFzqwJ/wWLOw/Ebt/IhRUYddPLisEngN3a5b8TDddvcEbukpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750126879; c=relaxed/simple;
	bh=Q81PrULg4YylW+JLRnn/4+wlqHB0Tb3Mgl9k2hluRGQ=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=UF/P1RejhaFJjaBjjgjFqqPahQcFFOv6fGXQpzZisimCgdAEsH8mMXURCPdvXrJSat1ul3M1hMrmXwqI81Ufi3zBu9VJwEixnL2jfUkCbFhOC6Kvl6lQJfU7lVu8rgXLe1R4W5xGt+7IbVxVC2Uycy05ISZkzvWV1GJgbQLOxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=vdulkUl7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b2pIhJiS; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C09F25400D0;
	Mon, 16 Jun 2025 22:21:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 16 Jun 2025 22:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1750126875; x=1750213275; bh=ssJWCxY6yo3tMAjHQQQVH
	PjDYP1jdpM6tCoODuP2YO8=; b=vdulkUl7WCCGKF3F9vC0y3AjFhhOPxhHIuFvH
	hnjgzT/awf++MpCBmaww5BYe4+lNusE/09qhyUSfG1a4v7wVAVK52pFrzy+xkeVf
	oOed1E7SklbLjS+Igl3RV1VGB1Wc7u/yt32cq/1kSqZweQF8Jv/QFPpIajkIDGsy
	Lq7p8i3oo0rc31hop6KepFTsbNbSN0FLg68/zeKcvLl7pStGZCDuG3CNdsfuVQWz
	Kd/dUu2qw1fI9rpav4CW6nUQoHv3+kSW0KQijL91AGrFxHvc5Pl3jKWcmWmvLPnL
	jbs6xRA38f0b8hqjRDeh5hmPnjlpwcWD+/KkTFpDKAY53Ljwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750126875; x=1750213275; bh=ssJWCxY6yo3tMAjHQQQVHPjDYP1jdpM6tCo
	ODuP2YO8=; b=b2pIhJiS08HNzSWZoG+sorH8cZHoaMeuvT4CvTtu/uj53AGAc+w
	vqZh2wwuXloTp7R4P2Ld+fqUkneqsnN1ChAFELlS2D05dZqhZAoNgI0HSnwWQsL+
	AYLiUYU2NtPczjryx59vVjLfS3OuFwgnvWfdI7wkx+YjcGsZEEElcUI2wpfch39L
	4+u0ePu6ZUfmGiDJAvb1tTtnNetOZ+FoC+PNqX1lnKxNdOkKc9NpRy+plgZLCF6u
	L4W5oV87H1j1/ufAymjmifkHaNImIYzxl0LYR7IcQ2LNFTcBbe0MEm2fLjVxlwaI
	GJT4MOaGRvjAq+ZWNP4eMKAGJJMQTnns2CA==
X-ME-Sender: <xms:GtFQaDn2TPD8de76bhemPv6KFdNaSW66hcHL1Q5hjKany3fEBLNFgw>
    <xme:GtFQaG0ofij3YoVZG1SIskXCBhJni2yGefwwXmMOn_8Cmg_fApDgLdqH4wfnIu4Y2
    dBUQYsW8fLHcsY929A>
X-ME-Received: <xmr:GtFQaJp85VdUof2v5ZaSm1aS65RXSNJtj1lxvULsmUo3nYcaheOTXGvU4V7FQeiaaYGUAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvkedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhfogggtgfffkfesthhqredtredt
    vdenucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrd
    hnvghtqeenucggtffrrghtthgvrhhnpeejvedukeevveeftdehuedujefgffettdekvdev
    gfeuuefhieduheeitefffefgleenucffohhmrghinhepshihiihkrghllhgvrhdrrghpph
    hsphhothdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsg
    gprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgv
    mhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehsughfsehfohhmihgthhgvvh
    drmhgvpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshhtfhhomhhitghhvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuh
    hmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegtohhrsggv
    theslhifnhdrnhgvth
X-ME-Proxy: <xmx:GtFQaLnVg0n3vX1Lnc7sPNc93_T-IneKsEfsEAzhcVghH77CsMs17g>
    <xmx:GtFQaB369W9nLAhf2M8R7rlDhSCVR4xLBbB-O9a9gboCPyGUoaC16Q>
    <xmx:GtFQaKsoFOQT17gJbgp_2zWZPhiMb5weCEzI4AaM-XyETx8X4S5oOQ>
    <xmx:GtFQaFWEYHPfa0xnQBOoJ7r75_PUOk5aZLs-R2AQkNHnIVxVMWqZqA>
    <xmx:G9FQaDHtU0jr_mreC9Pb-mpRdnudS3ESn_m3btn8e5bI5MQFguhomXdK>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 22:21:14 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id B79789FCA6; Mon, 16 Jun 2025 19:21:12 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id B361B9FC54;
	Mon, 16 Jun 2025 19:21:12 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Stanislav Fomichev <stfomichev@gmail.com>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Stanislav Fomichev <sdf@fomichev.me>,
    Hangbin Liu <liuhangbin@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: Remove support for use_carrier = 0
In-reply-to: <aFDAkS3VUgHwxxr6@mini-arch>
References: <1922517.1750109336@famine> <aFDAkS3VUgHwxxr6@mini-arch>
Comments: In-reply-to Stanislav Fomichev <stfomichev@gmail.com>
   message dated "Mon, 16 Jun 2025 18:10:41 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1934949.1750126872.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jun 2025 19:21:12 -0700
Message-ID: <1934950.1750126872@famine>

Stanislav Fomichev <stfomichev@gmail.com> wrote:

>On 06/16, Jay Vosburgh wrote:
>> 	 Remove the ability to disable use_carrier in bonding, and remove
>> all code related to the old link state check that utilizes ethtool or
>> ioctl to determine the link state of an interface in a bond.
>> =

>> 	To avoid acquiring RTNL many times per second, bonding's miimon
>> link monitor inspects link state under RCU, but not under RTNL.  Howeve=
r,
>> ethtool implementations in drivers may sleep, and therefore the ethtool=
 or
>> ioctl strategy is unsuitable for use with calls into driver ethtool
>> functions.
>> =

>> 	The use_carrier option was introduced in 2003, to provide
>> backwards compatibility for network device drivers that did not support
>> the then-new netif_carrier_ok/on/off system.  Today, device drivers are
>> expected to support netif_carrier_*, and the use_carrier backwards
>> compatibility logic is no longer necessary.
>> =

>> 	Bonding now always behaves as if use_carrier=3D1, which relies on
>> netif_carrier_ok() to determine the link state of interfaces.  This has
>> been the default setting for use_carrier since its introduction.  For
>> backwards compatibility, the option itself remains, but may only be set=
 to
>> 1, and queries will always return 1.
>> =

>> Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=3Db8c48ea38ca27d150063
>> Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.=
com/
>> Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9=
c9ded97163aef4e4de10985cd8f7de60d28@changeid/
>> Link: http://lore.kernel.org/netdev/aEt6LvBMwUMxmUyx@mini-arch
>> Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>
>
>Acked-by: Stanislav Fomichev <sdf@fomichev.me>
>
>Maybe better to target 'net' with the following?
>Fixes: f7a11cba0ed7 ("bonding: hold ops lock around get_link")

	I targeted net-next and left the Fixes: tag off on purpose.

	First, the bug this nominally fixes is many years old, and
wasn't introduced by f7a11cba0ed7.

	More importantly, though, this patch is removing functionality
that someone theoretically could be relying on, and I don't think such
removals should happen in the middle of a stable series.  The default
setting for use_carrier (i.e., using netif_carrier) will never hit the
issue in practice, so the exposure seems to be minimal for common use.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

