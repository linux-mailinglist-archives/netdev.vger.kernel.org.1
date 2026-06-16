Return-Path: <netdev+bounces-299982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qn7cK1vQMWqZqgUAu9opvQ
	(envelope-from <netdev+bounces-299982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:38:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8F26959DC
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:38:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="P/2Y5lXZ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299982-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299982-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDA843009F93
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967B13B2D24;
	Tue, 16 Jun 2026 22:35:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965D3AE187
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 22:35:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649319; cv=none; b=FPdfKdx5S1Y7RVttmwB0bspgNOx8b4nbwhzJOfF12Nj5TAch6LLAT4IfivaSBz0ZonETclGhRzceqikIpRpIH2WOLYhZ2xArh+jfAooJ1ZUH3AaZNMUvH8/at6kEamWsWnlIcW596xkQUQO+heG1IdyKPYXGIW8+XtPFoKKl3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649319; c=relaxed/simple;
	bh=348H9B2XdEF37pmcoscPrIqI7hKy50qt7XuJA7Nr0DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXupb/VdMZhapcxaW6qcFbNP785ZFbKdOD3yahfE47qJlJwgvURofV8ZMNgt4+1XwdBvkYeMy+9nuBvOuXmubLdD+YF98Xj4yERG0s/F6S+i3pFrHN02/V5V8d/8a52jarFFtLFpPTVcZEQF65u6wl9tgQTT/iwL0qIPnhznHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/2Y5lXZ; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso5151836a91.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781649315; x=1782254115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGzNAG5oGHrxIXD0faDZNR4J60LxM3Cal3HJzZdDHvY=;
        b=P/2Y5lXZALfFXSpQ5u1be8sKq+1rL6wwvz3zNB7ygwuAkthfb4dHDvpAEOyB9EglfQ
         LNCoXhvVP/j9jJnUVpgdE0hUnbAkDD62kvCi33a3aO7ULlsnDhRTB57nS4TBa9TrI54Q
         nNLguU3VhUEqbwn24vDW11BBDJ1oiZ7yh7/gdchS5fW0V/UgSUOr7y36nYG0pEmORnXb
         3zBN/J/UerjhHkxARcwZRCzY6oFE4delXnIfy0dWRZsJ5xxvGPbBOioP0RH+Vi9CO4oH
         aWnEPBuMkBpY5Cgy7mgfLnyZROj32okXFOnqsLe76QXLtlaj5xdz3nnLAvDx4nW3syGA
         /xVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781649315; x=1782254115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SGzNAG5oGHrxIXD0faDZNR4J60LxM3Cal3HJzZdDHvY=;
        b=I/DYu36zn4nN6WIdhFXDGi7JoD1cH0B09ksE9TQxrNkiTTMoXMj45p2GYkOuvzBBKV
         03XHou0Xvbd29uVlj+/GfusO0LE8gm1F3ph/epZSaJCdD0t/XSvExveEdlxvKFVHsRGD
         sDNBSk//F/2pkf6b3E0IWkO7M2adePO8JepjbHp/zyomS1SRmSyViZAVdHm1M2MERGNH
         6KzVggR565Dcc3B/yACiq25c48PtkzXwlaqFErIjPiqvzWKRIXqPQAZfXNL8GEMoESUC
         mZJBjzKwQq4Nt7V4U0+7iWT+Y27wUI5B0aANhQOYojx550sQCZsdqGtQevQvWt8Q8ktW
         yGjw==
X-Forwarded-Encrypted: i=1; AFNElJ9UR/pYrxufOGNP6p+DI37U7DdIt6hZeJB0NkaInqP9jgiFlwYMJj1Qq/w3xlvOApjx5C0KtGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhnH4Us9kFx6N6aeo0rGHmxcjM5KN/bqvGtSR3kurIDsm3xMKd
	1CtLs7fphVCxEgILGJLrK0grcOnAymtABPWrvSvJwPH7LjzE587UYRx/
X-Gm-Gg: AfdE7cmJ4cQHELKd82pA/XrzalsX5opDcEvMgKREZyDEoelTg7c9S6ou+o2Qk8vofdw
	RnqEtri+wJov/2f/OiyqppMIwWuW7jIgXR4+mUZFQ8TbrBcWtSgLYsI/2TQGe7+h4J4Cczr0VQd
	21Rwc0h+kXv5+ygAZFq121UhACkx9k2XTdLWTina9iftGTe9qeV8GJutJyY/NXgUUSOatL24g+a
	aJpDdx/VLfrufIIwqVfd1KpRzFrSCLL5SwVYxZUVfSPpDO2HSN8v4JPghToTGyRcnK0nVTKFwZJ
	9QUrHHYzX0QE4eZ5K4UXGvGXEjF6PcyaYxn3rltUdOqcDJnoUg7+iADvShTQG6as/HRTvJlQ03u
	KrsoERYXSnoEalDvMDDP2Nf5W7KaSg1p/TPfTxc+Y3GcL4olxTyCwcWkS3rvoHJduwcSXj1EFM2
	MbtHY+WIQ4JDczuHMiksyBYpui+UIE9ePowhG61WtV1dbYY1wALbr28ClyJUBFLbO5Fpv5YFE=
X-Received: by 2002:a17:90b:2604:b0:36b:71e6:3de8 with SMTP id 98e67ed59e1d1-37c9ed0135amr958584a91.24.1781649314947;
        Tue, 16 Jun 2026 15:35:14 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c52092ee3sm4216898a91.0.2026.06.16.15.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:35:14 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Add bpf_fib_lookup() VLAN flag tests
Date: Wed, 17 Jun 2026 04:04:26 +0530
Message-ID: <20260616223426.3568080-5-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
References: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-299982-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:eyal.birger@gmail.com,m:rongtao@cestc.cn,m:toke@redhat.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C8F26959DC

Cover both directions of the new VLAN flags in the fib_lookup test,
36 table cases plus a dedicated cross-netns subtest.

For BPF_FIB_LOOKUP_VLAN the egress cases assert: without the flag the
lookup returns the VLAN netdev's ifindex and zeroed vlan fields, with
the flag it returns the parent's ifindex plus the tag (including via
a neighbour resolved on the VLAN device, in OUTPUT mode, over a bond,
and through a DIRECT|TBID table), with the flag on a non-VLAN egress
it changes nothing, for a stacked VLAN it leaves ifindex untouched
with the vlan fields zero, and a frag-needed return reports the route
mtu in mtu_result while leaving the swap unwritten.

For BPF_FIB_LOOKUP_VLAN_INPUT, an iif rule on the subinterface routes
the same destination to a different gateway, so the asserted gateway
shows which device the lookup used as ingress: without the flag the
main table answers, with a matching tag the subinterface's table
does, with or without SKIP_NEIGH, and BPF_FIB_LOOKUP_SRC selects the
subinterface's address. A VRF-enslaved subinterface selects the VRF
table through the l3mdev rule and, with DIRECT, through
l3mdev_fib_table_rcu(). One case sets BPF_FIB_LOOKUP_VLAN as well and
asserts both directions work in a single lookup. Resolution semantics
are pinned: an 802.1ad tag resolves its device, PCP and DEI bits in
h_vlan_TCI are ignored, a VLAN ifindex resolves the inner QinQ
device, a tag on a bond master resolves while the same tag on the
bond port does not.

The error cases assert -EINVAL for an invalid h_vlan_proto on both
address families, for the TBID and OUTPUT flag combinations and for
an unknown flag bit, and BPF_FIB_LKUP_RET_NOT_FWDED for a VID with no
configured device on both families, for a VID-0 priority tag and for
a device that exists but is down. The failure cases also assert that
params is left untouched.

A separate subtest moves a VLAN device into a second netns while it
stays registered on its parent, and checks both directions refuse to
cross the boundary: the input flag fails closed with the tag and
ifindex untouched, and the egress flag does not publish the foreign
parent's ifindex.

The tbid read-back check is skipped for DIRECT cases that set
BPF_FIB_LOOKUP_VLAN, since a successful swap packs the vlan fields
into the union the check reads.

Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 .../selftests/bpf/prog_tests/fib_lookup.c     | 494 +++++++++++++++++-
 1 file changed, 491 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index bd7658958004..42107d60c9ca 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
 
 #include <linux/rtnetlink.h>
+#include <linux/if_ether.h>
 #include <sys/types.h>
 #include <net/if.h>
 
@@ -37,6 +38,41 @@
 #define IPV6_LOCAL		"fd01::3"
 #define IPV6_GW1		"fd01::1"
 #define IPV6_GW2		"fd01::2"
+#define VLAN_ID			100
+#define VLAN_IFACE		"veth1.100"
+#define VLAN_ID_DOWN		102
+#define VLAN_IFACE_DOWN		"veth1.102"
+#define QINQ_OUTER_IFACE	"veth1.200"
+#define QINQ_INNER_IFACE	"veth1.200.300"
+#define VLAN_TABLE		"300"
+#define IPV4_VLAN_IFACE_ADDR	"10.5.0.254"
+#define IPV4_VLAN_EGRESS_DST	"10.5.0.2"
+#define IPV4_QINQ_DST		"10.7.0.2"
+#define IPV4_VLAN_DST		"10.6.0.2"
+#define IPV4_VLAN_GW		"10.5.0.1"
+#define IPV6_VLAN_IFACE_ADDR	"fd02::254"
+#define IPV6_VLAN_EGRESS_DST	"fd02::2"
+#define IPV6_VLAN_DST		"fd03::2"
+#define IPV6_VLAN_GW		"fd02::1"
+#define VLAN_VID_UNUSED		999
+#define VRF_IFACE		"vrf-blue"
+#define VRF_TABLE		"1000"
+#define VRF_VLAN_ID		101
+#define VRF_VLAN_IFACE		"veth1.101"
+#define IPV4_VRF_IFACE_ADDR	"10.8.0.254"
+#define IPV4_VRF_GW		"10.8.0.1"
+#define IPV4_VRF_DST		"10.9.0.2"
+#define TBID_VLAN_ID		50
+#define TBID_VLAN_IFACE		"veth2.50"
+#define IPV4_TBID_VLAN_DST	"172.2.0.2"
+#define IPV4_BOND_VLAN_DST	"10.11.0.2"
+#define IPV4_VLAN_MTU_DST	"10.5.9.2"
+#define QINQ_AD_VLAN_ID		200
+#define QINQ_INNER_VLAN_ID	300
+#define BOND_IFACE		"bond99"
+#define BOND_PORT		"veth3"
+#define BOND_PORT_PEER		"veth4"
+#define BOND_VLAN_ID		500
 #define DMAC			"11:11:11:11:11:11"
 #define DMAC_INIT { 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, }
 #define DMAC2			"01:01:01:01:01:01"
@@ -52,6 +88,16 @@ struct fib_lookup_test {
 	__u32 tbid;
 	__u8 dmac[6];
 	__u32 mark;
+	/* input tag with BPF_FIB_LOOKUP_VLAN_INPUT; expected output tag
+	 * with BPF_FIB_LOOKUP_VLAN (checked when check_vlan is set)
+	 */
+	__u16 vlan_proto;
+	__u16 vlan_id;
+	bool check_vlan;
+	const char *expected_dev; /* expected params->ifindex after lookup */
+	const char *iif;	  /* override the default veth1 input device */
+	__u16 tot_len;		  /* triggers the in-lookup mtu check when set */
+	__u16 expected_mtu;	  /* expected mtu_result (union with tot_len) */
 };
 
 static const struct fib_lookup_test tests[] = {
@@ -142,6 +188,204 @@ static const struct fib_lookup_test tests[] = {
 	  .expected_dst = IPV6_GW1,
 	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
 	  .mark = MARK, },
+	/* vlan egress resolution */
+	{ .desc = "IPv4 VLAN egress, no flag",
+	  .daddr = IPV4_VLAN_EGRESS_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = VLAN_IFACE, .check_vlan = true, },
+	{ .desc = "IPv4 VLAN egress, single VLAN",
+	  .daddr = IPV4_VLAN_EGRESS_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	/* skb path without tot_len: mtu_result follows params->ifindex, so the
+	 * swap moves it from the VLAN device's mtu (1400) to the parent's (1500)
+	 */
+	{ .desc = "IPv4 VLAN egress, skb-path mtu is the VLAN device's without the flag",
+	  .daddr = IPV4_VLAN_EGRESS_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = VLAN_IFACE, .check_vlan = true, .expected_mtu = 1400, },
+	{ .desc = "IPv4 VLAN egress, skb-path mtu is the parent's after the swap",
+	  .daddr = IPV4_VLAN_EGRESS_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, .expected_mtu = 1500, },
+	{ .desc = "IPv4 VLAN egress, flag set but egress is not a VLAN",
+	  .daddr = IPV4_NUD_FAILED_ADDR, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = "veth1", .check_vlan = true, },
+	{ .desc = "IPv4 VLAN egress, stacked VLAN untouched",
+	  .daddr = IPV4_QINQ_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = QINQ_INNER_IFACE, .check_vlan = true, },
+	{ .desc = "IPv6 VLAN egress, single VLAN",
+	  .daddr = IPV6_VLAN_EGRESS_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN egress, neighbour on the VLAN device",
+	  .daddr = IPV4_VLAN_EGRESS_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, .dmac = DMAC_INIT, },
+	{ .desc = "IPv4 VLAN egress in OUTPUT mode",
+	  .daddr = IPV4_VLAN_EGRESS_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .iif = VLAN_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_VLAN |
+			  BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN egress over a bond",
+	  .daddr = IPV4_BOND_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = BOND_IFACE, .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = BOND_VLAN_ID, },
+	{ .desc = "IPv4 VLAN egress via TBID table",
+	  .daddr = IPV4_TBID_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID |
+			  BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .tbid = 100,
+	  .expected_dev = "veth2", .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = TBID_VLAN_ID, },
+	{ .desc = "IPv4 VLAN egress, success writes mtu_result with the swap",
+	  .daddr = IPV4_VLAN_MTU_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .tot_len = 500, .expected_mtu = 1000,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN egress, FRAG_NEEDED reports mtu, swap unwritten",
+	  .daddr = IPV4_VLAN_MTU_DST, .expected_ret = BPF_FIB_LKUP_RET_FRAG_NEEDED,
+	  .tot_len = 1400, .expected_mtu = 1000,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .expected_dev = "veth1", .check_vlan = true, },
+	/* vlan tag as lookup input */
+	{ .desc = "IPv4 VLAN input, no flag",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_GW1,
+	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv4 VLAN input, tag selects subinterface route",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_VLAN_GW, .expected_dev = VLAN_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv6 VLAN input, tag selects subinterface route",
+	  .daddr = IPV6_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV6_VLAN_GW, .expected_dev = VLAN_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN input and egress combined",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_VLAN_GW, .expected_dev = "veth1",
+	  .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_VLAN |
+			  BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN input, neighbour resolved on the route",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_VLAN_GW, .expected_dev = VLAN_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, .dmac = DMAC_INIT2, },
+	{ .desc = "IPv4 VLAN input, source address from the subinterface",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_src = IPV4_VLAN_IFACE_ADDR,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SRC |
+			  BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	/* VRF: the resolved subinterface is enslaved, so the l3mdev rule
+	 * (full lookup) and l3mdev_fib_table_rcu() (DIRECT) must select
+	 * the VRF table from the resolved ingress
+	 */
+	{ .desc = "IPv4 VLAN input, VRF subinterface, no flag",
+	  .daddr = IPV4_VRF_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_GW1,
+	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv4 VLAN input, tag selects VRF table",
+	  .daddr = IPV4_VRF_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_VRF_GW, .expected_dev = VRF_VLAN_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VRF_VLAN_ID, },
+	{ .desc = "IPv4 VLAN input, DIRECT uses VRF table from resolved ingress",
+	  .daddr = IPV4_VRF_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_VRF_GW, .expected_dev = VRF_VLAN_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_DIRECT |
+			  BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VRF_VLAN_ID, },
+	/* failure arms also assert params is left untouched: ifindex still
+	 * names the physical device and the input tag bytes survive
+	 */
+	{ .desc = "IPv4 VLAN input, invalid proto",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = -EINVAL,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = 0x1234, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN input, unmatched VID",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_VID_UNUSED, },
+	{ .desc = "IPv4 VLAN input, subinterface down",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID_DOWN, },
+	/* the resolver runs before the forwarding check, so on devices
+	 * with forwarding off FWD_DISABLED (not NOT_FWDED) proves the tag
+	 * resolved to that device and the lookup used it as ingress
+	 */
+	{ .desc = "IPv4 VLAN input, 802.1ad tag",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_FWD_DISABLED,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021AD, .vlan_id = QINQ_AD_VLAN_ID, },
+	{ .desc = "IPv4 VLAN input, PCP and DEI bits ignored in TCI",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_dst = IPV4_VLAN_GW,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = 0xe000 | VLAN_ID, },
+	{ .desc = "IPv4 VLAN input, inner QinQ device from VLAN ifindex",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_FWD_DISABLED,
+	  .iif = QINQ_OUTER_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = QINQ_INNER_VLAN_ID, },
+	/* bonding: the VLANs live on the master, as on receive, where the
+	 * frame is steered to the master before VLAN processing; a port
+	 * ifindex does not match (ports carry vid state but no VLAN devs)
+	 */
+	{ .desc = "IPv4 VLAN input, tag on bond master resolves",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_FWD_DISABLED,
+	  .iif = BOND_IFACE,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = BOND_VLAN_ID, },
+	{ .desc = "IPv4 VLAN input, tag on bond port does not match",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
+	  .iif = BOND_PORT, .expected_dev = BOND_PORT, .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = BOND_VLAN_ID, },
+	{ .desc = "IPv6 VLAN input, invalid proto",
+	  .daddr = IPV6_VLAN_DST, .expected_ret = -EINVAL,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = 0x1234, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN input, VID 0 priority tag fails closed",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = 0, },
+	{ .desc = "IPv6 VLAN input, unmatched VID",
+	  .daddr = IPV6_VLAN_DST, .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
+	  .expected_dev = "veth1", .check_vlan = true,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_VID_UNUSED, },
+	{ .desc = "unknown flag bit rejected",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = -EINVAL,
+	  .lookup_flags = (1 << 14) | BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv4 VLAN input rejected with TBID",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = -EINVAL,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_TBID,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
+	{ .desc = "IPv4 VLAN input rejected with OUTPUT",
+	  .daddr = IPV4_VLAN_DST, .expected_ret = -EINVAL,
+	  .lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT | BPF_FIB_LOOKUP_OUTPUT,
+	  .vlan_proto = ETH_P_8021Q, .vlan_id = VLAN_ID, },
 };
 
 static int setup_netns(void)
@@ -204,6 +448,105 @@ static int setup_netns(void)
 	SYS(fail, "ip rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
 	SYS(fail, "ip -6 rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
 
+	/* Setup for vlan tests: a subinterface for egress resolution and
+	 * tag-as-input, a QinQ stack, and an iif rule so the input tests
+	 * observe which device the lookup used as ingress.
+	 */
+	SYS(fail, "ip link add link veth1 name %s type vlan id %d",
+	    VLAN_IFACE, VLAN_ID);
+	SYS(fail, "ip link set dev %s up", VLAN_IFACE);
+	/* lower than the veth1 parent (1500): the skb-path mtu check follows
+	 * params->ifindex, so the egress swap makes mtu_result jump from this
+	 * value to the parent's, which two arms below pin
+	 */
+	SYS(fail, "ip link set dev %s mtu 1400", VLAN_IFACE);
+	SYS(fail, "ip addr add %s/24 dev %s", IPV4_VLAN_IFACE_ADDR, VLAN_IFACE);
+	SYS(fail, "ip addr add %s/64 dev %s nodad", IPV6_VLAN_IFACE_ADDR, VLAN_IFACE);
+
+	/* stays down: the input flag must treat its tag the way real
+	 * ingress treats a frame arriving on a down VLAN device (drop)
+	 */
+	SYS(fail, "ip link add link veth1 name %s type vlan id %d",
+	    VLAN_IFACE_DOWN, VLAN_ID_DOWN);
+
+	err = write_sysctl("/proc/sys/net/ipv4/conf/" VLAN_IFACE "/forwarding", "1");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.conf." VLAN_IFACE ".forwarding)"))
+		goto fail;
+
+	err = write_sysctl("/proc/sys/net/ipv6/conf/" VLAN_IFACE "/forwarding", "1");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf." VLAN_IFACE ".forwarding)"))
+		goto fail;
+
+	SYS(fail, "ip link add link veth1 name %s type vlan proto 802.1ad id 200",
+	    QINQ_OUTER_IFACE);
+	SYS(fail, "ip link add link %s name %s type vlan id 300",
+	    QINQ_OUTER_IFACE, QINQ_INNER_IFACE);
+	SYS(fail, "ip link set dev %s up", QINQ_OUTER_IFACE);
+	SYS(fail, "ip link set dev %s up", QINQ_INNER_IFACE);
+	SYS(fail, "ip route add %s/32 dev %s", IPV4_QINQ_DST, QINQ_INNER_IFACE);
+
+	SYS(fail, "ip route add %s/32 via %s", IPV4_VLAN_DST, IPV4_GW1);
+	SYS(fail, "ip route add table %s %s/32 via %s",
+	    VLAN_TABLE, IPV4_VLAN_DST, IPV4_VLAN_GW);
+	SYS(fail, "ip rule add prio 3 iif %s lookup %s", VLAN_IFACE, VLAN_TABLE);
+	SYS(fail, "ip -6 route add %s/128 via %s", IPV6_VLAN_DST, IPV6_GW1);
+	SYS(fail, "ip -6 route add table %s %s/128 via %s",
+	    VLAN_TABLE, IPV6_VLAN_DST, IPV6_VLAN_GW);
+	SYS(fail, "ip -6 rule add prio 3 iif %s lookup %s", VLAN_IFACE, VLAN_TABLE);
+
+	/* a bond with one port and a VLAN on the bond: VLANs on a bond
+	 * live on the master, so resolution succeeds for the master's
+	 * ifindex and fails closed for a port's, matching receive, which
+	 * steers the frame to the master before VLAN processing
+	 */
+	SYS(fail, "ip link add %s type bond", BOND_IFACE);
+	SYS(fail, "ip link add %s type veth peer name %s", BOND_PORT, BOND_PORT_PEER);
+	SYS(fail, "ip link set %s master %s", BOND_PORT, BOND_IFACE);
+	SYS(fail, "ip link set dev %s up", BOND_IFACE);
+	SYS(fail, "ip link set dev %s up", BOND_PORT);
+	SYS(fail, "ip link add link %s name %s.%d type vlan id %d",
+	    BOND_IFACE, BOND_IFACE, BOND_VLAN_ID, BOND_VLAN_ID);
+	SYS(fail, "ip link set dev %s.%d up", BOND_IFACE, BOND_VLAN_ID);
+	SYS(fail, "ip route add %s/32 dev %s.%d",
+	    IPV4_BOND_VLAN_DST, BOND_IFACE, BOND_VLAN_ID);
+
+	/* a VRF with its own dedicated subinterface (the iif rules above
+	 * must not see it), for the table-selection-by-ingress cases
+	 */
+	SYS(fail, "ip link add %s type vrf table %s", VRF_IFACE, VRF_TABLE);
+	SYS(fail, "ip link set dev %s up", VRF_IFACE);
+	SYS(fail, "ip link add link veth1 name %s type vlan id %d",
+	    VRF_VLAN_IFACE, VRF_VLAN_ID);
+	SYS(fail, "ip link set %s master %s", VRF_VLAN_IFACE, VRF_IFACE);
+	SYS(fail, "ip link set dev %s up", VRF_VLAN_IFACE);
+	SYS(fail, "ip addr add %s/24 dev %s", IPV4_VRF_IFACE_ADDR, VRF_VLAN_IFACE);
+	err = write_sysctl("/proc/sys/net/ipv4/conf/" VRF_VLAN_IFACE "/forwarding", "1");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.conf." VRF_VLAN_IFACE ".forwarding)"))
+		goto fail;
+	SYS(fail, "ip route add %s/32 via %s", IPV4_VRF_DST, IPV4_GW1);
+	SYS(fail, "ip route add table %s %s/32 via %s",
+	    VRF_TABLE, IPV4_VRF_DST, IPV4_VRF_GW);
+
+	/* neighbours on the VLAN subinterface for the non-SKIP_NEIGH cases */
+	err = write_sysctl("/proc/sys/net/ipv4/neigh/" VLAN_IFACE "/gc_stale_time", "900");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.neigh." VLAN_IFACE ".gc_stale_time)"))
+		goto fail;
+	SYS(fail, "ip neigh add %s dev %s lladdr %s nud stale",
+	    IPV4_VLAN_EGRESS_DST, VLAN_IFACE, DMAC);
+	SYS(fail, "ip neigh add %s dev %s lladdr %s nud stale",
+	    IPV4_VLAN_GW, VLAN_IFACE, DMAC2);
+
+	/* a VLAN on veth2 with a route in the tbid test table */
+	SYS(fail, "ip link add link veth2 name %s type vlan id %d",
+	    TBID_VLAN_IFACE, TBID_VLAN_ID);
+	SYS(fail, "ip link set dev %s up", TBID_VLAN_IFACE);
+	SYS(fail, "ip route add table 100 %s/32 dev %s",
+	    IPV4_TBID_VLAN_DST, TBID_VLAN_IFACE);
+
+	/* a locked-mtu route via the subinterface for the FRAG_NEEDED case */
+	SYS(fail, "ip route add %s/32 dev %s mtu lock 1000",
+	    IPV4_VLAN_MTU_DST, VLAN_IFACE);
+
 	return 0;
 fail:
 	return -1;
@@ -218,9 +561,16 @@ static int set_lookup_params(struct bpf_fib_lookup *params,
 	memset(params, 0, sizeof(*params));
 
 	params->l4_protocol = IPPROTO_TCP;
-	params->ifindex = ifindex;
+	params->ifindex = test->iif ? if_nametoindex(test->iif) : ifindex;
 	params->tbid = test->tbid;
 	params->mark = test->mark;
+	params->tot_len = test->tot_len;
+
+	/* h_vlan_proto/h_vlan_TCI union with tbid */
+	if (test->lookup_flags & BPF_FIB_LOOKUP_VLAN_INPUT) {
+		params->h_vlan_proto = htons(test->vlan_proto);
+		params->h_vlan_TCI = htons(test->vlan_id);
+	}
 
 	if (inet_pton(AF_INET6, test->daddr, params->ipv6_dst) == 1) {
 		params->family = AF_INET6;
@@ -352,6 +702,21 @@ void test_fib_lookup(void)
 		if (tests[i].expected_dst)
 			assert_dst_ip(fib_params, tests[i].expected_dst);
 
+		if (tests[i].expected_dev)
+			ASSERT_EQ(fib_params->ifindex,
+				  if_nametoindex(tests[i].expected_dev), "ifindex");
+
+		if (tests[i].expected_mtu)
+			ASSERT_EQ(fib_params->mtu_result, tests[i].expected_mtu,
+				  "mtu_result");
+
+		if (tests[i].check_vlan) {
+			ASSERT_EQ(fib_params->h_vlan_proto,
+				  htons(tests[i].vlan_proto), "h_vlan_proto");
+			ASSERT_EQ(fib_params->h_vlan_TCI,
+				  htons(tests[i].vlan_id), "h_vlan_TCI");
+		}
+
 		ret = memcmp(tests[i].dmac, fib_params->dmac, sizeof(tests[i].dmac));
 		if (!ASSERT_EQ(ret, 0, "dmac not match")) {
 			char expected[18], actual[18];
@@ -361,8 +726,12 @@ void test_fib_lookup(void)
 			printf("dmac expected %s actual %s ", expected, actual);
 		}
 
-		// ensure tbid is zero'd out after fib lookup.
-		if (tests[i].lookup_flags & BPF_FIB_LOOKUP_DIRECT) {
+		/* ensure tbid is zero'd out after fib lookup. With
+		 * BPF_FIB_LOOKUP_VLAN the union holds the packed vlan
+		 * fields instead, so skip the check for those.
+		 */
+		if ((tests[i].lookup_flags & BPF_FIB_LOOKUP_DIRECT) &&
+		    !(tests[i].lookup_flags & BPF_FIB_LOOKUP_VLAN)) {
 			if (!ASSERT_EQ(skel->bss->fib_params.tbid, 0,
 					"expected fib_params.tbid to be zero"))
 				goto fail;
@@ -375,3 +744,122 @@ void test_fib_lookup(void)
 	SYS_NOFAIL("ip netns del " NS_TEST);
 	fib_lookup__destroy(skel);
 }
+
+#define NS_VLAN_A	"fib_lookup_vlan_ns_a"
+#define NS_VLAN_B	"fib_lookup_vlan_ns_b"
+
+/* A VLAN device can be moved to another netns while staying registered
+ * on its parent. Neither direction may then cross the boundary: the
+ * egress flag must not publish the foreign parent's ifindex, and the
+ * input flag must fail closed rather than use a foreign ingress.
+ */
+void test_fib_lookup_vlan_netns(void)
+{
+	struct bpf_fib_lookup *fib_params;
+	struct nstoken *nstoken = NULL;
+	struct __sk_buff skb = { };
+	struct fib_lookup *skel = NULL;
+	int prog_fd, err, parent_idx, vlan_idx;
+
+	LIBBPF_OPTS(bpf_test_run_opts, run_opts,
+		    .data_in = &pkt_v6,
+		    .data_size_in = sizeof(pkt_v6),
+		    .ctx_in = &skb,
+		    .ctx_size_in = sizeof(skb),
+	);
+
+	skel = fib_lookup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		return;
+	prog_fd = bpf_program__fd(skel->progs.fib_lookup);
+	fib_params = &skel->bss->fib_params;
+
+	SYS(fail, "ip netns add %s", NS_VLAN_A);
+	SYS(fail, "ip netns add %s", NS_VLAN_B);
+
+	nstoken = open_netns(NS_VLAN_A);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns(a)"))
+		goto fail;
+
+	SYS(fail, "ip link add veth7 type veth peer name veth8");
+	SYS(fail, "ip link set dev veth7 up");
+	SYS(fail, "ip link add link veth7 name veth7.66 type vlan id 66");
+	SYS(fail, "ip link set veth7.66 netns %s", NS_VLAN_B);
+
+	parent_idx = if_nametoindex("veth7");
+	if (!ASSERT_NEQ(parent_idx, 0, "if_nametoindex(veth7)"))
+		goto fail;
+
+	/* input: the moved device is still in veth7's VLAN group, but it
+	 * lives in another netns, so the lookup must fail closed
+	 */
+	skb.ifindex = parent_idx;
+	memset(fib_params, 0, sizeof(*fib_params));
+	fib_params->family = AF_INET;
+	fib_params->l4_protocol = IPPROTO_TCP;
+	fib_params->ifindex = parent_idx;
+	fib_params->h_vlan_proto = htons(ETH_P_8021Q);
+	fib_params->h_vlan_TCI = htons(66);
+	if (!ASSERT_EQ(inet_pton(AF_INET, "10.66.0.2", &fib_params->ipv4_dst),
+		       1, "inet_pton(dst)"))
+		goto fail;
+
+	skel->bss->fib_lookup_ret = -1;
+	skel->bss->lookup_flags = BPF_FIB_LOOKUP_VLAN_INPUT |
+				  BPF_FIB_LOOKUP_SKIP_NEIGH;
+	err = bpf_prog_test_run_opts(prog_fd, &run_opts);
+	if (!ASSERT_OK(err, "test_run(input)"))
+		goto fail;
+	ASSERT_EQ(skel->bss->fib_lookup_ret, BPF_FIB_LKUP_RET_NOT_FWDED,
+		  "input across netns fails closed");
+	ASSERT_EQ(fib_params->ifindex, parent_idx, "ifindex untouched");
+	ASSERT_EQ(fib_params->h_vlan_TCI, htons(66), "tag untouched");
+
+	close_netns(nstoken);
+	nstoken = open_netns(NS_VLAN_B);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns(b)"))
+		goto fail;
+
+	/* egress: the fib result is the VLAN device here, but its parent
+	 * is in the other netns, so the swap must not happen
+	 */
+	SYS(fail, "ip link set dev veth7.66 up");
+	SYS(fail, "ip addr add 10.66.0.1/24 dev veth7.66");
+	err = write_sysctl("/proc/sys/net/ipv4/conf/veth7.66/forwarding", "1");
+	if (!ASSERT_OK(err, "write_sysctl(forwarding)"))
+		goto fail;
+
+	vlan_idx = if_nametoindex("veth7.66");
+	if (!ASSERT_NEQ(vlan_idx, 0, "if_nametoindex(veth7.66)"))
+		goto fail;
+
+	skb.ifindex = vlan_idx;
+	memset(fib_params, 0, sizeof(*fib_params));
+	fib_params->family = AF_INET;
+	fib_params->l4_protocol = IPPROTO_TCP;
+	fib_params->ifindex = vlan_idx;
+	if (!ASSERT_EQ(inet_pton(AF_INET, "10.66.0.2", &fib_params->ipv4_dst),
+		       1, "inet_pton(dst)") ||
+	    !ASSERT_EQ(inet_pton(AF_INET, "10.66.0.1", &fib_params->ipv4_src),
+		       1, "inet_pton(src)"))
+		goto fail;
+
+	skel->bss->fib_lookup_ret = -1;
+	skel->bss->lookup_flags = BPF_FIB_LOOKUP_VLAN |
+				  BPF_FIB_LOOKUP_SKIP_NEIGH;
+	err = bpf_prog_test_run_opts(prog_fd, &run_opts);
+	if (!ASSERT_OK(err, "test_run(egress)"))
+		goto fail;
+	ASSERT_EQ(skel->bss->fib_lookup_ret, BPF_FIB_LKUP_RET_SUCCESS,
+		  "egress lookup succeeds");
+	ASSERT_EQ(fib_params->ifindex, vlan_idx,
+		  "foreign parent not published");
+	ASSERT_EQ(fib_params->h_vlan_TCI, 0, "vlan fields zero");
+
+fail:
+	if (nstoken)
+		close_netns(nstoken);
+	SYS_NOFAIL("ip netns del " NS_VLAN_A);
+	SYS_NOFAIL("ip netns del " NS_VLAN_B);
+	fib_lookup__destroy(skel);
+}
-- 
2.54.0


