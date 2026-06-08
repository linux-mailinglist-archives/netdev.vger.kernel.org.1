Return-Path: <netdev+bounces-296658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QsU5Gyf9JmoZpQIAu9opvQ
	(envelope-from <netdev+bounces-296658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:34:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E365949C
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:34:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hDYXo+nd;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=AucteB65;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296658-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296658-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B04A330CCB50
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 16:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A39347500;
	Mon,  8 Jun 2026 16:18:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4301332EA7
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 16:18:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935523; cv=none; b=UXdTHaswWJcEQuW1n/dfAbCqAhjNv8RTi3jBmcDTxTdAHW1mEuHY2S5TeMSCYbJxWbBc82nEJHtoBqPZv6iS9/5sHrc6T9heqEnACL6Fv1hWSGDI48X0UOan8q7nXAc5NflwQgotfzrpDtdRiQHbAHaCb5VyPFEAb+4k5/yvaXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935523; c=relaxed/simple;
	bh=e8pZf8plrZyej9TnlAyDOk5VBoL31Gl/oUv8+6Ry5A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQvm7MQVYm3MY5Rhd92r1AEB6ToYTtmtcdfoB3aigqs0eqchNLLHQgMWNrl3JrO4ATqDwtCgjgAQaLIUTbywMcoPWLHLG02Z0DM7HRzbWFOneAg2DX3IFHRAZza+E92+LaIlJD8HkOZXi+OX4o8kIohhCQDy9knfi+JsEnWdzZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hDYXo+nd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AucteB65; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFTem3971274
	for <netdev@vger.kernel.org>; Mon, 8 Jun 2026 16:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wN82TcQ6qVxJTHgTvwxJ3Z+eIR2T6ucnR+HY21rEwRY=; b=hDYXo+ndaCgs7v2x
	6w/SG6Cpd9D0RozsU4fQBBkpBclLm50JjDibbtZyh6WMRQLukT/Iif5eQZj4raCu
	kSghrhSOnK6q6x4a2X/GTf9AuyEfrhy5cqpW05s6Zm3YKT4ihKRaRJ/UQCr9wIJw
	e3n3VF+2do8u22f5Rz3SGpFIT5ujuTp/g1j8nrSQz7zrRA/DmDnUm5JEI2dlNJIR
	Q9Fff856ERovsvuSlrT75kh8K/i9vPbdQDirKCEVJfMU++bNeAKVXuG2smhD+sH7
	aj9+Jtx0YIPP0db3xCqwKwCR1dmviZNR0JT/zoMuf3wrLQcbgs7+J6FJIKtOGQpU
	jt+rRg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enupthr7b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 16:18:40 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8423f3e4728so2916226b3a.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780935520; x=1781540320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wN82TcQ6qVxJTHgTvwxJ3Z+eIR2T6ucnR+HY21rEwRY=;
        b=AucteB65OFN/h7aWf+U8wFb9nENv6pvkNx9D3lvQ0777CBK/csyT1FWVR1moyyRpT7
         +4Mv3QYov4DZAmZ1vb60vILIUVXeR5H0knZwc1hOZc7Kza5CxGJbPPLR/X4rfL42lt4m
         sbQVSO/ELeCanJ1o9PBJtBjDCn4bkvRRdsYzw8RAn1JaLu5O3gvtZIT3kINuflwlM/cl
         TqZygBhKUd6Bi0hyYRjzSVOLLkAI1gcHMrNHkwuwsqCADB33372cgRZW2zbfssbQMLDf
         b5OU+lVLAIPdzNB0Z9xomun0AFiu1JrjTG/Mzyg59qwur01ZUIGJJuHTeiFw5XkAXqMa
         XPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935520; x=1781540320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wN82TcQ6qVxJTHgTvwxJ3Z+eIR2T6ucnR+HY21rEwRY=;
        b=JjMCXCygjfwqpan18H74yk0Qy4u3u0UMHf4rahHgRcW/MnrMfQU7KcbfWahnXhZjch
         T4fBCNroLmSffTu9/uVgWlu78XHjHYj0fhNgdKzCXFVwbnsjrogyBv+1FwZpVhcXs7zT
         wlJIIAPeaF7rzuHo8SRkWFXi78HvgOGlq8ZdUUbqefHZYTLqoIAhLFo0Aw0PAzXLpj19
         SRIUQiOMm2cQ5Eej3Bfj/XnEC43w7drWHulPF6OC6tgsJdKzVE3SAinS6Bqudp/FjjMT
         GvBBGSm/2wZVADDlu8jn0TzL4/b96/3phj8OXklG95s2vfqtcGzvZRo5esXLjRYkGav+
         iHGw==
X-Forwarded-Encrypted: i=1; AFNElJ+uoV/UqByQWHCLVw2vEkKPWf6KekmjJt/vrzW2DSn6JzNvPdMEBf7YdAzdat3pUudsbr4RMKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGbfhet0XZyT3xgZ0iYbYQvOXz9SIngoid1Y3viK+XGpE0Fmx6
	fs52hQEmvFTyHiOO+le8YmnJn1ivu9X2ICWJ/ZfP7vhg+802gvwYxwStomchCsTRDicNFODEWU8
	qH+2YNUu7eXkrDDUTjOuOcaPHgckssvIlTewfLxLLpgfPwwnP9U1Xb8C/FZ0=
X-Gm-Gg: Acq92OFUkqo51xLxGEpO3rrqmHZb9Cl+DjWZzG/XD0I6K2WFQDLrld7jEB6pzlwsXb9
	do8zAL4BLS0NvUO04PcGHyMYVp0dasSEyfeiO284bJL2pev6NXgkDLujxcGL5X9Q6v0eKuT0ymU
	N2DGSvn2U3AISgTLYpnYj2U4OlGlW8EWZHeaRZvy3xLRQyXRHLUDFFkE4XBzLVhudJ/DEcuvQ6Y
	UTkkKqXAE7WCEAjb4NQUjWTDodPvYgTArsey3wdAoHQlPEmV7rK+Xa47fmIRtPaPoxIt6jyqOgN
	/ngAMUoCwSA3SREXnvsY1L467BUEgcw9+GDzm/DhlVzKkMpPzjacNmkarSbmP/8S5VmK/PrxsPV
	OeZIqfmh7ni16qWSz85VJpOrif1T3yzrNUqYHsvCpYd2LIG9ocD98Y9s5bP7fO+Cz
X-Received: by 2002:a05:6a00:2351:b0:842:5b85:63a0 with SMTP id d2e1a72fcca58-842b1102db0mr16141989b3a.46.1780935519946;
        Mon, 08 Jun 2026 09:18:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:2351:b0:842:5b85:63a0 with SMTP id d2e1a72fcca58-842b1102db0mr16141951b3a.46.1780935519489;
        Mon, 08 Jun 2026 09:18:39 -0700 (PDT)
Received: from [192.168.1.6] ([122.177.240.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828fa877sm18865716b3a.51.2026.06.08.09.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 09:18:39 -0700 (PDT)
Message-ID: <d046aa40-3dd7-4fbc-b99a-be8076ef46f9@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 21:48:31 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] clk: qcom: smd-rpm: Add missing RF_CLK1/RF_CLK2
 clocks support on Agatti
To: Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Brian Masney <bmasney@redhat.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com>
 <20260608-shikra-gcc-rpmcc-clks-v5-3-94cefe092ee3@oss.qualcomm.com>
Content-Language: en-US
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-gcc-rpmcc-clks-v5-3-94cefe092ee3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WYvvAP2Vqrraj6QwOyv8nEbwJgqun5P1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE1NSBTYWx0ZWRfXxXrDUPgY4OQQ
 iKpVFI48onCGEaLRkVs8a7Jc5W+EH+AYXdZBUFijMPNw9N6uX3owbI3zVBVsKSjaQqGwR3qr8Xg
 gnpM9SpxXtYqtZQuB1Ebe5NZksWM4l5HlFDzROaSquA0xQjGKEaoZf64VnGcPsIOGJdNzdUKkEf
 eJFo+oaC1OQTBM6l3Oe53jlxytF9T2wKmJ9VPi5Kx0CX3rPtXxUfZLSaXzHJo73l5XkOQlnKjro
 /+AKwpNIxwsPLxZbeKqSqlhT44S2xG6U48PskMPkt5H0I/5C88XkiuYiAbRqTLrMo6b728j47IY
 wSSfpdkZi5hEDFXodCa09jJQ0w12Pt8bg8HATre6A3c+ulX5uNMWzgf9oQ5XxQgiFdNOo32qEGL
 Ui04obMBWwD5kqCEaRbmzHSsuNiVKNeAGdrlslSgvtCi6u5VjVe7L9KdFAIxEOj7HB/kPtedF9p
 p6Fq7qHSl8poKZyk6Bw==
X-Authority-Analysis: v=2.4 cv=XKAAjwhE c=1 sm=1 tr=0 ts=6a26eb60 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=dTFYtdXiv3wnlml4cWrohQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=G-4fGFNKO6kq0i09DNwA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: WYvvAP2Vqrraj6QwOyv8nEbwJgqun5P1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080155
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296658-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,baylibre.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:imran.shaik@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jagadeesh.kona@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jagadeesh.kona@oss.qualcomm.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: BC2E365949C



On 6/8/2026 5:51 PM, Imran Shaik wrote:
> Add support for missing RF_CLK1/RF_CLK2 clocks on Qualcomm Agatti (QCM2290)
> SoC.
> 
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-smd-rpm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com> 


