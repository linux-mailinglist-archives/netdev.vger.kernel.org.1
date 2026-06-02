Return-Path: <netdev+bounces-294271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 825bL337HmqWbgAAu9opvQ
	(envelope-from <netdev+bounces-294271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:49:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1B162FF32
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:49:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=f5J0vsFV;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Bx9sAEBz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294271-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294271-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DEE030975AB
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669A33F1AA4;
	Tue,  2 Jun 2026 15:22:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71783F1656
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 15:22:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413749; cv=none; b=MX3evYqnqNsgY28B0nYuEC2kBdHVGEun6M8GDVLd4dzkgwxAWlkkQQUE0PEdA7BI6gpR4YJEm2uqpb6w6zEbjfTz7ZvtP88rnkkF3d65n+4N+8khzJahRkbVhESVqAt7c9o5AjC32P3eELFMqQzGQNFGVqb3ht9KHQqcB8tNg6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413749; c=relaxed/simple;
	bh=+Xb/utRGbA76vMez2NMiVdI+b7uBrOEKhyFM8kS9ee0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BxaUvF+bavNajM3xj6Rc8rCOv62B1sJOQkLv77XVg6FEv1GH5D8cIxHOysnpuOC+P/DCUDt5l95WDW1QFEjXJ/iUbSGSKI5I8NbAFBxm7GRqTZDhJf92Tk+Q1FX31yZ6S+eUVLEBHuAjsfeC/olweucmMIpZup00hJGtlbVtwhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f5J0vsFV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bx9sAEBz; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652ErwhA3430255
	for <netdev@vger.kernel.org>; Tue, 2 Jun 2026 15:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uhRPtdw0XTUqgVAR+NUCXa7KNyeb5Qt7pdv/jdZhIhM=; b=f5J0vsFV/Va/9/B9
	Rau7yFgAY/y9AJgYQAP102ItcfTsjTLroOG/XgKkClblC2RgveaFHEqhAUw4XWOJ
	pv46Tz7TcoIcgnVUYQUJ+iWgX/UfZipn9KjZ4V9NCrEOVgqDtbZBUTcyhv7XVexc
	/n0mXwy+I7d267lPFjhHD2HO1ijPswpLZq4fYuplCFlLFikyoYBtSVZfiG7aBl1b
	EwgWYw6D4n3RpUV/Z9pbtt+5UfjeAepnQdGip5N0gqWZHDk50WLFQH+3Oq2QlKA+
	VlrYs4Wiql46RsQs7Cd0KObxanA3o5aqto0ndrienvA+7yBLMDwSUDQqlcmucbV5
	H6xV4w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehn8mk6tv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 15:22:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf11699875so58480105ad.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780413746; x=1781018546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhRPtdw0XTUqgVAR+NUCXa7KNyeb5Qt7pdv/jdZhIhM=;
        b=Bx9sAEBzsgnrFL/Uo4J+m/NrlovlSHYYT9CKoVktMXfd8I8kUuam88xOzSMs48rJUR
         /YjP8l3AH6xlZBRrRzMbudY4BY1vYFCdYNEfE6Z/PX2eq4Sa5WWZAifm6c8Si8RwJJFU
         f2YFG9hbh2Q/0dmA3y5J5CXBnJrCDfhRs0kMyWhv007a/ju/6HByZAU0RXWnyEEIrvQP
         MXL9uJCrFiNl7aBelhiqWADnjxUYYqo5RXplHp4mByYy4fP4QTWJtXZcOTiHxzs9QaYw
         RtD+H6gUV81dxWsg5OuU56HPP4UoCc9iZhr/bLonulflg04uCmMwNJ9kK8B4BukUXiHH
         /Zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413746; x=1781018546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uhRPtdw0XTUqgVAR+NUCXa7KNyeb5Qt7pdv/jdZhIhM=;
        b=XtCW/dvtzbwU8dRgxY9VmJrDnUT2l87vbRXa/wTJIAusCWxFDIUs5sEHsrXoYpAXPt
         ZPbS2hcf+HZwI74j927DsHQEv76z7J66Kb44nwGrKi/8JXVRKK2JLsGcvECxcIVApu5b
         MsSNsvSJjeQCNrcJpJ5AjCWvRqKpH9kam0E0rx/0PvU5lZH+ZvhOKwVfV1VFFYjsLOlb
         nkTy8+kiuLg0bY99juUwhaVtqWDJtueVfhRVseg7/zIVNxPeDTSP9k3vBwmbEdz2ezFP
         rPTbLYicO1ltdTGKms4lUP8UwjvXswj6HV+fp0q0QbEQIGsDNbla0ap0v897rIyMVdl6
         MrdA==
X-Forwarded-Encrypted: i=1; AFNElJ8/IPkTp6GwEHtgN3dz5/mq6O1KTeSasiAkpXgWmd4jt3ZRjN0u1G6JdPfEFKgig4PWrT2lcl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjExb7Y59qG8VfjYn6sGPKQbUtiGe+pU11hyFZ+1pApu7L294
	81sfpgheKECTMK/yvedhLimV4q+/c/HUTww5BesVYjpkMLqklGS1SmT7AkWym9Lzem4tlgOtozm
	6/MtMEwa4Sz6pfjGJyITdFk2EM5Yj2iPoE765RFfQ5tga8tu8/aLYlK8zqTI=
X-Gm-Gg: Acq92OHfvVbHPRv6HXN2Hkjy7aaO3XV+056M50SkeNU3zLtFt9bljgqvHswNY5gckR3
	0y7vuK5lJDfaiRttCF3DkkE8kqKOfY/mTqmq55/1//iXXwb9KhG3c8FbrFz2rukkktzcGkI7tkD
	/62/9OWej6gqaJR4RgUdAkFqSSvfRhj3FFlNKTk9uGDR+Xh+eZti4Ez72xZ4GvF52JeWggx4Wqn
	+BBbHfJqp6rYu9gH1iJu8XUZjBJfRI+uw/GgqaUqlNOurH+mn32C3aUZ/aTjftwuquMpnFdW62Y
	sU0sea406X4JBW01v5qtubhBeaSSWj2vYTYr23WuqDvZ6HTibfuroEevOXSHOxTI3znAHvLxaUo
	ujmifVF+S14p5wCaVeGx3s+BN5Ih5xGwOx8WrZCSIa45m0GXDeim0+jL+
X-Received: by 2002:a17:903:2351:b0:2c0:aa5d:756f with SMTP id d9443c01a7336-2c10cc58081mr37107985ad.8.1780413746455;
        Tue, 02 Jun 2026 08:22:26 -0700 (PDT)
X-Received: by 2002:a17:903:2351:b0:2c0:aa5d:756f with SMTP id d9443c01a7336-2c10cc58081mr37107665ad.8.1780413745979;
        Tue, 02 Jun 2026 08:22:25 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e71cbsm135136465ad.15.2026.06.02.08.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:22:25 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 20:51:52 +0530
Subject: [PATCH 4/5] arm64: dts: qcom: Add gp_mn pin state for GP M/N clock
 output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-pdm_clk_gp_mnd_v1-v1-4-1522662b6c53@oss.qualcomm.com>
References: <20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com>
In-Reply-To: <20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE0OCBTYWx0ZWRfX+/yL0lc3+Vzn
 gc8Iybj4DGfBP4K8U39uSsJDZ5SjuCudw4Qt0BdQUSXb0KDPqacwnlCpD78M8v/lMj9WiK4bXGD
 7hep7pQLPyYT7k/k5X6KSHkehNw7wH+wpSur760Sun4YJmZ4zUrkCVAhsmUwvbgQW17RgPZLhBU
 CuEyYlnMJlgAxTeFEqRAgAxm8EEtXwjPYWQU4478u2gPpzgzrEwjYMMaWGL3nTpa8hvi2N09FTG
 p74a3LDqlQ1W6E1HgK/WmLA6mzsCXC/NexwmJhhtcl8qx+ckKdcE4ekPyzZKi9yWMkdmtvv43LB
 rdi7wtngFCPIdv+O/K2UvnrtkIGSFM64b8wDRsRBPoj5uyGjKk9w6hwUQ9C64upfIEGUVBgD41q
 RwLpjfo6kaYXVDTFeorN2gtTSXo+rOpg6vvpc5+rbnXoAk3+IBSaEE6Ns97gAxeQoj05ZZYNi9u
 vKvz3ZFdDxZ9jIzC2Zw==
X-Authority-Analysis: v=2.4 cv=d5nFDxjE c=1 sm=1 tr=0 ts=6a1ef533 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=FGXTwBWI_TPF8Oz6hcgA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 4dSELYsEwsdyOUwWo7N2KagnzIl7pT1p
X-Proofpoint-GUID: 4dSELYsEwsdyOUwWo7N2KagnzIl7pT1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020148
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294271-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linusw@kernel.org,m:richardcochran@gmail.com,m:konradybcio@kernel.org,m:ajit.pandey@oss.qualcomm.com,m:imran.shaik@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:netdev@vger.kernel.org,m:taniya.das@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[taniya.das@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: BC1B162FF32

Add pinctrl states for the GP M/N divider clock output pin across
multiple Qualcomm SoCs:

  wire it to the GP M/N clock controller node via pinctrl-0.
- kodiak (sa8775p): Add gp_mn_active state on gpio35 (gp_mn function).
- lemans (sa8775p): Add gp_mn_active state on gpio35 (gp_mn function).
- monaco (qcs8300): Add gp_mn_active state on gpio32 (gp_mn function).

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 7 +++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi | 7 +++++++
 arch/arm64/boot/dts/qcom/monaco.dtsi | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index fa540d8c2615dc02d941eb16bc7253204c2750bd..1ff9e1598d00429c03b2bcae41fa370ab2c892bd 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -5908,6 +5908,13 @@ edp_hot_plug_det: edp-hot-plug-det-state {
 				function = "edp_hot";
 			};
 
+			gp_mn_active: gp_mn_active-state {
+				pins = "gpio35";
+				function = "gp_mn";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			mi2s0_data0: mi2s0-data0-state {
 				pins = "gpio98";
 				function = "mi2s0_data0";
diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 353a6e6fd3acb22ef228bee340212b8b2c300957..19f8cf4e15482947f6049188050c370340afaead 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -6022,6 +6022,13 @@ dp1_hot_plug_det: dp1-hot-plug-det-state {
 				bias-disable;
 			};
 
+			gp_mn_active: gp_mn_active-state {
+				pins = "gpio35";
+				function = "gp_mn";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			hs0_mi2s_active: hs0-mi2s-active-state {
 				pins = "gpio114", "gpio115", "gpio116", "gpio117";
 				function = "hs0_mi2s";
diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index e4c8466f941bdba04f99b988fd7bf5afd926b31d..ebe5889daa5300efa7857314e9170d7d2fc33ef7 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -6433,6 +6433,13 @@ dp_hot_plug_det: dp-hot-plug-det-state {
 				bias-disable;
 			};
 
+			gp_mn_active: gp_mn_active-state {
+				pins = "gpio32";
+				function = "gp_mn";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			hs0_mi2s_active: hs0-mi2s-active-state {
 				pins = "gpio106", "gpio107", "gpio108", "gpio109";
 				function = "hs0_mi2s";

-- 
2.34.1


