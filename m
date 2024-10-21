Return-Path: <netdev+bounces-137606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46A69A7269
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D52281E05
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E880F1EF941;
	Mon, 21 Oct 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Uhvns5ZR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578F1EF0AA
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535631; cv=none; b=QxwFhsWCaydghh7nDpziqJz3M0g3B+jGTZ1tedspS+vJyouPowXyVB5mNkjPCx8Zglkgi8C9Exyxq2Mh3CywolLePl7EKI5om0MRBIAXwWpSg1igHydbegmXgLQepHmr9PEK1xBCiRc2D2nY75C9fyQHUEfG+KwGrTyq6dtyNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535631; c=relaxed/simple;
	bh=oID12Euvd7P0aoyXlP9fxbQ8f7K6Z1fnpbfowBZFzYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXQgLlk5N+faZml57AMBhdy99kA591nuPkAL1NW2Adjzo+mpLibOv0zkHkPRjeiUWbrUKYhH0RDdaHHkDUr7mJsyKBPPadUwD6nSEucdgRC8zsd9Vl31IkStWQbTPPog1+4ZxgFdL7TXkPysS8HV3aIuj0fAz8xlcAz+QMjgJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Uhvns5ZR; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729535630; x=1761071630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5WvBj6YwDokhO0W+f3gUdP8AqIED+tcjbwFNMSpb+Q0=;
  b=Uhvns5ZRlHZcOjQg0lMtb5Io8OgOZr8ex+Vw7l1SkhraHnAdlnZDUhjG
   JS7OQ1bEJaSwWCL2A+TwxIFdP8U6zDxDSKa31AnOO9vqfSUcy5fGWABSe
   B8y0k3gyV2Ngbs+lr+XSCxLemMxZowjs7UybQKDPZDrwGP2C4F6IBSfXe
   I=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="433403527"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:33:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:5135]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.192:2525] with esmtp (Farcaster)
 id bf46d91b-2860-416b-9155-08a4ee098037; Mon, 21 Oct 2024 18:33:44 +0000 (UTC)
X-Farcaster-Flow-ID: bf46d91b-2860-416b-9155-08a4ee098037
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 18:33:42 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 18:33:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 03/12] ipv4: Factorise RTM_NEWADDR validation to inet_validate_rtm().
Date: Mon, 21 Oct 2024 11:32:30 -0700
Message-ID: <20241021183239.79741-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241021183239.79741-1-kuniyu@amazon.com>
References: <20241021183239.79741-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

rtm_to_ifaddr() validates some attributes, looks up a netdev,
allocates struct in_ifaddr, and validates IFA_CACHEINFO.

There is no reason to delay IFA_CACHEINFO validation.

We will push RTNL down to inet_rtm_newaddr(), and then we want
to complete rtnetlink validation before rtnl_net_lock().

Let's factorise the validation parts.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 79 ++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index ec29ead83e74..24af01fcb414 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -846,35 +846,54 @@ static void set_ifa_lifetime(struct in_ifaddr *ifa, __u32 valid_lft,
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
@@ -923,23 +942,8 @@ static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
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
@@ -964,15 +968,21 @@ static struct in_ifaddr *find_matching_ifa(struct in_ifaddr *ifa)
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
 
@@ -983,8 +993,7 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
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


