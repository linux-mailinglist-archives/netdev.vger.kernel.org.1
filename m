Return-Path: <netdev+bounces-214884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750B7B2B9AD
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53692623ACA
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB5B1C8603;
	Tue, 19 Aug 2025 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FEEiPTOs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEC126E165
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585435; cv=none; b=o2GhEjwJvEcWtfd684IucTbF9Abzvns8gHPSycCu6kpdctPHIWvAhXyN7MunrV/fxjdx+sezV0KQAXlIjVE6u8LP6ZFNlINQCYTLEytse8k/D/L9Y+s/U67JQMwMVknEzFB4AXPlAfBwpY3/MKOpRDCnUqmt2otX/pn6kkhjOVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585435; c=relaxed/simple;
	bh=UVRoIFA7YXNnu/vJQ5olTkDt4U/pPMeeSryOJu9KTBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+wIpZNIy89LRZ37RD+WjiNpBJ0BWPnqmavMqDwjea3MNTI1QKmJwUlRx6b6eIaiU/dO0Y/mJVh6ac1dtg/s2/hUZyGD/CNJOzKt36GQlVB71msy/xgunkVmmX93PD6YxgdMJB+UmsAbnkt3cy4fttb8pZkw+VHZ7YHEIXUX3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FEEiPTOs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J0bOVJ019369
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NPgiFAJ7QYLG2oWj/sNVs7ofikmUpmx59tiZmMh5Oas=; b=FEEiPTOsUZeFu/qe
	+jNrfAA1WrSJLADQFgBeTqO8iKt92jHLHJ/BiGhzjA0ceEjv4YwOgLKuL807UJLo
	uGIbkBatZVjtcAkZZiGW1cDnpaCVD7jeVGHZF6/P8u/aoj8R9dKd/LitOHQvGx7V
	BsldcVCDya8C+8C9UcDpM2OWD4vUQtXPEeLdSGtNoWOTUhbiFtQ6mKEBuSlus6at
	cDN3wFXdNyWSSZ5EUqqsinu3JeNjHw8tsbXbI7HQc67vKtwu4A5CLFdnN2Dfb2wp
	JVcOIF4Q8SFRbmNiQL2ZMWCbNipI+VTBWdnPVvmd+DFM4BHSM0i+dh7gyPojtET8
	cuxzbA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj747ga7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:37:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-321cfa79cb3so6453784a91.1
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 23:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585432; x=1756190232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPgiFAJ7QYLG2oWj/sNVs7ofikmUpmx59tiZmMh5Oas=;
        b=ouVVXlSek9/xQkMST1LrXmjJRXsLz63CNL3EjNgkM87pHg33oDkmcgobaRPPi0gDJc
         zyE/JvaidQ6KWFwsWvm7bWP6j9XHejfptfedB64KR/xe0NdH64lu7Qsfm7XH4NYiwyxY
         eeTnZ/lqH8X2bEuTo3jcJHGp1NDtqWY9QtbnD60ShL3ezKWrzjPbL0zuD5Asnb6cd+MH
         +WAG/lmhM2VohWvGvQF96N6k9k42l034wtf91mrK7wpJFOHL9iWU8PSYqKdbC6CzwlLs
         A7qjWutFt274RUNwf7fwMvtsHDHoFXWYRET5lxYk04eRmz0xBU4PweBXFAGTsxW8vfsI
         +6rQ==
X-Gm-Message-State: AOJu0YxsNiUo9GOzVbfSXrtCY2RphKHYXwnNVNXhbY4pyeQ6K4/UWFVP
	UaWsfBO76sxbN//ZeLaqabXWtVVPQwruIjY6GCX31wGlFLA4skIpd7m/z3WOumsfsx9D1odghR2
	Ui9Xoi/191w8v3DDhpdjS3tcjKUE+Ei+VLiQBFjK1h7Pw01sUOJUNmh8oObk=
X-Gm-Gg: ASbGncvLETCU5mBF8jM5sMsFydOMi05SqHUCgNJNloVKeZ3RhRk4TctwlEaZAU5HnhH
	YfwstXIDCwIdWFoM1Ejc2XlYrsCpAtCa5S3/BdXxLIK7U64DgiS9V2ohxZ6fyARtBh/Ngjn2Eeu
	vHa6l9q6UUZ2p//Ypt0eQB/3Vm0gUSvnWCuh220IDVMsXy/2/o+Iu/l9DMFa+szH5UZGvadkhoh
	OmXt0zzljIm6GNQV5pct+mmWEmxp+UzyYFu4vkfBE9wpYJwdaS6vDHkiAVTOXKEZS86z3gw8MVg
	EQ0KXMjv69+G7S2TRorCfXdYZh1NrQkp6/6stkwCt9c2stdrlDYJvtywt8vZ+404vya/RT8ce8l
	UJ2pTk/b7gEVoj92sDTODi7c5eSxnEAWMsA==
X-Received: by 2002:a17:902:dacf:b0:23f:75d1:3691 with SMTP id d9443c01a7336-245e0ebd338mr17897295ad.15.1755585432126;
        Mon, 18 Aug 2025 23:37:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs5sSOdxz4RmFjmlJHx9g8dTbVBE1WGeTusAu1XpGUGqae1RKUVGWzRGqVqz2wkAnydBOXQw==
X-Received: by 2002:a17:902:dacf:b0:23f:75d1:3691 with SMTP id d9443c01a7336-245e0ebd338mr17896935ad.15.1755585431668;
        Mon, 18 Aug 2025 23:37:11 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fe38sm98120455ad.135.2025.08.18.23.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:37:11 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 14:36:01 +0800
Subject: [PATCH v4 6/6] arm64: dts: qcom: sa8155p-adp: Inverse phy-mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-qcs615_eth-v4-6-5050ed3402cb@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755585389; l=949;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=UVRoIFA7YXNnu/vJQ5olTkDt4U/pPMeeSryOJu9KTBM=;
 b=tsf+6WvUJKGOAH+FBQ4hmhftcJq+MxJgP5hpWHWfw7nVpRZpaoDF3ljPE8azKnO8ViTgXsSGS
 YPtA30xLy2ODO3YSOHN1nrjjEXlEbtXd3G+JBkkD4/mZWXfZrbYVwV0
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-GUID: iPdTteJT2CFM-tK5OEfW2slUmgW-VPQW
X-Proofpoint-ORIG-GUID: iPdTteJT2CFM-tK5OEfW2slUmgW-VPQW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfXzE8OIZiuDawp
 MZPOIXfSTM3hMAPF48wbLh7Cou8r6GvD3GJODj3rNpqiaBz8L584Bzy1IuNdt+geFcmK67Tb+fu
 ntKiPmfT3wPXdQlV7xUfxYi0B39ud8M2N5Kx9LevUnWTeVXa3N/DA/0ckxfYgSLoNOSEFNavp/M
 wfybLnGmrhnLt5hP44dFPEV0xZfLmjIePm381Tk3CedgofGbFKz1S0B0TY0dNgepTbOnZUqG/vg
 vLn9z5c7erbtZuW2VicK/JTAndVF7ixvjLKvPiCx/mOpd7gXSbXutIhdjBEp/ANgWYKac2CMRh6
 E8GlrwhqG7YPrXHMVqA88Ch4cgjVLOc6rj/bqOjqqPMgN98K5P6oEgHGj7QuehAjNrZ4cW40Kqa
 PDD43SYO
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a41b99 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=78Yoz-F5aJHhz6vTWxYA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033

This board expects the MAC to add the delay. Set `phy-mode = "rgmii-id"`
in DTS to match upstream definition and work correctly with the updated
driver, which switches the semantic handling of 'rgmii' and 'rgmii-id'.

Breaking ABI compatibility is acceptable for this board, as it has no
known users or interest from any users.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index 388d5ecee949..4ac1a5b09e30 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -325,7 +325,7 @@ &ethernet {
 	pinctrl-0 = <&ethernet_defaults>;
 
 	phy-handle = <&rgmii_phy>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 
 	mdio {
 		compatible = "snps,dwmac-mdio";

-- 
2.34.1


