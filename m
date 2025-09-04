Return-Path: <netdev+bounces-220019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FCAB4434C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F131CC3ECB
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EAB322A15;
	Thu,  4 Sep 2025 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CjiH6mer"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04743090D4
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004009; cv=none; b=o1X1dFyfcdspI0CiNEE0rpWkqIZezl1vwMdVOLfnfaQEYR0Ghfy6hVC8F0KhAj7Z0WJeVU2/obNMUfoKPZj0CXFg6cv0IwsPrOoUp6LTF31zaAQT2K7vakS44y52pUJSyu2GuWm3SR7dn1ko9bQRuVc9/coUJ5Yf0uiyNktjiWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004009; c=relaxed/simple;
	bh=27FWMqFCDTUwpqfJlNc8jFyWyreHhp7HJeUXTzNfhgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ae450LHXD/2+80GUflAWbA2vMO6lopHesji8qcQZ26eLUQ26k8MJdAPPp7IlP5w7CMsYI00HsH1jZlo4Gm2poPuwfItjiYQeriB/LiBdw4Uo8QIsIPDbOQygJ6ZRZZb31X14o5K133TJDsyWs6jUo39XnKu+3XIYZvZW6f3WrKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CjiH6mer; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X8jI008120
	for <netdev@vger.kernel.org>; Thu, 4 Sep 2025 16:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PBnsv8jIHnwgITCzKC089k9TiBqBMjIPeobN0jq972I=; b=CjiH6merx45R7pQw
	E/yXR046uZfUs/pwpo2Tc5v+ssI3QmcYcpwnz7YXR7mhmGKf++mpfXAJAn+/7rxf
	TcRogn7XQZAbpfd3868VtqvPU/Hb4nhk3h8Njt5SUMLjlKpuDC1nwbVsDokj4wYp
	LmAHXkYRzZAoVEylirfVRY+KZFJUrexiBmMJ9O+zXjwRlnKC95791W00q+tB4CBY
	OK+VdmEjRuTmI5VDZ14eEmYwyn1fFz6ppbUUhK7zeonJnPomYRnHykJE4JgAsjoI
	hAhUyXM2/5BK0fm7FjjlzZSBFvsb/xiAKu74cDRHgwSX2c4/hUbYfgxwfifJqny1
	KsfccA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjr5qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 16:40:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32b57b0aa25so1003523a91.0
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 09:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004004; x=1757608804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBnsv8jIHnwgITCzKC089k9TiBqBMjIPeobN0jq972I=;
        b=KBcU1mU/wi6SjgkkUhdL/0gCIwVOMCQCZB2NZTwyPSgVhO8YQv+YoA4t8X9o9gvrIZ
         IsvQHUSEd8/NrJ7Mgo3R3Qemtlx6EU+o09dr7Ap8aemH/z/bMqWOq7GChjDJcnJ+x+Pg
         QBeJOTjhbgngNeHpXfsDkWRMPeHh5BlIbnLbXwV1EQlluu5HxoOPYgk65qLvSqU7+6x1
         +6kv1cOjMsOTL1jt1U647CwzH0HwoSfI92kLbvadXA0u8mmQzdoO57yx8JGWQlqV42Pp
         gzv9p74NpcH8bORu34KtmdruXAR52qgtK+0X9GU7/Atti8VCzKMpJzEVJv2eMZN9bI1j
         3G8w==
X-Forwarded-Encrypted: i=1; AJvYcCW7m7o556RNkcztNeCAZMKoQH8JxIWHMTr9mKBm9Ul8avmjyNd/h8cvIiIo19MEbV+3FIojmhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJb+e86+PYyGeYC6w3wjMO9SJ6p6QARrrYZ9Q5uXX4QdV9LHC
	P1bPuNWY4wbJjm4fMBI6Rvy/CZlYaVR4YLgH9CSY+ZJWPcJnINcrxNMG7C+zFKQt1cJdGV9W5Ks
	T5MKQBJJAmLJcJQKP3GNR966tMwoYEiHGz3wpAkU7D7oKUEF4X5nASIjQZco=
X-Gm-Gg: ASbGncvB3CYf71U9q8rbPF4GWPc/09QB8eNwUexvSiehCpfm5VphXDBTBb4udP5kw8g
	ymb/t90rHOZwxm7avBx8EE6O4IuvBU8WFDRediuL7S9uLYgWYWQyPf3zu7dyz+nZosoHi6N2sZC
	nd/RvbWionvsPzRuMXMUBaLO46zuKVMNFuVG4+Q+L0v1eHVfeEDU9M4bDJG/a1cWoLB+cExX1MS
	CmJ+ARphqwBv/qTYOt5Etkf8Y8uGXBOFXSGnyAUAjtOGjuc44lXlb62mWAXcj+os5tsHVezuPXo
	WydktoL63daOY86Awr2cYiUcky98LE3dcndYiZqD3OJqdiPPiJxdip1iuxvyoeE2rUEK
X-Received: by 2002:a17:90b:2790:b0:327:8c05:f89a with SMTP id 98e67ed59e1d1-32815412e9bmr26511475a91.4.1757004004352;
        Thu, 04 Sep 2025 09:40:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETLbiF5LomcDMPddyH+6eJjA8N15yzTu1sZbM/gaEcwfgyKS7gkdIZOV07jqV2Iqp5IGsQEw==
X-Received: by 2002:a17:90b:2790:b0:327:8c05:f89a with SMTP id 98e67ed59e1d1-32815412e9bmr26511431a91.4.1757004003710;
        Thu, 04 Sep 2025 09:40:03 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:40:03 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:05 +0530
Subject: [PATCH v3 09/14] arm64: dts: qcom: lemans-evk: Enable Iris video
 codec support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-9-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Vikash Garodia <quic_vgarodia@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=865;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=LoxKYvMXT6w2D33TxA4UNVzhnQ1bXXJVAz3sDICoZRg=;
 b=cn9950aoCKHCLBDJ0YQwZZ3VOYSNkIexa6YkQadyz2LdSJ6QJLVSeQY/Et3Cb+sit9kRExVnW
 ja4vkVqHBA6AP1YylmP9vi7DIKXoFyrKl97WqVPitioS8TxvugA4hap
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b9c0e5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=9guL5b7EFFMc6jyTlUkA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: gbGTGvQGJr_zHJ_dBKAEwPPXP5R7OdhI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX5wL+aFYOgWhk
 MKY0D567yBplwwMbPMVYg72WxXCPMyi3oAsGTags8F7KXzcnsZzGkPYjUnGkBOH6hdN7WVPwxjE
 WUhTZE1guxgkmRLyL8Lv4QeGbHTip5mTqF02OESwVCrG6MrfaZj31EGGP3WPPnmVlgdciX+d05x
 5EqtixPmbR+i9niuRkevuVMWbp83J0Cs/H50bvxnx+zvTzSX1uFngcQ7h+ZR4w+IKaPrf6qvk/n
 zK9dOkUA5P7k7ytBlsL0wMcDgTlWR2WeU/RtdKC69DoiX7phtftKyKt9ImGIRe6Y6lD/0sJLPRV
 qjo2o9/R2R6AyC+ObUGgYRDwbNL9TXkDV06RKEop/YnTuOQpH5sSE6+l0j0HN8KsLhq41DR2RQM
 JAv6DTun
X-Proofpoint-ORIG-GUID: gbGTGvQGJr_zHJ_dBKAEwPPXP5R7OdhI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
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
index 1ae3a2a0f6d9..d065528404c0 100644
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


