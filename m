Return-Path: <netdev+bounces-276845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHPvHXRC12ksMAgAu9opvQ
	(envelope-from <netdev+bounces-276845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:08:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3583C672F
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 395EF300D4FB
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 06:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021D830B53E;
	Thu,  9 Apr 2026 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c9SMqxY6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UkqR2JI0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B630B508
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775714926; cv=none; b=rIeTJrk2VtPdXSHDkqTBegzK1ruMUw+DcYfn0AlFSzFMUkheJb5yJPDncf6/VEb5oOol6OGq0gqJwBzb6LWgtrwxQN3xr8Gt++9Ra6EhZ8Q6pq9OMjTfUqhL0RvpPLf3508yvhXSxQGD7GvYOpQNpVl9mmNqhr7JZgTAI2RJVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775714926; c=relaxed/simple;
	bh=YkhHcdogrZdFjMj+g7oz7ToP7DMRH+REAibTe9XshMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFQ6bzfzWU3xvThqfQ3m2EJvv/Sr4AdZ1fL08eqU0zca2IUK9ke+L8xRStXu/gQzcj5JhPe8PzoCtwfPNMDS5yN3AdePndL0WXN10AQeTDB+/d+FF4fb2E9vuJ+9mKhgkI7EwD5pZ3YZPdVdVfI+c8ReymEU4C03Nw2UZAjxyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c9SMqxY6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UkqR2JI0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638NaFMU2845444
	for <netdev@vger.kernel.org>; Thu, 9 Apr 2026 06:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g7WckDi4dIlJlXlZI+N7vNzXcJtArdXcfVJMIgu82lM=; b=c9SMqxY67po1tcbY
	SjvNBdbY+x2k8HNjr/Ky1m1/fOB2Us8JT30MFTpPudbqRc9RB0B3SYbbbwkxf7uU
	RH8ocmFlhsXsFXZdkDMBJP8ZvOjtbpJjRpWARanbJJacPAMVBJc1ZORUY437lUSU
	rpbUp6VBTvZ6nCrP4J4KbKyD9hb/0qXvyGcvi6pwpwEGZVS4HeDIZOJOXkIxKsk5
	0QCfPucEy6kuVfctRGWFKySe3iV+WUaynqQCetuTM3CrTvAKSfU3QDza3fZXmgpl
	reKhnkvBBMNzqaCtuzN0vozSwJWjXyUvmqhLxYNtmCWuqqNo3azkxhVs3PO/aFz6
	+bF7gw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddt7hjnns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 06:08:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82cd9fa608bso964643b3a.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 23:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775714923; x=1776319723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7WckDi4dIlJlXlZI+N7vNzXcJtArdXcfVJMIgu82lM=;
        b=UkqR2JI0Agws7yaTtOywwN7Cd4uP7vDcN/X8iBdu21w1/X+nthusKZwctzb6exZDSY
         A36cCrHZNUKa/CqmfQzL2+uaI1Ae/H0PU7JZ9nDWRKBIjq2fhpRopX1cdiVQZe2+AepW
         YvzTqEPUfQsshza0vcbYxSohHy3sdm+D9UPGYByJAbn3BSh6jfCG+sQAF0SwRjsy8dSr
         IoGBAsuOKfFBBZ2Sz0VpdImfY6dEueHLzG9NHymViZJ/eOuPjykj5nv81S8T/pT4ydP0
         YfvyAcLrC1llWKnZCFXf6+9RvVw5JwQNk2j08045n23pNB4D9haMzOXHFFgXL2HG2oBT
         Tb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775714923; x=1776319723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g7WckDi4dIlJlXlZI+N7vNzXcJtArdXcfVJMIgu82lM=;
        b=nc/AgnRsc3bVWx2fA6DF5oPFIEqVevFq3MnEYPc34lbWZPhM6xFkbs8P5iSdcMywfa
         fEUGpv//YcHzLZqN2GDTrXmiMqXb3sY2XjzaBw+aKcz1rct/UOjIZ8IgYoC+wN1e/KY2
         Lc0lI8J+KfB5nPVaAemOr2Jh91v7HPkE9oyKkXmxz1EoBUndxfKzQjMoEHW20qTH9Y9i
         CqivVPSUhFJMndmTSRcaLL+fhy6NjApxKNhFBzQ8eayARwON07TQ/uOu06RdYYlPDx2X
         Z9cDSA+YGO8Y0TNkGmYDrWeTwgLRzf0ydT8nIdlbrq/puFqt85fFnTXw99uAHANvzH5Z
         p/LQ==
X-Gm-Message-State: AOJu0YwZyLQkFmeKe5LWUXn89TBGByFprTJNtG/mJ7F1NcZMZ8ZooevY
	n9smRccplMjTGVTvrZUbbFFgXzibplezn2bppreSrRbXdde2pfavz51Kmk3WffxTB4aDrtK+f9t
	KYkZA5du0MGHx/gI3eJxCtxRZ54fMc5uiXHM7USgl+al4tu+MPFwLguqV9i0=
X-Gm-Gg: AeBDievoScO5fyiD4YWx89C0o70qaDrF6T/9S8pQ+rTgxl73pFK/RqjFiEfVEMmhtSA
	CEwZ4KBldzWWj1ezok5YcRBL0agQIE07RbgKCsmr5wAhlGd7xvmiKuH7/eXCFPscLMja5bz6hxw
	s6y8Zgj6k4n5HiwMRIjIFSP09p0NPseKMMBTckIJSG5t0fKToEDwaIPl7GM9p4ahhl30nOEwxWu
	1d7vlaO2iD3CDQRMqJqGucdGB7xQUgjqnAs8t2khYruenjl4VIQt5Hfw3j1JSwW7vi4KZuwWHEc
	cJCYsMRVZv4GKJLwmVFzu33DRurhgSvDNWAmEiS9gFquLxBOvG7mbTxhW9pbmcmrdXGz38raTkU
	Y4wqzQbmM/+LAocY6kjgSV5MK9luHEDuIcK7pdgJfJz4x0yhADrGOtuXxV+U=
X-Received: by 2002:a05:6a00:3bdb:b0:82d:1faf:773a with SMTP id d2e1a72fcca58-82d1faf7f27mr14931973b3a.3.1775714923195;
        Wed, 08 Apr 2026 23:08:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:3bdb:b0:82d:1faf:773a with SMTP id d2e1a72fcca58-82d1faf7f27mr14931953b3a.3.1775714922721;
        Wed, 08 Apr 2026 23:08:42 -0700 (PDT)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3baffsm23163534b3a.14.2026.04.08.23.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 23:08:41 -0700 (PDT)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 11:38:33 +0530
Subject: [PATCH v10 1/2] net: mhi: Enable Ethernet interface support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260409-vdev_b1_eth_b1_next-20260408-v10-1-6d44ca48f189@oss.qualcomm.com>
References: <20260409-vdev_b1_eth_b1_next-20260408-v10-0-6d44ca48f189@oss.qualcomm.com>
In-Reply-To: <20260409-vdev_b1_eth_b1_next-20260408-v10-0-6d44ca48f189@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775714915; l=5511;
 i=vivek.pernamitta@oss.qualcomm.com; s=20241114; h=from:subject:message-id;
 bh=YkhHcdogrZdFjMj+g7oz7ToP7DMRH+REAibTe9XshMM=;
 b=wPPUWWB8Iuxlgai0qqycQg2n1mRVNX450S8NPb6EH6v4HGraTra3TTdJBjoejvBvqW0D+/x91
 TcfM0v0EUhoBcfvHAbG5Kh4w9Ppuf98WRMdZ6xWrGN6rV46Mol7SRYN
X-Developer-Key: i=vivek.pernamitta@oss.qualcomm.com; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Authority-Analysis: v=2.4 cv=O5IJeh9W c=1 sm=1 tr=0 ts=69d7426c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=WxnqTDRJW-rUwrNVdAYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: tiKN2O5puQAd3Oy3gKsZnm8YYuKtcOoQ
X-Proofpoint-GUID: tiKN2O5puQAd3Oy3gKsZnm8YYuKtcOoQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA1MiBTYWx0ZWRfXxlFgErfhwe2A
 LGto+nO+Lbzd1M3mW9cy6Moto4lGT9PKGKIPkGr71LMRXEFz+g6waVkSi8fK1VlQHFNauFUq4gI
 EUqQZ9KMcdPJ5EMGqmtainsGtyh+mZKa2YlhgTHeMrdYdrdmlcqRu1vM6k7Ye6CUPTX/t2j0/JI
 NuTgKl7WFv966gwlR3Z9BdXmqnVDt7VFFC4jBmg9H19ccxxoNvO3AipsZ4ZJB8ULcmWf/wf9cm4
 gugdaTWgkn404SZXayvQb+ZZUpkTfhezL8uEIw21q7FQ0giOv0XBc8175BWFEAhUAX8v0PFbn41
 QdZiDUsbmXVb4oDVrG8Z81NNW7QZ/YRJzHehXsn0OCdJbvSGANUGK8GehItlsO2NCC1gt6WVwjE
 +60aVtZWWxqdfJsNvgqona4zeIZTbm+BcQ6kkvlMdvn47OMUDfJMjaAeKXrFA208LAG1X5NbVHk
 BBeISxndquKgwzvBstg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_01,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090052
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276845-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vivek.pernamitta@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1D3583C672F
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
index ae169929a9d8e449b5a427993abf68e8d032fae2..47b8617de027980a69c57261a9b4bcefc828dc96 100644
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
+	return -EOPNOTSUPP;
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
 
+	if (ndev->header_ops)
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


