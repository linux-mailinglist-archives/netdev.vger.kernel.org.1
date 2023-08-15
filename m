Return-Path: <netdev+bounces-27722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF477D016
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC182814A8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9AF15AC6;
	Tue, 15 Aug 2023 16:26:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2AA156FD
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 16:26:24 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89A310D1
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:26:22 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40ffa784eaeso28630571cf.0
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692116782; x=1692721582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjmZ3NeF/Ok7CZo49WbchZlg0SyWPJ1z32hVeimCtu8=;
        b=C3980aITKSv8xzxwzSzD63kjJvFTPIhMMHecWJU8u3sdszNwJCK7wW8ncjq7yHg03p
         ee4CTYFLOJZtNkYbIB0Yc8DN93+3lKQBPRnoSL4OAliduX6OB/djHpqEuG0w5fnK+aN6
         3qvnAPzyrTDtxjlE0Q0CH6sEIOtZw0igXZwb1MVHSl0AO4ldvN/2c4RgYZVXnKy0Wbta
         jXTqrUHLnK3bAsA3+GXrmOLACIzLEDOQEw8oQ/46DIlHYuvZRxqCRNazsB0isLLtXHcH
         4s9EohlCpoutg3CKpHffB1yJBAw7LS6mexpnbdMS2LdjdEGU/vRf5OrqiZY5H9DMTO2g
         X24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692116782; x=1692721582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjmZ3NeF/Ok7CZo49WbchZlg0SyWPJ1z32hVeimCtu8=;
        b=Ur5wB7U+2fLDjiavekEhO2NfN5+vXXAwn3LJ7ddS0yW9fVfqUMglMPY1FfdZjsOexx
         RzEZvVb8MEiNcL78QllPLtlezG4ft7VO30SLWW/8SAo0rmJ8qlokeG9q34vwXUsW6lMx
         ev0G/M44sQ8hzHeoy3YRiArate7FKAmVF10XG6iMWbbHIuTQAKUvEACSKt/B0qmfHSjG
         4lf6xU0rQmXfp+bw1Tocd2xWOAhl8P8h1+9+ejWciWm1saFD3BlQfYug/Npvgkb1Hatz
         D4cK7EMLTzNPes4OKcFbZ35JDMdxL69YEWNkyBv3bwBHHtWlQsqAXLf1mEI/dv2HpISK
         3D7Q==
X-Gm-Message-State: AOJu0YyEgKn9/xxowI7FPtE53xDc0VSMkE/JwN2H6/9Otu+5AzQDR7/x
	6MMyXuojfybFyOMuK+q/Bcz0ew==
X-Google-Smtp-Source: AGHT+IGJZ3kDbWFYxkcUdW3XzedwvzL3kR8f/St9QPbgYa4k1O64K9yuolVY1i5iIPB8XLnbABtM2g==
X-Received: by 2002:ac8:5f0f:0:b0:406:94af:c912 with SMTP id x15-20020ac85f0f000000b0040694afc912mr15257815qta.54.1692116782080;
        Tue, 15 Aug 2023 09:26:22 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id q5-20020ac87345000000b003fde3d63d22sm3874640qtp.69.2023.08.15.09.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 09:26:21 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: jiri@resnulli.us
Cc: xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	vladbu@nvidia.com,
	mleitner@redhat.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH RFC net-next 2/3] Expose tc block ports to the datapath
Date: Tue, 15 Aug 2023 12:25:29 -0400
Message-Id: <20230815162530.150994-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815162530.150994-1-jhs@mojatatu.com>
References: <20230815162530.150994-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The datapath can now find the block of the port in which the packet arrived at.
It can then use it for various activities.

In the next patch we show a simple action that multicast to all ports except for
the port in which the packet arrived on.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/sch_generic.h | 4 ++++
 net/sched/cls_api.c       | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index f002b0423efc..a99ac60426b3 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -440,6 +440,8 @@ struct qdisc_skb_cb {
 	};
 #define QDISC_CB_PRIV_LEN 20
 	unsigned char		data[QDISC_CB_PRIV_LEN];
+	/* This should allow eBPF to continue to align */
+	u32                     block_index;
 };
 
 typedef void tcf_chain_head_change_t(struct tcf_proto *tp_head, void *priv);
@@ -488,6 +490,8 @@ struct tcf_block {
 	struct mutex proto_destroy_lock; /* Lock for proto_destroy hashtable. */
 };
 
+struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index);
+
 static inline bool lockdep_tcf_chain_is_locked(struct tcf_chain *chain)
 {
 	return lockdep_is_held(&chain->filter_chain_lock);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a976792ef02f..be4555714519 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1011,12 +1011,13 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
 	return block;
 }
 
-static struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
+struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
 {
 	struct tcf_net *tn = net_generic(net, tcf_net_id);
 
 	return idr_find(&tn->idr, block_index);
 }
+EXPORT_SYMBOL(tcf_block_lookup);
 
 static struct tcf_block *tcf_block_refcnt_get(struct net *net, u32 block_index)
 {
@@ -1737,9 +1738,12 @@ int tcf_classify(struct sk_buff *skb,
 		 const struct tcf_proto *tp,
 		 struct tcf_result *res, bool compat_mode)
 {
+	struct qdisc_skb_cb *qdisc_cb = qdisc_skb_cb(skb);
 #if !IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
 	u32 last_executed_chain = 0;
 
+	qdisc_cb->block_index = block->index;
+
 	return __tcf_classify(skb, tp, tp, res, compat_mode, NULL, 0,
 			      &last_executed_chain);
 #else
-- 
2.34.1


