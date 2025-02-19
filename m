Return-Path: <netdev+bounces-167926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A73A3CDD6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 00:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606901893118
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1B826139C;
	Wed, 19 Feb 2025 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nyd0+8UH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6287261374
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009008; cv=none; b=nCMTONyq0tr3lpDAW48Jdo6Sc749smH2ShwZivUoyLA2B9dxvA5V4Hs7Q3h06QW0WhYreQB9kv800bj0vwXo65hyxiEZ3SmgabOrS3kKlJIPTtIc+bXC4Nzqd6LftJKT2oJjF6NiueVXJX5Uaug35uzS9rVeyquCHi8n8zc8o00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009008; c=relaxed/simple;
	bh=v32lsHci1PVLTqi40mkM0/19cem5qNbUt9NgLOzCZPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JG5qHlm9LMt4NMohfioY8cShEOX/8WFADcUXn/nNnGDzEM7qXdFXU5YpXa0cI9ZqFhrZOMtMajiAn9V2YFsdz9x3uf1J4ZI/c9sR5++XSUbwPROsW9HBJmH22NiouxFZTB8IqzCNpxL2+PYs16Ev1WSlL44uU9+Va5ke3QgKPz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nyd0+8UH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C17C4CED6;
	Wed, 19 Feb 2025 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740009008;
	bh=v32lsHci1PVLTqi40mkM0/19cem5qNbUt9NgLOzCZPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nyd0+8UHcTPpII1B/TbLu2hWC03NAG9dqGkFYkG7fFBIoyNqSfRl3BRB4MB3xjm/U
	 jkAfi0HzBtVSeBtIM/fWiKWTFRq456c8Qt1zf9ErjmEk5PTc/yIo+453ZQ0vs+Ql7z
	 WpF1peom0lQLt9bJ5vdShG1AAwGK9MwOE18ZvHFJ8kasTCPFwPC0DYcLgVQUfNZ7jD
	 8NeNJubOEdelxbWCRLN7Xzi3+609WAsTF27ouCOs8TGjjUVq42Tc3jwL/R79FbH+v5
	 2CuEuRBPTYofSq1pT9sEfpuZbikp1Q5dPLuImiNOoqQhu3xoOaeeHZAshKcHODcXwm
	 4SprVxVf70Z/Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	stfomichev@gmail.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/7] selftests: drv-net: probe for AF_XDP sockets more explicitly
Date: Wed, 19 Feb 2025 15:49:53 -0800
Message-ID: <20250219234956.520599-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219234956.520599-1-kuba@kernel.org>
References: <20250219234956.520599-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate the support check from socket binding for easier refactoring.
Use: ./helper - - just to probe if we can open the socket.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: new
---
 tools/testing/selftests/drivers/net/xdp_helper.c |  7 +++++++
 tools/testing/selftests/drivers/net/queues.py    | 12 +++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
index 80f86c2fe1a5..2bad3b4d616c 100644
--- a/tools/testing/selftests/drivers/net/xdp_helper.c
+++ b/tools/testing/selftests/drivers/net/xdp_helper.c
@@ -50,6 +50,13 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+	/* "Probing mode", just checking if AF_XDP sockets are supported */
+	if (!strcmp(argv[1], "-") && !strcmp(argv[2], "-")) {
+		printf("AF_XDP support detected\n");
+		close(sock_fd);
+		return 0;
+	}
+
 	ifindex = atoi(argv[1]);
 	queue = atoi(argv[2]);
 
diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index b6896a57a5fd..0c959b2eb618 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -25,6 +25,13 @@ import subprocess
     return None
 
 def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
+    # Probe for support
+    xdp = cmd(cfg.rpath("xdp_helper") + ' - -', fail=False)
+    if xdp.ret == 255:
+        raise KsftSkipEx('AF_XDP unsupported')
+    elif xdp.ret > 0:
+        raise KsftFailEx('unable to create AF_XDP socket')
+
     xdp = subprocess.Popen([cfg.rpath("xdp_helper"), f"{cfg.ifindex}", f"{xdp_queue_id}"],
                            stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
                            text=True)
@@ -33,11 +40,6 @@ import subprocess
     stdout, stderr = xdp.communicate(timeout=10)
     rx = tx = False
 
-    if xdp.returncode == 255:
-        raise KsftSkipEx('AF_XDP unsupported')
-    elif xdp.returncode > 0:
-        raise KsftFailEx('unable to create AF_XDP socket')
-
     queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
     if not queues:
         raise KsftSkipEx("Netlink reports no queues")
-- 
2.48.1


