Return-Path: <netdev+bounces-302510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VWTuOvgzQmr81gkAu9opvQ
	(envelope-from <netdev+bounces-302510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:59:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 882376D7CA1
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:59:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=e13Tz6kI;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=QbgZUo2i;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302510-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302510-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64D5F3055E89
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 08:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B313F9F47;
	Mon, 29 Jun 2026 08:55:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FB93F8893
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 08:55:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723338; cv=none; b=FZTHQo1EPkC4Zq+8A2g5V1n812zs3bjYSlbrWZF0vD4boHOcW64iHuqgN1xxj2fBoA3BpCRPS5JYc52GDRFT7Cql6HanMguXO6RwtWXbGyXk/5pf+SHqEn8GLg31J8gDBM1JnUz+FgFXwvsAPLuOLnZXsUdWU5b/NOxZp6T+b1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723338; c=relaxed/simple;
	bh=GWTkfYePYPEGTpO3+RiqLPCaGCSmezUWdnppwKHAMqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GFI+sBSQ63Smp+v8HdD6k2BKLTlv9X3xKD27sqttWCBRVi2YydccvaBPRrXT+0rMjFs6zc9MSaRcYNB+FNKLI3N//TDpd1GpPrDAYOoGI2WXBUfWmhlzcUh8UzEupfyEFMk9/LOQEcanUvHVY8k6mDR6ZHI7PRMi/ULwfb2cn5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e13Tz6kI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QbgZUo2i; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rbYe2097843
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 08:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=; b=e13Tz6kIkamhMoyB
	AqyCH6LK7ijdeJzi8mw9q6lz57F/Ow9TLcusNIY3p57SGWT2u+O3U6K7e4UB7J2G
	ogjrH0OPfQFELQeerI3VUViYoM8y8m4USavzVNaAoYuLsxluNpSG/txMgDsf/w3j
	soMFqHdivw0sh4npujkwEjn4ywL0M2WOINtCmvuMk+3RN8roI3Q/p1jcob0NXBi1
	jlzY74NPlvYVX651DVAZ8MHYeUjX/IBFWNzBBSssuaeQe3d/kTe/iIJH7tLotVma
	oEtxlmnY5BRC2FXJSh76izJsOkfO17fGp4LnUdj3HMwytP4srQVIf55hWj4iikQi
	CkCOnA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7wfbm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 08:55:34 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-966d40aca0eso3122503241.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 01:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723333; x=1783328133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=QbgZUo2iHoKCTWS3QVajj3KNlBjmakUYbuiUb6Xk6Cs/K0Ql2+HvKY50C+6S7nbI45
         2ASG3EUtvNGFl04QDD3jUxzIpIytcpYE0Cpp5qyNrV3KOgrHUFZV59AKhqadDX8ku9p/
         hFQNH6mJzqm3r9ANjLvJYUgUznMgp2F6DP3BadMVJHPOYe19kJ9YZ7audU95PM6+dAU1
         kZxN+E6D1AJmPjJzd0+BZNQM23RZgujBzkxqGE5VmqhI5gvRFK/tLW6C3N47MRd/mbip
         c36P3sG4YO0vpnWImfmtaKgmoMacWZ5EYw9jhDo4goFGy28UeoOzO2zMUJJYJ6UHCKR9
         uPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723333; x=1783328133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=nZG+9TBgJ0nYSUP8p8XMuFGeeRux5BapLrmRJC1TpSnjQMbn7C8zne9KMT/B5iNgyX
         EyMSrAVmpY34h0co3zA94YDUDrnf/zBEbVwek1j5pZaAh+u94AQp0OcULYR9oD7DjJhi
         /FWHfG47jiiG5UajySR5iKnHYL0d+mS51w7twieln3ehtpR0VdovwIOFiCoMBWPtfBrt
         TdHtkyZgFN+EFfMjxs3m1iaPaLP+ACwAfIHRvfEWJrRyZnLwJsJ5PAOB6orASRSLwtBX
         EG4SBubZKD0iGAT1DjGsKk+2bS7pyZGyubIgqD+F2WpMxuV9ZjS74gLA8z8Z2DZCMWsh
         DUEA==
X-Forwarded-Encrypted: i=1; AHgh+RqhIGbihUhLIPj8FKqRAQFmO/reIYICUgfnoFjpLlpRZwWv2+XGb+TtrAoNV0YLP0cQLLIfDoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPru0yXTKmnb46+FwGo29Pp7K3Z7qy8gkvm1O07WY3KlnifNN
	6uXKlUl+rSwseTX1GQif9FSSwrDB39KEq8SwTtETEnTca/1750REn7zdF891uKX3EIAOtNbv9B0
	Wyug+lTDINlifakHd9zCttA7B2lKuSKGu6XItgIDIvU31kuvwhidjsDScEZA=
X-Gm-Gg: AfdE7ckfkvf2nI02pfM9cdewQRxiJSXH4I0n89tGMZf6j2jRPHH/U5P/P4/DrkX1CD3
	8gQyzKMyBPe0YVE4L7YWLHsCT1j4rzJDxWyYwlUH41z1/bbGIIf1WYiojfQPeYjP/gmtmlTEZXS
	/w6fKAnxZg2vqtXdHQVVNea+RKejkRKBCfNpifMbN7XpL9ohVr8nRD/OKy4fCJnlsvLBwVpaNv9
	uY51IVBvGUW8DDghNlS1DKzQVnsVtuvzaBwJNomtl4cUWfBG+fG1SMdNJJLxNhLbqEw5acpjzdQ
	d2kEmjfPeD6tFFeU3TxaOZ2EoZDvh9flEadMNZVCDCVsaEsf8ws30usARfkul+Wrwrhxw5RStDC
	OgYvhKwe9hVfD84KtVhodcd3x/MQDxDwCUmhhIyG+p6VyIx8Arn6zTNfOHIQbAiWyF8zoTn9dD3
	BZ0+PoFQaD/UKAkfCgym/70UVvrkSAbzPMqhae3qSgSvsyZ1MlKP5II93s7PBD8vCK5U5z8VvTL
	pC6WHQVqeYLdvSJwf96
X-Received: by 2002:a05:6102:80a5:b0:6f0:3c5b:ce7a with SMTP id ada2fe7eead31-73435d8a3b2mr7432156137.17.1782723333490;
        Mon, 29 Jun 2026 01:55:33 -0700 (PDT)
X-Received: by 2002:a05:6102:80a5:b0:6f0:3c5b:ce7a with SMTP id ada2fe7eead31-73435d8a3b2mr7432116137.17.1782723333025;
        Mon, 29 Jun 2026 01:55:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:22 +0200
Subject: [PATCH v6 3/9] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-3-f02513dcd46d@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfXzHjW7sHSKwny
 6PPovK67Zd9ZIKLeAZ8Z8CorAHGY17MQ4DuYbiw44YLPyeIPpW0m4wm5gwHy4Q/8PPHbWo6CxDx
 nl91+SHXB7zuoUVgOI0sDAI+lICaKvR7GevlCKIgyBuLTEq/FOf4S7VydLr8KzMKGJMgN9encc7
 4qEQIzqaAiPhDGrMw3r4mgLstzPFT/SiLApv2BiFwJ9aU+Lwli8YadxubPXzqlbZ8zzAliEfQjD
 9r7qxFsY7D4uy/7t3rqpNZ9sm68U0twLdowEP27jZn3LXFwYvcwbe7Wq5NPV4tGBwoEevh0nTe8
 dUMWWcdRkFV8zFWez2L/CdA22JsArivebwN9CQjTcygUm4YtibXIeegEXeAuRAZpqQJHV+DrdUe
 jXNlU763fULJOo98Sv3T9E/BZWd4XcICAXWtfgSUkUNZE0IIz3XCAGsf+FQtMqJM2JWHYEOwN44
 HVmHHSqdaNnPJnynYAQ==
X-Proofpoint-GUID: IRbhSOlnhs30kGfysltvqhBfwiNBzm1s
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX7x11WLe6WTw3
 rs6nvexDGDxFGyTlhk+0V59F6OrRBkcbEQ/UlK/Xu720+mDPImJp/5zALsrzx0nLt+xDzTpOnc+
 /LD5jQuqB+3UkuDaJgALmx4vTtGLoKo=
X-Proofpoint-ORIG-GUID: IRbhSOlnhs30kGfysltvqhBfwiNBzm1s
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a423306 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302510-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@
 kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 882376D7CA1

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Since such data may also originate from chipset OTP or be supplied
via other device tree structures. All of these cells are optional
and can be provided independently, in any combination.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..878c5d833a9cb073520c256c1b72d0f1489e7f4a 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description:
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


