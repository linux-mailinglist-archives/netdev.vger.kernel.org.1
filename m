Return-Path: <netdev+bounces-285385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJJYIimv/GnlSgAAu9opvQ
	(envelope-from <netdev+bounces-285385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:26:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC504EAFF1
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B780C301C50F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BC9450904;
	Thu,  7 May 2026 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A2LhJinX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ww/ZppNl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8AC44DB63
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167494; cv=none; b=oBumRsmPHC/bg8XQfzP8vdBtOPn5UYbg9p3hf+OPy3tm0goHOX0uxZZz/7N/DFddEiCjoIeEKHzI9TS1wtpGVu1DzOymAqiDmSQyVip0s8h9gQnan3JQ/NRGQXQWvYePuazg7387Z4cy1pZovtaJwsyyi8OcxG+Jmb0aHameD5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167494; c=relaxed/simple;
	bh=aWIeQEdmSLhgx88ywuNXkmaIu8+4RM4LnE64b4MEZHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILl4i1aiK1W4cWwqKbkeKg/M3bibQuYeWyQ40BB5a+j3SBFWyERtxnfudJkOI/zQGge3VzAL9Wd7HQB5J6rARQXrdWb2XUwYcsVFkbyLBIy2AKyWb0Ft20swAgNd52cBBGd9eULDdTOgxNYomPI6A5I17hRqCh2+7pZqNfcy3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A2LhJinX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ww/ZppNl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BWfWP3924321
	for <netdev@vger.kernel.org>; Thu, 7 May 2026 15:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BmKkWNysoQOkzQVu0/HpO6GRxwgi9ndXDewfJyYIvjs=; b=A2LhJinXkxFI/S96
	9vte8eeCRxFZ/E3ZYfrJQhuW21ihoIaeeqWVGUT9ZnEWt1g9Nqjg0us2pQSDCU8o
	puKLgB8ksgjnhr+8qycY2wZEqtnKH/wo64eSLK/DgtapCF9gGyZr9Yhp3EEZqXFX
	AOFJ0tp4dfPdwVx6xtbBZfSxwIRsO9nzFdFO2ewf9zbsaanbhqgC8AM9eWRPGm2n
	4K4k+eogj+kc+t2F5nNkwR9xmaMXKzfNi2t0wdIAw6RVTViVO5T8DfxVaqIr9qWK
	na8BUQmp9zy6TMKuJ1pgBd2WFa3Q0sgXHSdsRyFv8baE99MiF4vyAAK78VuqhYAN
	Q5COHg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0c88bs32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:24:51 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-61002acc895so948880137.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167490; x=1778772290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmKkWNysoQOkzQVu0/HpO6GRxwgi9ndXDewfJyYIvjs=;
        b=Ww/ZppNlaLFL0EqBmpKzQputg8kT3OWojN7Uhvdi7r/V8ZJ8eiC7qfjreIC0wmNfdG
         tcpUMaMwDm0CeJOvWzXz9qTW1RA1Sk22grbaLzpEA/I6V27sm4qVQDph5MYITjF0fvLh
         QhF1cJ7oYjl1n6bIL2pOJ2SXC7lJUoNox9Gc6DoWeP2xTHqdWiRNG+STKERJMSlpHgqd
         WolNlsgfG91zjsj2M6S6pvT5b8wSGnl9UWpBPP+L+ll9SFoHIT4gIbxUqB2c+DjHT7kP
         ArqKwd52mPUb4Utufn8Jzw89fLUm02NFK9hN0Ro6a8mJZm3cjoopdhnvnq7c+Wt6rpd+
         VvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167490; x=1778772290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BmKkWNysoQOkzQVu0/HpO6GRxwgi9ndXDewfJyYIvjs=;
        b=ny36bDYghT9/1C9PYIkj5IacRdFjwlWFjvYB+VG6IJ6Da2KR29StnkiOr6P63WMIR0
         jNun7OfoZgeW3l4YGQA9DRcfdGwPTsscjmHf4J5X9S0s4YeH6xxQUCNlxGD9VwkrfmgM
         2uMpNAVO2+dxKGHkycOZ6P2KnqM46I4G1NolloKdzpuv5FLisYo8AEww1oG26vnFzCo/
         75XWHw5A8JmkJktuheExbXcb4F+XCoQkQTvR9CpxgCHUxuLOx8OGXTJ05VSaZ5YtMxsB
         VHlksvzbyiyy11Gi8lXYj3RAUYxIHGalNNEYE3sIsdBMGAvsQvOyYL9Es7CDSMV8+gkh
         73Tw==
X-Forwarded-Encrypted: i=1; AFNElJ9WaDxHOhq+3cRuJOMOiDdiLWQ+sXxMNcHSEEgKlowp4XAejPbYrKu5gDoIs+9dc3E4abt+gcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznss+ybUqigtPXrXlvcDSEBIevfd1EVjbx8VUlry9VLd9b5rtZ
	JbuEsSaPOZYIhpmxy+plBnMRQ1tU8vto2FQC0xSXCrutlCzIfJSgWRKI9srsQf89ze47w3MzSl5
	wfHbUaGn4rX1U232+3aGmn2Hjn+nUhdoXya30/1T0lh1OQo0bGLd2QH+DURI=
X-Gm-Gg: AeBDievhyeoUCSsNwZZXszG/D88oPvmnxZiBZ9ivT0/r83zHzLicgBqe1DAGt8XYhY8
	UQtXoALGY+8EBs8k+QkqCqnY8/7MpCcKFvMcLKQtsHUPWKoggX4sU6MLITmVDja1O7wgptudS3W
	jTfzEXiiOsbdRjzEQAfNLfkECm3zIM1sVOrgsEjE5FdqgR8BxP+QFr3ji9RefnJ3Gf2lGLOiDX1
	kYPX4sGjwuvx7woARKX2DaYbCiJLi7PxohN8rha33kEJWJP9BpEK/cdEIhTueUnVE1EEuwbzqMq
	ems3iXpmUxQZOO5CcLMf6H00b8mO2U9QIc/TeRhFuCWbxqfKTNlqXJHuLyrIZpVYKtFl0+RKrS9
	CKq+FcnlPpIbFz7IgKyJwUelVZlAe1QaxZ5697DG8KosGDgeO2Rl1FFsg669eV06qtn/+OHKtxB
	XAR2jsrt3VeCh2q4lDe7LMILngwBY=
X-Received: by 2002:a05:6122:3a06:b0:56b:8e1c:582d with SMTP id 71dfb90a1353d-5755974b78emr4681425e0c.14.1778167490319;
        Thu, 07 May 2026 08:24:50 -0700 (PDT)
X-Received: by 2002:a05:6122:3a06:b0:56b:8e1c:582d with SMTP id 71dfb90a1353d-5755974b78emr4681359e0c.14.1778167489785;
        Thu, 07 May 2026 08:24:49 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:24:49 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:37 +0200
Subject: [PATCH v2 2/8] dt-bindings: net: wireless: qcom,ath10k: Add NVMEM
 MAC address cell
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-2-bf17edd5134e@oss.qualcomm.com>
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
In-Reply-To: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: IcqyTpcULqIomwV9qg2hjumeStS4GgWW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfX+cUfR/3Igmmp
 gpt8Mho0Vgo41TUMebsx/ZWJrC6xghp//aQHO5SPrJEbUDlHFK62OSQIl9xZeUQ0X8BEMcEbdn9
 rmM49crg6u3AhYoSE9PP8VVT4JCGQMSJ1GI886ZabRAb9bhNLHdZkU1upGI4sNoO83az+Z16VaN
 BtIQ/lkUQCNg84Clx2cGHF4WcJtx4TFIb/cQx7Ugi0TNSLBaC1AT63BjgtxENQaX8KHDtbQD7Nd
 6UcbU2MIk9Tq1W+qssaOtpXQ8m8WLvlbvZSQ2rQgL0cGgZmMsaScKbcBNf8PIAy1sMmKZ/a4yw0
 /s5GB/7zAHz9Rw2sDS62ksetCU57x2MThTo7/E8vVe2sGzY/h+2bx225/0Cr8HypAVQvfqbInU6
 c0OHMOtFq0nTqVf7EDbO1bKZV65jhZcJf5rQKiogjswPO3zB3RE0BvYgAPnca0UZrj+0c9XDVV+
 g/iMyuRgfZntMrLfmiQ==
X-Proofpoint-GUID: IcqyTpcULqIomwV9qg2hjumeStS4GgWW
X-Authority-Analysis: v=2.4 cv=X8Zi7mTe c=1 sm=1 tr=0 ts=69fcaec3 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=yPTVd8cUMD2GasGf7IAA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070154
X-Rspamd-Queue-Id: 8EC504EAFF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285385-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add support for an NVMEM cell provider with the standard "mac-address"
cell name. This allows the ath10k device to retrieve its MAC address
from non-volatile storage such as an EEPROM or an eMMC partition.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..96e025cd1e3acacf3da270ed43955b0d6acdb7de 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,15 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte MAC address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: mac-address
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1


