Return-Path: <netdev+bounces-133954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA82997900
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8411C21A52
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E17919A285;
	Wed,  9 Oct 2024 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lTZKxmLe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E03189520
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728515906; cv=none; b=shfvG/j/g2PojgiUL1JurSHAJK/nAx2/O7SeX4yxMnkh9M+iHuoTeCf3HbRvSdXwulL4PUYE+Jw/3HlLUZkgB7z36T4Co+84E0wcvfKiXzXpUiP9T0xiKJtUsYDPf9XzEAJcC4Gc+w8bvPC/aUXdCH/ZhTcX7cxx+nfN+mPC1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728515906; c=relaxed/simple;
	bh=ABFIbOSOHUK/UmVtc69LX2ps1SYjHEfyxVLz6wFPCcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvaQEztuMfzPHG3E/5DV2glIiATzwBQqORfrE/VOKezYczl87xFtiSTMBdiL2245PNyXSgQGst8vaSW4dg457ORzMqdzWv2OlDMEryByvQNQQVJdRKqUgsHPZS/jZwjKaEeZ4b8knjAvAY9Dvo4OJ5YP8OmUt7UqyHIzg0KwknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lTZKxmLe; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728515905; x=1760051905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QzeR79WX7PhG8ZqYR0aJUnjTpVx8wki/aJN3WxGqk60=;
  b=lTZKxmLe4+Kte87/3OlteqE50lc/4UqIvyNqPlSPUynXojr5MJ1TiQN3
   ihECZYvfFxWt/fcMWm6q9r6Vow3thhlTxhUjfhNXsFslMci1kQDGLf1ii
   vvuoNoIV+AWLsXrxMKB4zQTX3dj/+8NsK8746z0b70Fr338Dtp8ItS7y+
   M=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="430254231"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:18:21 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:32574]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id fcdf5521-eb11-4620-a8d6-9a66f902efe5; Wed, 9 Oct 2024 23:18:20 +0000 (UTC)
X-Farcaster-Flow-ID: fcdf5521-eb11-4620-a8d6-9a66f902efe5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:18:20 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:18:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 04/13] rtnetlink: Move simple validation from __rtnl_newlink() to rtnl_newlink().
Date: Wed, 9 Oct 2024 16:16:47 -0700
Message-ID: <20241009231656.57830-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009231656.57830-1-kuniyu@amazon.com>
References: <20241009231656.57830-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will push RTNL down to rtnl_newlink().

Let's move RTNL-independent validation to rtnl_newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 1d214c76011d..3416f364db83 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3706,15 +3706,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 #ifdef CONFIG_MODULES
 replay:
 #endif
-	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFLA_MAX,
-				     ifla_policy, extack);
-	if (err < 0)
-		return err;
-
-	err = rtnl_ensure_unique_netns(tb, extack, false);
-	if (err < 0)
-		return err;
-
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
@@ -3730,16 +3721,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		dev = NULL;
 	}
 
-	if (tb[IFLA_LINKINFO]) {
-		err = nla_parse_nested_deprecated(linkinfo, IFLA_INFO_MAX,
-						  tb[IFLA_LINKINFO],
-						  ifla_info_policy, NULL);
-		if (err < 0)
-			return err;
-	} else {
-		memset(linkinfo, 0, sizeof(tbs->linkinfo));
-	}
-
 	if (linkinfo[IFLA_INFO_KIND]) {
 		nla_strscpy(kind, linkinfo[IFLA_INFO_KIND], sizeof(kind));
 		ops = rtnl_link_ops_get(kind);
@@ -3808,6 +3789,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
+	struct nlattr **tb, **linkinfo;
 	struct rtnl_newlink_tbs *tbs;
 	int ret;
 
@@ -3815,7 +3797,30 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!tbs)
 		return -ENOMEM;
 
+	tb = tbs->tb;
+	ret = nlmsg_parse_deprecated(nlh, sizeof(struct ifinfomsg), tb,
+				     IFLA_MAX, ifla_policy, extack);
+	if (ret < 0)
+		goto free;
+
+	ret = rtnl_ensure_unique_netns(tb, extack, false);
+	if (ret < 0)
+		goto free;
+
+	linkinfo = tbs->linkinfo;
+	if (tb[IFLA_LINKINFO]) {
+		ret = nla_parse_nested_deprecated(linkinfo, IFLA_INFO_MAX,
+						  tb[IFLA_LINKINFO],
+						  ifla_info_policy, NULL);
+		if (ret < 0)
+			goto free;
+	} else {
+		memset(linkinfo, 0, sizeof(tbs->linkinfo));
+	}
+
 	ret = __rtnl_newlink(skb, nlh, tbs, extack);
+
+free:
 	kfree(tbs);
 	return ret;
 }
-- 
2.39.5 (Apple Git-154)


