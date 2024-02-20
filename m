Return-Path: <netdev+bounces-73238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891BF85B8F6
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041DC285101
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0729861679;
	Tue, 20 Feb 2024 10:25:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10CE61667
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424729; cv=none; b=L2h/V85SrJ5Z2Wul8AOi8dXaJMTihY8mUD5qFxulbo4dGVGZOZl6oM8D9/0NFodkjSBLi1DyMBN6o+hPXhNSh0YG2iGBJycpCug15kg0qqKLOf4M1cI7djORq9535XumpLxepm7uQJGklcFxsFSCLK3tvkjefxtM4YKht3ovogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424729; c=relaxed/simple;
	bh=p74k8QJYRwuXNW0soRKdb6jpvhTb9GfGu/nXSNw0aSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YHqYBdnTppFveTE7ACBcrvZzjagwmomeopUMKrUjAXb9wdM4oY8YE8x0W2mnsn0gCfIlu1XsrmjHHXqw8zljPYo20LXHm+ZU+s8iAu6cuCymd1Og6k3Pq3GTDaqDaOXuCQ4MYgN2uaafEIsqRPDsGYTKun36N2DGTJpFJK98pQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 472912F2021D; Tue, 20 Feb 2024 10:25:24 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 40BEF2F2023F;
	Tue, 20 Feb 2024 10:25:18 +0000 (UTC)
From: kovalev@altlinux.org
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	jiri@resnulli.us,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net,
	idosch@nvidia.com,
	kovalev@altlinux.org,
	horms@kernel.org,
	david.lebrun@uclouvain.be,
	pablo@netfilter.org
Subject: [PATCH net ver.2] genetlink: fix possible use-after-free and null-ptr-deref in genl_dumpit()
Date: Tue, 20 Feb 2024 13:25:12 +0300
Message-Id: <20240220102512.104452-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

The pernet operations structure for the subsystem must be registered
before registering the generic netlink family.

Introduced in commit 134e63756d5f ("genetlink: make netns aware")
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 net/netlink/genetlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 8c7af02f845400..20a7d792dd52ec 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1879,14 +1879,14 @@ static int __init genl_init(void)
 {
 	int err;
 
-	err = genl_register_family(&genl_ctrl);
-	if (err < 0)
-		goto problem;
-
 	err = register_pernet_subsys(&genl_pernet_ops);
 	if (err)
 		goto problem;
 
+	err = genl_register_family(&genl_ctrl);
+	if (err < 0)
+		goto problem;
+
 	return 0;
 
 problem:
-- 
2.33.8


