Return-Path: <netdev+bounces-182480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A92A88DA8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1C6189840F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225AC1F3BB4;
	Mon, 14 Apr 2025 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIBczYrL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92F1F3B9E
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665602; cv=none; b=p5iKD25xYWI+PhPTh9TfKUX+TYzfKu9IfW4x0JoDX6z6JumR2gI/W3bZjyp6KifNilrIwr+S5dECPn3PQ6zgoAl91/vH6j+CsbtE+yANH+WM+Sy70AfMQCPMSTi9xPsJQ2QdM75DLQzFcYfgnjnYhLs1TGplIrfBOImvFhyimfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665602; c=relaxed/simple;
	bh=hcFL0r4rBPCfWHgqcNaOMIEOIgrB7jh6uwyqYKIwMN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tscxU69gQAR0iHXG/td2gLb/xy6wIzBBp5Zv9qXAWWCxpg7TPBH+r2juq3dsJjKpxTWB1MWT7W8/9100VSTjxzM/I8QFqmSVLmuEzu4qk+JfMl1nM7cHr4+Oqw5TgfoCI5TtZjcn4k02UQgEa8F3l1TxGKujWraHMNbTXZ2Io2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIBczYrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722E2C4CEE5;
	Mon, 14 Apr 2025 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744665601;
	bh=hcFL0r4rBPCfWHgqcNaOMIEOIgrB7jh6uwyqYKIwMN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIBczYrLnZtCoOcInvnWA/diiBfUB2HG8Nhv8YzDq0Dn9YlAolArCMY1V8KksH5Uy
	 d5ej61AzZ9YTjJZ3ffPbDVA/HHiLH+J0lT7+vsnk+LCDRk0WHv9PglYLYCuC9QSLV8
	 ixMAIIms8pwIeO7z8+EvHHkGLWaaFH9Mev1YytxPdorMXdWhpnHM1kbH/Bt3HiMH+C
	 zUTuyzUY9FDvKHd3pNgzLxf0Jt3Q7hs67F0xpSbWlw5Z/5GOdIBYdawtJfhWdd24Ar
	 xPv45ksOrrT9rFO2coZRq8DI18ydtnmss8G2h8zQo77/k2B3TkLRRu+F7OmBY8qHZM
	 L5nH9IlZDsLow==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	sdf@fomichev.me,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 5/8] netlink: specs: rt-link: add an attr layer around alt-ifname
Date: Mon, 14 Apr 2025 14:18:48 -0700
Message-ID: <20250414211851.602096-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414211851.602096-1-kuba@kernel.org>
References: <20250414211851.602096-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alt-ifname attr is directly placed in requests (as an alternative
to ifname) but in responses its wrapped up in IFLA_PROP_LIST
and only there is may be multi-attr. See rtnl_fill_prop_list().

Fixes: b2f63d904e72 ("doc/netlink: Add spec for rt link messages")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt_link.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 31238455f8e9..200e9a7e5b11 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1113,11 +1113,10 @@ protonum: 0
       -
         name: prop-list
         type: nest
-        nested-attributes: link-attrs
+        nested-attributes: prop-list-link-attrs
       -
         name: alt-ifname
         type: string
-        multi-attr: true
       -
         name: perm-address
         type: binary
@@ -1163,6 +1162,13 @@ protonum: 0
       -
         name: netns-immutable
         type: u8
+  -
+    name: prop-list-link-attrs
+    subset-of: link-attrs
+    attributes:
+      -
+        name: alt-ifname
+        multi-attr: true
   -
     name: af-spec-attrs
     attributes:
@@ -2453,7 +2459,6 @@ protonum: 0
             - min-mtu
             - max-mtu
             - prop-list
-            - alt-ifname
             - perm-address
             - proto-down-reason
             - parent-dev-name
-- 
2.49.0


