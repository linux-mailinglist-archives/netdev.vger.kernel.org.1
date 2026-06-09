Return-Path: <netdev+bounces-296946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 10AoGgXIJ2pK2AIAu9opvQ
	(envelope-from <netdev+bounces-296946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:00:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE4D65D79F
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:00:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mFktGxKu;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=d754NhLA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296946-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296946-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 496E5311CA6A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 07:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414CE3EF672;
	Tue,  9 Jun 2026 07:53:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1013EDAA6
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 07:53:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991605; cv=none; b=oaCm5bIUTM/SgFoN2+qTXPD3K+EeJMtWWWoPFjNGtNsSyn02MlkKt7hpXpoA2RFwJ89kXDudH3fy1WZFkrx0vh9dtjmqghtvYF3Ta5tBMg95qQOc17FVs042cOJf7Ae9S9BcIMT1/LW+LmrtUtVAV+DPZF7CySl1McKdxydedLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991605; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HexkEya2lffz/3gOEAFJhQ2Szc5SKHC2oJlP0x4bwGheAd6PqA/URBEvNEoLqoEr9cghrU9qo5aac8grZSv5cDVW9TpiUqxgWieZU1xqTa1DECFW/6BjmhxrsVI+qOQlRLgIjIVMbazHVzdRgSxen7zb0l4kgcB7FNylMf1Sukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mFktGxKu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d754NhLA; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6593x6Ze1065901
	for <netdev@vger.kernel.org>; Tue, 9 Jun 2026 07:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=mFktGxKub3OBWZqq
	WmvRXRbzTgMecOXVAW0uD4F7zuze8xHExVrgprxqAAD7nDnk/8EbCmQf42UKmaVv
	EY4ZBOIPvyl9sX5iMKvzypi8hRZZKJKBb7fv/MiUGCAi0cmCcarSKpmQIUEtxmh5
	QgowqOHnsq/aP6sjmDd4q8r5Q2PJBXf3axT24MnJAfg/UJzurNToZi+fo+L8qwaa
	iWg4gFPSZg+4uQ5Y2r3nngrJ8whTX9lqDc0KFnMn8p/0mUWMs/OL0HLKL+LtqVaB
	ZC+xgpButnyvMGf7bvxTB9NZZljIe7A3dgHWBaIxrPwBMljD6kczacpfglUutKMm
	PmVrag==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enw5m4q7j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 07:53:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5178ae66ff3so86222441cf.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 00:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991602; x=1781596402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=d754NhLAH6Coen+vdM1OAy7+lPYQu109KuvI/pbA2nIo5eTP3iULRZ9DNBLNBmpTUZ
         i7bxTrn6x2lyDr8ATCUrkOXgHY8dSKjj8Ro+WO+Kif1P5C0lL6cra6qWV42T+rSb9zNN
         KCX8NKJJItYGHv0JNJ/UutmS+3PI9fg13uGZrkg5wlLoVe3vY97SI5uJBpQeD6L7DOUj
         fIW16S2qummtws3qdV4hjl3mLDpBWpZlsKXaLMN/rz24HrJLm1N2ui1Mmx34eUVcNyx2
         XvQkUFrwiLLakg9CykM4lk1R8XYJeiXNX90+YeiqnbOSG6wRhVxJmUo9b3UE6OBBWl2U
         r6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991602; x=1781596402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=nJGMsSaZOg9oXSUkY9yxYO0C4GL37D1M6LMi4f47AEQZMbuuGwtQSorsPWHJlp4d2c
         /wC/FeuIHIfepSa18tiqAkFdYS9AvWwynK8zSKPZt+DAVh7rG/lgxVh1RxVl7cQ1EBGx
         dDdT0PJbkhUCrPo9gxgHxDLF8lGDj+VFB26BQ4nntgDzP8+qvlHrA27jE15G82w9F9Sf
         7jSuSDAWKhh9B4BBcSufJClPCrH2YEtSjMcLYEtbh+Zs2tO1dR+HeyBRWbwNWlQhNsUC
         2bdL9EvkDlKNpVoZ3pttWxzB7P/efnSFk6hmwLgV9FPDOsn+q2cpDV+I5gJtMd4G9PjM
         gqSw==
X-Forwarded-Encrypted: i=1; AFNElJ+xyGWBjCpspogI9jbl0wFCfr/AWIw8ulqn+OQ6TZov0XQlo0IuRw0sQ0VoBn79TpeG9UrJiTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0RT5wdgSrqMg7ZKbLady7KXKu2+kpcbtGGUG4I3/BiBPiPrfG
	hBXT3PtAJx9IIydccJj26LCWLy7FXoGngOt8ihX+0pGbNhwcEYelGqQg9tQomPsfFHMCtFh/3AQ
	TjBMxQ0xTC4kaGtN/XhGAnw0oimMgz8azUE+78nAS+rsuygBf6w6vfZbPYyY=
X-Gm-Gg: Acq92OGJP1RXetI9o34/M4u9yR3WsY9fXepTBqq4qJC0QjLJGsimCugyQYgcM9Ky8GE
	xaScpBMpfL/VLjc0qsc0ik3gdHuQaNI4lEuCm4IkNVGf710fFl98suHpxEePaDdjBYAmdm23dtw
	3zGx6bKP3NRcdgeTq+kzZuW7CQ7PgUNwSAqZ6lAenr7+q0FR48f+GJpDnooSceSTFRskrcajF89
	YnIajhS607MWqmrP3NS33poaa0b2qR8pW4tn9MHVxUOpXtjxck7cncIhX3a+gZtn3HDhhnkslqZ
	u7Z9P4qFyAqcUxQk3cl6vHjA0PnuH11dGy2uQIICUWTMcSgV7+tOctnYKLgkWsFrdwaW0XVA/K+
	3OTFEbz5CCI/ZuC5FI3S0nt+VPp2IvyRxT0rMGlfzYQSRMNRUEpb1yNRPP6010WJkAwUirZEMRP
	kV3t9e0MuCzmnMyURABRrYtEVLd7Lqw90J13CHmfR6iIYreXsNvzqyjK8BoxpurQ6P0xhSDiRVy
	JwN1jiiI5qo
X-Received: by 2002:ac8:5c83:0:b0:50e:6313:6e13 with SMTP id d75a77b69052e-51795a829femr267703771cf.5.1780991601769;
        Tue, 09 Jun 2026 00:53:21 -0700 (PDT)
X-Received: by 2002:ac8:5c83:0:b0:50e:6313:6e13 with SMTP id d75a77b69052e-51795a829femr267703571cf.5.1780991601346;
        Tue, 09 Jun 2026 00:53:21 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:20 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:28 +0200
Subject: [PATCH v4 3/8] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-3-45712e6b22c6@oss.qualcomm.com>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
In-Reply-To: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MyBTYWx0ZWRfX0dhi9busCfJM
 zbNJoYdSrFgWbjpTrbrwlMBdeA7YIiO9NfrPxrH3HZexLaGWgVjHTiaYzQDR6b4oZfCJRwFv6JA
 dRUhzx2mBHfojPoyZly4LPfHlaahAH8PXEKVOH2cccl/tyIF52jsTBLukC8SMv3FOHUH33EHjym
 sFpp+01KoBQ5r/frHo+qJ/dcnRK65n4lvwaRUqS9hf3ZonmqDUgIzcBkGa2zG9g0blRxqgkv/SD
 efVSUVOuKaukNNOFvFXJwWLKKhp1TXkdnb+2sYuAJULqB42V6A3lYcrkDyTqKNyd5GR5sIwBFpG
 4s+qN+LUmdyl+grrKPZIeWODiiAqe5pSmufA6nynfJFD8+BOGUFLAYLJVhv1JrGPll4PKT+yhQD
 WUmwfIR+EtonKs0fAO/cjTzhQIvgOaJdqaJ5FXGkky2Z+qNU7LQB9tWHojdKjgVWvbL54bISR2c
 DJzIXotavhQCtvsTwiw==
X-Proofpoint-ORIG-GUID: cY4VXctxH1q_cbYhTibQPmNKSBJBIRs_
X-Authority-Analysis: v=2.4 cv=UptT8ewB c=1 sm=1 tr=0 ts=6a27c672 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: cY4VXctxH1q_cbYhTibQPmNKSBJBIRs_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296946-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEE4D65D79F

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,13 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1


