Return-Path: <netdev+bounces-189438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DC7AB2130
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 06:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1524C4909
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 04:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091281ADC98;
	Sat, 10 May 2025 04:47:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED69C2ED
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746852475; cv=none; b=lvuYmflCROR0WjmM1NSnwTrSGgL4UpHQpf6gSc3RZbuzsmxrPgjX6/QNmD3Ocixf+rU0bTSFw+OkiAWGYgpSyZOZkrnwQUMb1Dl+F8MbZTQQ7zhVKffY608nNoyJxlVrtk7R+5BnweMcgdI+m2knU0XHi5BI3lpx9JPK2BLalpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746852475; c=relaxed/simple;
	bh=lPC9H8lVfR+LSsdVWQGqDRFZlJVUsdjGvwQzHN0H4hI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d2Tw+tMfNKXNymhBCqFiFnXasz0L4pe7HCvcjcIfDpLGDoXjhUlMAMhX62f8yJR64qPctaxLfTkSInBcltfltFkHQ94EsWRbuCt/rT9TTYMuBH6LqlR3mgSUCo1i8kQN9fX9D/ZbZOHNWDiawh79qncpcu7K/DiDM8FA+cPbW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz12t1746852327t265f59c2
X-QQ-Originating-IP: mlH4gltEseryWGZ634GgyMGUcWsgmcdv4mRT57kgfV8=
Received: from macbook-dev.xiaojukeji.com ( [111.201.145.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 10 May 2025 12:45:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3237815649446040878
EX-QQ-RecipientCnt: 10
From: tonghao@bamaicloud.com
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 2/4] net: bonding: add broadcast_neighbor netlink option
Date: Sat, 10 May 2025 12:45:02 +0800
Message-Id: <20250510044504.52618-3-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20250510044504.52618-1-tonghao@bamaicloud.com>
References: <20250510044504.52618-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N0Y11OQjfoyDNsAGSSlWBRYiaOKvRlOLjFc0/O2ixlJlVWkXvM9W26Jf
	Z5QGwUYhJKKm2xYud/xpdmysROkHTulRq3XRZ8FLRg/M6faGSHF7cF43QfSTR7gkRjq8S8z
	FoaWmIYbqwarTZDL4wy7luE5ojrLr8STvgngOOSDFCH1MgROSdWaWkl7YGstRmPrXXAfNiV
	leWYnO04pYlZUjZgs8cRNr8aahx8m4pwjeyvtiUF7zmjT2aStmNai/jzR36N4XEwDFykbkS
	WedKkajS9iGZ0A5CAAsSuJSEdXUO8nnjLytNHeK+jTp1kdgU6lVbUHb1PCcyQAKSkTcxPs0
	J6v0uweoC5UfcbJ/bTKcaxlf7ErHLYHm1PphGnOynP8gVDfksskrziKbVTEfmY9rhyJrT1r
	AyAxstPo4UHhmw0wVsavuF7K2AR7v1sclKmC5yOFsISOr9xwdAxSn8nGxRRvuv1EME+Fthj
	HAR6GRtUnTS4Lf+klkx/r3zYMzhbe4FnNM2eOizodpZ/E/+4JOUA+gWt0g76GThvtCUnuN1
	hrWB5aAl+6utewbh1Ao7wW2DErNlcSOcmPGviCN3YJm80cZ1ekqz6WJU/b7qhmM3GdChwDx
	Ez/Grk7skDs4k51yDd79w0jGWrw+fBbOADZTNDkjjX3HFSIMeugLFnOkCCKAZsVNIW1EFfy
	4mkd70lDcIaDnOpzOXoMvCvFRHKQBMbdH7e0IXlw/yuvWGDvTBuasHp9gdNYbadaEVEtdax
	2sGaaz6+vpxb4Vg2ivyC54MP1QID4lAlSJXE7m2+7eEjLayvotYhJAfgorxraetZ/hBb/gL
	HPJkkszQUfyWdvdIwZ3aU19PV/u6KF+mVbsieGApZhLEDUEjcu/aozv8DLcdeQh9yur9cny
	4XIO1S2Oow5J6nQVgsoVGvS3WkGwvyAFnU3M7BAyWrYrflL1wSxJVfp+nvhheDROHs04zes
	IdZEK81vmNKMMfmTFvjI5SGOp0FxqzFBt4IILa8v1FdN2mO6STWvmHxQhviq3QNyoaJm/ae
	7cLV4Shw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

From: Tonghao Zhang <tonghao@bamaicloud.com>

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


