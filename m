Return-Path: <netdev+bounces-24078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E317476EB3F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207331C214C7
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097901F938;
	Thu,  3 Aug 2023 13:54:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080B1F195
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:54:20 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C70EE43
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 06:54:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c5fc972760eso1146600276.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691070858; x=1691675658;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8eFRxj5E7/AO2lNPUkvBVeEpSjVZOS/XcpHxgW/buY4=;
        b=lTGhiAns1pwfq09KxMYoOhha5PbAYzhW1Uf2drh5P2UzHjZfIeZiyO+BOOIF2dR9Ai
         dx8YPYIEXRtBPloJTJIYyql5ZQyPFdAfWBbnpTkUKEsYvVbNg/JVYFKlocyNYvyr6ZsD
         bxENqdOXRkx7YnmM99iQwVyhcHZfcV1jBoq/KrO9fkqsP1mChfi3NxyrFqYxvZDOH2+u
         yUJ7npX7lAgf/2HljS2ZR5Fj35B+Umcio+TlEBYB6Frb07Ge2hEp0xTmooZiks/qAyCG
         Y2LqZL6sf2funYVCHVrXzDVQkbmMB/hwbfQblHnThMmPMtMuI5l4xARVxF+YxkO2Lcuk
         HEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691070858; x=1691675658;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8eFRxj5E7/AO2lNPUkvBVeEpSjVZOS/XcpHxgW/buY4=;
        b=jmn6RZHzrVH0APSSJB4gmq4KHkOUSpvp0DPD/gwApgVUQt6QCqs0gXD4sRXxP09OiA
         B/vxuQbjY7yBTQsmQP/uXmdczSwDm0iQiRRBxiL2iCkW4KTHHe78YhbOV1UlxmVJixJe
         Xolm0PralRlSSBmgEPXEJDWOH/0pswcDwbL63B0ZYAM6xYNPc8qLhN9ibSQWC+R2v7Tt
         y4rDfRHeSoAy7ki+qtvQKN6qZkckTujlczK1e0AEavMOkewUPLSKiT9Mtb9rR3SGLlWw
         RvReqzsukZl2widjEW61uGY1Kg26cQs4h9vYFdjLY8Tf752av+GD2oHN38djrQ82hqbv
         pe8Q==
X-Gm-Message-State: ABy/qLY5SI2kprQd96WhY5598UZsKNDPhTbOaB/7YUdDT5OUx1u48X4g
	Hl+VkT4pAWBbPzI/wN6yc3R2Su/cxJRYEw==
X-Google-Smtp-Source: APBJJlHKsJGvU82VzeyEfO5QEJtmREw/q75MWFEIMiH5SvaRpNgdDVoFCVOqIZ7rjBix9mF5fM+8Y75E1TRJyw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:c5c5:0:b0:d0b:d8cd:e661 with SMTP id
 v188-20020a25c5c5000000b00d0bd8cde661mr124893ybe.12.1691070858418; Thu, 03
 Aug 2023 06:54:18 -0700 (PDT)
Date: Thu,  3 Aug 2023 13:54:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230803135417.2716879-1-edumazet@google.com>
Subject: [PATCH net-next] tcp_metrics: hash table allocation cleanup
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After commit 098a697b497e ("tcp_metrics: Use a single hash table
for all network namespaces.") we can avoid calling tcp_net_metrics_init()
for each new netns.

Instead, rename tcp_net_metrics_init() to tcp_metrics_hash_alloc(),
and move it to __init section.

Also move tcpmhash_entries to __initdata section.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_metrics.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 82f4575f9cd90049a5ad4c7329ad1ddc28fc1aa0..96ab455063c57fd04c8d754ee623929d009ee716 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -972,7 +972,7 @@ static struct genl_family tcp_metrics_nl_family __ro_after_init = {
 	.resv_start_op	= TCP_METRICS_CMD_DEL + 1,
 };
 
-static unsigned int tcpmhash_entries;
+static unsigned int tcpmhash_entries __initdata;
 static int __init set_tcpmhash_entries(char *str)
 {
 	ssize_t ret;
@@ -988,15 +988,11 @@ static int __init set_tcpmhash_entries(char *str)
 }
 __setup("tcpmhash_entries=", set_tcpmhash_entries);
 
-static int __net_init tcp_net_metrics_init(struct net *net)
+static void __init tcp_metrics_hash_alloc(void)
 {
+	unsigned int slots = tcpmhash_entries;
 	size_t size;
-	unsigned int slots;
 
-	if (!net_eq(net, &init_net))
-		return 0;
-
-	slots = tcpmhash_entries;
 	if (!slots) {
 		if (totalram_pages() >= 128 * 1024)
 			slots = 16 * 1024;
@@ -1009,9 +1005,7 @@ static int __net_init tcp_net_metrics_init(struct net *net)
 
 	tcp_metrics_hash = kvzalloc(size, GFP_KERNEL);
 	if (!tcp_metrics_hash)
-		return -ENOMEM;
-
-	return 0;
+		panic("Could not allocate the tcp_metrics hash table\n");
 }
 
 static void __net_exit tcp_net_metrics_exit_batch(struct list_head *net_exit_list)
@@ -1020,7 +1014,6 @@ static void __net_exit tcp_net_metrics_exit_batch(struct list_head *net_exit_lis
 }
 
 static __net_initdata struct pernet_operations tcp_net_metrics_ops = {
-	.init		=	tcp_net_metrics_init,
 	.exit_batch	=	tcp_net_metrics_exit_batch,
 };
 
@@ -1028,9 +1021,11 @@ void __init tcp_metrics_init(void)
 {
 	int ret;
 
+	tcp_metrics_hash_alloc();
+
 	ret = register_pernet_subsys(&tcp_net_metrics_ops);
 	if (ret < 0)
-		panic("Could not allocate the tcp_metrics hash table\n");
+		panic("Could not register tcp_net_metrics_ops\n");
 
 	ret = genl_register_family(&tcp_metrics_nl_family);
 	if (ret < 0)
-- 
2.41.0.640.ga95def55d0-goog


