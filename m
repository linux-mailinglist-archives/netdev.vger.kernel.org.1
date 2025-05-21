Return-Path: <netdev+bounces-192174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D755ABEC61
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBE64E2D86
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557C623C8DB;
	Wed, 21 May 2025 06:46:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E4F23C4F1
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809968; cv=none; b=JMo57ra9rhHsGMAjFF1InR8/RM18hHEMo8amBFDlMDYXGDoZ99x5IMUfrm5RTnxRUyKgyUZ74qbDQnlB0fcTPhzq26hBjhdD3XvQgPoAKVe3lnoBPHlCzTh9WgKybW7y/izVUDmO09+WdW2j/nHgaQy6EmHdkRQrZufq2B4qo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809968; c=relaxed/simple;
	bh=SHgM35ehuiKgprp0tc4SnfjBQuIM0F/DXp4gG+NqPs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZ+TeOduJfGBEP1wV90n9VjXGYos6wc4Cj8KZzlWAaRG6wSTI5tDyf2KePSVkNpuiZ7bSNpliP059ycRKPR6Gd3N7ykoTYASgX40FdO6VdJRKzQgqECQPokTAmLIJEJY4yyEIC82rH8uYW9qlCP1Zfr4iqvDLfchgo/bEn1pfJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1747809877tfb5bcf01
X-QQ-Originating-IP: z/+H3gVaJLybbBey0e9pB6DoAL/mzNziv7iicH05Cfo=
Received: from w-MS-7E16.trustnetic.com ( [125.120.71.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 May 2025 14:44:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18388620783474407481
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 6/9] net: txgbe: Correct the currect link settings
Date: Wed, 21 May 2025 14:43:59 +0800
Message-ID: <C94BF867617C544D+20250521064402.22348-7-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250521064402.22348-1-jiawenwu@trustnetic.com>
References: <20250521064402.22348-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N0fHFfxtkpsjwXeoH3AoSFoj+cA+n+cIwXzZObmWraGrQT/bhZ1ouVPF
	Oo5SEdSWGEXprSizQf/Ru24sALXYNbShBG2XXrJ/3KccdirgRd+4uyeYEnM/EACdDSRyf74
	ApyRYbyJzX8+QU8/JdbmTjB8TqEOzYk2xdIH9Laxtpdn9JwoBg4akRVlRcNO/SRDp0jE8S2
	2iVkPvEFDvGNMrVND7GgoFztUrGropU8ATWbvEAEtu9ZlHZu24fH3Lg/uGRUdJzOyxcATXa
	okJM84lbBSrl3/2dAJFbDPpBjO2ngRTpcAVLRuFaAIlNCF6NgmMHvA7MTigu+0r/QgDIQ39
	7QBbVSlDGgEXRbVY3CgQgsjOoBSx71etaLKGqZRh8ouGNHrtAIun652a7NWb9ZpStZIZDGr
	Wf0M8nX+XakMSio7bNH3+oMq2kHIGgpu4z1V1XT463Y3BsvS0RVa/KUkVvv6i2e5Zda6ddL
	4YFS9DjJmTKAXf4/akMSNQNOEQWaQBdLATIuJAtxO01/YH7kzEVR/vN3YnaEbgPm4m3W73W
	kgJcXAGN/Z4rlIGGgt5wdHftJyT8okAkN+5qHaw7euvoodpgiMzqiuRYy1IIWvkwzhxxUeS
	rnWi8IWBVdXL8orHGULSVvxOnw3hgvDQhNdsbRiNWQS+utHdmw1/z3qdNR2DEHuQE8h+EnA
	BdlL+LFLjT4CV6NyUd5CxaqRUUN5oWA6nptYFR4agh/cyFzlopOtFXEMgDbFDATZPFN2qPg
	T/fCOfJB988DtXBvbjgVjzCC7eJzKXwTVZyc0kGCj+DfW5AgtHmziWQjnYD3MfajMsJpucW
	zzOxcXeJz3IfQW1novr7SAS26zvGTjh92ceR0RszG2EMxnKHxq/bhSkIf0xrgQ7VX+soD2X
	zYx5v3+1E69IYj0WeogoCKsIN0tUQIjlE0SUXHihOB5w14C3sPgY3Pn9KduKjgYsPmeCoKy
	V74FpvknKK9KtzhbxcW2rJ3BGvg1ymL3lRKthR050tnTRRTEb61Gjwd2wcEeTZRPSxgaaVh
	0OeLZvmVQzCpZ66346WJeaPuDAFbvUnk9WjI8rTnJtHUXN4ROJ
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

For AML 25G/10G devices, some of the information returned from
phylink_ethtool_ksettings_get() is not correct, since there is a
fixed-link mode. So add additional corrections.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  3 ---
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 27 ++++++++++++++++++-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.h    |  2 ++
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 86c0159e8a2d..c12a4cb951f6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -231,9 +231,6 @@ int wx_get_link_ksettings(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (wx->mac.type == wx_mac_aml40)
-		return -EOPNOTSUPP;
-
 	return phylink_ethtool_ksettings_get(wx->phylink, cmd);
 }
 EXPORT_SYMBOL(wx_get_link_ksettings);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 78999d484f18..fa770961df5f 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -12,6 +12,31 @@
 #include "txgbe_fdir.h"
 #include "txgbe_ethtool.h"
 
+int txgbe_get_link_ksettings(struct net_device *netdev,
+			     struct ethtool_link_ksettings *cmd)
+{
+	struct wx *wx = netdev_priv(netdev);
+	struct txgbe *txgbe = wx->priv;
+	int err;
+
+	if (wx->mac.type == wx_mac_aml40)
+		return -EOPNOTSUPP;
+
+	err = wx_get_link_ksettings(netdev, cmd);
+	if (err)
+		return err;
+
+	if (wx->mac.type == wx_mac_sp)
+		return 0;
+
+	cmd->base.port = txgbe->link_port;
+	cmd->base.autoneg = AUTONEG_DISABLE;
+	linkmode_copy(cmd->link_modes.supported, txgbe->sfp_support);
+	linkmode_copy(cmd->link_modes.advertising, txgbe->advertising);
+
+	return 0;
+}
+
 static int txgbe_set_ringparam(struct net_device *netdev,
 			       struct ethtool_ringparam *ring,
 			       struct kernel_ethtool_ringparam *kernel_ring,
@@ -510,7 +535,7 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.get_drvinfo		= wx_get_drvinfo,
 	.nway_reset		= wx_nway_reset,
 	.get_link		= ethtool_op_get_link,
-	.get_link_ksettings	= wx_get_link_ksettings,
+	.get_link_ksettings	= txgbe_get_link_ksettings,
 	.set_link_ksettings	= wx_set_link_ksettings,
 	.get_sset_count		= wx_get_sset_count,
 	.get_strings		= wx_get_strings,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.h
index ace1b3571012..66dbc8ec1bb6 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.h
@@ -4,6 +4,8 @@
 #ifndef _TXGBE_ETHTOOL_H_
 #define _TXGBE_ETHTOOL_H_
 
+int txgbe_get_link_ksettings(struct net_device *netdev,
+			     struct ethtool_link_ksettings *cmd);
 void txgbe_set_ethtool_ops(struct net_device *netdev);
 
 #endif /* _TXGBE_ETHTOOL_H_ */
-- 
2.48.1


