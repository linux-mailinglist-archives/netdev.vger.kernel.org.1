Return-Path: <netdev+bounces-166611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB50A36930
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 00:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2242D170943
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1741FDA97;
	Fri, 14 Feb 2025 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tkx7E/8+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787231FDA6D
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576795; cv=none; b=ilQkANdVFoVOzEgK0nm/V7ty0+s4V4WkBpKUII3v50k7E9Sw8sgxz98gN+HSZhWb0V2fMHJNwP5I9n2fMw/T9xBftydTDHchX7htDaGgj8Q4U1DZq7RkW3e0o0XFppXhTQnAYve/F1KF36hRxrtBAEwGNl+CEaV83wigqxuYTyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576795; c=relaxed/simple;
	bh=BFzWS6WmTNDISMqrqjbvlcoq8ZHLktxhAj4wiS9ZPsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtR4kS9zmAo8f447n3pRN9wUDSK17gCH3jbvkQ14ZWt8Sc2qTVmqwKtE2uD7V8ReDCHd7YPDm7Ly1Gj592BRw0na5bafqMjAmWv5TJiT/oQQ/YZJXCR2Id3oR3oQky2B5gtBCafKNjSTCaYqHwPlC8QCa6TqIrARnoLuRPx53rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tkx7E/8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9534C4CEE6;
	Fri, 14 Feb 2025 23:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739576795;
	bh=BFzWS6WmTNDISMqrqjbvlcoq8ZHLktxhAj4wiS9ZPsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tkx7E/8+lH6f2kd+aQjrhRGKk/NMY4HCpAAwTUv0yzSVal34eorQ/Gq3SCbGoPsnp
	 IFfSns4X96sRUx1fyDR4i05vWeXBdvwbO4Xq0fLXphlA+wkHmQ+LE9/NW2eZQIlRDs
	 m74T+wVrtKZ3I81VdIt0VBE6n/WiJGQUYS+hhTtdghb7r8gT5D0yvULpZHoTfqAjGF
	 2qQ4p3br1STxmocOh1wXpw+tVedyHedSKixD5oWxNQWkfoMxUSBejZrvp5SvmFaFNy
	 Qiiou7fzYZZMxK5c/lFMbYAcKmXf4VkCPmbeIiHLY0MhE+kIyib6IDBUIytkU7ch93
	 Ecb6GdiVcP1oA==
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
Subject: [PATCH net-next v2 2/3] selftests: drv-net: get detailed interface info
Date: Fri, 14 Feb 2025 15:46:30 -0800
Message-ID: <20250214234631.2308900-3-kuba@kernel.org>
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

We already record output of ip link for NETIF in env for easy access.
Record the detailed version. TSO test will want to know the max tso size.

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


