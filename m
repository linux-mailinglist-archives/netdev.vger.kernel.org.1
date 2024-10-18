Return-Path: <netdev+bounces-136784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315979A31FD
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9711C20EB8
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD59A47A5C;
	Fri, 18 Oct 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sVpTJaJi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162FE28399
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214600; cv=none; b=RWO0ZKdaYltF8pWsjPxl4PRcODOHrf6xTk8BXfPQPG0mmywiX6ocgoygs1Zbwvpy4cWI14Y22AiDlukVsJULZt/QueggrsZ/xIiJakquYbkKCEyntGd8NUV73EEIrBYH2eRVPpkx/VuM5dk2MT1aSPHWJvAJ3qRY6w4viEU7Zv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214600; c=relaxed/simple;
	bh=bFhqSnc4snQX+HKf4hZpM1XEYDKYRIdjCigx/gCYOQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDfyO8p1HaTMS69CoWpKS/gLl0xpqfi5xWrlOv4SChdcC4jKi17UxWkUENK3v7CbCSh6FXIjFnXEKrLcwDTY1zCegwgFXiAftnGKLsNyS5hvdSAhyLhKfpczFi0gFxqqAPar46RfMxfmtSh2l2Kx4ni2DViolvlARkvhoifyptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sVpTJaJi; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729214599; x=1760750599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lzg3Dfa43RAgfRDdpWes3fxXtJJCHx4U44xGSqws87U=;
  b=sVpTJaJixQgrMUobq2djMUg8o9C1KE3b/k7iPh/6tHDuRGKejDezS81+
   4pm/HeRyOKbLhy+rrbU70QVVJxZSYIt2qloi4+j84qhSASzRoPp8bQqF3
   S1HBHcUZkxO0QZNne14cL5zQ8n8NoIvwTKPZg4+CSF+Tw48H2V/8IZZRC
   I=;
X-IronPort-AV: E=Sophos;i="6.11,212,1725321600"; 
   d="scan'208";a="436052306"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:23:15 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:44037]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.95:2525] with esmtp (Farcaster)
 id 5eb112c7-575d-4374-8e8e-118a6946dd10; Fri, 18 Oct 2024 01:23:15 +0000 (UTC)
X-Farcaster-Flow-ID: 5eb112c7-575d-4374-8e8e-118a6946dd10
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 01:23:12 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 01:23:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 02/11] ipv4: Factorise RTM_NEWADDR validation to inet_validate_rtm().
Date: Thu, 17 Oct 2024 18:22:16 -0700
Message-ID: <20241018012225.90409-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241018012225.90409-1-kuniyu@amazon.com>
References: <20241018012225.90409-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

rtm_to_ifaddr() validates some attributes, looks up a netdev,
allocates struct in_ifaddr, and validates IFA_CACHEINFO.

There is no reason to delay IFA_CACHEINFO validation.

We will push RTNL down to inet_rtm_newaddr(), and then we want
to complete rtnetlink validation before rtnl_net_lock().

Let's factorise the validation parts.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/devinet.c | 79 ++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 89b892eaeb95..64994ece27c0 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -831,35 +831,54 @@ static void set_ifa_lifetime(struct in_ifaddr *ifa, __u32 valid_lft,
 		WRITE_ONCE(ifa->ifa_cstamp, ifa->ifa_tstamp);
 }
 
-static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
-				       __u32 *pvalid_lft, __u32 *pprefered_lft,
-				       struct netlink_ext_ack *extack)
+static int inet_validate_rtm(struct nlmsghdr *nlh, struct nlattr **tb,
+			     struct netlink_ext_ack *extack,
+			     __u32 *valid_lft, __u32 *prefered_lft)
 {
-	struct nlattr *tb[IFA_MAX+1];
-	struct in_ifaddr *ifa;
-	struct ifaddrmsg *ifm;
-	struct net_device *dev;
-	struct in_device *in_dev;
+	struct ifaddrmsg *ifm = nlmsg_data(nlh);
 	int err;
 
 	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFA_MAX,
 				     ifa_ipv4_policy, extack);
 	if (err < 0)
-		goto errout;
-
-	ifm = nlmsg_data(nlh);
-	err = -EINVAL;
+		return err;
 
 	if (ifm->ifa_prefixlen > 32) {
 		NL_SET_ERR_MSG(extack, "ipv4: Invalid prefix length");
-		goto errout;
+		return -EINVAL;
 	}
 
 	if (!tb[IFA_LOCAL]) {
 		NL_SET_ERR_MSG(extack, "ipv4: Local address is not supplied");
-		goto errout;
+		return -EINVAL;
 	}
 
+	if (tb[IFA_CACHEINFO]) {
+		struct ifa_cacheinfo *ci;
+
+		ci = nla_data(tb[IFA_CACHEINFO]);
+		if (!ci->ifa_valid || ci->ifa_prefered > ci->ifa_valid) {
+			NL_SET_ERR_MSG(extack, "ipv4: address lifetime invalid");
+			return -EINVAL;
+		}
+
+		*valid_lft = ci->ifa_valid;
+		*prefered_lft = ci->ifa_prefered;
+	}
+
+	return 0;
+}
+
+static struct in_ifaddr *inet_rtm_to_ifa(struct net *net, struct nlmsghdr *nlh,
+					 struct nlattr **tb,
+					 struct netlink_ext_ack *extack)
+{
+	struct ifaddrmsg *ifm = nlmsg_data(nlh);
+	struct in_device *in_dev;
+	struct net_device *dev;
+	struct in_ifaddr *ifa;
+	int err;
+
 	dev = __dev_get_by_index(net, ifm->ifa_index);
 	err = -ENODEV;
 	if (!dev) {
@@ -908,23 +927,8 @@ static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
 	if (tb[IFA_PROTO])
 		ifa->ifa_proto = nla_get_u8(tb[IFA_PROTO]);
 
-	if (tb[IFA_CACHEINFO]) {
-		struct ifa_cacheinfo *ci;
-
-		ci = nla_data(tb[IFA_CACHEINFO]);
-		if (!ci->ifa_valid || ci->ifa_prefered > ci->ifa_valid) {
-			NL_SET_ERR_MSG(extack, "ipv4: address lifetime invalid");
-			err = -EINVAL;
-			goto errout_free;
-		}
-		*pvalid_lft = ci->ifa_valid;
-		*pprefered_lft = ci->ifa_prefered;
-	}
-
 	return ifa;
 
-errout_free:
-	inet_free_ifa(ifa);
 errout:
 	return ERR_PTR(err);
 }
@@ -949,15 +953,21 @@ static struct in_ifaddr *find_matching_ifa(struct in_ifaddr *ifa)
 static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 			    struct netlink_ext_ack *extack)
 {
+	__u32 prefered_lft = INFINITY_LIFE_TIME;
+	__u32 valid_lft = INFINITY_LIFE_TIME;
 	struct net *net = sock_net(skb->sk);
-	struct in_ifaddr *ifa;
 	struct in_ifaddr *ifa_existing;
-	__u32 valid_lft = INFINITY_LIFE_TIME;
-	__u32 prefered_lft = INFINITY_LIFE_TIME;
+	struct nlattr *tb[IFA_MAX + 1];
+	struct in_ifaddr *ifa;
+	int ret;
 
 	ASSERT_RTNL();
 
-	ifa = rtm_to_ifaddr(net, nlh, &valid_lft, &prefered_lft, extack);
+	ret = inet_validate_rtm(nlh, tb, extack, &valid_lft, &prefered_lft);
+	if (ret < 0)
+		return ret;
+
+	ifa = inet_rtm_to_ifa(net, nlh, tb, extack);
 	if (IS_ERR(ifa))
 		return PTR_ERR(ifa);
 
@@ -968,8 +978,7 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		 */
 		set_ifa_lifetime(ifa, valid_lft, prefered_lft);
 		if (ifa->ifa_flags & IFA_F_MCAUTOJOIN) {
-			int ret = ip_mc_autojoin_config(net, true, ifa);
-
+			ret = ip_mc_autojoin_config(net, true, ifa);
 			if (ret < 0) {
 				NL_SET_ERR_MSG(extack, "ipv4: Multicast auto join failed");
 				inet_free_ifa(ifa);
-- 
2.39.5 (Apple Git-154)


