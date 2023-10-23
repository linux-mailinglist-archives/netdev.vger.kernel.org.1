Return-Path: <netdev+bounces-43478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32687D374C
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 14:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4571CB20C28
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2D114F7E;
	Mon, 23 Oct 2023 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cn5eYQgo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFE7134A6
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:57:48 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5518C103
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 05:57:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b1ef786b7fso3091812b3a.3
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698065867; x=1698670667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yCAXAY3fgSa7Kb0MKqcgqBNDm1vRIcXYYGEzF/D8jjI=;
        b=cn5eYQgoZwYoVrloc6pgtjiTXhKXt/b4gJTG6YWyaYjCPEW3JeXcGuvbt084Jxeb8h
         M+fOAzw6Am89vWd0VishxaqzzqqQYCtSWHOWE9JwE6dow6D0jDl/cKXdIFyf1YY2Lz24
         btW++4KfL4GQEAfrzygkr95BTn5LC3DRnxeUiJMPYkRUvjvC8wnMwMFSX1COCuK871Ph
         s5LV2/rBbujfR63tRGVEI945BKdm9foz4/4671cI1mkaYN2I34wUBTDUNVpl887O2Ss8
         bEcVZnyVRr0ST7K84/FtplkgNkqceuDMlL/2mTwgfsCKzdmWBD2AZqxpEN9Ptpb2Y8dW
         nYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698065867; x=1698670667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCAXAY3fgSa7Kb0MKqcgqBNDm1vRIcXYYGEzF/D8jjI=;
        b=FTYm1rIZn/npY2eSy0vjpNYbq7UBoaPGG4ZD7KikaD9m+h6VZ4u0f0TLOdxz2Rivkv
         YAUln6KXiewWWfoyatoUBaJ8dqArk8zzYNtSqej3PNVhhL5LpAp+yuBiMegsYyH64Hck
         ZE6moWbqco1FmUzQ7rooke2ATC2QFjA0/AlvRaj6IEgrXHYctBbPvDNNF7PHAnufURmS
         Rece27OWu+1Nq24Gj78B8zwcJqWhag8rZpRW4+Xhzom3IgrOcDWpVw4EftrdFmZUs6+l
         ZG36GMZzBNKJLZP54lie8KH+sKZxrj30hbbNy+Mik5lxXiqkGliaimIxXsY8NKlwano+
         /jtQ==
X-Gm-Message-State: AOJu0YzLSicXci3VP7x28gtqu0AcwezO32V5c8LF+I5DyreMLmM/fTTx
	ZnySsFMHModNbQpkqVH2Rw4n1g==
X-Google-Smtp-Source: AGHT+IFf6zV09p7t/ZyPlfIP759xrLQulyHUf1/ol6SF33PPdLltGWgp7s08x8wNXn7uL1UWu0qZGQ==
X-Received: by 2002:a05:6a20:6a06:b0:17e:87c1:7971 with SMTP id p6-20020a056a206a0600b0017e87c17971mr434493pzk.46.1698065866765;
        Mon, 23 Oct 2023 05:57:46 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([240e:6b1:c0:120::2:3])
        by smtp.gmail.com with ESMTPSA id k28-20020aa79d1c000000b006bde2480806sm6056588pfp.47.2023.10.23.05.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:57:46 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net-next] xsk: avoid starving the xsk further down the list
Date: Mon, 23 Oct 2023 20:57:31 +0800
Message-Id: <20231023125732.82261-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the previous implementation, when multiple xsk sockets were
associated with a single xsk_buff_pool, a situation could arise
where the xsk_tx_list maintained data at the front for one xsk
socket while starving the xsk sockets at the back of the list.
This could result in issues such as the inability to transmit packets,
increased latency, and jitter. To address this problem, we introduce
a new variable called tx_budget_spent, which limits each xsk to transmit
a maximum of MAX_PER_SOCKET_BUDGET tx descriptors. This allocation ensures
equitable opportunities for subsequent xsk sockets to send tx descriptors.
The value of MAX_PER_SOCKET_BUDGET is set to 32.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/net/xdp_sock.h |  7 +++++++
 net/xdp/xsk.c          | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 69b472604b86..de6819e50d54 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -63,6 +63,13 @@ struct xdp_sock {
 
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
 	struct list_head tx_list;
+	/* record the number of tx descriptors sent by this xsk and
+	 * when it exceeds MAX_PER_SOCKET_BUDGET, an opportunity needs
+	 * to be given to other xsks for sending tx descriptors, thereby
+	 * preventing other XSKs from being starved.
+	 */
+	u32 tx_budget_spent;
+
 	/* Protects generic receive. */
 	spinlock_t rx_lock;
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f5e96e0d6e01..65c32b85c326 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -33,6 +33,7 @@
 #include "xsk.h"
 
 #define TX_BATCH_SIZE 32
+#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
 
 static DEFINE_PER_CPU(struct list_head, xskmap_flush_list);
 
@@ -413,16 +414,25 @@ EXPORT_SYMBOL(xsk_tx_release);
 
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 {
+	bool budget_exhausted = false;
 	struct xdp_sock *xs;
 
 	rcu_read_lock();
+again:
 	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+		if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
+			budget_exhausted = true;
+			continue;
+		}
+
 		if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
 			if (xskq_has_descs(xs->tx))
 				xskq_cons_release(xs->tx);
 			continue;
 		}
 
+		xs->tx_budget_spent++;
+
 		/* This is the backpressure mechanism for the Tx path.
 		 * Reserve space in the completion queue and only proceed
 		 * if there is space in it. This avoids having to implement
@@ -436,6 +446,14 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 		return true;
 	}
 
+	if (budget_exhausted) {
+		list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list)
+			xs->tx_budget_spent = 0;
+
+		budget_exhausted = false;
+		goto again;
+	}
+
 out:
 	rcu_read_unlock();
 	return false;
-- 
2.20.1


