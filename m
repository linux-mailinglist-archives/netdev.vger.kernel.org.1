Return-Path: <netdev+bounces-194793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49648ACC885
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 15:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1D93A6A8F
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D213D238C36;
	Tue,  3 Jun 2025 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk4JOYf/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43B238C2D
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958843; cv=none; b=TbiikRYrQ5Z7Yr9tLZC175NdK6cwitLImO8LzOrWni9JOIXkBypIa/WVSq1DdmK+WdlVbu9IYCM69+3m44IF5Z1W9PVZoNm+BzzSiMm+3HjTErhuiqdABAp3hxVzMEJ+4JGCM7wrUqCBiIho74SaSjy3JPOncDtaNQ7OpHgBGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958843; c=relaxed/simple;
	bh=B5yfQ0VznwQpXE+djiH1tua0BNboI2YM5OujlOBiCos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgsNpDlfW2WFCd9wJxcIq3u3SFPDiIM9v5XqHomLo48UvufZ4VI5jZvBZNN1a9sooAdN0DtUvl6IKQWEoM/jbldvSGLAkgcmX93viLc0O99UdK2K+awfi9pTJO87YsGclrBHTrmus4zghNCPg9gKv81X8Nbv2WMZrePcmX5B24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk4JOYf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA42AC4CEED;
	Tue,  3 Jun 2025 13:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748958843;
	bh=B5yfQ0VznwQpXE+djiH1tua0BNboI2YM5OujlOBiCos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xk4JOYf/yfvBcn5mqQM50dSpC9e+V82NuOM26wxDU8KXWXaR2/NL9+XM8D00i0CzA
	 EAvn/Xo/+NAnkNJC9Cyw366jSjDT27PfAHmJKIqgBd9AyrBO1qRyO39vQ3fhvVTLbM
	 Owx2a/VRf71CrtY+aX0pfF7/8pN8dpPQFqu0SsGWsjnBCEtZ02nC7n/x0xgx55CE43
	 6PtqTwYnjiAFi8EEFWzvE8Edqcd9J+dhEaA9Ci+JbW+G41qz5PD35kNzEsoA0MhjD8
	 04hzeMMKVO0nS2aZXo0PMbwHDmGDEQYixt2vlBBgXsNJUd909N6KRvm8K4C8vxawJe
	 XTWGlSowPXO0g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/2] netlink: specs: rt-link: decode ip6gre
Date: Tue,  3 Jun 2025 06:53:57 -0700
Message-ID: <20250603135357.502626-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603135357.502626-1-kuba@kernel.org>
References: <20250603135357.502626-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver tests now require GRE tunnels, while we don't configure
them with YNL, YNL will complain when it sees link types it
doesn't recognize. Teach it decoding ip6gre tunnels. The attrs
are largely the same as IPv4 GRE.

Correct the type of encap-limit, but note that this attr is
only used in ip6gre, so the mistake didn't matter until now.

Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-link.yaml | 53 +++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 6521125162e6..b41b31eebcae 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1717,7 +1717,7 @@ protonum: 0
         type: u8
       -
         name: encap-limit
-        type: u32
+        type: u8
       -
         name: flowinfo
         type: u32
@@ -1760,6 +1760,54 @@ protonum: 0
       -
         name: erspan-hwid
         type: u16
+  -
+    name: linkinfo-gre6-attrs
+    subset-of: linkinfo-gre-attrs
+    attributes:
+      -
+        name: link
+      -
+        name: iflags
+      -
+        name: oflags
+      -
+        name: ikey
+      -
+        name: okey
+      -
+        name: local
+        display-hint: ipv6
+      -
+        name: remote
+        display-hint: ipv6
+      -
+        name: ttl
+      -
+        name: encap-limit
+      -
+        name: flowinfo
+      -
+        name: flags
+      -
+        name: encap-type
+      -
+        name: encap-flags
+      -
+        name: encap-sport
+      -
+        name: encap-dport
+      -
+        name: collect-metadata
+      -
+        name: fwmark
+      -
+        name: erspan-index
+      -
+        name: erspan-ver
+      -
+        name: erspan-dir
+      -
+        name: erspan-hwid
   -
     name: linkinfo-vti-attrs
     name-prefix: ifla-vti-
@@ -2239,6 +2287,9 @@ protonum: 0
       -
         value: gretap
         attribute-set: linkinfo-gre-attrs
+      -
+        value: ip6gre
+        attribute-set: linkinfo-gre6-attrs
       -
         value: geneve
         attribute-set: linkinfo-geneve-attrs
-- 
2.49.0


