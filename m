Return-Path: <netdev+bounces-244104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9654DCAFC32
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 12:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 895003021699
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 11:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C381320CAB;
	Tue,  9 Dec 2025 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mvt1EQaQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j11YLNMK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF952F7AD0
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765279557; cv=none; b=d/9/GA0oYHv8RIyy+z5/5+t8diSOZxeRHMXl+ZYJxW0Vvz6i7Oy6VgGovcpzfGQyMYtbVfiG3d8MhiSk7I7ShF/m2bq3CylCG2pIZx2hd/JwXLodkBMAX8qh3UNsf3mQkmju7zqm4erGVn5mn0yl692KpktiSK25sZRkXfVPbRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765279557; c=relaxed/simple;
	bh=2FGJCYKsjYntIjZN8gihGQCd+HkaPjPNeoGWcukaLFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o78X4T79RI1V51bWUU0R4YBkpA21P+2dP7Kg9AQkWplWY/HL6VNHnzPuNo7+8MTvOrD75+R6uHc4lZEHHxBX62L0qzL/WcAuVGMIeVnaHv3qFLWQzsflbJVJsZyTY3ecLQ7ZUmPeKr6oyNUp8XhW8DAIQVunIwoCbyR6AUS2rHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mvt1EQaQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j11YLNMK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B99NPlS3125521
	for <netdev@vger.kernel.org>; Tue, 9 Dec 2025 11:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EvDD45RhBoypTIEIU6+VZMz01WBs5CFpnRzADYt4gVU=; b=mvt1EQaQB8iSlCuK
	Vgxf5dXS9KtZ8/cyTZvKM6Bajm1ejXNc6QrYpzSSNuyLke3cM/xCsEXkmKIqcny3
	tqafJK7xXWPn0cEDrU5WrIA3eWvTSpreGjwrRnODpILxnumxeXrH1nG2yzUiVc4x
	bdvnc3M4A/dswrnL+HgpoRyXy9kLAQikUo9xsn/jUo9A8KFDE6+vrHEikxVgOzu+
	Z1fqRFZajkARg34PR3GDAvaiA2/6086mUiCcXpCxxblVUzBvSbRIpHb1nloDM1yi
	OdCXRspfg1/kuS1MPEMDc+h8r3QDAw2IykWpJaNqTbkIUuyR6CRbSr+QTURhMDS5
	wdJBRg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ax4jnjfxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 11:25:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340c07119bfso10564022a91.2
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 03:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765279553; x=1765884353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvDD45RhBoypTIEIU6+VZMz01WBs5CFpnRzADYt4gVU=;
        b=j11YLNMKZWqUs9ASQjRIE8akFJvgjGur+EEtB9RERb3hFpVQDO972+QBElTmaqtTML
         OfHN6cwoQak/I0VA5eCeC+uwrHR6x3vRUw3V6BCZFlGBU9L5GZ0PNslYDbFCO4/gpwU/
         qcktLCqdTpNIeq4ifb7kwEzz3POyVv8tS5MKltymYNgK5PKESQlp7Hz6ebGqESrMTLvY
         V+pCrbGW+KodePz3eoUowy03pRWpyDz8yya68V0KRkuAg8FjbZfRAVwYngLZ04XtgCMI
         ZAGIDW9Mh0hBlVROpUmlTkZxl7tJ/ub1yGkRTRmalQxOXeu88tDQDkairSwE500gt5A3
         qBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765279553; x=1765884353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EvDD45RhBoypTIEIU6+VZMz01WBs5CFpnRzADYt4gVU=;
        b=Bf1EtSj/V28waT96VoNViWjjwaiiTWSLaxOd91zFprFfF7ea0/Ha6+YHIKqwdicbaH
         rVxZmFBs5QtC2fPeGRLoGPfS00KTeC3oqfZQkXr4nLYKi0WxF2EWx+9+FDUHX8r5ppza
         IGOEO2yvgMT8+741WVBPpmtt8SYBU/MBXXcacExoNRbbdNsBlut4OZWwHJlaEsslG8P2
         7zvdwpLnecs1loPCfTFURIEpzi9f4TiymXJmEhFR7QF6s7LQAXxqaRtxQ5RohB22M3Dp
         R83LG7EIZLxVJlr/bFb6RArs/6z4gCz0DtGTXSg0/fY4K9ZV5eNXG2yKfh+5C0ejNC+I
         vurg==
X-Gm-Message-State: AOJu0YyRXzcY5rWguXmR93Q34sW6muMPXaOMpzN1tX4S7dLHlOTHvGNL
	5sfyZlznrha4SsxSE+4AyDkbkSZNY+e4EORX6zBctANCKs8+DbfYhqLDsXqV4YWkLSSQQhDkcnw
	IrwMY8n6vsUxxqXzSKwKUavWqPx7Avto5K94g22HHN0yp8qC5FzeR05T3HqI=
X-Gm-Gg: ASbGncu5udZNq5lcdrilHY00d7ehOzzjr/D9jsLJ/JmzROMaOENc6wKvoVH4uaGyLgQ
	QzYz/25pdtUI4EiQr71t7UBh63qJqMEa29wR41yfz2R26vhk6fXc5CTRv/IU7/szdZ/EzVK8RFT
	oobU7PzopuFpZ7dGEvTvOQL6TSMfQ53+w01Zh12Er0aWvj229ci63p4D1+KusMLvCFYi30CD4Ye
	TT885h539y4Qble15kBgJg3z3McfQPG1XoV1VHtlHOCNzXsazlZVdDpf05P4y4pKrTQkNzUvpHv
	7p5UZ0plc0BFwuVmNWv0LGBaRfU+ta0lbFgo3AX/od0X+ySOjnvUhXE3jnNvP05ZgFMmsrxooyr
	uBKXgNKo3oktyXA9vf1DI+aWp0V8YzmWGN3ML
X-Received: by 2002:a17:90b:3fc4:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-349a2383216mr9377650a91.0.1765279553422;
        Tue, 09 Dec 2025 03:25:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEhiKhxzloVAVDD7SMTU5H/0EbNUFXFZXddfP0ByD6tJ/lpwKv95r6+zJSHLiOW0qNdHwcLw==
X-Received: by 2002:a17:90b:3fc4:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-349a2383216mr9377631a91.0.1765279552988;
        Tue, 09 Dec 2025 03:25:52 -0800 (PST)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a49b9178csm2135964a91.12.2025.12.09.03.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 03:25:52 -0800 (PST)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Google-Original-From: Vivek Pernamitta
Date: Tue, 09 Dec 2025 16:55:39 +0530
Subject: [PATCH v6 2/2] bus: mhi: host: pci: Enable IP_SW1, IP_ETH0 and
 IP_ETH1 channels for QDU100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-vdev_next-20251208_eth_v6-v6-2-80898204f5d8@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765279540; l=1454;
 i=<quic_vpernami@quicinc.com>; s=20241114; h=from:subject:message-id;
 bh=+nRfEhok8twa4Xlo7PhnBTCR9iY5h7FrwyNjZGBqxEI=;
 b=9KkJ5O9oszdtZjNvDYyCiuz05nlJzO0EMIuX4M6xl275ahq89w8yfAYigRkU5bFVFPGxb2Jb/
 pIPqy2H5WRZATy+BzLnzy1JBysCimexGF5sm1iX4OXiPsqODXejsoz0
X-Developer-Key: i=<quic_vpernami@quicinc.com>; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Authority-Analysis: v=2.4 cv=dZSNHHXe c=1 sm=1 tr=0 ts=69380742 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Vo5YzJSDI_NEo2NC7oIA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: xoR3LnY8GTjVVtPSRcADnbQi-vM9yscQ
X-Proofpoint-GUID: xoR3LnY8GTjVVtPSRcADnbQi-vM9yscQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDA4MSBTYWx0ZWRfX9UCbbpgMpKCd
 YTpyECOJmvlPafsBk5zSZiBrbaoV8KhqrNgEdvtzR3XwKxo14YtV2ZrI/erd5slIN/oxdUFuwL4
 ZEfNl12QcF6cDAnbnANKPOhPzexo2OUHDoP2sSFFX3WKpdS1s72eBN6EfaUkz3/Iy567enwCrLI
 9NnZ523zfvN+P/mAUz9rRrgktFjtigZD0TAAfjfVYFrpfQlr79994RkypVO08WQFfZDCAGCj1Wc
 hNTccfEkZMx2kMBT/bM2P8cdfZqkW6bSFTqO49ZiuKj8FiFMoGmEx/tUTGgUZGg7T37Yu/FID9w
 Fb30jj6egy8iQI21aztTkBgo9QKEKphgNiMownzkvzEtEAZdPg+PKRe/JBfsr86rivqMdpWKps3
 OnqgYgSQAglW+zP7r0jdW5Fhb8Hb5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512090081

From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>

Enable IP_SW1, IP_ETH0 and IP_ETH1 channels for M-plane, NETCONF and
S-plane interface for QDU100.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
 drivers/bus/mhi/host/pci_generic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index e3bc737313a2f0658bc9b9c4f7d85258aec2474c..b64b155e4bd70326fed0aa86f32d8502da2f49d0 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -269,6 +269,13 @@ static const struct mhi_channel_config mhi_qcom_qdu100_channels[] = {
 	MHI_CHANNEL_CONFIG_DL(41, "MHI_PHC", 32, 4),
 	MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 256, 5),
 	MHI_CHANNEL_CONFIG_DL(47, "IP_SW0", 256, 5),
+	MHI_CHANNEL_CONFIG_UL(48, "IP_SW1", 256, 6),
+	MHI_CHANNEL_CONFIG_DL(49, "IP_SW1", 256, 6),
+	MHI_CHANNEL_CONFIG_UL(50, "IP_ETH0", 256, 7),
+	MHI_CHANNEL_CONFIG_DL(51, "IP_ETH0", 256, 7),
+	MHI_CHANNEL_CONFIG_UL(52, "IP_ETH1", 256, 8),
+	MHI_CHANNEL_CONFIG_DL(53, "IP_ETH1", 256, 8),
+
 };
 
 static struct mhi_event_config mhi_qcom_qdu100_events[] = {
@@ -284,6 +291,7 @@ static struct mhi_event_config mhi_qcom_qdu100_events[] = {
 	MHI_EVENT_CONFIG_SW_DATA(5, 512),
 	MHI_EVENT_CONFIG_SW_DATA(6, 512),
 	MHI_EVENT_CONFIG_SW_DATA(7, 512),
+	MHI_EVENT_CONFIG_SW_DATA(8, 512),
 };
 
 static const struct mhi_controller_config mhi_qcom_qdu100_config = {

-- 
2.34.1


