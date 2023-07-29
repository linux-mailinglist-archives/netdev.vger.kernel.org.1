Return-Path: <netdev+bounces-22498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CB9767B64
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 03:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB27128283A
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 01:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514781A;
	Sat, 29 Jul 2023 01:56:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD27C
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 01:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF03C433C8;
	Sat, 29 Jul 2023 01:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690595790;
	bh=jcdUwKvuh90JIYIzs5yww3XJ3AZuKlqOVLiM+rfhDvY=;
	h=From:To:Cc:Subject:Date:From;
	b=OxxvCAu/qlLJNG1dJSaGFDOK9MNE+fb7RIqU5rZIExGFdCmhd5MMoa0en5osM0TUy
	 NaYnrL3QMNU+30f7qgbMFyiP8GmZuSK6P6MXL12rNieNNZgDReEk9YJOqWBhvnhfLm
	 v/yxAfp7RBbSXgZwlIO6Z5TWTCN8dwSxRMEmWl8/kgtAO6M8Q+1dwEyrAHEkBTD7wb
	 nMxNosJlsnTCvk5l491QfRi8xDDKkLASO7WU+t8OMju8qB8YbcnxKEIYFU3gdVc75G
	 SS0peiaIXmPlUb9BvhQgHftcbyftr7AuHid2WOD5rFVw9H39wMV+8LVfdZDrtQn78d
	 0hkvAnyxSUL5w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	leon@kernel.org
Subject: [PATCH net-next] net: make sure we never create ifindex = 0
Date: Fri, 28 Jul 2023 18:56:23 -0700
Message-ID: <20230729015623.17373-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of allocating from 1 use proper xa_limit, to protect
ourselves from IDs wrapping back to 0.

Fixes: 759ab1edb56c ("net: store netdevs in an xarray")
Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Link: https://lore.kernel.org/all/20230728162350.2a6d4979@hermes.local/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: leon@kernel.org
---
 net/core/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index b58674774a57..2312ca67b95e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9587,7 +9587,8 @@ static int dev_index_reserve(struct net *net, u32 ifindex)
 
 	if (!ifindex)
 		err = xa_alloc_cyclic(&net->dev_by_index, &ifindex, NULL,
-				      xa_limit_31b, &net->ifindex, GFP_KERNEL);
+				      XA_LIMIT(1, INT_MAX), &net->ifindex,
+				      GFP_KERNEL);
 	else
 		err = xa_insert(&net->dev_by_index, ifindex, NULL, GFP_KERNEL);
 	if (err < 0)
@@ -11271,7 +11272,6 @@ static int __net_init netdev_init(struct net *net)
 	if (net->dev_index_head == NULL)
 		goto err_idx;
 
-	net->ifindex = 1;
 	xa_init_flags(&net->dev_by_index, XA_FLAGS_ALLOC);
 
 	RAW_INIT_NOTIFIER_HEAD(&net->netdev_chain);
-- 
2.41.0


