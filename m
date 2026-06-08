Return-Path: <netdev+bounces-296487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id beO7CiKgJmpBaAIAu9opvQ
	(envelope-from <netdev+bounces-296487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:57:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF3655632
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:57:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=DIbofuVL;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=fWwNbzKt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296487-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296487-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 214B1303ABF3
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA0A33F8C3;
	Mon,  8 Jun 2026 10:50:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6D133DED9
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 10:50:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915849; cv=none; b=Nh4m/Gio4utZuxtX3RDN8hzZO/JfJTSVCxJEuxPWwyqywe86uIj/ow8qxpJuzTCM1KMZuTTrRN54rWOJUXTiNFM2nF6b2fia5REOUOxMWzUjkq372KHcb1QbqAjv1OvlUxxsd0Q/DMz/fkLycXzZdExt1WzAtH/hGl25/6jyGyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915849; c=relaxed/simple;
	bh=Py9S39WSsqNn5txRhNRguCyI8QhKY+XwVW2450FRg1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTd5RGu2S3yPOKUiSVJWddnsDEGR9iWt9x2xCyaROQ6mkFONuQJ1ZaAbkboRsJ0qxn3d6oJbAeyVj+yvaAPNGxGLgG9jnvjM64AwvSlB4+tq/grMdJjpnuWrSFvffn4Vzer/cw2KVRVFcAeB4rXqFo5lL6ORwpYnFcDYIuqdgjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DIbofuVL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fWwNbzKt; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OrsO2274533
	for <netdev@vger.kernel.org>; Mon, 8 Jun 2026 10:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OWi+MtCOvdURNk0hMiFLYvRu4fS7vb184xBw7cGri0Q=; b=DIbofuVLZ0OazGPY
	eM5Fx7D4dpdBevCAkSGgCG4FSIbgCFSVwfZW4LCQAntAgjPxORVNho5v1DCgfslF
	W9kj/1D7UKheGa6LNYtUnNLQJOOex1NVWxTPw0zSfl2lx2eX6JCUa7+aDO+bKy+c
	0rqCQHpy+l1MKNyCZSbY1v3ObgIN6qzypHWDb4Z0yV4PFVe9jK44lABrGw5Fjmsw
	PrwdFTEvzBigxfKLrzRJ5wPt7S6hQ3nCmbvRqXaFkcchzzBXhc48ggXw7gBo+OG6
	LwmZ7+R826Z8AO3t306GnuKl+gyzgYPbqTIR6jn3mGtVnInRVeLXvRIVySfZjkUY
	HJaGEA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgy5je-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 10:50:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51760f997fdso132779841cf.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915846; x=1781520646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWi+MtCOvdURNk0hMiFLYvRu4fS7vb184xBw7cGri0Q=;
        b=fWwNbzKtowlmBTzbBb4R0//1pts1pkwTsZYLOC5+KbgAcm6b3OwYvGiCti51PYmSYt
         Yth23EBRbA7H9e8TqOcwhlpOaWcfNig6tT0l4OlHH7wu5ZiqzYY8gM8pAj4NesmDdqCF
         UOKtZQRn4X7e4YkgxBgPH7NZgqEAMwo2yilwakdq7CCw5Au0tI7HSBhtUOjnDBMMNscu
         uQdY2+5skXjqem3jA45RUX9qfbXT7PSm7qIcsCBCjtdexqRaaCWujC//lX9TNITf2KYr
         qzFBUNK8AFvtBLrp9a6ejo9F8/d710hWsNp6VPjBOVhjQ1flyraBESGMsnhSQDwMMW+S
         R49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915846; x=1781520646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OWi+MtCOvdURNk0hMiFLYvRu4fS7vb184xBw7cGri0Q=;
        b=iTSkjyiFipNMJYdGxJSKatbd3zyxbUNZmY0b/LwmMlkhT2p0LaKQV9qYig8XovJOhn
         AE0YAeZJrnZyWLwrCP/UDXp1iNS/1k1g45hxEtTD2QDC0MiFBK35F54r50UK6sKMukGi
         qFA5RizLWiesA+7jVzz9LW2IvAm3FOzq2CVdQV8ZnfssYjY7p5kPDHZ7pR/gOxfk8or5
         1fppXc0gcKfsqPNP2+N5jFia/ytf2CzG/rfrSK/KMNivR5BdHn7Bco3nwQSRD6kyVUDn
         W/k0tVGPLj0PAcy/vvApmiDeqQulojB9hl1nBenVBOi4ILoTp7M42UWDVxl4ui1yB1Pv
         BH5w==
X-Forwarded-Encrypted: i=1; AFNElJ8JdF+kUEBS1snC4fzHvuHhAvsG949yZEjOAb2ZrZD+RQ7Mrv8qfFoZoBUGa8slIzY8NjNLHg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuwEP631F4TgZV4AeGCam5adbnU04nb+qGGXbQvt/nHUq3yE/t
	HVswMRLrWulxmfsLaQBnplgi15t3TZme9PKf+2PrHb7uTjuNNZgsexIP6QZn4W24fABwghROMns
	w/sRHAMis0sD75PLAc76EhgYA7UsYAN5HQR8ymZGONOd03k7OLoN1qCDvhgg=
X-Gm-Gg: Acq92OEuwr5qSjL7ynNA3B6Jg9Pmkdfae7MEjwJ/1y2of8FkMS8WtUwO9brW1C1Aq0w
	iHgidyCuC5YHqMipJMwaOX7nU9us5COozUU2f7ejlKMmUvpYpK/RZTK0wbSGb84JpzFkh1w/oR3
	bubXF5K/E2O5zhOtDzQ6CwRQPAH9M76KBUG0LqmPfzN3VTj5CFHxwmidTfSwG4vPgntgK64BTRf
	sfxuayq/l7b/Q2jqA+g/Ra4cjN2IKxy4J9BoRO/u1nE5IE6d9fMditXBFceV5XjMU+JId5vG6GO
	HrultIuR9QUC4GRZ+oTmG4HolioT056h1Kh37qIUjAAlxK3fW3rsIQHF22BpaGktRIOXEswtf0h
	c/RjHaVZjCWFPwkjBNjjQGk6hiJHdXtkvbIW2ZRVr/6xbfB4tHWzTZimCVoX0cZ3d2cEdbfW7ai
	1xYNwMv48fyYj6z2XVH0sygSy2pWTz/VQzFIhL85kJ/0VIfcy2r7kg55MQSwLL2mDAAO2deC1sB
	r2MKT4tuswd
X-Received: by 2002:ac8:748a:0:b0:50b:6b21:2a83 with SMTP id d75a77b69052e-51795b7322cmr169213771cf.3.1780915846615;
        Mon, 08 Jun 2026 03:50:46 -0700 (PDT)
X-Received: by 2002:ac8:748a:0:b0:50b:6b21:2a83 with SMTP id d75a77b69052e-51795b7322cmr169213621cf.3.1780915846226;
        Mon, 08 Jun 2026 03:50:46 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:45 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:50:39 +0200
Subject: [PATCH v3 2/7] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-block-as-nvmem-v3-2-82681f50aa35@oss.qualcomm.com>
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
In-Reply-To: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a269e87 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: baxqaAX03wFO6jQ_J2RS0irVJP6XXBTz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfX7NijQNcXJW72
 kgiyQkY65FJF5T7sEofKrwZRlGzo3fok30YDJERzAaRYdM5oT2LQ4QDFAVdAK+hVo6wtURquO+E
 sr7e/BfQf6vVMV17Fp/2LcHsLNvmIW/xsetv4j0MM5gT3NDp0S19Zgu8JuOUvKcHP7WYF+66OS0
 F7kCKby8TuZSO1N48ven1pXP1nLU9/ZznuRDzutHOLOfZbpBe29eZrXLayTE123HlOA0VsceLcG
 4hb3uRnWUGFqkvtTJw+1srGOccZ2f+GNhOZ3XIZLbsK3q2UWh3hFlFCdOV1GHRWETIF/11Eb8K8
 nsmg7Ghc2ewS9txN6LXZP0bPUMmpjIE2EC6qTZ6hF28OfVIGRoWX8ffVez7zHsM01eru3tTZpwP
 J6Gn9/BF/elv0oldpf39zMAJF4tQdbByeWPSMVMFmXsFVo2MB+eOYgCeP6OcHA5Z52aCoQMc+fo
 AwTCbsbxfe61xpZaV9w==
X-Proofpoint-ORIG-GUID: baxqaAX03wFO6jQ_J2RS0irVJP6XXBTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296487-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: 26CF3655632

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

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


