Return-Path: <netdev+bounces-165725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30A4A33409
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F04E167C11
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 00:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3E34CB5B;
	Thu, 13 Feb 2025 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ5rcrRJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B47481D1
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406901; cv=none; b=NB5fsJlNII3Hh6t0k10oTFtP3gPFHNHp04RQDbp4d9W2QZdRPGHtbJgw3/Ki3V+/CIaoDyMOmkWbr7CJBgTfcpAJ9kGXdo9JET3/1XQ2x/MsSujFrrIhENN0BBbTY7U5Z7lQIjBWuvqypqg5EScxe2CkUjWuQTYHbBkG33Sc6QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406901; c=relaxed/simple;
	bh=mimynJWa2qWDxhOOjySCJF1CjQg6PWUREy/ycZEH+i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHX3uM06CdqvKeE1rYnCgpsSrW5/h91CXTS1fEtJFKooijDSnbHJ2P+sRejsgd+rmJLauZnrkyA78q618JcCmC2TXH8fAO4XDasZxxjHLKG2gOXDUF9AFEsiu3L4qtZQc6MSmi/6P9B2JxlmX3kt5mWwfRGHGmasaaZUvGs5vpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ5rcrRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF62C4CEE8;
	Thu, 13 Feb 2025 00:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739406901;
	bh=mimynJWa2qWDxhOOjySCJF1CjQg6PWUREy/ycZEH+i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQ5rcrRJxuU2E+yjLebNBi9UF+gPLSGCa1uycI/A0SBUyYpy3j9ESD10EUo8/miJb
	 IxmBWR0/sCaFDRG5475zNIrej4qHKc6Y99aQCZkwnjmVx84VS/SePaQTEdgL7og1C8
	 4h8PGboXFxy5+Ku1Z0M9sIr/0+Dej6eGFcoqtnjH/AegJ+8gpGKt5Em+NsVzcOLBo9
	 V42R6s1/jIm5NcYBJRt1yYitIbFJR8F48QmJLLwch5ix6r+uRk+8C5O4Q8M2USyzUj
	 7DOcEw19mwh7BkHvwo7i+LjnUZ5ushrdO1Cm6HgSLJttCCHdeDvr7tsKgQ5EjSrTTd
	 on2vfGU2SCO9w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] selftests: drv-net: get detailed interface info
Date: Wed, 12 Feb 2025 16:34:53 -0800
Message-ID: <20250213003454.1333711-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213003454.1333711-1-kuba@kernel.org>
References: <20250213003454.1333711-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already record output of ip link for NETIF in env for easy access.
Record the detailed version. TSO test will want to know the max tso size.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/lib/py/env.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index fc649797230b..acd6e4a865b6 100644
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


