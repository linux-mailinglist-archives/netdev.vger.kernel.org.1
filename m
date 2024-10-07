Return-Path: <netdev+bounces-132776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A6E993211
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7185F2812D6
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAAC1D7E25;
	Mon,  7 Oct 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUCm6c2N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693C1EB25
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316393; cv=none; b=qz9SO6Tgj+Nna1x01NC5SSu8AQZbYL9vVvQpPZ2diRh3waRdlBTEZqIwm0QlvwWm+wua72Zh64A0XofX7lVou4cq0boVOSJ3APpwZTiFWLcgIQsqQVDbKT5EqhEHXGafpzUcVQMzBBjMi6ucTGrrLgdH1Ctr/3O0GvmH61jJ2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316393; c=relaxed/simple;
	bh=RgtFAjmfrxpNW2hu2a8fXpj/wNsiD+jeQODwI2fIgGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IMM2M/K4uJ8pccuJHNbI5wHiDPrwGZVYkCdgJD/SI/rX5adICT2YMuwBCEsbcR50EB87tpcQ++D/J/IJGnWKeQ/AqRHrC9QpsMYKqeBMhRhssR69xdmAmUufAZT7ZqzpV5eLwpvsLyxRdemfuE2ZrrzDtt8UU0A1o9JmF3XE7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUCm6c2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90535C4CEC6;
	Mon,  7 Oct 2024 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728316392;
	bh=RgtFAjmfrxpNW2hu2a8fXpj/wNsiD+jeQODwI2fIgGM=;
	h=From:To:Cc:Subject:Date:From;
	b=LUCm6c2NAlNoh2WXvYRQpfvQpUsQAnJ1/sEyMLkfh5WKlbM5PTc1SF64P+SNWv8mo
	 Q7s9hgOXTLYCfS3jI3S5XS47ek/7msRAIuQ1n/cVpv/gw6Ky9G9Ok8AsibjxpwbPhZ
	 rV9OKDRndWuiNripPbkYmVelsMVY0nIuxTtOqoWpsjiFKe3jZvnisAEHo8LhbVVCQg
	 yVjbCer/pytulsw7RM0mLGjkabwmJc5CAg/DJLFO8kXhe6WyGf6/LUooBRJ4gv2Vld
	 G1sLQWX66HTdwn5p4snxgkBD8mPdPnCWCEA0XDtHwAaSIlmf0ZnFaUKVZO6PXGY0Jd
	 3o5n/jMTGWHuA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next] tools: ynl-gen: refactor check validation for TypeBinary
Date: Mon,  7 Oct 2024 08:53:11 -0700
Message-ID: <20241007155311.1193382-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only support a single check at a time for TypeBinary.
Refactor the code to cover 'exact-len' and make adding
new checks easier.

Link: https://lore.kernel.org/20241004063855.1a693dd1@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: Antonio Quartulli <antonio@openvpn.net>
---
 tools/net/ynl/ynl-gen-c.py | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 717530bc9c52..9e8254aad578 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -464,17 +464,22 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         return f'.type = YNL_PT_BINARY,'
 
     def _attr_policy(self, policy):
-        if 'exact-len' in self.checks:
-            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.get_limit('exact-len')) + ')'
+        if len(self.checks) == 0:
+            pass
+        elif len(self.checks) == 1:
+            check_name = list(self.checks)[0]
+            if check_name not in {'exact-len', 'min-len'}:
+                raise Exception('Unsupported check for binary type: ' + check_name)
         else:
-            mem = '{ '
-            if len(self.checks) == 1 and 'min-len' in self.checks:
-                mem += '.len = ' + str(self.get_limit('min-len'))
-            elif len(self.checks) == 0:
-                mem += '.type = NLA_BINARY'
-            else:
-                raise Exception('One or more of binary type checks not implemented, yet')
-            mem += ', }'
+            raise Exception('More than one check for binary type not implemented, yet')
+
+        if len(self.checks) == 0:
+            mem = '{ .type = NLA_BINARY, }'
+        elif 'exact-len' in self.checks:
+            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.get_limit('exact-len')) + ')'
+        elif 'min-len' in self.checks:
+            mem = '{ .len = ' + str(self.get_limit('min-len')) + ', }'
+
         return mem
 
     def attr_put(self, ri, var):
-- 
2.46.2


