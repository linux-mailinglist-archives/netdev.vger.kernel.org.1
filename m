Return-Path: <netdev+bounces-244103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C83E5CAFC35
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 12:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD03B3015A93
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5B82F5496;
	Tue,  9 Dec 2025 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ANwSlMUx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MvRy+nLI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D4E320CBC
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765279553; cv=none; b=krP6CTjvmf15w+Q4myJ5/o5nFKiRdHoFbW6KI1UiIijLLLVXjybnr07H+y8XeNc/d2M3QUGWCv1OBWQWV4dZglrb5iS8A2sEdypRP3rEjbFlXfpSGbTUWRM5KVXMfZqLtuTqzJw05YMIXpnlfkDu4jYRsHeZfaltRnduu/6bPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765279553; c=relaxed/simple;
	bh=4Xt1IQmjvM1per4xGAI62B4crkvRjHhecHdHzfrfSEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LhWMEP1KhZQizT7VIPis8ElHfdP0M8FrW65GJ+bLYcqU40ZhrTtQDkrQgDZlgaQjmCrd+mz/uX8piDcE8C/HOzAeaIXXinREQlHuEyTp58DwHbX/+6XE4Mw9pMuhB27hFCxYWXMnzC9KwOgT9meG5ACoIY4C7iTqY5QsUuzj54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ANwSlMUx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MvRy+nLI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B99lG303347692
	for <netdev@vger.kernel.org>; Tue, 9 Dec 2025 11:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zzvm6kMjAbwAyGaq4GDz/9JFMnRPWETiid+E++VSmOg=; b=ANwSlMUxEAtZ9DIC
	ydYKJKww+wSw2W7kF2/z/Qq+VjFgZr5KpVNfviD9OCNzMXmqSfe9LHs8ZQUiJ+TJ
	QxM5cHuW3+WONfyXuB+PwRbQ24Unq5JBxosuIwze6ziXLxHRPAnmbxdpfspg6kVx
	tlAaIiGTIBWVM4vQJfoPg3GanT5MBbIDA2MPuKQ6hlebDA4SIjtbngOIdfC/9Lsa
	39zOyYo/SMSGd3lqxGOwItFXCjCr2/oHA3aRCUCNDgkVUDQ0T+yCnwhYMGSmrxo6
	MKNBN5bAxLrap8vVLFrOwcPSBdsbAiR8d68rMonLXdzYe3/2s64rxhOt9TrObI+h
	k0TRAw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axherg970-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 11:25:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34385d7c4a7so3558277a91.0
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 03:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765279550; x=1765884350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzvm6kMjAbwAyGaq4GDz/9JFMnRPWETiid+E++VSmOg=;
        b=MvRy+nLIHQ8jzX7aFtytENPVf6C7oO6030GSaQjZq5amHow+uULBtRgxVQkazlMt7J
         +b7vklTFw0GH1O0Z3C1JbmLoSSBQqm6fk3EOGXp7mO7xdG4vEomdVPWK+jEJK+xTGFxb
         stbnqWtd14RRbbY7pQL9+0zPRnXxb9FKQf3UsA2AYT6QYSQkTDniJuGi5/FJsw4NuElI
         Q4ZlXX4uiV42bR89Olehf9rC6nf+jREih98ppMYxLYTKpkNMqJYIrpmAYVB5K+s+8pY5
         m1i6LTq6ZZ2O3/9OlyA8TX8MWIphcJ4SWxonDrYMrBaqGN79QjYYFBJsaFhzmlD0PJBZ
         Pkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765279550; x=1765884350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zzvm6kMjAbwAyGaq4GDz/9JFMnRPWETiid+E++VSmOg=;
        b=waLKlsQcVT2NnWIxyLOzg+gpWrk3HTIEfaJ2SgISGX/qoPjxB4Ip1MqYiPXW8jaZ3H
         JS1KI15pwtSzlARxcESGgC+zZ8MQIpeMTvtZafdcxF5Yzk64ONXW+5YMLS73ko/NrFxl
         OmPhoTiP9UGXdQMnqLds+gbCNPTWILA4z3c9xDg+LI7pxTnmxMMTiveVaac+4+j8lV7d
         gNKtebylBcGmrtQ06yDBTkRZewqehrjI877sAiZOfGIG63sLkK3RPZxKLLt4wbjysteG
         y9E8BoJrbeXdmDCEbPlYfMQI9ifxT9uBsrjEGH89OEKqKSRwGJhqrKkhI4gam5JWGDM9
         RohQ==
X-Gm-Message-State: AOJu0YzNmCShDgv0btKFx6jbf4VANxwlLjE2JFvrj3Ac5LcCeC6Ar3Ka
	Ku5BFpq1HmGB/KU3oQwQ/AXrYLucgPCJDotYOyLyJNe4pbs+OsLl0dPCE0oynMyqXghl9XqQcmI
	Iu1asEz6d/yd2SKkSrJqVk6LbStSKAOVYsVk7J9MFWU+3X5SVz8g0lT4JyHo=
X-Gm-Gg: AY/fxX5g77BcmIG5tX4115Fy8aewTHjIb6myCGnorZaUhHtAthhs22oane+zdnDnh/x
	dQjVn/xngI+ROQswI9yqGNF36nmhRaxc50BPxFsX/l/wkJEMGJzQ8WtB1Cgq8K4uVVvv1uUFGvW
	d+Xiu9IkRdfDrs1J6reqRBhRcNBJve+d1qrSh2617jEpTaE1blF9aEbVK/AytOWBUg7oSesVDJC
	J4FbRYWOjyHBRrNqcgpoYCBpm24NJbCPwu9mxSCnyqzgA5A+17fRkLSAaxy73qy/d+bIQxGLAeG
	VHDFwghgI8o3NW6Xscwe59C2ne8D75+/bwAvllsDedCUKgYPLdNZG176bWgQr8c/t2XCGWgGtkQ
	cR/JzSOU54+oCEbLlixbvtGKhUpsncFcTJcVs
X-Received: by 2002:a17:90b:3c90:b0:343:7410:5b66 with SMTP id 98e67ed59e1d1-34a4f89b48amr946343a91.11.1765279549709;
        Tue, 09 Dec 2025 03:25:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQEq+dHQp2FQjrMyzqkzhLh2wL7hYVs08v/LzvnKvF1wFx0jv/sRAtqEpEOmVocGpk3Yu3/w==
X-Received: by 2002:a17:90b:3c90:b0:343:7410:5b66 with SMTP id 98e67ed59e1d1-34a4f89b48amr946328a91.11.1765279549204;
        Tue, 09 Dec 2025 03:25:49 -0800 (PST)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a49b9178csm2135964a91.12.2025.12.09.03.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 03:25:48 -0800 (PST)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Google-Original-From: Vivek Pernamitta
Date: Tue, 09 Dec 2025 16:55:38 +0530
Subject: [PATCH v6 1/2] net: mhi: Enable Ethernet interface support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-vdev_next-20251208_eth_v6-v6-1-80898204f5d8@quicinc.com>
References: <20251209-vdev_next-20251208_eth_v6-v6-0-80898204f5d8@quicinc.com>
In-Reply-To: <20251209-vdev_next-20251208_eth_v6-v6-0-80898204f5d8@quicinc.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765279540; l=6488;
 i=<quic_vpernami@quicinc.com>; s=20241114; h=from:subject:message-id;
 bh=PyNLCBsIRJYR2Mdyu60wBNZuDnOIiuK8SbOT40fp5gU=;
 b=8CVrovBbbQpgioDY7gBpzhp2cNfu9WAMC1hNXZUXbn1V/2fg+z558pJNrEMaCrnzjSUOgwXBJ
 JSFl/EMI7kZDc1YDj759QCyeoerv1mqmNEJ22e/Tueq2fSNIzJF6In0
X-Developer-Key: i=<quic_vpernami@quicinc.com>; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDA4MSBTYWx0ZWRfX53qvlLVCrf5S
 U1Z0V8/6bQ84e+pvBfOKaHApxvu+lkPNrTiJe+Qfo8f5EzSXFxY37+8noT0g7AYIOe8v8Mwm2Bm
 RJTIgsAuM9eX9nbZ87cBI31BEOw0ImZBSMonQlMqIk/QI2kNw+dEPGeLt9dxw3tkWpu2sjz2N0A
 cilyq/naIs7cXd++CV2kFnqKLd3mcvGwkQ04oy/MrITKl4TRHdLbyeWYjWwbFTi8+oy+xnEFvtS
 c4iGgac1dhUjFF/ItmlXBmgBD49sVk3poZ/j7dPeWkQCk9YMYgihweB3gEZzLs9PlhgEhdIFtyS
 0wQswqiqePZTOKNIE3xd0wB1A7aNLacvnrfu8Cf/ThYtbEz+s+lifpxvXFGAj+PprH6XQZzxuqL
 hKvSBfviF9wHSddoYfTnYNtkEqlcrg==
X-Proofpoint-ORIG-GUID: CUyTy7N53HsobTlXcv6W13vga4WizBPT
X-Proofpoint-GUID: CUyTy7N53HsobTlXcv6W13vga4WizBPT
X-Authority-Analysis: v=2.4 cv=P7M3RyAu c=1 sm=1 tr=0 ts=6938073e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=B7OUL4BZy9I5PIjrJhgA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090081

From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>

Add support to configure a new client as Ethernet type over MHI by
setting "mhi_device_info.ethernet_if = true". Create a new Ethernet
interface named eth%d. This complements existing NET driver support.

Introduce IP_SW1, ETH0, and ETH1 network interfaces required for
M-plane, NETCONF, and S-plane components.

M-plane:
Implement DU M-Plane software for non-real-time O-RAN management
between O-DU and O-RU using NETCONF/YANG and O-RAN WG4 M-Plane YANG
models. Provide capability exchange, configuration management,
performance monitoring, and fault management per O-RAN.WG4.TS.MP.0-
R004-v18.00.

NETCONF:
Use NETCONF protocol for configuration operations such as fetching,
modifying, and deleting network device configurations.

S-plane:
Support frequency and time synchronization between O-DUs and O-RUs
using Synchronous Ethernet and IEEE 1588. Assume PTP transport over
L2 Ethernet (ITU-T G.8275.1) for full timing support; allow PTP over
UDP/IP (ITU-T G.8275.2) with reduced reliability. as per ORAN spec
O-RAN.WG4.CUS.0-R003-v12.00.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
 drivers/net/mhi_net.c | 75 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index ae169929a9d8e449b5a427993abf68e8d032fae2..d0713e1eb7b024667f8f3f00ed3cf38d91a75708 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2020 Linaro Ltd <loic.poulain@linaro.org>
  */
 
+#include <linux/etherdevice.h>
 #include <linux/if_arp.h>
 #include <linux/mhi.h>
 #include <linux/mod_devicetable.h>
@@ -38,10 +39,12 @@ struct mhi_net_dev {
 	u32 rx_queue_sz;
 	int msg_enable;
 	unsigned int mru;
+	bool ethernet_if;
 };
 
 struct mhi_device_info {
 	const char *netname;
+	bool ethernet_if;
 };
 
 static int mhi_ndo_open(struct net_device *ndev)
@@ -119,11 +122,29 @@ static void mhi_ndo_get_stats64(struct net_device *ndev,
 	} while (u64_stats_fetch_retry(&mhi_netdev->stats.tx_syncp, start));
 }
 
+static int mhi_mac_address(struct net_device *dev, void *p)
+{
+	if (dev->type == ARPHRD_ETHER)
+		return eth_mac_addr(dev, p);
+
+	return 0;
+}
+
+static int mhi_validate_address(struct net_device *dev)
+{
+	if (dev->type == ARPHRD_ETHER)
+		return eth_validate_addr(dev);
+
+	return 0;
+}
+
 static const struct net_device_ops mhi_netdev_ops = {
 	.ndo_open               = mhi_ndo_open,
 	.ndo_stop               = mhi_ndo_stop,
 	.ndo_start_xmit         = mhi_ndo_xmit,
 	.ndo_get_stats64	= mhi_ndo_get_stats64,
+	.ndo_set_mac_address    = mhi_mac_address,
+	.ndo_validate_addr      = mhi_validate_address,
 };
 
 static void mhi_net_setup(struct net_device *ndev)
@@ -140,6 +161,13 @@ static void mhi_net_setup(struct net_device *ndev)
 	ndev->tx_queue_len = 1000;
 }
 
+static void mhi_ethernet_setup(struct net_device *ndev)
+{
+	ndev->netdev_ops = &mhi_netdev_ops;
+	ether_setup(ndev);
+	ndev->max_mtu = ETH_MAX_MTU;
+}
+
 static struct sk_buff *mhi_net_skb_agg(struct mhi_net_dev *mhi_netdev,
 				       struct sk_buff *skb)
 {
@@ -209,16 +237,22 @@ static void mhi_net_dl_callback(struct mhi_device *mhi_dev,
 			mhi_netdev->skbagg_head = NULL;
 		}
 
-		switch (skb->data[0] & 0xf0) {
-		case 0x40:
-			skb->protocol = htons(ETH_P_IP);
-			break;
-		case 0x60:
-			skb->protocol = htons(ETH_P_IPV6);
-			break;
-		default:
-			skb->protocol = htons(ETH_P_MAP);
-			break;
+		if (mhi_netdev->ethernet_if) {
+			skb_copy_to_linear_data(skb, skb->data,
+						mhi_res->bytes_xferd);
+			skb->protocol = eth_type_trans(skb, mhi_netdev->ndev);
+		} else {
+			switch (skb->data[0] & 0xf0) {
+			case 0x40:
+				skb->protocol = htons(ETH_P_IP);
+				break;
+			case 0x60:
+				skb->protocol = htons(ETH_P_IPV6);
+				break;
+			default:
+				skb->protocol = htons(ETH_P_MAP);
+				break;
+			}
 		}
 
 		u64_stats_update_begin(&mhi_netdev->stats.rx_syncp);
@@ -301,11 +335,14 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
 }
 
-static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
+static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev, bool eth_dev)
 {
 	struct mhi_net_dev *mhi_netdev;
 	int err;
 
+	if (eth_dev)
+		eth_hw_addr_random(ndev);
+
 	mhi_netdev = netdev_priv(ndev);
 
 	dev_set_drvdata(&mhi_dev->dev, mhi_netdev);
@@ -313,6 +350,7 @@ static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
 	mhi_netdev->mdev = mhi_dev;
 	mhi_netdev->skbagg_head = NULL;
 	mhi_netdev->mru = mhi_dev->mhi_cntrl->mru;
+	mhi_netdev->ethernet_if = eth_dev;
 
 	INIT_DELAYED_WORK(&mhi_netdev->rx_refill, mhi_net_rx_refill_work);
 	u64_stats_init(&mhi_netdev->stats.rx_syncp);
@@ -356,13 +394,14 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
 	int err;
 
 	ndev = alloc_netdev(sizeof(struct mhi_net_dev), info->netname,
-			    NET_NAME_PREDICTABLE, mhi_net_setup);
+			    NET_NAME_PREDICTABLE, info->ethernet_if ?
+			    mhi_ethernet_setup : mhi_net_setup);
 	if (!ndev)
 		return -ENOMEM;
 
 	SET_NETDEV_DEV(ndev, &mhi_dev->dev);
 
-	err = mhi_net_newlink(mhi_dev, ndev);
+	err = mhi_net_newlink(mhi_dev, ndev, info->ethernet_if);
 	if (err) {
 		free_netdev(ndev);
 		return err;
@@ -380,10 +419,17 @@ static void mhi_net_remove(struct mhi_device *mhi_dev)
 
 static const struct mhi_device_info mhi_hwip0 = {
 	.netname = "mhi_hwip%d",
+	.ethernet_if = false,
 };
 
 static const struct mhi_device_info mhi_swip0 = {
 	.netname = "mhi_swip%d",
+	.ethernet_if = false,
+};
+
+static const struct mhi_device_info mhi_eth0 = {
+	.netname = "eth%d",
+	.ethernet_if = true,
 };
 
 static const struct mhi_device_id mhi_net_id_table[] = {
@@ -391,6 +437,9 @@ static const struct mhi_device_id mhi_net_id_table[] = {
 	{ .chan = "IP_HW0", .driver_data = (kernel_ulong_t)&mhi_hwip0 },
 	/* Software data PATH (to modem CPU) */
 	{ .chan = "IP_SW0", .driver_data = (kernel_ulong_t)&mhi_swip0 },
+	{ .chan = "IP_SW1", .driver_data = (kernel_ulong_t)&mhi_swip0 },
+	{ .chan = "IP_ETH0", .driver_data = (kernel_ulong_t)&mhi_eth0 },
+	{ .chan = "IP_ETH1", .driver_data = (kernel_ulong_t)&mhi_eth0 },
 	{}
 };
 MODULE_DEVICE_TABLE(mhi, mhi_net_id_table);

-- 
2.34.1


