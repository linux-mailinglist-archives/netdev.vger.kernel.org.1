Return-Path: <netdev+bounces-140987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9D79B8F58
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD185B22868
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97C61A2653;
	Fri,  1 Nov 2024 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aAdkv6/s"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A271A256E;
	Fri,  1 Nov 2024 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457330; cv=none; b=Q8LGd0Sp3b8cvIBtwJTBYRfzRUn59+XS+pQKyY1xLt5N8O4M5v7gwMpMhvp6td8rZvSthXaL/I30bgRN+DiFAb0Y/t/Tz7T7ylB/83GpolWYRM6NqB5+J6vhy/ZK5tqRty7Oh0kzRpSBUn+sNhUtS/YNvw0gUXXbi3IbeLBjxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457330; c=relaxed/simple;
	bh=cCTMz0n3TufOW/nzpqclVZkXSz9b3dTWlwVdZAF6w6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MMJAveUoNPj3pisACJEm3Eo9RikOGsDiWx6fblZ+beluuNCHh3A54ITI1I2JJ7B08h86Nfn5qsthYVh0Vol4A3s3AEBVoUyx6u0cRd4zD32i8aHiKFZM9C8xZq8nr4XG7qaS3xj5sTqdGApwykTafcxq/L5wvljjrlqkZS/IN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aAdkv6/s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A13Jnk5019830;
	Fri, 1 Nov 2024 10:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MG6QcRdCDOsIB7rtc2QzNR/9cTeI6HRt5XW82nF1E0w=; b=aAdkv6/s5kIve4bY
	hh8tfG4tJ0Mw5YD4L5n58OzUvk/W0RACpPKNDK092uHNz2zuEvblsKwPhF9mTnKk
	kouQANESLF8hHGsj48gB/uhSI7G5EV11iof2gnTSFCR61cEDVSNjfX+zT0o/E9zV
	uxDUjKrfliuTZTrBTQYT79uwcPilYRqcc/ivl7KFLpYXfD74fqk6p9yQ+PCn2Dju
	MrZeeBlL2ByfgL7u0iNr7O/sy5FCVGOc37aHbE+nNrtI3wmpp9YTNyu175NFERLP
	Y3ERFwVt7om3yoE45SQDHfUHYWaZGAVYdBuVvif0pl82d4cJieuYOvvERDNkLeEo
	WZAYzg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kmp0puqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 10:35:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A1AZDch008294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 10:35:13 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 1 Nov 2024 03:35:07 -0700
From: Lei Wei <quic_leiwei@quicinc.com>
Date: Fri, 1 Nov 2024 18:32:53 +0800
Subject: [PATCH net-next 5/5] MAINTAINERS: Add maintainer for Qualcomm IPQ
 PCS driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241101-ipq_pcs_rc1-v1-5-fdef575620cf@quicinc.com>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
In-Reply-To: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730457277; l=942;
 i=quic_leiwei@quicinc.com; s=20240829; h=from:subject:message-id;
 bh=cCTMz0n3TufOW/nzpqclVZkXSz9b3dTWlwVdZAF6w6c=;
 b=7y4AbnidauEDXfLUXhW7SLPKDR/nM9ZviEmqdPJrsDVNGfwzyhMkLyEsottWDgQNrwCMep+KW
 JWX8W+C1PGVDlj7jNpMB1/s1bJFtniQAisFPMwMM7NwDOr+4NTD0gEB
X-Developer-Key: i=quic_leiwei@quicinc.com; a=ed25519;
 pk=uFXBHtxtDjtIrTKpDEZlMLSn1i/sonZepYO8yioKACM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z8NdR-kpGwNaqy4L5TQFo3xtu0JcAKBf
X-Proofpoint-ORIG-GUID: z8NdR-kpGwNaqy4L5TQFo3xtu0JcAKBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=835
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010076

Add maintainer for the Ethernet PCS driver supported for Qualcomm IPQ
SoC such as IPQ9574.

Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..6c5599c3834b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19148,6 +19148,15 @@ F:	Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
 F:	drivers/mailbox/qcom-ipcc.c
 F:	include/dt-bindings/mailbox/qcom-ipcc.h
 
+QUALCOMM IPQ Ethernet PCS DRIVER
+M:	Lei Wei <quic_leiwei@quicinc.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/net/pcs/qcom,ipq9574-pcs.yaml
+F:	drivers/net/pcs/pcs-qcom-ipq.c
+F:	include/dt-bindings/net/pcs-qcom-ipq.h
+F:	include/linux/pcs/pcs-qcom-ipq.h
+
 QUALCOMM IPQ4019 USB PHY DRIVER
 M:	Robert Marko <robert.marko@sartura.hr>
 M:	Luka Perkov <luka.perkov@sartura.hr>

-- 
2.34.1


