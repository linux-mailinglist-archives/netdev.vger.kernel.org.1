Return-Path: <netdev+bounces-296945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +rPqHUrHJ2oG2AIAu9opvQ
	(envelope-from <netdev+bounces-296945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:56:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B16A365D6E6
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:56:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=oGK78Hh2;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=i2KZVGF9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296945-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296945-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDA103063BA4
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 07:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7413EE1C6;
	Tue,  9 Jun 2026 07:53:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BBC3EDAA6
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 07:53:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991602; cv=none; b=nWtTgu6GKxVdF2xxpgxyErHmBZFueO/cAz9WQUwinN9XvdaMl53MOS9GB1L+2AqvueY7Qxj/SbhtVRrCmZgjXjVVotiJ85Rsu5d4ULw4CdgM3kMUHFZ3I+tyTP5XcHy1tU8wRSK061DKGzjs1kBgwD5ceiIK0k7B1mJBb38dcvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991602; c=relaxed/simple;
	bh=yYJ5VBN7wBwAYsQ0zlbRkE0xdiTrAcSbG/QNNToAmpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uaz23KypEyUPCT5LRK15usMnlYEdJgnINZ1YtDqyqsPUERLE0SXeLZxESplJWcEyiB9JR9IQmgoME9zCnuWGByuRSoAAXNLBuy5sISQXCAFQ804VsdlOciez/E8Ibw84fbR94xPYmuZUZLXHFn4YGMNFibvgyi/JYrvRPzSkfiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oGK78Hh2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i2KZVGF9; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6596xf6R1878378
	for <netdev@vger.kernel.org>; Tue, 9 Jun 2026 07:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aaVv9Eurf6ixxwY7bJNLCZAXbfQRk7/8Rh3U8IOXpwA=; b=oGK78Hh2GvSSk3nx
	gRnEthzbKV089nIAjT+pSAu6UIWXHONVitXv+kCiYNajab87B+rFJbZw9tkGCq5B
	j1v0xQtK8QFmGL4AiAHzvO3DrS1j7d0IIx35SbMpvtzTsRXJqzsPsFplwmJ/7Uik
	xha+82hUokTCipYZ1DCkQE+tum05qEMgwTeSbTBu7/e0n4Qky/Kv7swLuSX18C0g
	g6uS3XehElds/iQla4W4q4foq9qDeMYFes1lTTi5O9+qZi7jVPiUZhNLFx1xcdtm
	WR4lK1+q0aM/KbvRlQQeCaaUEpY4u+rq/tDaV0fQr19uQbHeaLK8b943DzeCPHc8
	vbkc3A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epe25r727-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 07:53:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5174a23afcbso63819721cf.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991599; x=1781596399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaVv9Eurf6ixxwY7bJNLCZAXbfQRk7/8Rh3U8IOXpwA=;
        b=i2KZVGF91mQGjTrM5kNMM4SRccjv4N0ywQEgHq7IwuhIdSAqfYPmyeRAl331IPEjBh
         3JDUe3AayiFFmN/iKmc2lsYEt/POCUtyYKE/KUa/xF7sqS3SEViXrrZ1a8zSJ3fJeEHz
         fm3XnSZ+/nDQ6j+7d/PMCGeO2UT4MEP4d9AOC35PatwmhNH7v4mKek6LKeV/8VvFw6aG
         KXhWGhEgFHXapB3pKIS4wkXeYhHu5ABtpHU8bDkinDUwG4LI2bq42g8XDcZaRHkLbd0B
         JmE0fT/l9h5LSwErG7GIHZlvtABLzapnS8ubiTpaOymFcxgMblsOgvWyilq6DqAv7vRu
         PUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991599; x=1781596399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aaVv9Eurf6ixxwY7bJNLCZAXbfQRk7/8Rh3U8IOXpwA=;
        b=XWilMT3vYEa369z/LLBE3AVIB3/2zHLYsmLQgJXqQywzmaa6OZhp/0k4w7+JGHKlCn
         TCXqMasjpMjVQe/SJ3pgFa9LR+eX7bBfAyIeW5AkD4uRiwqfcdsMxW7QrvnwyEvtfoM4
         auRZqKwdLTtyLfcm5wefIZ0JmSfVBbAmeX20tRPA0mqM6ouf0T1GmatuCqGDF1P5W4B6
         Ioeabpga278D2v9jlNJ1P3gqKAXedm6D5X2uMyFzgix+/LFQybWzkZT1tetQ8i0FMUB0
         2AhlwSEtzsDTwbde8qUSe/Qzy2BGTl6umQTF0/1FHkglrCBTGfT6umRFro2NLU1L3KRg
         WYZg==
X-Forwarded-Encrypted: i=1; AFNElJ+vj6tPAram/F2HnIKhooPu93D03eiqEUWruxxCgIZPm6n4roUCQoUUBGxlTzRA1P9O+NnJYyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHssNFpbZdW/HENiCV8I+sf/7DHTz6CuH0jNSQlM7azUQHyMzF
	HEDtSbY1nBcH/367VSAbRln/rtQK2hbH4u5kBL6MjUP6GaVixLKQGSgmIVgcPkGAtA/2xYSg5wg
	iV1jVdQrHqG/XUKg8B9N4SLIaEsseWZJsqYiMfhQfU25ufEYSW1QUx8r4Nv0=
X-Gm-Gg: Acq92OFbEvtcHVvedCa/JLzuKTq9hQoisH0QYAgI8kZvFFU591ENe3HPgWEX9JCAvDC
	4L8W/eoyn89ioNHBs6jjCVcRhDXe3ZEuYFbA1P6Huzpl9+1si1U/nsGIt7UX2u+Qor5wAZcxjS8
	ndrjFYt0nWiXsW9y7xYJ+iebaL0SYIk/DzDoA85qYw+Ndc8QHvjkaYtIUko7poMfUFZBGbtK719
	Fjo/BQnvfAzZvgiSzjt1qXlt2VijwjUDcnpiVzFm0Y9qz1cWlLugmQuHdcKFnFvnCByeZul7zhq
	wIDKCnsODRkpMWqpneSccIH99WuQgWssId7K9si3OOstu3wfoLetcBBRprCDbNXv0C1Ig3jtQ0v
	VTjuKRXRgswDfynPHu4C+RMoCwnBSz3KpCkDDqusC9ffAnrEFedu+uGtaTlCzXYVls97TNdzUb2
	cfoptvvIWts6U5LF/StXi11G4OiTv7vQFUtM/d7cTLakb0zduXoXzU+s5stF2Fg+tyIcpa/w4pl
	u//QZXMa22y
X-Received: by 2002:a05:622a:1a98:b0:517:a9ef:ce3c with SMTP id d75a77b69052e-517a9efd0bemr186043471cf.24.1780991598502;
        Tue, 09 Jun 2026 00:53:18 -0700 (PDT)
X-Received: by 2002:a05:622a:1a98:b0:517:a9ef:ce3c with SMTP id d75a77b69052e-517a9efd0bemr186042831cf.24.1780991598097;
        Tue, 09 Jun 2026 00:53:18 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:17 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:27 +0200
Subject: [PATCH v4 2/8] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-2-45712e6b22c6@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Eo_sgqeNItHUGAAuMYYOHfADmfiFqSaC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MyBTYWx0ZWRfX4veZ+6041Wsf
 b6TOoDB+p+vuM9GtGKmJzyOiJAfaLTIbK9H80Sxql2pQyhawb/DY9mpMrF2XUM3Y0Z5QmwF1tuc
 ZopPXrAap/d2BGq6bBpnvwC4l1HptPjTO4QvlHi0UxgqhTGmwHPyYMW1nInLR2tAZrFd5EhX/i8
 r5Cc2AI7pTH+iTLUcW6nl0nL5tVP7HHN62RwW4ZqckALHwD8A65VQKSeVROUuPpurI3STNJXQFy
 Ol6m3P+hV3XgW7Gh9ykuUGkVZl4pTbvEoOLHskbTs/a5B9smEelw5m/qK4oOm7QeSWVCPa1U/0d
 Jt2sMNmGkbZ0kdOf5msy9ZAs7QxA3/53lHXjG7NGO7QVkfYKUosBrfxxyjJ8EbvXflcXFrpj5mk
 SY8TTmtcWYh9xa2jvtuOsXELJHRMSDTHrsXKFmKTcXe6KjpbjS1Yx7v6kJtOPyY/4c+B1qjioUW
 jV3WeXqsl7dah9oMhIw==
X-Proofpoint-GUID: Eo_sgqeNItHUGAAuMYYOHfADmfiFqSaC
X-Authority-Analysis: v=2.4 cv=LoqiDHdc c=1 sm=1 tr=0 ts=6a27c66f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296945-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B16A365D6E6

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..7391df5e7071e626af4c64b9919d48c41ac09f1e 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description: |
+      References to nvmem cells for MAC address and/or calibration data.
+      Supported cell names are mac-address, calibration, and pre-calibration.
+
+  nvmem-cell-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - mac-address
+        - calibration
+        - pre-calibration
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1


