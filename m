Return-Path: <netdev+bounces-272732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JgNyM4p1x2lDXwUAu9opvQ
	(envelope-from <netdev+bounces-272732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:30:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2130F34D828
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B7603024144
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 06:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEFE30F7EA;
	Sat, 28 Mar 2026 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="GloBB0Zl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328E1192D97
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774679405; cv=none; b=DGgYVm02UVqIDZ4yl86kEo97Buh8a4KFLHGvX9kMEfNJImISVIVNjQQWV8kPTtV8W6NMFLUp8Yjo5wNggM2pqxWC549egXXHHaHjycZYneoggwB9xiTosHHwFivMM+7I+fCfuQowdYKSVqaP9s6TOdmXgWKqYf2SxzfGyVrjE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774679405; c=relaxed/simple;
	bh=xW1wc94YfM9S77eQBr4XSjqABGmaEYNxYjRtreidgFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsOEBWEp0A0MrzOO5yzd78Jt2ecHfEewKoCsHrmjGVf+v1D+3uli19+rtv0Y10+Keun25empUrDHeXyb2X2exCW1FCZ0tzMzalVCuXlGBwi3EL73xs37JeikwXiSKuK2hZeZndEspRjNP34rTrpDH0ktLBcdzqWD+F2OzlgWEcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=GloBB0Zl; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c17d152c01so1843452eec.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774679403; x=1775284203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZC3wXGU2hX/iAEcs6Ou5xr77klGlMLsUM+XsPJ10yg=;
        b=GloBB0ZltjHrma10bs7fKhvkECF5Lk73Z/mcx25cYJiVChHvWMnX4E0TQUf9yRwXrT
         UR7F4pmgGRMe/ojsJ/5Gj7dztYYe7yWG8DYC12GIuhdSUuNNiehqro3eR4ducHi5dg0h
         vCKUGO/+VLJlwh4ZCq76+byl2NVwr4o1qUwLx+BhJA00oiKpSgNtTa+FTVAtUjj3TrHn
         bHMP5WCZTcw65fxFnfaB7Y/L4quTY9UAzUYimKQyCbN8PoHXnJezXlvos05Vpaeeitvy
         CiYXzQlheaK0f80vbCTYxhXhKlkCiEnZshTUpOa1/qd+4jD6tASpzCc/NmBA7wIdQ8Fg
         4q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774679403; x=1775284203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZC3wXGU2hX/iAEcs6Ou5xr77klGlMLsUM+XsPJ10yg=;
        b=ReD1PHyaliEhFvUYK5qIaDnvF80f0x58ZBg/fwdnDuTAfYt3+oBu6NqZy2Q+CTU6VC
         w1OdD4nnLJ2hSzvgmwSxcVq8GuG3blVMCxLeTxlwOjdPkMjtSM1DoFatduhsIn9NAdO/
         Ryccr89ech03NJupx5YoGXcv3balTskH0XI8EaOmA9j89RFfTWIIZPw5xjCextOqFkNM
         sPvCPe7E5YYVvJCsv1OATBkGauWzKleESrXssNL6oKOHgRdx1REJVhB6QOt5cFmEMg+M
         7F7AIfxyc9a5FAGsSeztrypZUZgYBfEWsJne6vSkncZMG2pYNzeXp83/CB4sW/Z9KxLI
         suMw==
X-Gm-Message-State: AOJu0YzAy2ZQCzhinAfpUA8QOM8M5WtnmB/hhbLJpPAaPCY2Lv6HGX5D
	vAsAG55LYlqZKO70BxxPReVK/mDUHYZqkYHzoYqblhPnloX4j7/Nac0uXR66uZKHxuqe2OKGjIA
	OqckMxA==
X-Gm-Gg: ATEYQzx4v8U8J5IOYBvlpWsnkxegGeRRi2kTxskl2ljf3vrftGtVFjd7/fqkJXz3Dgj
	W26FJgT1yTzQk9XuF4qXkJ0jdI6CT+tX+YIMLs8EfuvoHe3LeJzAsdJ8Lh1KoNUFCquQ496lqjS
	M+FHNijHEhTfWwiY5w70qBEzRn9S8suN96haZPNmt2/3umZr5S6iVqjyY04l8ntnBH5dIuihC9g
	73cnHVUDx1bAwrJv0RdU8J1UG5CVQXxwNLPUd6mJlJwdaT7H8b83QzGqOY0TtmmYaGcHHSCMKOY
	LMMSSHUD3ydYYPOme1+WpxYdIsuKsayKOxT9MSglJZJb6nOYyshJNRKVSW5ed5rz2wcLG34pgY3
	7La1FgLCgkDeT/VJG3DIuZVOnZ96h5Nl8nVdDce09XkQqoXqGUHu9Vmw+nAib6G1xemQMT5V3iI
	BTS/LUAyWvk9xNO2/6l5ZxO7ZdNwBgD+M5A82C6T3hyFJsEX2sGt5i8A==
X-Received: by 2002:a05:7300:ac8a:b0:2be:fe8:8b0a with SMTP id 5a478bee46e88-2c185e44a68mr2625453eec.21.1774679403069;
        Fri, 27 Mar 2026 23:30:03 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7483ffcsm1376216eec.26.2026.03.27.23.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 23:30:02 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	horms@kernel.org,
	razor@blackwall.org,
	kuba@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2] bridge: mrp: reject zero test interval to avoid OOM panic
Date: Fri, 27 Mar 2026 23:30:00 -0700
Message-ID: <20260328063000.1845376-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272732-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,blackwall.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:dkim,asu.edu:email,asu.edu:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2130F34D828
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
interval value from netlink without validation. When interval is 0,
usecs_to_jiffies(0) yields 0, causing the delayed work
(br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
itself with zero delay. This creates a tight loop on system_percpu_wq
that allocates and transmits MRP test frames at maximum rate, exhausting
all system memory and causing a kernel panic via OOM deadlock.

The same zero-interval issue applies to br_mrp_start_in_test_parse()
for interconnect test frames.

Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
netlink attribute parsing layer before the value ever reaches the
workqueue scheduling code. This is consistent with how other bridge
subsystems (br_fdb, br_mst) enforce range constraints on netlink
attributes.

Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/bridge/br_mrp_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
index ce6f63c77cc0..86f0e75d6e34 100644
--- a/net/bridge/br_mrp_netlink.c
+++ b/net/bridge/br_mrp_netlink.c
@@ -196,7 +196,7 @@ static const struct nla_policy
 br_mrp_start_test_policy[IFLA_BRIDGE_MRP_START_TEST_MAX + 1] = {
 	[IFLA_BRIDGE_MRP_START_TEST_UNSPEC]	= { .type = NLA_REJECT },
 	[IFLA_BRIDGE_MRP_START_TEST_RING_ID]	= { .type = NLA_U32 },
-	[IFLA_BRIDGE_MRP_START_TEST_INTERVAL]	= { .type = NLA_U32 },
+	[IFLA_BRIDGE_MRP_START_TEST_INTERVAL]	= NLA_POLICY_MIN(NLA_U32, 1),
 	[IFLA_BRIDGE_MRP_START_TEST_MAX_MISS]	= { .type = NLA_U32 },
 	[IFLA_BRIDGE_MRP_START_TEST_PERIOD]	= { .type = NLA_U32 },
 	[IFLA_BRIDGE_MRP_START_TEST_MONITOR]	= { .type = NLA_U32 },
@@ -316,7 +316,7 @@ static const struct nla_policy
 br_mrp_start_in_test_policy[IFLA_BRIDGE_MRP_START_IN_TEST_MAX + 1] = {
 	[IFLA_BRIDGE_MRP_START_IN_TEST_UNSPEC]	= { .type = NLA_REJECT },
 	[IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID]	= { .type = NLA_U32 },
-	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= { .type = NLA_U32 },
+	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= NLA_POLICY_MIN(NLA_U32, 1),
 	[IFLA_BRIDGE_MRP_START_IN_TEST_MAX_MISS]	= { .type = NLA_U32 },
 	[IFLA_BRIDGE_MRP_START_IN_TEST_PERIOD]	= { .type = NLA_U32 },
 };
-- 
2.43.0


