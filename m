Return-Path: <netdev+bounces-206309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86929B028D2
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 03:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1191C22BAB
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 01:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB4614658D;
	Sat, 12 Jul 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxaW4I0E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B922D4A1A
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752283207; cv=none; b=jYxA4W/wdN8EgU7yS+516xkm8BRY1ucWf3LoWOi0oI0z+S8e80KEmSXnZqj5igytYSqlgaAMw2vm3euORku0j6Eun+/QTpOrgMECkic5gepew0emqMc4/1VHMtixazKBoHArga4He7FMCWpXgIdOBMVEZET981miEgNt+8CKLNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752283207; c=relaxed/simple;
	bh=kATkyF9z+Ad+Cr7kMypJCkxD0V8rqLc1rSrgyTWBBMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhO22RtvAsoZPcjX1SiiwWcdvtObqWKSCTG/gWj74/tcbC5J45z5vJA2nDRQsXR18Xxkq1ILpUqancZkzIqkd8hvE81cIdIsvq3TIRAbQCoEDW4IbUOZsTV7okgQ6imeCjoe9mcWalcMH6jMOtl66zbdmRtL24TT0M9hxa8Uido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxaW4I0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB87C4CEED;
	Sat, 12 Jul 2025 01:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752283207;
	bh=kATkyF9z+Ad+Cr7kMypJCkxD0V8rqLc1rSrgyTWBBMo=;
	h=From:To:Cc:Subject:Date:From;
	b=WxaW4I0EEtdG0KkHYl6GZF8e+vvebwp5Wij81GI/KidxSpWIWJi1m59fD3m1mi/6q
	 9qjgxlvCshgyWEviJ794B9dgKHpoo/yCS3XrGYSB2HDN9bbK7aImw/cIzEDsfGFVgX
	 Ml1t6QrpgGIA/LDZxGe7twqa3oBK29c+JB+u/mqUV7+CTCTSXTdoVMhh6wZzxUTwJv
	 rqqmKGdL65ZSG7ybu88zdoQagIgHl+JOsElHeR6QEf6rntmp/1Hty35bY7g1N3Xg8G
	 uze8xTx9hnv+wE9L7i+33min2GeYAzYF6+imhGpAflW5kQWgt2IRg5MoR4quOHea99
	 +gfZVbEF4LWhA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] selftests: drv-net: add rss_api to the Makefile
Date: Fri, 11 Jul 2025 18:20:05 -0700
Message-ID: <20250712012005.4010263-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I missed adding rss_api.py to the Makefile. The NIPA Makefile
checking script was scanning for shell scripts only, so it
didn't flag it either.

Fixes: 4d13c6c449af ("selftests: drv-net: test RSS Netlink notifications")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index df2c047ffa90..fdc97355588c 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -16,6 +16,7 @@ TEST_PROGS = \
 	irq.py \
 	loopback.sh \
 	pp_alloc_fail.py \
+	rss_api.py \
 	rss_ctx.py \
 	rss_input_xfrm.py \
 	tso.py \
-- 
2.50.1


