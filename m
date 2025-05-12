Return-Path: <netdev+bounces-189684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC00AB32F3
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE46189A9D7
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA434194AD5;
	Mon, 12 May 2025 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="ZlIdfLxS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gC+JfBBh"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F57625B1CD
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041603; cv=none; b=RCVSLza/+LKSica6X5MjgFxWS0iZg8KGFmHEL6QDDjlxxtxWqX1utCphEZJtCUf5R8jL0PcWexEVit07wTOjPT9POb/v2n39tuAsfLTD+y6lqcdvegZsjmeTqayWk2N3mN/6UtofUuTWgofjvo8N5jOMtuUgZGfv0owqlESN4hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041603; c=relaxed/simple;
	bh=GBhgHqrvViVItNSIQEoeSOvD4ftqVLJv6mNeNunEfWw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Fi7hVNEKwAo59qYR9ru/KPEzGaI/8uTBi7KqzL+MtaJUjVVVjhBQ61Tyn6NoiutJhcShzX/KyboNujWt3haz+5CtAc2GK+hi65rE2LF+w9JxjNTdxgeHbHkVsMW3xxRgXKmsO1DrVNuX584qNscjcpkS8rVdlZ7M4u5PqszBGEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=ZlIdfLxS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gC+JfBBh; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id B863D1140140;
	Mon, 12 May 2025 05:19:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 12 May 2025 05:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1747041599; x=1747127999; bh=CvYftXw5Tvqsw6wj/SE2OeAjW3pvHmb7
	FcABR9pzR58=; b=ZlIdfLxSfKr8puq0NNc3lnleVFsjmAwtV8DAFKc0wzDBGd8D
	yo8hUkd92PRUQpp8AIpO/aabCPuaaM5wjjR1Lq0ggmQY43zbQyUgWyRCHXbyCScd
	yBuEH5p2WXAT8ZGfWL9lS/qwvGYotH0PL5v8IfQssRHvND80udKtYT8B2mytvh3g
	N+ZVuq9XMrhLnvdipTlj3644xV/Ku7lDvviIFHp7hNve/0Q1elynoM+hkTW+nPEi
	4m5ozbCLVf18dgENTWI2/m6KlHpA1xhNfcmLP9GGOpBTCBzx812d3og+aHjx0Tp7
	gDqtDChuEWv1eNxq4fxYYnOl+1eQ16zOouJFrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747041599; x=
	1747127999; bh=CvYftXw5Tvqsw6wj/SE2OeAjW3pvHmb7FcABR9pzR58=; b=g
	C+JfBBhxTe6yOGUy7VeGf1n+GGsYWg9xmxJ9T1YMVGtu9seWnU85k7fjWRxIywFx
	44ozjZSH0gUmIcQqf0qsDcfMLlRUXjZlU9os3aYjnRU76fkH/0TIy4k3XWcLVX4P
	MVCBFt+ZImS2rKGe/WX/96C3dq+bjhDIecOeuxxJmGtZ0cTI1XQiZeiBPZVw5pWm
	0YRpR+yqS5Ffiz6cBMXIXSO8Dy/ijrHvjF6wXxd58O862PT7dpUIe4F0UwPSq7kM
	pumEp6k25rLL0WR2FCa3p5LMGjnn0Xra/AnovkreIV9u3HcB2wpntKTGrLEoFXVa
	OkgGM2pkUmGV9uewEafbA==
X-ME-Sender: <xms:P70haB7vUHd9AfojuSRFQgNH6WDyZYT3vA924NiyRcSCGlcDHNBA8g>
    <xme:P70haO7f6D9Ta8k5Ug7wM2j9EaXiZ0mPALZK1_a2lM4XmD3l1GmJbINxWVaqIpeh9
    oanudK6w-olf5xQbns>
X-ME-Received: <xmr:P70haIeEHzrvWWKcQBRCxI7bjtVOJBAhWWvT26OgkCjloDV9HR59RLncMwPKDhByNM04vOiD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tdejnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhepheelteehfeeukeejudetvefgueeuleejieeh
    teefkedvkedufefhgeekfefhueejnecuffhomhgrihhnpehmohguvgdrshhonecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvsehjvhhoshgs
    uhhrghhhrdhnvghtpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepthhonhhghhgrohessggrmhgrihgtlhhouhgurdgtohhmpdhrtghpthht
    ohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgrii
    gvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnh
    gurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheprghnughrvgifsehl
    uhhnnhdrtghhpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:P70haKIj1JMhoDBlYivXu-ZbLxgjFibOnrbLhkvY3jQLpUide0Bq-Q>
    <xmx:P70haFJ88hqWx5TT53Y5C2b04p9Z6FBeYX7vS9I2cNTRot2F-lFysg>
    <xmx:P70haDw3b42qNN8gaGL7_q683ZeuD500BzrDVyTDtRnN_Be3P4rIyQ>
    <xmx:P70haBL-54nQIjLt3nkUBo9aQLIuGGCF0e67Z2filJ6GU6toxwtFgw>
    <xmx:P70haGCZOgVXIS4p6t_1rFZXUODak-6VwzfKUwHsFy_p0EQpjPDOiZ9D>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 05:19:58 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id E10471C0465; Mon, 12 May 2025 02:19:54 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id DEC8A1C0464;
	Mon, 12 May 2025 11:19:54 +0200 (CEST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Tonghao Zhang <tonghao@bamaicloud.com>
cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 1/4] net: bonding: add broadcast_neighbor option for 802.3ad
In-reply-to: <B43CC0DC-286B-44FF-8FA8-1B1BC0C990BF@bamaicloud.com>
References: <20250510044504.52618-1-tonghao@bamaicloud.com> <20250510044504.52618-2-tonghao@bamaicloud.com> <1133230.1746881077@vermin> <CE4DB782-91EB-4DBD-9C26-CA4C4612D58C@bamaicloud.com> <ea87b2d2-9b17-4f16-9e40-fe7212f2788d@lunn.ch> <B43CC0DC-286B-44FF-8FA8-1B1BC0C990BF@bamaicloud.com>
Comments: In-reply-to Tonghao Zhang <tonghao@bamaicloud.com>
   message dated "Mon, 12 May 2025 10:25:16 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 May 2025 11:19:54 +0200
Message-ID: <1278464.1747041594@vermin>

Tonghao Zhang <tonghao@bamaicloud.com> wrote:

>> 2025=E5=B9=B45=E6=9C=8811=E6=97=A5 =E4=B8=8B=E5=8D=8811:53=EF=BC=8CAndre=
w Lunn <andrew@lunn.ch> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>>> static inline bool bond_should_broadcast_neighbor(struct bonding *bond,
>>>                                                  struct sk_buff *skb)
>>> {
>>>        if (!bond->params.broadcast_neighbor ||
>>>            BOND_MODE(bond) !=3D BOND_MODE_8023AD)
>>>                return false;
>>=20
>> I think you missed the point. You have added these two tests to every
>> packet on the fast path. And it is very likely to return false. Is
>> bond.params.broadcast_neighbor likely to be in the cache? A cache miss
>> is expensive. Is bond.params.mode also likely to be in cache? You
>> placed broadcast_neighbor at the end of params, so it is unlikely to
>> be in the same cache line as bond.params.mode. So two cache misses.
>>=20
>> What Jay would like is that the cost on the fast path is ~0 for when
>> this feature is not in use. Jump labels can achieve this. It inserts
>> either a NOP or a jump instruction, which costs nearly nothing, and
>> then uses self modifying code to swap between a NOP or a jump. You can
>> keep a global view of is any bond is using this new mode? If no, this
>No, no mode uses jump labels instead of bond.params checking.

	The suggestion here is to use a jump label (static branch) to
essentially eliminate the overhead of the options test for the common case
for most users, which is with broadcast_neighbor disabled.

	As described below, the static branch would be tracked
separately from the per-bond option.

>> test is eliminated. If yes, you do the test.
>I test the lacp mode with broadcast_neighbor enabled, there is no performa=
nce drop. This patch has been running in our production environment for a l=
ong time. We only use this option in lacp mode, for performance, the code c=
an be modified as follows:

	How did you test this?  The performance under discussion here is
that branches in the packet transmit path can affect overall packet
transmission rates at very high rates (think in terms of small packet
rates at 40 Gb/sec and higher).  Bonding already has a significant
number of TX path branches, and we should be working to reduce that
number, not increase it.

>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_ma=
in.c
>index ce31445e85b6..8743bf007b7e 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -5330,11 +5330,12 @@ static struct slave *bond_xdp_xmit_3ad_xor_slave_g=
et(struct bonding *bond,
>        return slaves->arr[hash % count];
> }
>
>-static inline bool bond_should_broadcast_neighbor(struct bonding *bond,
>-                                                 struct sk_buff *skb)
>+static inline bool bond_should_broadcast_neighbor(struct sk_buff *skb,
>+                                                 struct net_device *dev)
> {
>-       if (!bond->params.broadcast_neighbor ||
>-           BOND_MODE(bond) !=3D BOND_MODE_8023AD)
>+       struct bonding *bond =3D netdev_priv(dev);
>+
>+       if (!bond->params.broadcast_neighbor)
>                return false;

	Using a static branch, the above would be preceded by something
like:

	if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
		return false;

	With additional logic in the options code that enables and
disables broadcast_neighbor that will increment or decrement (via
static_branch_inc / _dec) bond_bcast_neigh_enabled as the
broadcast_neighbor option is enabled or disabled.  The static branch
becomes a fast way to ask "is any bond in the system using
broadcast_neighbor" at very low cost.

	As Andrew helpfully pointed out, netfilter makes extensive use
of these; I'd suggest looking at the usage of something like
nft_trace_enabled as an example of what we're referring to.

	-J

>        if (skb->protocol =3D=3D htons(ETH_P_ARP))
>@@ -5408,9 +5409,6 @@ static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff =
*skb,
>        struct bond_up_slave *slaves;
>        struct slave *slave;
>
>-       if (bond_should_broadcast_neighbor(bond, skb))
>-               return bond_xmit_broadcast(skb, dev);
>-
>        slaves =3D rcu_dereference(bond->usable_slaves);
>        slave =3D bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
>        if (likely(slave))
>@@ -5625,6 +5623,9 @@ static netdev_tx_t __bond_start_xmit(struct sk_buff =
*skb, struct net_device *dev
>        case BOND_MODE_ACTIVEBACKUP:
>                return bond_xmit_activebackup(skb, dev);
>        case BOND_MODE_8023AD:
>+               if (bond_should_broadcast_neighbor(skb, dev))
>+                       return bond_xmit_broadcast(skb, dev);
>+               fallthrough;
>        case BOND_MODE_XOR:
>                return bond_3ad_xor_xmit(skb, dev);
>        case BOND_MODE_BROADCAST:
>>=20
>> 	Andrew

---
	-Jay Vosburgh, jv@jvosburgh.net

