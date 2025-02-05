Return-Path: <netdev+bounces-163236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE4A29A44
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C273A0812
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6B9204092;
	Wed,  5 Feb 2025 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="NJKcO/77"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732441FE476
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784291; cv=none; b=fveuyEGnutC6chfn7e4pSxZ83enTM8w1E44pGrQZHCgIyvWieF9gQoidgsUScsc3gp5tppJhFWzWUbOfAZMN5qFeoV2atsFBFANsxeJd7y/bHU6+O+xzYZM+YIauTterDk3PVC7yAVBUdYbl7oIWV0YmKTrkkzk1yWuE2kDyASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784291; c=relaxed/simple;
	bh=6uXbUzdREBssIW/56lp9+osP8wskTzhD5dGm6h63ZAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rfVZIiSckP2khC/9wT51Czmd8ZMAj9yBMBJIsODHwnZq5DuIJes/wyOJ3G71UoZGdzOqPfUSyGgjwMQc/9365agitfi//Kb+ihjebPzs8vyk4LgrnZ9u7TNmV8YgossYsA/erZ9huccXzshe8+9np94RNdPACXYA/sx+5XuiNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=NJKcO/77; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f9c97af32eso85062a91.2
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 11:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738784289; x=1739389089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhr7/jrRE/HjJFixjFrzU1vwqSk/fF+4+8h2TqxlTAo=;
        b=NJKcO/77ZZceteFrkL9p3HILEpEfmxri2VVZ4qj75RvyP5WvEvPrVpplY+lJJaf7id
         Qw5JnuOyD5mehEo1xbbQjWok39tYhARJaHQmXARuwEALZb2derRwcI8yNr69vE019bOE
         sy728w29rA9oVByPwdkMXZFs/XvtgAWaItxsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738784289; x=1739389089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xhr7/jrRE/HjJFixjFrzU1vwqSk/fF+4+8h2TqxlTAo=;
        b=SVrZdOZ93+r1VFs/TNSM54z3MIisqlaL8ZxGb72nGC6ufLgMTAAeIojPPTYT0yqEyD
         fjjdeLUulQhrEx0kfAgecWXZY4JqSl8632yyQWa8mCudLTmrTj8KMGvqZE0LYqLszCrF
         PHnY86QkFBL8HH0jUwph+jT6l3bfxTWHKKo/6VjGsiQCOlT1eWuvjf+G0LzCO8X1MWov
         6LFBejkyEgX54WlqGRN/PFVUYpA2DZN23FLnWkmERY1X53f2Lz/qa9Hhe+h6Kx64XFnG
         Jd4NAaUu0Hj79a0bBr524rHES7HBzhSCAZUiLAnkJ3R5d/hyUFQvYYwrd5rmLLrZMXYM
         e4Hg==
X-Gm-Message-State: AOJu0Yx5CuKIejIFXWQS9dpjvbuSp/7SxAdST9IeefeAZl2HkUIF38oi
	t4Ly/QifDU0uXe0lZ69UHJ1TpaZdklPJOHtrNV7I13VsJkeQixw0kXTOkhDN4xfsY36LDbFVQLx
	ekwx+Vfh+Qrr2dV3XtlLYsmdl7/ocngdseGdp1yudKtqWiz8o0naplqq0tEc3JahYF39bMxEP64
	pA3cd4nMNjU2qiVsUjyErIwI2BBKmv38rKT2w=
X-Gm-Gg: ASbGnctCoPsg7sBbYY5ie8Gyzi0J5Lg5zU+Bp4MG8Hcd3xlZbsmbefYE2qMzbdKIfCU
	eCFjIoxn6C22HJh3aFl0UgJkQ7TNQjF7/Cdo9Zp7EAfGEwlYPXOUS5X2JWVl8D7xiPsYEjQiDov
	kJ42cfeFNs8lC8nJt96d2oQH+7/0rNqN3nnU06XQoPfxSvmVW1b83StpTQKWnXk8/E+WBLteO8R
	6HOPXS5S1V3qj9NssuRNFi6fYAFJap03/LBHE43P+O9rYRyV0s8pzPVQtCvKwPLTI34tC1Q2+Jn
	KM+Ko/4mihY6BiP3m+zIEyQ=
X-Google-Smtp-Source: AGHT+IEG30GcyrdDcVUeAd52bYnK7kh1XNEPgfaw3ovyxDPoEE7UUtYd3b0uGutzocFSSVDCEArnAQ==
X-Received: by 2002:a05:6a00:9095:b0:72a:8f07:2bf2 with SMTP id d2e1a72fcca58-73035117eabmr6796991b3a.9.1738784287337;
        Wed, 05 Feb 2025 11:38:07 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cdc3fsm12898784b3a.124.2025.02.05.11.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:38:06 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4] netdev-genl: Elide napi_id when not present
Date: Wed,  5 Feb 2025 19:37:47 +0000
Message-ID: <20250205193751.297211-1-jdamato@fastly.com>
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
 v4:
  - Fixed a typo in the NETDEV_QUEUE_TYPE_TX case (rxq should've been
    txq).

 v3: https://lore.kernel.org/netdev/20250204192724.199209-1-jdamato@fastly.com/
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
index 715f85c6b62e..b5c4e42351e6 100644
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
+		if (nla_put_napi_id(rsp, txq->napi))
 			goto nla_put_failure;
 	}
 

base-commit: 0bea93fdbaf8675b7e8124bdcaf51497dcc8bcfa
-- 
2.43.0


