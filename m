Return-Path: <netdev+bounces-189509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3917AAB26C2
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 07:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1519188EA4E
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 05:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C208678F4C;
	Sun, 11 May 2025 05:12:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E331BF37
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 05:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746940360; cv=none; b=noLH00GXZ9LF9mUabny/mJDJ10WP40bHqH7oDPuULq8/u2Avk9SbKGxy1lCPxyEFUW1iaaOLt9OeG5dS6zI7nVpXIXAJNpCbAY2ksxABddzUavIvg8srfHuCrA1oQ1Lhlwfh8MVtQQGOREqf6yGkt8OK/YC4NG1gLMerwBp6j1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746940360; c=relaxed/simple;
	bh=lwHmMHvTRBC+AsVv3Yweapfzu/qO3x4wtIS9bRKa5lI=;
	h=Message-Id:From:Date:Subject:To:Cc; b=RPdWCcNqBA7Co6kSdTEdnXnPotdiICYpKYqQC/yICwWEXm/8TTEzy38/zOjFecbKALiz0sgPyL4ZxZoy1yMfYpdSQ3y1J4q/GMp8rWWpeh7eBwkWHjivq3dErDNiWMl+T2ZpuYT3giP+ZMBhH78GihuwxEpDpxGr0CF7pPmE7I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 849062C00591;
	Sun, 11 May 2025 07:12:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 764821AF2D0; Sun, 11 May 2025 07:12:27 +0200 (CEST)
Message-Id: <d6b58684b7e5bfb628f7313e6893d0097904e1d1.1746940107.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 11 May 2025 07:12:00 +0200
Subject: [PATCH net] tools: ynl-gen: Allow multi-attr without
 nested-attributes again
To: Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Since commit ce6cb8113c84 ("tools: ynl-gen: individually free previous
values on double set"), specifying the "multi-attr" property raises an
error unless the "nested-attributes" property is specified as well:

  File "tools/net/ynl/./pyynl/ynl_gen_c.py", line 1147, in _load_nested_sets
    child = self.pure_nested_structs.get(nested)
                                         ^^^^^^
  UnboundLocalError: cannot access local variable 'nested' where it is not associated with a value

This appears to be a bug since there are existing specs which omit
"nested-attributes" on "multi-attr" attributes.  Also, according to
Documentation/userspace-api/netlink/specs.rst, multi-attr "is the
recommended way of implementing arrays (no extra nesting)", suggesting
that nesting should even be avoided in favor of multi-attr.

Fix the indentation of the if-block introduced by the commit to avoid
the error.

Fixes: ce6cb8113c84 ("tools: ynl-gen: individually free previous values on double set")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 30c0a34..a7f08ed 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1143,10 +1143,9 @@ class Family(SpecFamily):
                         self.pure_nested_structs[nested].request = True
                     if attr in rs_members['reply']:
                         self.pure_nested_structs[nested].reply = True
-
-                if spec.is_multi_val():
-                    child = self.pure_nested_structs.get(nested)
-                    child.in_multi_val = True
+                    if spec.is_multi_val():
+                        child = self.pure_nested_structs.get(nested)
+                        child.in_multi_val = True
 
         self._sort_pure_types()
 
-- 
2.47.2


