Return-Path: <netdev+bounces-167543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A216CA3AC0A
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 23:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373787A23D2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E5A1D9346;
	Tue, 18 Feb 2025 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/3dOd6S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451BA1D6DB1
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919273; cv=none; b=owzcz07abaUnG4NuilSAL1wndR+iEg1RK5udrQ1hly1eK2HlmaTpItL9c+/nrgYy8L8wstlPViMFRS6e7vwssLCvR/wWtHaM9PY8n0KFchiYC8LBlgnuKabTju9JjXJrkjOowH1P1/X5i/WmvWn10ENy1KIIAPqDdM+q/gbhU8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919273; c=relaxed/simple;
	bh=XLKWiJUs5Q7VhOwY+XIKPdeeyH9CF5ZvsVrFxguSOhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuNClCNKL6Ja5aCIwRuZBm9c3IHSdeG/2NNxlptJP9qnZTvyXF71lTsLfQc7mfMHg7CrXL3sj9+lbeoyKv1QMTG8+77HIIRNgz0Q/iUZtUMvBaoukBj22uzfTXY98+vb1fNFpoPB3Czdk1vtq2XfaNbHUJnPPIGLfoG3kdc3dSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/3dOd6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64379C4CEEA;
	Tue, 18 Feb 2025 22:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739919272;
	bh=XLKWiJUs5Q7VhOwY+XIKPdeeyH9CF5ZvsVrFxguSOhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/3dOd6S1GN2gm0wdrcJA99DgrhFrVZ11DCIvz9M4/+H9LMx77b4uvsH95b2IS7WK
	 /F5IaL4dmpYEwqnOARBlGoOxFnsX41fi7jvYXw+u1DiO7c4ekGATyAfnqnzNZ0VtWG
	 ++EltpHPPK4XVHxEZx17FvEtS4G7huLdhXKMgpinWwNiPBS7ErlhETHT5ZEAOWQeGm
	 uZsjtXaBWKb2RX9PB6c4sH9EhswnoxFljIgfiFN+Trp8hpOA8tnLfWmYWPxt2DLmWX
	 o51v1s2nXAwAKEPGUBbJwdFAJjt28A0mez3rIpBw+5ROEyRSWJbYjmi8LsxwahFTrg
	 WGyoe4dP6vUuw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	petrm@nvidia.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v4 1/4] selftests: drv-net: resolve remote interface name
Date: Tue, 18 Feb 2025 14:54:23 -0800
Message-ID: <20250218225426.77726-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218225426.77726-1-kuba@kernel.org>
References: <20250218225426.77726-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Find out and record in env the name of the interface which remote host
will use for the IP address provided via config.

Interface name is useful for mausezahn and for setting up tunnels.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - check for IP being on multiple ifcs
v1: https://lore.kernel.org/20250213003454.1333711-2-kuba@kernel.org
---
 tools/testing/selftests/drivers/net/lib/py/env.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 886b4904613c..55d6b3d992b6 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -154,6 +154,9 @@ from .remote import Remote
         self.ifname = self.dev['ifname']
         self.ifindex = self.dev['ifindex']
 
+        # resolve remote interface name
+        self.remote_ifname = self.resolve_remote_ifc()
+
         self._required_cmd = {}
 
     def create_local(self):
@@ -200,6 +203,18 @@ from .remote import Remote
             raise Exception("Invalid environment, missing configuration:", missing,
                             "Please see tools/testing/selftests/drivers/net/README.rst")
 
+    def resolve_remote_ifc(self):
+        v4 = v6 = None
+        if self.remote_v4:
+            v4 = ip("addr show to " + self.remote_v4, json=True, host=self.remote)
+        if self.remote_v6:
+            v6 = ip("addr show to " + self.remote_v6, json=True, host=self.remote)
+        if v4 and v6 and v4[0]["ifname"] != v6[0]["ifname"]:
+            raise Exception("Can't resolve remote interface name, v4 and v6 don't match")
+        if (v4 and len(v4) > 1) or (v6 and len(v6) > 1):
+            raise Exception("Can't resolve remote interface name, multiple interfaces match")
+        return v6[0]["ifname"] if v6 else v4[0]["ifname"]
+
     def __enter__(self):
         return self
 
-- 
2.48.1


