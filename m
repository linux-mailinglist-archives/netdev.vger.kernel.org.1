Return-Path: <netdev+bounces-270938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCNsDv9SwmnNbgQAu9opvQ
	(envelope-from <netdev+bounces-270938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:01:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC62305347
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C69FC301D487
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6883C36E46C;
	Tue, 24 Mar 2026 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGFgS/zD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YJ7Zd3Wf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9A3D8132
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342263; cv=none; b=UbY3TwoKBYF7NAjh3rYgrAAJOCuRkcgiNaOLCAN03axwM/ckcxDrrEJ9FfY7hcXca9iAnKEzhcOsl8m4QezmAumyaT/XaA82oJ/cT+FRj4WiZ79ogB4VuwaC52iYdRFoqbyjxidyt8t6D65pUTKKTW9wKGI7nehBTcpnUZZLWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342263; c=relaxed/simple;
	bh=K1aC662L+9k1UBZVFhUowzAz5oxoOxQNzAXHwIk90M4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9wO73XAo+yAowq7b6ncQCKE7Our0gVL76zAveuAWQQnTeS1Y1eslpaYmnf5r/lcLO2T/72rESr6RQw1Yul+ZaXMP9tvUSkwzFsUBhAot3mmfnvExshLTWD3bUZ/DQXpjr8wSBnHuZGXy9LfaoFfpPUuMtYq+B1BLvRS0aXDhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZGFgS/zD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YJ7Zd3Wf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O7RBCU2371357
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mRU5A0a5cwKQRPXDBHimTxYKv1NzaEwLlulVirlsnTE=; b=ZGFgS/zDbc/3svNE
	Clx/XhMnJcgoPHKB3xOHVH95mWagVD6NpWglYBryW04BEp/J8i5ONvfJe94px1pl
	Yt7idxrn9TvzkJASXDc5HjJpn+hinIWnnJ4snAJ4Fd0EPQ1jk3n16kELywdGMqQc
	JFsunyDCNG5ctedXf5+u1vy4lW86m8dcD//cF9oFiR7PwxkzHiz6asdW9a6idehc
	BzEzZP8Rwxr+Nv2Mxxo47+x1Mu3lhz5wLC5ZrCQITomSdZ1yMqpKktvAHWX5rQGT
	mEyG/YDqh/DAwvkfXjHMkuJmC92xoi3QVBAKhwb20nUF1+eQPEoT0QPtnU+DH5H5
	/LhkVQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3p8308sa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:50:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b06b68783dso24292965ad.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 01:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774342259; x=1774947059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRU5A0a5cwKQRPXDBHimTxYKv1NzaEwLlulVirlsnTE=;
        b=YJ7Zd3Wfry9ZIMZwt5U+j5XFC9AuXhyeGbU+06o5+ckN+EeAP3kkJ6t+hzkWIqgm9g
         APmrVoj1A01uNmq4nBiEFyuqQCZuD+Fodkq718f7BTUK77MmI6lMSaDKkFgLnHjPkz6v
         62/iodAbFLqZY9AcnqPJZwXLqK3KfKRCujpZA8N2D/3xKovBYN1qSrmnICxsonUkunw4
         Aeulspq/ZY8zGrv3rNJy7sUNN70Sm9i9/Q8Oar2ClWufhaWF85xPU7pyX32PQzs6j+4E
         RDz8KvuirhZRnplK7ema3WCQye1wKUT+DVD/dyaqsSy1fKTBahqVryCY+kbBBUy8BZBI
         GSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774342259; x=1774947059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mRU5A0a5cwKQRPXDBHimTxYKv1NzaEwLlulVirlsnTE=;
        b=QNfYykOa+LxbMHm1wPZ2GMB6ljlbJMuDhlXkSmARZuD0eKhNswNECrt8VYLHEP4nau
         tAE/ApNuVU5kfdBNP77vkZWvh71eJvenzNCB/paXFGbEXSlMmGBtqBurSHNcDO6tGs36
         pjhiL9tE5NKzvRtfFaO2Js9gMWKpvfRVPvv4mu0miQTPfMsogeRhwOAoZSnXILGOqlVQ
         bLslrc0X6x1XKPRUzVJbrvRkUgKICRGb+jOsEicUasDruifqslhB+IsNUNwar17kE7lJ
         ojUdSZxCKqhLtTPUYsFShmOi4NeRamO3KJS+qWiTwLclEaxaxKFTYYdf+xUqJQ2HdwVZ
         dyCw==
X-Gm-Message-State: AOJu0Yw/B+dIHZmsdQZWM7JHS7mr9vky53DqP407RfgU5YekaTZEQzEO
	DdTrczGXKjMCcDs/MdamS9TkEKmj6z1CCGtN3VVZwolc/0INmuD73GHFxmlJXAs6WPNx92FtUIz
	Ut9ztykdJlsw2Cq7ikuYPrR5VgMYfdUc2duSyt1nx0Wg7Fr7BAA+tBtTTfLM=
X-Gm-Gg: ATEYQzwDYOEBogQJwH3j6faF8aETJdr1irX1A0WMwqK2iMq8wGsNackxTy06l8NQl9w
	8yZjUJ9vfYTka83o1BNSYqwlWe+fO2+/y3m36CXIdRsjuEMs0ooY3YYj4SQn1DQ5/1U1elQOpCb
	9/d8DMIFs7i/lqaJbWeA/OGugKTdGHfDXgRGkQfrSntX1qEKgAWFVQynVdAf1Jx2i847KQ9wVBd
	1VGN6BQ7I44NhKi8c0Iw1ISBl6AQyUUWubpqayl5EZzu6pDs4HZ0fA/5M2Es3W4HsiE6dnYrGCG
	FNvLOBXdNzZMrlcAGf1NtDL/HVsx8R0Rn08xUp+10ZkCFhYucKvBXiSf/mbXSxeBKSFu+EkAddb
	MuBlZKS0dG69TW7/LHRdlelDJ6sAeF6Uwa0MEu2atIs4BbYxQjE8OR6eQRYM=
X-Received: by 2002:a17:902:e811:b0:2ae:6d9e:ed57 with SMTP id d9443c01a7336-2b0827393efmr148796775ad.21.1774342258919;
        Tue, 24 Mar 2026 01:50:58 -0700 (PDT)
X-Received: by 2002:a17:902:e811:b0:2ae:6d9e:ed57 with SMTP id d9443c01a7336-2b0827393efmr148796495ad.21.1774342258405;
        Tue, 24 Mar 2026 01:50:58 -0700 (PDT)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c4f1sm135752265ad.59.2026.03.24.01.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 01:50:57 -0700 (PDT)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 14:20:48 +0530
Subject: [PATCH v9 1/2] net: mhi: Enable Ethernet interface support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260324-vdev_eth_next-20260323-v9-1-da6e4e486437@oss.qualcomm.com>
References: <20260324-vdev_eth_next-20260323-v9-0-da6e4e486437@oss.qualcomm.com>
In-Reply-To: <20260324-vdev_eth_next-20260323-v9-0-da6e4e486437@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774342251; l=5503;
 i=vivek.pernamitta@oss.qualcomm.com; s=20241114; h=from:subject:message-id;
 bh=K1aC662L+9k1UBZVFhUowzAz5oxoOxQNzAXHwIk90M4=;
 b=sgOmrsIK8+CE32MgGD03/jPgfErI4vlIL0LvdbZeixVWnvCjHa7Sxq5wyOL8f7vKXqMY47bB7
 IlvlYNm2x0zDCvgu8eSOWbS0Z98VYhpKE99vUxbBb3G1knjOYqXS82A
X-Developer-Key: i=vivek.pernamitta@oss.qualcomm.com; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3MCBTYWx0ZWRfXyJuUvAMm4UVv
 ZuyWp7/2A9Dwih63FD+IAqe0/BDAROzTiCHc1+1rAg+ma3+r2YeYULCY6yIlBD6GmjPalzCWMb5
 NDdzgFa13AxIdKJwnYmIBNNnTi/DYxib1v3ycwFalPcXSQjo6yu/m6k23Cf8mCqLJCRJJvL9ZGA
 SlEGD1zdUb47i6au04Eo8q7g5fay0cty3hehxsV+pFAAGx/eO7HSThjOcP/9VKdbVm2J504zPym
 Wsrz6Z+PbseiJJR5bL61PY/jRTHX6exfgGTQ+hEYXjFKpSAJARN4JnVZu2GfPZrkPMMUtMxnrxi
 R7JYawzPxBiyQFsl92MW/SfBmhDgiVkBvSdSyykggc8WrW2QidDu0ZSkML1kRP/ze3N42l0R5g8
 TTanZBjWXFL5t5aiMDQ8vmki50eO3B1Ei9iZOJ4PzaJ+AOXZTJPMJGfj4vKlu4xuvrjrhaTaUJS
 yLvZ6SFE/WwWr/A2VCg==
X-Proofpoint-ORIG-GUID: cbr5xvxH5Ycuh8nLjZ9ZS8x2mCACAR6D
X-Authority-Analysis: v=2.4 cv=F6hat6hN c=1 sm=1 tr=0 ts=69c25073 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=WxnqTDRJW-rUwrNVdAYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: cbr5xvxH5Ycuh8nLjZ9ZS8x2mCACAR6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240070
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270938-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[oss.qualcomm.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vivek.pernamitta@oss.qualcomm.com,netdev@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[loic.poulain.linaro.org:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6EC62305347
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support to configure a new client as Ethernet type over MHI by
setting "mhi_device_info.ethernet_if = true". Create a new Ethernet
interface named eth%d. This complements existing NET driver support.

Allocate MHI netdevs using NET_NAME_ENUM to reflect kernel-enumerated
naming. This updates the reported name_assign_type for MHI net
interfaces created by this driver, aligning naming semantics across
existing and new devices. No functional or interface naming changes
are introduced

Introduce ETH0 and ETH1 network interfaces required for NETCONF
and S-plane components.

IP_ETH channels represent the Ethernet interface exposed by the
MHI device. The driver creates a corresponding netdev instance,
allowing the host to access and operate the device’s Ethernet
interface.

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
 drivers/net/mhi_net.c | 65 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index ae169929a9d8e449b5a427993abf68e8d032fae2..87d8c61fab983005eaea99603d74a557d1483b6e 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2020 Linaro Ltd <loic.poulain@linaro.org>
  */
 
+#include <linux/etherdevice.h>
 #include <linux/if_arp.h>
 #include <linux/mhi.h>
 #include <linux/mod_devicetable.h>
@@ -42,6 +43,7 @@ struct mhi_net_dev {
 
 struct mhi_device_info {
 	const char *netname;
+	bool ethernet_if;
 };
 
 static int mhi_ndo_open(struct net_device *ndev)
@@ -119,11 +121,29 @@ static void mhi_ndo_get_stats64(struct net_device *ndev,
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
@@ -140,6 +160,13 @@ static void mhi_net_setup(struct net_device *ndev)
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
@@ -208,17 +235,20 @@ static void mhi_net_dl_callback(struct mhi_device *mhi_dev,
 			skb = mhi_net_skb_agg(mhi_netdev, skb);
 			mhi_netdev->skbagg_head = NULL;
 		}
-
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
+		if (mhi_netdev->ndev->type == ARPHRD_ETHER) {
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
@@ -306,6 +336,9 @@ static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
 	struct mhi_net_dev *mhi_netdev;
 	int err;
 
+	if (!!ndev->header_ops)
+		eth_hw_addr_random(ndev);
+
 	mhi_netdev = netdev_priv(ndev);
 
 	dev_set_drvdata(&mhi_dev->dev, mhi_netdev);
@@ -356,7 +389,8 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
 	int err;
 
 	ndev = alloc_netdev(sizeof(struct mhi_net_dev), info->netname,
-			    NET_NAME_PREDICTABLE, mhi_net_setup);
+			    NET_NAME_ENUM, info->ethernet_if ?
+			    mhi_ethernet_setup : mhi_net_setup);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -386,11 +420,18 @@ static const struct mhi_device_info mhi_swip0 = {
 	.netname = "mhi_swip%d",
 };
 
+static const struct mhi_device_info mhi_eth0 = {
+	.netname = "eth%d",
+	.ethernet_if = true,
+};
+
 static const struct mhi_device_id mhi_net_id_table[] = {
 	/* Hardware accelerated data PATH (to modem IPA), protocol agnostic */
 	{ .chan = "IP_HW0", .driver_data = (kernel_ulong_t)&mhi_hwip0 },
 	/* Software data PATH (to modem CPU) */
 	{ .chan = "IP_SW0", .driver_data = (kernel_ulong_t)&mhi_swip0 },
+	{ .chan = "IP_ETH0", .driver_data = (kernel_ulong_t)&mhi_eth0 },
+	{ .chan = "IP_ETH1", .driver_data = (kernel_ulong_t)&mhi_eth0 },
 	{}
 };
 MODULE_DEVICE_TABLE(mhi, mhi_net_id_table);

-- 
2.34.1


