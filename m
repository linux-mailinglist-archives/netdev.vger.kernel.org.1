Return-Path: <netdev+bounces-111878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0DA933DBA
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 15:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0817D1C22B8B
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838A41802D7;
	Wed, 17 Jul 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBfVW1hb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB891802CD
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223493; cv=none; b=Pf6Iialrb4C2Su6AfQzwnbVXuKS8akT2jxceowZR9nKO95OLI0nXOi65Xu2q7hE7gxOvh9RBzFfectNn/5BKIxvhSM09Mlpn0jXeXtZ4Sa6mQATyuLHDUHf4lG5M1FSIyG0/OdK1sKQ5FbkRfJa/3iPNY7/KqNqJjt0te8qcTqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223493; c=relaxed/simple;
	bh=dNu9MqauNrqn4+4p2YoVF7zd/L6XLLcKZrcaNK8QhfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXRkCMN1K0N5PzO4DcC+sIpCeSNbzP3YSywW/RHzSaotKQ0FrSF1pzrMVxKsx/Upv+RdPkqcRjGQ5I/1xJVSUrzASHZB5WutnOFETaVwHePBuZrF8zdj7XOnn/L6W2UubAAj+rbQzqUrJJzQlMMj/9gDKWVTs9rGGsKL9w5cR54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBfVW1hb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA175C32782;
	Wed, 17 Jul 2024 13:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721223493;
	bh=dNu9MqauNrqn4+4p2YoVF7zd/L6XLLcKZrcaNK8QhfA=;
	h=From:To:Cc:Subject:Date:From;
	b=MBfVW1hbLWJuPAxes+bzDb8sSe8lXZVM+DZ+lvuA9w+2Uj9k9UoPVhP/vYxLLsxJ2
	 gfoby5N8erHdPrYB7OA/hXwOSxPUu2NRGKVgB9gyEnEUBbPlPePnv4FPi56w7GhRLj
	 i/6Ny4ux/6GBDDSIYBOCCCLDHVA4uojRO8vA4S3XguKMwkwdqfZ6KEf+9ChUMKFaux
	 /WV4HsJ/7psgSkf2Q+3rpZUIkoiJFbKeCXILLV3wH2vCUvVzb250Pi1Tt1q5An0oA7
	 QRFXfLxi5w1RMR81wFcU2aLJpzqdSqOBnfBpDT9v4Ix6cIXRTfap3GNZyH6skb+LZ3
	 P25FSFR3t/jKg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	kernel-team@meta.com
Subject: [PATCH net] eth: fbnic: don't build the driver when skb has more than 25 frags
Date: Wed, 17 Jul 2024 06:37:44 -0700
Message-ID: <20240717133744.1239356-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to commit 0e03c643dc93 ("eth: fbnic: fix s390 build."),
the driver won't build if skb_shared_info has more than 25 frags.

Fixes: 0cb4c0a13723 ("eth: fbnic: Implement Rx queue alloc/start/stop/free")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: alexanderduyck@fb.com
CC: kernel-team@meta.com
---
 drivers/net/ethernet/meta/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index a9f078212c78..b599c71a2d27 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -21,6 +21,7 @@ config FBNIC
 	tristate "Meta Platforms Host Network Interface"
 	depends on X86_64 || COMPILE_TEST
 	depends on S390=n
+	depends on MAX_SKB_FRAGS < 26
 	depends on PCI_MSI
 	select PHYLINK
 	help
-- 
2.45.2


