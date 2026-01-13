Return-Path: <netdev+bounces-249589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6672D1B63E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE4B03010A96
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4A1322A1C;
	Tue, 13 Jan 2026 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="MStrIQVv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xvngtpP2"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F3318BA7
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339661; cv=none; b=QgLJXKcSgl4C5hsNtnnfmMVG/uerdVkqMFETRQlm5vA/jhU0KtPZsISj4c0+ebpQFW/Cb3WLH0lbGoeh6TDfrrsivYF6n1+7XskB/ueD4OpGY5OhFHlDQYta6a7IxwUL7QCNBedohu6FFFFiGUMRX8x6/VUk7kPSAkoTLv4UtaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339661; c=relaxed/simple;
	bh=ojTvZy0HkHtSfVQML96IjVdqRsNyXVW2drICdNmWADU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vD4j0yajRzVUwzQbihJBQDx2OuFH7Dql8Pkt/wkKhSt80t5e5jtcM/6BAdAjTPxN+o2LySgY0Hr9UPX4QwFrUe+xQvLIItpTj9rwuSJuap9fzwLSeghY5i/+Z8mGyFKyBGgYrJ3pOQUfJlqtiEHKWWz8175xlWJfLrtxbB8JNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=MStrIQVv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xvngtpP2; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8BEE414000F3;
	Tue, 13 Jan 2026 16:27:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 13 Jan 2026 16:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1768339657; x=1768426057; bh=6gUZN8luKw9aR1VSCda7f
	5OAif1GhDXV2jVULQWlWtU=; b=MStrIQVvncv1DqKoGEVf+kiJy+IMch1qcTadB
	5HXbqLSYK5nPMr09MR6nzMuULhKQOzw6BiPl12QWxjY7+hMJqyGGLivrsJ03uI7i
	ylUSTFxm9UsJXpogDrSUD7dQvAyItHioPnnOVq8zQ4BAWmU53bHaPHP7wnNKk+OO
	DMIdZNENT11n6kH7KJGXLHMTC+5JW2Zd7g2+etIzWCzVVOELJTLCNKL593ogPoxs
	fgdyJptE11rqNLnJNYGWfCRWwLcZgFQ2lxVBxq1wbNvsY9SxGoIDtwYj4Hq4XkDo
	obp9Pj6lBkCNgIaacv96/GWMiZ4oBg2DH2YVm8Aa+BvYcLWpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768339657; x=1768426057; bh=6gUZN8luKw9aR1VSCda7f5OAif1GhDXV2jV
	ULQWlWtU=; b=xvngtpP2nJwn/q7VbDepVPhFVHWcASmwAkQ5EF+FOm+Y0n7E5Ia
	ocSDb7QnNJkZfprXvnD3k41f0kdIIVv6PDOR0YVIbVb58RxGtBgxd7Mvqj7WtwQ4
	zQNf4CaKQrWNXUGT99R1V1Xlz93IH9NF0UFK64RkEEgOSSNFzEro8AiHysXPSYvc
	iZM2pmE1IsszC/b631Eikvo7ydjliyucK1Y4mMAFVuH/GAyPNTjyud42nvcXnzRN
	3hgPY55x5tN+xG08uILMBcg0SuJbyrj1xfqyLV9+Ofe3OU8qjQxneHmq8ypCOg+/
	732QB8VmQLHiu/8uQ2eKF6Iok0k90OdVYng==
X-ME-Sender: <xms:yLhmaYIWPLrCDxABBJJQVZ9nAVBUTQCuHvnik23V4k6BXpjmOvqqsA>
    <xme:yLhmaejfEBayZW_9DP6YrOUPu_ZYthnD_iQQqJh7guJaMXp0i1v7fQOljKMbmkrVe
    XmSOQBHTj3ntaORl9ffl9KtvCt1JqZv6Tjkkc_OdCU7auLJ-MV2OQ>
X-ME-Received: <xmr:yLhmaU_nKaVLdYQtnxHSAR3WVECzV7xx89Wbs06dc-Afh75mW-WezZv1p-WOLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlihgtvgcuofhi
    khhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimh
    eqnecuggftrfgrthhtvghrnhepheduiedvieefffduueelgeehuefhleekuefffeeiheeu
    hfetjedtvefffefgfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvrdhkvghr
    nhgvlhesfhgrshhtmhgrihhlrdhimhdpnhgspghrtghpthhtohepudefpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdp
    rhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvg
    guuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtph
    htthhopehluhgtihgvnhdrgihinhesghhmrghilhdrtghomhdprhgtphhtthhopeifihhl
    lhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgriihorhessghl
    rggtkhifrghllhdrohhrgh
X-ME-Proxy: <xmx:yLhmaTMW6hy6z_xQi8n3zARry_rOlh-iaaWb5aEEfVvat3H0TUvSEQ>
    <xmx:yLhmaYBQi-lbra0_Ncd6tq3G8LdDp7AnqkiT29Y-yvrH6Z61bdcp-Q>
    <xmx:yLhmaXOSTt6MYh8_GugEj3Oy24HliIDqDilkLVzeqi0BADj8Yjz6Xw>
    <xmx:yLhmafeP-XRrfHIsF_Qrjh0EjkEOWc--1WmWqE0a0vyH-9I9l8tNDA>
    <xmx:ybhmafM8x7eOWCi5Yjc8qbM1rk-sv_2JiM4rSA4dV-BIumAWKU4AdbHN>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:27:36 -0500 (EST)
From: Alice Mikityanska <alice.kernel@fastmail.im>
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
Subject: [PATCH net-next v2 00/11] BIG TCP without HBH in IPv6
Date: Tue, 13 Jan 2026 23:26:44 +0200
Message-ID: <20260113212655.116122-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

This series is part 1 of v2 of "BIG TCP for UDP tunnels". Due to the
number of patches, I'm splitting it into two logical parts:

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

v2 changes:

Split the series into two parts. Address the review comments in part 2
(details follow with part 2).

P.S. Author had her name changed since v1; it's the same person.

Alice Mikityanska (11):
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
  net/ipv6: Remove HBH helpers

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
 21 files changed, 59 insertions(+), 279 deletions(-)

-- 
2.52.0


