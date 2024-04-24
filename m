Return-Path: <netdev+bounces-91096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 020DF8B15F7
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 00:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962CE1F23895
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 22:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A0016D9AF;
	Wed, 24 Apr 2024 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZE9CTOJC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730716D33A;
	Wed, 24 Apr 2024 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996892; cv=none; b=dLds/XdUtPexruKawYjEcuN/jCx7PrnbVbiJBOMY09uoLZW1XcrD/IZgeYrYFfs2Brr0u0wv7O4XJYKoUozhy7WwwcF5Nz0HkHd6MitemdRd7p7/g31Swxeq3ANDrILesqImcR2Q1TsZxtsxX8/6x6CHd4lm25ssuT3tEPMi43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996892; c=relaxed/simple;
	bh=Gt09BVyguHHicNRP+AvdpMng623ntjFEP5+/KWehRuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUatWPUhtZOrcToZO7kewUpIhcxBG+zOmiOv87fRQoBI+HrlKTPwyResiHffQdi4/Q4VbU35n9SEY06EcavU4POarvhlPCgtLaCHEMAwN2QHvK//kroGvGwZZP+PyFIE1cSyj2DGHGyisiZl4mPusRcCDqlia+rFq1azT9TU0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZE9CTOJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB4EC113CD;
	Wed, 24 Apr 2024 22:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713996892;
	bh=Gt09BVyguHHicNRP+AvdpMng623ntjFEP5+/KWehRuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZE9CTOJCpnvjynAgGIuZNq9o0VNLPoDQylrgP4TDW808ojSCBiJmZWlVar6BA0SmF
	 /SctLwApHgWXUe+PGL/JvcjwKfVeAPi1F7+W5wBQttglbmjekfdJ0QcZ5CVgqvIHx1
	 xG2bfNmrnctZSldZ17tu4pKks6S4mwVOMKDZHFR3NyIpUQnBpRHw9KyeiWQTF8kXJe
	 Xqlvc/tQmMTR+jsg3qHWnnBrW6sV7kOU2Rxxhlp2BUB+CLxJCB6pe1DFA2Au0rittY
	 xoernGQBOTloczQrqBSMAYVION7JlEdVcv2oARMg1Zmn8W3jKUcZTE7GNl7JEtQ6r1
	 mTT62Pe8zTKkA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/4] selftests: drv-net: validate the environment
Date: Wed, 24 Apr 2024 15:14:44 -0700
Message-ID: <20240424221444.4194069-5-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424221444.4194069-1-kuba@kernel.org>
References: <20240424221444.4194069-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Throw a slightly more helpful exception when env variables
are partially populated. Prior to this change we'd get
a dictionary key exception somewhere later on.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/lib/py/env.py       | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index a6a5a5f9c6db..fda4967503de 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -88,6 +88,7 @@ from .remote import Remote
         self._ns_peer = None
 
         if "NETIF" in self.env:
+            self._check_env()
             self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
 
             self.v4 = self.env.get("LOCAL_V4")
@@ -143,6 +144,25 @@ from .remote import Remote
         ip(f"-6 addr add dev {self._ns_peer.nsims[0].ifname} {self.nsim_v6_pfx}2/64 nodad", ns=self._netns)
         ip(f"   link set dev {self._ns_peer.nsims[0].ifname} up", ns=self._netns)
 
+    def _check_env(self):
+        vars_needed = [
+            ["LOCAL_V4", "LOCAL_V6"],
+            ["REMOTE_V4", "REMOTE_V6"],
+            ["REMOTE_TYPE"],
+            ["REMOTE_ARGS"]
+        ]
+        missing = []
+
+        for choice in vars_needed:
+            for entry in choice:
+                if entry in self.env:
+                    break
+            else:
+                missing.append(choice)
+        if missing:
+            raise Exception("Invalid environment, missing configuration:", missing,
+                            "Please see tools/testing/selftests/drivers/net/README.rst")
+
     def __enter__(self):
         return self
 
-- 
2.44.0


