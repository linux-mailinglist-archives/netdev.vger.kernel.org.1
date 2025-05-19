Return-Path: <netdev+bounces-191435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6228AABB7C7
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3C23B3B2B
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC9C266F04;
	Mon, 19 May 2025 08:44:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59042267B9F
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644291; cv=none; b=ii8LoX/7r1jq2X38fCMkvgfcnJFSvz6WZT8ORNLe8COXd2D5RDHgKOIu9ENf5hH9QJ0QAWOoPjYTD2gguFAzLCz6S2qdPf2q1sQ9sxsBFtIegfP21MVaC9fu16phjmSI1VIVzeY+mEUhoJnDr46S+/RLm1pKB0C5EQGVaSDOzxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644291; c=relaxed/simple;
	bh=aTBDfCF4+YIWd+vFtGRqRDTmkGPFH33dAtesQYqY8CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xm3wSGR1Q8m6dC+0opeAzfY/6xSpiAabVX8GLse7VPeFlGWV9rivOQVpO2vzEosoo6Fn+fa6gNg+AuIYuPJzr1UBinl7GvHi8JVHaBhEi/ezrxGRGDCXqHjWn40vgmhb02963Lk44soLdmPjcfUYKI5WkIjmPIi/ufTYJK3WyDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz15t1747644216tc75e2035
X-QQ-Originating-IP: lV01w/YtSGbr+wPhHgVztGjXhx25Y3ydN5+hOrSfwM0=
Received: from localhost.localdomain ( [111.202.70.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 May 2025 16:43:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14630557773924427046
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
Subject: [PATCH net-next v5 2/4] net: bonding: add broadcast_neighbor netlink option
Date: Mon, 19 May 2025 16:43:13 +0800
Message-ID: <29A5478BCEC13ABF+20250519084315.57693-3-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519084315.57693-1-tonghao@bamaicloud.com>
References: <20250519084315.57693-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: ONv4FG6+I+02FFwm/z2tn3zNGqq+6b2NnEOFsE8df09UQ6kyUrd0u6wj
	XuGChCCJb32fPEetr+TMe3miJup4n5EePTZOySGO3tivSHchizgabZvuwIkEK8rJrgo6k/l
	5hKP1czWg+Pot58oVHfts8RlkXHi1cowl4YDE6AeMoFfzKu6F5SZpETzZqpiETmfJtIDwN4
	7zesCNtvZTB6HV78pYz5kbJTWSZteTXzsUx4NqMlcQXSDoNLf3VRjjgfXzWf82e/XWnDeeM
	+luE7RIZOBHNObb45N71i4GuoxFAHrveWox+jmCAAcAQVDkjbGEquTPrpqn+AdX7gM1V1WQ
	/vAoclV+jo8IXIpk+CFV7pDc8wvMam1j4vi9DreWvUaqKJpz0l/zcouJdNbpGdivmBsnK0u
	ZlEtDzTciRp7noPYLNhp02pn2q4brtqzHT+KdgvEJVr6oDr/PomWAuKLNfITyu/2LXm324w
	LNi0tBfvhVTFTkC/PA5zPo5ZN2EV8Y9qXJRaH8I2Ztnu207rSX0ytvQn9IUPGk5+Bsstxu/
	tfArbg3sdh/MLQ5TM0aBnBuihmB4POOA+ypXY3tm2tvVYMkPbqGJDBxsCiehm2h2GggVgCR
	S7tr37PSvlWecE03PZtnABcW+hIWMBhr0hAdLzbEENow+8DXhsUJqBUvOk4GnygES0JavqT
	KdMX3GFtVtbayOWzeCH552+NII5BjIulfEbjBzI/ijK8gCyk+g7HsLhdskVXB9rN5ihQZSM
	x9BHuqYo5j8H/q/clOdHM7VD2lzQ78B7kSiCKAAO9WCx2AxQ87HlALnqRXVGSSiQTjNOP71
	hnYSVknBrfw35pjEldNOBmORVM5Nndn0asByuCffgaFCg09ED2TPb/tuawE+YoOQo6q24im
	F83KbkEoA/sVLgLq9fMWUgO+2V8/EI2+Rsanb4qQYaKhLrAw18vONNoLhM6exoi26aYCOUn
	avHD7mQ/n6nbKxya8IrzHpJfqHVMLS6b3w9WAW8yB7NeVKx58OKw7WsLZE8Yd31RDPDY=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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


