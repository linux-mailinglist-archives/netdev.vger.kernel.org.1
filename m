Return-Path: <netdev+bounces-188463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F671AACE30
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 21:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C027B23CE
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 19:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0452F20CCFB;
	Tue,  6 May 2025 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nwlfm7Ql"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201920C478
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560481; cv=none; b=fiFmsMT2G1bC5cYCGXXxtRg1aUeaQPJvbrRA1HkfPPLmouM3CEIa3J930P8S4AY1VEWI6tZRtgFYuA49+3tmEvjC0jfL2VzWQ6ONqfPdt1pvzf9iZMR7q++JdeqNXoy/d0JDohUt3011bkicjLjvBTgJ0PwKa58RsrFSSuUfj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560481; c=relaxed/simple;
	bh=ir08aAcPv3HYgyxCMBR5VRZYKPF8iLdLtTICCyqYq4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFNSfaJA8fFO7SwMX0cC1T8blxg8oFPzwSMWjsfe67aylXA5XOa83l1q0ptS7PEMOtwRNQdsu+fa4Cm2rVGEtpfjH41gNVgyDlXLxI2KWPmuCUdpj6lPUcoA6KZ4luKKUjZVnSfdpqAYXUpnTYqxhMdzrjIFwTUaCL/13EqsvfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nwlfm7Ql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6B5C4CEF2;
	Tue,  6 May 2025 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746560481;
	bh=ir08aAcPv3HYgyxCMBR5VRZYKPF8iLdLtTICCyqYq4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nwlfm7Qlyfd8KJhpF1B7+nhmQKxxZJxNVc4PPJ8+MjpUIMnbIuSybpTrh4NCEU5Pj
	 ILs+XUX6pqXMzbJaCPMNCpOoQn8e4dg+TIjC8VJpCwnWBaSCTRDuYAGGCS62ZVJz0E
	 OEVw4ivKnGc/iuQy3zjDK0QsHdNPLcg85P2nW1REgs/Nqqt2CS49mxl3PMB8AmvSnG
	 BLlibfw5s2uMYa2PnOIXUQfDPqXem8xR9x5ptZKW6kh88dnti5VvjMol6bY6RlV6Zk
	 yqE3N2vblgi0vwNCdNj8iyMI4dfxs6i6zV38aBZ7UwgDZ8DkX6J4vg7GDdr44uMgEO
	 t8GsNxeqMBFJw==
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
Subject: [PATCH net-next v2 3/4] netlink: specs: remove implicit structs for SNMP counters
Date: Tue,  6 May 2025 12:40:59 -0700
Message-ID: <20250506194101.696272-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506194101.696272-1-kuba@kernel.org>
References: <20250506194101.696272-1-kuba@kernel.org>
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
index 25f0c3c6a886..fa5ff70f2f5f 100644
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
     members:
@@ -2195,7 +2159,7 @@ protonum: 0
       -
         name: stats
         type: binary
-        struct: ifla-inet6-stats
+        sub-type: u64
       -
         name: mcast
         type: binary
@@ -2206,7 +2170,7 @@ protonum: 0
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


