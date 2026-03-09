Return-Path: <netdev+bounces-265598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ2OH+zmrmlRKAIAu9opvQ
	(envelope-from <netdev+bounces-265598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:27:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F7723BA3B
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E20C2302A788
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195553E51FB;
	Mon,  9 Mar 2026 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H2ocoS8x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LwhQ3wyD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098073E3D86
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069881; cv=none; b=iiG+4eXLFr+dK+qDyZ7Mx8HO+FhM3QAeO99jvIB3oB+H5RDZY/Jd60vAqYBLMpF2Juz3rmV3PqNChQCYacMlBlURWsnC2n0fEd/um49bxq9l1LlV7nr0Ft0d5QJid+gP4vQCnQiz+xv9zn35NyUdBMr3pxOwMnOu8EvczDG25Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069881; c=relaxed/simple;
	bh=r8cuQ6b8f7Xo/KoqCVbaVcurxgNdTb1lBAk91JFsjJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sX1Vujvkl3oNYi7CUYNsqPb9jAxjHb+4fwfxXvYWYxk39JDLTC++ai0Pl2pDlAtghd5J0DTF1ag7kEoz8HBFpQM4XiEYhsL30sXqGaRTgq+wD/3MF3fvGUu6uyejfAs8oeMQiaccySVqbSrHSRccI5Qs+jpcb2tuje3bSLDcoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H2ocoS8x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LwhQ3wyD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629A6gsH2195134
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 15:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=54zpT9fL548
	mlSdxSVINsQLVELiV7cKhFBd6utZbb/Q=; b=H2ocoS8xuEVZQg4nvfIwgILp7Pt
	VkZ3ecnSCcSYut8tgk4kPlqxqwrw9mpWozTkQycEDU9gZCdptGsCnGBFI3mchXKX
	5Q3ngGoDesK+DwCYCrzrmnL8IziJrIQAOjUjsiZFfQWLdy2SjlYpKKkx8xapXhXk
	iK4NUSVPW7Gd2CQpfYwHShPWGhvdPYnGgIseBHqIRy82X3e5+gCW1mwzcxWwY+68
	1SD+NEAbAN7WUxyRYKMotaGQkKaxQRI8757LHoNXvF/xUpw/xC+R6jzizKyHKJUp
	S4UdEhD64hY05w2SItpaoS2WF0a3qFInO23AhLqZ6IxmfcMA2KQuSJWBV9A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csv5u90fe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 15:24:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd900cd3a7so230123985a.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773069877; x=1773674677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54zpT9fL548mlSdxSVINsQLVELiV7cKhFBd6utZbb/Q=;
        b=LwhQ3wyDl5wcWvksQ0w23G7rkMxKPiOLBqLxHpLHA4fHyCJ2qsEuk4hREO5C+QYY5c
         CA8EoWo3r5Py/z4pslnURD9GQC64yA273JCTf3Z8yY/HaXdv36FH8XIhZTX8i+0zwoHd
         8muSqv1mWI/iZ0lvc+zw0nrG9UwKrq9v631Atp0xhTkoedzI2d/uQ6X14bq77p63FXJZ
         Xhmdz1a6XLmJ/js6/kOAqdMalsWw2+vOP9pstCDcv0cALrV7IgygMMzJv4ZSU2SNA8iU
         sa6yqOQB4YMUsNdcgDiRcNKUhpMq2MzB9NzSuNLntRpZahEPdi/PsAa/BFhQTobLPwar
         sBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069877; x=1773674677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=54zpT9fL548mlSdxSVINsQLVELiV7cKhFBd6utZbb/Q=;
        b=HtKYE5Dw7WanjvGNR8x6DbQk6nSWoUHovKCrUyB24ZOw+5NqALBN9b8bKyr8b97d9Y
         egp+n1YAxKqLeg0o5UoX13pINPSi2DWHfLtrc5KAz4oERHSZKpcmRU5xqW8Yi31iLxdi
         PkV+rAV5PSw+q0QSRR7Mx0SPD435WWW5yy0PgEJge4GNL1m5vbXLOoHK/AaF75l+X65w
         H9X8PerT+IcWoa4p2GEhQYnA+s3tipCvFrni+Xj4CNgmYvEXvUYCcP8uloDzngBjroHp
         ERWhdzByCV7lAaq4IcBfpb4/icJBqm06Yr7h4HjmbHt3vhmp7AMl+prtSzGXW7b6M1Ym
         SV6A==
X-Forwarded-Encrypted: i=1; AJvYcCUgeXJlTnadKbXIZeeO2//sUo3CIVqfLTn90tURv1HvDj2m1eCcNZ6f/v88r3SMDtqZB6KGG8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5WOVawU/ffArz8duP9aj0kZ9320JCtpTQfA8LG1aWVeUaU5B
	2eOFwODDv4K2MnlDvJoVWCdxtSZUC615iRmEy28vgauLCS4ii4ACUg0CfCMAf/0kRmHVAmp1k3n
	UTN4dd50oQSilmZ5fRgOZYGxPsMqYu9RR2t1vMWpQQK8QL/sc353wg+T+ngE=
X-Gm-Gg: ATEYQzzMVBO8sBVMsjF3HVTZbmwl1xk3yVOUpBmKO8TDEhvIDaqPUpq5nr1PQtTzShK
	IUAOmvnka+Kk1MhFXqAW37gUZXIfryGKrtpLIsroJqNDxj2ldRRaIo55D3MNfmog09a4Iy2vqaM
	QlPEJHVKvTyhYR2VM9PJvvKX4xzLXShaTVr5IbjLXu2V2qGrF0d9y89bvfKQGEg/iiEhoVlVCWC
	XHlJu+RJMvgPocDJ811t2eqObiDiLeM3vaUsjsF7QU5897efcbZlQp95ok2XejSt1oMm7dYxOl9
	s2pZnD1ZkDhxG0m6VCaxXprRoHhMJh3MmSsfMTVxx9minm/4hPHoXU/QFv9X0I+1ZZCKH3mhB2h
	EXNyfxsyYNoY+7GKd2RWOmmm5Pj0j+EtaNkeOSKcHUjrscGWZzqXC+dY=
X-Received: by 2002:a05:620a:27d0:b0:8cd:7835:87f7 with SMTP id af79cd13be357-8cd7835897dmr871720685a.68.1773069877404;
        Mon, 09 Mar 2026 08:24:37 -0700 (PDT)
X-Received: by 2002:a05:620a:27d0:b0:8cd:7835:87f7 with SMTP id af79cd13be357-8cd7835897dmr871715085a.68.1773069876757;
        Mon, 09 Mar 2026 08:24:36 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853a59fc36sm192812515e9.9.2026.03.09.08.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:24:36 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: richardcochran@gmail.com, geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, m.facchin@arduino.cc, r.mereu@arduino.cc,
        loic.poulain@oss.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 6/7] arm64: dts: qcom: monaco-arduino-monza: Add sound node
Date: Mon,  9 Mar 2026 15:24:17 +0000
Message-ID: <20260309152420.1404349-7-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ejp8dWFHcL8Iq1232j-fgJ5l9KMftM3z
X-Proofpoint-ORIG-GUID: Ejp8dWFHcL8Iq1232j-fgJ5l9KMftM3z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzOSBTYWx0ZWRfX4+3c9DJ4eXuB
 novHgxgz24LzGYQkQ/6VOCCKmk/rkAHu/ldUm9/7ysgPp6p69maO5MbOHyffweVBdDEminpjF2r
 KYrRj9WOnSolFYvywmpEbLDLz+2QZedcqsF9LcCL5CWwkrR33z1+0iTKl38SPnqVBdHOr0I+qr3
 noGhJlh2NnaP3oPW/r+b045Lz+QJtGj6AOQjexFk4UrqB7lnHUIW5UyJdiFyZBIHtm0l8I1pG+p
 6XRlI7fXogOu8JAgS12vOhA14AXsjak8xllGtuIJO72lVfy9HhcdGY6OVQWYrSvngBOUcJ9MazC
 Co7gQGZ4zDyBaxM4WeK4Xq+fA1aLf573fm6OUXjbkLh/v4gf8RggVN3l/a3Gb3IQPUdidOXYKNO
 68eePxC3YTO5RtM2jslSEbACVzRrDl3TcjP3fpWujhZVcHLPR4D6CqPUltYNhuG6ivEQ6NAtG5J
 zumAL3i2Lo56L351ADA==
X-Authority-Analysis: v=2.4 cv=Xr/3+FF9 c=1 sm=1 tr=0 ts=69aee636 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=nFBmfCUKH4FirDOTGbYA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090139
X-Rspamd-Queue-Id: 29F7723BA3B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265598-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,3c40000:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,0.52.125.128:email];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add audio support for Arduino VENTUNOQ board, which has Headset, Mic, Ear
and Lineout connected to external Maxim max98091 codec, HDMI audio
via ADV7535 dsi-hdmi bridge.

Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 .../boot/dts/qcom/monaco-arduino-monza.dts    | 66 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/monaco.dtsi          | 55 ++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
index b6db2a7151f1..be62b3dabbca 100644
--- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
@@ -80,6 +80,72 @@ hdmi_connector_in: endpoint {
 		};
 	};
 
+	sound {
+		compatible = "qcom,qcs8275-sndcard";
+		model = "arduino-monza";
+		audio-routing = "IN12",  "Headset Mic12",
+				"Headset Mic12",  "MICBIAS",
+				"IN56",  "Headset Mic56",
+				"Headset Mic56",  "MICBIAS",
+				"MIC1",  "MICBIAS",
+				"Headphone",  "HPL",
+				"Headphone",  "HPR",
+				"Receiver",  "RCVL",
+				"Receiver",  "RCVR",
+				"Speaker",  "SPKL",
+				"Speaker",  "SPKR";
+
+		pinctrl-0 = <&quad_mi2s_active>, <&quad_mclk_active>,  <&lpi_i2s4_active>;
+		pinctrl-names = "default";
+
+		pri-i2s-playback-dai-link {
+			link-name = "Analog Playback";
+
+			codec {
+				sound-dai = <&max98091>;
+			};
+
+			cpu {
+				sound-dai = <&q6apmbedai 137>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		pri-i2s-capture-dai-link {
+			link-name = "Analog Capture";
+
+			codec {
+				sound-dai = <&max98091>;
+			};
+
+			cpu {
+				sound-dai = <&q6apmbedai 138>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		hdmi-mi2s-playback-dai-link {
+			link-name = "HDMI Playback";
+
+			codec {
+				sound-dai = <&adv7535>;
+			};
+
+			cpu {
+				sound-dai = <&q6apmbedai 145>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+	};
 
 	vdc_3v3: regulator-vdc-3v3 {
 		compatible = "regulator-fixed";
diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 0727dbd44a75..ef2cea0db048 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -2885,6 +2885,61 @@ lpass_tlmm: pinctrl@3440000 {
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&lpass_tlmm 0 0 23>;
+
+			quad_mclk_active: quad-mclk-state {
+				clk-pins {
+					pins = "gpio5";
+					function = "ext_mclk1_c";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
+
+			quad_mi2s_active: quad-active-state {
+				data-pins {
+					pins = "gpio2", "gpio3";
+					function = "qua_mi2s_data";
+					drive-strength = <8>;
+					bias-disable;
+				};
+
+				sclk-pins {
+					pins = "gpio0";
+					function = "qua_mi2s_sclk";
+					drive-strength = <8>;
+					bias-disable;
+				};
+
+				ws-pins {
+					pins = "gpio1";
+					function = "qua_mi2s_ws";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
+
+			lpi_i2s4_active: lpi_i2s4-active-state {
+				data0-pins {
+					pins = "gpio17";
+					function = "i2s4_data";
+					drive-strength = <8>;
+					bias-disable;
+				};
+
+				clk-pins {
+					pins = "gpio12";
+					function = "i2s4_clk";
+					drive-strength = <8>;
+					bias-disable;
+				};
+
+				ws-pins {
+					pins = "gpio13";
+					function = "i2s4_ws";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
 		};
 
 		lpass_ag_noc: interconnect@3c40000 {
-- 
2.47.3


