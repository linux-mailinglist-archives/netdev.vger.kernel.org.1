Return-Path: <netdev+bounces-264237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC4oCNRKqWn+3wAAu9opvQ
	(envelope-from <netdev+bounces-264237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:20:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7691620E3B3
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0986B305E300
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFD8377578;
	Thu,  5 Mar 2026 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQRkPmX+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="elIVdE5x"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1606377560
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702115; cv=none; b=IVLaRCYMZ9MgsHYcgRcjEDvJaIy7eNnn77Cj7cJN+8MfzAf3XnZlXNYGeh/IWPqyEJkGq5/voKXMux2p3JQOdbdAVqUSaHrVw+Ct+2b22Wchf6TdwXftN7O1umotUxXPg8rRsghhE5LUxPKPVBY4iSNnTcnMlWuWvm3cqMQ7p5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702115; c=relaxed/simple;
	bh=XRZpedr+2qpOkN3fG8Q8Osa6UFaMF5goxsvzLuitC0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWonXAt0o5WutQ/VbCizpMqy7sddtC4U41NXky8oFU9uaUOP85OxjwcIdEiC/NheRgWDp/ucUE8ycp3aKOz9mI/bFMTaDd4WY6zlLM49fpyzeHB9+DIhHVskjSeWJJ3QXGI+m3dppRWvteHovwDZs2ob3QWWKfygcPgIiJkcm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQRkPmX+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=elIVdE5x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6259C3gO3665284
	for <netdev@vger.kernel.org>; Thu, 5 Mar 2026 09:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lB2MyXzqwL2fKx+Ie3b2ww9IDsTWQhJEMy9qeDpkHuo=; b=fQRkPmX+D74BHrMb
	asyUwF1awRSU41+Alv6Wnw7Gs81vmURRSipvQe26gecP5AjxUQs2FjH2evlpCBle
	EvlJTGeq7/hZa7TgbL/eiwIfLm9VDQ84HkWp0PDa9k8zC3mFxWdX2oUrXIvDSeUO
	MJlRb3hfiqoNxb4lqLQBC5yk39pNljrdNKN9SvZotseq/6rNLYILsr5slIzaGT2r
	CXRqeu0rHZQRIblzagGnKAQ//HjjGknA7AXeqY14HW8GLv/JQd3X9Okrf7xmxJF5
	2NdQ/R4sUdq3+kMqXrOnJ6N/9Kl6X1z8XshPF4tixarfRUFzzIjQtTlkBNy1zXbb
	lHd6eg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq04u1d4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 09:15:13 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89a012f8ab7so25540606d6.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 01:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772702112; x=1773306912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lB2MyXzqwL2fKx+Ie3b2ww9IDsTWQhJEMy9qeDpkHuo=;
        b=elIVdE5xveLAfRBnCtdDhukPFFVPhEfx0OAdRQ+3+MO7xCuxXqfJWTMfdS8rhrElSB
         13662Oq8ZZ+mGNGAeBf79TlXnCqjKrxUQFmgbHcVs0Zeip04r7A8Yk1GvxcLKd3ltuST
         M/JefZb/htFzUIIT1RehJM3GGC8jTSHr8k0zAoa7kQ9plHRHLdLjj/iOTjMRnj0Lw8bh
         DAjTfpJLX5OxJsr8aeSjnX5iJgkEjJNnPQ7Kc+nkLONfrP+A0ra0gBTJZGDKVlvNBIMN
         fSZFBQoZg7UuhVsHa3O3BKxTI1ghb1zQDYKgW7zMjyHuMpTICO6470i00cL1VyacoETu
         5PxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772702112; x=1773306912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lB2MyXzqwL2fKx+Ie3b2ww9IDsTWQhJEMy9qeDpkHuo=;
        b=meYnFoeIFlGynvRdNtF0ASL6xnP8fhFPVWm5TeQPA74iEjsc/nojHmrr1ZXfc1H/xi
         3Rdysp09q6We4SuORYnOG8jktrKViIKTc3TQDFUs9Gc/LT2rQYwZkOOnMQck2kHuIF2g
         E/1D66300abFNhd7AR4FXxOB9Qe9TWAfG09PCNQLhcc7QITUu5EEflL+Rr64rTm6jSYO
         x37UTNJ1q1jao+cAWV8wEixVQ3hSdho/TmdyrczFGh7AG0YQsVNTi+gLLLMMq0ZuegCa
         B3igyKkUfEk+0OLDxfC6DZ1YwmfWFdjV9gQvbby0vjIjhh2MjebHLR2JkUZqFB+PvFr8
         to5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnMBMyivG3u42p8AmZ+cKPaaAyWTk+6eDZRKM3liclsbN1LRCWRaMww6bZ66m8ppPSRcaZEyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys0PlpZNdjyV3v/FPjumtC453KA0sC14mZprT8UZ+XqHY4G/vl
	3DN+HC4oz+PNataSmFeT4MJKKS6rfVyplBOa9DJqX0yHTFXpNKykySQuTlt9NLAYqHO6hSP8TgX
	CtHDa2OZ6eDWUflP8ZSY4TVjiOvQ5krMIzoHWY16xchbR6HhXjQfwn8av/jw=
X-Gm-Gg: ATEYQzxMRmZCAMe1PbixIkJC/GnPO4Xnj6Zx71hxvbp2KSxHt2xPFR9BxxfsGLP/iru
	rTscN1seGgGzMGqHcmlQTtWiaDjqsxK/1SQ28+hGTa9k67dIHD6B/fSkQf7+NgGJQRH247OM8pW
	QoTWBg4gyWT/FCFxmcTE6cTrQpYHOxahPmFrgrIKhuJaat6g1XKcu6riicBgO5RCpV25pEcHkGg
	6XiUjTQ3gGYoiYklZ0wLXQJedZpUfQB2WwvLUfUxucLySmkg9/Sr3GgV+UEScE0JbMhSPweR+VM
	Kma5srU/locsXJw2hzjMn4SAUuaHXMGNfSZ0F/qLbWY6pTRoObmIqreSQLo2owV6IvYUhJC1wv4
	jGG4bjCv5xW9qu/+kxR6ou/MW8baZku+Wz4hCNNreZ3xYGqGkSkBEynK7XfnNpsUE4PgaJu9nXA
	fhwlU=
X-Received: by 2002:a05:6214:4842:b0:89a:1720:4c5f with SMTP id 6a1803df08f44-89a19aefda8mr48644746d6.3.1772702112253;
        Thu, 05 Mar 2026 01:15:12 -0800 (PST)
X-Received: by 2002:a05:6214:4842:b0:89a:1720:4c5f with SMTP id 6a1803df08f44-89a19aefda8mr48644286d6.3.1772702111839;
        Thu, 05 Mar 2026 01:15:11 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ae666eesm878784966b.35.2026.03.05.01.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 01:15:10 -0800 (PST)
Message-ID: <19c70059-ee24-4b16-8df2-d5c9274ac6c4@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 10:15:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <ebee2fcf-9069-4a9f-ae72-86f4471cd4f3@oss.qualcomm.com>
 <20260305091336.ls3k24ieehntxf4f@skbuf>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260305091336.ls3k24ieehntxf4f@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ONw8JpvTh9E8Rqyulwxw5KgVKAOijYnX
X-Authority-Analysis: v=2.4 cv=eqTSD4pX c=1 sm=1 tr=0 ts=69a949a1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=6df94im0sWgtjZpQi0gA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: ONw8JpvTh9E8Rqyulwxw5KgVKAOijYnX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3MyBTYWx0ZWRfX7hyACNy5Zber
 YmdgycyYXrJAAZ1LMlCeT9viwISuUwwnT0bFOvByu4Undd/VL9C68O8yNeNC7YbQ12mcKynS93w
 KCJdF9u7btFL/KjBuIQIo4Oc97JaoWS+u4im8sOOvrHpMqPwI9t190EM+tYsiBc0tplampA5M/l
 6iDbE/cNwMvvmle5r6I/t5RWLMP/X9iRrE0g6+EIrkfBnBu17+bM3gPb3N+VDxNSHT3H4l4dhMo
 WF+fTDTqJRggJaNHmD38tThbU9cJIGuOZ3CmAHRed8nuvViue7/M5ohsnhDg37SUinBZ5SJ9RES
 icubYeN7wKYUbVmGIIkN4adEVAu0Em1JYvQPB94q7frJiotPkXz+ThF3mqX6GvtBDAStciqz+fO
 B7YvyqRAYsSpXGiU5qhpWaKMzorIwgCR8z6l1OvHYmoerbR0IlsGfrWTwJDA6pLBE7ZpVbjcxoT
 kQZLaaPMHyg32LM6t4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050073
X-Rspamd-Queue-Id: 7691620E3B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-264237-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/5/26 10:13 AM, Vladimir Oltean wrote:
> On Thu, Mar 05, 2026 at 10:11:32AM +0100, Konrad Dybcio wrote:
>> On 3/5/26 9:51 AM, Vladimir Oltean wrote:
>>> Hello Konrad,
>>>
>>> On Thu, Mar 05, 2026 at 09:39:35AM +0100, Konrad Dybcio wrote:
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 55af015174a5..bdfa47d9c774 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -10713,6 +10713,7 @@ F:    Documentation/devicetree/bindings/phy/
>>>>>  F:   drivers/phy/
>>>>>  F:   include/dt-bindings/phy/
>>>>>  F:   include/linux/phy/
>>>>> +K:   \b(devm_)?(of_)?phy_(create|destroy|init|exit|reset|power_(on|off)|configure|validate|calibrate|(get|set)_(mode|media|speed|bus_width|drvdata)|get_max_link_rate|pm_runtime_(get|put)|notify_(connect|disconnect|state)|get|put|optional_get|provider_(un)?register|simple_xlate|(create|remove)_lookup)\b|(struct\s+)?phy(_ops|_attrs|_lookup|_provider)?\b|linux/phy/phy\.h|phy-props\.h|phy-provider\.h
>>>>
>>>> Would looking for the devm/of_phy_ prefix followed by an open parentheses
>>>> not suffice for the 'has function call' case, instead of listing all
>>>> currently present exported functions?
>>>
>>> This would maybe work when you run ./scripts/get_maintainer.pl on a file.
>>> But I would like it to have good coverage on individual patches too. And
>>> since the devm/of_phy prefix only matches when you "get" the PHY, not
>>> "use" it, my fear is we would still be missing out on the most important
>>> part of the patches.
>>
>> But that's just '(devm_)?(of_)?phy_[a-z]+\(|includes.h'?
> 
> Yeah, but what about the networking PHY API, phy_start(), phy_connect(),
> phy_inband_caps() etc?

OK I wasn't aware of that poor namespacing..

Konrad

