Return-Path: <netdev+bounces-187784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F85AA9A05
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE6D189490B
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C7D26D4DB;
	Mon,  5 May 2025 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABxFqY4k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09342690ED
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464549; cv=none; b=uMLHmPtILee7eFT+BD6DrieJq1gBzGgiuij7yOQrRc62/g89e8lnAfPCnzbPkO3Yu1Xu91gaZwKn3mK0nJrHm1L8xQk7JxORF8Ooi8WFMv804TKUs9Xhr8kfiRiN34GtYsNC6GMmd5bo4ntDbGKj0O6+5ZeGOE8iqLZry43ArSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464549; c=relaxed/simple;
	bh=VubQCrIJgimgSGw0AaCg5LLPW+uskXj70iRqkxBAvO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1KygAHo3YE6W6MadzixLCWR26tOdL42AD0Pp+sAsIlfqkT0wn4AxO7fV6GGhUykAvd+MMtSxgosEXK5QuSJ9EnHBUXFqS8ATudI4qJtE3OaCTSMUmr79U5QsR+iP5Qxt3YxgrbQlMmOX6WtZDV5cGOqh1AVO21Gsql/6yt7A88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABxFqY4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38431C4CEF3;
	Mon,  5 May 2025 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746464548;
	bh=VubQCrIJgimgSGw0AaCg5LLPW+uskXj70iRqkxBAvO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ABxFqY4kHRBPL5zgPzTDtd7APyeck5tjgxWShvbvlN4HJDX3TceyBrRUvTN/u8E3B
	 wdlhnOz0wZcTNSvhhgI4NDlgD+dWMisMBM+QDn2rNM5Ml7kSl438nDsKqGG/pO7N0k
	 I4jlTV6mC5NniJMrFOwDuLpQjn/y5Iy8HPJOFuA2lUUEZ6HGDoIdAcT3puEBChs++j
	 EbrpZudPBxvlr0w3gz8ofgMZBfkuWKkVyC9Kvvk8g8pQ1qI8UQkVpvUUwjc9ZO6VHO
	 Ji/Dl6d1z1RLOgqBDrPUnasz5jQ1gQruQ1ar1G6Qimc82tYeUsGMcHuakFSFCQnG7Z
	 CdclBhVeJ76mQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	johannes@sipsolutions.net,
	razor@blackwall.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/4] netlink: specs: remove implicit structs for SNMP counters
Date: Mon,  5 May 2025 10:02:14 -0700
Message-ID: <20250505170215.253672-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505170215.253672-1-kuba@kernel.org>
References: <20250505170215.253672-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uAPI doesn't define structs for the SNMP counters, just enums to index
them as arrays. Switch to the same representation in the spec. C codegen
will soon need all the struct types to actually exist.

Note that the existing definition was broken, anyway, as the first
member should be the number of counters reported.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-link.yaml | 60 +++++-------------------
 1 file changed, 12 insertions(+), 48 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index cc95c12e7a3b..2fbf4ac55c9c 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -585,138 +585,102 @@ protonum: 0
         type: u32
   -
     name: ifla-icmp6-stats
-    type: struct
-    members:
+    enum-name:
+    type: enum
+    entries:
+      -
+        name: num
       -
         name: inmsgs
-        type: u64
       -
         name: inerrors
-        type: u64
       -
         name: outmsgs
-        type: u64
       -
         name: outerrors
-        type: u64
       -
         name: csumerrors
-        type: u64
       -
         name: ratelimithost
-        type: u64
   -
     name: ifla-inet6-stats
-    type: struct
-    members:
+    enum-name:
+    type: enum
+    entries:
+      -
+        name: num
       -
         name: inpkts
-        type: u64
       -
         name: inoctets
-        type: u64
       -
         name: indelivers
-        type: u64
       -
         name: outforwdatagrams
-        type: u64
       -
         name: outpkts
-        type: u64
       -
         name: outoctets
-        type: u64
       -
         name: inhdrerrors
-        type: u64
       -
         name: intoobigerrors
-        type: u64
       -
         name: innoroutes
-        type: u64
       -
         name: inaddrerrors
-        type: u64
       -
         name: inunknownprotos
-        type: u64
       -
         name: intruncatedpkts
-        type: u64
       -
         name: indiscards
-        type: u64
       -
         name: outdiscards
-        type: u64
       -
         name: outnoroutes
-        type: u64
       -
         name: reasmtimeout
-        type: u64
       -
         name: reasmreqds
-        type: u64
       -
         name: reasmoks
-        type: u64
       -
         name: reasmfails
-        type: u64
       -
         name: fragoks
-        type: u64
       -
         name: fragfails
-        type: u64
       -
         name: fragcreates
-        type: u64
       -
         name: inmcastpkts
-        type: u64
       -
         name: outmcastpkts
-        type: u64
       -
         name: inbcastpkts
-        type: u64
       -
         name: outbcastpkts
-        type: u64
       -
         name: inmcastoctets
-        type: u64
       -
         name: outmcastoctets
-        type: u64
       -
         name: inbcastoctets
-        type: u64
       -
         name: outbcastoctets
-        type: u64
       -
         name: csumerrors
-        type: u64
       -
         name: noectpkts
-        type: u64
       -
         name: ect1-pkts
-        type: u64
       -
         name: ect0-pkts
-        type: u64
       -
         name: cepkts
-        type: u64
       -
         name: reasm-overlaps
-        type: u64
   - name: br-boolopt-multi
     type: struct
     header: linux/if_bridge.h
@@ -2198,7 +2162,7 @@ protonum: 0
       -
         name: stats
         type: binary
-        struct: ifla-inet6-stats
+        sub-type: u64
       -
         name: mcast
         type: binary
@@ -2209,7 +2173,7 @@ protonum: 0
       -
         name: icmp6stats
         type: binary
-        struct: ifla-icmp6-stats
+        sub-type: u64
       -
         name: token
         type: binary
-- 
2.49.0


