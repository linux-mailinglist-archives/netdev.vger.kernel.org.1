Return-Path: <netdev+bounces-72193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F690856E93
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 21:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00196282A54
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 20:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D3013AA5F;
	Thu, 15 Feb 2024 20:30:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA9136995
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029003; cv=none; b=cKfD0HMGEPDqYNg9P8epP9+dIFSV0on2cyNlxoEmpBBu5fzkYGZBbZhPowh0FIo1ETow6YuDmGw6IBQ3ME5M/EKer2hcmeOSZ5GEM7qU6gon8WTVzbxV5diH6pv3/Vylnx3SpeOxuFBTUN+WZX3cEwjb47lAxMTcqhe5s545qlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029003; c=relaxed/simple;
	bh=MmWuYJYZTVQP3ZveeZ2NRxPmCulT0dJG9AELPAeQt1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D4H02T3XbuyoBgbDFGuFtWddZwAf6BmSMo9+QFnw4VTljU12Yr1MlpIB95GEcDb6jMpDzuFSzBf8E8M+a7bBj7aoYVsGDXUIPjYD31vjQAHWo5asShmKpHNlThfXmsZmMAUm9DERkAfv1NjIiHwPAH5nKK/AqEHSsOFSN1P+U6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 2280C2F2025F; Thu, 15 Feb 2024 20:29:59 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id D947A2F20259;
	Thu, 15 Feb 2024 20:29:56 +0000 (UTC)
From: kovalev@altlinux.org
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	ebiederm@xmission.com,
	kovalev@altlinux.org
Subject: [PATCH] tcp_metrics: fix possible memory leak in tcp_metrics_init()
Date: Thu, 15 Feb 2024 23:29:49 +0300
Message-Id: <20240215202949.29879-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

Fixes: 6493517eaea9 ("tcp_metrics: panic when tcp_metrics_init fails.")
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 net/ipv4/tcp_metrics.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index c2a925538542b5..517c7f801dc220 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -1048,6 +1048,8 @@ void __init tcp_metrics_init(void)
 		panic("Could not register tcp_net_metrics_ops\n");
 
 	ret = genl_register_family(&tcp_metrics_nl_family);
-	if (ret < 0)
+	if (ret < 0) {
 		panic("Could not register tcp_metrics generic netlink\n");
+		unregister_pernet_subsys(&tcp_net_metrics_ops);
+	}
 }
-- 
2.33.8


