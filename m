Return-Path: <netdev+bounces-219545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F49BB41D82
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E78C18858A7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E863002C3;
	Wed,  3 Sep 2025 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H8ElKYNQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2113002AF
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900100; cv=none; b=pzI3Cpx/nxrfiiIAF1O7UjEPx+2ViJrJgT6qpf4/aIaEoPAoDEHeozRj6LYOkh/EpvfISF/iviWmFcVu1k9OPFZzxLGe9yUFLj64lXbCif0cPUUkFSFD2OrLtAt9LrRxrFtCbmq+aFmyyCinfU+BS9Hh8Bny7Et/ShwztC6oxws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900100; c=relaxed/simple;
	bh=d/8KcN+OgREoal5l5Y/MZyinEyOohKBfCQCl2h9LqwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mQ//JrD8/V/joDxwey/Fq8MGf/OLBj8AhQwQVYD7R+SRHjlGfIBT4RMe9MdkSfraR/okBHJd1aompl0sMMhwHEqBNmBC8gSQjs7fArFPC1kMjQ+kdY8iPiy0zQC3m1yXReXXiSm0WWqHSRraSurDik1iPFUamKv1WxqjzfYWI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H8ElKYNQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BErFT010818
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 11:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BGCKdyi9/G2sO0XrDIQXa/zPVi43JbEno1jV9pbfWBk=; b=H8ElKYNQ4w1OS2SY
	cRjRfLQNXhGZiIT++U+Rj2qGBb9E5/ulQqhy5WBiIY5iWF8F2hmUhcM/rQHVeDe+
	nWssRucKJypAwezIhYKTmmLcFQeo+Jzp56nfQ3f9oEtJxmf/hEms6ceLHyisDpXz
	XhNy4DskGSvOW0IPoYnaHeyKPE57rh60we20aMtvXgOWAqk9dTRWbF3yuGgFMy+S
	heyLA6NhhVQWvCO5lh+/k/8ikAohrif4vmQdw6yg2B13FWQMF5iar7lLMg+6Kszo
	4PmJH1h9C1ENdaBnFtrF4fO/aFRHR63bdEFg3j1Rc7EMAUBRumL0O05t1ngteZnb
	tzWYYA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjkemd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 11:48:13 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso6349674b3a.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 04:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900092; x=1757504892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGCKdyi9/G2sO0XrDIQXa/zPVi43JbEno1jV9pbfWBk=;
        b=MhJtX4AmuFVKCBDFQ04Wbw8PP7tNY/5cPCdV/UYnwQkBZqUXiweIYybBnT/otJXd75
         U8CFz+cki9xlPkUctjqeVL0zM1j+NzAmkJG2oVEHfyPxsGLB7pkfHn7rXLYVHC6J7GO/
         215hQTUe67EwBSMZvSjk0TIl9cMOELnIwQZpmlbRS2FjEjgliKTICrcOMpv4nVUqCrpu
         PR9KXv5h1Q5OaqRD1foTu7oU5zSDBI8p+JTtDa/tiMEF/Z8w7S4rTaRNKEYpKh3ZEb/e
         sHQCd93g/ci/HeyCq6Nn1sDR8nORcna8Db4Ofd1V27XoKz+gTOC59aIdTp0Q+XGMX+ph
         eBvA==
X-Forwarded-Encrypted: i=1; AJvYcCU349UmGnnj66t4+SxlfzpSM2Osby/YHFHRw0bBazVQtjuXWWq8OIxSEQidlx+FYY2r2rapxOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0dxRUgced25OPMhuTDOpNmVQbifjE496whFyCslvqMkoq7heV
	nnuKH9u+Q66iji9UXzOO/bX4xxCyqpFuNOeLkO2wWIjqBv+an3QVhPcJmmqU25GCq62PsTRbG5U
	JPRLRXQ2NbYYT81pLG54Nj6NTD3BA/04uw2QxWfB7oJgDegsK5IvlvVbSbd0=
X-Gm-Gg: ASbGnctOnNomO5udPYIlPCbp57GZLtOdy87mPdt1wGj1+3U4W3oAautDaFCARZg6/Hi
	aWKfZMQTWjr3mJe+wvaWGX6r3Xh+d+Zu9qRuxpEwQHHBypM2d9DxKONEEXTAAqPTB9aHkJWVWRm
	FG35hSa2tm9CWB/+GNVgIrd5VKG1BeS5ZQrFqg1LTFoR9VazEB4gD2pZpR43xIavV9pc01ic+pi
	+788PdgMuHqpeilGrKOi7aHV7ov8QRmrgSyVRaLnM3yKX3uuku3xHNVokXNfitFaVkxVqbLJWRa
	hEFU9AGB8WzGAJcvcx6Qjg4OL86r+MM9zhHC/UPOi3Ngq8puce24T3BLUPbk0KZ+uph+
X-Received: by 2002:a05:6a20:3d91:b0:246:9192:2789 with SMTP id adf61e73a8af0-24691922d9dmr3770137637.49.1756900091726;
        Wed, 03 Sep 2025 04:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELpa4Dqb/ri4sikbh2/35FUCgGSrLzAq9vhNEPG8ilfsdeKswwyiLmoPL40YnRVxfbYYh9wQ==
X-Received: by 2002:a05:6a20:3d91:b0:246:9192:2789 with SMTP id adf61e73a8af0-24691922d9dmr3770107637.49.1756900091220;
        Wed, 03 Sep 2025 04:48:11 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:10 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:09 +0530
Subject: [PATCH v2 08/13] arm64: dts: qcom: lemans-evk: Enable Iris video
 codec support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-8-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=865;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=Lwi6TRjPF04O/1B4XCSUMzPV5zfW+xGiP2gdnJ+he1c=;
 b=iKATISuLMw0sB5ZAmFurgIKPxiRrhFzj4GxgOd1LLCa9pPqVxB+oD4RcAcuMndX8Z2sJ5j93b
 Iu5LRYW2UY3CjLniV4Y7XKG505xiJsX6jBly/7LCNpWVf5DXAO362en
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b82afd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=9guL5b7EFFMc6jyTlUkA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qbiICYRv7A1NgZXiavWe2p4C1ZuYgsR5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX5WSYrBci/tf+
 wBE52/vryGcM9ImWm6qrrEjPHw3kYwh0hd5t293pHgWOBnXkmMaFtGyba/UAIB3aofiTULbf2PP
 nwIn3eHPAgDqO5kOvPon6mzIrI3BObqBVtc0SfVHBeojSU7IeUGHPjeJQ72wV5Z62wX4ST3RjpD
 hpJZd9zmA/CR+1HLI5/cuNM9KrJ/YrhugzqS1GVzkKsi4LVS/pIlyUTOn+ZErnJbhRiAYjXGY3j
 Nflcj4YVbVFPx1tyaBZ96aKFpOVgEkot3i370++hLamqZB/mz+WnEJfXPR9/eHEiufPxkYQQs6X
 TNYBKKKkiS9AvA2n3aeZ0vwu/TQcI6G8M6+JD3prOpeU09rCNekIaivHlceD4P75fWswDZZW3j0
 vTF8EHtB
X-Proofpoint-ORIG-GUID: qbiICYRv7A1NgZXiavWe2p4C1ZuYgsR5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

From: Vikash Garodia <quic_vgarodia@quicinc.com>

Enable the Iris video codec accelerator on the Lemans EVK board
and reference the appropriate firmware required for its operation.
This allows hardware-accelerated video encoding and decoding using
the Iris codec engine.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index eb7682fa4057..d85686d55994 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -333,6 +333,12 @@ nvmem-layout {
 	};
 };
 
+&iris {
+	firmware-name = "qcom/vpu/vpu30_p4_s6_16mb.mbn";
+
+	status = "okay";
+};
+
 &mdss0 {
 	status = "okay";
 };

-- 
2.51.0


