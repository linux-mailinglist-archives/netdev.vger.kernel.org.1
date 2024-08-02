Return-Path: <netdev+bounces-115154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0318994552E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E901F23861
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A454C9D;
	Fri,  2 Aug 2024 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/37b1xA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B34C66
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557888; cv=none; b=ee3zH8NatRCT/EL3hNerS+4A3EL4GebmsywxcAMPBinyfFNveqmmzrQOODZnsra1XAfy0Pd/jTxKaTsq/TlzPP0qPi0azLM2FH+KlJDhKyvRfg0ZOHFLLvhPCMDNzu/m8uRDNIAZf2XMx/fUJWOhHRidHU9a2Tp/23Rz57xU608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557888; c=relaxed/simple;
	bh=hFEqDxXlOsCbVq8aotSErKRovpoTO+FE8P1a1WMu+4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsQkTk6Iyn5iqJWSAz1UzEJgRoTJ97+DOiNAoSm7puuWSxGdjCuOZ6nFPJMr2KDXEqa9bfWpiCMBTHs45DScxKnuc22M6NI7Rltd6UH8avPe7obanD9kgnScD2zyzcAUmLZGOqa6eIrZEL4B3Bov8bz1oOPp4wmCjLIwdBwxhKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/37b1xA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51093C4AF0A;
	Fri,  2 Aug 2024 00:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722557887;
	bh=hFEqDxXlOsCbVq8aotSErKRovpoTO+FE8P1a1WMu+4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/37b1xA5TTKQMOAW9w9u7GP+QqK99R9Jj5CZTvmpfOddX37nA72W4UwQOZV6Ocm6
	 guMZTOKRAAw1csrIDPb8qGszLX1ZvwPjSSZxrUP/TkRTx9kN26wrZOkzM6cb5j0pJT
	 s8QVA2WBaS98FKO30pV5agvbZhuNaIcDcnR1TrLZ3ra5Yu3YjGIYF3lOU+wfnoWwja
	 JEmpQCv797AoP6y6y5mDuV8zutEpi7FsU6ulwYQSCuXXB+C+AG0ePLiITCDz30wBiJ
	 EMnNdOmJuYMBrpN4StIUHJQKwHa81mGaGqoLMt5wPns9viv3Nb7zQx4oeSt33UCbLi
	 bv2ra/Y1plQzA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dxu@dxuuu.xyz,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com,
	gal.pressman@linux.dev,
	tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 01/12] selftests: drv-net: rss_ctx: add identifier to traffic comments
Date: Thu,  1 Aug 2024 17:17:50 -0700
Message-ID: <20240802001801.565176-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802001801.565176-1-kuba@kernel.org>
References: <20240802001801.565176-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include the "name" of the context in the comment for traffic
checks. Makes it easier to reason about which context failed
when we loop over 32 contexts (it may matter if we failed in
first vs last, for example).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 011508ca604b..1da6b214f4fe 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -90,10 +90,10 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     ksft_ge(directed, 20000, f"traffic on {name}: " + str(cnts))
     if params.get('noise'):
         ksft_lt(sum(cnts[i] for i in params['noise']), directed / 2,
-                "traffic on other queues:" + str(cnts))
+                f"traffic on other queues ({name})':" + str(cnts))
     if params.get('empty'):
         ksft_eq(sum(cnts[i] for i in params['empty']), 0,
-                "traffic on inactive queues: " + str(cnts))
+                f"traffic on inactive queues ({name}): " + str(cnts))
 
 
 def test_rss_key_indir(cfg):
-- 
2.45.2


