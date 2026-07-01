Return-Path: <netdev+bounces-303756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7GBvG+89RWrc9AoAu9opvQ
	(envelope-from <netdev+bounces-303756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:18:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F6E6EFAD9
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:18:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="Sq/4TlU6";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="jF70/2De";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303756-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303756-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E52EE314A48A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524C94C9554;
	Wed,  1 Jul 2026 16:01:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600034C6EF7
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 16:01:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921676; cv=none; b=D6t/B3U66WmArLEGqMGbcXqvuD/i58jC79y4dqQy6MK0LDBq+mTVwTfJV3zndCyRQ8UhbFk9+X5KUXnSepb3ne2Ge8R5kSW8SJWf/l5rzo9U91IlJw3hWpk55tQa6ij08KFKjgoovKNMp8Ik5UzGs0kCHbIfRes2ievEbmVD9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921676; c=relaxed/simple;
	bh=WoEsQQXEHcp3Z4NugaMqCjtqYrDzpmWHIggHogkIi2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8/Rct8cKA7gu//lxoqoLnZ4fvJutmWjh0t2ZHSKixkQcY6VuR+ockyZGX+vzYY5OBotaK5yDxVCl//3S5c4n1CqeWNZ5zyYXD+Qp3YT4zHNV8kIjj+7XE7NKKob0iPacOLpfa4w0SczVPRXUfHacbvJ0zX42af5B9pxaW6ym3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sq/4TlU6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jF70/2De; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoBk31546221
	for <netdev@vger.kernel.org>; Wed, 1 Jul 2026 16:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=; b=Sq/4TlU6exhyzy+K
	qT9msILIdxixfLAxMRh0G1xJpAKvzWs+ZtpKWxy3uGndIQq5dUiSP6UBO4SL/Pij
	Z1jGh2bARokNq8G9wo5OP2turSINkMs51RaXW6y8CCNSEptt//shZHZFk+wgSfAy
	AvDvzofP45s1zaTXy5X1MKQH2r0Z7Id+XYNo9uSQqmGEWPua5QqEI8GfW7dtdRIl
	iji3q3edsCaC+54kQGJH2rv8D1nHj+89qG3sTtg6c9EHnu1toRLWSuucWo6SBHxU
	L1RYwdkd9PVMqapCHK/tRDocDlc1CHAjWB/DsLeETtI9XYrVe3ixT6G6u2JHDj4x
	D6AxDw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sqshqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 16:01:09 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9e54e9cf5so1400720a34.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921669; x=1783526469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=jF70/2DeBisEdEjdvqAbvIXVLcj9pmhfTmlLj9jbjLevltW68YJ3v4IRQdon5O2i4y
         +xaJeZplRGRJA+S0qmqkSwp+g8237VfcCZ09O53UESCtI1+ptLN2Uy/2u7JQ5bIfv8sS
         TfPMH9EIoEYXDRkVpd30kr/tQVQDSagg+ZEkU3DYtYbxmLkekJv5+sGgoF1LPQbiY/Kr
         C/uvDc3k9ibZHNTReQzQxL/opffsRs0SQK7NP2zMYnYZGmS8Fdg24KRZWvrPNkhxQFFV
         NWn5lib1Xzcde9LLFrALgsT0tdpFx3wi8uoTr/J/4qnHv8lFWcnFFCCNolXaEXFGd1Q+
         6M/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921669; x=1783526469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=ohcVPzMbMvGNNg6gebkcZE9y2qqLlJFJb8xCf96AQatiTfeafAKcTuJ4zxkI5G18fe
         c5NmT4xHRq8Ohxg4gTv76FC+I4uQ+Fq4bQ60CwVUeXxSkFS52YJq/LYIrSf+3JfG27kW
         r5KoDUSeE+O++YvS0BqXxW2aM/S2+uSUIHAow8B1S1eAI1ue48Fqww0GDLrklnD9V5Zo
         CVyJMC/3oPVuLAPfkYP3avU3Z7ZsqOr+IBKVkyAaJeBg/YcFauaGdUEglAlqRtrlVAfw
         WJKlsoTlBxkVPpAfYo1sHs/2x/quHyBU6Q6BHf4v+6H7/mmJuxNjAaICojLLhtPp1Nwe
         cyfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8TXSEBhhj7Sc/Py4jLU35OZWEoJWPecNIlAeyfgLwRSh4tfVw3Yivk52Nldy2W6HPY7DR7pb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3dzgJ8rjlkyPA98oJ1KSq+SUWZumFp1NPSMfrwv/kToKj8GPl
	37Jz9puioFqdssyVwgVq6O6Dw0DXHldLLX3A4FE53UUqHPBfUXr5p3IKqXr+E5fqp6Mo5wg87aL
	HNZvs4Uw4DQUywa5EbflmOf2F4zINBzrQhYD4h/5pQRFPFy+K0bml/SrgY0k=
X-Gm-Gg: AfdE7cnfi0u0hNW5quNkj6GmNv3mOsnV3wpE4cL4nJrbcQJAjR3mTkf2AvI0qqSJfgP
	PVR2tlmb02RfZmluESgMxS6lGtiLnPQLZubngSL/pq3NYY5yIxsHcAvz4VUPkHh+3ZcVYIeeyc6
	G3OKPFGfhG0xPsfxRoxjPpfFDCPM82DBWAgScGWWbsE7cY57VCDBv5unM+8mjvPhXqg+pQ6AJp9
	2EMNzg6bn8bRvGwrEnpyc1GqF49+KyWYYrMVdHQ/q3bAeZipRpRset63wL/ENUSYasjiDjG1cwy
	VQGFGm6zvnCHMrkrp6IR8AaIGrOrAgkuNoQ91N75djuZwLZ+UbiDbvPGn8F1QcUCB7vqoCHvNIQ
	L+gVF3NVObxVQjABorLvWnObxghC1n6Pi7BDv/2Q8LV5cnzGOCyjC5S/uGTFPiUuEPSJQZ4k/9I
	0d9Nc7pPb3x9Rnkv9dN2X72f5rY0KK97kBo/x0j4fJoavDBKRmTJX/Cdl3VqXXHwk=
X-Received: by 2002:a05:6820:200d:b0:6a1:50eb:2113 with SMTP id 006d021491bc7-6a309b97f95mr1372355eaf.72.1782921669024;
        Wed, 01 Jul 2026 09:01:09 -0700 (PDT)
X-Received: by 2002:a05:6820:200d:b0:6a1:50eb:2113 with SMTP id 006d021491bc7-6a309b97f95mr1372277eaf.72.1782921668477;
        Wed, 01 Jul 2026 09:01:08 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:01:07 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:33 +0200
Subject: [PATCH v7 9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-9-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 8TanRQ58kzlRh5xEyC7nDhl37Z5db8Th
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXw+xcPacoaVRS
 YxNhs2XqaptZbmsT5AQBoOtuZ1d/HM4dx8JQDuZMvHk3DYbUMapw2zrQKB81IN1pt0Q1JWTDzv4
 dURAhlgp/tcZ2fncxwMM6mh3TGGq2FI=
X-Proofpoint-ORIG-GUID: 8TanRQ58kzlRh5xEyC7nDhl37Z5db8Th
X-Authority-Analysis: v=2.4 cv=ceHiaHDM c=1 sm=1 tr=0 ts=6a4539c5 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX7kppjBKdBqEp
 oGR+WIB1+8fkR9+dkEu0Utjfd+8aZSimQ/4aT4pgyI0wCk16bQALCV4gTXIYdW2fxcrg2LKMuwF
 P+Vv0v3acnYMvRk2tT81RmZnFGTEnxsnmY0zwQ+XGekjKmUjT0sXIubxAdNGVSE1+oUGR/foRdt
 IAOK+Tf7rr3W3OPV8zoWusBsWIQ+5qQfwO9T0+IV61RukzQhrDQXN4KyoPOioT8g+fampYnPz1X
 Uk0fy9XSXGtYeEkninhKFRMZ7hiJ787roDwmpJbezmkhZWtOvltVsEHFjwzlrIYUIqmSclWM7vg
 SKqPhsQcC0mT2zkmHj1Pvk/oG2IpriStwG/O1NDUWjlXrUZ9qMIGDHg/YUrglRKcVWRCLIKpB5o
 E0IJ8aMqmi79dpEN84c8kYSqdOg3kJyxcKb2r+fOxSj4PMBnYJxFNy5/7afgfgsnWSsZJHMkona
 OHnuB4LfqW2YsUJswZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169
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
	TAGGED_FROM(0.00)[bounces-303756-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel
 .org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
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
X-Rspamd-Queue-Id: D4F6E6EFAD9

On Arduino Uno-Q, the eMMC boot1 partition is factory provisioned
with device-specific information such as the WiFi MAC address
and the Bluetooth BD address. This partition can serve as an
alternative to additional non-volatile memory, such as a
dedicated EEPROM.

The eMMC boot partitions are typically good candidates, as they
are relatively small, read-only by default (and can be enforced
as hardware read-only), and are not affected by board reflashing
procedures, which generally target the eMMC user or GP partitions.

Describe the corresponding nvmem-layout for the WiFi and Bluetooth
addresses, and point the WiFi and Bluetooth nodes to the appropriate
NVMEM cells to retrieve them.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..38839b8a361e76f6c1989924b16095b9d8815f66 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,33 @@ &sdhc_1 {
 	no-sdio;
 	no-sd;
 
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	status = "okay";
+
+	card@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+
+		partitions-boot1 {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			wifi_mac_addr: mac-addr@4400 {
+				compatible = "mac-base";
+				reg = <0x4400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			bd_addr: bd-addr@5400 {
+				compatible = "mac-base";
+				reg = <0x5400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+		};
+	};
 };
 
 &spi5 {
@@ -512,6 +538,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr 0>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 
@@ -557,6 +586,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr 0>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1


