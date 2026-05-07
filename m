Return-Path: <netdev+bounces-285474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C3wDJLm/GmGVAAAu9opvQ
	(envelope-from <netdev+bounces-285474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 21:22:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B1B4EDF58
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 21:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A69930167BA
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 19:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A31947DF8E;
	Thu,  7 May 2026 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QFkhuJ0O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eGgZNDJO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B9480DE5
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181742; cv=none; b=mmjoATDcx/8rf5M4qRlhz5QTnf0cPabCo6UBFCMPAZRVkok+XSYRwO/U1yxogtRAV+PV+i9+D++BDZHQgkhmgdKCdIsjiNIhAYeWQ81wHZKWSDUbs3TVh5/YAJ6fGRByrJOdNpkCaXiQPz6x/AuzDD1R1ApDqoCJ45RU/jL2XVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181742; c=relaxed/simple;
	bh=jvyJCe0RN8MCcynlAWEz42sn7roJV11eMx4pxGp1l2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sMii+OfZD4JB+I2a7gmyPkVTK41arWgW1QJKs8K8X6fcmoBpj1W389twywOg62z6vezPYELB5vI1yz5tKaipR72/XnwTQMfv2EdeYpC6R+VspMSFN7NCpBBIueW0L1JoJxKwLhjuP74sZzVr85ZdAX0Uv5pFGlQOBjckngTuDKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QFkhuJ0O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eGgZNDJO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647J7eoF2531479
	for <netdev@vger.kernel.org>; Thu, 7 May 2026 19:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YhLEBhs95oU5wNJOrtgYV7oafT0Q2U0L+BmVD6j5Hy8=; b=QFkhuJ0OeUIUMPyt
	UGFMIiDGQ4W3iggEOm8OmRhMYuJyge+2KxH9CWK1XZ9Iv0aMqpSHg4ZJIdzD7OJY
	NJZDS5L3WC5JhwBlFIrSbPzpm6RJiHtbsn1Id6qe9nUFhBoICoixbIptHPNaonMc
	56Bp7afpF4Zjtf5PUKSDViCvE88geejTn9bSGmu40ERKr93l/emOACqP4IB0HT94
	s2b9eYFYhAqowkgajJptQVrOXYNEJ1/UwSSAF8NNlg/1iPiiy/ZdhQEcAdH9Pzbx
	m8CkIVIwQOaHhtAPjouE32j4Fopbw9ToDA+0IHH19+LVftc4rcN0QnGWH0PYL8OM
	w/SRtw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e10m9r1kr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 07 May 2026 19:22:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b9f5ac4e36so12400025ad.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 12:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778181738; x=1778786538; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhLEBhs95oU5wNJOrtgYV7oafT0Q2U0L+BmVD6j5Hy8=;
        b=eGgZNDJO+tPiJxCfp7uozh+FMubzt+J9evAe+Ei7z6NdAUW83FLhRHhfkZryfiH6qH
         7SNZhf/FzO7h8G0oDbpZCMLb93yCQ45cUbSVG6mIxllH9voHl6K1np1cT3zixmieg0ZF
         UIYKHzwcDIa36qAY4nAIRrO6b3Way4AHpTcvmZjoiORUCM3udL8pNdtQqlAlcdPT8lsu
         VYpBkyWadJn7ekiCmuc8+lUGwO6P079QcpsTLoM2sKGuwGHP4pvSODwlsNnzRlru69W7
         lSazBEivlB69qRJudsS3H9jCQx8qhgSiPE79YFAgoQBotoQhkHY8lWGXV/8iZZY3MEFi
         2JLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181738; x=1778786538;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YhLEBhs95oU5wNJOrtgYV7oafT0Q2U0L+BmVD6j5Hy8=;
        b=jfaMnjDXHVtQe2/zsDHl/OfLaSxWDi6P/vx33q3gDoIvZpxuw7nku44tv5zPV1ED8J
         Gb1KUaPobGj983dF1QB+zVXkBBJjI8P1uE9fpEpzzeXdveNc1fJHp6DvRf+cOBKlmSDK
         rv/JNV1mFcF17YPJzBXvMmMY8ewvQWo08NBeIIrh/W6URoMM7w+OpcihuPa0IXkMPPBV
         BJlPJSDjLBoV1Q4yqCmjvVkGBEKBZEqU8zYh4h3ogx/KsG4xTJEm37uM4Y4yzZzsuWCk
         LXNK9iRpFa498MjpBOV7GJO+g1CD3zeHMK22xmZaFLnTvtucE1xnfxK1XX+kOshO+DEB
         1Blg==
X-Forwarded-Encrypted: i=1; AFNElJ82JpkBcWT9LAlw3YRsML69kjHBCKecckkxApuv4l1yyPpYEJrHL7LpIvGIN68sQvWBlK9/63g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxijBCbnqBjZ+FMcRNtQ4WDDJCMQzp1TFeqmQnkDU295kMgrBfc
	xoy0IlCRC4bYaFCFocbphSMfcZfMC5ZGJ9iKcY6gwscRZgxl6v4SrSodJjvP+/MIANwVaI01sxK
	SCbMiAaxcolMtuyMHzkP0GBHjCt99i4CMrdTsGH3+tR4g0/p/nbDUqgvyaPc=
X-Gm-Gg: Acq92OG0Gfp2zMqjAUT2/MmhLrj+UO5I+M2ads6jcuGIX5csn7NOSexC7kbHRHoDkfa
	/0lXG2CiQ+IhaRk7V5No1faPBTvxDzclPsaYUNQpOZNSFCUg6Lxch11AkrYBJpU+s4dFbHoGsTE
	98G/JooEaPq/vIQma1Z/H2lLVkZMXncoMLnmMwds5KbpAqhQDdOuRyiR8uxuAB4dMyIySVEq/gu
	BrYVGheCQOxCeDmRMVPz6cVBcR3G7cpgQStm/gdQTY2Ai2BRrhkAEHq2kKE63HHp0P6EUZXXI8S
	tvM+SYXHqNCKrmtu4H6JZjbZxydx+qWsKYKBu3CeOtXB1iwFtP0aRKUc4PIEk41vRtybBWT+LAY
	IkBMvbIHum7hck5xE1RyYw2inPwoBzUj+ivh0
X-Received: by 2002:a17:903:1b4f:b0:2b7:88d8:efee with SMTP id d9443c01a7336-2ba7a340633mr92494775ad.28.1778181738305;
        Thu, 07 May 2026 12:22:18 -0700 (PDT)
X-Received: by 2002:a17:903:1b4f:b0:2b7:88d8:efee with SMTP id d9443c01a7336-2ba7a340633mr92494455ad.28.1778181737773;
        Thu, 07 May 2026 12:22:17 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bae7874767sm6012535ad.72.2026.05.07.12.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:22:17 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Fri, 08 May 2026 00:52:00 +0530
Subject: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: Document Shikra Top
 Level Mode Multiplexer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-shikra-pinctrl-v3-1-771144cdc411@oss.qualcomm.com>
References: <20260508-shikra-pinctrl-v3-0-771144cdc411@oss.qualcomm.com>
In-Reply-To: <20260508-shikra-pinctrl-v3-0-771144cdc411@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778181728; l=4519;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=jvyJCe0RN8MCcynlAWEz42sn7roJV11eMx4pxGp1l2E=;
 b=Me/o864+36S2EWlBKzGgNBLGitpdPK9s7G6zjHfL7l03B1xlVBUrlrGdLVKlfQjTxV0et/HsC
 RF9S7bNs+00AyJyIpeRf8ZTRW00EL46dnu9GAmBAqznQMNzuDcDDuWC
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: qOTo_bS8FxQF12SZGw8ghfuVgan9YPza
X-Authority-Analysis: v=2.4 cv=VP3tWdPX c=1 sm=1 tr=0 ts=69fce66b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=bT5XQOCXPleopHcqzpYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE5NSBTYWx0ZWRfX2AYwx2jQVbCX
 x36ZXRcE6kvBFurmufTrMq5GUj8e3/7E9+KtWghjIQTkouy07SeE2EmNiGf38Jm4zME6p0DIZUP
 CTxWzjBpfDAS8D232txp7nk/x2lSm7QnLUbtbH3504xLwUsdiUnqausdb6MAH8Fjs4XOznhtWF2
 sbtDqtgo6+0kOOGxoyuisZFIBEsgg28waRRBkVSMcfUYD1riAyn0mXI+uN7smXWubLQ26pP8epI
 cvG/EjhYDgBxvM9zVhhxFBXlCQ0Sk9mek+DOiOX0t1LBU8Lrh04WeEFSIBwZV83/aVlgRQrU7Vf
 VYOEq2NECX163jCa9J1uxOxI5fkGhNfkEyZFYbTWz0VIwd3PJqLYnDh6isLAvPjYmbxW2JsYBOW
 qmoM2XEdzV8sI/z5gb5cVnVh5Sm+976++VPMZTy+Y2ZhOYkMdpJfQwXg2ySRqoD1Kq8JH1xMiso
 xFXc3HV+3Ydf0di5/7Q==
X-Proofpoint-ORIG-GUID: qOTo_bS8FxQF12SZGw8ghfuVgan9YPza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070195
X-Rspamd-Queue-Id: 05B1B4EDF58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-285474-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,devicetree.org:url,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_PROHIBIT(0.00)[0.7.161.32:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add a DeviceTree binding to describe the TLMM block on Qualcomm's
Shikra SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 .../bindings/pinctrl/qcom,shikra-tlmm.yaml         | 123 +++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,shikra-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,shikra-tlmm.yaml
new file mode 100644
index 000000000000..411c402f9044
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,shikra-tlmm.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,shikra-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. Shikra TLMM block
+
+maintainers:
+  - Komal Bajaj <komal.bajaj@oss.qualcomm.com>
+
+description: |
+  Top Level Mode Multiplexer pin controller in Qualcomm Shikra SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,shikra-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 83
+
+  gpio-line-names:
+    maxItems: 166
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-shikra-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-shikra-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-shikra-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-5][0-9]|16[0-5])$"
+            - enum: [ sdc1_rclk, sdc1_clk, sdc1_cmd, sdc1_data,
+                      sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ gpio, agera_pll, atest_bbrx, atest_char, atest_gpsadc,
+                atest_tsens, atest_usb, cam_mclk, cci_async, cci_i2c0,
+                cci_i2c1, cci_timer, char_exec, cri_trng, dac_calib,
+                dbg_out_clk, ddr_bist, ddr_pxi, dmic, emac_dll, emac_mcg,
+                emac_phy, emac0_ptp_aux, emac0_ptp_pps, emac1_ptp_aux,
+                emac1_ptp_pps, ext_mclk, gcc_gp, gsm0_tx, i2s0, i2s1,
+                i2s2, i2s3, jitter_bist, m_voc, mdp_vsync_e, mdp_vsync_out0,
+                mdp_vsync_out1, mdp_vsync_p, mdp_vsync_s, mpm_pwr, mss_lte,
+                nav_gpio, pa_indicator_or, pbs_in, pbs_out, pcie0_clk_req_n,
+                phase_flag, pll, prng_rosc, pwm, qdss_cti, qup0_se0,
+                qup0_se1, qup0_se1_01, qup0_se1_23, qup0_se2, qup0_se3_01,
+                qup0_se3_23, qup0_se4_01, qup0_se4_23, qup0_se5, qup0_se6,
+                qup0_se7_01, qup0_se7_23, qup0_se8, qup0_se9, qup0_se9_01,
+                qup0_se9_23, rgmii, sd_write_protect, sdc_cdc, sdc_tb_trig,
+                ssbi_wtr, swr0_rx, swr0_tx, tgu_ch_trigout, tsc_async,
+                tsense_pwm, uim1, uim2, unused_adsp, unused_gsm1, usb0_phy_ps,
+                vfr, vsense_trigger_mirnat, wlan ]
+
+    required:
+      - pins
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tlmm: pinctrl@500000 {
+        compatible = "qcom,shikra-tlmm";
+        reg = <0x00500000 0x800000>;
+
+        interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        gpio-ranges = <&tlmm 0 0 166>;
+
+        qup-uart0-default-state {
+            pins = "gpio0", "gpio1";
+            function = "qup0_se1";
+            drive-strength = <2>;
+            bias-disable;
+        };
+    };
+...

-- 
2.34.1


