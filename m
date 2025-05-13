Return-Path: <netdev+bounces-190029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B87BFAB5044
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57ECC1B41345
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13EA207DFD;
	Tue, 13 May 2025 09:49:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331A23C4E3
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129757; cv=none; b=c/JyyL9VfClHbVu1F1406YJkeKLSoO65wZRvdbrZuSH1GHIaFJ/BCqvfIaBOGaLLSAX1Xx0dFARyUDfhINGHHgLVf4cYP2kg52+/D3TUWGqs1rDve9MNgMPn9sFRJW5mMotzcYFfTGqoHS5HmhBFE8rXCTvMW9VoIloZHsujVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129757; c=relaxed/simple;
	bh=ZKjwE0/w89Noepc6THLdErEU7vHxUq2+NyWOrQMW8LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9HjfQOj87cTgqrkOeQcg3ZZ1z7geZriC5qzXEv7K/8MzyH5KPXNL4hPXB4UrM8lyT7FHs+lXFqY4ot3PrHH1rzNBNOn8CZ0bK8blsTHt4151MFNTPD/fV2Pclu1s4/9+Yxoen56UfYGWITanhVHlB8S6LFhXVGdW9fTRAqa+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz4t1747129685tb66b25bc
X-QQ-Originating-IP: MDZV/2HWi/SItN/voahY6y5AQTBIFkcgC7isURyQ8kc=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 May 2025 17:48:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8387637803524236603
EX-QQ-RecipientCnt: 11
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
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: [PATCH net-next v2 2/4] net: bonding: add broadcast_neighbor netlink option
Date: Tue, 13 May 2025 17:47:48 +0800
Message-ID: <2B0F476B6A0D5505+20250513094750.23387-3-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513094750.23387-1-tonghao@bamaicloud.com>
References: <20250513094750.23387-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NWT6b+CD3I3QlraMU+9uE3onYrHwDqyoUB0/YEuR8lw1EBRBNfHsBRM1
	LRVtzebV47chBXIHHy9ogSy9QS30PvaRY9MJY//JxI3n4AvuvzW1s65H4qdm8mqpqNKDVXl
	vR2EvCMus0ccXXkoxd+Ixex9bJKrWjItW9ceAbWv9Jfb3Xz/+bij3PwQHmA3m6sOkFQf5Z1
	pXWH1u33mdpQZRiOWNZnMIuyhbcKFHFOAPEdxSxuBRaLvI7vIvU7uNWsL1XaTtz8duVt4mv
	PLtuXh7Qo/mE6azayH8x3HGjJUwxiX+sLagOOtPwnSHYC8d9gyTtP9+m49YVaAJ68S3/U1C
	Pn45c+bsWCGSvnK0U+Y3hkPh4jcCPla4/nuzs3Um2KtpRUhEmDC/iabAV/72HCoVId5M+lC
	2RowXvc+M6etJZdr65CkhJJm5r0XEyPUSAZR5R7tOLfGP/o6Cc0DLJZX0HD7SmuiYrgmMo4
	GfZCreBN8abbyMHP4OENqAHQXHFHhxLx1HaYDUlZTqQPELYZCJTQMubE/JcezLW6wxsxJyG
	2vmjSAoXQ1qp9BLlEO3txquHXO5jUNdcwTkpGhZqJp9t/EpGsDBPLPI1PECaFJV4jjBdFBU
	p65RHyaXzcTrC/dzR8etncDFk14L5ZhjJwE6/PVf5PQCd126RHAncVW5+HSj++ijpx2KXn5
	NzfNjXCzvG4kOgEb9wFxTZD9aRYn4zKuGIXp/ZhmsSLgprVkbrk/no4dK80NG6+PVbwdwx5
	XOZMhmyJXuCRhj8ha69Asa3ABbqxbi+2csg/wrCPDVSOaMCEwcMZ6yoBMj3drd17EwG3YQF
	ZjBsDWwZF3tE13iznUwC+ygmseEDM3EFRXzoyXZV/pe4RLBDnF9EIgNleWI1Q8Z/j+XggSM
	wYh8Qy6PzCiLjCfEe6+4qDN63dU8AaXNqLlKV0/Di6dk3acfD0hpUlb16GKpmv4e+NgVGS+
	QtRW+EId7h1CVy8AbygOBTvILRMOVVD0CHKp1kvcpnWqsJnFZ6EmDCjlA
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


