Return-Path: <netdev+bounces-166610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06338A3692F
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 00:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4928F3AA402
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ABE1FCF6B;
	Fri, 14 Feb 2025 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwivenJi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029AD1FC7C5
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576795; cv=none; b=EDptbo7FC0EwcV+8xBiVRIBKD3Rud+4758dTbZSiEDNS0k7dPKASFaZqe6jndUORio3vrWnOAI9jTYnqugFb/+bXTujX2+ugqqZdUL2x+4nODaIqDFcfXccC0IyNOGu5toi9EAC9HgCn2sT6LWaz4uczUyX6i/I+p3otyhrQWio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576795; c=relaxed/simple;
	bh=ug6ZCgKRl+wfJNZbfAUxtVKscfyZskiYuCaZIblzlxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzCNc6U/CJ5iBvsCQko5+jn//s4Kq40Omj77bXr2iZQXGiCakqTdUfDh2fefruJ/ghG5T056HpeauuYUaVFbbybRjjoq0eVOPfgauAH1ZvtrYz99QiePxGtMVpeVm59oaNGJn56DtWzdG7OjWnj9CpHr+IEno0+Yn44gVXBSU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwivenJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC28C4CEE2;
	Fri, 14 Feb 2025 23:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739576794;
	bh=ug6ZCgKRl+wfJNZbfAUxtVKscfyZskiYuCaZIblzlxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VwivenJi/F0H9wxJWwgAGl+CeicIo9TUf3XNotJWBkyM7DhO8W1a5JWehQ61IN/vg
	 eQvioOjm2g+Ltm0imJa9is1stHSr3j4HuJpz4xwMb689GZye51YxRZCWOpwvzkKO5s
	 5Kp4tqsuTcjhjKbOSoHFClN6FpY/QMVMRgqPTWh9B7AazRQaFpkJVGyrUB1tit0DuT
	 B3FdWalD22se9pae2eWN9KE9u53lM/cQXsJW+hWZEWKC5kRCqvX4kPzmyCc1S5H3EC
	 TycWugDwc7QHvK1cr2zfHKxl68ACHOef9rSlsF8eiQ4uvNF25s3SVUb7IcfmE4++Ub
	 L/tbe+Gxc7D0A==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/3] selftests: drv-net: resolve remote interface name
Date: Fri, 14 Feb 2025 15:46:29 -0800
Message-ID: <20250214234631.2308900-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214234631.2308900-1-kuba@kernel.org>
References: <20250214234631.2308900-1-kuba@kernel.org>
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


