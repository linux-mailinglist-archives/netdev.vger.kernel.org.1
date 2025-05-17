Return-Path: <netdev+bounces-191239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6387DABA749
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A53188D279
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2308F136A;
	Sat, 17 May 2025 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/jo310u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14C820ED
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440813; cv=none; b=KMlxPLykhdqqqIP5kybn1bTURcmL5FGlMX0dmTvwAB1dFemikrvbBF9vzFXhvlu1zBZeo1BiG7XhllwAVAiGxHR2JZlm3+I6h0jg/8izjT1H2gtjdxc29a7WDZoMskpq2v3H6EwnLWBrVq7SXTgy6kP9ZgYa7eBiltp6indYdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440813; c=relaxed/simple;
	bh=rq6o67lxeJJUFBtmfuzMQAv9Xlx0KyqRdjj8bJs9WAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7+WqYVQjZ/oNcm+o8zmzYXXqqT8dC+KD7HJzCblgoC0Q/jBFB8BxJXQlP2QIMf1HT6XYVtfxvPRStyXeG+tCdEVJ+YZydh4UBNqMIN1exEypnBOeRQmD+/+sk2zHIv+T9fZJRP1Xo7igsv+qjCSyKobjRtsdiCdiKjGYyZxFPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/jo310u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC63C4AF09;
	Sat, 17 May 2025 00:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747440812;
	bh=rq6o67lxeJJUFBtmfuzMQAv9Xlx0KyqRdjj8bJs9WAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/jo310uZ5/XXk7mrvcu7V45dsM5pdIJTM8w/EtwXi+xil0ngOPY5iDX/pbqKWHtu
	 dwW3l2+/K+San3U9y8//YRejFPHKAH/36PqvqZoPm4LI6M6OdoWN4o6agL6Bbtsll1
	 76P9jPc+AGI7fhNrNqlZDhOHa9bqnEljTuj5YadTsX/L7OpoVwnlTdtTGdrR3xH0jb
	 Yhfx/cJYFcuDkkrNa+YGJnZ70joU9AxIWcowqEtW8nRvPoZ31E8mY12Qjuoxf7+hLV
	 abmAma/I3VeJn7Wg3nu7r+FefplMV/hPoUINX7WTEod9hbqJ/z7KCfrtI1wYIIC5gX
	 0hvyma8xD0IfA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 01/11] netlink: specs: tc: remove duplicate nests
Date: Fri, 16 May 2025 17:13:08 -0700
Message-ID: <20250517001318.285800-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250517001318.285800-1-kuba@kernel.org>
References: <20250517001318.285800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tc-act-stats-attrs and tca-stats-attrs are almost identical.
The only difference is that the latter has sub-message decoding
for app, rather than declaring it as a binary attr.

tc-act-police-attrs and tc-police-attrs are identical but for
the TODO annotations.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/tc.yaml | 78 ++---------------------------
 1 file changed, 4 insertions(+), 74 deletions(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 953aa837958b..c7e6a734cd12 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -1452,7 +1452,7 @@ protonum: 0
       -
         name: stats
         type: nest
-        nested-attributes: tc-act-stats-attrs
+        nested-attributes: tca-stats-attrs
       -
         name: pad
         type: pad
@@ -1471,38 +1471,6 @@ protonum: 0
       -
         name: in-hw-count
         type: u32
-  -
-    name: tc-act-stats-attrs
-    attributes:
-      -
-        name: basic
-        type: binary
-        struct: gnet-stats-basic
-      -
-        name: rate-est
-        type: binary
-        struct: gnet-stats-rate-est
-      -
-        name: queue
-        type: binary
-        struct: gnet-stats-queue
-      -
-        name: app
-        type: binary
-      -
-        name: rate-est64
-        type: binary
-        struct: gnet-stats-rate-est64
-      -
-        name: pad
-        type: pad
-      -
-        name: basic-hw
-        type: binary
-        struct: gnet-stats-basic
-      -
-        name: pkt64
-        type: u64
   -
     name: tc-act-bpf-attrs
     attributes:
@@ -1797,44 +1765,6 @@ protonum: 0
       -
         name: key-ex
         type: binary
-  -
-    name: tc-act-police-attrs
-    attributes:
-      -
-        name: tbf
-        type: binary
-        struct: tc-police
-      -
-        name: rate
-        type: binary # TODO
-      -
-        name: peakrate
-        type: binary # TODO
-      -
-        name: avrate
-        type: u32
-      -
-        name: result
-        type: u32
-      -
-        name: tm
-        type: binary
-        struct: tcf-t
-      -
-        name: pad
-        type: pad
-      -
-        name: rate64
-        type: u64
-      -
-        name: peakrate64
-        type: u64
-      -
-        name: pktrate64
-        type: u64
-      -
-        name: pktburst64
-        type: u64
   -
     name: tc-act-simple-attrs
     attributes:
@@ -3327,10 +3257,10 @@ protonum: 0
         struct: tc-police
       -
         name: rate
-        type: binary
+        type: binary # TODO
       -
         name: peakrate
-        type: binary
+        type: binary # TODO
       -
         name: avrate
         type: u32
@@ -3817,7 +3747,7 @@ protonum: 0
         attribute-set: tc-act-pedit-attrs
       -
         value: police
-        attribute-set: tc-act-police-attrs
+        attribute-set: tc-police-attrs
       -
         value: sample
         attribute-set: tc-act-sample-attrs
-- 
2.49.0


