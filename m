Return-Path: <netdev+bounces-220733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AC1B48688
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 10:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6CC3B9EC6
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC3C2EB866;
	Mon,  8 Sep 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hz7rxv8m"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F242EB5B3
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319622; cv=none; b=SVqt43f7pxbCTYNArE1IHNLFmtazkdjIHJe95g3Fte9BKItAK8Lw99dDqhJW7E5na6hkQKvAXuDsMQpYZ+1mzIWrFzmC/M+xo6aZWs+emL0CxkRTVc8sIQzKOUdHbcQXSYBEEb73u3ozBRBQOmSYt2ABKR2C/u9qG78EpXQMWt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319622; c=relaxed/simple;
	bh=orOKlPtQLn5AGPhNEQlHkVZYfkJ9hhPyxvhObhS2CkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/FXRC2VxenQEyeVSZMS8BCS94UnezhVIIYU2lqyx39QaH7/uqH3qKjAP5vYluSQo88QDT2lcAbNoWwJlwPliniwHvaAm1jGljeJT9qhz36l8r4AiwnzRwlJII64ARIX5XE/tH5WchX/n5t/TeqwbV5M/sA07BeTnUHdIntnZzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hz7rxv8m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587JQflZ004401
	for <netdev@vger.kernel.org>; Mon, 8 Sep 2025 08:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uiQp9Gtm65Pdl4W6k0WxVxnFve96qzLdksXdOVeH1VU=; b=Hz7rxv8mmA3JvVJV
	CS3ADwafbY16xoZwLnciGXlSLw+pIRijKLqJ824/Cu2xMrLwLTsAh3PUAUqg2V/S
	r0uC3UEkkYOc9Lr77+YbRnzyAOCTAKHQgTPboFwUUpa3eI8errnpSXlIkv5KjnEv
	LtTkq4sbyTvIigTM+RJeMlOaIIGFkF43z43iA+Z7viP/3PWufYo21sV3Fcy9YPgA
	fEgXoNrgoa47Qoh7/NnOWPnNc+0jL78ZcRtkWorA9wcVIYwjCamN0pDe0wh+JRjN
	Ou4tWX4YKhdqKGQYeOVCKJ9Oh9ys9wuEFuBzDyWSV9IkG6yKKn80rgOu2odBp+R2
	yKvv+w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j3umj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 08:20:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25177b75e38so19421355ad.0
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 01:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319615; x=1757924415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiQp9Gtm65Pdl4W6k0WxVxnFve96qzLdksXdOVeH1VU=;
        b=Zr0tnrI2eZK6jCR1Nst283zVvy0WliKYxCtqMr9d8QrFB/iGGvV/RXtyHnbYLq97Kn
         eX633/oAOqEEl6z3WZgujvE0lh1WaDu+wota7HAJ+WWUo3tvlM2hClL04fyghQCRwXz/
         hRpKanD9nFZBWW+g3A4Fyanc9LCe5ljuqciBJ+24ROdHt8SrnFNDz+NPMZvJxwHc26xC
         8BksJUCjq95+iA/MCCdMby0nFlQue5nXrX6d9AOtcN+hVTI2TaiqpsxRImpS9oOhB6Nq
         ndHXPnYi5nppayBU9yqyWaAhleugSkL9Taeq6ZrioGZ7zNHp86ihAPJ+Rzr4NL7hhzyf
         9MiA==
X-Forwarded-Encrypted: i=1; AJvYcCX+q5PpRud8dEI0gP/yo2ZSQabyeVsDhU89ckOcFr4l0I1AqEB8Mso1KECTXVb2DXfPhlVZiCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Ou0mfhE1KA17u9paqxouP1AQw+Ewvr6DftRpZxSrWMVOeTZe
	gpEzZwItzGRvW3uodmoZ+XZejx8RrpDVo2C5sfxY8Iz7WsoYGGtSxbob65dK6tLARo+Yv2+xB1Z
	id3JRyIrYHh7MzmkiIQon09th/twlDrXFZUuovU96FYvzXeiRpyryr+KMaSA=
X-Gm-Gg: ASbGncuErSVoREjhSzRL03zKaJpow74pn+eC1M8lVg9oWkSS5kOUWE/MZLyYI9UYZdt
	ObWjWYvUl3T/moQWizYjYWjG4hitUMxQ5oUKuuFkYYvwSOm0IKaJwM3gVn7ZtdhpoWDUPV84N6+
	4p5T/LxZ8CNB6E9UXGT71xB/iqUsePeJW4+RsXI4CMXEgOLrI5ROm/Ji3W/YOhEE1BtK53MpqWg
	uUH+4auEdC1ovZCKjG/gNXaUTAgmpwXYEN8tjZsiJ5B48VUkJ9ZShZQgPS97A776Ca6r3M9qrJv
	WnZeQPRUHTHNH8T0o+LwaSOzfiv4Y7aKE38Eonb9Uqz3+K1oAFjNsSEivSlp546A21GD
X-Received: by 2002:a17:902:eccf:b0:24e:47ea:9519 with SMTP id d9443c01a7336-251718ddac9mr98887265ad.47.1757319614669;
        Mon, 08 Sep 2025 01:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1vovZ9gkQhZX2rd/L1KkPL3qlKIyszAECpRN309/lL9U00EjRsbkgJQyBobjrCkcpgK0uuA==
X-Received: by 2002:a17:902:eccf:b0:24e:47ea:9519 with SMTP id d9443c01a7336-251718ddac9mr98886925ad.47.1757319614225;
        Mon, 08 Sep 2025 01:20:14 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:14 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:51 +0530
Subject: [PATCH v4 01/14] dt-bindings: mmc: sdhci-msm: Document the Lemans
 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-1-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=1254;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=v81wxg2XnsrITbgpwYn82teoXJQ/l0LPAItmU3R1jlg=;
 b=+5W9XDqLZ3HvskV0J+JhX/1XQy4z2UoMFE1DFgGDiojtHaS1/WyS2D/FlKi2vbAuaFXMThdCo
 qIZCasUOKXmAzeHCr4KNp9eFh0u7hWlbVQvGhT57cjHSkNuYspnI91N
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX7UopYFsiscdP
 x62HzHwkkouVJshczV4KZB3GammByTVpJ9n5o6/inePTuLQCOfi9urBShHT+YYR2oWKwcaCidsX
 SNbPRfmzwiyFfIQmet1hcTOR2TbOiSKWuh471JAynDhPA/QiYYKkNmTx2WT1k/1qZDT4nc4dB+z
 gINup3TFmGhUUStlzXg2HpEo+8hHbzry4m725G/Ks92ZBtgDixsyqOj6S08szYDHNHWh0HLF3Bd
 CRsppN8RrL+qsFbDXpTvVMtUit3+M9k7PcGkCTwYeMzTsbISZSdYQFFj35FCVC1GNPP9UCWSELV
 yPXKu3+8lRuE55fI/iVYTVXypdVNWnuNa9VQT7/MaSVyNllfTxwc50/MYM3iRl8kjGsA5nVbFie
 FPbcSLdm
X-Proofpoint-ORIG-GUID: IpMfxD2zgV7T85H4CCIRI0IjhZahP0Gd
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68be91c3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=oyqPBBxx3V5-Y59TF94A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: IpMfxD2zgV7T85H4CCIRI0IjhZahP0Gd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

From: Monish Chunara <quic_mchunara@quicinc.com>

Add the MSM SDHCI compatible name to support both eMMC and SD card for
Lemans, which uses 'sa8775p' as the fallback SoC. Ensure the new
compatible string matches existing Lemans-compatible formats without
introducing a new naming convention.

The SDHCI controller on Lemans is based on MSM SDHCI v5 IP. Hence,
document the compatible with "qcom,sdhci-msm-v5" as the fallback.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 22d1f50c3fd1..594bd174ff21 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -48,6 +48,7 @@ properties:
               - qcom,qcs615-sdhci
               - qcom,qcs8300-sdhci
               - qcom,qdu1000-sdhci
+              - qcom,sa8775p-sdhci
               - qcom,sar2130p-sdhci
               - qcom,sc7180-sdhci
               - qcom,sc7280-sdhci

-- 
2.51.0


