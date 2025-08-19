Return-Path: <netdev+bounces-214883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBFDB2B9A7
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4061C188446D
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822892848B6;
	Tue, 19 Aug 2025 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bJMZZ1+V"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8062848AA
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585430; cv=none; b=dJ6m/Xi4kZLekHZ7CaeS8LNbZltn+ldU5k3FCsZpUiXgncUTJcEycN8e+xC2JFOp0VVh9a6Iigq7MvQbN1OvijONpOaTZa+jH/BkMDV+kNSKPZwhOt00xQKHJpPL1cZfW7E8+mL6Wo7N0zNLtjMpNydYydBlP6B1dxd2TzYZ+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585430; c=relaxed/simple;
	bh=VJbvSPzR7nYekRfOxydBQiO6Zxq0O3MtfapiK80ggjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNUzhyOXBhidO6eoU4MabBehwT8QCPiJVeuzeRDa499BbuYDJfSbjhT2armWNhpdbKcb+Fn9YasKhj3uyHe47Ix1tnVgQrxBVZmHBtNIKUSPkp8jXnqG+LKEbDrLmgvOEy6xhUxkP16AH9JfOwnrgqqUgIISl0ntD3JnasWRR0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bJMZZ1+V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57INiKiU002261
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lyiKtoOw6v5xNC85LbQnn0O181F2eSfm873V8UTSEA4=; b=bJMZZ1+VRZp2ZgcF
	/LByZH8rEzTSngp8mNSOikSd3O0NTWP7wfWanZc2E9c3jy1om2eHJZJMrGxuYtXr
	YuN+iMeXcG9uIFswqVYqlkvUZexSZtAr/1lJncV3FXMYGGZiXgC/EPnOj7UgUjYs
	UmYMsxEoNTHDO8Ubt6ON0jz14hZSypcKSoqg8XPRRR/LiEN8/mMTXzcZuPmkwxaD
	aCC/9TJ3DVSsBwAoyfpEWXce3PVxGOdqTzjSsB+W+B8qWV9GZGNE3RQStYNQsB9d
	P1GlXir6ATskn+L59jkb9WfCjNZ+cULABOpqolm6r+CV8LqQ2So/6MIuH6OzRJdy
	iZrhpw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m62vje6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:37:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47174c65b0so9933806a12.2
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 23:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585426; x=1756190226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyiKtoOw6v5xNC85LbQnn0O181F2eSfm873V8UTSEA4=;
        b=pBndeedYVWoBaA7u+0C18B3Z7rUCprOO1eok9iDdNMize8Z0L3apWFdfuSv0eBkSJF
         gLS/b5qolypIKRv/p9jVrCxqId74ZZAnBk2sL10ODNMW5ZllnS0PBcZ5K+1HtfAJMzmX
         w4zQA2nub9bHvgGkdjBucOhH4Hs0nTSleNmZzDgUmlJ3HicS2IY+C5BbvKJspXQYAup9
         bO8Mj4puKqQt9P1IUKTeY9yIjydtHbLRVvXmEdQt1RdgYlrg3e9BPG8K7/UJUY043YSd
         RbalfF6KM169uUsEEHFHhhcf1vgRSkFgEtnAiAI/p0gGMjtmi5fDirj+/ucMvGZgzAWv
         a4Tw==
X-Gm-Message-State: AOJu0YxOX1WJGbomLBPP83QDawg4C34AmydqcE5xgQjlwywynTk89w6q
	rtDMwXj1kJeAadAUzygnbhhtUVn5IPIrHOR+3aUYIVNhVlLrksvVHCLU1zlI9GTlWXWCHHrkFDO
	fWtgakWx+DP1KnmrOt2+Cassh4mWy6iNnG0gtDnQIjiK6bddCIOY2WMBlzjc=
X-Gm-Gg: ASbGnctEViJJhRrlqapKvT7HEBDPVM9S3bKscyij1XB0X+hGhJOMVimB56AgxJ9RUsb
	X1U7tNA07YQDGrP+bYLyo2eMkkngIK6FjS1rOkaC5CuwA7Zu4zm2BuEgZOacwlctfZwvJGrZBtS
	kc9j2tw1A1skpUapsKpLqW5kEc9jrOkKJ1PVKMkl0Ua1eYur88YpxNgkQU09xDZXxpiaFB/Xk8O
	ntTsfQQurxcaq6vniaF5AHr1XHPYt5TUM0zG4o1E1kyn/AnZUjMaf9Yo2qxU5SHLygtOi7ZYGPL
	gdZ1tnFqv0+4GVd2FreJ4R9tUFO3Ur2AEPptJMjm7Covsvd9BZxDHwIFAWt5d0WKitX8BPRpeF3
	YELb+LsPYQiccu8t+jmLUN3KBkTTzbd2K4g==
X-Received: by 2002:a17:903:2acd:b0:23f:dc73:7798 with SMTP id d9443c01a7336-245e02aa607mr18391555ad.6.1755585426469;
        Mon, 18 Aug 2025 23:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEazJmFdGaBIAHWXLR4lCSydXu9MeqjV3bEY6sPcOpXqB1mWNgIGjkbWAfT3wdTKq1teGvRyA==
X-Received: by 2002:a17:903:2acd:b0:23f:dc73:7798 with SMTP id d9443c01a7336-245e02aa607mr18391265ad.6.1755585426036;
        Mon, 18 Aug 2025 23:37:06 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fe38sm98120455ad.135.2025.08.18.23.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:37:05 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 14:36:00 +0800
Subject: [PATCH v4 5/6] arm64: dts: qcom: qcs404: Inverse phy-mode for
 EVB-4000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-qcs615_eth-v4-5-5050ed3402cb@oss.qualcomm.com>
References: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
In-Reply-To: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable+noautosel@kernel.org,
        Yijie Yang <yijie.yang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755585388; l=972;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=VJbvSPzR7nYekRfOxydBQiO6Zxq0O3MtfapiK80ggjo=;
 b=caBB0fwY7GcFvoMDwpRbiG5mbkhc6TVqdTkdOaZN/liBSLS7pCblke/P68n8ZiPuYBVZRQN/f
 BsIYbowh9CUBMJa+bW1NgLEsQ7AKwPN5rzk5oXw7hs1C185gDkhyaDe
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEzOSBTYWx0ZWRfX68C8Je1pHfb0
 BxLlaWcDf+bstrXhoVeJLmGlPEIkWLKKXipiot/rN1rPFWLOCamcqIDfvTECXxsdpWnhDBRosGb
 8rtuy8fdsGad1HZ72skD1WcevtEvRIYC0vfTTrwZcYaucQDiDFMtSbuJbWzhG5GPgeYgcakxuQD
 GPjFUQzNDsGQrWxgDb1E+80+ZKc0nJ2D7C3ABNizGdAqNRp7HAR21angSLjOHFetBSWiYamFaR+
 71f947iZseuCeBR6s7hzT4mOztIu8Oo8/oUCXd7m7ynWmRiJWg8Wq2ecLkay4JZzWZqPpRBBCTz
 v+kIwH3BHiqp7ft5wB5KvxBoPoxlY2PeshiyxYM+OczLYPHZfJcDHiLY2q5OTgCTHoVI6G7rmDg
 udDTigka
X-Proofpoint-GUID: RTcNb1yHly5WwoGsEuumKPuClgKCvHLd
X-Authority-Analysis: v=2.4 cv=A4tsP7WG c=1 sm=1 tr=0 ts=68a41b93 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=78Yoz-F5aJHhz6vTWxYA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: RTcNb1yHly5WwoGsEuumKPuClgKCvHLd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180139

This board expects the MAC to add the delay. Set `phy-mode = "rgmii-id"`
in DTS to match upstream definition and work correctly with the updated
driver, which switches the semantic handling of 'rgmii' and 'rgmii-id'.

Breaking ABI compatibility is acceptable for this board, as it has no
known users or interest from any users.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
index 358827c2fbd3..a3e67e83f69f 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
@@ -25,7 +25,7 @@ &ethernet {
 	pinctrl-0 = <&ethernet_defaults>;
 
 	phy-handle = <&phy1>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;

-- 
2.34.1


