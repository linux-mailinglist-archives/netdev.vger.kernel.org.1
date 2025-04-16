Return-Path: <netdev+bounces-183065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C495A8ACD5
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D16C1901589
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0CC1D8DE4;
	Wed, 16 Apr 2025 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NuO97GBW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F682AD16
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764237; cv=none; b=bFDaR+4s2TVF8INguS8IPUrmmNTwFYDVbYspeCbD+FQ8ecBq83L+CbeYyqqedSQJAFjnPCfxSDM1HzZL/XL6ZbfRznoNysI4VX7ecD6EnDxVRhXt8ZdwAjM16GA++cnHuUXrZ0DSkeBU8Rbu94t2hG8S1C1WgwQp9ygeoluvLiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764237; c=relaxed/simple;
	bh=JM+trVTyjFahQAQAYABA3f2OTDBJzZ1deo6i3PJTEX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTJZR9QOlWGUVVjtJagruyUggMueiGqMySKpEIbVrB1A8Faobx5GkKGVpVBxQNkNb7cTXtdXOaLXerA7GxvsQ1w7YI2IpaowVtEgE+C2ildH9blXkbTD4WXDMoKX8Ej/4zKaZMvMABoWQZDLKiACR1qhIedNuuguHsLjGyjCWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NuO97GBW; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744764236; x=1776300236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WVecZ4Nrnpy3GBNpADrvMcGfdHXV+8TDPljIn/d/Xlo=;
  b=NuO97GBWvwFTCtFLsOGMBb3gxSuuqa3QSFJkFkz9MBkpuJpZirgcqQhG
   EpOwbSWNnZ57Urio0O7qyiIPGWT5sX8pePODahyf6lBVWD6JUpG/AhzwX
   9wZNkSnjbnyeGFT9dAcjo0S2thFpmDFh2OK+yPI0qrevD6DZAl8jBtGpY
   0=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="84018323"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:43:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:61673]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id eb260e5f-0fb4-4d04-ab14-46b8535ec4d7; Wed, 16 Apr 2025 00:43:52 +0000 (UTC)
X-Farcaster-Flow-ID: eb260e5f-0fb4-4d04-ab14-46b8535ec4d7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:43:52 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.149.87) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:43:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/7] neighbour: Move two validations from neigh_get() to neigh_valid_get_req().
Date: Tue, 15 Apr 2025 17:41:25 -0700
Message-ID: <20250416004253.20103-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416004253.20103-1-kuniyu@amazon.com>
References: <20250416004253.20103-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove RTNL for neigh_get() and run it under RCU instead.

neigh_get() returns -EINVAL in the following cases:

  * NDA_DST is not specified
  * Both ndm->ndm_ifindex and NTF_PROXY are not specified

These validations do not require RCU.

Let's move them to neigh_valid_get_req().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/neighbour.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 8384a025e7c0..af84515fb86a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2872,6 +2872,11 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 		goto err;
 	}
 
+	if (!(ndm->ndm_flags & NTF_PROXY) && !ndm->ndm_ifindex) {
+		NL_SET_ERR_MSG(extack, "No device specified");
+		goto err;
+	}
+
 	err = nlmsg_parse_deprecated_strict(nlh, sizeof(struct ndmsg), tb,
 					    NDA_MAX, nda_policy, extack);
 	if (err < 0)
@@ -2885,11 +2890,13 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 	}
 
 	for (i = 0; i <= NDA_MAX; ++i) {
-		if (!tb[i])
-			continue;
-
 		switch (i) {
 		case NDA_DST:
+			if (!tb[i]) {
+				NL_SET_ERR_MSG(extack, "Network address not specified");
+				goto err;
+			}
+
 			if (nla_len(tb[i]) != (int)(*tbl)->key_len) {
 				NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
 				goto err;
@@ -2897,6 +2904,9 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 			*dst = nla_data(tb[i]);
 			break;
 		default:
+			if (!tb[i])
+				continue;
+
 			NL_SET_ERR_MSG(extack, "Unsupported attribute in neighbor get request");
 			goto err;
 		}
@@ -2991,11 +3001,6 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	if (!dst) {
-		NL_SET_ERR_MSG(extack, "Network address not specified");
-		return -EINVAL;
-	}
-
 	if (ndm->ndm_flags & NTF_PROXY) {
 		struct pneigh_entry *pn;
 
@@ -3008,11 +3013,6 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 					nlh->nlmsg_seq, tbl);
 	}
 
-	if (!dev) {
-		NL_SET_ERR_MSG(extack, "No device specified");
-		return -EINVAL;
-	}
-
 	neigh = neigh_lookup(tbl, dst, dev);
 	if (!neigh) {
 		NL_SET_ERR_MSG(extack, "Neighbour entry not found");
-- 
2.49.0


