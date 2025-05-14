Return-Path: <netdev+bounces-190326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492CDAB63E5
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8067A3BE87C
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C041F0E2E;
	Wed, 14 May 2025 07:15:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1780E20A5E1
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206910; cv=none; b=FDEl9C+t2/H9rDYHbrMwVKN5ijC4wMZtSQG8yPzV6wTg/PYwNOHxh/5RTq/UK7jkxXr/6ZchgQKgXSOfN6CBq+6SkophsV9vrUAChDmkPhnjegt1cgtw55ewLEFQck4r3r11AxwmRSgEFaW8a6KR0+kOATMCHCnRyJ4E9z4jwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206910; c=relaxed/simple;
	bh=aTBDfCF4+YIWd+vFtGRqRDTmkGPFH33dAtesQYqY8CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6lkOH/p+2RYo6cuvuT86PEdCx2QSEpFCOBtvWcVjXNSeXHCUgR3/Vuj/2F8pNnKWYyrzQ9MX9gK67a9wd7Wl3YTQ8CY1BIr64e01nfdGT04r266g7cBpUDWgcRlm4PSX28Z54u1tvqJMjkdO3bPbPQ6MLHn9r4fstxBNAkp/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz11t1747206842t7fd5ac62
X-QQ-Originating-IP: zL7P6FrUH4wfGhSsHOZI0nE7B5LkL4YRqsW6OWtxw4M=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 May 2025 15:13:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11991264364826877124
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
Subject: [PATCH net-next v3 2/4] net: bonding: add broadcast_neighbor netlink option
Date: Wed, 14 May 2025 15:13:37 +0800
Message-ID: <6A6785B87CD99B06+20250514071339.40803-3-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514071339.40803-1-tonghao@bamaicloud.com>
References: <20250514071339.40803-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Odky5wNUcHo/lzAd/Dbco+JMp4ShlAA09CMII+De/y4OVhBms5gUxSUE
	JF+MYNUMLWMfqLd940ICepOAxBjfWNtn6I3PdK56YLBOPLwHJRjOhBT3nvodXGHWNocz84n
	+sopqn3E1XSuiVQIiayvyiC/jY8qg+SjLET/Ba9o9HWDYSYCZHrTm6G6OE6ENioz2qK1gBh
	A3P5/Jv05Kadl5kFOPxx5ZhmwhlbCRFIA0rTlC2g4jKru3iNMswfvm77cLHlLJqMM/Qayms
	dyxOmfnmiuIEH60d11VsQQtWpJW5zJ1RXBbjaFp+lGDHh8dV0pZo/Wb4mGlG+zNafQR6Vpl
	aWhLf2CJBoDyQvDgG8qSyTpm00z19NolbL1HRifucPNikaNqSQyksj8tWtEK8vC5pyxa8jL
	SzyKaXQlqayt5YvANWKgHQwUZhBx6RMknYNvKhYIt1X056i/UfASg5dr59fardTQRf29UIQ
	sFuMd1M6N8xnQfkA/NFvXPjTbDYK/qGmO/ZAEfprqbOXtqmLuDBN+IZjo4P4mPBa5dTUtWB
	cOHxE3g8khYE8VfoQqUc+01Ijsz5Z5ivYb0jD1wOKsnPcqvwx0owNhsrjdq543zXdw4YA7+
	E1sha0gzJHq0II+Din2Fp/riXtZeFunT8guA5UDNoDANTdc9RSlIUy9bDXRcA6pYXJB3ul3
	cii0WHQLEbRp0kS/r77FsZdNaK/9JpBOcjJqfaCevGprUDQaja+hMR5V3vcqHZlbzXlFD4e
	2xL7UTHYx8wavRaUZIYkmlgMkoqEw2IqAph8z1kIx2127zu6EHbWL+tCbOKxby0NJIg8Y+E
	Ma3HqnnqjbglC9Wt7ItCUoeg7QiWFsqZOojthG6Ss6LBD4jJQWpMEo0a7zDDPO2WN+Bvlo0
	WUCCie7kFggy5TPo7DzMNf8Z5CsllbxUIE3RWKLq/HHVkicRasLb4/QzyNdbZhjiHEzWZSx
	3mCjuY/1ybvT46plLhiRanwxsfLvJZGVKVYnwA/TgALeWS60ZubGmo9KI
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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


