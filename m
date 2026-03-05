Return-Path: <netdev+bounces-264542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGiKHbbuqWkBIQEAu9opvQ
	(envelope-from <netdev+bounces-264542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:59:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB5F2185AF
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28CC730804DD
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 20:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D31734844C;
	Thu,  5 Mar 2026 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="X0kSa3lg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="34hUGAwn"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2D2F1FE4;
	Thu,  5 Mar 2026 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772744355; cv=none; b=SEC/zsM3wiVrgSRQ2l+Fk68tYy46Gfxmi3PYc4vthdEdpXVuq3c4KR7nGMSsIXcTd3En2MK0rq1LThbAWV1IA3dzoDJx7mai4+KaZPbfzzuzOKPZwSQvtw3RvOcKPjnMfs6X1+Bc4WKUVPga8SjPBmdTc49T63bqQZBvYFku6ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772744355; c=relaxed/simple;
	bh=6IVix00z9EdNlGw/WT7RRubw9kMatkjDqVKBuva5bEs=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=CW4l2iY1c05pfs2KUjC14pmPDar+OT15eK/elvEAbA+teeHIMwoB1HlDEn9XCdGvxfO2ZpsttfbDBSOsKHOvI0WwNxxe/htSRqEW69nwjkXmr+Ls+N7CPP1rEJoaleDyUdjOqBbp516VBXnyL+7m1mK74Er4pSEE/abGB7qXSI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=X0kSa3lg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=34hUGAwn; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 94BF01D00125;
	Thu,  5 Mar 2026 15:59:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 05 Mar 2026 15:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1772744352; x=1772830752; bh=J7QXco/i5BBMP/veHf0Vgy3zY/Tn161n
	DkiE45qpcdM=; b=X0kSa3lgjSNUIPLLxbhhhpUOgU7d8dUNgxkgxDo5fvXsTdcU
	YTHCdHBkPQsA/5MbcU6PAnKlAjt3dcLyemSD2TKuLIoPJB2vhlidjhNp0Q90lBeF
	WnWcYE/icT5usv3cNR8sWgYe886/ZoHbnF8ONaJiCKwDnrawYEYtd0mnaZBaW5S0
	9ANyokAAq2U8FPpu+foDQWmvmpBJnQfGH2itfhSpjbazWTLaPL/Lkb19Oue9JytJ
	iG7MyduOHp03o8E97Mmx7mjqHiAptvCXE9xNWav6RVf0dlZjy5GoUXNXdlm4FRw0
	AWH86azgyyHxHwFpM8/tkRNPF/ak8NcOYQXatA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772744352; x=
	1772830752; bh=J7QXco/i5BBMP/veHf0Vgy3zY/Tn161nDkiE45qpcdM=; b=3
	4hUGAwnrL4ksQn737kFqsk9i9iL/x/gwJoBlGv40wOO1ikfd+1hiMkvj7liOipyh
	cKL2pKo/y848BcRv+2yF9c5OYh1WgxT6Kc3ew2eWza8BKRyZKy0tuXx/yV0gqi9f
	B/Y25jaNveNSnrQbDlaKKcF/R4Di9WTbg+p//rpaqr4Soi0cx6AhvNUD5xmsBI9T
	WxzzI3hJiM1y8rN1IfnJd0LuBKKEvravGGkkM7Z9i+2G7f6SJwhM3rFVEGfHFwJn
	dKlGvrveem1hwD/RMqr8EfvDGEybPU2ADwPaQBWuVC6YszP+2O76sUWAJP95o6iI
	McIWwBywSyZShYvVlu4Qg==
X-ME-Sender: <xms:m-6paYgjvfIE1OORShBiPPgir9H-Z4SGMVtKlgfifaJtKYfFa3V5WA>
    <xme:m-6paaXAwd1PVL9EOFXHnZ9x1c9o33nudeSI4hvZ9g8c9fk0FL6lcQ-tAsCk-5mCt
    kpOyFFoBQarQGNQ0rCnz1C0BpR-wBKt4na15Ki29e9zlqetXG3pYVg>
X-ME-Received: <xmr:m-6paXUTJZPuX5O_TNHAeGp7rDViiXKQeftfbv-K8WQnjzWabWlMvEGsffi2hhxdtqp1qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertdejnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepteelgfekhfekudetkeffgeehhfeggfekvddvvdeitdfgfeevueetteegteejgfev
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgs
    pghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgvfhhfse
    hgrghriihikhdrohhrghdprhgtphhtthhopehkohhtrgdrthhouggrsehgmhhoqdgthigs
    vghrshgvtghurhhithihrdgtohhmpdhrtghpthhtohephihukhhirdhkohhikhgvsehgmh
    hoqdgthigsvghrshgvtghurhhithihrdgtohhmpdhrtghpthhtohepjhhirgihuhgrnhdr
    tghhvghnsehlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:m-6paaiFUOvEuDye9iJwFV-HUHOefTq-GwL4bKtQgFo8__NDDlo43A>
    <xmx:m-6paSZPRn6--sSk46nZQxfE7TVtA21C3GsTs1zYVRrABZh8fZdB0w>
    <xmx:m-6paXrb4dhBkPcdb0PhJcRjkiiX87oReG43WAZHtCrHttV0mnRmLg>
    <xmx:m-6pafPqFU-bgydXr5NtgnY8iwU6gsQI37X-WatFQyDikCE_njdyAQ>
    <xmx:oO6paV1wM98rUO4IMya0b3-KxF6rZuUUlDnq_fqkZQ7rxYk40LOGMHuy>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 15:59:06 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id D9A459FCB4; Thu,  5 Mar 2026 12:59:05 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id D8ADF9FC39;
	Thu,  5 Mar 2026 12:59:05 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Kota Toda <kota.toda@gmo-cybersecurity.com>
cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Yuki Koike <yuki.koike@gmo-cybersecurity.com>,
    Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH v4 0/2] net: bonding: fix type-confusion in bonding header_ops
In-reply-to: <20260305110751.167489-1-kota.toda@gmo-cybersecurity.com>
References: <20260305110751.167489-1-kota.toda@gmo-cybersecurity.com>
Comments: In-reply-to Kota Toda <kota.toda@gmo-cybersecurity.com>
   message dated "Thu, 05 Mar 2026 20:07:47 +0900."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Mar 2026 12:59:05 -0800
Message-ID: <1356396.1772744345@famine>
X-Rspamd-Queue-Id: CAB5F2185AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264542-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,gmo-cybersecurity.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Kota Toda <kota.toda@gmo-cybersecurity.com> wrote:

>In bond_setup_by_slave(), the slave=E2=80=99s header_ops are unconditional=
ly
>copied into the bonding device. As a result, the bonding device may invoke
>the slave-specific header operations on itself, causing
>netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpreted
>as the slave's private-data type.
>
>This type-confusion bug can lead to out-of-bounds writes into the skb,
>resulting in memory corruption.

	A few days ago, Jiayuan Chen <jiayuan.chen@linux.dev> posted a
fix for what sounds like the same problem[0].  Their solution appears to
be much less complicated.

	I also wonder how this bug was discovered.  The code in question
hasn't changed in many years, and now there are two independent fixes
within a week.

[0] https://lore.kernel.org/netdev/20260228095854.391093-1-jiayuan.chen@lin=
ux.dev/

>Patch 1 stores the slave's header_ops in struct bonding and sets
>wrapper callbacks in bond_In bond_setup_by_slave(), the slave=E2=80=99s
>header_ops are unconditionally
>copied into the bonding device. As a result, the bonding device may invoke
>the slave-specific header operations on itself, causing
>netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpreted
>as the slave's private-data type.
>
>Patch 2 uses READ_ONCE when loading header_ops callbacks
>to avoid races with concurrent updates.

	With the READ_ONCE changes in a separate patch, does that mean
that patch 1 by itself is subject to race conditions that would result
in errors?  If so, that's not acceptable, every patch must stand alone
and not break the kernel.

	-J

>Fixes: 1284cd3a2b74 ("bonding: two small fixes for IPoIB support")
>Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
>Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
>Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
>
>Kota Toda (2):
>  net: bonding: fix type-confusion in bonding header_ops
>  net: add READ_ONCE for header_ops callbacks
>
> drivers/net/bonding/bond_main.c | 67 ++++++++++++++++++++++++++++++++-
> include/linux/netdevice.h       | 41 ++++++++++++++------
> include/net/bonding.h           |  5 +++
> include/net/cfg802154.h         |  2 +-
> net/core/neighbour.c            |  6 +--
> net/ipv4/arp.c                  |  2 +-
> net/ipv6/ndisc.c                |  2 +-
> 7 files changed, 106 insertions(+), 19 deletions(-)
>
>--=20
>2.53.0
>
>

---
	-Jay Vosburgh, jv@jvosburgh.net


