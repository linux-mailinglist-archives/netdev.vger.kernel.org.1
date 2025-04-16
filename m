Return-Path: <netdev+bounces-183064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BD9A8ACC9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A561A442939
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130BB1D6DB6;
	Wed, 16 Apr 2025 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Cc1ko1UC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7E51CAA98
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764215; cv=none; b=tnV4nQewY4MigD98z1unRaoLJXtUhEmczJwY3SAadFha3RdMAJfGXsZpDgoEptqJnzdEhv2oF/UAucVEaYpr49JzqoW+S8xoL+ll13jXm1IdbpRuRs9g7BM+XUB75AlrciTe2KCmll/B1KYH/l6jbOAoZxo4iAxkKgDtnkuartw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764215; c=relaxed/simple;
	bh=xbg1xMDj3A9emjuJ+k26sfJ+2VOiYK90onpz9RldSzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2eFcZVWr+5Oy3hbitwdosQbokoDbX344V7FW+iQzCNT2MQr9b2HT59n828tnAzdqzyVDMoWzReB5HSiUrPJdc8XFtoKg1WSAr9u6qoRWBbFpUiaB1lcuZG4pCyDBkPmROTdUG4ugYumBF9eN40PV6EVHUrn9JpUE3bxYSFcmDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Cc1ko1UC; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744764214; x=1776300214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=78AU335/wCD0y54b0qDVKINti3J6lEPIUuYcBV3vdiA=;
  b=Cc1ko1UCsRgl0vBa8yi/DPBAvqAdZdggh7CK2yTACOeoZ6Rx6YQLOukT
   eaUgW/p4XiuDgsJDLAUXndc72onoDBkunptZWx05+tRwvbUMpvPasaCXL
   lqXB6VLHRrztpWaV8KpyWM0lNqszCLY9GkwLh9usyLc1YDm3Ij62+ZzpC
   E=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="480737474"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:43:30 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:30792]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id af7ea68e-9d25-46a4-94fb-1e5aaef9040a; Wed, 16 Apr 2025 00:43:29 +0000 (UTC)
X-Farcaster-Flow-ID: af7ea68e-9d25-46a4-94fb-1e5aaef9040a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:43:28 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.149.87) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:43:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/7] neighbour: Make neigh_valid_get_req() return ndmsg.
Date: Tue, 15 Apr 2025 17:41:24 -0700
Message-ID: <20250416004253.20103-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

neigh_get() passes 4 local variable pointers to neigh_valid_get_req().

If it returns a pointer of struct ndmsg, we do not need to pass two
of them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/neighbour.c | 49 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 65cf582b5dac..8384a025e7c0 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2846,43 +2846,42 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
-static int neigh_valid_get_req(const struct nlmsghdr *nlh,
-			       struct neigh_table **tbl,
-			       void **dst, int *dev_idx, u8 *ndm_flags,
-			       struct netlink_ext_ack *extack)
+static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
+					 struct neigh_table **tbl, void **dst,
+					 struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[NDA_MAX + 1];
 	struct ndmsg *ndm;
-	int err, i;
+	int err = -EINVAL;
+	int i;
 
 	ndm = nlmsg_payload(nlh, sizeof(*ndm));
 	if (!ndm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for neighbor get request");
-		return -EINVAL;
+		goto err;
 	}
 
 	if (ndm->ndm_pad1  || ndm->ndm_pad2  || ndm->ndm_state ||
 	    ndm->ndm_type) {
 		NL_SET_ERR_MSG(extack, "Invalid values in header for neighbor get request");
-		return -EINVAL;
+		goto err;
 	}
 
 	if (ndm->ndm_flags & ~NTF_PROXY) {
 		NL_SET_ERR_MSG(extack, "Invalid flags in header for neighbor get request");
-		return -EINVAL;
+		goto err;
 	}
 
 	err = nlmsg_parse_deprecated_strict(nlh, sizeof(struct ndmsg), tb,
 					    NDA_MAX, nda_policy, extack);
 	if (err < 0)
-		return err;
+		goto err;
 
-	*ndm_flags = ndm->ndm_flags;
-	*dev_idx = ndm->ndm_ifindex;
 	*tbl = neigh_find_table(ndm->ndm_family);
-	if (*tbl == NULL) {
+	if (!*tbl) {
 		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
-		return -EAFNOSUPPORT;
+		err = -EAFNOSUPPORT;
+		goto err;
 	}
 
 	for (i = 0; i <= NDA_MAX; ++i) {
@@ -2893,17 +2892,19 @@ static int neigh_valid_get_req(const struct nlmsghdr *nlh,
 		case NDA_DST:
 			if (nla_len(tb[i]) != (int)(*tbl)->key_len) {
 				NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
-				return -EINVAL;
+				goto err;
 			}
 			*dst = nla_data(tb[i]);
 			break;
 		default:
 			NL_SET_ERR_MSG(extack, "Unsupported attribute in neighbor get request");
-			return -EINVAL;
+			goto err;
 		}
 	}
 
-	return 0;
+	return ndm;
+err:
+	return ERR_PTR(err);
 }
 
 static inline size_t neigh_nlmsg_size(void)
@@ -2974,18 +2975,16 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	struct net_device *dev = NULL;
 	struct neigh_table *tbl = NULL;
 	struct neighbour *neigh;
+	struct ndmsg *ndm;
 	void *dst = NULL;
-	u8 ndm_flags = 0;
-	int dev_idx = 0;
 	int err;
 
-	err = neigh_valid_get_req(nlh, &tbl, &dst, &dev_idx, &ndm_flags,
-				  extack);
-	if (err < 0)
-		return err;
+	ndm = neigh_valid_get_req(nlh, &tbl, &dst, extack);
+	if (IS_ERR(ndm))
+		return PTR_ERR(ndm);
 
-	if (dev_idx) {
-		dev = __dev_get_by_index(net, dev_idx);
+	if (ndm->ndm_ifindex) {
+		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
 		if (!dev) {
 			NL_SET_ERR_MSG(extack, "Unknown device ifindex");
 			return -ENODEV;
@@ -2997,7 +2996,7 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
-	if (ndm_flags & NTF_PROXY) {
+	if (ndm->ndm_flags & NTF_PROXY) {
 		struct pneigh_entry *pn;
 
 		pn = pneigh_lookup(tbl, net, dst, dev, 0);
-- 
2.49.0


