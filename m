Return-Path: <netdev+bounces-219541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB213B41D62
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A883AEC63
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D20F2FDC20;
	Wed,  3 Sep 2025 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EBhoNwGd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77AE2FD7A5
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900078; cv=none; b=pNmVtJ1GvkHsATTMaRrT/Ow87FKFUbM9VhO4kyjk0qqiAS06UFiau2E1fuyJi/7VuHhHNn+A7y18a0TqPbjrBpdIH3AZSVb2cDrsBKcxQ8hDMfs7mROeVJND35J6B4j3kDsOzuKaSI/EalEtuEEEchU2uZmd9eSJuiYEbs3R/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900078; c=relaxed/simple;
	bh=0FeeJxABc5ZLBzftb3WOCcBqPi06istci6RlquBW6aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NCqxwFb8rVBUrpsD0RrIsDj1zOmSvX6b5hUlMIhjIre06YNzssEkonyPKNQCYuckZQEr6tRCBOZp3UHApe+PWaSH6JOR3pmbIadyK05uFzetCF3FlneXiyxrNvelfwn7ftmY9RFYT1AmMDJgkpFvu/0+lZsAtE/500OETaHE91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EBhoNwGd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF2p2021285
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 11:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+k/0Y2ctRXhmp0hMCcqdw5HbaI//nig8/AJI492yJs4=; b=EBhoNwGdeNEm/i5O
	XNohHffgz8ceHCtPsZCfFNdGqTZnBSxSE6Vi/5VZgWscHa2l1xWYQuZLJruzo0pG
	Z/ChWHny/hDXbsJ6AWbGVlxO13djEf97JuCE9scY6X8E87xspfInRBD+WpczTOgh
	d4FvtP22IyCNYNTUkB8NSvybHLVx7gWJqhTrIthN5c08ihkwhwuryr/UT+S7R7Ri
	1FJyFrMLp7VxOpK+oOs/HEVX38kE5AMj9udZPILCnYOU2oTJfpCL9nc9+F2PerbE
	3Q9wiZChasVYkZC99SIIk8G8zKzQHVtUC4tHoj0w+6xvLs+7wI5h9MnXMETSc8Qh
	KWEIYg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk939ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 11:47:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-324e41e946eso11525671a91.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 04:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900075; x=1757504875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+k/0Y2ctRXhmp0hMCcqdw5HbaI//nig8/AJI492yJs4=;
        b=Y36EXoaMFledsWsl0zlb9NIM+LhzKNghU9fJEzasqLNWhIxoCEESIJypoyqJgYLOnB
         KnRiwnNcATldP9UORrIuWdBX7Jdjkx9WwwBkmUbjwgvBbtEH5njLBhQs8q1XSSshmTQ9
         x7i4XOCJi7C4KtPaNPDjMnl3guEnZJ/YDMHrigBX7BBMh8s2mTlo41Zn8qqlBqzTV5uk
         q/8F3B3TxWzxeJr7EJX3JFJqogRqbQ3hkbPQ36vhm5ndJoBTJuD738V7Z8LYdPzH5w9b
         EmpxZcm5ymvC7wk8aRu1AdnJHYdmq9/yDiJAZNsTG6GxL7j3tQ6LfxSCbFFhPK34j4mS
         PyJA==
X-Forwarded-Encrypted: i=1; AJvYcCWGT4z3C+onuHA8MNVGVnmZomS9ysPNM0j8GZNvky/TeOT76u3VSGEceRQINx761NnSsJskLs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHL8ElDV7oxhXzzCSUdbhFytLZYcCfM/k/C0WFkKNe5QXZeUvf
	nNEFtCxvmfbd/k5dLraggeFVvbo/6r5ISEvtM1adzmvkziUZlvGc40snA1eCrdnixkVZOGM1cjE
	A2ELPtVuqD6tnDpAQPvyxKThhR+9HQ8FIfm2dD3uucDU8cBRoV+l2TB59F1um3sDyfDo=
X-Gm-Gg: ASbGncv5Gjl/RuGEqaAgzoexjGrEFYJTqQ3Nn0vMyfsuHG5Pqi+4W/vZ1QgNQeVTdx4
	lcAbcTHKrM9hHDEus+ceHDJSdjMYUk93iFlmJCboPcfnsLaT/DGYMAfUgN2Ek4wNy7yDTyIR9JD
	9DggOcnktLUdlgkNHbErNPoOdNuGSs8lwCmbm6ESBJHaokyJdY2iS74Tv3pqTGwjdBkmSlkias/
	2ttRP05Ug27r0ONMv1mmCyJGzr35WSjmJlIgZAyLYOGPqpY/23RTFSvHUbJ4EuT+8cLt88wkpB8
	qtjmqwIRC+EBfZQgR8J4neRRB7FtjXaIoKAH4LcIGbfmmkXQ2jXVPTVu9+OA0p7+ZgU6
X-Received: by 2002:a17:90b:4f8d:b0:321:87fa:e1ec with SMTP id 98e67ed59e1d1-328156e3ceamr19078444a91.34.1756900074667;
        Wed, 03 Sep 2025 04:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQLTrOKyrlRq8CDwOnFSbZGxeNwIDBVtnsWGyS6oLgPo7rW4Aif07jO0gOfDmSKfPbR/ilJw==
X-Received: by 2002:a17:90b:4f8d:b0:321:87fa:e1ec with SMTP id 98e67ed59e1d1-328156e3ceamr19078422a91.34.1756900074188;
        Wed, 03 Sep 2025 04:47:54 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:47:53 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:05 +0530
Subject: [PATCH v2 04/13] arm64: dts: qcom: lemans-evk: Add nvmem-layout
 for EEPROM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
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
        Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=958;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=QbgUycV7N8Z7tPsz0CF79+YmFBlWcv+ZbS3a6+NM+KA=;
 b=Gjfy7kML7lZT+3E8qTi21MI1Rf6+I/2U/vEhOXh/btmZHpL7mZGdxI3gE9mqrFW+GjZXeHt5g
 oiAdMlY6GNsAUEFK4+z805a1Asdm7ZvXmmjUaChXVYJkRrbaKVvPYRA
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: Ez-_9OXKpj55AT0-FK2plhagTPVqZ3wT
X-Proofpoint-ORIG-GUID: Ez-_9OXKpj55AT0-FK2plhagTPVqZ3wT
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b82aeb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=JPxAlOPENmrAts8ssvsA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfXxF6fBNZpZuEx
 owm3xnzh6vDhnai+8EGw5zG7iSz372PoSwRjCwwtWjH+N7AgPKKpmhaPxwD5gCpxa4ZS5gHkMzI
 j4Qu3RDn21DZKDxESsfxi3+fy8HeZalqSt+NMrlN23TIdEN2eVBgTSfdgfK3euSBP7kag4va6Dv
 EkekSditgq73YXsI5yZMZLunwhRxN+Cvmg/t1YT4SOd4dXRao3kM8TbxG55EfjP7Sefow8C3FtZ
 VZ5lQltaeAxArKMgV31Ol/eDH/6ne3ZwoJisK2yIQyK+WUyN1iGW3e86gJokZv7K7vIXg7ePDfa
 YLQcHhE01DCsC8AJ5r4XGw7ZKKZBXtKMD3Yh4s5FAOfL7ab4Yx1gXGWq22fPOD1B5nHP6K25On+
 xzZM3xuf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

From: Monish Chunara <quic_mchunara@quicinc.com>

Define the nvmem layout on the EEPROM connected via I2C to enable
structured storage and access to board-specific configuration data,
such as MAC addresses for Ethernet.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 753c5afc3342..c60629c3369e 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -307,6 +307,18 @@ expander3: gpio@3b {
 		gpio-controller;
 		reg = <0x3b>;
 	};
+
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
 };
 
 &mdss0 {

-- 
2.51.0


