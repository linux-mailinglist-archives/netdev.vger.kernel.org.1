Return-Path: <netdev+bounces-195925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ECBAD2C36
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 05:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E273AEEA7
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 03:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA0F20A5EC;
	Tue, 10 Jun 2025 03:46:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3D31E521B
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 03:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749527191; cv=none; b=eFyZRxVXAqXPRZi5+El2enNF+fbXHvqY2tj3FEHX7MqDZDCc0b50p8kAmGEXUHq/9a9nHrBPQ7f1BXPZ5EiwFoxvfZB1rIpLBKGZTfszpFIm63gDsActsbz+N4SS0RUnZAWAiXegVLX6yNyjrg1CYAU3McZMNVFLZjjg6k3xjvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749527191; c=relaxed/simple;
	bh=b1rgYTKhkyPRyHl7/4Gi5QLolb2gubZFGI5smUerzb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=axRgkc3BxY8/jRpr60uio2SFbamP68aT4RUaRYUjzlOJIksRd1+8ptOj0pT1x2/Ghl5Fn10aQem6nxGK1pxVX8BUv3iZHxds0JUm+LqBXmsBCCOHrdG0vRzUcPOMofGvIgaBeY8VH7oJVh9RvmDNfzqet2DgdqYgOi1TF7mVeU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz18t1749527160t9f8b1ad8
X-QQ-Originating-IP: 4eU/NePvb737xWgkhwkiSBGvtsqQT9AHXqdb9OUTpEc=
Received: from localhost.localdomain ( [111.202.70.101])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Jun 2025 11:45:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16841047995638308170
EX-QQ-RecipientCnt: 15
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: [net-next v6 2/4] net: bonding: add broadcast_neighbor netlink option
Date: Tue, 10 Jun 2025 11:44:43 +0800
Message-Id: <c12fa14e016b6fa9f1a8b49ecad212c235301ac8.1749525581.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1749525581.git.tonghao@bamaicloud.com>
References: <cover.1749525581.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OJVhEmJj02aqtxAeBIXA59oLj+xuZO8AfgMIdk4IYI5HYFmywD5GZsrq
	yT79cBgNuacjRrxWGH+eZ4UmRZ7UM6J+apdhqmUi1HL2dJqAnl5sKfDMH3LQz/y57FRSdrO
	+eUvj+cB2Qr4sph59Sdnl0xxt/SiPdylhBMrZCDUlQMl0mibuHWmUb6Pv/v4P0FEcY2tqZJ
	8PN4AYYS4VByUEaVZ8cHok8AHEi7PTVwAaa0VqtOuqXcSjObawi71GDgUKbJn4Rghi6JFhc
	/LD/yqMP8nSzmcDjdDbrXgLs8YOKZsqvBXQShmmQuRw6wFORxedBsnpYq54JeAUR5Y+iuIe
	C73zXuSSPo3BdD+kuGBMMRBp2QAYYpmaISrRJ3w0m1YjnmGuDtnx+AgtCPRKhwj0AY0yp36
	gxIyDdGsSCVg6u90l+8w8ZgBwoNybFQ0kIf9n5mFQ4pbKME2UwAqr+2EJzOh6n3e0MXiLfS
	6cG+lTR1Bh6d0zgZfnrF2VsOAME37UJl7u815ThJD1iXW5bH+8xrcxtyEAYTTyX0WRyBweP
	MUNgB9KRsLVaZ7UGeE/c1VuroOBMvNjB7njpPHPVHgeTI9yrIDnJOlnFu/n0eqo7frMnKWx
	PiAHyZbLeJuSlgG7hw0QKJ5LASVjfwt1VceW+fvOlkSIH06kMQwAXVr4fuAkt5DSr5/y/uM
	sYe777bpPgKwM1zIbu7BGUldsWCqjMwJdvxVw7mU6tnDwAx4baTZS+K2+S29T3zanm4cuYR
	Cp6zznR6gVa9SsfpyD2E0+HwKwYiNMCXzNw90uEoBxsL63UF7H88KtQdGdZLF8HevQ2FXyR
	eQGGWiMaz86Jv9e7xRnT+i72yTAsVVMLlhMPO9U0sWl+fWtQ29CSMpzAjVECnoGzfjrhTCJ
	y9bWzAZl1KgFvtJKzW7sb7GlNwH5DpmA8GKwogROmLRAp7BT9hJze10NxiX+8xP4hVNn3qY
	kFMAdxyY6Wsg+bWAQqd7ytzYfulg9YhkLBQ6jMWJ/HPje0ObPtJeTNDVzpX0kAIGXsWNov6
	exuUY1QyYS5aOkkNWp2h8W0kGJDyF9OZGh9OujSA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

User can config or display the bonding broadcast_neighbor option via
iproute2/netlink.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/bonding/bond_netlink.c | 16 ++++++++++++++++
 include/uapi/linux/if_link.h       |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index ac5e402c34bc..57fff2421f1b 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -124,6 +124,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 	[IFLA_BOND_MISSED_MAX]		= { .type = NLA_U8 },
 	[IFLA_BOND_NS_IP6_TARGET]	= { .type = NLA_NESTED },
 	[IFLA_BOND_COUPLED_CONTROL]	= { .type = NLA_U8 },
+	[IFLA_BOND_BROADCAST_NEIGH]	= { .type = NLA_U8 },
 };
 
 static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1] = {
@@ -561,6 +562,16 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 			return err;
 	}
 
+	if (data[IFLA_BOND_BROADCAST_NEIGH]) {
+		int broadcast_neigh = nla_get_u8(data[IFLA_BOND_BROADCAST_NEIGH]);
+
+		bond_opt_initval(&newval, broadcast_neigh);
+		err = __bond_opt_set(bond, BOND_OPT_BROADCAST_NEIGH, &newval,
+				     data[IFLA_BOND_BROADCAST_NEIGH], extack);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -630,6 +641,7 @@ static size_t bond_get_size(const struct net_device *bond_dev)
 		nla_total_size(sizeof(struct nlattr)) +
 		nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_NS_TARGETS +
 		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_COUPLED_CONTROL */
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_BROADCAST_NEIGH */
 		0;
 }
 
@@ -793,6 +805,10 @@ static int bond_fill_info(struct sk_buff *skb,
 		       bond->params.coupled_control))
 		goto nla_put_failure;
 
+	if (nla_put_u8(skb, IFLA_BOND_BROADCAST_NEIGH,
+		       bond->params.broadcast_neighbor))
+		goto nla_put_failure;
+
 	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
 		struct ad_info info;
 
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 3ad2d5d98034..53b2f6ebda8b 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1534,6 +1534,7 @@ enum {
 	IFLA_BOND_MISSED_MAX,
 	IFLA_BOND_NS_IP6_TARGET,
 	IFLA_BOND_COUPLED_CONTROL,
+	IFLA_BOND_BROADCAST_NEIGH,
 	__IFLA_BOND_MAX,
 };
 
-- 
2.34.1


