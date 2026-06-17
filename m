Return-Path: <netdev+bounces-300262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NRLRCwgkM2qU9wUAu9opvQ
	(envelope-from <netdev+bounces-300262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:47:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B169CB8F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:47:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=db7lAJfT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300262-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300262-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7152F301F319
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 22:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E06A3A3E7E;
	Wed, 17 Jun 2026 22:47:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600739B4A3
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 22:47:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781736451; cv=none; b=P0lnMVa+nzgbuDywU7b9gsPaQYr5s6CZz3H/51y2TlHQO4al/pDJuCgeU67STzs0rXl8X6VrUs3KjFL+YFxRLNQA2j2mo7IRK4bz20pvS6T+sVU4ItaXpi7TbrynCoHVRFMaYyzhhHTKz4VK/4ALKIbaJ4n0TqCNvuuZRpiJD/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781736451; c=relaxed/simple;
	bh=yM6kJR9+j6KBxCtaM2cYf0AuV1XZewak4TynnyV+IJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKX4k1UQswyDH5EaXdMT8CN7vjJ6crc72gbnLu2/UoRrCn32JJsqdoSPM2vrtHiFqcfXMiuvCZ8FBqhguC8qi/uacy7BTq4KXpZRTitBqq6q5rhzXLiqwK8lZXgXuwde8DtA3t0Lnj/o/J5xt+utuA3YrpD4oZHzJShaHYx8m7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db7lAJfT; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36da8439078so210397a91.2
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 15:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781736449; x=1782341249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/ktcGtRdK8bOsxRZ/ZQSsMpZyLcq8Ea6Ees+j5Oy2A=;
        b=db7lAJfT2508SaTj8ZaJjvJLGtMNAIzbaFykFFUCY8wP618uagcRrrNNmxGCZI1wWV
         Xw2Gq/Db/wjFscO5Fz6w/0EKdvNwRwwR/iva/mAXSoJRjowls7i4zmbYVveHKwDfQepg
         2f34Rt+a7XFf0qm2rt+cQu37oKu5WqZsbElmktuArryLBZSF7uAh1TudDCb433+LhG5T
         7pbYH+LzPubGcShnXaLnquhrnZzdYketiAhHBW2z0q/u+emd9ja/d1/c8lNtRG2yldhU
         9QFm8tpCXHKwjRPBadweLHaMC7NmIgrfAV5oRBnR6o77i1tvOlMMTbPD/tLBHH+LTA+k
         xwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781736449; x=1782341249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/ktcGtRdK8bOsxRZ/ZQSsMpZyLcq8Ea6Ees+j5Oy2A=;
        b=mZY0XCjj3odvK+EYDQU/6QYIldBCXC7wJ3Ry9KNMrEwXoAHAs/wXpCPFm5MrbXbLNT
         RRciXTwHlXqzwERngJG6drsmXbNXRwvmMNmKTSdxuTeS6Di6Q9n38x0SSA8QMW7r5kp4
         GHSNxH6mmMM3UWBRqtIbJAaoi/LTNu9HMdUN+BUpnI7QqsWDO+7x6uUVuje4FzFTsZFD
         jXef2m6zlFwYH3JzyO9termIi6NRl31EHQcht3+6mu9MxlvtN/z+e8eOJyST9XF3d99c
         bhm4e36wG0dzEKVSrJNx9R9BXuX+1I3YQUGirl3DbZM+BxoDnB8QDfjzB+TB4RdYOKxO
         OGKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gGfaexDByZS58Q0EwohD7RB5eB/n1jnZlkALWnIu8vVgaeF4VwBJC5rfgZkpl2oxQRA/XCHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOUinL8qtanZXu7JpmzMlrojccMJhLEQ36FPMiMiX/2ZzkDR5r
	yGWpVYwwQNbCNeD1bedHTS3ZFpCXyJYfJ4K+m0TJ1AcMjkba2boTxvkb
X-Gm-Gg: AfdE7cn8nRVKgaq+0YX730bK6AYKBsxyIxZ98y59lcfmLLufeiy6JdjB9n9c8LxCAJD
	b33VNeMYcEwhR5jtyBAo3BEpKOv+TO/VeIK1M2VoPoEPNQPhHhrhk4U5lDTS6thbDYJbUSWpD/Q
	ssi7FJb3Kv+a2lgRTjFUoio9Bgb1Q4gm5yxrBCtPQ3yCpbaLAdFrKNMiCHz20o6ziIIhiLth4J1
	0xQjiFcVF4RkrjTS6Hff4TCTaccMjLwznoZ42OS1QtsOAdMaWRxZYenokXrgtGObn4zw55h7EKk
	T46LbhJC+F7KCTRedZ8Mm3+iyxQnkno+FV/MPeLeVXiyVgYlSR+Vx0aSj8p4VdEXBBIqOJAPqlw
	MiC7qqeE9gwT62kw+rcY/kqWUvKObuPlXhWlTzLF4jrpre+EOZdObGAwEYZQ3IKMnzYxKO99F4h
	Xyjzgtc/b/kJ68vB9jApPiMsc90JzZEVl1rYUHPf1xz8VuuAdreZD1WKFlvQ2H
X-Received: by 2002:a17:90b:2e85:b0:368:af5c:5925 with SMTP id 98e67ed59e1d1-37c94b136bdmr5931252a91.23.1781736449387;
        Wed, 17 Jun 2026 15:47:29 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5d505sm14890344a12.1.2026.06.17.15.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 15:47:28 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	eddyz87@gmail.com,
	edumazet@google.com,
	emil@etsalapatis.com,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	song@kernel.org,
	toke@redhat.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf] bpf: zero-initialize the fib lookup flow struct
Date: Thu, 18 Jun 2026 04:17:19 +0530
Message-ID: <20260617224719.1428599-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-300262-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:dsahern@kernel.org,m:eddyz87@gmail.com,m:edumazet@google.com,m:emil@etsalapatis.com,m:horms@kernel.org,m:john.fastabend@gmail.com,m:jolsa@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sdf@fomichev.me,m:song@kernel.org,m:toke@redhat.com,m:yonghong.song@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,gmail.com,google.com,etsalapatis.com,linux.dev,redhat.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 333B169CB8F

bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() build the flow key on
the stack with a bare "struct flowi4 fl4;" / "struct flowi6 fl6;" and
fill it field by field, but never set flowi4_l3mdev / flowi6_l3mdev.

On the non-DIRECT path the lookup goes through the fib rules whenever the
netns has custom rules, which a VRF installs:

	bpf_ipv4_fib_lookup() -> fib_lookup() -> __fib_lookup()
	  -> l3mdev_update_flow()   reads !fl->flowi_l3mdev
	  -> fib_rules_lookup() -> fib_rule_match()
	       -> l3mdev_fib_rule_match()   uses fl->flowi_l3mdev

l3mdev_update_flow() resolves the l3mdev master from the ingress device
only while the field is still zero. Left at a nonzero stack value the
resolution is skipped, and l3mdev_fib_rule_match() then tests that value
as an ifindex, so the VRF master is not resolved and the rule fails to
match: an ingress enslaved to a VRF can fail to select its table. FIB
rules matching on an L3 master device (l3mdev_fib_rule_iif_match()/
_oif_match()) read the same value, so an "ip rule iif/oif <vrf>"
mismatches the same way.

Zero-initialize the whole flow struct rather than adding one more
field assignment, so any flowi field added later is covered too.
ip_route_input_slow() likewise zeroes the field before its input lookup.

CONFIG_INIT_STACK_ALL_ZERO masks this by default, but it depends on
compiler support (CC_HAS_AUTO_VAR_INIT_ZERO), so INIT_STACK_NONE builds,
including older toolchains that fall back to it, are exposed. Built with
INIT_STACK_ALL_PATTERN, a plain bpf_fib_lookup (no VLAN, no DIRECT) over a
VRF slave whose destination is routed only in the VRF table returns
BPF_FIB_LKUP_RET_NOT_FWDED, and resolves with this patch. On the default
config the lookup succeeds either way, so ordinary testing does not catch
the bug.

Fixes: 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices")
Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..7c58df589826 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6139,7 +6139,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	struct in_device *in_dev;
 	struct net_device *dev;
 	struct fib_result res;
-	struct flowi4 fl4;
+	struct flowi4 fl4 = {};
 	u32 mtu = 0;
 	int err;
 
@@ -6279,7 +6279,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	struct neighbour *neigh;
 	struct net_device *dev;
 	struct inet6_dev *idev;
-	struct flowi6 fl6;
+	struct flowi6 fl6 = {};
 	int strict = 0;
 	int oif, err;
 	u32 mtu = 0;
-- 
2.54.0


