Return-Path: <netdev+bounces-188461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CDBAACE2E
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 21:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88373B4CE2
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 19:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1937A2066CE;
	Tue,  6 May 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Knlm97Ib"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9541205ABB
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560481; cv=none; b=SMrqhgLr2E1v1hb6zIrSw57sXVikP9v/ioqEvTGbMs7RilKTCRwz17Z+Gy9Psoc2HfuwWKGhD9yr5oCIYhMZmUMs69c3TwLw+EfTKCwI+Wpers1OaiugI2ofjczCms2/oo2smNg+00DJwok2S3wI0MWvHTCOsxT6Rkdy8der1rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560481; c=relaxed/simple;
	bh=8g8QEgKHC5VPodA7cDA0x626vkb3UGi4kKhWnqtk9JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKJ4F3yCRnWyrgvc/URuexr6FeopES/BKO69rs8XMJ3wtydz/Z8IK7f3WS5z9P/UswUvKrZOZJA3ZP+rFUyKt9hH/zkGdLmM3N0/EAUmO3FMtFi+gcjt0WELMJiibwZQB/fL+t8i2NnNIPuHYwrOIcuKuCPFN3oarIdrI3CHpJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Knlm97Ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF3EC4CEF1;
	Tue,  6 May 2025 19:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746560480;
	bh=8g8QEgKHC5VPodA7cDA0x626vkb3UGi4kKhWnqtk9JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Knlm97Ibbssrh4FNreGifgqup8/Me3jiO4N0mNHZAVk8+sMAl+JvQ9FZRpaE4Ljvi
	 q5d14f9c9hsLhLz3/ixkr8NO3ZnWjfM+G1NRstlGcvu/S6oiuGKBN6lpJt6Skc20Ow
	 xTTmj/e/WG2Tl9p1UCTHagm43MPjGII8E3j2QPmbJ0F3ILIcndR74Zk3euyIKTRD0g
	 UdZhZGEy+IG1unmAnwAYXddI/5u2OjC/o6E36UAlQUlhWjZX3w1arSfxu5uZZkGl1a
	 yVi8kJ+MjmwDJ85XiCMHWnxaio6DZ7XouaBPoZ4O74wYBhX6pzgW+t2D5dWCgiwx+A
	 vP5jDNomErxZA==
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
Subject: [PATCH net-next v2 1/4] netlink: specs: nl80211: drop structs which are not uAPI
Date: Tue,  6 May 2025 12:40:57 -0700
Message-ID: <20250506194101.696272-2-kuba@kernel.org>
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

C codegen will soon use structs for binary types. A handful of structs
in WiFi carry information elements from the wire, defined by the standard.
The structs are not part of uAPI, so we can't use them in C directly.
We could add them to the uAPI or add some annotation to tell the codegen
to output a local version to the user header. The former seems arbitrary
since we don't expose structs for most of the standard. The latter seems
like a lot of work for a rare occurrence. Drop the struct info for now.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Link: https://lore.kernel.org/004030652d592b379e730be2f0344bebc4a03475.camel@sipsolutions.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/nl80211.yaml | 68 ------------------------
 1 file changed, 68 deletions(-)

diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index 1ec49c3562cd..3611b11a7d8f 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -203,71 +203,6 @@ protocol: genetlink-legacy
       - scan-random-mac-addr
       - sched-scan-random-mac-addr
       - no-random-mac-addr
-  -
-    name: ieee80211-mcs-info
-    type: struct
-    members:
-      -
-        name: rx-mask
-        type: binary
-        len: 10
-      -
-        name: rx-highest
-        type: u16
-        byte-order: little-endian
-      -
-        name: tx-params
-        type: u8
-      -
-        name: reserved
-        type: binary
-        len: 3
-  -
-    name: ieee80211-vht-mcs-info
-    type: struct
-    members:
-      -
-        name: rx-mcs-map
-        type: u16
-        byte-order: little-endian
-      -
-        name: rx-highest
-        type: u16
-        byte-order: little-endian
-      -
-        name: tx-mcs-map
-        type: u16
-        byte-order: little-endian
-      -
-        name: tx-highest
-        type: u16
-        byte-order: little-endian
-  -
-    name: ieee80211-ht-cap
-    type: struct
-    members:
-      -
-        name: cap-info
-        type: u16
-        byte-order: little-endian
-      -
-        name: ampdu-params-info
-        type: u8
-      -
-        name: mcs
-        type: binary
-        struct: ieee80211-mcs-info
-      -
-        name: extended-ht-cap-info
-        type: u16
-        byte-order: little-endian
-      -
-        name: tx-bf-cap-info
-        type: u32
-        byte-order: little-endian
-      -
-        name: antenna-selection-info
-        type: u8
   -
     name: channel-type
     type: enum
@@ -761,7 +696,6 @@ protocol: genetlink-legacy
       -
         name: ht-capability-mask
         type: binary
-        struct: ieee80211-ht-cap
       -
         name: noack-map
         type: u16
@@ -1382,7 +1316,6 @@ protocol: genetlink-legacy
       -
         name: ht-mcs-set
         type: binary
-        struct: ieee80211-mcs-info
       -
         name: ht-capa
         type: u16
@@ -1395,7 +1328,6 @@ protocol: genetlink-legacy
       -
         name: vht-mcs-set
         type: binary
-        struct: ieee80211-vht-mcs-info
       -
         name: vht-capa
         type: u32
-- 
2.49.0


