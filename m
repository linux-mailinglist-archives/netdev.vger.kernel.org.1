Return-Path: <netdev+bounces-261568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I8EACqqoGlGlgQAu9opvQ
	(envelope-from <netdev+bounces-261568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:16:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0ED1AEFAD
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00D2F3001814
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2062A44E031;
	Thu, 26 Feb 2026 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="ugkUzpo7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNjHst4Q"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C739280F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136999; cv=none; b=pcaLTKRn8w0zN6s5Yg1M/hwKU5hnuG4fjkGoKGQnu7kW5wJfzBQwbMd7LTGYccoJ+HPdvVoF9EvxFpxjw3b4HTondgLDKJdt4CLmrgolJ/QKnlhSV3qtzyqb5JNy3FxuvuvN0kj68r6a0tCMOjwktB6leePJCl3zwhVTcMuuvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136999; c=relaxed/simple;
	bh=Fi9Ai8JKWzJ7raQudfT62PlKQ0kIC6YVTanh/qV9xP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltSKWCYPNw627kmEHz6qvsgCPWMTIi2mNu/uCeqZwW2v4r6oLU3bvMY4BFlrhQJtuyr+PuIAzLdykFdlZvDUxL1R9KQJvZsKV84gM1dKmTz36rpVUOZsVr4b6YY4YPT4iGgFKZCQ1q6RCN/gH8wpJDTAcydwZRghlDaMOsohhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=ugkUzpo7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNjHst4Q; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 766471D000C0;
	Thu, 26 Feb 2026 15:16:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 26 Feb 2026 15:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1772136995; x=1772223395; bh=zB8IoujtT/GJR3Nv7VvVk
	xLt92Z2zMMjAcqpqP7/kso=; b=ugkUzpo7NosZsic2a5Nae+i/B9MB2Vif60Mxb
	dtBfxQQXzqPYJ2OGEAiYvjJsE7ggP4eRnrYLeNevvFAwHk8O/htts87u7qGakZHb
	OqW2iTd9E7SIFrwgdDBSQqjtS2WlRcUMZ5p+G8fysOrBfA/yfOMTGpvbLGgogULF
	EvVkUOFnBaei2lRsBfGomnWC46DO7gclnylEzXlsU7r85a6IltHv5NSOXpjZuILe
	dYGZfMgG9kfpMu5SDKnqE/PN6FyVZ3u8vvzhTz8uW+J8QY8zl7UxbQ52HzUcmynG
	3Q4h6mSb/UGz7kJrTvoYcoJqsPhLAVVcvWsdn4zfeYys5xO4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772136995; x=1772223395; bh=zB8IoujtT/GJR3Nv7VvVkxLt92Z2zMMjAcq
	pqP7/kso=; b=LNjHst4QJ7j28eQukajmAzK0TTNpqdEA0XdjSmFj6KNL7g4bsiz
	AV4HwKLD9fNaUDimiQF+g7wwIB56w9sFfROBb2jMb3ktTq0mz3aQFkY0Bq0bIcHx
	JJ+Rlgiu3CMHdSPcqQqKCOIytYLsxZXZoG4VZVcnzxs717xSWEyUDyzF9LKi6yYf
	g+QLtSsEK+DZe8AZvhOrpLX1+I1BdZsXmIs2jeyx7/dIdIToowdPGIbcS/55i9jR
	rKZnMtXDHaEkNsMCgMryML42ywwVZ6ZKF5/w99ZleGLvk8lQVnCnLb4DmehKh+7c
	oDibmYf/MI2v3lpIrEQRMLPn3NFffMDRbcw==
X-ME-Sender: <xms:IqqgaR4IRv6lH4orQ1K7OWPks3D_f1wZ5n1SgX1s67AKYztwPZ8NzA>
    <xme:IqqgafXbbuJhE9ZS-4C7mfarFd5DKRQ_tTdcl7zZMGK3OxFiCtxtjcx6tW2GFo8q1
    Y3qkrDzidwm0ZWCeaJk1SPiuHq3e23wzn-q4pgtNpxaoM9a2m_ia3A>
X-ME-Received: <xmr:IqqgaYM1kZ-etw6k9Q7kQCokkASwJhAjqBnGCmeml28jdtwkpCCN1ubc0UuFXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlihgtvgcuofhi
    khhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimh
    eqnecuggftrfgrthhtvghrnhepheduiedvieefffduueelgeehuefhleekuefffeeiheeu
    hfetjedtvefffefgfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvrdhkvghr
    nhgvlhesfhgrshhtmhgrihhlrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdp
    rhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvg
    guuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtph
    htthhopehluhgtihgvnhdrgihinhesghhmrghilhdrtghomhdprhgtphhtthhopeifihhl
    lhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgriihorhessghl
    rggtkhifrghllhdrohhrgh
X-ME-Proxy: <xmx:IqqgaWhKPaw1-aw7bzYulW9QQI3-CwKkTinW-1KDzbu1Nuyz07g-5w>
    <xmx:Iqqgae4ofUk5O9C5IhwcBGq29rp_aNfZXc5g8kO3-6wdSQis8iewrQ>
    <xmx:IqqgadegK5DxF7ihHxjQTb_rkg8-Q-KfFDs3C3larF7LWNSYs-3R-Q>
    <xmx:IqqgaXAtmmHuqOPRVOmoBT6TuLpKk5Co9pAspM79meYLGkNLhFRSFg>
    <xmx:I6qgaXS6xo2Y4RVR2OLjpWrS9O_uN-wuf56FLyCF7ruaYN0qa6KTP-Rp>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 15:16:33 -0500 (EST)
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
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v2 00/12] BIG TCP for UDP tunnels
Date: Thu, 26 Feb 2026 22:15:48 +0200
Message-ID: <20260226201600.222044-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-261568-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,fastmail.im:mid,fastmail.im:dkim]
X-Rspamd-Queue-Id: 0F0ED1AEFAD
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
IPv6 BIG TCP doesn't require stripping the HBH in all various
combinations in tunneled traffic, adding BIG TCP becomes feasible.

Patches 01-03 are small fixups to some related code that I'm changing in
the series.

Patch 04 adds accessors for the length field in the UDP header, as
suggested by Paolo in review. The usage of udp_set_len is then added in
the following patches that start using length=0 in BIG TCP UDP packets.

Patches 05-07 close the gaps that prevent BIG TCP packets from going
through UDP tunnel code.

Patch 08 re-adds proper validation of malformed packets that arrive with
length=0 from the wire.

Patch 09 is for proper formatting in tcpdump (set UDP len to 0 rather
than a trimmed value on overflow).

Patches 10-11 bump up tso_max_size for VXLAN and GENEVE.

Patch 12 adds selftests.

Thanks all!

v2 changes: Addressed the review comments: added UDP len helpers,
consolidated UDP len sanity checks in patch 08 into one, added
selftests. Added fixups to related code (patch 01-03).

v1: https://lore.kernel.org/netdev/20250923134742.1399800-1-maxtram95@gmail.com/

Alice Mikityanska (11):
  net/sched: act_csum: don't mangle UDP tunnel GSO packets
  udp: gso: Simplify handling length in GSO_PARTIAL
  geneve: Fix off-by-one comparing with GRO_LEGACY_MAX_SIZE
  net: Use helpers to get/set UDP len tree-wide
  net: Enable BIG TCP with partial GSO
  udp: Support gro_ipv4_max_size > 65536
  udp: Support BIG TCP GSO packets where they can occur
  udp: Validate UDP length in udp_gro_receive
  udp: Set length in UDP header to 0 for big GSO packets
  vxlan: Enable BIG TCP packets
  selftests: net: Add a test for BIG TCP in UDP tunnels

Daniel Borkmann (1):
  geneve: Enable BIG TCP packets

 drivers/infiniband/core/lag.c                 |   2 +-
 drivers/infiniband/sw/rxe/rxe_net.c           |   4 +-
 drivers/net/amt.c                             |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   2 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +-
 .../ethernet/mellanox/mlx5/core/en_selftest.c |   2 +-
 drivers/net/ethernet/sfc/falcon/selftest.c    |   4 +-
 drivers/net/ethernet/sfc/selftest.c           |   4 +-
 drivers/net/ethernet/sfc/siena/selftest.c     |   4 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c   |   2 +-
 .../stmicro/stmmac/stmmac_selftests.c         |   4 +-
 drivers/net/geneve.c                          |   6 +-
 drivers/net/netdevsim/dev.c                   |   2 +-
 drivers/net/netdevsim/psample.c               |   2 +-
 drivers/net/netdevsim/psp.c                   |   8 +-
 drivers/net/vxlan/vxlan_core.c                |   2 +
 drivers/net/wireguard/receive.c               |   2 +-
 include/linux/udp.h                           |  16 ++
 include/net/udplite.h                         |   4 +-
 include/trace/events/icmp.h                   |   2 +-
 lib/tests/blackhole_dev_kunit.c               |   2 +-
 net/6lowpan/nhc_udp.c                         |  10 +-
 net/core/netpoll.c                            |   2 +-
 net/core/pktgen.c                             |   4 +-
 net/core/selftests.c                          |   4 +-
 net/core/skbuff.c                             |  10 +-
 net/core/tso.c                                |   3 +-
 net/ipv4/esp4.c                               |   2 +-
 net/ipv4/fou_core.c                           |   2 +-
 net/ipv4/ipconfig.c                           |   6 +-
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c   |   4 +-
 net/ipv4/route.c                              |   2 +-
 net/ipv4/udp.c                                |   8 +-
 net/ipv4/udp_offload.c                        |  58 +++----
 net/ipv4/udp_tunnel_core.c                    |   2 +-
 net/ipv6/esp6.c                               |   5 +-
 net/ipv6/fou6.c                               |   2 +-
 net/ipv6/ip6_udp_tunnel.c                     |   2 +-
 net/ipv6/udp.c                                |   3 +-
 net/ipv6/udp_offload.c                        |   2 +-
 net/l2tp/l2tp_core.c                          |   2 +-
 net/netfilter/ipvs/ip_vs_xmit.c               |   2 +-
 net/netfilter/nf_conntrack_proto_udp.c        |  19 ++-
 net/netfilter/nf_log_syslog.c                 |   2 +-
 net/netfilter/nf_nat_helper.c                 |   2 +-
 net/psp/psp_main.c                            |   2 +-
 net/sched/act_csum.c                          |  12 +-
 net/xfrm/xfrm_nat_keepalive.c                 |   2 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/big_tcp_tunnels.sh  | 145 ++++++++++++++++++
 54 files changed, 298 insertions(+), 114 deletions(-)
 create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh

-- 
2.52.0


