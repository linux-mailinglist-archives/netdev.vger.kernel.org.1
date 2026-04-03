Return-Path: <netdev+bounces-275072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ4aBz7Lz2lH0QYAu9opvQ
	(envelope-from <netdev+bounces-275072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:14:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 822543950C2
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 100A2309384B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DF53C6A2D;
	Fri,  3 Apr 2026 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="La/h4ETJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HpElIWKz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D03C554C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225487; cv=none; b=nWPwUCMCg1VXF+W9IQZXXF4cf9NhEJTqGaZ04+wrh9v6JXGzJEj/UHs6kuaHCSYk63VdqsMnMt+g753Qz8/k6h1oz/Dc3OHlAWXC04Nlt//FGvLdKrb3yRu4Fuz+gQpVXlHP1UH9dkReIyTNYh5SsrjzLZkseH+RBNh4PA5bGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225487; c=relaxed/simple;
	bh=LMhCinJ76fg5OoAev6q2bRZG/FqUvfvLkdG7qBbfT1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fkd3paN0Uq9Aj/Xs30bwpDJUNlA7bYywsvgOzyiwYQDN7KRQuuHrHMS1eC5Jkga8x/6QnZr2Ll0xRehbXV3EtnxIpAKeDAga6ikT8r+y6eylKUHeh1HlYd0aXIPZjk6Sy/15c3kFXt9os+Osvb5TbmAB+fBf6KPX2rPxa8Hitx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=La/h4ETJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HpElIWKz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6337cpr42707131
	for <netdev@vger.kernel.org>; Fri, 3 Apr 2026 14:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FKvG8YmivZ7s6G82R4mIgEk3yQGCPIAQZUIiegjm3x8=; b=La/h4ETJxN02VYYS
	MZ1WaUYXmqAXpdXo3QTCUDGp4k6zkowjQJACvnWQEY6aORmKJzjZH6VIa8FRKEso
	GtCeLxvgPgMNC/K1+q0SEBPas2d6qLV7bO44QGHJB+ol5JlbyMiC1hdiOvt1E15O
	OXZFYLngw3zHo2id3buxG4E3mL9IS3BWNOaTSD2oLazqfLP8NZn8x0F3d1BywT2H
	uB7Pq3K6pKBApMn+KCx1u2hTRf9HFkEHFVjjDAFR8HnncYvV7e5lctEHO/GU8n16
	DWqdyVyw8gY2Rcgmgn8y84+aaPd61viiQFYIiMOE1w1endYHJ0YB2Msh/rweO1IM
	sU3TKw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9yfjjp7a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 14:11:24 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-60270015488so2922016137.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775225484; x=1775830284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKvG8YmivZ7s6G82R4mIgEk3yQGCPIAQZUIiegjm3x8=;
        b=HpElIWKz5L+V8349eczuuQp6ooLlGASameowVfYYGX+ZSHxReL/JXlEVGiAX6zZBNB
         F1mRjT/r7YAyZpgxVMa1RUTiAh88EGyRtghvXKaAUoBHT0RSAvFbY0LWC2VL29zbBotV
         +7xLjGnYVeSwvFuFdbt7JxgmOdbnRQz00TrF8zq1PaxTeaAAy8iieEDw9S19jfqHrldd
         bzkyhhpdvGKZQeSX9jVvho3uCYZ6uDEA5Vk9NZ4XMBCn9V3W72yl3bDmwJ0eOrXecDwI
         d91ojaw+8foL4Q414s44CBPSbJMEPdLg2hW+mCPHatbLrmLUFhWDUbOWBkRzYByvxwvP
         daHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775225484; x=1775830284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FKvG8YmivZ7s6G82R4mIgEk3yQGCPIAQZUIiegjm3x8=;
        b=TDIDenO8oAwTfy8FnMTDF3MWcpIyofChRoSs2rcx5MvAFRwJQey00R1USVi1z84onZ
         AuBbQ220GbWTb7FiS9/NKHBb5pkZgOXnd9elAAQ6GQMPKGWsgEVqGhqEJB3CJ+NN3mde
         slVl58OV6jkqBN8SdGiYbcNvA5H0hslUQ8t4iKsDFG/Wtfu+/WVLRFK/PtnQjlyYFfgb
         6WH1zrhv5l0AXGrkokxRqfegkK2aezKVro0GHZ1LwdbXmYqrY84Z2n8WsBKVfcIDgIgF
         JitECtrR6ZGTGZazteSvEZdumASjnd4BQS0jB+1h0gnJgxGgr13BPtqEv4TXvCyy8dC2
         kjxA==
X-Forwarded-Encrypted: i=1; AJvYcCWAZeTnEAqIvtuCa02NXkWQtAOuvG0ffGQFShSOHErf9ruJgaeVq5YLUCSqKlQh+GEzrGoq2R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAcu+5kaKRCmsHeb5LQAgHEwEJa88pFiLsSHuCva18xAPY7N2E
	ZDCCYYFtDZ/tT0Pj13vo4BalJTWHBa8s0CNKlhqRhjsTFJw/sInA0oi8P8CDrAJKJVWUkgfZNKo
	L2pRaVUc3GAnLlkx7pNl3ljFzjwuvqMsQNMSzFhgRqQmHcgO1zuy6np6sVk4=
X-Gm-Gg: AeBDieswWxKiGaMyrWG+WSO+fCzR+iW9ymPmcgmyGJ3QXgHvWdMRK45Ur18jYjU3N8k
	1S8Du5LeLDWSpWxpilN4LN+Qlo8yFwk1zZeskmhuX7TmSNP9XPfsofEns1q1ppy1qyMEOjP1S9M
	b3jAL/EFVfBAUjmOxog/2+KC3vz6W7m+Vv78jE/MJFfn84utaav1y9bLed5ENQvbZQEbrzr6yOR
	I41OMUsA2TamTabE4AUSpcB97UET3u6IR0tykSp5QxePaqVFwoZir38SVK9/CGKrd+n+/U3p4aE
	9g4NgtAbSLwN6lpXfh1n7lB93Ow/8laTz+A+WSrn01mkJw4k+HbE0sWay88HjUi0D+oVja9KNKB
	6/jT2jOnzwmcr47BwgjbFTT071q0eWZIz4XWWomawA4OMpSYCvZU=
X-Received: by 2002:a05:6102:943:b0:5ff:ed38:1889 with SMTP id ada2fe7eead31-605a4e176f9mr1349098137.10.1775225483458;
        Fri, 03 Apr 2026 07:11:23 -0700 (PDT)
X-Received: by 2002:a05:6102:943:b0:5ff:ed38:1889 with SMTP id ada2fe7eead31-605a4e176f9mr1349078137.10.1775225482968;
        Fri, 03 Apr 2026 07:11:22 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:129d:59e8:f7c9:47ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899d1b19esm30127315e9.6.2026.04.03.07.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:11:21 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 03 Apr 2026 16:10:51 +0200
Subject: [PATCH 3/7] dt-bindings: clock: qcom: Add Nord Global Clock
 Controller
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-nord-clks-v1-3-018af14979fd@oss.qualcomm.com>
References: <20260403-nord-clks-v1-0-018af14979fd@oss.qualcomm.com>
In-Reply-To: <20260403-nord-clks-v1-0-018af14979fd@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=24556;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=q0JzRMLaHw0AWBgo+dd9NT2AJZ+MW7NNNrrkUZJZukI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpz8p8sq5n+KMZ0/tGvlytBM7mYrlqsD+LQLvGP
 e3cb21SJwaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac/KfAAKCRAFnS7L/zaE
 w3P3EACn7ABU/7dmRUNGWDyZISGPCsv+8IvNx1S1wGCPtQ3ic2YWQajE+L4u4m9YFhRVOmslD5o
 NeRuWr1z1LRsaNQPhRhE/oDDf7ocOKcND1e8VXCGejnDm0w6MJQiSMTXDHlovVYIiwP4hzs4OU4
 qZMnPnLwl73nRQ6ZsXq4UOjvw2tD2vZaaxfJcvUmPIzffr3y67MKT5OJ7zYYMHyAIcLZWCCr6V5
 1uwW0IZfnfjFj6Hhxq1tfUZQbJTV6voSNAgEwYT1nBQmgIRVZEEowMr+i0ld1CXT6uP/P2CQdYq
 EbVkVy9KgeMrupIcVur9R9qVb+DmWsE+bKjQOKGxIGuDVXGEJCRTPN80clFW2SY6QWGERrT7fw1
 8ZOEE6FVpMDuGoCfM+SapZyhu1g4baByuoViivBj9fSENhynAl9S28QVxJ898wsVUx26zSB2nnx
 /wuOQKl4itbY4DlqstdYkkCprnq5uBLSw1L5wA5bYS1Cc8z9tqelTtyYlXsGDqkrO7QQi5BWlz/
 4TSwqobFMzeNPQ07dTjLTHrFVllBj7xNtPLM9LjzlGO/26jp66/3y/fNGSP0imbBbfQ9/JGxeJw
 SwVudCnCzrVbPzlE5qw2V9Qh7pPFO79Y23g8sWCQS50lVuXkpsQh+aacKdQE9PvWBtgDJOvrAMU
 PpvSbnnOPjJLQ0Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: 89W-AROiQrJOcSIy-NyGYp_rnu-nicyQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEyNiBTYWx0ZWRfX3XhRVX0rKvh6
 5SVAf19BIjSrlE6AGxUOqn2rrSE8WY7mwAeazsjPwmb747kWy+aBhpWtEcOghV9xVo88S4s7Jnl
 EihzMPPWL2FqO5BpwjFNqSkoMiCbjsMhsQp30z47GxUzstx4i/YxioJ1meClYqKnyk7E1MK6Jdb
 Fb8Jm0g5wgn2V1Ei6rsCWJ9hIrAL0mB1vPXP6cZQWwGomNR37GCvM2e6QI26n4IZLB9dwCb2h/z
 M1VGX+sr9DZ+jcQussozoJlg0IydORFU3wKvP7a5Fr3ymQP0i1ZkrY+EBjJiWp028MctG8I5ee8
 Mye3bRTfHTaQ4kXV6XKRFwQkZB5qgH2b+sbbNwfbGDZS+9aHqI8cXqAa5U+53ypUFxQAqD/KmY2
 pVU7W3yWtTYLAZ4Q9PHmtfUASCcfbkP1TkJEwU1Bh4OCa1+tA24ldu3Kl4i9wk+9nbagGOnQ9gt
 XD0ybm0lRNFVtgYTZow==
X-Authority-Analysis: v=2.4 cv=OrpCCi/t c=1 sm=1 tr=0 ts=69cfca8c cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=DpCVWlyd2gz3rNZ2myMA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: 89W-AROiQrJOcSIy-NyGYp_rnu-nicyQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030126
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275072-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,oss.qualcomm.com,quicinc.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 822543950C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Taniya Das <taniya.das@oss.qualcomm.com>

Add device tree bindings for the global clock controller on Qualcomm
Nord platform. The global clock controller on Nord SoC is divided into
multiple clock controllers (GCC,SE_GCC,NE_GCC and NW_GCC). Add each of
the bindings to define the clock controllers.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 .../devicetree/bindings/clock/qcom,nord-gcc.yaml   |  58 ++++++++
 .../devicetree/bindings/clock/qcom,nord-negcc.yaml |  60 +++++++++
 .../devicetree/bindings/clock/qcom,nord-nwgcc.yaml |  55 ++++++++
 include/dt-bindings/clock/qcom,nord-gcc.h          | 147 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,nord-negcc.h        | 124 +++++++++++++++++
 include/dt-bindings/clock/qcom,nord-nwgcc.h        |  69 ++++++++++
 include/dt-bindings/clock/qcom,nord-segcc.h        |  98 ++++++++++++++
 7 files changed, 611 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,nord-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,nord-gcc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e35136722a931ef76f80d36ad2bc07fe618490d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,nord-gcc.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,nord-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on Nord SoC
+
+maintainers:
+  - Taniya Das <taniya.das@oss.qualcomm.com>
+
+description: |
+  Qualcomm global clock control module provides the clocks, resets and power
+  domains on Nord SoC.
+
+  See also: include/dt-bindings/clock/qcom,nord-gcc.h
+
+properties:
+  compatible:
+    const: qcom,nord-gcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Sleep clock source
+      - description: PCIE A Pipe clock source
+      - description: PCIE B Pipe clock source
+      - description: PCIE C Pipe clock source
+      - description: PCIE D Pipe clock source
+
+required:
+  - compatible
+  - clocks
+  - '#power-domain-cells'
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@100000 {
+      compatible = "qcom,nord-gcc";
+      reg = <0x00100000 0x1f4200>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&sleep_clk>,
+               <&pcie_a_pipe_clk>,
+               <&pcie_b_pipe_clk>,
+               <&pcie_c_pipe_clk>,
+               <&pcie_d_pipe_clk>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/clock/qcom,nord-negcc.yaml b/Documentation/devicetree/bindings/clock/qcom,nord-negcc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..749389f65ee14999b3a195256e34f486e9aace1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,nord-negcc.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,nord-negcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global North East Clock & Reset Controller on Nord SoC
+
+maintainers:
+  - Taniya Das <taniya.das@oss.qualcomm.com>
+
+description: |
+  Qualcomm global clock control (NE) module provides the clocks, resets
+  and power domains on Nord SoC.
+
+  See also: include/dt-bindings/clock/qcom,nord-negcc.h
+
+properties:
+  compatible:
+    const: qcom,nord-negcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Sleep clock source
+      - description: UFS Phy Rx symbol 0 clock source
+      - description: UFS Phy Rx symbol 1 clock source
+      - description: UFS Phy Tx symbol 0 clock source
+      - description: USB3 Phy sec wrapper pipe clock source
+      - description: USB3 Phy wrapper pipe clock source
+
+required:
+  - compatible
+  - clocks
+  - '#power-domain-cells'
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@8900000 {
+      compatible = "qcom,nord-negcc";
+      reg = <0x08900000 0xf4200>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&sleep_clk>,
+               <&ufs_phy_rx_symbol_0_clk>,
+               <&ufs_phy_rx_symbol_1_clk>,
+               <&ufs_phy_tx_symbol_0_clk>,
+               <&usb3_phy_sec_pipe_clk>,
+               <&usb3_phy_pipe_clk>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/clock/qcom,nord-nwgcc.yaml b/Documentation/devicetree/bindings/clock/qcom,nord-nwgcc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ce33f966bdfdf0b0ccebc40944e3d961c79c6fe0
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,nord-nwgcc.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,nord-nwgcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global North West and South East  Clock & Reset Controller
+       on Nord SoC
+
+maintainers:
+  - Taniya Das <taniya.das@oss.qualcomm.com>
+
+description: |
+  Qualcomm global clock control (NW, SE) module provides the clocks, resets
+  and power domains on Nord SoC.
+
+  See also:
+    include/dt-bindings/clock/qcom,nord-nwgcc.h
+    include/dt-bindings/clock/qcom,nord-segcc.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,nord-nwgcc
+      - qcom,nord-segcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Sleep clock source
+
+required:
+  - compatible
+  - clocks
+  - '#power-domain-cells'
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@8b00000 {
+      compatible = "qcom,nord-nwgcc";
+      reg = <0x08b00000 0xf4200>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&sleep_clk>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/qcom,nord-gcc.h b/include/dt-bindings/clock/qcom,nord-gcc.h
new file mode 100644
index 0000000000000000000000000000000000000000..8fbde162c8598d75b42136350fb23b33c29c339f
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,nord-gcc.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_NORD_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_NORD_H
+
+/* GCC clocks */
+#define GCC_BOOT_ROM_AHB_CLK					0
+#define GCC_GP1_CLK						1
+#define GCC_GP1_CLK_SRC						2
+#define GCC_GP2_CLK						3
+#define GCC_GP2_CLK_SRC						4
+#define GCC_GPLL0						5
+#define GCC_GPLL0_OUT_EVEN					6
+#define GCC_MMU_0_TCU_VOTE_CLK					7
+#define GCC_PCIE_A_AUX_CLK					8
+#define GCC_PCIE_A_AUX_CLK_SRC					9
+#define GCC_PCIE_A_CFG_AHB_CLK					10
+#define GCC_PCIE_A_DTI_QTC_CLK					11
+#define GCC_PCIE_A_MSTR_AXI_CLK					12
+#define GCC_PCIE_A_PHY_AUX_CLK					13
+#define GCC_PCIE_A_PHY_AUX_CLK_SRC				14
+#define GCC_PCIE_A_PHY_RCHNG_CLK				15
+#define GCC_PCIE_A_PHY_RCHNG_CLK_SRC				16
+#define GCC_PCIE_A_PIPE_CLK					17
+#define GCC_PCIE_A_PIPE_CLK_SRC					18
+#define GCC_PCIE_A_SLV_AXI_CLK					19
+#define GCC_PCIE_A_SLV_Q2A_AXI_CLK				20
+#define GCC_PCIE_B_AUX_CLK					21
+#define GCC_PCIE_B_AUX_CLK_SRC					22
+#define GCC_PCIE_B_CFG_AHB_CLK					23
+#define GCC_PCIE_B_DTI_QTC_CLK					24
+#define GCC_PCIE_B_MSTR_AXI_CLK					25
+#define GCC_PCIE_B_PHY_AUX_CLK					26
+#define GCC_PCIE_B_PHY_AUX_CLK_SRC				27
+#define GCC_PCIE_B_PHY_RCHNG_CLK				28
+#define GCC_PCIE_B_PHY_RCHNG_CLK_SRC				29
+#define GCC_PCIE_B_PIPE_CLK					30
+#define GCC_PCIE_B_PIPE_CLK_SRC					31
+#define GCC_PCIE_B_SLV_AXI_CLK					32
+#define GCC_PCIE_B_SLV_Q2A_AXI_CLK				33
+#define GCC_PCIE_C_AUX_CLK					34
+#define GCC_PCIE_C_AUX_CLK_SRC					35
+#define GCC_PCIE_C_CFG_AHB_CLK					36
+#define GCC_PCIE_C_DTI_QTC_CLK					37
+#define GCC_PCIE_C_MSTR_AXI_CLK					38
+#define GCC_PCIE_C_PHY_AUX_CLK					39
+#define GCC_PCIE_C_PHY_AUX_CLK_SRC				40
+#define GCC_PCIE_C_PHY_RCHNG_CLK				41
+#define GCC_PCIE_C_PHY_RCHNG_CLK_SRC				42
+#define GCC_PCIE_C_PIPE_CLK					43
+#define GCC_PCIE_C_PIPE_CLK_SRC					44
+#define GCC_PCIE_C_SLV_AXI_CLK					45
+#define GCC_PCIE_C_SLV_Q2A_AXI_CLK				46
+#define GCC_PCIE_D_AUX_CLK					47
+#define GCC_PCIE_D_AUX_CLK_SRC					48
+#define GCC_PCIE_D_CFG_AHB_CLK					49
+#define GCC_PCIE_D_DTI_QTC_CLK					50
+#define GCC_PCIE_D_MSTR_AXI_CLK					51
+#define GCC_PCIE_D_PHY_AUX_CLK					52
+#define GCC_PCIE_D_PHY_AUX_CLK_SRC				53
+#define GCC_PCIE_D_PHY_RCHNG_CLK				54
+#define GCC_PCIE_D_PHY_RCHNG_CLK_SRC				55
+#define GCC_PCIE_D_PIPE_CLK					56
+#define GCC_PCIE_D_PIPE_CLK_SRC					57
+#define GCC_PCIE_D_SLV_AXI_CLK					58
+#define GCC_PCIE_D_SLV_Q2A_AXI_CLK				59
+#define GCC_PCIE_LINK_AHB_CLK					60
+#define GCC_PCIE_LINK_XO_CLK					61
+#define GCC_PCIE_NOC_ASYNC_BRIDGE_CLK				62
+#define GCC_PCIE_NOC_CNOC_SF_QX_CLK				63
+#define GCC_PCIE_NOC_M_CFG_CLK					64
+#define GCC_PCIE_NOC_M_PDB_CLK					65
+#define GCC_PCIE_NOC_MSTR_AXI_CLK				66
+#define GCC_PCIE_NOC_PWRCTL_CLK					67
+#define GCC_PCIE_NOC_QOSGEN_EXTREF_CLK				68
+#define GCC_PCIE_NOC_REFGEN_CLK					69
+#define GCC_PCIE_NOC_REFGEN_CLK_SRC				70
+#define GCC_PCIE_NOC_S_CFG_CLK					71
+#define GCC_PCIE_NOC_S_PDB_CLK					72
+#define GCC_PCIE_NOC_SAFETY_CLK					73
+#define GCC_PCIE_NOC_SAFETY_CLK_SRC				74
+#define GCC_PCIE_NOC_SLAVE_AXI_CLK				75
+#define GCC_PCIE_NOC_TSCTR_CLK					76
+#define GCC_PCIE_NOC_XO_CLK					77
+#define GCC_PDM2_CLK						78
+#define GCC_PDM2_CLK_SRC					79
+#define GCC_PDM_AHB_CLK						80
+#define GCC_PDM_XO4_CLK						81
+#define GCC_QUPV3_WRAP3_CORE_2X_CLK				82
+#define GCC_QUPV3_WRAP3_CORE_CLK				83
+#define GCC_QUPV3_WRAP3_M_CLK					84
+#define GCC_QUPV3_WRAP3_QSPI_REF_CLK				85
+#define GCC_QUPV3_WRAP3_QSPI_REF_CLK_SRC			86
+#define GCC_QUPV3_WRAP3_S0_CLK					87
+#define GCC_QUPV3_WRAP3_S0_CLK_SRC				88
+#define GCC_QUPV3_WRAP3_S_AHB_CLK				89
+#define GCC_SMMU_PCIE_QTC_VOTE_CLK				90
+
+/* GCC power domains */
+#define GCC_PCIE_A_GDSC						0
+#define GCC_PCIE_A_PHY_GDSC					1
+#define GCC_PCIE_B_GDSC						2
+#define GCC_PCIE_B_PHY_GDSC					3
+#define GCC_PCIE_C_GDSC						4
+#define GCC_PCIE_C_PHY_GDSC					5
+#define GCC_PCIE_D_GDSC						6
+#define GCC_PCIE_D_PHY_GDSC					7
+#define GCC_PCIE_NOC_GDSC					8
+
+/* GCC resets */
+#define GCC_PCIE_A_BCR						0
+#define GCC_PCIE_A_LINK_DOWN_BCR				1
+#define GCC_PCIE_A_NOCSR_COM_PHY_BCR				2
+#define GCC_PCIE_A_PHY_BCR					3
+#define GCC_PCIE_A_PHY_CFG_AHB_BCR				4
+#define GCC_PCIE_A_PHY_COM_BCR					5
+#define GCC_PCIE_A_PHY_NOCSR_COM_PHY_BCR			6
+#define GCC_PCIE_B_BCR						7
+#define GCC_PCIE_B_LINK_DOWN_BCR				8
+#define GCC_PCIE_B_NOCSR_COM_PHY_BCR				9
+#define GCC_PCIE_B_PHY_BCR					10
+#define GCC_PCIE_B_PHY_CFG_AHB_BCR				11
+#define GCC_PCIE_B_PHY_COM_BCR					12
+#define GCC_PCIE_B_PHY_NOCSR_COM_PHY_BCR			13
+#define GCC_PCIE_C_BCR						14
+#define GCC_PCIE_C_LINK_DOWN_BCR				15
+#define GCC_PCIE_C_NOCSR_COM_PHY_BCR				16
+#define GCC_PCIE_C_PHY_BCR					17
+#define GCC_PCIE_C_PHY_CFG_AHB_BCR				18
+#define GCC_PCIE_C_PHY_COM_BCR					19
+#define GCC_PCIE_C_PHY_NOCSR_COM_PHY_BCR			20
+#define GCC_PCIE_D_BCR						21
+#define GCC_PCIE_D_LINK_DOWN_BCR				22
+#define GCC_PCIE_D_NOCSR_COM_PHY_BCR				23
+#define GCC_PCIE_D_PHY_BCR					24
+#define GCC_PCIE_D_PHY_CFG_AHB_BCR				25
+#define GCC_PCIE_D_PHY_COM_BCR					26
+#define GCC_PCIE_D_PHY_NOCSR_COM_PHY_BCR			27
+#define GCC_PCIE_NOC_BCR					28
+#define GCC_PDM_BCR						29
+#define GCC_QUPV3_WRAPPER_3_BCR					30
+#define GCC_TCSR_PCIE_BCR					31
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,nord-negcc.h b/include/dt-bindings/clock/qcom,nord-negcc.h
new file mode 100644
index 0000000000000000000000000000000000000000..95f333d8e1aa7cf1e386b6926380b2c853f7cf43
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,nord-negcc.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_NE_GCC_NORD_H
+#define _DT_BINDINGS_CLK_QCOM_NE_GCC_NORD_H
+
+/* NE_GCC clocks */
+#define NE_GCC_AGGRE_NOC_UFS_PHY_AXI_CLK			0
+#define NE_GCC_AGGRE_NOC_USB2_AXI_CLK				1
+#define NE_GCC_AGGRE_NOC_USB3_PRIM_AXI_CLK			2
+#define NE_GCC_AGGRE_NOC_USB3_SEC_AXI_CLK			3
+#define NE_GCC_AHB2PHY_CLK					4
+#define NE_GCC_CNOC_USB2_AXI_CLK				5
+#define NE_GCC_CNOC_USB3_PRIM_AXI_CLK				6
+#define NE_GCC_CNOC_USB3_SEC_AXI_CLK				7
+#define NE_GCC_FRQ_MEASURE_REF_CLK				8
+#define NE_GCC_GP1_CLK						9
+#define NE_GCC_GP1_CLK_SRC					10
+#define NE_GCC_GP2_CLK						11
+#define NE_GCC_GP2_CLK_SRC					12
+#define NE_GCC_GPLL0						13
+#define NE_GCC_GPLL0_OUT_EVEN					14
+#define NE_GCC_GPLL2						15
+#define NE_GCC_GPU_2_CFG_CLK					16
+#define NE_GCC_GPU_2_GPLL0_CLK_SRC				17
+#define NE_GCC_GPU_2_GPLL0_DIV_CLK_SRC				18
+#define NE_GCC_GPU_2_HSCNOC_GFX_CLK				19
+#define NE_GCC_GPU_2_SMMU_VOTE_CLK				20
+#define NE_GCC_QUPV3_WRAP2_CORE_2X_CLK				21
+#define NE_GCC_QUPV3_WRAP2_CORE_CLK				22
+#define NE_GCC_QUPV3_WRAP2_M_AHB_CLK				23
+#define NE_GCC_QUPV3_WRAP2_S0_CLK				24
+#define NE_GCC_QUPV3_WRAP2_S0_CLK_SRC				25
+#define NE_GCC_QUPV3_WRAP2_S1_CLK				26
+#define NE_GCC_QUPV3_WRAP2_S1_CLK_SRC				27
+#define NE_GCC_QUPV3_WRAP2_S2_CLK				28
+#define NE_GCC_QUPV3_WRAP2_S2_CLK_SRC				29
+#define NE_GCC_QUPV3_WRAP2_S3_CLK				30
+#define NE_GCC_QUPV3_WRAP2_S3_CLK_SRC				31
+#define NE_GCC_QUPV3_WRAP2_S4_CLK				32
+#define NE_GCC_QUPV3_WRAP2_S4_CLK_SRC				33
+#define NE_GCC_QUPV3_WRAP2_S5_CLK				34
+#define NE_GCC_QUPV3_WRAP2_S5_CLK_SRC				35
+#define NE_GCC_QUPV3_WRAP2_S6_CLK				36
+#define NE_GCC_QUPV3_WRAP2_S6_CLK_SRC				37
+#define NE_GCC_QUPV3_WRAP2_S_AHB_CLK				38
+#define NE_GCC_SDCC4_APPS_CLK					39
+#define NE_GCC_SDCC4_APPS_CLK_SRC				40
+#define NE_GCC_SDCC4_AXI_CLK					41
+#define NE_GCC_UFS_PHY_AHB_CLK					42
+#define NE_GCC_UFS_PHY_AXI_CLK					43
+#define NE_GCC_UFS_PHY_AXI_CLK_SRC				44
+#define NE_GCC_UFS_PHY_ICE_CORE_CLK				45
+#define NE_GCC_UFS_PHY_ICE_CORE_CLK_SRC				46
+#define NE_GCC_UFS_PHY_PHY_AUX_CLK				47
+#define NE_GCC_UFS_PHY_PHY_AUX_CLK_SRC				48
+#define NE_GCC_UFS_PHY_RX_SYMBOL_0_CLK				49
+#define NE_GCC_UFS_PHY_RX_SYMBOL_0_CLK_SRC			50
+#define NE_GCC_UFS_PHY_RX_SYMBOL_1_CLK				51
+#define NE_GCC_UFS_PHY_RX_SYMBOL_1_CLK_SRC			52
+#define NE_GCC_UFS_PHY_TX_SYMBOL_0_CLK				53
+#define NE_GCC_UFS_PHY_TX_SYMBOL_0_CLK_SRC			54
+#define NE_GCC_UFS_PHY_UNIPRO_CORE_CLK				55
+#define NE_GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC			56
+#define NE_GCC_USB20_MASTER_CLK					57
+#define NE_GCC_USB20_MASTER_CLK_SRC				58
+#define NE_GCC_USB20_MOCK_UTMI_CLK				59
+#define NE_GCC_USB20_MOCK_UTMI_CLK_SRC				60
+#define NE_GCC_USB20_MOCK_UTMI_POSTDIV_CLK_SRC			61
+#define NE_GCC_USB20_SLEEP_CLK					62
+#define NE_GCC_USB31_PRIM_ATB_CLK				63
+#define NE_GCC_USB31_PRIM_EUD_AHB_CLK				64
+#define NE_GCC_USB31_PRIM_MASTER_CLK				65
+#define NE_GCC_USB31_PRIM_MASTER_CLK_SRC			66
+#define NE_GCC_USB31_PRIM_MOCK_UTMI_CLK				67
+#define NE_GCC_USB31_PRIM_MOCK_UTMI_CLK_SRC			68
+#define NE_GCC_USB31_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC		69
+#define NE_GCC_USB31_PRIM_SLEEP_CLK				70
+#define NE_GCC_USB31_SEC_ATB_CLK				71
+#define NE_GCC_USB31_SEC_EUD_AHB_CLK				72
+#define NE_GCC_USB31_SEC_MASTER_CLK				73
+#define NE_GCC_USB31_SEC_MASTER_CLK_SRC				74
+#define NE_GCC_USB31_SEC_MOCK_UTMI_CLK				75
+#define NE_GCC_USB31_SEC_MOCK_UTMI_CLK_SRC			76
+#define NE_GCC_USB31_SEC_MOCK_UTMI_POSTDIV_CLK_SRC		77
+#define NE_GCC_USB31_SEC_SLEEP_CLK				78
+#define NE_GCC_USB3_PRIM_PHY_AUX_CLK				79
+#define NE_GCC_USB3_PRIM_PHY_AUX_CLK_SRC			80
+#define NE_GCC_USB3_PRIM_PHY_COM_AUX_CLK			81
+#define NE_GCC_USB3_PRIM_PHY_PIPE_CLK				82
+#define NE_GCC_USB3_PRIM_PHY_PIPE_CLK_SRC			83
+#define NE_GCC_USB3_SEC_PHY_AUX_CLK				84
+#define NE_GCC_USB3_SEC_PHY_AUX_CLK_SRC				85
+#define NE_GCC_USB3_SEC_PHY_COM_AUX_CLK				86
+#define NE_GCC_USB3_SEC_PHY_PIPE_CLK				87
+#define NE_GCC_USB3_SEC_PHY_PIPE_CLK_SRC			88
+
+/* NE_GCC power domains */
+#define NE_GCC_UFS_MEM_PHY_GDSC					0
+#define NE_GCC_UFS_PHY_GDSC					1
+#define NE_GCC_USB20_PRIM_GDSC					2
+#define NE_GCC_USB31_PRIM_GDSC					3
+#define NE_GCC_USB31_SEC_GDSC					4
+#define NE_GCC_USB3_PHY_GDSC					5
+#define NE_GCC_USB3_SEC_PHY_GDSC				6
+
+/* NE_GCC resets */
+#define NE_GCC_GPU_2_BCR					0
+#define NE_GCC_QUPV3_WRAPPER_2_BCR				1
+#define NE_GCC_SDCC4_BCR					2
+#define NE_GCC_UFS_PHY_BCR					3
+#define NE_GCC_USB20_PRIM_BCR					4
+#define NE_GCC_USB31_PRIM_BCR					5
+#define NE_GCC_USB31_SEC_BCR					6
+#define NE_GCC_USB3_DP_PHY_PRIM_BCR				7
+#define NE_GCC_USB3_DP_PHY_SEC_BCR				8
+#define NE_GCC_USB3_PHY_PRIM_BCR				9
+#define NE_GCC_USB3_PHY_SEC_BCR					10
+#define NE_GCC_USB3PHY_PHY_PRIM_BCR				11
+#define NE_GCC_USB3PHY_PHY_SEC_BCR				12
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,nord-nwgcc.h b/include/dt-bindings/clock/qcom,nord-nwgcc.h
new file mode 100644
index 0000000000000000000000000000000000000000..b6253dd2aa85a3152f99447a60a6f8a3e85d8f3c
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,nord-nwgcc.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_NW_GCC_NORD_H
+#define _DT_BINDINGS_CLK_QCOM_NW_GCC_NORD_H
+
+/* NW_GCC clocks */
+#define NW_GCC_ACMU_MUX_CLK					0
+#define NW_GCC_CAMERA_AHB_CLK					1
+#define NW_GCC_CAMERA_HF_AXI_CLK				2
+#define NW_GCC_CAMERA_SF_AXI_CLK				3
+#define NW_GCC_CAMERA_TRIG_CLK					4
+#define NW_GCC_CAMERA_XO_CLK					5
+#define NW_GCC_DISP_0_AHB_CLK					6
+#define NW_GCC_DISP_0_HF_AXI_CLK				7
+#define NW_GCC_DISP_0_TRIG_CLK					8
+#define NW_GCC_DISP_1_AHB_CLK					9
+#define NW_GCC_DISP_1_HF_AXI_CLK				10
+#define NW_GCC_DISP_1_TRIG_CLK					11
+#define NW_GCC_DPRX0_AXI_HF_CLK					12
+#define NW_GCC_DPRX0_CFG_AHB_CLK				13
+#define NW_GCC_DPRX1_AXI_HF_CLK					14
+#define NW_GCC_DPRX1_CFG_AHB_CLK				15
+#define NW_GCC_EVA_AHB_CLK					16
+#define NW_GCC_EVA_AXI0_CLK					17
+#define NW_GCC_EVA_AXI0C_CLK					18
+#define NW_GCC_EVA_TRIG_CLK					19
+#define NW_GCC_EVA_XO_CLK					20
+#define NW_GCC_FRQ_MEASURE_REF_CLK				21
+#define NW_GCC_GP1_CLK						22
+#define NW_GCC_GP1_CLK_SRC					23
+#define NW_GCC_GP2_CLK						24
+#define NW_GCC_GP2_CLK_SRC					25
+#define NW_GCC_GPLL0						26
+#define NW_GCC_GPLL0_OUT_EVEN					27
+#define NW_GCC_GPU_2_CFG_AHB_CLK				28
+#define NW_GCC_GPU_2_GPLL0_CLK_SRC				29
+#define NW_GCC_GPU_2_GPLL0_DIV_CLK_SRC				30
+#define NW_GCC_GPU_2_HSCNOC_GFX_CLK				31
+#define NW_GCC_GPU_CFG_AHB_CLK					32
+#define NW_GCC_GPU_GPLL0_CLK_SRC				33
+#define NW_GCC_GPU_GPLL0_DIV_CLK_SRC				34
+#define NW_GCC_GPU_HSCNOC_GFX_CLK				35
+#define NW_GCC_GPU_SMMU_VOTE_CLK				36
+#define NW_GCC_HSCNOC_GPU_2_AXI_CLK				37
+#define NW_GCC_HSCNOC_GPU_AXI_CLK				38
+#define NW_GCC_MMU_1_TCU_VOTE_CLK				39
+#define NW_GCC_VIDEO_AHB_CLK					40
+#define NW_GCC_VIDEO_AXI0_CLK					41
+#define NW_GCC_VIDEO_AXI0C_CLK					42
+#define NW_GCC_VIDEO_AXI1_CLK					43
+#define NW_GCC_VIDEO_XO_CLK					44
+
+/* NW_GCC power domains */
+
+/* NW_GCC resets */
+#define NW_GCC_CAMERA_BCR					0
+#define NW_GCC_DISPLAY_0_BCR					1
+#define NW_GCC_DISPLAY_1_BCR					2
+#define NW_GCC_DPRX0_BCR					3
+#define NW_GCC_DPRX1_BCR					4
+#define NW_GCC_EVA_BCR						5
+#define NW_GCC_GPU_2_BCR					6
+#define NW_GCC_GPU_BCR						7
+#define NW_GCC_VIDEO_BCR					8
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,nord-segcc.h b/include/dt-bindings/clock/qcom,nord-segcc.h
new file mode 100644
index 0000000000000000000000000000000000000000..f0f7422af692d05417d126c1011a22faf3bdc611
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,nord-segcc.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_SE_GCC_NORD_H
+#define _DT_BINDINGS_CLK_QCOM_SE_GCC_NORD_H
+
+/* SE_GCC clocks */
+#define SE_GCC_EEE_EMAC0_CLK					0
+#define SE_GCC_EEE_EMAC0_CLK_SRC				1
+#define SE_GCC_EEE_EMAC1_CLK					2
+#define SE_GCC_EEE_EMAC1_CLK_SRC				3
+#define SE_GCC_EMAC0_AXI_CLK					4
+#define SE_GCC_EMAC0_CC_SGMIIPHY_RX_CLK				5
+#define SE_GCC_EMAC0_CC_SGMIIPHY_TX_CLK				6
+#define SE_GCC_EMAC0_PHY_AUX_CLK				7
+#define SE_GCC_EMAC0_PHY_AUX_CLK_SRC				8
+#define SE_GCC_EMAC0_PTP_CLK					9
+#define SE_GCC_EMAC0_PTP_CLK_SRC				10
+#define SE_GCC_EMAC0_RGMII_CLK					11
+#define SE_GCC_EMAC0_RGMII_CLK_SRC				12
+#define SE_GCC_EMAC0_RPCS_RX_CLK				13
+#define SE_GCC_EMAC0_RPCS_TX_CLK				14
+#define SE_GCC_EMAC0_XGXS_RX_CLK				15
+#define SE_GCC_EMAC0_XGXS_TX_CLK				16
+#define SE_GCC_EMAC1_AXI_CLK					17
+#define SE_GCC_EMAC1_CC_SGMIIPHY_RX_CLK				18
+#define SE_GCC_EMAC1_CC_SGMIIPHY_TX_CLK				19
+#define SE_GCC_EMAC1_PHY_AUX_CLK				20
+#define SE_GCC_EMAC1_PHY_AUX_CLK_SRC				21
+#define SE_GCC_EMAC1_PTP_CLK					22
+#define SE_GCC_EMAC1_PTP_CLK_SRC				23
+#define SE_GCC_EMAC1_RGMII_CLK					24
+#define SE_GCC_EMAC1_RGMII_CLK_SRC				25
+#define SE_GCC_EMAC1_RPCS_RX_CLK				26
+#define SE_GCC_EMAC1_RPCS_TX_CLK				27
+#define SE_GCC_EMAC1_XGXS_RX_CLK				28
+#define SE_GCC_EMAC1_XGXS_TX_CLK				29
+#define SE_GCC_FRQ_MEASURE_REF_CLK				30
+#define SE_GCC_GP1_CLK						31
+#define SE_GCC_GP1_CLK_SRC					32
+#define SE_GCC_GP2_CLK						33
+#define SE_GCC_GP2_CLK_SRC					34
+#define SE_GCC_GPLL0						35
+#define SE_GCC_GPLL0_OUT_EVEN					36
+#define SE_GCC_GPLL2						37
+#define SE_GCC_GPLL4						38
+#define SE_GCC_GPLL5						39
+#define SE_GCC_MMU_2_TCU_VOTE_CLK				40
+#define SE_GCC_QUPV3_WRAP0_CORE_2X_CLK				41
+#define SE_GCC_QUPV3_WRAP0_CORE_CLK				42
+#define SE_GCC_QUPV3_WRAP0_M_AHB_CLK				43
+#define SE_GCC_QUPV3_WRAP0_S0_CLK				44
+#define SE_GCC_QUPV3_WRAP0_S0_CLK_SRC				45
+#define SE_GCC_QUPV3_WRAP0_S1_CLK				46
+#define SE_GCC_QUPV3_WRAP0_S1_CLK_SRC				47
+#define SE_GCC_QUPV3_WRAP0_S2_CLK				48
+#define SE_GCC_QUPV3_WRAP0_S2_CLK_SRC				49
+#define SE_GCC_QUPV3_WRAP0_S3_CLK				50
+#define SE_GCC_QUPV3_WRAP0_S3_CLK_SRC				51
+#define SE_GCC_QUPV3_WRAP0_S4_CLK				52
+#define SE_GCC_QUPV3_WRAP0_S4_CLK_SRC				53
+#define SE_GCC_QUPV3_WRAP0_S5_CLK				54
+#define SE_GCC_QUPV3_WRAP0_S5_CLK_SRC				55
+#define SE_GCC_QUPV3_WRAP0_S6_CLK				56
+#define SE_GCC_QUPV3_WRAP0_S6_CLK_SRC				57
+#define SE_GCC_QUPV3_WRAP0_S_AHB_CLK				58
+#define SE_GCC_QUPV3_WRAP1_CORE_2X_CLK				59
+#define SE_GCC_QUPV3_WRAP1_CORE_CLK				60
+#define SE_GCC_QUPV3_WRAP1_M_AHB_CLK				61
+#define SE_GCC_QUPV3_WRAP1_S0_CLK				62
+#define SE_GCC_QUPV3_WRAP1_S0_CLK_SRC				63
+#define SE_GCC_QUPV3_WRAP1_S1_CLK				64
+#define SE_GCC_QUPV3_WRAP1_S1_CLK_SRC				65
+#define SE_GCC_QUPV3_WRAP1_S2_CLK				66
+#define SE_GCC_QUPV3_WRAP1_S2_CLK_SRC				67
+#define SE_GCC_QUPV3_WRAP1_S3_CLK				68
+#define SE_GCC_QUPV3_WRAP1_S3_CLK_SRC				69
+#define SE_GCC_QUPV3_WRAP1_S4_CLK				70
+#define SE_GCC_QUPV3_WRAP1_S4_CLK_SRC				71
+#define SE_GCC_QUPV3_WRAP1_S5_CLK				72
+#define SE_GCC_QUPV3_WRAP1_S5_CLK_SRC				73
+#define SE_GCC_QUPV3_WRAP1_S6_CLK				74
+#define SE_GCC_QUPV3_WRAP1_S6_CLK_SRC				75
+#define SE_GCC_QUPV3_WRAP1_S_AHB_CLK				76
+
+/* SE_GCC power domains */
+#define SE_GCC_EMAC0_GDSC					0
+#define SE_GCC_EMAC1_GDSC					1
+
+/* SE_GCC resets */
+#define SE_GCC_EMAC0_BCR					0
+#define SE_GCC_EMAC1_BCR					1
+#define SE_GCC_QUPV3_WRAPPER_0_BCR				2
+#define SE_GCC_QUPV3_WRAPPER_1_BCR				3
+
+#endif

-- 
2.47.3


