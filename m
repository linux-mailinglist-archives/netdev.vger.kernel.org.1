Return-Path: <netdev+bounces-201959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16092AEB940
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DD2B7B5A7A
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994242D9EF2;
	Fri, 27 Jun 2025 13:51:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AD2DBF4E
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751032286; cv=none; b=Jn+K3AvSJoDVj1l6L84Shi8h0sUWWtZ1ps18rp3XxL0KqT0oRh64F8XPRZsb4IKSVHA84BK6KUgqVP3D/Qh3hexneeCinuyXdEQB5qWJUsw/Z5e7CLs+juTELvfO8KplAxzJDdrEovE9/iLm40btAtPNoN01yoP8tN5ZgkAyOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751032286; c=relaxed/simple;
	bh=CEs9qkQqYwGySO1i/q5+Hd7UVG7/mdroCyHVjnsF1zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZg57q+NztXs4uEEZHkSRQrJZMB0VUCCD4hXJeZ8M8y4+XxwT2oehOlm7putU06+Ht4KTRz8YANJw2Vii4Qr9qFdHw6Z9EqkjkBWNuwhMcApnUmXFLK/a+gfAlz2Sc050bM9sGHMbX0FnG0epPe/6jQ54vJdDZhsJav9UHEKlWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz10t1751032256t12e190f2
X-QQ-Originating-IP: Oxt+y6w9Z/6GSsHwamnwyyACQvDMJgrhfzGcTfLuePo=
Received: from localhost.localdomain ( [111.202.70.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Jun 2025 21:50:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11602713529510233783
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
Subject: [net-next v8 2/3] net: bonding: add broadcast_neighbor netlink option
Date: Fri, 27 Jun 2025 21:49:29 +0800
Message-Id: <76b90700ba5b98027dfb51a2f3c5cfea0440a21b.1751031306.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1751031306.git.tonghao@bamaicloud.com>
References: <cover.1751031306.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nfk/EyOxfLNriaO33EAcRy0D4pc88qPW0csoxnVgRiodJTKLTUxmVPBf
	IsBz0wtzhXWey9OB5CsjVNGrHFHA6ruyzwxWk6KnElX3/b5+VPlMruK+Df7fYujhrooggD2
	fiTlTJ+X/41v5UngwP6txCcNz0LGV19kLpBPF06qjuRSzE68/q0rvUos3X2NDZymirUFHsp
	nu+4IJMFZZS3mhdSojgn1Ywv0Wjj7PW8DfgHM59YM5q0Yi29Y8bVNmyLycd9d/TSZLRKgnk
	deQvcgSCCeBMXmVaFSkDp1w4lG3XAPsBC8tMpaD1FGHedPQwW8NOPXbXVbfZpQ0rdBIXXtK
	J+6FI8bu3Du4bRcKSapzwYH5+2og9W2+wgX8XQrbT2mcR/56yTLq3y9srNbK1EIe3Rv0ikD
	U5l3DLBuJXZZXtMFlzSzZpup+0a4zA1VvWP72iFTb6hRdM3592gQBOPvHJgNTMVu5G79WPc
	aOOVmigItEw/Jf3PSiRbGWemy6qvFCp2xeW41k2Ksz7wsJ1qedWib6qkpctsi4zYuF5y3+M
	wb5KAn6rViDu17mHnLfJvT7xhcy0dzN52DprebUbgEMlozl5Gfn/DFVx546HgV99z3HRdkh
	XB5ZQ+Y/xkQjiFJBICQYDjQRKP0jX7uMCFMafN/DtGrWAzXkXl28ECy+zvoJqhwk3ac2b0C
	q2rqZ7u+mjulBSufqMUN2Ps5EGb2xy53QsBt2WN4saK/bKOef4mVb3zxYQyebFu9chHcFid
	PF+iGUpeTY74ClZy1lcMRl/Zv3vGUmq8sXiKilajFmm/EUHRvtAOJzL8JarGlNX0BGYMImY
	Z4bqtDSTSVy4421wsdTor7LBQcqYlCxOxxH7mXEXtTdi799gwRQCqAokwRLIhwq24P4c6yw
	u9VF9tM5uApWSXHpODGVAzsWNqHgmwfTCY8MyTfzL1f8OQYAsgOjrO5R2x3eZ2YWRcICjTk
	PhP8mEPvM+XJHh2Xp0JIPJjl/SHI2zZmmQRa4kG8gAczwxL7CXknUM6Bt57g+2TXaC2Rs9c
	ZHX6u8P9M1A8XX804Y
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
index 873c285996fe..784ace3a519c 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1535,6 +1535,7 @@ enum {
 	IFLA_BOND_MISSED_MAX,
 	IFLA_BOND_NS_IP6_TARGET,
 	IFLA_BOND_COUPLED_CONTROL,
+	IFLA_BOND_BROADCAST_NEIGH,
 	__IFLA_BOND_MAX,
 };
 
-- 
2.34.1


