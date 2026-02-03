Return-Path: <netdev+bounces-256196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIcPDzm5gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:00:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9537FD681E
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D64FA300AB1D
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34032C08A1;
	Tue,  3 Feb 2026 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="rqunfW2+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RHLBUtrt"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC32B2417FB
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109232; cv=none; b=SoKvoRfycwBzn1pPzg5nLr8nGWT0bcx2RihtJP5agX15QVk7nIDRlr9OvEBSOx6SS19Ifc86an6lfV5sxnOo4hiy+akUOwAGjOwTtX7/It5DGpjJ81OActURAra94n+iOVC7PMQvEaZwaLTKvE44S2WdcLGAdU8q6ZURVe6WStM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109232; c=relaxed/simple;
	bh=BU7cxOcatOZ3gmxCPTf0VRIsvMkQHqV5v0thXZ274sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uo4hoFiUZ92+0FFWc41pocd1Zm+ePlO+KOC8M2XgMr+Hm7cpJVnuVo3Z+W4C8abjT6SAr1taHmbk2rH/FvpHnANuLGTN+ViCLdZk50HSga0EtyA0Qc4pjTaKuFXwD9sz+/gNOXeQee2ZsMiut2Z1/GN86eQnJLzIqbLKgQwcCCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=rqunfW2+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RHLBUtrt; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 598707A013E;
	Tue,  3 Feb 2026 04:00:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 03 Feb 2026 04:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1770109228; x=1770195628; bh=W/3AGGzBL2zZmqTIwkhwP
	UHp6jZlKZykncblraQwHnw=; b=rqunfW2+GWJW0d6OxTHJ0IBpouVv2iSbMK6hh
	0XukRsK6CZI6YeJs1CVJcAdjSdqIzQycPZzWWZcDDr+fmetCmYghqezDzR8BFbw0
	WjxRmIiGDE54wAJRRZHkrNpZAZaxBjU+QTI7+6jl+3FeDjV6gfdrfTuGQYtejOk+
	h0vKq5rPiFlfpJ4sMOqgO6WFWvF9d9MhkTpomSPWKaXWsO54jL5OT53BxQNQCOtb
	8wJIHNS9lTc8c9MtSkvx8GU5teMEe3Orh5pnJulVUNah8cFdsxx7lKX02yUDpCQ4
	MJI1yWRp/dnioTNTuYxHd5YrToXuQ/GRm7RCdIh8UpP8uXM7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770109228; x=1770195628; bh=W/3AGGzBL2zZmqTIwkhwPUHp6jZlKZykncb
	lraQwHnw=; b=RHLBUtrtvvDVIGVrrFsFRvToyFadb5mBOQCzAz8tjt3XTMYZyuQ
	f+bkhFELmUuLXYCght463BmRe4owuLCkU2iCFljnX5qdJKSkbhyfQCt81+TXTAL2
	MpMp8/x5uky2NpFJPHTMD4MEEqfmFFQtt+ybsusVZOTGlQ5dUBSpmfmW9sEV2DYn
	BCCD2WXjEn45P3ueJc2cW6XnqPEM4cvGCCDNIlvK/mOFtqd/NSQQLzGGgN2hBbnR
	1kkZLB7HjeBXYy22lC0lysVpH5s2lt6akgG/jHfPUTnz2Yqta5GoeiVwejN9GleC
	05Nf6JaGV1lxXH13RcS4nw/lBABNDzDxNQA==
X-ME-Sender: <xms:K7mBaQFd1SvmmttMXwel-OAdkcroKPOsZGpig4LGIWgKZGRDoGdSqg>
    <xme:K7mBafv9vUiM0qOgK4JmW4WTRB6w7qLMBEdfrVeq0sCounUnXfc9LlXF5jXeTzB_5
    AwV1UC-S6GwLbWIirtI6QSG7fpor8BaTZRyW3IvAboL021ZIwveUQ>
X-ME-Received: <xmr:K7mBaWbHaPU8y0RfsoAyFxj4L6QkNmrBKPwN_isUv_leDQGYh2TAaev3q_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlihgtvgcuofhi
    khhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepvdfgieehjeehgefhvdekffeggfekuefggfehteef
    teeifeegvddvkeelvedtffefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdrihhmpdhnsggprh
    gtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnhhivghl
    sehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnih
    esrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:K7mBaf4pOExKwUIYo6hspxkOJCe095X3MloJ1OQaiAVwET1IUZICTg>
    <xmx:K7mBae8ftnyVioCaCOcc6rpfsRRkPvTNRrBo-lqRGrVPzEiSB8nIGw>
    <xmx:K7mBabaeOnpyH4LbCFUegzzKb3zXdESv-eYXjyijUY0WuYMfOviFug>
    <xmx:K7mBaX76QlPcBr1Rodfoe8gG1et_vjrsHkEJ1MW7VfmsMHBuYAQnOw>
    <xmx:LLmBadqONsq1rAxD-_OO727Znv7KHnZgjVU19rm_Q7V7f_Bs_hyvfnps>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 04:00:26 -0500 (EST)
From: Alice Mikityanska <alice.projects@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v4 00/12] BIG TCP without HBH in IPv6
Date: Tue,  3 Feb 2026 10:59:30 +0200
Message-ID: <20260203085942.2477583-1-alice.projects@fastmail.im>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256196-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	RSPAMD_URIBL_FAIL(0.00)[isovalent.com:query timed out];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.projects@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fastmail.im:mid,fastmail.im:dkim]
X-Rspamd-Queue-Id: 9537FD681E
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Resubmitting to add one more patch for bng_en. No other changes in code.

This series is part 1 of "BIG TCP for UDP tunnels". Due to the number of
patches, I'm splitting it into two logical parts:

* Remove hop-by-hop header for BIG TCP IPv6 to align with BIG TCP IPv4.
* Fix up things that prevent BIG TCP from working with UDP tunnels.

The current BIG TCP IPv6 code inserts a hop-by-hop extension header with
32-bit length of the packet. When the packet is encapsulated, and either
the outer or the inner protocol is IPv6, or both are IPv6, there will be
1 or 2 HBH headers that need to be dealt with. The issues that arise:

1. The drivers don't strip it, and they'd all need to know the structure
of each tunnel protocol in order to strip it correctly, also taking into
account all combinations of IPv4/IPv6 inner/outer protocols.

2. Even if (1) is implemented, it would be an additional performance
penalty per aggregated packet.

3. The skb_gso_validate_network_len check is skipped in
ip6_finish_output_gso when IP6SKB_FAKEJUMBO is set, but it seems that it
would make sense to do the actual validation, just taking into account
the length of the HBH header. When the support for tunnels is added, it
becomes trickier, because there may be one or two HBH headers, depending
on whether it's IPv6 in IPv6 or not.

At the same time, having an HBH header to store the 32-bit length is not
strictly necessary, as BIG TCP IPv4 doesn't do anything like this and
just restores the length from skb->len. The same thing can be done for
BIG TCP IPv6. Removing HBH from BIG TCP would allow to simplify the
implementation significantly, and align it with BIG TCP IPv4, which has
been a long-standing goal.

v1: https://lore.kernel.org/netdev/20250923134742.1399800-1-maxtram95@gmail.com/

v2: https://lore.kernel.org/netdev/20260113212655.116122-1-alice.kernel@fastmail.im/

v2 changes:

Split the series into two parts. Address the review comments in part 2
(details follow with part 2).

v3: https://lore.kernel.org/netdev/20260202192338.2373930-1-alice.projects@fastmail.im/

v3 changes:

No code changes. Added Paolo's ACK. Tcpdump patches have been merged and
unblocked the series:

https://github.com/the-tcpdump-group/tcpdump/pull/1329

v4 changes:

Added one more patch for bng_en, because it started using
ipv6_hopopt_jumbo_remove in the meanwhile. Added Eric's Reviewed-by.

Alice Mikityanska (12):
  net/ipv6: Introduce payload_len helpers
  net/ipv6: Drop HBH for BIG TCP on TX side
  net/ipv6: Drop HBH for BIG TCP on RX side
  net/ipv6: Remove jumbo_remove step from TX path
  net/mlx5e: Remove jumbo_remove step from TX path
  net/mlx4: Remove jumbo_remove step from TX path
  ice: Remove jumbo_remove step from TX path
  bnxt_en: Remove jumbo_remove step from TX path
  gve: Remove jumbo_remove step from TX path
  net: mana: Remove jumbo_remove step from TX path
  bng_en: Remove jumbo_remove step from TX path
  net/ipv6: Remove HBH helpers

 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |  3 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 -----
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |  3 -
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  3 -
 drivers/net/ethernet/mellanox/mlx4/en_tx.c    | 42 ++--------
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 75 +++---------------
 drivers/net/ethernet/microsoft/mana/mana_en.c |  3 -
 include/linux/ipv6.h                          | 21 ++++-
 include/net/ipv6.h                            | 79 -------------------
 include/net/netfilter/nf_tables_ipv6.h        |  4 +-
 net/bridge/br_netfilter_ipv6.c                |  2 +-
 net/bridge/netfilter/nf_conntrack_bridge.c    |  4 +-
 net/core/dev.c                                |  6 +-
 net/core/gro.c                                |  2 -
 net/ipv6/ip6_input.c                          |  2 +-
 net/ipv6/ip6_offload.c                        | 36 +--------
 net/ipv6/ip6_output.c                         | 20 +----
 net/ipv6/output_core.c                        |  7 +-
 net/netfilter/ipvs/ip_vs_xmit.c               |  2 +-
 net/netfilter/nf_conntrack_ovs.c              |  2 +-
 net/netfilter/nf_log_syslog.c                 |  2 +-
 net/sched/sch_cake.c                          |  2 +-
 22 files changed, 59 insertions(+), 282 deletions(-)

-- 
2.52.0


