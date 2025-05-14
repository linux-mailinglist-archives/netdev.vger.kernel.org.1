Return-Path: <netdev+bounces-190358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E5AB677F
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 313017B0442
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29937221F1B;
	Wed, 14 May 2025 09:27:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E03DDC1
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214848; cv=none; b=XIVNgrw0v4iNNjfcW7oXsI6SLaHZMbR5/u6uUPnvbSgUYc5nP+BrDEqeYV5TRz8b+6aOpsSSsIqBcSNEjqbgCGNoanKdXOt2Ckj0PloNf+J+Fy7kfhVTWeyKiPJb+r+1j+dIdKzj0VXvSw5NfsLuFzHGZELTubeGs2hylSviHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214848; c=relaxed/simple;
	bh=aTBDfCF4+YIWd+vFtGRqRDTmkGPFH33dAtesQYqY8CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecQgzoWeyiS0eOxYZ5tSZf7250ewKw1unMeCLvJNJjPDwJguLe38tyv8napZfVRxw9BVYPYehYNFBPo0lj6mtC4bSeP6QZA0RdpcINZe7RJXMV8TiFF3hEA6luQYCNufqUcGksZKdVJGsh1XnReqODLYbuM/Xo9RlnmkENIVBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz7t1747214763tba02a587
X-QQ-Originating-IP: /Bvx8dpW9tC5Ri1IXAla/dP4xDBm0LWsy0/zglJxQfE=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 May 2025 17:26:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3291365212908845692
EX-QQ-RecipientCnt: 12
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
	Zengbing Tu <tuzengbing@didiglobal.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next v4 2/4] net: bonding: add broadcast_neighbor netlink option
Date: Wed, 14 May 2025 17:25:32 +0800
Message-ID: <ABF23033C5EEBFAC+20250514092534.27472-3-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514092534.27472-1-tonghao@bamaicloud.com>
References: <20250514092534.27472-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M0FOvC2kgX4gptIKZVKxqKssm6K0MZSdthequVMx1a2tsz1SK9nlYQGn
	keV//3r6M1kW94GFlhaC+fSPcrkBYsQWQPw4DkM662UE9vrkMT0XH1FzcmMSrjhPL3Al3qy
	WCaMxROceb92+S8/vbguSN7ioLpUYlO/mptfjLkqMdqM7357ZCYQ4SqXKWHNnOLh0ZvPqiq
	XTeXIJvx/6LwM3ss3A4A9Iv3LRRWQsOLbNjgaM2BK98odidW7ya+AKATEDykJifCumXosEU
	xGQSFMToMbPyd+DpOeDOhEPgBxe9NN61VV58rBFXAKk90JpSMBd8IwoV23sKAe+pGf+MXrU
	L9BiOsJssJiyy3sPx6er2z+pyr69s/639vzPhgErXsprZcKpoidOuTrKN9dY+/MqQ1DVN8L
	CXUloUQTU5ad6XeMQf3kWvAK9HMnMNh/LYu77NjSyzNB9FTBEfTZDU71uAHjTqzT01zwz7Z
	xWKV45OX1Wg07At3OqYRjiNuc4GJireOzylt6LxVgA1Cy00WJBurJuRqeB7Q9qkN3+pKwmN
	RAELJ3Tq2AFF8wcIE4UZpII4/z11YoDtJ+Mn2no/NfZ+lCZlgzsKpCXwFtfBYkwOPffdGy/
	IE7inlvHRcxgqZhJvh7ks5nufWoflLt5Lt+BdOWR39mp5dqCWpOZBvxJS0qUA98KwwUnpXk
	tBLdbR3j5eMjJVayfKftq41vZFEcBbbdE7VqP+cC/oFOE8jO+l99TbAoc6fZlnaIN7VN0qy
	Dk5mOCi+ACRzTVkdeALIo5Qx7Dpd9qM/xAlWyw5bcH2CAecAOVYawo6RupkD/n0kEdOlYnm
	lMuzHTMshRw096YEn5JXQfCpIM6PbTozQ/aKWRzw/UmFjCUcnxbZDV6Yy3Q9x72FX1Qw8pk
	P0QUbPjLM6pFGBG3fBQek+kpTT3VpFkQ8OasQhH3BylebwnnLXLROwm6qP2kA0rmDmmLYL+
	MHs7MmID5Nt1zie+eqg6wykYSCO/Bvd0S6c7PSDQxWfreQVkV+gDeFbCGbUADq5N5bYUapK
	qPj1Gi0PsTkfJ4ovTj6gAhmJsZif4=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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


