Return-Path: <netdev+bounces-217033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CD9B3721D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 20:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD32365D26
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505A336CC96;
	Tue, 26 Aug 2025 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="auS89GN1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61CC36CC7B
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232493; cv=none; b=ak5dJ1HBQIJHWD/GbANpRSbHfdjKC6dAI/AbAmKWV2xYl2VtK4fffX4BKxZgDRO1SMfwuucaAP4S/HuK8qlNmRUuy+QF5YC0W3Z7UXbmy9N6S5B6gWi8EbdIfU6LRE5mopEchFDQs4tAlJklOZZwtmchej9lohn8EqBbJUpNR4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232493; c=relaxed/simple;
	bh=JxYcgKcmhaQur96n/POTBQUFznkRKuR1GNH5Rn9msRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R23hZ4ZsP/Wj5QNFpUkV10wxeOWirn+H8B3Wpwyb3nlNowllVoRf2ksPO30OfMmla46PrgSVW54f2Ozyedc/aRzvmh/JoMYamDnTmw57M78OQ6ti3tHVAmr+C+SOVmeyjYX5SIw9v2xkOzFUVmAYpy1J0xgKi6uKtoxDNYcU72A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=auS89GN1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QDRSgt008235
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 18:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eL0QgrgRy3cWfotIYWgvsMBQYI7kvhF7uQsBTion3yA=; b=auS89GN1MxwKhY5Y
	eyute2YrIR2oGMQkEgnhXLr349CrCx2PQv7B//8ltmJTQaDC0MBQ0C9hNLDX6aDC
	r92r6tipLqBldJHRVt+fG5WqwOS4HIrJ8UWtdo8Qkp1IWNVQ/WZq9NF0K1w/OsPi
	g8JOoNmFfyBx0DWHh297CVA2vMkWcVx3i7k89KC8jz09tOY6Hpp0evY9vbWbtXco
	xfGvVToEDb7/5QCKhASJvgtIvhlr18z1mpQvgyJBcEdt1sGVKGVGsaFpy/CCP3t/
	BkFSKCRYLCl3BuHc1/QKqopukyWVdrzZGxbzOYUQMP1YEXISMnjrKLkBOzvZdkg4
	Xgf18A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unsum3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 18:21:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-771f28ed113so1583899b3a.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756232488; x=1756837288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eL0QgrgRy3cWfotIYWgvsMBQYI7kvhF7uQsBTion3yA=;
        b=HVPOpWmO5dhpoFKL0RBKBh+7Avra3cQ9l2WNjZGv5s6uFtLX91zEnrRXEdJmUvgv4x
         scph2obTrF3QWfObiy+VApHPKWKO0fNwgqnd2VPhveCdMxFrzOtHeBGje8lOj+rCsDFV
         VDmUztiC6pFMxO4s/s05U2uHS6EaNC4pqxRCverooSdnbHAy2iwzUBmwZG+s39JjySW0
         3xtzOvaOxE0306rlBhFoBzMKIlWCvcuLslGu6V8nXYVK9tGbaSLpC3e5y7kyGqrIvlQS
         A/pielTVjCGi1VWRdrYEZQQ4/9ZGA834mmy+Yo0IWzjaancISCbLj7w39w4VfjTqS4Ui
         Jeog==
X-Forwarded-Encrypted: i=1; AJvYcCWwIYvoED5MVYX/7Rt0ebEoiB8UgkurguLzvVbAPQOyGozqi6E9Ow+Lz62hIhC3V1cwl9A7ZF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZomxN7cujHlWWL0N4ivIRqXnznlR0FGKe5qKv9sWk+kU1F6e
	gcFUa8TnvYxEG+7XFBfPBqi1LovVwcgLwfxcdUd77Iz1nK5LCRIyFLqKoqHFIpFjO3qIoVohAxH
	HemofTQilwBtl/9HR7EZC51SitIgDvXtnTBtjHtSRFDFjYjBqUAEhnZNhY7I=
X-Gm-Gg: ASbGncsxr9qbWQHDF6R+LhXIKtCVf8+5f/0WGt1JJrZUZgDHl1mtEJh/HgLP+N5ENFs
	OItL8pQsSJLjurxR78i3AsZMOvCSL5l91AwTrrT2aHFqYXJBs1HtHzVFasBbqOfciN5O1XycUUz
	bIEnFHKCHeh3X2yJM0GSl9+hiNOvINQhr5OflXH7VomKWzyb8LjI3qchP3+pC894AeEOvI5x/Fj
	k4/PoqOSpyZR0yWF0UDYDtxjPXyeDJCBPTnUimLIMzzu++JG4SYw5a2yQCVFneHY469ESi+WUsw
	3jtTsFlwmJcN5STFK0DdR97LYPDoDy7WcBHHOzut6d2QYKumjRU1NxYToaw+po8SZHLF
X-Received: by 2002:a05:6a00:14c7:b0:770:5987:5b3a with SMTP id d2e1a72fcca58-77059879144mr10408751b3a.16.1756232488288;
        Tue, 26 Aug 2025 11:21:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdbni7xGAlaDwJvZNQie+3PflKT30+F6qVX4DcxiW8gpRJHQkgNR9tu1A3N7ospcq9hZ+02g==
X-Received: by 2002:a05:6a00:14c7:b0:770:5987:5b3a with SMTP id d2e1a72fcca58-77059879144mr10408719b3a.16.1756232487815;
        Tue, 26 Aug 2025 11:21:27 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77048989fe6sm9881803b3a.51.2025.08.26.11.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:21:27 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 23:51:00 +0530
Subject: [PATCH 1/5] dt-bindings: mmc: sdhci-msm: Document the Lemans
 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-lemans-evk-bu-v1-1-08016e0d3ce5@oss.qualcomm.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
In-Reply-To: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756232476; l=1192;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=vYOX3rphXNqw4BaZtF1OQs+qVbxZRa6V2tNPd8V2s/o=;
 b=d02cyucfOmtC1y0r5qc+700gCtMeGv1Xx4u39k3ipECsmsgdJU/b+YdquOEEBuIb8Ab8VQ6ha
 UCtR4syOGZqCio2iFgsKBjK6ubiSLuHnl4u9Rq4tQRTIQi0rS8U9uTY
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: uD8Tynj2jwFOifi9JE1hNxftyVp9Qtxw
X-Proofpoint-ORIG-GUID: uD8Tynj2jwFOifi9JE1hNxftyVp9Qtxw
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68adfb29 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=h4M2rFpPKqSdi5wqdTYA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX6jeDLjLLqOb/
 PKJVztWRgH+SJxm/55FBRtyclOGZcxL5QVcQ/l04Bp6BQLmntAKYGRSsU7eMscvZIUkKpsnLSXr
 Ety5rkbrq4GxBXaBWsH7mlxKSCOxDuLXkMXOHBPyAYxCuMHDj522WEoXmYpQwwqIZVMi1RsMcAq
 YX2w7ykNhevAAA2dPQhWmTBO2c3q6TpIA6Jpse3T049H4o52D/UFeCgMiVmTdWmAi6hcYfMkDg+
 s1mhkXAxvsdOaXgFdUs9uVggnPVuv3s+spKIlB7PWxdFg1uV62lD5Tn5KialgU3q1f6CIq627rm
 IKf6XxUXWybe1cTunQXmopJl1mR5srcCkwCdnIjZ92jlAkrJHCqJ0BTndZuCjDv9YtQnIX3Chxn
 bwjuV8uU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

From: Monish Chunara <quic_mchunara@quicinc.com>

Add the MSM SDHCI compatible name to support both eMMC and SD card for
Lemans, which uses 'sa8775p' as the fallback SoC. Ensure the new
compatible string matches existing Lemans-compatible formats without
introducing a new naming convention.

The SDHCI controller on Lemans is based on MSM SDHCI v5 IP. Hence,
document the compatible with "qcom,sdhci-msm-v5" as the fallback.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 22d1f50c3fd1..fac5d21abb94 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -49,6 +49,7 @@ properties:
               - qcom,qcs8300-sdhci
               - qcom,qdu1000-sdhci
               - qcom,sar2130p-sdhci
+              - qcom,sa8775p-sdhci
               - qcom,sc7180-sdhci
               - qcom,sc7280-sdhci
               - qcom,sc8280xp-sdhci

-- 
2.51.0


