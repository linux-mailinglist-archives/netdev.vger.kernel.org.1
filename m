Return-Path: <netdev+bounces-282386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOIOOk8F8mnNmgEAu9opvQ
	(envelope-from <netdev+bounces-282386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:19:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85688494AF5
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB09D309B55D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101723FE347;
	Wed, 29 Apr 2026 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XnbW4eR9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SoOp0auG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C63FE343
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468334; cv=none; b=hEUChWbpm6+g/1dSzFn6Y9Bv9xJQRfnawZLa6XWPmlExBZ4OZ2aYi/4pSdb02lu500N7StHXRuVBIP/q3wzDkmove837GtBCQXrSWwWSaGt7zJGT3LnM/6JVXHTeTJ6DVX6EWKdlquOn9B/kYBy4SamXiFEN2GRohJQ5aPFHFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468334; c=relaxed/simple;
	bh=5FeJwkn0w0hoFaU+H21wk2uMRmNaRakanqYwZuX9Z0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FnIM63nq+BdsmBZVJiNtGnNv/2mmynZo61XZBVjUTeYAwAMOO6Z46Z5S/iLY0wgD+AzT64dh9riwVIyJ7HPi9G1PchFeduKUvwlFIH1S0gBmL3O04vveCfzoXiiMVFlHT2xOQGQK/9JvtXhblpXokkKVYciPn5sKNbUr9I4Acx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XnbW4eR9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SoOp0auG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8qFBQ3067056
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TGkFDtlKiI2veKivqw5MXYpsgYHsHTZr/F0pOrS2oiE=; b=XnbW4eR9hu6wr+fe
	tuUGGpL30RjI7YIXVnBBO8gCaPnnk25pwLjpn++ktExQuXoe6sEdEmnuvDXrJDes
	/JqlqSlu7n0XuiCU0GDs9wZkVxvK2dvS9ApeIz3RPPjZe/UAf8jWwkLiy49ygtwc
	oHcB1hXrmfIYI9R/QVn5KLTrXnXw9+hkg6U6lJUtt+CytORtWNAPGZDhJXaoRwRo
	xq/qWi94ReW6Vf9WN3PsFqZT2dh1RtJhi94bP6ZlCZ4lDVqXGcibJxvbCVB583oO
	nis8Etx6bwV+ChTESz4UJPqkR9hIUh/6QI+yl0lysLcfB6fomK7ajuxvfOiUo36V
	Nyg8IA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sxam3q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:12:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35fbaada0caso11797690a91.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777468331; x=1778073131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGkFDtlKiI2veKivqw5MXYpsgYHsHTZr/F0pOrS2oiE=;
        b=SoOp0auGAZwej7lGyjw5AfMiCljTTdmzUgQqlL6go/gnUyVG52Y4N6Y+0tygDCurQU
         Ma56JuDfEA4I3hpRVJrjyyVUF1FngWZ7mpjXLoJL3MhihwM+FCpb5Vmte4WykC3JMO7K
         gaT1MLIeedw73irkgMcS3pXgn+ncJkt6PApqGCbu3RFDv1z9xz54uARO1C/a+ZcIEYc3
         1+W2IcbOp7vNPRYfJfwNJcR0JXfY0T/khybB+MMkN43t3PjmYVFH2AcQu3RVAgj4RJWH
         R7ExcKPS04CcKUzTWJYuN+oQF4h7BOdhQiNuGp4QJemTAvORwhFIooCXLArLebEelaQN
         iJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468331; x=1778073131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TGkFDtlKiI2veKivqw5MXYpsgYHsHTZr/F0pOrS2oiE=;
        b=BLVocV3XQ7GRZVCu24ugc8xVRyh+KqDzcTF0O0Z/fNitrCpdsP/cDsbf2qQvVkA1JT
         1Qt/GQ77JZsYPEbhhLR8IZIKNaXbQoQC97FTjPyT4mJ2jZkKbUMaTQxTvDodC9fU3ElT
         gFtjsOH6hYwKGE0c5t1C5K+x+DGu4m0QOkGtIWB4Jd7n9XiTKiR3OAJRBavvQwJYc4Xk
         1Zv1NBplBObtKHWNxv7WPwYM9a/FeeHh46yAtLzi3P89eZEHTA7Id0Kl0xPakcKSNlmJ
         FRYWg1fTdU5uju8VAKzhThMllekyQiM5Lyim/QZxhqwIhMWDKRajyO7cZ5IOq1Sgk8EL
         Rc+A==
X-Forwarded-Encrypted: i=1; AFNElJ/NyHsQpdI+iwV+C29sIkiu++RWsAN5rI2U2NfOzJ+aslMs56U+2QV1dpDaPbdriOybd0ejdHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4dgmxLuGnv247WwRTMnenf6tZ6w+pOvqw0ifr8UMj/Cs6+Dk
	pKIJDjg5cH+fSLmseOBfNy+vUD2u3ha4GDeSnD91o6MaqRUFLIRTIQw5EFe0U8cBKDzsfIcAT0l
	X6tA3ERKWYmZCljCd1FH7a5b1jLpNrQhI0xy6s3qI+kdbaE1x6rQk7tWFQyTnoKondG8=
X-Gm-Gg: AeBDiesftzCWgQdyvBLv4XngI83HgUYVr9/V31umm3m8pYGo3AFiY3CeJ1M5QA4iTa1
	wMYH5fNIBCk/Acdq0jT94zKyESm4w1IIYREtMal3Xv2eM7/SARDq95OH/WbF+YBfS3JfYVbiE9r
	Uv7CmZdmB0W2RFbTknfaZECJmDBsn1V4urudmEp6kXzlwEUuX3k7SO6dNCDvNaKWV9GQZg3kEOP
	EG1Oq9b/Qv0CKP72icKrNjgzMIs+3TFoVyhC2ZPLgPf5GSHnw0tcbz+LfVFBoyiU7xkYa9FeCuM
	eFhugTsgoUBuDtNDW76zjPjRKkoUsogf4DXU6v5mVw8vhWd0OZEBSI4HpLbIeSuDvEra4P9VtvA
	v6f4phgVURSm/7ookC3eWNG4GMuMskYWV9YxUc7kLhQu/7Jk=
X-Received: by 2002:a05:6a21:33a7:b0:39b:dea7:5626 with SMTP id adf61e73a8af0-3a3af625869mr4368764637.35.1777468331254;
        Wed, 29 Apr 2026 06:12:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:33a7:b0:39b:dea7:5626 with SMTP id adf61e73a8af0-3a3af625869mr4368698637.35.1777468330599;
        Wed, 29 Apr 2026 06:12:10 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed6decf3sm2063025b3a.31.2026.04.29.06.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:12:10 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 18:41:56 +0530
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom: Document Shikra Top Level
 Mode Multiplexer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-shikra-pinctrl-v1-1-1b4bb2b3a8d6@oss.qualcomm.com>
References: <20260429-shikra-pinctrl-v1-0-1b4bb2b3a8d6@oss.qualcomm.com>
In-Reply-To: <20260429-shikra-pinctrl-v1-0-1b4bb2b3a8d6@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468321; l=4446;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=5FeJwkn0w0hoFaU+H21wk2uMRmNaRakanqYwZuX9Z0c=;
 b=5jYkUxcG5qPe/fWWUGltzwDAgJLZr6glLKzLyJP+03Re8Cc4tJBsVZ9G9sEMEt6u+w9eaRTWw
 V+XLS/mm+G9AuFu3CCoI/hgR3eMkZjKVQcDn8YkI3I5xRZWPMyf3+Ol
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: pVSOSyG6Z2bEPwdJFQ64XwQNgeWVzzvr
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f203ac cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=bT5XQOCXPleopHcqzpYA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzNCBTYWx0ZWRfX2yh9mk9iiEZQ
 bPDPo8Qz8E3u6rCCCUcZcs6I/COSdBAVviZe8aa/FfxPuiQ7kOmzulACR1sdlTObSCSc5dxRZm7
 AhdF/FHU3irpt4pZZIzaQyiPRqx1lAS0nZkKlOYgncO4TCMhlLCRFz/whQGLZnaCpGtBzsVwXlN
 LWGW+dWFe/mDwfnPXHTH+E2OcnbuLohthvSJk9gGwKucZnpboZU9JrQ+hWnN0UtRb7k1GpFM68x
 KB0dzYU3+PccAjROHK1Zwd0KYy7SW1mJZIFltjy0ZYFVnaMsfkzIAO4lhUIOHAT6fsRLfJNJ5sY
 RZIhXWiyYtxS5fBDxBTrbO1nuVxP7H/mCGHI1q2BqTtQfgI5PGwaOyEEpF/IWUtUTBDUJrA1sU6
 jCrvxu7zZ4lHlmJyAZhZKGIVOrkA7iEytHYT7ZgQewS4V18gpYkfYi/O7JlFTYomqhorYpBo2Yd
 WePECymW2P3hLHbubGg==
X-Proofpoint-ORIG-GUID: pVSOSyG6Z2bEPwdJFQ64XwQNgeWVzzvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290134
X-Rspamd-Queue-Id: 85688494AF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282386-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Add a DeviceTree binding to describe the TLMM block on Qualcomm's
Shikra SoC.

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 .../bindings/pinctrl/qcom,shikra-tlmm.yaml         | 123 +++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,shikra-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,shikra-tlmm.yaml
new file mode 100644
index 000000000000..896fbe461ef9
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
+    maxItems: 165
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


