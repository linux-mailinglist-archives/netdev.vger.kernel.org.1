Return-Path: <netdev+bounces-167544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E428A3AC0B
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 23:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8CF17519E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AD21DC185;
	Tue, 18 Feb 2025 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPV2uVkJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EDB1DA0E0
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919273; cv=none; b=WDFDYdW/5Z9MIoBckS8JCjfDTXtvGjQAZw/0V2/s7eW9+rEMM1Hi0OBNkx/xTe2eZ6OPnro5J0vqPXP8xJ4jTPMledNixwJEAKi9+SNOepJ/tidJMp3+uQWLgsBxKgYW4dyU1HpGLoCXwKAUhuDPcAFcjTfdKYPr+keyTkMl4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919273; c=relaxed/simple;
	bh=fRQR7xEssmKGVa236xYbmsEWB0ieUXTVShkUCTGTN5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mx8ikgoDJX73X/+YJMHk0rjfwSbyLSktmd0QNSRWLu4k3K89xxX1gL9G2dxMMF5BItPBdeUGRHYSXVd9r+O7kjrBX1EnzejG6eH4YP2H82pLkCVm4b33FGAtpRWeK0tMvKmmjV+0QY8NFRmI7oyX+6XhUX6N8UMAfBN/PWygB+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPV2uVkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D478DC4CEE2;
	Tue, 18 Feb 2025 22:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739919273;
	bh=fRQR7xEssmKGVa236xYbmsEWB0ieUXTVShkUCTGTN5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YPV2uVkJVRHLYmzb6Hl+jjCEws3P1d/P7yKX9de6sCYbsoOXXO43ua3/739GMLF80
	 KZXJJRrhPLtqZpLweevkcr4a2yxjLsW8E3kbYbMqnWY1jzDGtYVsOdqGA6AHRFx7ea
	 a1lvayd8jhawhjNe+QcnrjFtqDREOnYRWcDSEeAaPuW/PYAltnfy5ujhNNRjgklbU5
	 FE/FtHiXwMmXajugq2hgeWgs+iPkf2UrRbwHSKn1ue4RKpwJHnE0nkQoq+e/c3l7HN
	 yKU5FPSfKvAwIwPl7CJsbPT81IgnDvf0E9U4FinkynVZsTHjlDl1XE3qTfm5dAjfY7
	 WPnVG3e7BtXoA==
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
Subject: [PATCH net-next v4 2/4] selftests: drv-net: get detailed interface info
Date: Tue, 18 Feb 2025 14:54:24 -0800
Message-ID: <20250218225426.77726-3-kuba@kernel.org>
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


