Return-Path: <netdev+bounces-301317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eEdBBRpVOmo76QcAu9opvQ
	(envelope-from <netdev+bounces-301317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:42:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1011C6B5E21
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:42:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="YB/8UGmo";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=DchT3qzt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301317-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301317-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35BE9300372F
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED33CF039;
	Tue, 23 Jun 2026 09:42:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A173C661A
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:42:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207764; cv=none; b=Q2fZduZqhzdexhbHFduevhd6vCZeBzdYGLBy0kSRE4qwJrRgNiTJydJsnhh/sdpZSCkt+A7bdrjf7CwQFOIcMlhz35mOnnw0KYjGO5FoGoZMFm8UTxTTf2yydQ52Yb0adcvCqvwDi+HuONduFc9u/g26koyR5jlJfoEdsxDh9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207764; c=relaxed/simple;
	bh=2zt4mDfQLCcN7VZdwKtxZoDHgil7aJyHwJKdbeBKs4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1rBuSxFvH4OocDhNSXwP+7XwGFuOYiDfVI0QB5LvQuvlcGA5C/pCbXwpZn+EHQbGdpSvjIaW/acit6B1tZ2Q+Vl53CxQHjM7TRYmjBCiN8aBRI4ky74JGVFz7IFJz+Qftz9YOsQuAPJAL+bUCyz/6XLCutuSrHfL594h2/mwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YB/8UGmo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DchT3qzt; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N7kq3L3228498
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gso4/eCWqTGK9+zw2V2gKqpch+D4ZfB1l0eAVrB6LD8=; b=YB/8UGmo765MuLo0
	dXdHA69ayE7MXPDuMXJO5te4qaOteA0rpPktiMkss4WuOYCOqi2vivLey+r3TRaf
	2jQVDKIeOZxKis0Z1Lm8QyUyb2j4zRT/fZF/8fX4Yvb+vJsGDtwjmsk/94nqqPuA
	RkmrafsyDgYqPaiFZLco1hdHb6ac6cjZ6CON6aO2OcrrHaKAsGWr7rzdp/wlGlxY
	ZkRRJCAKnzu0GMf+NQ+8WpAy0ezSv40+rCA7wrD+CQLpyCa7/pfGWpAeXCuhB4/w
	HoK8j24/Dg7iZn9ddvMBgHF2CxJGQnxmfguyb6lBLHtblo6MPf9V/TM1N8nWCOhi
	QqXxQA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp29gg1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:42:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c2c98c1be2so46195065ad.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 02:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782207763; x=1782812563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gso4/eCWqTGK9+zw2V2gKqpch+D4ZfB1l0eAVrB6LD8=;
        b=DchT3qztJF+AEjzIeTnmKTMvlbgQoQakpBFToLIWgTegvCzSKPD6DHpN3oQfaDXA+b
         kMGnbvF7rOIVvNbTCD2JAPi7aN/nBfX4LoDx9tHgDI0q+zraLv1E7EtKMcx+4ogWZXHy
         uigm7lQqVRZ8FJEpY4AuboNza2NuZxVpKGFqpLRAGzx1yVe2oaqCofJk2o3RlIFV5eo0
         GgsYg8jQfdizqNT7kukHixE/aoxIarQJbnCdfe69ZKQY0mvPfmv2ikR+wiH0UwvIvGSp
         dBm5GIgr39iYu9czOpdFF34iVtPk6Bvq/QhQynnxzz0xzGHsF53wS/rSEovNaqP1W1Ok
         awjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782207763; x=1782812563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gso4/eCWqTGK9+zw2V2gKqpch+D4ZfB1l0eAVrB6LD8=;
        b=aPmvnGnLeDFp1EKnkYX9y/UfJxkNCkv89SA5GT1uSoxrelk2vtAXhLFTl4y+e/vK++
         HHKnbLowHzV7dq+t5pGz2SugQM8Tojz5T/FkVUPxbcOPahCsWN627hfBFumKzN7O091w
         9rysXNjUu3JozEqWh6wzlC0YrdaAILAZwbSQJurPYSx6e+nuVC+nQ3E7IFVo8UqgtKAh
         7HJVUkrZHhgsBZzMihSGaQds5Z4p9UajTB+VC7PLxMfAa9aOrbN93BGuT0GwPJcyxWYk
         YxXuNs8iGZylM0/YGFn3LRgjUtre1pGb/PaytBdKqorRcTikyP0dL9BgzHBgfSLSj2Z9
         jR3Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro6cmxUbLIHH0y8/ftEucL9AjZVHHIuE0KyC7ALNpmTjdA470Ow5cFUgnMPcg2x42CG6JUdUPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc2HCZ3tJ/IW/7XGgISqGebuuiJ5b5/tzlvsF7l7Qp821sRuZj
	AapsaPBux4G2MohP1BS5hrMfJ0gUwc+/ZHRcrC2NFI9r1RPN71THLI7IMBWWU3eGSN/BsphB/Pz
	lcuZTw0KiwEkfQ7xsq22sPvAzwG+RXJxCk/po8iNIbqYHXHU2LCAUQAaUT2c=
X-Gm-Gg: AfdE7cmSoxGmqhtwMJOwI2IoDFtnCFhIAYZdJ8hrJo+2b9mohiMeAXQTY2HV04IUYdz
	2JFOlKbQ7O0DIwYMfxYGVqNrKzsRybKLyHVOgGc1V3L0I49rPwUjUO9QOgf3cS5/zmwHm9Xgni1
	jYnkRcZ/C4hwx6ylGIobCZUgqZoVh0hJJ/sX6+LgC5a9NINGm2IOmAH8S9Y9wUG/LxrYrpBIuLk
	0CXQj2/KBBJDsWWhJYEeNvm5JEuiwG8pClUAAfi8ifbM59Hm+lsiDHLQI2jzFdEPpTjiWXTCPXX
	PVkEl4YUYwbK8Fo+ez62yq9VIuIqQXZkUBZgimAY92AZa7u2VXOsIHndsEODDIHAt3krtyjxRU3
	AIm5QfUx6dLzRMe1bGLMkRPGNY/6+Yw+mLE7v0ss2KcN/moNXajNa4aKohHTk47g5EEbe898WDf
	KN
X-Received: by 2002:a17:903:2ec7:b0:2c0:3400:5c34 with SMTP id d9443c01a7336-2c718c879fbmr191507985ad.3.1782207762713;
        Tue, 23 Jun 2026 02:42:42 -0700 (PDT)
X-Received: by 2002:a17:903:2ec7:b0:2c0:3400:5c34 with SMTP id d9443c01a7336-2c718c879fbmr191507745ad.3.1782207762274;
        Tue, 23 Jun 2026 02:42:42 -0700 (PDT)
Received: from [10.133.33.169] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743bfe8aasm97603725ad.68.2026.06.23.02.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 02:42:41 -0700 (PDT)
Message-ID: <8b0560ae-af5c-4d54-be02-d186be1d799c@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 17:42:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: qualcomm: ppe: Demote from supported
 and fix maintainer addresses
To: Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Lei Wei <quic_leiwei@quicinc.com>,
        Suruchi Agarwal <quic_suruchia@quicinc.com>,
        Pavithra R <quic_pavir@quicinc.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org
References: <20260623073307.36483-2-krzysztof.kozlowski@oss.qualcomm.com>
 <0247dfba-1c14-4fea-aab3-5489a36f35f6@lunn.ch>
Content-Language: en-US
From: Jie Luo <jie.luo@oss.qualcomm.com>
In-Reply-To: <0247dfba-1c14-4fea-aab3-5489a36f35f6@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a3a5513 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=HzQU9uYTMzTt3pVePtwA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: aDS3P0XlXTV6XLw9Tgu8bdG0nBfu0BWe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3OCBTYWx0ZWRfX4GnIZOPFEMar
 /JUBhBPEzGLdChP+RIFy/qivm/+LwKFNFbXbbkR+QH3EvBKgahUSNgBwdCw0tihRrf/zwtbX4gH
 a5qaH+kAZ+A1X9FnLf7arrfvs0ZB2/E=
X-Proofpoint-ORIG-GUID: aDS3P0XlXTV6XLw9Tgu8bdG0nBfu0BWe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3OCBTYWx0ZWRfX9+4w4cO1GFkd
 P5SBMs3Dbwa+jrFByFsUG+3AbR7g0+qCKJ6rXEs33fhHUIJg+CBMjDboyWb2O+t0gfsi27z8Ewq
 0FfCWGEJ+ywh4hSlp7iNaq5/7AO676w+Af6fNSeguQgX2sY5qDv6NKg3QNjBjoVNFKxJ7opcKZc
 3jVZrxhp8sNodZOe4XoikZg+3OQyRPxeB1eB5aXE1nF3M6RmqCQtamWdWBLCJs7kicfo2oFON2e
 QiS21FIt6jSs9nJvjOKOwAyIdpH4G1N/aQcWf8Rz5kFYLMHaGSve0/IMc65s7iBJ35BROjTonnG
 1zZfkhn87DFURhZTgSxRoMuzuGFoiXiGZMJYJzPh1Sm7o1u1VCIrkAgCQDjWOaBSIchKiJdCkDT
 tpjpVyfZlWoZcfRX4URzTc72HESZB1b5vuuLhUTAsW/UVcQUbvW1qH7MTSQH4bg1OYeEK/kLOgl
 +EORwd3YG2MDdnUnuYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230078
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
	TAGGED_FROM(0.00)[bounces-301317-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[jie.luo@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:krzysztof.kozlowski@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:quic_leiwei@quicinc.com,m:quic_suruchia@quicinc.com,m:quic_pavir@quicinc.com,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jie.luo@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1011C6B5E21



On 6/23/2026 4:10 PM, Andrew Lunn wrote:
>> Driver is not supported - in terms of how netdev understands supported
>> commitment - if maintainer does not care to receive the patches for its
>> code, so demote it to "maintained" to reflect true status.
> 
> Maybe "Orphan" would be better, if the listed Maintainer is not doing
> any Maintainer work?
> 
> 	   Andrew	   

Hello Andrew, Krzysztof,
I will continue to maintain the listed drivers, so their status can
remain Supported.

