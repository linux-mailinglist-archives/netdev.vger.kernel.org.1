Return-Path: <netdev+bounces-262663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIB+NgmapWnxEgYAu9opvQ
	(envelope-from <netdev+bounces-262663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:09:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AF11DA65C
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B61C307EFC5
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 14:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A53FD124;
	Mon,  2 Mar 2026 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jSXEzjsF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ANBD2FZ4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796043E0C74
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460195; cv=none; b=pluc05eQklTQxusZjSJrmPDxCO1vaT/UMuK6CUfsmL6UbglVv2e7SmqS4vbA7939Vz4Yo8Wci8qbRBe7yPjb/HWxRTGFb+H24lThNHu9/hbTg3TJ2AbDHFk5XDvOEk9ea8Sdy+A0AR3T074+hbEe1bRY1aQ1tLqmALDc3XD41JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460195; c=relaxed/simple;
	bh=0DpLQsIRL9lZPdr/74iWH92RFX+op2F84/TMyMJdNV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9MkK4PvU9HZWepLKkEDjVcSifJoxAXKpJocsWJ4oSBNh1AaXCHpC4I4j86FyhpVDzIKpEgcNhiyPs717tYdGqlgGZH/lqebJKlB4tBG2WmVgoW0opSdnpgoDdXJCZSIE2E5ZC5FDs6iejpqw86vPaYnS3Nc/GxEfCw1BYb/Ikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jSXEzjsF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ANBD2FZ4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229K306782739
	for <netdev@vger.kernel.org>; Mon, 2 Mar 2026 14:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PiMIdqf+IOzKz3ex7vZG+YsmSZaXkxFqnI/VO/YvrbM=; b=jSXEzjsFDiOwiWuP
	YoPTUZbiEf2+DK2TnhPmTNChGQOU9UESkDqNbYMrSytAqpo8iO1+BATdgI3bZRZM
	3+ksWVsDRoZ0W9lJcZVOuBm2Bs2fvW4/HjslvLHuSZzAB1IXuUt+FFfev/XFhqjx
	pofjm3hi5X4Rs45qhIknt3oH/7tfW1NTt4RK+7NxYFEREoUOp9rUU4SwyfxqZoNx
	c9ebnorsnVgilTDa3mtNVFL1qzGWCLfTCOitOemAYSXIUlxJdu5re2rIR2m11JsW
	nEonFaqV91XWjynCLe3w3rd/pDb+1F+6VeiE1lC6JhTeEPNIrrqcBTNcIefeQclt
	Bbl36A==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7u00vpb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 14:03:13 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-464764d7480so7115100b6e.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 06:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772460192; x=1773064992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PiMIdqf+IOzKz3ex7vZG+YsmSZaXkxFqnI/VO/YvrbM=;
        b=ANBD2FZ40Qb7bG6vTKQUStEyRrf18372ep0Y6hjz9D3PoofYvHisxCLnf/840IYANV
         MDx1AOrQ0AB96RxSIoBbdx/dqqzwy3qtHRsWAs6O5y3btJH+MvS4SWyvDfZgbHRG2Xgp
         dRMuvlwcysCRN533X6VZYKzsUekPezz8Q8iPgMeu4nkheP7cAtrs7+XgW2rltHfY+g5B
         4CFVqpkk91U4TtNhqJ84SN3cr0xynN41PncRBwvKfeOkZAGjkswxtR/IVsitN8rRfmP1
         0tGDj2ytEKRo6yP96qlcc3n4/t53YT/2YfEwDX6lugyE8Lnyi07wY0eSLNETHsnYzXbL
         GX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772460192; x=1773064992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiMIdqf+IOzKz3ex7vZG+YsmSZaXkxFqnI/VO/YvrbM=;
        b=eVbOcpnGK2fH6p0PmrxwpG7BdEQj74L8goCyeCPhZAcS/qCvVdWFgmVJYrm1H4hSnl
         Jr2/Ulf/25oKJZmYPTp5W7VbCB3bcAunz2gMsUbzLb1XjYuvXpw9273Q3VkZqIz7WO/8
         d+zQLSpeqH50L01rZW7ZG/UXeT2Q1vl0ijUyWWzBr+iXfTsMO2h4mUZ2Oj+CWuQJih3e
         CTz8FxOo9ji7xSsHyYqswabw9UY9CWjgs06uygI1M5ySDsrgg67z7rSyqMqhAS7D8vPD
         sSiRYKQSvzgIzBV1+R0gIZaxNJNEuZ4+GrJnMLiqsgSFiDLvssqr77rQxKMYI3abJmgo
         wv0A==
X-Gm-Message-State: AOJu0YwOF2FjjeDeN2hkOkaZ7yslt8MBZY4bDpdHFBFShPlojZUgj/nM
	NsZGlwkMTrR9cR0At6MwVCYTFZwVf27noWTgsm5cz3wzgeBZmKkadf1DjCKTttJWd3Y9L2ELM4S
	vRtF9WytsSOhPu00izfZwuuX4DC95kolY3xiGQrLC+E0mH+H8iDuIxy1/RME=
X-Gm-Gg: ATEYQzwh7hOxL5WMIxgYRb567AIOMS2RMyKwPEx2jZVeM+oHG4Tc7NBfcVKQtcYepwT
	T9cbY2TUoGWS1QeuGAiD1iM9UkSqYqrpvYpR+AZuzEGy1LBurybY+pYHywtbN5ErWK1zprGmIEL
	cfx978Laa5DGrYqCUBawUwdghD1XRdTSzkfMA2fyA+gNt6foEaViHSeKl5r/NOtQM0coSnoHwKD
	ktTN8cbJWc+a0NEnOMco1np800YD6ISYjsKpY/tdJNr99ba62kl+tGHoQ94h3YIyWaEJooHgF+J
	4Wudulv135sWgTWkyV0XuqfKaJe1d7jg58/OdiayDbz9zmEm2KhQIOifw2qndi7HvSxx+oY1TM/
	M0suGMuGqijUyw8UqtELgQM5pQFCkhVMSnNNJ6CJ4+YZPGds/tzpvTGi9pFjrunGOAeNfcEIkZl
	XVKGY=
X-Received: by 2002:a05:6808:350b:b0:45c:75ec:b9a6 with SMTP id 5614622812f47-464beb75bbemr5108320b6e.6.1772460191764;
        Mon, 02 Mar 2026 06:03:11 -0800 (PST)
X-Received: by 2002:a05:6808:350b:b0:45c:75ec:b9a6 with SMTP id 5614622812f47-464beb75bbemr5108256b6e.6.1772460190790;
        Mon, 02 Mar 2026 06:03:10 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b93973d3ec4sm273613766b.66.2026.03.02.06.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 06:03:08 -0800 (PST)
Message-ID: <35b72adc-8f67-4cd1-a210-8bc88af39a5a@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 15:03:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v5,3/3] net: ipa: Grab IMEM slice base/size from DTS
To: Jakub Kicinski <kuba@kernel.org>, konradybcio@kernel.org
Cc: netdev@vger.kernel.org, elder@riscstar.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, krzk@kernel.org, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, devicetree@vger.kernel.org,
        krzk+dt@kernel.org, robh@kernel.org, edumazet@google.com,
        elder@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski@oss.qualcomm.com, davem@davemloft.net,
        marijn.suijten@somainline.org, horms@kernel.org
References: <20260224-topic-ipa_imem-v5-3-015bf09e123e@oss.qualcomm.com>
 <20260227015449.2484275-1-kuba@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260227015449.2484275-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GMMF0+NK c=1 sm=1 tr=0 ts=69a598a1 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=9R54UkLUAAAA:8 a=bTaGD7iMzZT8p6Mo4RsA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExOCBTYWx0ZWRfX+3DzMA5EU+eK
 unqPHBGSdF62TD/pWAK3RMZCF/5mdewTvozxJZLnc731CgSyRZ8xyKkh/mMr8S5OYSk2lMk8x/h
 +UQB1WCQy2MAGILqsPIn7JBwYyAHXA69ZhdA5qH6GcoDMAdVDVuvO9c5uqmsqFUNDqU84TXbBja
 HwWl5UZabAuc9UYrTmn9irzBAlitc2rrvFwhOeA6BbfZiA2YUDSBYK2Koxs9XW4X7Vf7FeP1grT
 70B4wGZ77xTh5r+Mk4AjpfBtlKRfN9LFWl5xfJHg2vPMM2g0Vcz5IW+Q3Lm6vwgKem7f1vOnnsz
 pxEkGdlWx3xfHJoXAMvIHbnv6o5ylsd9rmxwLwa3+qL8V9SIhwndSXgC7hKqlRIEe5NX8pXgQn7
 gUwezGOJhyemTUMLELUI5yMt+ypMlnxVJ05CjZHlBqVfIFxG5Vc2lijqA8PPGOf50Ts6HQ+6E6p
 5PWEGIhHBtop1ayfjmw==
X-Proofpoint-GUID: d9DXSlNsr-yDwOKhtc8OPIUk16YZhaQO
X-Proofpoint-ORIG-GUID: d9DXSlNsr-yDwOKhtc8OPIUk16YZhaQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020118
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262663-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 57AF11DA65C
X-Rspamd-Action: no action

On 2/27/26 2:54 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---

[...]

>> @@ -656,7 +659,24 @@ int ipa_mem_init(struct ipa *ipa, struct platform_device *pdev,
>>  	ipa->mem_addr = res->start;
>>  	ipa->mem_size = resource_size(res);
>>
>> -	ret = ipa_imem_init(ipa, mem_data->imem_addr, mem_data->imem_size);
>> +	ipa_slice_np = of_parse_phandle(dev->of_node, "sram", 0);
>> +	if (ipa_slice_np) {
>> +		ret = of_address_to_resource(ipa_slice_np, 0, res);
>> +		of_node_put(ipa_slice_np);
>> +		if (ret)
>> +			goto err_unmap;
>> +
>> +		imem_base = res->start;
>> +		imem_size = resource_size(res);
>                      ^^^^
> 
> Does this code corrupt the platform device's resource array? The variable
> 'res' was obtained from platform_get_resource_byname() earlier in this
> function, which returns a pointer directly into pdev->resource[]:
> 
> drivers/base/platform.c:platform_get_resource_byname()
>     return platform_get_resource(dev, type, num);
>         => return &dev->resource[i];
> 
> Passing this pointer to of_address_to_resource() causes
> __of_address_to_resource() to memset the entire structure to zero and then
> overwrite all fields:
> 
> drivers/of/address.c:__of_address_to_resource()
>     memset(r, 0, sizeof(struct resource));
>     ...
>     r->flags = ...
>     r->name = ...
>     r->start = ...
>     r->end = ...
> 
> This permanently corrupts the platform device's "ipa-shared" resource entry.
> While ipa->mem_addr and ipa->mem_size were saved before the corruption, the
> platform device's resource array is shared kernel infrastructure.
> 
> After this corruption:
> - /proc/iomem and sysfs will report incorrect resource information
> - If the driver is unbound and rebound, platform_get_resource_byname(pdev,
>   IORESOURCE_MEM, "ipa-shared") will fail because the resource's name field
>   was overwritten with the sram DT node's full_name, causing probe to fail
>   with -ENODEV
> 
> Would it be better to use a separate local variable for the
> of_address_to_resource() call?

Yes, the computer proved useful once again - I tunnel-visioned-out the
prior use of 'res'.

Konrad

