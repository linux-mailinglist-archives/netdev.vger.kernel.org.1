Return-Path: <netdev+bounces-167090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8591FA38C99
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6ED3A357D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F9F237194;
	Mon, 17 Feb 2025 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5SwKK6q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A496C23716E
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821324; cv=none; b=SYM6OTK1RyMg18dDUy2o9keEY136KkyjXQBulSVGB5XsmqQ+0tSHrnIEytgACkvMkiUFtwA5xQi2f7qL07cjH4Bw/tMGkXecopZZJs/zubKOYdmH2biwDTyCyi2AE+l7QTjNrlBOPmcfwdKGvmzk7ktb8wz64ce+l2KsRgakJgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821324; c=relaxed/simple;
	bh=XLKWiJUs5Q7VhOwY+XIKPdeeyH9CF5ZvsVrFxguSOhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVilVoe9vWkpZsqKeLAMqDk/OuvvZ2kGYidZNKl1Fw1qqq2J/4DJzKXwSo7WxdNkkfE5BOKcRUju+lZ+r6Yh5Rb2QkT1rBWCEA9HnXoFs6fvRBS7BVTI9NFJ86UK/Zfvp1psfy4JhnSWqqdVBPE9LAHOGR8wXFfcTe6qwwvew/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5SwKK6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90ACAC4CEEB;
	Mon, 17 Feb 2025 19:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739821324;
	bh=XLKWiJUs5Q7VhOwY+XIKPdeeyH9CF5ZvsVrFxguSOhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5SwKK6q/YS6SVVNM/6mgCeZXNEai9l0ciCg/Iy08u0+Pzlt1XDe3ZzPDIZJYEYPP
	 syFmk1/v6oINZqU57GcRHDj7CcBlNgwS/CTpbzIn5CNU9TeEuLcq0/AXGxoz1q8G3T
	 Jb8vbm5U8+S7E/tb3ZdL/ps53b6V9NVoo14+zvB1pNy1tRjTAbsNDPpphybnkeVRao
	 u7rm//C36ofJjYWHQLKxWl4FOopc3x38WhrfdpWsrGGeahamX5Yry5ON1zQdE7L5pM
	 Wf9jJlxDA5IxSEzhePO0+YqbCrPKnm6seormfP+Lz88TACCM/ju+JrR8khIqHfxZZo
	 gCPWnLdi9TOnw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	petrm@nvidia.com,
	stfomichev@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 1/4] selftests: drv-net: resolve remote interface name
Date: Mon, 17 Feb 2025 11:41:57 -0800
Message-ID: <20250217194200.3011136-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217194200.3011136-1-kuba@kernel.org>
References: <20250217194200.3011136-1-kuba@kernel.org>
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


