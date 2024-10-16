Return-Path: <netdev+bounces-136261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47389A1215
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DF71C22D9B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2EB2144DD;
	Wed, 16 Oct 2024 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B1BKGUXg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E3F212EF5
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104970; cv=none; b=Gm53J5xYqAd+KLNc3YNtxfyKIXDM5HWIyjxMzg/24JNWlbplvypp/lu2Eh4WDGKEKvD4hSXlggMg/aM9tiIzS4ZWX9DiCrfp1/T7wcW2qbuNRnKexBQDV8odTV6UK+xs43bFEiFpc2xH8ZSe1fbgd6bVzufNToWjjy8sOTKKBeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104970; c=relaxed/simple;
	bh=eEpnGQMRUViynbNHOXZUmXmzxicFfpDgKlCoYMtEBIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lui4O7xafSXUYvLdsaYoXy4n42JzeNP6w2pzVQIYwdIzs56XGM6vQ5Q8D0fHGry41c97trRQXgENyJRd0njtZEJTecJ+ldPSWh8YTN+pmgE/WjTG00yxr8CHPhDL7X+I4LeHexBQOCze1e/V/spu+ds3bwNkevjl8OKPTQwN9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=B1BKGUXg; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729104969; x=1760640969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8sFHA1ab51phTqSXR1j8fyU2LEm0+PMiMEdRXUxqH+4=;
  b=B1BKGUXgfaTNnBPX0dyYksB0a0qP/Z/hC/Ef+6QH6bcZAiaewADJy5/J
   PSCa4mSG2/gkpDcGMbCPpiW7zJEODUucy5x+H1b+afmXKUrGgMCUe6JwL
   eVFw8WhRFGyOEdPcvEftX+NFc5L2gFRlqnE16aSS3J54kAHAzzT0OBrBC
   E=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="435632780"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:56:05 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:35924]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id 1e687f30-d9a2-4845-bae0-927f22e8770a; Wed, 16 Oct 2024 18:56:04 +0000 (UTC)
X-Farcaster-Flow-ID: 1e687f30-d9a2-4845-bae0-927f22e8770a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:56:04 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:56:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 06/14] rtnetlink: Move ops->validate to rtnl_newlink().
Date: Wed, 16 Oct 2024 11:53:49 -0700
Message-ID: <20241016185357.83849-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241016185357.83849-1-kuniyu@amazon.com>
References: <20241016185357.83849-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ops->validate() does not require RTNL.

Let's move it to rtnl_newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 49 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e708f0852602..9c9290a6c271 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3692,16 +3692,14 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  const struct rtnl_link_ops *ops,
 			  struct rtnl_newlink_tbs *tbs,
+			  struct nlattr **data,
 			  struct netlink_ext_ack *extack)
 {
-	struct nlattr ** const linkinfo = tbs->linkinfo;
 	struct nlattr ** const tb = tbs->tb;
 	struct net *net = sock_net(skb->sk);
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
-	struct nlattr **data;
 	bool link_specified;
-	int err;
 
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
@@ -3718,26 +3716,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		dev = NULL;
 	}
 
-	data = NULL;
-	if (ops) {
-		if (ops->maxtype > RTNL_MAX_TYPE)
-			return -EINVAL;
-
-		if (ops->maxtype && linkinfo[IFLA_INFO_DATA]) {
-			err = nla_parse_nested_deprecated(tbs->attr, ops->maxtype,
-							  linkinfo[IFLA_INFO_DATA],
-							  ops->policy, extack);
-			if (err < 0)
-				return err;
-			data = tbs->attr;
-		}
-		if (ops->validate) {
-			err = ops->validate(tb, data, extack);
-			if (err < 0)
-				return err;
-		}
-	}
-
 	if (dev)
 		return rtnl_changelink(skb, nlh, ops, dev, tbs, data, extack);
 
@@ -3768,8 +3746,8 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
+	struct nlattr **tb, **linkinfo, **data = NULL;
 	const struct rtnl_link_ops *ops = NULL;
-	struct nlattr **tb, **linkinfo;
 	struct rtnl_newlink_tbs *tbs;
 	int ret;
 
@@ -3813,7 +3791,28 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 #endif
 	}
 
-	ret = __rtnl_newlink(skb, nlh, ops, tbs, extack);
+	if (ops) {
+		if (ops->maxtype > RTNL_MAX_TYPE)
+			return -EINVAL;
+
+		if (ops->maxtype && linkinfo[IFLA_INFO_DATA]) {
+			ret = nla_parse_nested_deprecated(tbs->attr, ops->maxtype,
+							  linkinfo[IFLA_INFO_DATA],
+							  ops->policy, extack);
+			if (ret < 0)
+				goto free;
+
+			data = tbs->attr;
+		}
+
+		if (ops->validate) {
+			ret = ops->validate(tb, data, extack);
+			if (ret < 0)
+				goto free;
+		}
+	}
+
+	ret = __rtnl_newlink(skb, nlh, ops, tbs, data, extack);
 
 free:
 	kfree(tbs);
-- 
2.39.5 (Apple Git-154)


