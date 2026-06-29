Return-Path: <netdev+bounces-302508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tXKaFRQzQmqp1gkAu9opvQ
	(envelope-from <netdev+bounces-302508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:55:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F33326D7BA5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:55:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gtV2aL4F;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=KAcVGx79;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302508-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302508-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC7D8300E5DD
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93DD3F8EC9;
	Mon, 29 Jun 2026 08:55:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D089C3F86E6
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 08:55:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723331; cv=none; b=t8aZ3gqGHS0+itpYssM8uV7UId9u/fFE8jqtejVUQ7VWVuWCjukiGLizGJL/VkkhCdVRsFKIC2vMgvUfnxG9V/kotOkjT1suf+HaLyCpWRg0ZXr1fFX1ks1KdBBf0NHp2iQyu4BqwC1RtQIxk9e84YiMmxb5xgcyYk/0HVOojFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723331; c=relaxed/simple;
	bh=Q5Wxi0COcXv/gy+y0D0pXiE5Pb3m9E8JU2uB4atickw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZzGTKCptQ+MFrzVm+8+AReouFqPi4EnuNLdISMxa9faa9DlnFTiszXaIAHvDqtd9I32G4DSaCjgKU4O8s9oaqS0DJxgw+Z2sAQIj44Mk6InzXi21O6VmeUhuqbeQWtt/qPKJy2GUKh3i5zSJqLOVsW9nkeJJ25132V7aCAIbqv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gtV2aL4F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KAcVGx79; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T7E0La2188890
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 08:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4BGE4mxzpnz+OGxMlb54QsPRqPzv5icpmnSVCakRRL4=; b=gtV2aL4Fz4LX+hTN
	/6NwxrnCWdM+NDO0SF1lVC8rX50YHMG7SNeEQckNKu96PogiLC3h9k3LukSLeYpj
	cX+KIGUoQbqroZCojs52V87NEE5uP28/DtA75oDUqLuqgsSovEONCnRPclFqQNFy
	q8S89vFDTM8gdUPATfPSUXiXIgsfxkBKO3txBVDtCcVKLCcfNpzeCNR4OGjvDLBK
	e6O9jqYaEX0088rI3JAgwT7Ztw6C+yd1Qib3ibfIAIV+/cVt77+BA4k5vz1SKM/g
	xPP2NSZ/AHjSrOYPeHB1bsQQvD31SIsxa4+4qh5R0ZE6ryuH0BDBnNVzEgxLwlGe
	31j9kA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4trdhc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 08:55:29 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bd797e447cso3766880e0c.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 01:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723328; x=1783328128; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BGE4mxzpnz+OGxMlb54QsPRqPzv5icpmnSVCakRRL4=;
        b=KAcVGx79T7ZUy4531wrr1DA/Td5xk61qZEVGVKjhE9OCfO1Iv6He881v93sUvvY4Dq
         hxO0EMUSbBYPpVPd8OdLIZHYbJxpJQ3vq7ZA3y+UnsVw0FyfrAWpXJWVkI44Pu8oX8Qy
         pg0ow4N9ynHsh10szYPCLuH5qdNeWyi6KX2/VzBhXO9XbqshMbfb+qGRBZtRqJpLdYHR
         20zWYvrLfUWuDBIKYYpy+HZkF1HkhIrBpIV7THG+5FoKMYAJmSv2xYZbSl0KVXyIN7qc
         +SLZLiOhrCGmW28z/vqp3khifRVrzUdgR2bKmd9HPKAwxO4w1iQqFlYMpqYvaR/2i5wZ
         KqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723328; x=1783328128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4BGE4mxzpnz+OGxMlb54QsPRqPzv5icpmnSVCakRRL4=;
        b=M2n6OjFyZAPyAKV3P5BKeKF1ifh0dDY1XxG4JQKsl5roZz4WY+n1QqTJksfvKOvxWg
         j/JZdQTvB/Hv+s8xeCIEs2TTzPF2kW2lnPhc+4UTNdLfNqFfBsa81ej0uyYqus4dcCFV
         wXJQRIjj9CBs9S9BM4DEnccuAe9XtTubxoA8bxaYQzmn0IkDTZriPjfi0yu56ehSSZ+3
         22nEzLBsMhAlJ5z8TGghJ0B7p3oJis6Ii00nafEXeEPqv6d9VCr3x9oYsFsAH903i7Xc
         KXMWgg1/nH1jgPWx/GW3YJ7kZOcowy6mIH9E2ZWhfts240RU35gIhm8OvpYjk5Aw9BWt
         d2bw==
X-Forwarded-Encrypted: i=1; AHgh+RqbXBngQAXNatPgP1pv8WqenjXp8b5xIn4Mmm90afnyPYyb4ICQCv4l5TuSpwmhiZjdK5PRRi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygWQkwQo5/3PBhACvdft5AVw4wh+h97a+MtWnDKfIusW2GDoEw
	pLgMKlGoFQjFhzSzLIeQeyZXXY1SgsdrOEWax1MGeW/av75bZGwhkKLgFnGf1shhuj8N/tTl63K
	dmXcTkBBO4XbodJGep79QM6SxwRvdKV2RJ6oNoikl24lZdMyuXO6d8NjRQtI=
X-Gm-Gg: AfdE7clcZlRf9vEZw4C2nsmHxAhLgU/8vo1p/JfY+JfKHTt2+Ny2n81Uf9Je0/ekJHs
	8kdjp7GJnR02AJvzkBJCkmxbmaX4oLA2Ww2dWJE6sISgA4Dx98Qd5hNx0Uc/X770P6sbaHKw64L
	4SDXJMETW1ea9FWZ1OgIHlscksV87QZhdc7SvwhjVCszysTS9LWOh8CCdHIL00Ru8RTXg4KYGgU
	e+iPiHKEQDl60DFyqgmuc7UKBiwtYUXVFsKtPe27PjJk4zzVTJ2qAmMwSjC10kazYS4GLM8U8Dt
	slpowInt3CMKnc3N3ddRivDPM3rn7WIgMMsqvFHrv+Zxz4UQIwZSPyrissTh03llXGaJthQapwc
	L2N7VCtA8muyC0DvwPoIRpecKzsAFEksp82ax0ihU2h98qS9NAjX0nmHWSiPdkiNGOZZgrHINvs
	tXPKo9gLNemxaFmQsqPs7yN+qk/7X56XNKyEkUEovwGTsyGyovxGYKaLV8Clo86VKumC5fSm4vr
	g8RnxcmLIjoFQemIa/b
X-Received: by 2002:a05:6122:d12:b0:5bd:9d27:1ded with SMTP id 71dfb90a1353d-5bd9d271febmr1874524e0c.3.1782723328062;
        Mon, 29 Jun 2026 01:55:28 -0700 (PDT)
X-Received: by 2002:a05:6122:d12:b0:5bd:9d27:1ded with SMTP id 71dfb90a1353d-5bd9d271febmr1874507e0c.3.1782723327621;
        Mon, 29 Jun 2026 01:55:27 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:20 +0200
Subject: [PATCH v6 1/9] block: partitions: of: Skip child nodes without reg
 property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
In-Reply-To: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX0PSOQFGCOak8
 1k6ElUfh4JA7hhLI5m0C4SJcm9RQCnNH0j8H05jxsVkjtug5I5SyHUDAJ/YCJumFzyPckNSeBQ6
 n/qdUNn2HfwaFd/KoBlOiVvphCD19FiAAQN4HWG41A5e4jKHk9GApyOpKMowJgdSKjNzGZDWQey
 knTsCuuW+3i9zOSTFeUzOPD6q+N4rOTkyTPYl+9zAM73lRIMbNTVxYFcMyC1/jtPwVM6EH84KfD
 9J2GW0IcKTYLj7B9mLxTAavnvj6SdLV+cM3O9S1HA2ybOw1m87K8bIXKcQaMCoc/Ki1qI3N2R73
 Gl9ffOBrLDrV4o0lU53ux0a8ynTcHYrbpZ1e/ONC2cZggUoYLZR6XbMtjy2+QQ7tyrDm2+FGElW
 mmhWLlzVQPhhInzE/Z5l8rlGX9NwLcUL+LdJ+Lv9EEA+HjqHjOZ3lf1sIWaHZAAQzyfNq8bqAi2
 SNoyPSfY57TiJpNLPtQ==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a423301 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Wp80rbrglrcOpQJs44cA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfXy2pPseqMbLWY
 b25O2bCr3uaTluc6E1cEV3ZDbXjPvTfityJDIyJUX/fmYd8urVOkSn+GYlUJfbl+ZWvnU8V/sln
 nWOQIFnil+oVEQbsCiZAyqPzF8dXLhU=
X-Proofpoint-ORIG-GUID: 3N2PZSZr_dmaPeLCaP2hTVOMwYKpADvh
X-Proofpoint-GUID: 3N2PZSZr_dmaPeLCaP2hTVOMwYKpADvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071
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
	TAGGED_FROM(0.00)[bounces-302508-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:stable@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:l
 uizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
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
X-Rspamd-Queue-Id: F33326D7BA5

Child nodes of a fixed-partitions node are not necessarily partition
entries, for example an nvmem-layout node has no reg property. The
current code passes a NULL reg pointer and uninitialized len to the
length check, which can result in a kernel panic or silent failure to
register any partitions.

Fix validate_of_partition() to return a skip indicator when no reg
property is present. Guard add_of_partition() with a reg property
check for the same reason.

Fixes: 2e3a191e89f9 ("block: add support for partition table defined in OF")
Cc: stable@vger.kernel.org
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/partitions/of.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/partitions/of.c b/block/partitions/of.c
index c22b6066109819c71568f73e8db8833d196b1cf6..534e02a9d85f62611d880af9b302d9fd49aa4d46 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -15,6 +15,10 @@ static int validate_of_partition(struct device_node *np, int slot)
 	int a_cells = of_n_addr_cells(np);
 	int s_cells = of_n_size_cells(np);
 
+	/* Skip nodes without a reg property (e.g. nvmem-layout) */
+	if (!reg)
+		return 1;
+
 	/* Make sure reg len match the expected addr and size cells */
 	if (len / sizeof(*reg) != a_cells + s_cells)
 		return -EINVAL;
@@ -80,14 +84,15 @@ int of_partition(struct parsed_partitions *state)
 	slot = 1;
 	/* Validate parition offset and size */
 	for_each_child_of_node(partitions_np, np) {
-		if (validate_of_partition(np, slot)) {
+		int err = validate_of_partition(np, slot);
+
+		if (err < 0) {
 			of_node_put(np);
 			of_node_put(partitions_np);
-
 			return -1;
 		}
-
-		slot++;
+		if (!err)
+			slot++;
 	}
 
 	slot = 1;
@@ -97,9 +102,10 @@ int of_partition(struct parsed_partitions *state)
 			break;
 		}
 
-		add_of_partition(state, slot, np);
-
-		slot++;
+		if (of_property_present(np, "reg")) {
+			add_of_partition(state, slot, np);
+			slot++;
+		}
 	}
 
 	seq_buf_puts(&state->pp_buf, "\n");

-- 
2.34.1


