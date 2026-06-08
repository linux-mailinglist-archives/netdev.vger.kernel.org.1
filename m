Return-Path: <netdev+bounces-296489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WUGnCvSgJmq8aAIAu9opvQ
	(envelope-from <netdev+bounces-296489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:01:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA52655709
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:01:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=DFLRMLKk;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=T8nXA72J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296489-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296489-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB4253081CD4
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04865345CBF;
	Mon,  8 Jun 2026 10:50:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF3B3446C5
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 10:50:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915855; cv=none; b=SCOdipGOukb/K1Ukg7ES+BFnE/KrZin8LKmzhvf6LONR0XnMErLJoKq5aaQ8YtXOiKAv2W8Y6r3JnR5ZXlhgkSOLsFFKG1IhWV/ZxFoKViC20/AqUX3Apk3+aTZ9H+d9I6AbGDmDuzPnQWewMfgnSUG1ASuHiDSxxFZ60kUgN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915855; c=relaxed/simple;
	bh=82tOqhMxMqDMa92MhjlNmFuJ21oVmwMx7617WZCwNpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qXGRvT4Xy/tn9Lpbk0tvFMbJlmEDxYNK3n4imhPMJ/eGU7YqY3guZ9cYbua4mU7Qx++kvSBayGMrflITytEQjBQNK9g2ZT5oqYR9geNvYeK8kgLqV1eNbo77+Anj5WZk+4/2ZFh9fp5yxQNvgx/3R0vCTrKolKjMJryr7vgK7rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DFLRMLKk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T8nXA72J; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658A2xwW2882026
	for <netdev@vger.kernel.org>; Mon, 8 Jun 2026 10:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N4obobFwXe+ZvslbSpMidwSTHXcyAz/tF/irAKCEVyw=; b=DFLRMLKk18svRImJ
	YbSNuKXpVeYhnoQC/xZGYgAPsHSmE6c+2TGOH/D9cm3sGjzI7bIjGjwMIA0uczm4
	r3DjudcrqPz1SAZiWrdJKO9TvrS871936NGmgRgHWUf/edZpVhTFFruO43YvOIxn
	iHsH78WC12Ds21Vr3Gi+nDQUSjMnP7pUkKTnG3dIVn8kD22gXg2iw4SMGnePOZkd
	IPbkY/mmtwHrKA6K2+g4Ki1Ir9qoVzjGq/kYMTo+XICJg24Zf7g9KnlBXztS8l2j
	ektdzhS5+ElwWotwa+40j3uEoRJH0k6qrCot85rjOQXdApE5N3umoScBEWmN27Gm
	md2A+g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun406hu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 10:50:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51776d4355cso125290111cf.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 03:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915852; x=1781520652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4obobFwXe+ZvslbSpMidwSTHXcyAz/tF/irAKCEVyw=;
        b=T8nXA72JZMotAU4iQcBZ69peJ1Dx8NafLsYP8Z/ArUIa2477HXbDk5y1bYAK8P+v64
         1bPIPy29xHgtsRg4LbRvnvpq6e0vujNW6rTKZzKPsfjp/5QImnA1XKUUNwgexiaheu1Z
         9Q7VgdF0lqHJHCA7Smde3NIgKs76Bzqbppc8i2Sgk6T8E7FnI8DCJpWopbuuDKuUrORw
         1VxtfkQT2p5Zdx2WPNILlPRf9/TyaDsiU3lRp/x+KMyE7zj5vqY13dAbdGOIAK7/cBFt
         MAl8FSTNYxDKPmeqPPNBGOAbxNwDoBAZxSUc9ouVP2hH0KBdiVzF/c9HIdKtpzxkbTql
         30gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915852; x=1781520652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N4obobFwXe+ZvslbSpMidwSTHXcyAz/tF/irAKCEVyw=;
        b=r+6eSi+a2Yu6MIl+KWTrgyYBWKbrMO2j0Ws305fIHnMZXECzSliGhip0rXE9B3r4dT
         HlZ7l411gDQso/2dAa9slEp95CMquoN0qUURCjgrXZJQgcYKdeaamp/1DwhcyriTOpeA
         79U8fGtbgqqOBs43rsZr8YyTwqfGT6LpKZVE3SfjcsnWxz1v6HseNLQuUlaykXCPry/7
         FTDAIItTdNLJnwM/QQ5kTMXhIlWYP/gNglOUOn6SR4awFkt83AyP2JEApCCGaEI8Z/fl
         cA9a4m+cA8jTd0j+ZMQQP5WgVbRo48WJ/RFPTifEYaw0XGkHgMriZQr23aPxCweD9G5X
         xGiw==
X-Forwarded-Encrypted: i=1; AFNElJ9cJJTPVv1Z76hi9BU86+ufrpSnyiHpCNwsYieoxbYHz2TNBEV0E/nvYRYGyQSrweW6bcTcXFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwztvoWwrJI0e0wxrzfHRHq1xycxtyERmEFwWS8HUVkL2XetgWP
	S485waTSCAtr8hzd4bp9nSiX57QZVAHSZ+G2XMVuk5kvoEMq5oUJMClwqCLdYDvrsvzwi2xAGEa
	e2j/SGllMYVMmAMuzEmw3DkLeGHEg/SyMV+nPIbmEDp5xCbcQR3DDNwx155I=
X-Gm-Gg: Acq92OFmKgmzxpccLuWpHtGOs+2VXChjidr92IKXpp/GSwSsOAqghTHISuFKJo7o9T/
	1HNxpOQXCc+KDnH28mY5+QxKrEnJ0j6SAvQbUIo9tgCRhymUQnxVNb5pnC1JrWCu8A2kaAvVQSF
	eEJfAhn7ZY+KDhRNrXlBjQFV18hkEP8jn4O/q36oxPJ/zkxoBMEDBjwEGzNCtKXQJn4lQF8CP9X
	pBjrAi1Xl/nB5mMsAWVO6ikU9DBERZsjyTrYfeGcSe4cQ604i7o0Z0bzKjtc/YFnTTGEU18WIsR
	8GjAu8y1kJ/VCgICngn5gOVQDbqs3cyoaoQU9k7lo+bOIAWwqFVipWjY1URfmZ/hk5dAPEro+nK
	a+J3cHEBz3U3rJ/X7+nm3c9eaCoufP2gw1pNnd0I35QF8kNiXj2C4XU5q8B17ZGCUzjWAgNRLbm
	HR9yzW2FXjOIsmqVWKk+duUnvoQ8/Z4xMEBEnBuWpJxTGEUgzsphHGs31in/Yb9xJcY39KHeqD+
	H16ISOwAsNw
X-Received: by 2002:a05:622a:284:b0:517:88cf:5cb with SMTP id d75a77b69052e-517986737ddmr140531811cf.7.1780915851891;
        Mon, 08 Jun 2026 03:50:51 -0700 (PDT)
X-Received: by 2002:a05:622a:284:b0:517:88cf:5cb with SMTP id d75a77b69052e-517986737ddmr140531451cf.7.1780915851344;
        Mon, 08 Jun 2026 03:50:51 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:50 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:50:41 +0200
Subject: [PATCH v3 4/7] block: implement NVMEM provider
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-block-as-nvmem-v3-4-82681f50aa35@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfXxuGvSV/cXBJe
 FrXWz+yEgmuemn75rDLvHzWs0WW3yIDKofMk3TuwjSPl67Oa259AKizXxUWsr94RPlgSdPQpGBn
 dg6uWpAXe2q/s1wM5p3BZ5HAyhEAIEPOWvv2NQXAVNkLSrrPwjXpszAzYmTnqSCvvFwEcmig3Jf
 ECk708bvtNyVAQDqYx0uHwcCKRFIS8ZO8uK4L+jhARr5AEaSIQvnuPhvWQIV7a7HoEyemURiwDD
 2qNhykOHoe9bWLiaX2uLjrchhR+wc/ypqrzAMQz2Mizhwy8T0PlbDiz5B5t1C0PdxrKHIjabXMd
 VpvCZQvK0Dp7oZPuCfpfturqh/9vpmSnq9Ybg32ucPH5gsBfhTIHyb8rr41yjT3OZdii6T0jkcw
 liv9hgqDqDtlWXCOpJB1KnXP3NO0O5ncSXP8BajDXRCm03SVQIpaViniB2fB+WF4kp5oGLtSFdo
 AQetEmA3L7cCbBJecfw==
X-Proofpoint-ORIG-GUID: hYYxZbuzZpRVDK_ORqGlhiCRmugkCcB1
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a269e8c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VT4XjZGOAAAA:8
 a=EUspDBNiAAAA:8 a=71DuYGxFrHUPmPLwgxgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-GUID: hYYxZbuzZpRVDK_ORqGlhiCRmugkCcB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080101
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
	TAGGED_FROM(0.00)[bounces-296489-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,config.dev:url,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,config.id:url,qualcomm.com:email,qualcomm.com:dkim,config.name:url,makrotopia.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 8AA52655709

From: Daniel Golle <daniel@makrotopia.org>

On embedded devices using an eMMC it is common that one or more partitions
on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
data. Allow referencing the partition in device tree for the kernel and
Wi-Fi drivers accessing it via the NVMEM layer.

To safely defer the freeing of the provider private data until all
consumers have released their cells, a nvmem_dev() accessor is added to
the NVMEM core to expose the struct device embedded in struct nvmem_device.
This allows registering a devm action on the nvmem device itself, ensuring
the private data outlives any active cell references.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/Kconfig                  |   9 +++
 block/Makefile                 |   1 +
 block/blk-nvmem.c              | 171 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvmem/core.c           |  13 ++++
 include/linux/nvmem-consumer.h |   6 ++
 5 files changed, 200 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 15027963472d7b40e27b9097a5993c457b5b3054..0b33747e16dc33473683706f75c92bdf8b648f7c 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -209,6 +209,15 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
+config BLK_NVMEM
+	bool "Block device NVMEM provider"
+	depends on OF
+	depends on NVMEM
+	help
+	  Allow block devices (or partitions) to act as NVMEM providers,
+	  typically used with eMMC to store MAC addresses or Wi-Fi
+	  calibration data on embedded devices.
+
 source "block/partitions/Kconfig"
 
 config BLK_PM
diff --git a/block/Makefile b/block/Makefile
index 7dce2e44276c4274c11a0a61121c83d9c43d6e0c..d7ac389e71902bc091a8800ea266190a43b3e63d 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
 					   blk-crypto-sysfs.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
 obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
+obj-$(CONFIG_BLK_NVMEM)                += blk-nvmem.o
diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
new file mode 100644
index 0000000000000000000000000000000000000000..99c7728fb7bccdc2216780a73a89a9210f925049
--- /dev/null
+++ b/block/blk-nvmem.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * block device NVMEM provider
+ *
+ * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Useful on devices using a partition on an eMMC for MAC addresses or
+ * Wi-Fi calibration EEPROM data.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/mutex.h>
+#include <linux/nvmem-provider.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/pagemap.h>
+#include <linux/property.h>
+
+#include "blk.h"
+
+
+/* List of all NVMEM devices */
+static LIST_HEAD(nvmem_devices);
+static DEFINE_MUTEX(devices_mutex);
+
+struct blk_nvmem {
+	struct nvmem_device	*nvmem;
+	dev_t			devt;
+	struct list_head	list;
+};
+
+static int blk_nvmem_reg_read(void *priv, unsigned int from,
+			      void *val, size_t bytes)
+{
+	blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
+	struct blk_nvmem *bnv = priv;
+	size_t bytes_left = bytes;
+	struct file *bdev_file;
+	loff_t pos = from;
+	int ret = 0;
+
+	bdev_file = bdev_file_open_by_dev(bnv->devt, mode, priv, NULL);
+	if (!bdev_file)
+		return -ENODEV;
+
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
+
+	while (bytes_left) {
+		pgoff_t f_index = pos >> PAGE_SHIFT;
+		struct folio *folio;
+		size_t folio_off;
+		size_t to_read;
+
+		folio = read_mapping_folio(bdev_file->f_mapping, f_index, NULL);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
+			goto err_release_bdev;
+		}
+
+		folio_off = offset_in_folio(folio, pos);
+		to_read = min(bytes_left, folio_size(folio) - folio_off);
+		memcpy_from_folio(val, folio, folio_off, to_read);
+		pos += to_read;
+		bytes_left -= to_read;
+		val += to_read;
+		folio_put(folio);
+	}
+
+err_release_bdev:
+	fput(bdev_file);
+
+	return ret;
+}
+
+static int blk_nvmem_register(struct device *dev)
+{
+	struct device_node *child, *np = dev_of_node(dev);
+	struct block_device *bdev = dev_to_bdev(dev);
+	struct nvmem_config config = {};
+	struct blk_nvmem *bnv;
+
+	/* skip devices which do not have a device tree node */
+	if (!np)
+		return 0;
+
+	/* skip devices without an nvmem layout defined */
+	child = of_get_child_by_name(np, "nvmem-layout");
+	if (!child)
+		return 0;
+	of_node_put(child);
+
+	/*
+	 * skip block device too large to be represented as NVMEM devices,
+	 * the NVMEM reg_read callback uses an unsigned int offset
+	 */
+	if (bdev_nr_bytes(bdev) > UINT_MAX)
+		return -EFBIG;
+
+	bnv = kzalloc_obj(*bnv);
+	if (!bnv)
+		return -ENOMEM;
+
+	config.id = NVMEM_DEVID_NONE;
+	config.dev = &bdev->bd_device;
+	config.name = dev_name(&bdev->bd_device);
+	config.owner = THIS_MODULE;
+	config.priv = bnv;
+	config.reg_read = blk_nvmem_reg_read;
+	config.size = bdev_nr_bytes(bdev);
+	config.word_size = 1;
+	config.stride = 1;
+	config.read_only = true;
+	config.root_only = true;
+	config.ignore_wp = true;
+	config.of_node = to_of_node(dev->fwnode);
+
+	bnv->devt = bdev->bd_device.devt;
+	bnv->nvmem = nvmem_register(&config);
+	if (IS_ERR(bnv->nvmem)) {
+		dev_err_probe(&bdev->bd_device, PTR_ERR(bnv->nvmem),
+			      "Failed to register NVMEM device\n");
+		kfree(bnv);
+		return PTR_ERR(bnv->nvmem);
+	}
+
+	scoped_guard(mutex, &devices_mutex)
+		list_add_tail(&bnv->list, &nvmem_devices);
+
+	return 0;
+}
+
+static void blk_nvmem_unregister(struct device *dev)
+{
+	struct blk_nvmem *bnv_c, *bnv_t, *bnv = NULL;
+
+	scoped_guard(mutex, &devices_mutex) {
+		list_for_each_entry_safe(bnv_c, bnv_t, &nvmem_devices, list) {
+			if (bnv_c->devt == dev_to_bdev(dev)->bd_device.devt) {
+				bnv = bnv_c;
+				list_del(&bnv->list);
+				break;
+			}
+		}
+
+		if (!bnv)
+			return;
+	}
+
+	nvmem_unregister(bnv->nvmem);
+	kfree(bnv);
+}
+
+static struct class_interface blk_nvmem_bus_interface __refdata = {
+	.class = &block_class,
+	.add_dev = &blk_nvmem_register,
+	.remove_dev = &blk_nvmem_unregister,
+};
+
+static int __init blk_nvmem_init(void)
+{
+	int ret;
+
+	ret = class_interface_register(&blk_nvmem_bus_interface);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+device_initcall(blk_nvmem_init);
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 311cb2e5a5c02d2c6979d7c9bbb7f94abdfbdad1..ee3481229c20b3063c86d0dd66aabbf6b5e29169 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2154,6 +2154,19 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_dev_name);
 
+/**
+ * nvmem_dev() - Get the struct device of a given nvmem device.
+ *
+ * @nvmem: nvmem device.
+ *
+ * Return: pointer to the struct device of the nvmem device.
+ */
+struct device *nvmem_dev(struct nvmem_device *nvmem)
+{
+	return &nvmem->dev;
+}
+EXPORT_SYMBOL_GPL(nvmem_dev);
+
 /**
  * nvmem_dev_size() - Get the size of a given nvmem device.
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 34c0e58dfa26636d2804fcc7e0bc4a875ee73dae..ce387c89dc8e4bc1241f3b6f36be8c6c95e282ed 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -82,6 +82,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
 
 const char *nvmem_dev_name(struct nvmem_device *nvmem);
 size_t nvmem_dev_size(struct nvmem_device *nvmem);
+struct device *nvmem_dev(struct nvmem_device *nvmem);
 
 void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,
 			    size_t nentries);
@@ -220,6 +221,11 @@ static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
 	return NULL;
 }
 
+static inline struct device *nvmem_dev(struct nvmem_device *nvmem)
+{
+	return NULL;
+}
+
 static inline void
 nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
 static inline void

-- 
2.34.1


