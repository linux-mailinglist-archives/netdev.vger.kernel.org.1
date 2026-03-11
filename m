Return-Path: <netdev+bounces-266715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EKQEeSgsWn4EAAAu9opvQ
	(envelope-from <netdev+bounces-266715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:05:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E22DB267B83
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAC983122794
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D433E3C54;
	Wed, 11 Mar 2026 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bv83wDQy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gfeQGvct"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE93E3145
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248649; cv=none; b=SvWsXZj9AK0+zgS8q9pmCQeLWNDQwUKA3TdGWnnCMc7pk0fxoKqynjBIZlUtr9eUumzgYNm8WgNzxHrdLSjJy/p7s0EeQBvaiNmLIcryvfmCMDuaQqMQGHtZ2NYVqTITXGcN9PbPFRpSdZHLAgZr1HoefezXfxylpnyPnWw/W3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248649; c=relaxed/simple;
	bh=jarMP2kx4omN4KmFez4/RzYUXczgrQKSOEW4KJFpBFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uWZzOLP3AS/WXiYH6vNoczdh0A6l/JL505BAfF27nKj+YCCHCp1TN5X98Qpb33V+TDgGkch846oGIxajG6oVen5+pumxmaVxuyPQlTCs81XEI56Tk2s0Dm5DFPlTtEIb83E3XdC+tSCBujQ703JgS78IshFsVSeQVgUyhZXcXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bv83wDQy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gfeQGvct; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BFpDD53172234
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 17:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gdxx6+E9Nzo1SIEzhKmedbjW3ho5UzPgZIwDTMk23Hk=; b=bv83wDQy2b/EsaRU
	eJyfDUe27dHZSKDxXetxfX6xMwAnt4QbesB4mvz+7iHrdwV1rvKptFYh6B1krTjR
	ICyvXoN67ke/klwfb1MvrYNu6wLFzqLBF4Cc74CqjSdJf8TNVUwc4A76ywj0JFj6
	fD1eXV9P42pNfMu9GoKWgcnjfkMXw61dpW8ggeyyMJ5FSJF5mXTRQmXS6iggjwiI
	DwS1jKyz2hHSGa/xLJqyW3/WQxBXvW7hgdGZxpl1qvXByMxQOO+/wew+3VtWM+C3
	t5dvguiGQLTrmYnth6uLCo1Vs/ynkR6dpc36U4b36pMRUl11mwog7Ee1chminHMz
	KFriPA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cubd8r9h0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 17:04:05 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5f934f736d4so146271137.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773248645; x=1773853445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdxx6+E9Nzo1SIEzhKmedbjW3ho5UzPgZIwDTMk23Hk=;
        b=gfeQGvctsrWcytLy0+llDCOW1pKiyW59jPRX7qcksK0Kz0iIeu2z/K1kSGTmZF+miW
         23E45jQZfLTkCR2I7Or8uHKdk+wbazmy29sQRUIWdO1EPhuylXRk1maZitJfzwOrUQA6
         Mr4Er8fKD0HbiJ+U03kyZX6fySVDaaYX7QN4NOmbOBhTumn/Nbc8iotmNTELH01ETo5a
         hAPtGDk9alJw1YAwl4sr+xnpdMnqqkTuK2sTywVWOwn5W/NJjZRPYvzGuFRdar0QNQ58
         cdl8zMxlkz43xGtRtrbt1q5BXkoCsVXxm1u6IqmLBB5krC6OWatTWRYqmipyXNMmKlL/
         mIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773248645; x=1773853445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gdxx6+E9Nzo1SIEzhKmedbjW3ho5UzPgZIwDTMk23Hk=;
        b=CbqMmkeuR2MvjjtqfqueLt10PhwWuRA2Ix5IZ0CRd6obsr+GfodnyT2Jn2LhKs1IUS
         /fGYHXfYx3ZbGbNp/GvKCcRJKlpPF1E92aw19I2u7QTrPJPmAJ4bvvIBqp6PRiKexCE4
         14tIq8dW4l1AhFBzLoqqJU0iiDaDJTMKqxVEkwMAGmNGkm9pYzI+IGfK8B7dYSxDepH/
         j0Pg63hycjYd3oBIlUnPf+r3LepveVgwAqD+qTl8Y200PuWmLTwn9lk41MxQ14xBqRS3
         OoSY2UkaPvlYWKk+qSbVfZu5rj6da5Em7uFvt9fWI6pjBF20YRNf8zL30L1nZBvuEipw
         48uA==
X-Forwarded-Encrypted: i=1; AJvYcCWBtc72usA13Qc2ZDL/dYENo3Ho3b/zz/AxTCYrW+XFKcp9pUnfFd8S5Ry5Ptdg7puw73QV0cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrEnxvRr9bPILncn7Ljt57NGMYT79VZMevaqzq+rsVLwOPuMkm
	rqG/NqA1X4k5qHlI9LDY5EeGZMUUas0FFEmXkRupPHD/P0VkI3SPKcqLpwc3p4tmHueDAyMw84Q
	rcjanCBSGhyewLP4lx18MFGI88u5CD9P6ud6w5erQPAqVRF9KEKQV9DYW87Y=
X-Gm-Gg: ATEYQzxcflYYG9soVyCmu+tz57FHJUSyllgSIhbBtoM1X8LzXGrHf2BwEIfKs5h/rQF
	CPa5vFNQtuBzMXDeXDZEbgYStH8Gni2VAf6WjlCtCMC8DwqhBWxcJCZg7PR70qhViQ3ylPBO53v
	p44A9sGkTE8RXcNQVwtwEOJTkCk/QJ6/wdp8zYiZW9LEBTwLhfKYh1wtbqsNDPpnKM35AnPLVb6
	qTSriOYznjZYcATVtsilbgUuIK8m1j2OEnNP/x2h4HrCS0Ktr9QuIy7TBK6MEEWOibVs6KwKuaG
	+cvRUSOQTV37IAz29ibF5BitHl1lvUI0oo51Zgtp2tYZ59z8ZU70wrLPyV3SRXUxIXVXfQ/0pWY
	rEPzkfXrhi7ktlv6KeHe7lR7cHsnmU8S6c6M4qdME854tDuUbIYCO
X-Received: by 2002:a05:6102:cc6:b0:5ff:cb2c:a013 with SMTP id ada2fe7eead31-601def2ae84mr1132894137.29.1773248645235;
        Wed, 11 Mar 2026 10:04:05 -0700 (PDT)
X-Received: by 2002:a05:6102:cc6:b0:5ff:cb2c:a013 with SMTP id ada2fe7eead31-601def2ae84mr1132877137.29.1773248644707;
        Wed, 11 Mar 2026 10:04:04 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:3a92:6740:d71b:5056])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ad1e4esm167993075e9.8.2026.03.11.10.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:04:03 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 18:03:37 +0100
Subject: [PATCH net-next v8 2/6] net: stmmac: qcom-ethqos: use generic
 device properties
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-qcom-sa8255p-emac-v8-2-58227bcf1018@oss.qualcomm.com>
References: <20260311-qcom-sa8255p-emac-v8-0-58227bcf1018@oss.qualcomm.com>
In-Reply-To: <20260311-qcom-sa8255p-emac-v8-0-58227bcf1018@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
        Romain Gantois <romain.gantois@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Radu Rendec <rrendec@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
        linux-riscv@lists.infradead.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3058;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=N+dHjWXfvXJHTEYUAiwtkC+XoS225MOcRMNA92C/Jpw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpsaB0v3Sl4/sp56iDGfrn63MUk6MjZIiJTzfXf
 w26BYwssyCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabGgdAAKCRAFnS7L/zaE
 w7sdEACZsFXM7p//CfitX5UqpB/btkY4zsW5EXkhS9yfGCgabSgfoTX9DsKhv6sX1pJTctxW2Jj
 WdJ4s1IX9/7vW+acevWWapCmtarWxZ+FS9/DUks7wrNii8FysLTpAIkKe0yb5Vqb4aazorFJepZ
 QMklj/TPR9rnPTjYCcYpO3JXPhxHVcWSGGj1T008VYY+H1g7HC3FLiYH6OztIN8m28UXC2wXXjm
 jjH4O2G4j9lQU6G0SgnnRbMSc5bzei51WxJdkBgnWXq6cFPr/qoGF+qKHbhvXfX8uR1zt6xjh7E
 rK3dnLYpwERUGOXR3HeSSv94sEOlLLtSb4ASnlh5jiCiXX/7RsM6KJkqmVNBo9jNfKUBNTFEc2E
 Rk5QW+Q6QSiC8UUdHRgwzNOArdNWh7pg26eWfgQ/vMR8QPG57IiUS6TCQS79ajOAwN2OR3aEsAy
 4xwbeUPCe6I7NV3ncRMyuLsaW9Jx02+kDJTSurrKERfV9cqSnWxe8/3veaJ6cZIoqd/BwOgrRyp
 bPAoDz1Bk3cC3oqL5IKaxnXwFO/vosOgfVJsMn49Mio14B/mDN3if30VdgPxYKQzrF26XeCHPTe
 StSJ5KHRTqpETm5niQmB6XFjjOYPG1MCZFbE57IaXGvRChr4mErCe6uLSs6x3CR+iLYfB2jRfnB
 5p7afV75hsIVjkA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: jx95Ff9zJmZrIjFlQ9P9ugyyGQnhWK-P
X-Authority-Analysis: v=2.4 cv=eqHSD4pX c=1 sm=1 tr=0 ts=69b1a085 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=AGkLNbZTeN-MX8W9OO4A:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jx95Ff9zJmZrIjFlQ9P9ugyyGQnhWK-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE0NCBTYWx0ZWRfX1RNJKWsui5FM
 F2S9W26jCOiy6E0F5JreW3qRfmWwXcUwNsa8GDUG8Fg2i0LUn+QANZAt18sbiaTPif+lA/HOttD
 13fW+r9MXnScgHZQ5efDACM9NoVA9DogwCihrVpm16sA19J3yurBNd5cKwR7DamLH8tPJWuUYQu
 xeC6t+47nFzzrP6cJRPbF1KplhRXmZdI4oZl6MCpPJUZ+b9VHHf87jM+gd+YKLda3CMrqfvB+o2
 RW0mcN8I/gRznCXlUd7mPdHMq0vaVom+oQinhUm7NGsCp8E645Vaqw7jYUFAZiJjaQT48QAuTfW
 bIaYpyx3lLIfQWpS+PCWcm8CpAJSxu28VJiybMHLeNuAV6mlhi5p3prCrT9JSr8oFW1X+Cc7CwG
 CAGUcZnGG/I6GT/2MpJcP8U4PCXjxsT5SwbCvDjg5ernT4xUUbPPmeNnwe6pjz7eu57zNA2jffh
 LJsPonruUUawgb7hvXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110144
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266715-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,st.com,linaro.org,baylibre.com,oss.nxp.com,nxp.com,bootlin.com,glider.be];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E22DB267B83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to drop the dependency on CONFIG_OF, convert all device property
getters from OF-specific to generic device properties and stop pulling
in any linux/of.h symbols.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig             | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 07088d03dbab5bd1abf66e9460613b839c1d565e..e2af4fdd654340d618477ed87d3889dbb9aab456 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -135,7 +135,7 @@ config DWMAC_MESON
 config DWMAC_QCOM_ETHQOS
 	tristate "Qualcomm ETHQOS support"
 	default ARCH_QCOM
-	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  Support for the Qualcomm ETHQOS core.
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index cb1c074c205307bca556192584fb0a4a10eecd47..fb4ffd0d5360d091bf0192740b8a4a8d2c66e09e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018-19, Linaro Limited
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/platform_device.h>
 #include <linux/phy.h>
@@ -728,7 +728,6 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
 
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	const struct ethqos_emac_driver_data *data;
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
@@ -778,7 +777,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ethqos->rgmii_base),
 				     "Failed to map rgmii resource\n");
 
-	data = of_device_get_match_data(dev);
+	data = device_get_match_data(dev);
 	ethqos->rgmii_por = data->rgmii_por;
 	ethqos->num_rgmii_por = data->num_rgmii_por;
 	ethqos->rgmii_config_loopback_en = data->rgmii_config_loopback_en;
@@ -818,9 +817,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (ethqos->has_emac_ge_3)
 		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
 	plat_dat->pmt = 1;
-	if (of_property_read_bool(np, "snps,tso"))
+	if (device_property_present(dev, "snps,tso"))
 		plat_dat->flags |= STMMAC_FLAG_TSO_EN;
-	if (of_device_is_compatible(np, "qcom,qcs404-ethqos"))
+	if (device_is_compatible(dev, "qcom,qcs404-ethqos"))
 		plat_dat->flags |= STMMAC_FLAG_RX_CLK_RUNS_IN_LPI;
 	if (data->dma_addr_width)
 		plat_dat->host_dma_width = data->dma_addr_width;

-- 
2.47.3


