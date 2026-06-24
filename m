Return-Path: <netdev+bounces-301611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qr29I4auO2r8bAgAu9opvQ
	(envelope-from <netdev+bounces-301611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:16:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E07066BD435
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:16:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=JhAm8PuI;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=baVaFoS4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301611-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301611-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CA843007F45
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301231A6807;
	Wed, 24 Jun 2026 10:16:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6A4317D
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 10:16:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782296176; cv=none; b=Kn0L1ms2tyQLNsXhwd6ICPUb4cgBKmZ/LvlDYbgF0EoWZ22RtD2Yh9imGF4IHzgnvM6Fmf9y0x1Oi75Y8Ckmp1eH6J3obPcAC3YlTLfF0Wil5uAYXJAb8ZVNDWXCCjLGgFc0S9Rux2lF59G087RYlQu6evW6otyCGSutxEOuB3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782296176; c=relaxed/simple;
	bh=BzEk29JGiWKkaiyVUQyQsqDYy9jEYo/hDm64CTzoK7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gnvo8AEVYndA/qvDJN/u49Sw4Yr4dQ2O49FUiFRiMwLlVR9CViaEO8cXF+fn9LJxh6MHyqcvt4ZPKWIE19gGGiXnYFTf0S+g2j5TetQD8dTnTQVMkuNmEudbeg4gY7ySSvYBz/KdiSBaSx859tt7edO6GrOXhOJo/8szXmdJjlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JhAm8PuI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=baVaFoS4; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O5toZs533303
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 10:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uYUc6DnbYSfkS2y7eIMHId3IdyTyXlVDPIse7G1oYz0=; b=JhAm8PuIimzxY4nu
	GS2uhlEEqb2Yjm5SVwjENCRXTqJ/Hsxk7kwOE2TCIawEs2ZAJaYTY2G9lHJ+PAPS
	v/QgCKobCRLv5Awdw8sR9RW60OIpxId1HT5oP4DQk7MVcxQAyDvoYMOd87q7sEIK
	E9rfyrhIgKlYgWGtVyaXVV2y9iB7FsKh787wUXCp9lkhwaaz4/39GSLND5VyN8eK
	HsdDu6w2ET6R549FobBtKP+s9gf40Tl+AZIjlUv5dZhYLhGkZvz73cYp8s6Qyij4
	nwiYOl8TFNkGmFA4kAP+8fKiWjSoVGouTaQcVJuQ28FRlR5z102xHBWEki25THSV
	Efy52w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f06r31jd8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 10:16:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0c32faa62so13536745ad.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782296173; x=1782900973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYUc6DnbYSfkS2y7eIMHId3IdyTyXlVDPIse7G1oYz0=;
        b=baVaFoS47oL41AXMYtnaMSH/mxk32DJvzuQQbHbWL9gBMMGEExQRZogDX1HazteXxJ
         tAq44WLta1FHxhpvQKprcaD2l6hAtLUFqyP8WHYkn2ijC/OFRjjKA6fWxqr5RR0mvsyW
         l0ggRqfydGC41m0bUdOgzmSOcQHe8ww73T+kjDWtQAiFwz13TpdT0p6Kjxs6FFhuNAu1
         ZwfpesPp5dWfX9zQdejCxuk7iAFQq++bkU1LmkjgAD2cBHjXNCLGaJI5hwAJ0m09bzHk
         gBSfneWCZQmIfV9FBGEJgNyXyY7h4JiEyOIpYK+8OCWxg00w8qNkvhC9525i2M9hu4C/
         yZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782296173; x=1782900973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYUc6DnbYSfkS2y7eIMHId3IdyTyXlVDPIse7G1oYz0=;
        b=Iuoz7Lxs5R1l1ywFPdxE3VwobQndQVGU2vIwXR+K5Jg0de0HFdH7I2RkvHQXGrgHLF
         2ciUn+EKLVX95l9c+sbxYcMmvwfG1JFNqASI4Tt5Li6i3ays0nhFiTZ7A57gkNd91dNd
         ucN5AUhcKXiC+2kV+gcpM5oIv92KofB8Z3/oJ4MY5tI4lQpk4hBw/SIuobsNWlSDkrXa
         ymr52SKBo6yWfKzQUnN5v4cGZJg+Y/oEdxHOH7GWoaapdh//WoibB0GAoqppSYKesGYq
         qhcbNFqcw0uRUe6eItbJqix+Q6xuDOwLt1a4bYgoHM8s88pL+pOWViBGB31OMly19zBG
         M/OA==
X-Forwarded-Encrypted: i=1; AHgh+RofyyVEPORxI2BTBOdkT3Ykw1+v0JKAQ5DrrjjLpKG5gsAl1K9nFfu0ua6ginWi7k7oxhZ6xRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDA5JHG5pm9mV/WVE1ecNEjPXNvisE27xeCDERVP9hNqnH2Vst
	bHJ/FvUfUPumjI+TcM2fP0RKmz+SBNHbuPd7Q/x3DLuaLj2P7A51p67MkEYlwZ6lyiSLmDj3Sh3
	lWzl6oeq/3GsDw8TOtYoDGU3K1O/Arz52jENKH9caTln/THx74W+NuoIWNfk=
X-Gm-Gg: AfdE7cnGlw6V2kLy+AJGQRTnifaHUrZRhpbISRcEXZcdAdB7sUlRYguGqxr8i/zpddi
	mbvX2noXBUDsOEhtE6tpdGTQs6yJceoeG2gh1Z2U7NQqrYwbfMl+ZBrtxsmO1werFrrhZiLiXcr
	u6KpZSfpwmyddNinm2eOZIPPYl+ALFImP4XYOJ0/RdaD04UUCk7zyX9RTwMMW6R/b0ppZUuZj+4
	owPCe2S7lPo6zjeocLaqQ3shbc1JNm/4y5xviPLOa8a00B6NggEw0idghmAGp+GGwetBY1Tq2p8
	waJCKGp93UACXlHsTOuS7E3BkKQ8n0yTp2nQPTsE8BOnJ9TZwAVSloyfk3ZI5WRKWCuI98a7vJk
	lvQljBEbCnjxdwOu6wt4L8zl+iWmN7MOnUsLaISjcbct1KJQqBEPn9nycvhlaap0AkCgMH1RmEX
	hp
X-Received: by 2002:a17:903:1b03:b0:2c1:77cd:fb0b with SMTP id d9443c01a7336-2c7c772e013mr70238425ad.37.1782296173432;
        Wed, 24 Jun 2026 03:16:13 -0700 (PDT)
X-Received: by 2002:a17:903:1b03:b0:2c1:77cd:fb0b with SMTP id d9443c01a7336-2c7c772e013mr70237995ad.37.1782296173004;
        Wed, 24 Jun 2026 03:16:13 -0700 (PDT)
Received: from [10.133.33.169] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7ee339400sm4026735ad.33.2026.06.24.03.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 03:16:12 -0700 (PDT)
Message-ID: <50cef9ba-1a64-4079-b416-9b418486cbca@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 18:16:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: qualcomm: ppe: Demote from supported
 and fix maintainer addresses
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
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
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        "Kiran Kumar C.S.K" <quic_kkumarcs@quicinc.com>,
        quic_linchen@quicinc.com
References: <20260623073307.36483-2-krzysztof.kozlowski@oss.qualcomm.com>
 <0247dfba-1c14-4fea-aab3-5489a36f35f6@lunn.ch>
 <8b0560ae-af5c-4d54-be02-d186be1d799c@oss.qualcomm.com>
 <7095f7ba-bacb-4d03-89cf-ed43882d8213@lunn.ch>
Content-Language: en-US
From: Jie Luo <jie.luo@oss.qualcomm.com>
In-Reply-To: <7095f7ba-bacb-4d03-89cf-ed43882d8213@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4NSBTYWx0ZWRfXyf5b1CQqLJP+
 z8+OG6lZ9wRAty05LCGRt/nADGznJRBPdp/bM5VW87nnksRQU8GMkYTOZ+U621/NadcmnMCeN/J
 fHVEbTz4BJg8vGUnDtBNoGcKm3xL1WQlXyuEY2P0dA2mDVHCMvZzomoXShy7HE7R1g9dFgVxoZ+
 eQ+y0t4qsXJd5vJOhTmvrNMiXkw7cUe20BBKlflQBvzlxVwx2A5Hdyoi/nOG+44nvSXVYXCRTY4
 b2vOJqJPIch1/iy6m6jT118wEE9R/mZ//eOynObt68mHdnFGjOQuVvYqo/HS3sZUU34mxA3ZZ3B
 cmkOv9IMmmNG0sETLkLfXtNoKpJOtBcFn4s4poa4HB42tTQQxxohxsAbsAP28DIjRzyn3VzRMzg
 +xHh5VN8EM16GdXgVu7oyW6CWlL0DwGlQu/PDTJSj2o6K9B4G1CmNxvL4zO64uUqH2U2pA0nyD5
 6I+4fA35dttkw1t8azg==
X-Proofpoint-ORIG-GUID: oAsUaYAQ9hlGKd8zNS6E66BVpf7buhA1
X-Authority-Analysis: v=2.4 cv=ZM7nX37b c=1 sm=1 tr=0 ts=6a3bae6e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0nUQaeTidBPDXHyOA6wA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: oAsUaYAQ9hlGKd8zNS6E66BVpf7buhA1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4NSBTYWx0ZWRfXwTYdx2veXgAz
 D/T5OHEofZcMCCM8HE3CumXTHlU4Z4EidjydYRslrmZCsiOeeWLpO1owkgbLxr7uv5Dm7CaqkTl
 Q3i0gG/t3P1GgqVh4TfXO0ABfe1qgkM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240085
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301611-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_SENDER(0.00)[jie.luo@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:krzysztof.kozlowski@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:quic_leiwei@quicinc.com,m:quic_suruchia@quicinc.com,m:quic_pavir@quicinc.com,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:netdev@vger.kernel.org,m:quic_kkumarcs@quicinc.com,m:quic_linchen@quicinc.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: E07066BD435



On 6/23/2026 7:31 PM, Andrew Lunn wrote:
> On Tue, Jun 23, 2026 at 05:42:34PM +0800, Jie Luo wrote:
>>
>>
>> On 6/23/2026 4:10 PM, Andrew Lunn wrote:
>>>> Driver is not supported - in terms of how netdev understands supported
>>>> commitment - if maintainer does not care to receive the patches for its
>>>> code, so demote it to "maintained" to reflect true status.
>>>
>>> Maybe "Orphan" would be better, if the listed Maintainer is not doing
>>> any Maintainer work?
>>>
>>> 	   Andrew	   
>>
>> Hello Andrew, Krzysztof,
>> I will continue to maintain the listed drivers, so their status can
>> remain Supported.
> 
> Please understand that being a Maintainer requires that you respond to
> patches and questions about this driver, give Reviewed-by:, ask for
> patches to be changed etc. If you don't respond, ideally with 2 to 3
> days, the driver will be set to Orphaned.
> 
> If you want to maintain the Supported status, we can help you set up
> the needed CI system, and get it registered so it reports the results.
> 
>     Andrew

Thank you Andrew, Krzysztof, for the clarification on what "Supported"
status entails and for the offer to help with CI setup. I would very
much appreciate the community's help in getting the CI system set up
and registered for this driver. In the mean time we will also look at
resources internally within Qualcomm, to understand how to support
testing using kernelCI/netdevCI for IPQ SoC. This will help us test
the driver continuously as well.

I fully understand and accept the maintainer responsibilities for this
driver, and commit to the below:
- Responding to patches and questions in a timely manner.
- Providing review comments and requesting changes where appropriate,
  and providing Reviewed-by tags when needed.

I would also like to take a moment to provide an update on our current
efforts for IPQ SoC, if it can be of help. We have already re-started
our efforts for the drivers and are currently actively working to extend
the IPQ drivers to support more functionality and for newer SoC support
for same family. We plan to post these updates to the current drivers
once the review window reopens.

We feel maintaining the "Supported" status is appropriate and reflects
our genuine long-term commitment to IPQ SoC networking drivers in Linux
kernel. We request you to retain the current status for this driver if
acceptable.

Regarding the email ID change, we had attempted to rectify the
MAINTAINERS file a few months ago based on recommendation given
internally (please see below thread), however agree that such an update
in documentation is also required.

https://lore.kernel.org/all/20250903-maintainer_update-v1-1-2183fd2a3c44@oss.qualcomm.com/


