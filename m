Return-Path: <netdev+bounces-167091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D101A38C9C
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF893A44E3
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1902376F7;
	Mon, 17 Feb 2025 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kow67CyW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B542376F2
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821325; cv=none; b=Vag28u4cvWcX6bYXL6pi7jLylNSYVtN3uMEW2htmEYNkyjK+OpCcjWuweLaB1O88p6QV4GAE3DGBZ+MoLsBhQK0fLulwRVG3cJGwhboLTdT5VLgZis9ElEoYSsWs5sHiF655QQHov4UUey2cPITCHb1BED/cLBcUyHuSJoJ/Qm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821325; c=relaxed/simple;
	bh=fRQR7xEssmKGVa236xYbmsEWB0ieUXTVShkUCTGTN5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoVRF8yTSwAoK3eoGkASCv8QWcmD7QAi3EHUcGN2yAM8q7IoiQmNP1CecYmsCGzCPVb6IFoAqxovmLL7gS7wtJjhRYOSu0ERS9NBJfU95K1riATMa9M4Ii3SRFHyAeyEZlLAYHTLhQSZdBJHw8DmPc/gfWgY6SvyPqrUdmUSy34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kow67CyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42765C4CEE9;
	Mon, 17 Feb 2025 19:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739821324;
	bh=fRQR7xEssmKGVa236xYbmsEWB0ieUXTVShkUCTGTN5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kow67CyW2RZh4gRb0+VeVaqvgoCt4hnRadvNTThQ9NKKDxPiuuWDhiYJgmucI0giv
	 RzxEWs1bQr4hzcETV5VrLY+lQlVyra0LAsJUTM1uKCgLdGSoP8gOyxZYElgrDCirtc
	 g4J+XvxKgWQCiiFHF9Nt0i3SMURsv14iQmdE0uQjUsMIfktE0+J7F6LZMfMh+TNAbz
	 JhL01LGpLWYRsoREKQ6UW6if1AiBn62KWIkL4Yv2fZ5ZBGlWGAtifX6akr9/08naxE
	 7hLEW8Bx4Bl+JiPp7q5p+NcrbyZ7g5cpAxiXcULaU3H3pLi5pBY932XFWv22qYKr4r
	 mJ0OCTGbNnPdw==
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
Subject: [PATCH net-next v3 2/4] selftests: drv-net: get detailed interface info
Date: Mon, 17 Feb 2025 11:41:58 -0800
Message-ID: <20250217194200.3011136-3-kuba@kernel.org>
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

We already record output of ip link for NETIF in env for easy access.
Record the detailed version. TSO test will want to know the max tso size.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/lib/py/env.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 55d6b3d992b6..128acff4f753 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -64,7 +64,7 @@ from .remote import Remote
         self._ns = None
 
         if 'NETIF' in self.env:
-            self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
+            self.dev = ip("-d link show dev " + self.env['NETIF'], json=True)[0]
         else:
             self._ns = NetdevSimDev(**kwargs)
             self.dev = self._ns.nsims[0].dev
@@ -118,7 +118,7 @@ from .remote import Remote
                 raise KsftXfailEx("Test only works on netdevsim")
             self._check_env()
 
-            self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
+            self.dev = ip("-d link show dev " + self.env['NETIF'], json=True)[0]
 
             self.v4 = self.env.get("LOCAL_V4")
             self.v6 = self.env.get("LOCAL_V6")
-- 
2.48.1


