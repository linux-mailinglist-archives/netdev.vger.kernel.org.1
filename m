Return-Path: <netdev+bounces-271818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBUNI/+mxGmZ1wQAu9opvQ
	(envelope-from <netdev+bounces-271818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:24:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 038E032EC39
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ADE1301DC12
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CF839099C;
	Thu, 26 Mar 2026 03:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="cPkix0lc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1B1F0E34
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774495484; cv=none; b=ZZZg4r7JzBeU/SM/UW6Y/JK/STZ8VWfOXzDp0HvWRDAvv9mzqEXdvIH8B7G6VzWEo8ryXx2bJDgZ6LRIg662o5y/zsM4F0mhL/BTOR2vECRoXFELCO0wIZLa+GQnUxh8jxkcRaDqFn61X0QVGflEll3ILRjHCy0EPRYsphERauE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774495484; c=relaxed/simple;
	bh=K/PQfR8P9MVwkiIO+y1urfpkVRliInekQl8DW1MODec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bsbeqgpig0j2Jl0NNW9KQ9UVJn+WmcY6Dyk8x3jZLuO56U90nYPQScKkBgbf4354g+7nt3dEvYpOZqB5RYeYJ3IvUR715LoL+0GaY8qLoGKiMcXFNA+0DYCW9DAYxJZKMGNzj9Fg7FTClpBjPXIUnJr4UAaXJ+2mrBgwLFmyfqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=cPkix0lc; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c107ef474fso1307282eec.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774495482; x=1775100282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O0EG3jDsn9Dx1dDIZW/WxKOBZ4AbtctaYvNgsvk5XBw=;
        b=cPkix0lcMfsH1fUcrD84/Ajp/GHkVu78fUxIBzDn09PEVOjAMSmdo7bNnYbbAbvi5c
         Zcmzb/b1+IVfWXmwyXSw9gxS6Qv9iSnKnToyamRcHb1FRnQr0AbHKGPBvRQWIR2yqalq
         OaGu5ca65+qBoTBcqQ/e0AaESo9ZdJqKR5ENVUsO5daHlEkxwdM7uXhP9pNNoYGcjEJq
         zz14cQ5EC91uCDPsGhuSYHU7CsRcPEPR0kQnazRyLC+3HzKQcEzOI4mm3a9h9SevnAXH
         2+bUV4zi4qt1Kv385Aa9NsYVfvCacydXkuElruezUj+RKea+GzqQf9sjLF5HDDaGk8Mx
         5ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774495482; x=1775100282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0EG3jDsn9Dx1dDIZW/WxKOBZ4AbtctaYvNgsvk5XBw=;
        b=qZ70Z4og+gbKydiw0qDl1QeaLJb84th+YrLQkx8WQhz43D+WumPvgBJaqQOtL2OwPz
         g24srCmbEZWfxqH0K/vJIiyigXYNvjj+WQHK7WaohKnvbwt49EkiO3gBbz1dD6vtQYq2
         FaahPHoJRZYSLd/HkOeAs8uKCrmuPq/xrE3ixoIwTX8GvevpSqA9cdaJtwlH5jIZX+fK
         lozA07uUViShM3a0On76N8AApApWCEYzC/P8rAKGvrHPZhu/wOpHs/IB6pMcraMnW3zH
         fR9VUlilvOa2TO7THMbQGPYM9WuJThQd7xGsMYJc0culJG2QPB1K6JXBoOVUUGr+XwDt
         yFpA==
X-Gm-Message-State: AOJu0YzPFbz02GgUWRvGs+RuLb/170NVjsHCztr1m2rakU8CRGpF8BlR
	N8RidxKATPy/UVyiUx5h78LDzNxTtx6EJCC/ovkjytuHhcb1srQeJFUm8+HWbSePu3QxamF3Nk4
	wFeQczQ==
X-Gm-Gg: ATEYQzwdgK9J3InmIw/Ik+/IwtcJ7vMXz2m8pZy5i6ItaJNmT3JSUB93ZurCjrInvnN
	+y77ymL/WT2k2f78g7HGvfON8pVR4Vp4n+FyeberyCjJ+fZVwGrG7UDvRvG7JwEbMMgj/phc314
	wt1dYPW4UsuEgwFvqnxvKvT5vX1Yq7rMo1X887Z4p1Yau3vg5GHnDadIJQRluNRBB31Ff61TKmy
	EY0NrjH2AHIgfC6KVZ80YPUXQaXhLSP7AraPkvCcsJcNFNIICeajoXMmlVMgQFVLWrr6GJQzmyA
	lOpb8vNhrOuaOXgroBCd187LxRdXnZhbT859ksAFzu4w7e1s3ug5GSNvA9/qYAFITfltaQv9VEW
	UkcB6PZPozUdEfWzSUnVaikjjCReNuOsufTgcIj0X4nZwSujvwjZ6KPrprwOygqqFlhttmrLZrj
	/q3OZpbzDCHEJKRGaO4DMqbe3yH+WME2aQBE7w8FxSsbI5VaabxFPWWA==
X-Received: by 2002:a05:7301:ea7:b0:2be:a2d8:e9e3 with SMTP id 5a478bee46e88-2c15d468539mr3356070eec.29.1774495481658;
        Wed, 25 Mar 2026 20:24:41 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec277edsm2317280eec.3.2026.03.25.20.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 20:24:41 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM panic
Date: Wed, 25 Mar 2026 20:24:38 -0700
Message-ID: <20260326032438.3307549-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271818-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 038E032EC39
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


