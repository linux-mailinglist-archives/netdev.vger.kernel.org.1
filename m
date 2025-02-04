Return-Path: <netdev+bounces-162707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B95A27B38
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 20:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E121885FA9
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D3A217703;
	Tue,  4 Feb 2025 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YT6TKoqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC39E217647
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697266; cv=none; b=tOhEOJloXSkTkTrlT6xG2x2xqrU7yoyT3JBRC3s5055Os4AtZMnrRfp/koiSDyE+GSXVR/YuZfL+BvjZEBuUC6ao7D7VHWeSYExL5Q/mHdMRKbQYtRozAWrEy9TrNDHBYvGTBf8Bvn4Rcdt1S88UI/JdIVUhZT6vz4Hfhqd9UkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697266; c=relaxed/simple;
	bh=CvYBgsQQ2sB2qTH/ispwYnc1GT/UJnN//HUW4OU8uMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WcjLTesvOzWSbQ7mCJDTlWj4w6JKJZjA5ru/Fi9YSTngdcEBg2kkxShhGAR6lIR9IDqWoFBTm91xH94EtaIXQJFZ2Q543lBWuSny9T/RQMTtsYQ8Y9F5aaP27cxvgyp9AWupxuXVkFwnkeg75jOezmAk1npyZHWEnQCo/ThqdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YT6TKoqJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-219f8263ae0so113002645ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 11:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738697264; x=1739302064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8iOEoCrXIGW4Q927eer0s+nYHhVWh5aiFKVXEGf2lEo=;
        b=YT6TKoqJ7WsNaU+ANvUyl/P7tTsIpeZaq9xNB6t7fFXo8U4f/ivhuojjWKtYtUZTkY
         9SUfuxys4+rnRJ9KFDTJBsIWkjCZ1vdpJPGJ8RC2TPjIBNZ5zmluauJHRELBK4ePGuOl
         kvuoU1APaQ2N+lGzVexTIPtQeL966q2z29lys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738697264; x=1739302064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8iOEoCrXIGW4Q927eer0s+nYHhVWh5aiFKVXEGf2lEo=;
        b=pVjKyawP5/iKLxKwcz8YWT2aPcTRR15nru2rck5o6nSJDDkqU6HNwKQWj+3PENWqir
         Ns24BGFs+KYwYqa3dUvEExKeuFi01/KjJGLCCdnKQ1LqeQMk6MYFSInx3dv+6OvBr0Y3
         JVP3hueWz7miNL91RpLBD+siNHwhVH4EF34Mb3Y23Sf1RKptkxB6IulKti8ln4Auy4TV
         qJT/xY2DNFyqufULX8O+GeYL3EIA+Y6W8KM+XYw2TglavwlNWyMZXqMVoon+uRqEekwr
         dbmpjg89OKW8Zbt2wZVkkReu8aRIW/4SZWQUSYYDtBIvgCvSZgx4eiiW6Aq8wJhYdg8+
         2DRA==
X-Gm-Message-State: AOJu0YyKy78swAmnsnp2D+Ek8zjJGzCY2PygNF83f6yH5ACWc1FPeniK
	uU17Xtx61JeRrqu0UUffl6Ec+2edV7P5IoxGVWeudYd1ySjRaTD3uasY+hKK9EPKpeMJjbNyRQI
	01MojshuzfUG9lIUsHWt0B5ONQsAdm9ivH/Cgdv14UCoTuBb57LwfBbVFq616dV2KuzSlSsqmPh
	+0hMhXncW2rVbGNl5i6+Bk5T2A8S3PZJmwAhs=
X-Gm-Gg: ASbGnctxIqBd1Vf+ZZYqobpM1lekdDOGAh6YLDGhPrbE6ypD2c2H5/X/1UlQ6h82Y2H
	FKk2hsoAUjTLbhegR9Uh3FR/UH0hFlT/VJoJEDhXwTk4Xeq0/lH09JwEFyvJFq69WcQbT+w+NkJ
	QvHVItw2uKdbE2aE8ezkx4g8t4CXDeY+5NxJ5ugDyftjSBuVyWT4RNJQaLLyVdTRHUzlkk8+B0q
	ZLACnH/I+23vyskxDSLLRK/A52OfN70rkahuo79/S5CWmDkcSVsIwoRiMpiwvutfLqlZNs9amRB
	onmcBwVRGX88meauXVcLJSM=
X-Google-Smtp-Source: AGHT+IE+7dWcfNLhQTOMhd0Vsf5ukouIeilZjFgIDC26Ks2ade1xUAcue6WYJyYElM16Cq1HmnYHfA==
X-Received: by 2002:a17:903:2406:b0:215:8dd3:536a with SMTP id d9443c01a7336-21f17e2a49fmr393235ad.4.1738697263622;
        Tue, 04 Feb 2025 11:27:43 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331ddfdsm99261345ad.210.2025.02.04.11.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:27:43 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3] netdev-genl: Elide napi_id when not present
Date: Tue,  4 Feb 2025 19:27:21 +0000
Message-ID: <20250204192724.199209-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are at least two cases where napi_id may not present and the
napi_id should be elided:

1. Queues could be created, but napi_enable may not have been called
   yet. In this case, there may be a NAPI but it may not have an ID and
   output of a napi_id should be elided.

2. TX-only NAPIs currently do not have NAPI IDs. If a TX queue happens
   to be linked with a TX-only NAPI, elide the NAPI ID from the netlink
   output as a NAPI ID of 0 is not useful for users.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v3:
  - Took Eric's suggested patch to refactor the code to use helpers,
    which improves the code quality significantly.

 v2: https://lore.kernel.org/netdev/20250203191714.155526-1-jdamato@fastly.com/
   - Updated to elide NAPI IDs for RX queues which may have not called
     napi_enable yet.

 rfc: https://lore.kernel.org/lkml/20250128163038.429864-1-jdamato@fastly.com/

 include/net/busy_poll.h |  5 +++++
 net/core/netdev-genl.c  | 13 +++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index c39a426ebf52..741fa7754700 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -24,6 +24,11 @@
  */
 #define MIN_NAPI_ID ((unsigned int)(NR_CPUS + 1))
 
+static inline bool napi_id_valid(unsigned int napi_id)
+{
+	return napi_id >= MIN_NAPI_ID;
+}
+
 #define BUSY_POLL_BUDGET 8
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 715f85c6b62e..5aa3ed870b2c 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -364,6 +364,13 @@ int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int nla_put_napi_id(struct sk_buff *skb, const struct napi_struct *napi)
+{
+	if (napi && napi_id_valid(napi->napi_id))
+		return nla_put_u32(skb, NETDEV_A_QUEUE_NAPI_ID, napi->napi_id);
+	return 0;
+}
+
 static int
 netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
@@ -385,8 +392,7 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 	switch (q_type) {
 	case NETDEV_QUEUE_TYPE_RX:
 		rxq = __netif_get_rx_queue(netdev, q_idx);
-		if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
-					     rxq->napi->napi_id))
+		if (nla_put_napi_id(rsp, rxq->napi))
 			goto nla_put_failure;
 
 		binding = rxq->mp_params.mp_priv;
@@ -397,8 +403,7 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
-		if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
-					     txq->napi->napi_id))
+		if (nla_put_napi_id(rsp, rxq->napi))
 			goto nla_put_failure;
 	}
 

base-commit: c2933b2befe25309f4c5cfbea0ca80909735fd76
-- 
2.43.0


