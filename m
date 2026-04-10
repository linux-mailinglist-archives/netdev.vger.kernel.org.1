Return-Path: <netdev+bounces-277446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMkvL2sU2Wm7lwgAu9opvQ
	(envelope-from <netdev+bounces-277446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:16:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E46943D9127
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13DBE308D6CE
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E2C3D75D4;
	Fri, 10 Apr 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="kBITS53B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XuOFLMND"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B63D9031
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833819; cv=none; b=kUCNKxlbU6WBgSDi5MPsCYGKwvip7I0jPs3nqfADSDjVmm4lKQwkHzpjnvi83d7M4dHwebLObhYyY9gnJnXD8H5JpEvYjORXIDu3FAtsFJw60IFcOtyAXBJzEQ/J8nq1UVcpXU4q0nAYeyTs+n0yDupRLhcNHq7IC1lIXH3noQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833819; c=relaxed/simple;
	bh=0LxZZ0iRaDtMnTHXM/H951Iu2PgIUnCq+5pEAp0d1kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCtMp0p7DCSjCFprqg5MH4JQT3Jx9mWG8PNcStGgl8C3FYX/hZEb1gm1I1FkfOTOq6XzPfyV5F4cuzKf/jFNpMuE//fF34WyGVOhl93W8EpiWWfBiYYgil5NgaISq8Y6eAv+DgAG36XtGPzkvAhHML82S33Z2qZ/MYEAyAaA+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=kBITS53B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XuOFLMND; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C84EFEC0441;
	Fri, 10 Apr 2026 11:10:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 10 Apr 2026 11:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775833814; x=
	1775920214; bh=vL9XmsrfodAShoWkEymDLTb1J/jx4FcdLbKrX8NPX6k=; b=k
	BITS53B30zbEKBJgxM6OQmsHqlLS8lHcJ1n5oPsFYIU9/L/m2cFfxmRervtJHE+Q
	rnwr/zxUGGPWZnl/g3WLSwQVqxFaTdUfUh10dmqrEe3KGdkN9hmVzukzQchTWHV1
	1rpkemLA+AjwwjvLBY2CPI9m9uqI7Q6nqT/vqfoYHEovk3MyaxU9fi77wL9a7OlL
	oBsT6Prl0+2jsg1GkE9evSitvw3vt6eT+rt7qfEJMel+3Uw4p+GCy/mMWgaELnQj
	H4wmDEVH6UBmPE/XkgDCHUXaQuroFMvY8LE768sxM/XrgLp0tBy0Is+bxO8vBI7z
	7NVzfm7+v72I9Gn/iaR7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775833814; x=1775920214; bh=v
	L9XmsrfodAShoWkEymDLTb1J/jx4FcdLbKrX8NPX6k=; b=XuOFLMNDbkQNUgeec
	mP/e3WnlNYwH9ayRkvuTTMu0CuGDll9OmtIsLA9JhCWhrj21MWtS2Jg0hU0WIaMq
	1NSqQxVREafb4faQZQ15SAC6/Ee2Syy/Zxc3BfqeRF1dZ4pKzEtY8GRBiN4r9BWN
	4/4uVliFeNWV1v5gIAO7clcwToI9PzrHoa6Vwo1dL+jSy0MfQuto8puv44n2ioS2
	qkxqmbzC/gLH8SQLrCanGnpw6gBh2VE50t7IurPAXgaw5fPInBjdFPfcDAbYN+hD
	OnjL0DcjK7RctarFqPjH/npOMvfLT+613YM0vWMa0Zl6RvAnCS2bPo5v+GHF9iAn
	hXMvQ==
X-ME-Sender: <xms:1hLZafA560OnOMD7_hVwkvTi2-VzY8lGYPJDXxLqKNcPR9c-uxjnew>
    <xme:1hLZaV--H_7bzwNnGisn2zLBSjzxDfg6W7RA_tHwbteFZK5XX9gIJUV7Pq5YHxSpI
    yglGAUJ1W0c8fdXbUGHKAYsTDUh_EZvl_1wQlN9FKhzw9nlSovoCws>
X-ME-Received: <xmr:1hLZaaXYBPsK3NWSJLaWc9eaPPMBbw25VgzepwOwXy7tKK-5FeN0FQI5js-faw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhitggvucfo
    ihhkihhthigrnhhskhgruceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrih
    hmqeenucggtffrrghtthgvrhhnpeetffeljeefvdfhheeijeelgfekleejveeugeegveet
    hffguefhudffgeekvddttdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimhdpnhgs
    pghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnih
    gvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehluhgtihgvnhdrgihinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrgh
X-ME-Proxy: <xmx:1hLZaeJLYmCpVJ3Ap77qXpiLttDJX83VtlemB4k4VmnzZ5iqXfeE9Q>
    <xmx:1hLZaeBlCmWE6Z0tPoTCz8bvG_LFSOTggFx9o3E-tDqaRnUFo85GHQ>
    <xmx:1hLZaeH_JztPkv7FXfGLqowQmugF8TbhFvaaQm_G2yoxsiBXZuGhuw>
    <xmx:1hLZabKgqTVlBDK0oaBuMmjtx3IL1cmFmyBdOQ1T_8G0c9tr2rpxjg>
    <xmx:1hLZaVb5LvatUgz4UD6OTteijXt82gU98ly4baZJ0SnStKKI0q96jm6E>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 11:10:13 -0400 (EDT)
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
Subject: [PATCH net-next v3 04/12] net: Use helpers to get/set UDP len tree-wide
Date: Fri, 10 Apr 2026 18:09:35 +0300
Message-ID: <20260410150943.993350-5-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410150943.993350-1-alice.kernel@fastmail.im>
References: <20260410150943.993350-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-277446-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email,fastmail.im:dkim,fastmail.im:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: E46943D9127
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alice Mikityanska <alice@isovalent.com>

Since BIG TCP for UDP tunnels will start using len=0 in the UDP header
as an indicator of a GSO packet bigger than 65535 bytes, this commit
introduces the following getter and setters to use tree-wide, in order
to explicitly mark places where len=0 may be expected, and handle them
properly:

1. udp_get_len_short() returns len in host byte order: to be used on the
RX side to deal with non-aggregated packets, or to access the raw value
of the len field.

2. udp_set_len() sets uh->len to its real value if it's not bigger than
65535, and to 0 otherwise: to be used in GSO context with aggregated
packets.

3. udp_set_len_short() is to be used when the length is known to fit 16
bits. It WARNs when the caller tries to assign a bigger value if
CONFIG_DEBUG_NET=y.

At the moment udp_set_len() is not used, a following commit will start
using it after enabling len>65535 for GSO.

Raw uh->len (in network byte order) is still accessed in a few places
for checksum calculation purposes, and in __udp6_lib_rcv and nsim_do_psp
to decode len=0 (__udp4_lib_rcv will be modified to parse len=0 in the
corresponding commit).

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 drivers/infiniband/core/lag.c                 |  2 +-
 drivers/infiniband/sw/rxe/rxe_net.c           |  4 +-
 drivers/net/amt.c                             |  6 +--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |  2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  2 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +-
 .../ethernet/mellanox/mlx5/core/en_selftest.c |  2 +-
 drivers/net/ethernet/sfc/falcon/selftest.c    |  4 +-
 drivers/net/ethernet/sfc/selftest.c           |  4 +-
 drivers/net/ethernet/sfc/siena/selftest.c     |  4 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c   |  2 +-
 .../stmicro/stmmac/stmmac_selftests.c         |  4 +-
 drivers/net/geneve.c                          |  2 +-
 drivers/net/netdevsim/dev.c                   |  2 +-
 drivers/net/netdevsim/psample.c               |  2 +-
 drivers/net/netdevsim/psp.c                   |  8 ++--
 drivers/net/wireguard/receive.c               |  2 +-
 include/linux/udp.h                           | 16 ++++++++
 include/trace/events/icmp.h                   |  2 +-
 lib/tests/blackhole_dev_kunit.c               |  2 +-
 net/6lowpan/nhc_udp.c                         | 10 ++---
 net/core/netpoll.c                            |  2 +-
 net/core/pktgen.c                             |  4 +-
 net/core/selftests.c                          |  4 +-
 net/core/tso.c                                |  3 +-
 net/ipv4/esp4.c                               |  2 +-
 net/ipv4/fou_core.c                           |  2 +-
 net/ipv4/ipconfig.c                           |  6 +--
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c   |  4 +-
 net/ipv4/route.c                              |  2 +-
 net/ipv4/udp.c                                |  3 +-
 net/ipv4/udp_offload.c                        | 37 +++++++++----------
 net/ipv4/udp_tunnel_core.c                    |  2 +-
 net/ipv6/esp6.c                               |  5 ++-
 net/ipv6/fou6.c                               |  2 +-
 net/ipv6/ip6_udp_tunnel.c                     |  2 +-
 net/ipv6/udp.c                                |  3 +-
 net/ipv6/udp_offload.c                        |  2 +-
 net/l2tp/l2tp_core.c                          |  2 +-
 net/netfilter/ipvs/ip_vs_xmit.c               |  2 +-
 net/netfilter/nf_conntrack_proto_udp.c        | 17 +++++++--
 net/netfilter/nf_log_syslog.c                 |  2 +-
 net/netfilter/nf_nat_helper.c                 |  2 +-
 net/psp/psp_main.c                            |  2 +-
 net/sched/act_csum.c                          |  4 +-
 net/xfrm/xfrm_nat_keepalive.c                 |  2 +-
 49 files changed, 121 insertions(+), 89 deletions(-)

diff --git a/drivers/infiniband/core/lag.c b/drivers/infiniband/core/lag.c
index 8fd80adfe833..00fe241737ff 100644
--- a/drivers/infiniband/core/lag.c
+++ b/drivers/infiniband/core/lag.c
@@ -36,7 +36,7 @@ static struct sk_buff *rdma_build_skb(struct net_device *netdev,
 	uh->source =
 		htons(rdma_flow_label_to_udp_sport(ah_attr->grh.flow_label));
 	uh->dest = htons(ROCE_V2_UDP_DPORT);
-	uh->len = htons(sizeof(struct udphdr));
+	udp_set_len_short(uh, sizeof(struct udphdr));
 
 	if (is_ipv4) {
 		skb_push(skb, sizeof(struct iphdr));
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index cbc646a30003..e9fbfa6af3ba 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -237,7 +237,7 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	pkt->port_num = 1;
 	pkt->hdr = (u8 *)(udph + 1);
 	pkt->mask = RXE_GRH_MASK;
-	pkt->paylen = be16_to_cpu(udph->len) - sizeof(*udph);
+	pkt->paylen = udp_get_len_short(udph) - sizeof(*udph);
 
 	/* remove udp header */
 	skb_pull(skb, sizeof(struct udphdr));
@@ -300,7 +300,7 @@ static void prepare_udp_hdr(struct sk_buff *skb, __be16 src_port,
 
 	udph->dest = dst_port;
 	udph->source = src_port;
-	udph->len = htons(skb->len);
+	udp_set_len_short(udph, skb->len);
 	udph->check = 0;
 }
 
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index f2f3139e38a5..01511eca7d84 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -667,7 +667,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 	udph		= udp_hdr(skb);
 	udph->source	= amt->gw_port;
 	udph->dest	= amt->relay_port;
-	udph->len	= htons(sizeof(*udph) + sizeof(*amtd));
+	udp_set_len_short(udph, sizeof(*udph) + sizeof(*amtd));
 	udph->check	= 0;
 	offset = skb_transport_offset(skb);
 	skb->csum = skb_checksum(skb, offset, skb->len - offset, 0);
@@ -758,7 +758,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	udph		= udp_hdr(skb);
 	udph->source	= amt->gw_port;
 	udph->dest	= amt->relay_port;
-	udph->len	= htons(sizeof(*amtrh) + sizeof(*udph));
+	udp_set_len_short(udph, sizeof(*amtrh) + sizeof(*udph));
 	udph->check	= 0;
 	offset = skb_transport_offset(skb);
 	skb->csum = skb_checksum(skb, offset, skb->len - offset, 0);
@@ -2608,7 +2608,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 	udph		= udp_hdr(skb);
 	udph->source	= amt->relay_port;
 	udph->dest	= dport;
-	udph->len	= htons(sizeof(*amta) + sizeof(*udph));
+	udp_set_len_short(udph, sizeof(*amta) + sizeof(*udph));
 	udph->check	= 0;
 	offset = skb_transport_offset(skb);
 	skb->csum = skb_checksum(skb, offset, skb->len - offset, 0);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 894f2d06d39d..ef5e657816f0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3129,7 +3129,7 @@ static int i40e_tso(struct i40e_tx_buffer *first, u8 *hdr_len,
 					 SKB_GSO_UDP_TUNNEL_CSUM)) {
 		if (!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL) &&
 		    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM)) {
-			l4.udp->len = 0;
+			udp_set_len_short(l4.udp, 0);
 
 			/* determine offset of outer transport header */
 			l4_offset = l4.hdr - skb->data;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 363c42bf3dcf..c30abf17cf5d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1774,7 +1774,7 @@ static int iavf_tso(struct iavf_tx_buffer *first, u8 *hdr_len,
 					 SKB_GSO_UDP_TUNNEL_CSUM)) {
 		if (!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL) &&
 		    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM)) {
-			l4.udp->len = 0;
+			udp_set_len_short(l4.udp, 0);
 
 			/* determine offset of outer transport header */
 			l4_offset = l4.hdr - skb->data;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index a2cd4cf37734..bb74e9f567ec 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1884,7 +1884,7 @@ int ice_tso(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 					 SKB_GSO_UDP_TUNNEL_CSUM)) {
 		if (!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL) &&
 		    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM)) {
-			l4.udp->len = 0;
+			udp_set_len_short(l4.udp, 0);
 
 			/* determine offset of outer transport header */
 			l4_start = (u8)(l4.hdr - skb->data);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index f6b3b15364ff..276296e321ed 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2871,7 +2871,7 @@ int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off)
 				     (__force __wsum)htonl(paylen));
 		/* compute length of segmentation header */
 		off->tso_hdr_len = sizeof(struct udphdr) + l4_start;
-		l4.udp->len = htons(shinfo->gso_size + sizeof(struct udphdr));
+		udp_set_len_short(l4.udp, shinfo->gso_size + sizeof(struct udphdr));
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 625bb5a05344..8d2d607bc92f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -750,7 +750,7 @@ static void otx2_sqe_add_ext(struct otx2_nic *pfvf, struct otx2_snd_queue *sq,
 				ext->lso_format = pfvf->hw.lso_udpv6_idx;
 			}
 
-			udph->len = htons(sizeof(struct udphdr));
+			udp_set_len_short(udph, sizeof(struct udphdr));
 		}
 	} else if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
 		ext->tstmp = 1;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 5b60aa47c75b..fdd5f35bac73 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1081,7 +1081,7 @@ static void mlx5e_shampo_update_ipv4_udp_hdr(struct mlx5e_rq *rq, struct iphdr *
 	struct udphdr *uh;
 
 	uh = (struct udphdr *)(skb->data + udp_off);
-	uh->len = htons(skb->len - udp_off);
+	udp_set_len_short(uh, skb->len - udp_off);
 
 	if (uh->check)
 		uh->check = ~udp_v4_check(skb->len - udp_off, ipv4->saddr,
@@ -1100,7 +1100,7 @@ static void mlx5e_shampo_update_ipv6_udp_hdr(struct mlx5e_rq *rq, struct ipv6hdr
 	struct udphdr *uh;
 
 	uh = (struct udphdr *)(skb->data + udp_off);
-	uh->len = htons(skb->len - udp_off);
+	udp_set_len_short(uh, skb->len - udp_off);
 
 	if (uh->check)
 		uh->check = ~udp_v6_check(skb->len - udp_off, &ipv6->saddr,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
index accc26d1a872..1dcdb86690bb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -113,7 +113,7 @@ static struct sk_buff *mlx5e_test_get_udp_skb(struct mlx5e_priv *priv)
 	/* Fill UDP header */
 	udph->source = htons(9);
 	udph->dest = htons(9); /* Discard Protocol */
-	udph->len = htons(sizeof(struct mlx5ehdr) + sizeof(struct udphdr));
+	udp_set_len_short(udph, sizeof(struct mlx5ehdr) + sizeof(struct udphdr));
 	udph->check = 0;
 
 	/* Fill IP header */
diff --git a/drivers/net/ethernet/sfc/falcon/selftest.c b/drivers/net/ethernet/sfc/falcon/selftest.c
index db4dd7fb77f5..4d29e0baf2eb 100644
--- a/drivers/net/ethernet/sfc/falcon/selftest.c
+++ b/drivers/net/ethernet/sfc/falcon/selftest.c
@@ -401,8 +401,8 @@ static void ef4_iterate_state(struct ef4_nic *efx)
 
 	/* Initialise udp header */
 	payload->udp.source = 0;
-	payload->udp.len = htons(sizeof(*payload) -
-				 offsetof(struct ef4_loopback_payload, udp));
+	udp_set_len_short(&payload->udp, sizeof(*payload) -
+			  offsetof(struct ef4_loopback_payload, udp));
 	payload->udp.check = 0;	/* checksum ignored */
 
 	/* Fill out payload */
diff --git a/drivers/net/ethernet/sfc/selftest.c b/drivers/net/ethernet/sfc/selftest.c
index 8ec76329237a..dc716feb79cb 100644
--- a/drivers/net/ethernet/sfc/selftest.c
+++ b/drivers/net/ethernet/sfc/selftest.c
@@ -398,8 +398,8 @@ static void efx_iterate_state(struct efx_nic *efx)
 
 	/* Initialise udp header */
 	payload->udp.source = 0;
-	payload->udp.len = htons(sizeof(*payload) -
-				 offsetof(struct efx_loopback_payload, udp));
+	udp_set_len_short(&payload->udp, sizeof(*payload) -
+			  offsetof(struct efx_loopback_payload, udp));
 	payload->udp.check = 0;	/* checksum ignored */
 
 	/* Fill out payload */
diff --git a/drivers/net/ethernet/sfc/siena/selftest.c b/drivers/net/ethernet/sfc/siena/selftest.c
index 930643612df5..c74cf5131364 100644
--- a/drivers/net/ethernet/sfc/siena/selftest.c
+++ b/drivers/net/ethernet/sfc/siena/selftest.c
@@ -399,8 +399,8 @@ static void efx_iterate_state(struct efx_nic *efx)
 
 	/* Initialise udp header */
 	payload->udp.source = 0;
-	payload->udp.len = htons(sizeof(*payload) -
-				 offsetof(struct efx_loopback_payload, udp));
+	udp_set_len_short(&payload->udp, sizeof(*payload) -
+			  offsetof(struct efx_loopback_payload, udp));
 	payload->udp.check = 0;	/* checksum ignored */
 
 	/* Fill out payload */
diff --git a/drivers/net/ethernet/sfc/tc_encap_actions.c b/drivers/net/ethernet/sfc/tc_encap_actions.c
index db222abef53b..c2ad3a358d20 100644
--- a/drivers/net/ethernet/sfc/tc_encap_actions.c
+++ b/drivers/net/ethernet/sfc/tc_encap_actions.c
@@ -311,7 +311,7 @@ static void efx_gen_tun_header_udp(struct efx_tc_encap_action *encap, u8 len)
 	encap->encap_hdr_len += sizeof(*udp);
 
 	udp->dest = key->tp_dst;
-	udp->len = cpu_to_be16(sizeof(*udp) + len);
+	udp_set_len_short(udp, sizeof(*udp) + len);
 }
 
 static void efx_gen_tun_header_vxlan(struct efx_tc_encap_action *encap)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index a0c75886587c..29e824bd90ca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -154,9 +154,9 @@ static struct sk_buff *stmmac_test_get_udp_skb(struct stmmac_priv *priv,
 	} else {
 		uhdr->source = htons(attr->sport);
 		uhdr->dest = htons(attr->dport);
-		uhdr->len = htons(sizeof(*shdr) + sizeof(*uhdr) + attr->size);
+		udp_set_len_short(uhdr, sizeof(*shdr) + sizeof(*uhdr) + attr->size);
 		if (attr->max_size)
-			uhdr->len = htons(attr->max_size -
+			udp_set_len_short(uhdr, attr->max_size -
 					  (sizeof(*ihdr) + sizeof(*ehdr)));
 		uhdr->check = 0;
 	}
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 84e8d6c69172..dc3a405e0e0c 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -630,7 +630,7 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 
 	/* Adjust the nested UDP header len and checksum. */
 	uh = udp_hdr(skb);
-	uh->len = htons(skb->len - gro_hint->nested_tp_offset);
+	udp_set_len_short(uh, skb->len - gro_hint->nested_tp_offset);
 	if (uh->check) {
 		len = skb->len - gro_hint->nested_nh_offset;
 		skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 1e06e781c835..1e0b50fdbf74 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -845,7 +845,7 @@ static struct sk_buff *nsim_dev_trap_skb_build(void)
 	udph = skb_put_zero(skb, sizeof(struct udphdr) + data_len);
 	get_random_bytes(&udph->source, sizeof(u16));
 	get_random_bytes(&udph->dest, sizeof(u16));
-	udph->len = htons(sizeof(struct udphdr) + data_len);
+	udp_set_len_short(udph, sizeof(struct udphdr) + data_len);
 
 	return skb;
 }
diff --git a/drivers/net/netdevsim/psample.c b/drivers/net/netdevsim/psample.c
index 717d157c3ae2..1e71c3da4def 100644
--- a/drivers/net/netdevsim/psample.c
+++ b/drivers/net/netdevsim/psample.c
@@ -73,7 +73,7 @@ static struct sk_buff *nsim_dev_psample_skb_build(void)
 	udph = skb_put_zero(skb, sizeof(struct udphdr) + data_len);
 	get_random_bytes(&udph->source, sizeof(u16));
 	get_random_bytes(&udph->dest, sizeof(u16));
-	udph->len = htons(sizeof(struct udphdr) + data_len);
+	udp_set_len_short(udph, sizeof(struct udphdr) + data_len);
 
 	return skb;
 }
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 0b4d717253b0..e81b69d6a577 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -84,6 +84,7 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		struct iphdr *iph;
 		struct udphdr *uh;
 		__wsum csum;
+		u16 udplen;
 
 		/* Do not decapsulate. Receive the skb with the udp and psp
 		 * headers still there as if this is a normal udp packet.
@@ -91,19 +92,20 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		 * provide a valid checksum here, so the skb isn't dropped.
 		 */
 		uh = udp_hdr(skb);
+		udplen = ntohs(uh->len) ?: skb->len;
 		csum = skb_checksum(skb, skb_transport_offset(skb),
-				    ntohs(uh->len), 0);
+				    udplen, 0);
 
 		switch (skb->protocol) {
 		case htons(ETH_P_IP):
 			iph = ip_hdr(skb);
-			uh->check = udp_v4_check(ntohs(uh->len), iph->saddr,
+			uh->check = udp_v4_check(udplen, iph->saddr,
 						 iph->daddr, csum);
 			break;
 #if IS_ENABLED(CONFIG_IPV6)
 		case htons(ETH_P_IPV6):
 			ip6h = ipv6_hdr(skb);
-			uh->check = udp_v6_check(ntohs(uh->len), &ip6h->saddr,
+			uh->check = udp_v6_check(udplen, &ip6h->saddr,
 						 &ip6h->daddr, csum);
 			break;
 #endif
diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
index eb8851113654..275fe1bc994c 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -62,7 +62,7 @@ static int prepare_skb_header(struct sk_buff *skb, struct wg_device *wg)
 		 * to have UDP fields.
 		 */
 		return -EINVAL;
-	data_len = ntohs(udp->len);
+	data_len = udp_get_len_short(udp); /* GRO not expected here. */
 	if (unlikely(data_len < sizeof(struct udphdr) ||
 		     data_len > skb->len - data_offset))
 		/* UDP packet is reporting too small of a size or lying about
diff --git a/include/linux/udp.h b/include/linux/udp.h
index ce56ebcee5cb..fe3abbec2cb5 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -23,6 +23,22 @@ static inline struct udphdr *udp_hdr(const struct sk_buff *skb)
 	return (struct udphdr *)skb_transport_header(skb);
 }
 
+static inline unsigned int udp_get_len_short(const struct udphdr *uh)
+{
+	return ntohs(uh->len);
+}
+
+static inline void udp_set_len(struct udphdr *uh, unsigned int len)
+{
+	uh->len = len < GRO_LEGACY_MAX_SIZE ? htons(len) : 0;
+}
+
+static inline void udp_set_len_short(struct udphdr *uh, unsigned int len)
+{
+	DEBUG_NET_WARN_ON_ONCE(len >= GRO_LEGACY_MAX_SIZE);
+	uh->len = htons(len);
+}
+
 #define UDP_HTABLE_SIZE_MIN_PERNET	128
 #define UDP_HTABLE_SIZE_MIN		(IS_ENABLED(CONFIG_BASE_SMALL) ? 128 : 256)
 #define UDP_HTABLE_SIZE_MAX		65536
diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
index 31559796949a..09ae115099df 100644
--- a/include/trace/events/icmp.h
+++ b/include/trace/events/icmp.h
@@ -44,7 +44,7 @@ TRACE_EVENT(icmp_send,
 			} else {
 				__entry->sport = ntohs(uh->source);
 				__entry->dport = ntohs(uh->dest);
-				__entry->ulen = ntohs(uh->len);
+				__entry->ulen = udp_get_len_short(uh);
 			}
 
 			p32 = (__be32 *) __entry->saddr;
diff --git a/lib/tests/blackhole_dev_kunit.c b/lib/tests/blackhole_dev_kunit.c
index 06834ab35f43..fa3e0533038d 100644
--- a/lib/tests/blackhole_dev_kunit.c
+++ b/lib/tests/blackhole_dev_kunit.c
@@ -46,7 +46,7 @@ static void test_blackholedev(struct kunit *test)
 	uh = (struct udphdr *)skb_push(skb, sizeof(struct udphdr));
 	skb_set_transport_header(skb, 0);
 	uh->source = uh->dest = htons(UDP_PORT);
-	uh->len = htons(data_len);
+	udp_set_len_short(uh, data_len);
 	uh->check = 0;
 	/* (Network) IPv6 */
 	ip6h = (struct ipv6hdr *)skb_push(skb, sizeof(struct ipv6hdr));
diff --git a/net/6lowpan/nhc_udp.c b/net/6lowpan/nhc_udp.c
index 0a506c77283d..ed4227e6db74 100644
--- a/net/6lowpan/nhc_udp.c
+++ b/net/6lowpan/nhc_udp.c
@@ -88,16 +88,16 @@ static int udp_uncompress(struct sk_buff *skb, size_t needed)
 	switch (lowpan_dev(skb->dev)->lltype) {
 	case LOWPAN_LLTYPE_IEEE802154:
 		if (lowpan_802154_cb(skb)->d_size)
-			uh.len = htons(lowpan_802154_cb(skb)->d_size -
-				       sizeof(struct ipv6hdr));
+			udp_set_len_short(&uh, lowpan_802154_cb(skb)->d_size -
+					  sizeof(struct ipv6hdr));
 		else
-			uh.len = htons(skb->len + sizeof(struct udphdr));
+			udp_set_len_short(&uh, skb->len + sizeof(struct udphdr));
 		break;
 	default:
-		uh.len = htons(skb->len + sizeof(struct udphdr));
+		udp_set_len_short(&uh, skb->len + sizeof(struct udphdr));
 		break;
 	}
-	pr_debug("uncompressed UDP length: src = %d", ntohs(uh.len));
+	pr_debug("uncompressed UDP length: src = %d", udp_get_len_short(&uh));
 
 	/* replace the compressed UDP head by the uncompressed UDP
 	 * header
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index cd74beffd209..b6ea6975b55b 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -474,7 +474,7 @@ static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
 	udph = udp_hdr(skb);
 	udph->source = htons(np->local_port);
 	udph->dest = htons(np->remote_port);
-	udph->len = htons(udp_len);
+	udp_set_len_short(udph, udp_len);
 
 	netpoll_udp_checksum(np, skb, len);
 }
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 8e185b318288..5b4dd04d6124 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3005,7 +3005,7 @@ static struct sk_buff *fill_packet_ipv4(struct net_device *odev,
 
 	udph->source = htons(pkt_dev->cur_udp_src);
 	udph->dest = htons(pkt_dev->cur_udp_dst);
-	udph->len = htons(datalen + 8);	/* DATA + udphdr */
+	udp_set_len_short(udph, datalen + 8);	/* DATA + udphdr */
 	udph->check = 0;
 
 	iph->ihl = 5;
@@ -3138,7 +3138,7 @@ static struct sk_buff *fill_packet_ipv6(struct net_device *odev,
 	udplen = datalen + sizeof(struct udphdr);
 	udph->source = htons(pkt_dev->cur_udp_src);
 	udph->dest = htons(pkt_dev->cur_udp_dst);
-	udph->len = htons(udplen);
+	udp_set_len_short(udph, udplen);
 	udph->check = 0;
 
 	*(__be32 *) iph = htonl(0x60000000);	/* Version + flow */
diff --git a/net/core/selftests.c b/net/core/selftests.c
index 0a203d3fb9dc..36b949ae520b 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -72,9 +72,9 @@ struct sk_buff *net_test_get_skb(struct net_device *ndev, u8 id,
 	} else {
 		uhdr->source = htons(attr->sport);
 		uhdr->dest = htons(attr->dport);
-		uhdr->len = htons(sizeof(*shdr) + sizeof(*uhdr) + attr->size);
+		udp_set_len_short(uhdr, sizeof(*shdr) + sizeof(*uhdr) + attr->size);
 		if (attr->max_size)
-			uhdr->len = htons(attr->max_size -
+			udp_set_len_short(uhdr, attr->max_size -
 					  (sizeof(*ihdr) + sizeof(*ehdr)));
 		uhdr->check = 0;
 	}
diff --git a/net/core/tso.c b/net/core/tso.c
index 6df997b9076e..3cc5a03e7a12 100644
--- a/net/core/tso.c
+++ b/net/core/tso.c
@@ -38,7 +38,8 @@ void tso_build_hdr(const struct sk_buff *skb, char *hdr, struct tso_t *tso,
 	} else {
 		struct udphdr *uh = (struct udphdr *)hdr;
 
-		uh->len = htons(sizeof(*uh) + size);
+		/* size is after segmentation. */
+		udp_set_len_short(uh, sizeof(*uh) + size);
 	}
 }
 EXPORT_SYMBOL(tso_build_hdr);
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 6dfc0bcdef65..df04a407e778 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -320,7 +320,7 @@ static struct ip_esp_hdr *esp_output_udp_encap(struct sk_buff *skb,
 	uh = (struct udphdr *)esp->esph;
 	uh->source = sport;
 	uh->dest = dport;
-	uh->len = htons(len);
+	udp_set_len_short(uh, len);
 	uh->check = 0;
 
 	/* For IPv4 ESP with UDP encapsulation, if xo is not null, the skb is in the crypto offload
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 5bae3cf7fe76..e66e10a2c33f 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -1043,7 +1043,7 @@ static void fou_build_udp(struct sk_buff *skb, struct ip_tunnel_encap *e,
 
 	uh->dest = e->dport;
 	uh->source = sport;
-	uh->len = htons(skb->len);
+	udp_set_len_short(uh, skb->len);
 	udp_set_csum(!(e->flags & TUNNEL_ENCAP_FLAG_CSUM), skb,
 		     fl4->saddr, fl4->daddr, skb->len);
 
diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index a35ffedacc7c..155db067eaec 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -847,7 +847,7 @@ static void __init ic_bootp_send_if(struct ic_device *d, unsigned long jiffies_d
 	/* Construct UDP header */
 	b->udph.source = htons(68);
 	b->udph.dest = htons(67);
-	b->udph.len = htons(sizeof(struct bootp_pkt) - sizeof(struct iphdr));
+	udp_set_len_short(&b->udph, sizeof(struct bootp_pkt) - sizeof(struct iphdr));
 	/* UDP checksum not calculated -- explicitly allowed in BOOTP RFC */
 
 	/* Construct DHCP/BOOTP header */
@@ -1025,10 +1025,10 @@ static int __init ic_bootp_recv(struct sk_buff *skb, struct net_device *dev, str
 	if (b->udph.source != htons(67) || b->udph.dest != htons(68))
 		goto drop;
 
-	if (ntohs(h->tot_len) < ntohs(b->udph.len) + sizeof(struct iphdr))
+	if (ntohs(h->tot_len) < udp_get_len_short(&b->udph) + sizeof(struct iphdr))
 		goto drop;
 
-	len = ntohs(b->udph.len) - sizeof(struct udphdr);
+	len = udp_get_len_short(&b->udph) - sizeof(struct udphdr);
 	ext_len = len - (sizeof(*b) -
 			 sizeof(struct iphdr) -
 			 sizeof(struct udphdr) -
diff --git a/net/ipv4/netfilter/nf_nat_snmp_basic_main.c b/net/ipv4/netfilter/nf_nat_snmp_basic_main.c
index 717b726504fe..afe0f4a328d0 100644
--- a/net/ipv4/netfilter/nf_nat_snmp_basic_main.c
+++ b/net/ipv4/netfilter/nf_nat_snmp_basic_main.c
@@ -127,7 +127,7 @@ static int snmp_translate(struct nf_conn *ct, int dir, struct sk_buff *skb)
 {
 	struct iphdr *iph = ip_hdr(skb);
 	struct udphdr *udph = (struct udphdr *)((__be32 *)iph + iph->ihl);
-	u16 datalen = ntohs(udph->len) - sizeof(struct udphdr);
+	u16 datalen = udp_get_len_short(udph) - sizeof(struct udphdr);
 	char *data = (unsigned char *)udph + sizeof(struct udphdr);
 	struct snmp_ctx ctx;
 	int ret;
@@ -181,7 +181,7 @@ static int help(struct sk_buff *skb, unsigned int protoff,
 	 * enough room for a UDP header.  Just verify the UDP length field so we
 	 * can mess around with the payload.
 	 */
-	if (ntohs(udph->len) != skb->len - (iph->ihl << 2)) {
+	if (udp_get_len_short(udph) != skb->len - (iph->ihl << 2)) {
 		nf_ct_helper_log(skb, ct, "dropping malformed packet\n");
 		return NF_DROP;
 	}
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index bc1296f0ea69..9fa130a847df 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3190,7 +3190,7 @@ static struct sk_buff *inet_rtm_getroute_build_skb(__be32 src, __be32 dst,
 		udph = skb_put_zero(skb, sizeof(struct udphdr));
 		udph->source = sport;
 		udph->dest = dport;
-		udph->len = htons(sizeof(struct udphdr));
+		udp_set_len_short(udph, sizeof(struct udphdr));
 		udph->check = 0;
 		break;
 	}
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ab415de32443..43e1cf8d32e3 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1107,7 +1107,8 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 	uh = udp_hdr(skb);
 	uh->source = inet_sk(sk)->inet_sport;
 	uh->dest = fl4->fl4_dport;
-	uh->len = htons(len);
+	/* Datagram length checked in udp_sendmsg. */
+	udp_set_len_short(uh, len);
 	uh->check = 0;
 
 	if (cork->gso_size) {
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 2578aa7f9ff9..22acc80b12a4 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -279,11 +279,11 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 		 * segment instead of the entire frame.
 		 */
 		if (gso_partial && skb_is_gso(skb)) {
-			uh->len = htons(skb_shinfo(skb)->gso_size +
-					SKB_GSO_CB(skb)->data_offset +
-					skb->head - (unsigned char *)uh);
+			udp_set_len_short(uh, skb_shinfo(skb)->gso_size +
+					  SKB_GSO_CB(skb)->data_offset +
+					  skb->head - (unsigned char *)uh);
 		} else {
-			uh->len = htons(len);
+			udp_set_len_short(uh, len);
 		}
 
 		if (!need_csum)
@@ -468,7 +468,7 @@ static struct sk_buff *__udp_gso_segment_list(struct sk_buff *skb,
 	if (IS_ERR(skb))
 		return skb;
 
-	udp_hdr(skb)->len = htons(sizeof(struct udphdr) + mss);
+	udp_set_len_short(udp_hdr(skb), sizeof(struct udphdr) + mss);
 
 	if (is_ipv6)
 		return __udpv6_gso_segment_list_csum(skb);
@@ -486,8 +486,8 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	unsigned int mss;
 	bool copy_dtor;
 	__sum16 check;
-	__be16 newlen;
 	int ret = 0;
+	u16 newlen;
 
 	mss = skb_shinfo(gso_skb)->gso_size;
 	if (gso_skb->len <= sizeof(*uh) + mss)
@@ -564,8 +564,8 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 			(skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP);
 
 	/* compute checksum adjustment based on old length versus new */
-	newlen = htons(sizeof(*uh) + mss);
-	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
+	newlen = sizeof(*uh) + mss;
+	check = csum16_add(csum16_sub(uh->check, uh->len), htons(newlen));
 
 	for (;;) {
 		if (copy_dtor) {
@@ -577,7 +577,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		if (!seg->next)
 			break;
 
-		uh->len = newlen;
+		udp_set_len_short(uh, newlen);
 		uh->check = check;
 
 		if (seg->ip_summed == CHECKSUM_PARTIAL)
@@ -591,11 +591,10 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	}
 
 	/* last packet can be partial gso_size, account for that in checksum */
-	newlen = htons(skb_tail_pointer(seg) - skb_transport_header(seg) +
-		       seg->data_len);
-	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
+	newlen = skb_tail_pointer(seg) - skb_transport_header(seg) + seg->data_len;
+	check = csum16_add(csum16_sub(uh->check, uh->len), htons(newlen));
 
-	uh->len = newlen;
+	udp_set_len_short(uh, newlen);
 	uh->check = check;
 
 	if (seg->ip_summed == CHECKSUM_PARTIAL)
@@ -706,7 +705,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 	}
 
 	/* Do not deal with padded or malicious packets, sorry ! */
-	ulen = ntohs(uh->len);
+	ulen = udp_get_len_short(uh);
 	if (ulen <= sizeof(*uh) || ulen != skb_gro_len(skb)) {
 		NAPI_GRO_CB(skb)->flush = 1;
 		return NULL;
@@ -739,7 +738,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 		 * On len mismatch merge the first packet shorter than gso_size,
 		 * otherwise complete the GRO packet.
 		 */
-		if (ulen > ntohs(uh2->len) || flush) {
+		if (ulen > udp_get_len_short(uh2) || flush) {
 			pp = p;
 		} else {
 			if (NAPI_GRO_CB(skb)->is_flist) {
@@ -762,7 +761,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 			}
 		}
 
-		if (ret || ulen != ntohs(uh2->len) ||
+		if (ret || ulen != udp_get_len_short(uh2) ||
 		    NAPI_GRO_CB(p)->count >= UDP_GRO_CNT_MAX)
 			pp = p;
 
@@ -912,12 +911,12 @@ static int udp_gro_complete_segment(struct sk_buff *skb)
 int udp_gro_complete(struct sk_buff *skb, int nhoff,
 		     udp_lookup_t lookup)
 {
-	__be16 newlen = htons(skb->len - nhoff);
+	unsigned int newlen = skb->len - nhoff;
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
 	struct sock *sk;
 	int err;
 
-	uh->len = newlen;
+	udp_set_len_short(uh, newlen);
 
 	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
 				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
@@ -954,7 +953,7 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		uh->len = htons(skb->len - nhoff);
+		udp_set_len_short(uh, skb->len - nhoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index b1f667c52cb2..18f789d9383e 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -184,7 +184,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	uh->dest = dst_port;
 	uh->source = src_port;
-	uh->len = htons(skb->len);
+	udp_set_len_short(uh, skb->len);
 
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9f75313734f8..1d71a95d48b8 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -227,7 +227,8 @@ static void esp_output_encap_csum(struct sk_buff *skb)
 	if (*skb_mac_header(skb) == IPPROTO_UDP) {
 		struct udphdr *uh = udp_hdr(skb);
 		struct ipv6hdr *ip6h = ipv6_hdr(skb);
-		int len = ntohs(uh->len);
+		/* esp6_output_udp_encap limits len to U16_MAX. */
+		int len = udp_get_len_short(uh);
 		unsigned int offset = skb_transport_offset(skb);
 		__wsum csum = skb_checksum(skb, offset, skb->len - offset, 0);
 
@@ -355,7 +356,7 @@ static struct ip_esp_hdr *esp6_output_udp_encap(struct sk_buff *skb,
 	uh = (struct udphdr *)esp->esph;
 	uh->source = sport;
 	uh->dest = dport;
-	uh->len = htons(len);
+	udp_set_len_short(uh, len);
 	uh->check = 0;
 
 	*skb_mac_header(skb) = IPPROTO_UDP;
diff --git a/net/ipv6/fou6.c b/net/ipv6/fou6.c
index 157765259e2f..588929409241 100644
--- a/net/ipv6/fou6.c
+++ b/net/ipv6/fou6.c
@@ -30,7 +30,7 @@ static void fou6_build_udp(struct sk_buff *skb, struct ip_tunnel_encap *e,
 
 	uh->dest = e->dport;
 	uh->source = sport;
-	uh->len = htons(skb->len);
+	udp_set_len_short(uh, skb->len);
 	udp6_set_csum(!(e->flags & TUNNEL_ENCAP_FLAG_CSUM6), skb,
 		      &fl6->saddr, &fl6->daddr, skb->len);
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 405ef1cb8864..43e94a3efb26 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -93,7 +93,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	uh->dest = dst_port;
 	uh->source = src_port;
 
-	uh->len = htons(skb->len);
+	udp_set_len_short(uh, skb->len);
 
 	skb_dst_set(skb, dst);
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index d7cf4c9508b2..04c4adeb6688 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1367,7 +1367,8 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 	uh = udp_hdr(skb);
 	uh->source = fl6->fl6_sport;
 	uh->dest = fl6->fl6_dport;
-	uh->len = htons(len);
+	/* Datagram length checked in udpv6_sendmsg. */
+	udp_set_len_short(uh, len);
 	uh->check = 0;
 
 	if (cork->gso_size) {
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 778afc7453ce..c92cf5ee3e6a 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -171,7 +171,7 @@ int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		uh->len = htons(skb->len - nhoff);
+		udp_set_len_short(uh, skb->len - nhoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 157fc23ce4e1..0ed18164bfb7 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1295,7 +1295,7 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 			ret = NET_XMIT_DROP;
 			goto out_unlock;
 		}
-		uh->len = htons(udp_len);
+		udp_set_len_short(uh, udp_len);
 
 		/* Calculate UDP checksum if configured to do so */
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 0fb5162992e5..b460998e348e 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -1089,7 +1089,7 @@ ipvs_gue_encap(struct net *net, struct sk_buff *skb,
 	dport = cp->dest->tun_port;
 	udph->dest = dport;
 	udph->source = sport;
-	udph->len = htons(skb->len);
+	udp_set_len_short(udph, skb->len);
 	udph->check = 0;
 
 	*next_protocol = IPPROTO_UDP;
diff --git a/net/netfilter/nf_conntrack_proto_udp.c b/net/netfilter/nf_conntrack_proto_udp.c
index 0030fbe8885c..e9bd1632304f 100644
--- a/net/netfilter/nf_conntrack_proto_udp.c
+++ b/net/netfilter/nf_conntrack_proto_udp.c
@@ -41,11 +41,22 @@ static void udp_error_log(const struct sk_buff *skb,
 	nf_l4proto_log_invalid(skb, state, IPPROTO_UDP, "%s", msg);
 }
 
+static bool udp_validate_len(struct sk_buff *skb,
+			     const struct udphdr *hdr,
+			     unsigned int dataoff)
+{
+	unsigned int udplen = udp_get_len_short(hdr);
+	unsigned int skblen = skb->len - dataoff;
+
+	if (udplen > skblen || udplen < sizeof(*hdr))
+		return false;
+	return true;
+}
+
 static bool udp_error(struct sk_buff *skb,
 		      unsigned int dataoff,
 		      const struct nf_hook_state *state)
 {
-	unsigned int udplen = skb->len - dataoff;
 	const struct udphdr *hdr;
 	struct udphdr _hdr;
 
@@ -57,7 +68,7 @@ static bool udp_error(struct sk_buff *skb,
 	}
 
 	/* Truncated/malformed packets */
-	if (ntohs(hdr->len) > udplen || ntohs(hdr->len) < sizeof(*hdr)) {
+	if (!udp_validate_len(skb, hdr, dataoff)) {
 		udp_error_log(skb, state, "truncated/malformed packet");
 		return true;
 	}
@@ -153,7 +164,7 @@ static bool udplite_error(struct sk_buff *skb,
 		return true;
 	}
 
-	cscov = ntohs(hdr->len);
+	cscov = udp_get_len_short(hdr);
 	if (cscov == 0) {
 		cscov = udplen;
 	} else if (cscov < sizeof(*hdr) || cscov > udplen) {
diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index 0507d67cad27..da990e3b30f4 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -298,7 +298,7 @@ nf_log_dump_udp_header(struct nf_log_buf *m,
 
 	/* Max length: 20 "SPT=65535 DPT=65535 " */
 	nf_log_buf_add(m, "SPT=%u DPT=%u LEN=%u ",
-		       ntohs(uh->source), ntohs(uh->dest), ntohs(uh->len));
+		       ntohs(uh->source), ntohs(uh->dest), udp_get_len_short(uh));
 
 out:
 	return 0;
diff --git a/net/netfilter/nf_nat_helper.c b/net/netfilter/nf_nat_helper.c
index bf591e6af005..3853f41db499 100644
--- a/net/netfilter/nf_nat_helper.c
+++ b/net/netfilter/nf_nat_helper.c
@@ -161,7 +161,7 @@ nf_nat_mangle_udp_packet(struct sk_buff *skb,
 
 	/* update the length of the UDP packet */
 	datalen = skb->len - protoff;
-	udph->len = htons(datalen);
+	udp_set_len_short(udph, datalen);
 
 	/* fix udp checksum if udp checksum was previously calculated */
 	if (!udph->check && skb->ip_summed != CHECKSUM_PARTIAL)
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 9508b6c38003..47491b0ce4c9 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -207,7 +207,7 @@ static void psp_write_headers(struct net *net, struct sk_buff *skb, __be32 spi,
 		uh->source = udp_flow_src_port(net, skb, 0, 0, false);
 	}
 	uh->check = 0;
-	uh->len = htons(udp_len);
+	udp_set_len_short(uh, udp_len);
 
 	psph->nexthdr = IPPROTO_TCP;
 	psph->hdrlen = PSP_HDRLEN_NOOPT;
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 078d3a27130b..5fff52a8ca90 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -276,7 +276,7 @@ static int tcf_csum_ipv4_udp(struct sk_buff *skb, unsigned int ihl,
 		return 0;
 
 	iph = ip_hdr(skb);
-	ul = ntohs(udph->len);
+	ul = udp_get_len_short(udph);
 
 	if (udplite || udph->check) {
 
@@ -334,7 +334,7 @@ static int tcf_csum_ipv6_udp(struct sk_buff *skb, unsigned int ihl,
 		return 0;
 
 	ip6h = ipv6_hdr(skb);
-	ul = ntohs(udph->len);
+	ul = udp_get_len_short(udph);
 
 	udph->check = 0;
 
diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index 458931062a04..906458f3d8c5 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -133,7 +133,7 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
 	uh = skb_push(skb, sizeof(*uh));
 	uh->source = ka->encap_sport;
 	uh->dest = ka->encap_dport;
-	uh->len = htons(skb->len);
+	udp_set_len_short(uh, skb->len);
 	uh->check = 0;
 
 	skb->mark = ka->smark;
-- 
2.53.0


