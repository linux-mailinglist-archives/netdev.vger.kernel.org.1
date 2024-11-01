Return-Path: <netdev+bounces-140982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A49F09B8F49
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14FE7B221FC
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691B41925A8;
	Fri,  1 Nov 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BpIjtGGI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F7839F4;
	Fri,  1 Nov 2024 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457315; cv=none; b=lHyz4sqQaacDHbjvnNYllLD53m/9ueTY4ILSx2yr7HN9ZTr3xtbQ+IaPk16TCjd6mLbY7JL9Z+MR9Hwm0T5N/0eHkc2p59AwzfhAV1VEfYTehtTMLOY8osXIbm5s6vRjcczy62mC29O8+6Cdk5QDLd1xcmd3ajYBnrtGg1HKrxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457315; c=relaxed/simple;
	bh=mDY3sQhHHJay03QoXDGp/ZK5UPvuGf6lO1jg/cq7xSw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=JkPBN58dyaqgbFNAJUyqbAZTIh6p1ppwdpbkG4vywnDBk+sHxLyEWasNyy0BS3DLu/jhrqfZmYwBxlnZAYy2oWOJSboKVBqvjPfvKe00tiTrBwQzgGqvzFpeFlJKQpj7X56pI4zZmJ5lOn1G6heYOuQ9MvPM+CqQGL1hmC3yNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BpIjtGGI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A15pMkj027500;
	Fri, 1 Nov 2024 10:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=idB0wFf+KEHEu+GKhdfnGe
	cqvCNGY2vxrRLBvif2tl8=; b=BpIjtGGIPi3fS+akhumUzmokk54Z84mfAkYqSE
	Mi6baqxH5PGMvIn2sa5r83SO8aeZ+DKJ3DWsCGISV7BvDhYFqGDhEzCBmndSHthP
	h5XoqR+Gx7YAwWLjJqv6Wj1vKkPZ2uSvPwlFm2uXMGbhcVcCEKh4rPU74h6flRvD
	Ik+0HkrtpXkyaemxUgQuxC5s/GnF06ViGAnvkKxt8nK1UbZTmT+3gTrvCQHvtD3S
	XGPi3Vs0LZ29xz35nlyPIuOj6+TkhHkuPG5EvJr+x5pfwwiOt3PiRv7K+aUC4q3J
	OezFogjo/MmlPI13HrD1dOOLpHCdO35fZbrLkJmmDVr4Ux6g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42k1p3a3dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 10:34:58 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A1AYhsc004189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 10:34:43 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 1 Nov 2024 03:34:37 -0700
From: Lei Wei <quic_leiwei@quicinc.com>
Subject: [PATCH net-next 0/5] Add PCS support for Qualcomm IPQ9574 SoC
Date: Fri, 1 Nov 2024 18:32:48 +0800
Message-ID: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFCuJGcC/x3MQQqAIBBA0avIrBMai6iuEhExTTUbM5UIxLsnL
 d/i/wSBvXCAUSXw/EiQyxZgpYDO1R6sZSsGU5sWsUYt7l4chcUTatOtjH1DA3UNlMJ53uX9bxN
 YjtryG2HO+QN2JvOOZwAAAA==
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_kkumarcs@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_luoj@quicinc.com>,
        <quic_leiwei@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <bartosz.golaszewski@linaro.org>, <vsmuthu@qti.qualcomm.com>,
        <john@phrozen.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730457277; l=1960;
 i=quic_leiwei@quicinc.com; s=20240829; h=from:subject:message-id;
 bh=mDY3sQhHHJay03QoXDGp/ZK5UPvuGf6lO1jg/cq7xSw=;
 b=ZB2HSgnS8szv49yGy4OIy4c+EnnNgiEpPn2dBTwtoa6VxW6sk+vcXSTpSGLdfgmzqTvAWOb1b
 8Yb8c7N857DAsPGDWj2EJ8uIOWqZ2cHvLh2gV+oLk+KVuOpCjL9f6bP
X-Developer-Key: i=quic_leiwei@quicinc.com; a=ed25519;
 pk=uFXBHtxtDjtIrTKpDEZlMLSn1i/sonZepYO8yioKACM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XL6t0DXuFUg4viHgM9e2gB6mKYjqNTeu
X-Proofpoint-ORIG-GUID: XL6t0DXuFUg4viHgM9e2gB6mKYjqNTeu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=887 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010076

The 'UNIPHY' PCS block in the Qualcomm IPQ9574 SoC provides Ethernet
PCS and SerDes functions. It supports 1Gbps mode PCS and 10-Gigabit
mode PCS (XPCS) functions, and supports various interface modes for
the connectivity between the Ethernet MAC and the external PHYs/Switch.
There are three UNIPHY (PCS) instances in IPQ9574, supporting the six
Ethernet ports.

This patch series adds base driver support for initializing the PCS,
and PCS phylink ops for managing the PCS modes/states. Support for
SGMII/QSGMII (PCS) and USXGMII (XPCS) modes is being added initially.

The Ethernet driver which handles the MAC operations will create the
PCS instances and phylink for the MAC, by utilizing the API exported
by this driver.

While support is being added initially for IPQ9574, the driver is
expected to be easily extendable later for other SoCs in the IPQ
family such as IPQ5332.

Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
---
Lei Wei (5):
      dt-bindings: net: pcs: Add Ethernet PCS for Qualcomm IPQ9574 SoC
      net: pcs: Add PCS driver for Qualcomm IPQ9574 SoC
      net: pcs: qcom-ipq: Add PCS create and phylink operations for IPQ9574
      net: pcs: qcom-ipq: Add USXGMII interface mode for IPQ9574
      MAINTAINERS: Add maintainer for Qualcomm IPQ PCS driver

 .../bindings/net/pcs/qcom,ipq9574-pcs.yaml         | 230 ++++++
 MAINTAINERS                                        |   9 +
 drivers/net/pcs/Kconfig                            |   9 +
 drivers/net/pcs/Makefile                           |   1 +
 drivers/net/pcs/pcs-qcom-ipq.c                     | 879 +++++++++++++++++++++
 include/dt-bindings/net/pcs-qcom-ipq.h             |  15 +
 include/linux/pcs/pcs-qcom-ipq.h                   |  16 +
 7 files changed, 1159 insertions(+)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241101-ipq_pcs_rc1-26ae183c9c63

Best regards,
-- 
Lei Wei <quic_leiwei@quicinc.com>


