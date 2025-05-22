Return-Path: <netdev+bounces-192610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0176CAC07EA
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E6F18855E2
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D98D288C01;
	Thu, 22 May 2025 08:56:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C5287510
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904169; cv=none; b=ZbunC4kgfJDSTmAkGWQVOKVeTaYHZwsdEWw3dJd0x5cWXWznYc3YKG2jjLE/uOT912xVl9XP8GEjtBgFZSaZJmy//K/xxODU12c2M1moXCwRm1amB7OpjPwCVE0yku/watdw+wcUhFJGwEUb5GyTahvCQVyP2HxKXuOlQXzPXdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904169; c=relaxed/simple;
	bh=b1rgYTKhkyPRyHl7/4Gi5QLolb2gubZFGI5smUerzb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YL/sahoPlSCdaKeferH0XeWOpbZi+CfSaKW4xXTuBivMrNKmtygFp4PJ+k0vduK4WcgcnZ36jecVgykY854RilnU9/b8StORN1v6J1eHwEKQcqTk+DMbZcSGtlM6/ynLbdL1Fazyi/y6kSPXAb7R66i+QeL4plVOJFAoZ1kBaSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz17t1747904142teab480ce
X-QQ-Originating-IP: eJc8LWCI3mbK8N8SN5dDCKsBRm8qTD5VlCljKCC0M8c=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 22 May 2025 16:55:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3557322142986947654
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
Subject: [PATCH RESEND net-next v5 2/4] net: bonding: add broadcast_neighbor netlink option
Date: Thu, 22 May 2025 16:55:14 +0800
Message-Id: <20250522085516.16355-3-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250522085516.16355-1-tonghao@bamaicloud.com>
References: <20250522085516.16355-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: ML8hOghqQD+0wn148PWs0NJMqaZf20ABpU2KWInBs7toOzYNUwnskudx
	0F240403IVlCdp6Q9ekvmynMZ4gqP21dZQaBJ2J97GbXWFGt35IUfzJJh1NqbBdKP2EwYTd
	nsFs2I1a9OF757b+KjxkZtReK/vvkQ1mMsZSzCee5lGjyiCnjHfAz1gNfDoncVz+0YI9+/x
	S1DUGTUKMq1uXsZWgn21ZtjxcknANvAf3uvLE4o2EXB65x/Ff5RwApuExM43SqHVpdKW14L
	C8GnNJlIU7EBqKZPU+EFbHPg2k6NJ4CJk7YhyOx4muDx1CICL38fBkb+xLDwiJmy60riCVY
	DLBMmXdemdjqm5haqKzF8gWyW/RMJPOvx9n8iDj0A+GgIPF74/w00uTF54nFGDhOmaM3MLq
	gR4tiSmT8TvTKcVFZY6j/vvI1jkbrfHPVeWGMlQbf7pNNYzXupVwMseG5dXgh1nBPYOZ/PQ
	LGMpeJh5TdOHyTa5bKs5nQOw6Gs+qRT86cilZMm42KjMeBVTR2Nr8HsWl+AqOKoL4OTc5eP
	GqWWsjQkuvgT52cdZTk2yZSdahDAhI4rt4LpsoQ6JZPOE/wg6qVd3ZMu0xQvB5TaEQjrdgs
	EB6yBwnhRTcbUc+nEOt6OwQPRHWi0SepPxIbz8TUMpTatK7RQoF6uoNmu6VjBjL7E+Xmw3Z
	hwlaxKdKvwTZHub/ezGWkC7CCk5I2BW9YsKDFqVXva9A44r7X9d/mDCJbJ8GhI80hUG03xR
	J4Pe9cyLJdg7/tQLTM9/F4U2Kftqto5JCqSNZrY7TSqBAlsw3UtiCPSYbMSNJYrpv/vxlRk
	bBKBPMfzP2m4Fo93kD9t3naKfhYF7oxEAttOt8PLFaZw0h8ZfCSc5CUlPkDIgGzL1kkeiLY
	dmTw3bK7gqI1asbe5mp9hMjWTdhvbaG0AVjQKfEtXaMP8RpvgR1w5ezA3ailNXatRrbVAxc
	T/FVmzMD0/4vQiUgJw+WpANalantZnLsKJaEnYmyNMH5wSzpll4uRQ/S8DvRe84iDcaw2JO
	5opBEMSqr20TvW6I+r
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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


