Return-Path: <netdev+bounces-157362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE26A0A161
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 08:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E853AAF53
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 06:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9978E156236;
	Sat, 11 Jan 2025 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMpzlRvx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A98BEC
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736578799; cv=none; b=IZwhomwAdOCA+qMweOHy4BOv5i3Mq5TzkxB7YFoHGLfYZ3BqYpFDfFGww4as1ZD8cQ8zgtVaj4bqKCYExmgvfztzADh8yVL0sPaB0Ih8mDl1+QeTTzb0aciyEJRqoeuIDItxBhLZ/Aexh3bAYWSluh3/+1qjjezy/CUbMCNL3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736578799; c=relaxed/simple;
	bh=5l0fQJ7DPlvXaohSWGaF8ws/A766Cq6crpcxs8Q+0u0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VYjkgpZNah/B7mcbeJI2mXFYrREWzpd5xgTDaSKCcz/J2sitVcmm6YKZMum4TPcDvuVeZFigHmPTE2f+FFcMqX6B2GQ45bt5SCyp96w8hKCyw8ws487hr0zqNgk0RLc3/J84ljdFihFpEbnttqv2stiqafFSxN1WAdkx4L8BsV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMpzlRvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F38C4CED2;
	Sat, 11 Jan 2025 06:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736578799;
	bh=5l0fQJ7DPlvXaohSWGaF8ws/A766Cq6crpcxs8Q+0u0=;
	h=From:To:Cc:Subject:Date:From;
	b=DMpzlRvxjmlrI0D163ElgsgafyOlUddKU5wWecg43yulTyB4S9Fx+tNhZOfwwPLOF
	 Puo7SWMFlx2IMcdu+NIkM05w4CP6TrJTxCZGtJ+tCylrpHi7YE1xjfeRSCU3b56dBL
	 nRxTTYH4iIAHQPjOI+1kMwuYm0JmT8HDXnsMb2oA3udEbeJfvMBZhry4bfaCTzP9pU
	 7cWtnsAuPlCS2HhlOXEggJVMX/U+cqUmlkoCpYvPR6c+BGlgcEi/svx9tvey6afB6i
	 fO5ehHyQvCtRnlP+N1+9VeYMBGPPYZn3oIH+JR165HEPHcdtG4grg+hksNAIY8/P/U
	 MyfvuAlnaYiug==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] net: un-export init_dummy_netdev()
Date: Fri, 10 Jan 2025 22:59:54 -0800
Message-ID: <20250111065955.3698801-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no in-tree module callers of init_dummy_netdev(), AFAICT.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1a90ed8cc6cc..23e7f6a3925b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10782,7 +10782,6 @@ void init_dummy_netdev(struct net_device *dev)
 	memset(dev, 0, sizeof(struct net_device));
 	init_dummy_netdev_core(dev);
 }
-EXPORT_SYMBOL_GPL(init_dummy_netdev);
 
 /**
  *	register_netdev	- register a network device
-- 
2.47.1


