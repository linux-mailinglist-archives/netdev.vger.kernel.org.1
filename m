Return-Path: <netdev+bounces-255982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKT/FNT5gGn9DQMAu9opvQ
	(envelope-from <netdev+bounces-255982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:24:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A9ED07B9
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C87043006D4C
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3C3033E7;
	Mon,  2 Feb 2026 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="nMzJTE/J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZMW3Yo/H"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1A2F532C
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060235; cv=none; b=UmHYDsL3EZ7kbaEFAP7HU4RSrht3G6dt318OYaLc2bj/gLQrE7DOxaNf/xyZjl0+kq3zb6BcQs6LTT+4KLJVuIcC46qBcg/9fOAhiqZT+j5SmPnnGF+XCXL62+aDBgrA50gNBuzWt1rA/WzUfaqEgNfNeIBcqyb3GRYQvyFxBno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060235; c=relaxed/simple;
	bh=1CubTHJtWQ0eoEidlF1hHQ7H2Jqsewp+jlernkllfFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SC7BVqnCsBoLogfp/tEqCZ2ElU/u4s8EiFTjsb4D3VNNba3676p0TOegQettszLPQXaVn/mzLC4trc7rkLJZq8pamET3AeTHmxW7ax41qvXPFMZlyMfXMCwU4VyJ4mfMhRhTUTInx5XK/FB+E8d5pzoxHguLxEZxej6BLqvhmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=nMzJTE/J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZMW3Yo/H; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 409867A00BC;
	Mon,  2 Feb 2026 14:23:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 02 Feb 2026 14:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1770060232; x=1770146632; bh=YMyzNMcuC84Yx4ErI/dze
	E5d2fl3GgQbQtamLy4lGpo=; b=nMzJTE/JpOaizcPM0zFm2hCrZa/zX++lbeYI7
	On/KAgIIYk1gp/YSZkP+SDDextBmlE/3xpC/Lv1v/+eFWqCQTs3aFKeTx6VVxZ0U
	pcljybmL5Rm7AeDcjPXb7utNAtzZ4UdA/HT6kNDtyxB7LDK7sb2/RjBXeu5YNCJy
	51oDythRIFW1BywXTMLi/C2lFeJBfLU4jYDD0usg/sq28K1j+VFjzVhjCuPWXhiR
	clU+ZBb9iKlbAhS2FiHu9DDyytuf3uu61vQCwWRHCZ1tuuxcyvOs0zGflgUZxYAW
	dFRn4gbxtEnPf9RhUz7ujiVF2go7X9IXL7d0L5UZaXkD+frXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770060232; x=1770146632; bh=YMyzNMcuC84Yx4ErI/dzeE5d2fl3GgQbQta
	mLy4lGpo=; b=ZMW3Yo/HgMchurPJqg7ZCQOW1F7Fl/qWMULJbeHcm3FDU7w0lh1
	eSMtAyYUQNrlZJMEuJu8XSLKtXdOMs3ixpUZ+mAfmvs8726quRQSG9rzCPBBlVwQ
	MkyBS9elTD28ahwyXIDbDaH36l7OtG+IWOnVnXx7GHJ9/cZTkukdT0w9ifoPKmoM
	1Yunos+og95IF1n3sMrhwROxvsfk6bYVUQU8EkMdSUVv3VEY2D1zUrWW/icJzDFh
	d+ZKkvma6CV9Di/NBp3xSUYJDZc+MatqRPAgRzGuVzfyenjn2kNkwhLKfbQXXPlU
	rOWibw22MD19jNwgh0lZ6FwDEPbF/TkMLdg==
X-ME-Sender: <xms:x_mAaberEy1xD3eMlR-WoKFz0MRJgvoJ7IEkirEpdF4MiEcYuwfmuw>
    <xme:x_mAaXkFxS4HHg-pfuZ7a4xzzM-uWbBkerNETujJTHX1L4IVExG4uUW1URPNTuK_n
    p-3orIKI5EWui8SJmdd5OgKdjz-ktmnuBty1C4QpJLO3Y_8rukVGKc>
X-ME-Received: <xmr:x_mAaQwsSmMUiNSAz5W5U64jn5tp4IXIa-sHMetCRrIo7FwM1MgQyuDYi5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlihgtvgcuofhi
    khhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepjeeuffeghfehtdelgfethfeifeehffdtffeiheeh
    jeeileevgfejjeejudejtdfgnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdrihhmpdhnsggprh
    gtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnhhivghl
    sehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnih
    esrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:x_mAaawopVIDo1MXYGmWPMopkQDlESJOvJ924tUvIfQg3XhKSnebuw>
    <xmx:x_mAaQXkVtJ5OsM7YNRSJtEG0MQ2kUhzWJD9j7OdW4MOP-ZnD1XUag>
    <xmx:x_mAaRTgIThh_DNFfTjZTQV--V9Eclzi9LoNKYGhXWBW_S6d-2qVtw>
    <xmx:x_mAaYRDHLohV5DYjyDgiKCiXd6QemTpi47g_eblhfpETa5WWGYdYg>
    <xmx:yPmAaSpCT5F4eaSWotKiLDaIvtXK1YIHDI-tMv7ZVdn44HWc_18H8nF2>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:23:51 -0500 (EST)
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
Subject: [PATCH net-next v3 00/11] BIG TCP without HBH in IPv6
Date: Mon,  2 Feb 2026 21:23:27 +0200
Message-ID: <20260202192338.2373930-1-alice.projects@fastmail.im>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-255982-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.projects@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,isovalent.com:email]
X-Rspamd-Queue-Id: 29A9ED07B9
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Resubmitting as the tcpdump patches have been merged:

https://github.com/the-tcpdump-group/tcpdump/pull/1329

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

v3 changes:

No code changes. Added Paolo's ACK.

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


