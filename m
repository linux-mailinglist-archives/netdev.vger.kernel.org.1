Return-Path: <netdev+bounces-294267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rUUxAaD2HmpxagAAu9opvQ
	(envelope-from <netdev+bounces-294267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:28:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB8C62FC00
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:28:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=OK8hFhbB;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=AHCRHi9M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294267-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294267-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAA743038A56
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 15:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD84C3EC2E6;
	Tue,  2 Jun 2026 15:22:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819363E9584
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 15:22:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413724; cv=none; b=EAf1LmC1TA8uF6S70MOG55lp+pCC8b/pZN6sgI4lkavI3CfZ9Uwo9LRVhRp8BQXEWNu0Cg4O4u8j2QOeBmflAM7iJPVoeBkECU4/9EAH1T1ANx6ipm8/N8dLW55fpJGrZY0BJyBRpnqCBxcC7rR57+sz7b2cbEQLcmoDFmiNzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413724; c=relaxed/simple;
	bh=lh8FZMX2soQdqCvJUlCXyl979Qmo/LQaCjt7G5Tzax8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KQYv+wA/RttJslm1EZb6VNou81VhNhiq0ukx4LOyen3XUTNMU6IuHDD+tE4NZ0QNA6g0AR1wFxGmCrSEK8DlhwYIt79d44K3kQZMs35Q/B285yVpbYo/eaChy79SO6k0Cp88be0y5e9Rf1k0m9DUup7b6WKiFu2zdFyqe+LCvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OK8hFhbB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AHCRHi9M; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652ACEPi2692286
	for <netdev@vger.kernel.org>; Tue, 2 Jun 2026 15:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rula0vxp21DSEXYbt5FICL
	GmSa3GjueuuDLvkBfCxeA=; b=OK8hFhbBaTiNv1PaGBM6TcxK30wb64QPRVRHwk
	8C6+vFuMBZwa2GPPCOeuIvGH/YROzmtmK2NZSFRHTLjLlmK+3P3ZpvqjAM95tvNM
	YiHWk9QFm9o1FphvLWpekBEFFf8hwZAN+1QMRtpGDla6IeyndmyGWZILaTDm3LDq
	Oz7rcjc5/RFaOOQrFffTq2ggFx6BeSUcU8ZvG+OHOXEOYc5qKnGlUnEchVtf2mbo
	fUcHlQKGEi9000V6YQi9rHpgTn0mohXLOLHfWYB/Frdfys50/W4TlpOezhwvMoTA
	M5xVwMQ6kP4Z5CH+hU4Cb3r0zPOnlu6h00DeyFgxaldb0w4w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehqumjp9f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 15:22:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso181635255ad.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 08:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780413722; x=1781018522; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rula0vxp21DSEXYbt5FICLGmSa3GjueuuDLvkBfCxeA=;
        b=AHCRHi9MbRZEU9Eehx5BQ3tRHFlurQRtbkmJUQnCGyrUIoQ0B6fKdH+HlErN7qy1NC
         PxJN5mjE7krBVDoBLjqWrrArV4BuyBC2LY4KUpuwFUHqo305PjNlojyFyDpJXiKE0DXV
         liLzjoXGP/GQPnWv4BP8GvBtcQBO7qpCftOarwqKrfPiOXsRclDTVZD54rPyvlE8kd9s
         Y08CQ7x+416F4neB3kHS/InJsWkWuJIXLG5a0pncTuYcVixSMKDJRS9ndYKNXLeJ2CIP
         pao9uj+7otjme2o1E3QKackvcUWAK2yefGiSz8S1wkbUCDBvFNGtCFHysGNXOXc53hmL
         qPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413722; x=1781018522;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rula0vxp21DSEXYbt5FICLGmSa3GjueuuDLvkBfCxeA=;
        b=YlHPAre+uGaOgNLiXxoLbvTjJVbE6KpKkysvas8tmkRXGTxDuK9sH8V9MijF2GX2Vo
         tMxZRz5zVI0DTZj26RFk/ml/4+Qq0Jqprl28J1gTcCngGuGjEB85Hcc0gw5p1sFzJxRc
         CQTUpBDjZu5CFZbK8EJTUI7Y3qJxNY2L3JHV/sbZvyEKho7agchi49Tux7NY0z8rS2Dg
         S4hVlqlu4UpfpJTZbEut3UpNRSZpL/uMM9K5AnztRgJGEl7R+02ss3fqXLupNxR+sIkr
         yKNIvKH5Wtpgp1NVC6/fyOuCgRTS/N+x3WKNoPqM/Qh07IGtMgOhr4itFqLxSl5DnQDu
         5nUw==
X-Forwarded-Encrypted: i=1; AFNElJ9531Y1+O7L8ySRwaMTTRaJEd27UDY7oLc2sBZhrxgdRbPqLpcllaToND/DEDCdEj40uvTlePg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRD7M1Wm1HZk7EagwgW9C3iSNxP++MyLdpY033A+ZaaLbBHRy
	BS73Q8mGewqCRbpEwVQtpmE4nCRFiu/Lh2q/TRa3XTfCajGjqwWGHd6sQBJE3XgJgTV6uP5zNJM
	EssaXGEJPu+IGPWHZbWDc/uDmvmnQvEha2Gbc2q5qgMhOKfe0xFc0MVzbQP8=
X-Gm-Gg: Acq92OHrrjzf8x8j0Zzok/5mRt//EO0sIhz1QaYDSnKGcrSr1ppSe9ZMSN5edUcupw4
	D6uOmfXMbko+60OdSdiQnU8/V1Pqp1mb1d78wXvKAySUsfdFWQ8IsOAjFXbu98Y1B3A8Vw4GXKY
	sTpWBNVQ9Fh7U3vOYJpd6XZtnHvbOxvzRc8PwLUtfX+qbg0FnsaqlrS5tLuhh1id8SjYpT9ixET
	PTehrDKuIehWUbwd04oIIebEftddsrSxVBVnDuIB/j5RxrjrfWCAYp7807zU/xolpohNJViCZoR
	/Bl/FaAVcbPquwx8abUom+PVJ2DRmAQyXeBl7YYqK+h/mMgQWr1F9cwuR8Czj+L9hByyL1P74m/
	4m2VohrLKfCr00rRB7q4V5mx/GKkgg+IEdXgMJ7hydE3nKJ3itwy4lfla
X-Received: by 2002:a17:903:230b:b0:2c0:af09:f3c7 with SMTP id d9443c01a7336-2c0af09f5d4mr156636035ad.30.1780413721685;
        Tue, 02 Jun 2026 08:22:01 -0700 (PDT)
X-Received: by 2002:a17:903:230b:b0:2c0:af09:f3c7 with SMTP id d9443c01a7336-2c0af09f5d4mr156635555ad.30.1780413721216;
        Tue, 02 Jun 2026 08:22:01 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e71cbsm135136465ad.15.2026.06.02.08.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:22:00 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Subject: [PATCH 0/5] clk: qcom: Add PDM GP_MN fractional clock divider
 driver and DT support
Date: Tue, 02 Jun 2026 20:51:48 +0530
Message-Id: <20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAz1HmoC/x3MTQqAIBBA4avErBPUwKirRIg/Uw2ViUIE4d2Tl
 t/ivRcyJsIMY/NCwpsyXaFCtA24zYQVGflqkFwqrrhk0Z/aHbteoz6D17dgPQ5OOmG7wVioXUy
 40PM/p7mUD4Ugca9jAAAA
X-Change-ID: 20260602-pdm_clk_gp_mnd_v1-7e9c2c1b39ab
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE0OCBTYWx0ZWRfX6kj0D+3Z6rH8
 U/wxUnZCH8WuZBtgaKVjdjSt5kLIF5cszfqtGDYKj4qYTKHCaeC7benjUv/2Zira38yoHnOvrX0
 QD8ucoLeRGkgeMdVWFGCwqRaPGDRAdMhAuu+abeKra/5e8v3uBLV7GSngwjngod7A+lo6PPssVf
 S93o73LvMvv20x1RDcOsmOs3/QrCbT105YeC8/rlsgmrJ6xs/HCDjDvSHdvyHlSE4uBJSb8s8dh
 60J3l+4Y7aJeHQFg4ni5y/ClE/tAUx5iQ4bmofuOqD1XHCdS99ib6bmA/7+JyCghNwDMG9wfWqK
 As6HaIgU3QzgppLtjceumA7XVX3CjXCCuimuLsJwtU/EFaiLK5i59FebVj/lyf1bFWHdhyAR4La
 HR82RODGvsYk/QdRPCSlvnZheL/wPm+M/PPSW0g3szzqPNJm9aZkmnuD3YzTlX4K1QQov1iy2EQ
 mTcImQ8FEb3agOzERXQ==
X-Proofpoint-ORIG-GUID: yz_IWY4qkZm1guUzyROJqZ82Rv624Iqz
X-Proofpoint-GUID: yz_IWY4qkZm1guUzyROJqZ82Rv624Iqz
X-Authority-Analysis: v=2.4 cv=Rrv16imK c=1 sm=1 tr=0 ts=6a1ef51a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=7twCsXJWkRLxYzWIcc4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020148
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294267-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linusw@kernel.org,m:richardcochran@gmail.com,m:konradybcio@kernel.org,m:ajit.pandey@oss.qualcomm.com,m:imran.shaik@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:netdev@vger.kernel.org,m:taniya.das@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[taniya.das@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[taniya.das@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CB8C62FC00

The Peripheral Web's PDM hardware block on several Qualcomm SoCs
contains a GP_MN clock divider that generates a fractional output
frequency from a fixed input clock (typically TCXO4):

  Fout = Fin * (M / N)

The output is routed to an external GPIO pin via a dedicated pin mux
function, making it useful as a reference clock for external devices.

The hardware uses three registers:
  - MDIV: holds M (9-bit numerator)
  - NDIV: holds the 1's complement of (N - M) (13-bit period)
  - DUTY: holds D, the low-phase count, constrained to M < D < (N - M)

This series adds full upstream support for the block:

  Patch 1: dt-bindings YAML schema for qcom,clk-gp-mnd
  Patch 2: standalone platform driver using rational_best_approximation()
           to find the closest M/N pair, with full clk_ops coverage
           (determine_rate, set_rate, recalc_rate, get_duty_cycle,
           set_duty_cycle) and AHB bus clock gating around register
           accesses
  Patch 3: gp_mn pin mux function for QCS8300, SA8775P and SC7280
           TLMM pin controllers
  Patch 4: pinctrl state nodes for the GP_MN output pin in the
           kodiak (SA8775P), lemans (SA8775P) and monaco (QCS8300)
           SoC device trees
  Patch 5: GP_MN clock controller DT nodes for SA8775P (kodiak,
           lemans) and QCS8300 (monaco), clocked from GCC PDM XO4
           and AHB clocks with the XO4 pre-assigned to 4.8 MHz

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
Taniya Das (5):
      dt-bindings: clock: qcom: Add bindings for PDM GP_MN clock divider
      clk: qcom: Add a driver for PDM GP_MN fractional clock divider
      pinctrl: qcom: Add gp_mn mux function for QCS8300, SA8775P and SC7280
      arm64: dts: qcom: Add gp_mn pin state for GP M/N clock output
      arm64: dts: qcom: Add GP M/N clock controller node for SA8775P and QCS8300

 .../devicetree/bindings/clock/qcom,clk-gp-mnd.yaml | 105 +++++++
 arch/arm64/boot/dts/qcom/kodiak.dtsi               |  21 ++
 arch/arm64/boot/dts/qcom/lemans.dtsi               |  21 ++
 arch/arm64/boot/dts/qcom/monaco.dtsi               |  21 ++
 drivers/clk/qcom/Kconfig                           |  15 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-gp-mnd.c                      | 333 +++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-qcs8300.c             |   9 +-
 drivers/pinctrl/qcom/pinctrl-sa8775p.c             |   8 +-
 drivers/pinctrl/qcom/pinctrl-sc7280.c              |   8 +-
 10 files changed, 539 insertions(+), 3 deletions(-)
---
base-commit: 08484c504b55a98bd100527fbe10a3caf55ff3ff
change-id: 20260602-pdm_clk_gp_mnd_v1-7e9c2c1b39ab

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>


