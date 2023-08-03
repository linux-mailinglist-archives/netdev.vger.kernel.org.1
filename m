Return-Path: <netdev+bounces-24089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A955476EBC7
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630DF2821F7
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1037200CA;
	Thu,  3 Aug 2023 14:06:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47263D8E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 14:06:07 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07D344AB
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 07:05:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbf0f36ce4so6958315ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 07:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691071545; x=1691676345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Lk7Clg45RdUie/KjcmE3+28g2kd4eecHFcFfnkQv4M=;
        b=asWSJ+14SkxdbE8UXoYgIqvov0BFM79fmeO9euJ1Wv5XRqpkHwShFP6NIXKgvBYS39
         KY1uMbrWNQbSjJupGWVrrURhvJ8kmrkqWIv6ZEFPZTTKBxHUS5kikgwuA3z8c5IUvEuo
         pwfcOp99klDueriStK3YRP+G2A3ta6IrwdNffYwsY1QRFXnKH7rVeHr4XVx9ICdMcs8u
         TYhqMuVKoTXjFoBzzxm/+LJENMac9MTDwKIUuXzmbia+bqx/NXWlVFRC025fJ/SNhI7G
         0sUAAhVdNnFRuvikv0BqaV30V85oEqKXByDdz6upJq+kqp/EKzh4Br8vam8A46D6ers7
         qYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071545; x=1691676345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Lk7Clg45RdUie/KjcmE3+28g2kd4eecHFcFfnkQv4M=;
        b=l4pf/qzU7M5/Gdbvpa0ahWUateuBUfqmzGK9GifxqtC675Cl/rCOfHCUgkVByGmuWr
         xSeA0WOJzBtEBTsZ8DZzbC3g6sOFCwxrLosmFCCYnJ5knzOrMdUR6EakhBcVs+xDkUUB
         U2zY6y5RCIKu6gb6KjbSCwDRdomCOFEIG9utVG8V++MvUuqhtemB47EiqkAPx9qvJucV
         VgaPdpwlN8tYe0VfdmwR/ibHsanMzJAB2CjzclkOleTf+Z9QdpxQIxxh9gTkaLN/eiDo
         s+PMlDM7hw1jShvhgCbSXwiu6XA4ksBRnSpmxXINVlMA/oC2UY2RJ2fPJUn+IMZdwkck
         4s4w==
X-Gm-Message-State: ABy/qLZF7g2IUTEbr1VJGh0BlRLIwJzksU3mjqPtleJ29x7/Ejp6eTQC
	FSH9KE2JrWstu3mUPtLNyHIc2g==
X-Google-Smtp-Source: APBJJlFAD49Rki1qot079JravPBo6eprAsHUVmlpWIbFP9NtxcaEiWCV/ykOzsAbarNuQtLgr7hHUw==
X-Received: by 2002:a17:903:22c1:b0:1b8:a936:1905 with SMTP id y1-20020a17090322c100b001b8a9361905mr19934085plg.38.1691071545362;
        Thu, 03 Aug 2023 07:05:45 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000::8])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm14367485plb.195.2023.08.03.07.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:05:44 -0700 (PDT)
From: "huangjie.albert" <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "huangjie.albert" <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC Optimizing veth xsk performance 03/10] veth: add support for send queue
Date: Thu,  3 Aug 2023 22:04:29 +0800
Message-Id: <20230803140441.53596-4-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230803140441.53596-1-huangjie.albert@bytedance.com>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

in order to support native af_xdp for veth. we
need support for send queue for napi tx.
the upcoming patch will make use of it.

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index c2b431a7a017..63c3ebe4c5d0 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -56,6 +56,11 @@ struct veth_rq_stats {
 	struct u64_stats_sync	syncp;
 };
 
+struct veth_sq_stats {
+	struct veth_stats	vs;
+	struct u64_stats_sync	syncp;
+};
+
 struct veth_rq {
 	struct napi_struct	xdp_napi;
 	struct napi_struct __rcu *napi; /* points to xdp_napi when the latter is initialized */
@@ -69,11 +74,25 @@ struct veth_rq {
 	struct page_pool	*page_pool;
 };
 
+struct veth_sq {
+	struct napi_struct	xdp_napi;
+	struct net_device	*dev;
+	struct xdp_mem_info	xdp_mem;
+	struct veth_sq_stats	stats;
+	u32 queue_index;
+	/* this is for xsk */
+	struct {
+		struct xsk_buff_pool __rcu *pool;
+		u32 last_cpu;
+	}xsk;
+};
+
 struct veth_priv {
 	struct net_device __rcu	*peer;
 	atomic64_t		dropped;
 	struct bpf_prog		*_xdp_prog;
 	struct veth_rq		*rq;
+	struct veth_sq		*sq;
 	unsigned int		requested_headroom;
 };
 
@@ -1495,6 +1514,15 @@ static int veth_alloc_queues(struct net_device *dev)
 		u64_stats_init(&priv->rq[i].stats.syncp);
 	}
 
+	priv->sq = kcalloc(dev->num_tx_queues, sizeof(*priv->sq), GFP_KERNEL);
+	if (!priv->sq)
+		return -ENOMEM;
+
+	for (i = 0; i < dev->num_tx_queues; i++) {
+		priv->sq[i].dev = dev;
+		u64_stats_init(&priv->sq[i].stats.syncp);
+	}
+
 	return 0;
 }
 
@@ -1503,6 +1531,7 @@ static void veth_free_queues(struct net_device *dev)
 	struct veth_priv *priv = netdev_priv(dev);
 
 	kfree(priv->rq);
+	kfree(priv->sq);
 }
 
 static int veth_dev_init(struct net_device *dev)
-- 
2.20.1


