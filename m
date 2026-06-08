Return-Path: <netdev+bounces-296365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O09PLlFJJmqcUQIAu9opvQ
	(envelope-from <netdev+bounces-296365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 06:47:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C8652A2D
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 06:47:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Op28MRt0;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HBGTYaeI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296365-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296365-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A028930221E5
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 04:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C6C335566;
	Mon,  8 Jun 2026 04:46:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8F62DF12F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 04:46:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780894010; cv=none; b=cAxMHJiTSIjvsWUh+59/DMLszMrNayx9PT5uGIpOu168YbDZEMm6n2i8xiYs0e7kcjjqY5nCl1aeBH8FF8KZSz2qqSELyPi/Yko/D1UH21MY5K/XjavL7tcIkNQ56Il22Ci9gnkuGDA/qJBblB+/sNxqupEAXQkn55WfRlZuut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780894010; c=relaxed/simple;
	bh=/LzMqcu3HHGE5GBV56yl9iCiM+D7QtWOREec3mGMfy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5eNVY3qz06zZTwuw+MZzbzAi/HphKTqkCQw6LE9NskVUPJTnjpL2DDvXSxAe2APsp5WnAIyMlJH4jUekmB8rWdH/s/v6BLHJe2e8WMkqxIcjAeyICtJSFtw1TKp1QU6W7DH3tGO8w62EfZmRWBXo4K5stxxdUrttI58Cub93nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Op28MRt0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HBGTYaeI; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580Gl4K1933588
	for <netdev@vger.kernel.org>; Mon, 8 Jun 2026 04:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XaXdloh55VzPZiCRBES2vXV1HkRk8zMeWbdqdMEo94w=; b=Op28MRt0CQd+bmiL
	ZNZK2H2S+JI2Uo5Zd+z0JwD+S2pGVeI2xFxYUG47QfknUReW05Eneb7dYcjp4Mqp
	E29Q/Dn7XPBcWhXnLcCP7s53joLMZ5QxkPYVzTRCZVCwCkYYxkouzVY0vgQKGn4V
	XOT73dxR8EMH6z4ONN2S7U9tJArEdx9TICXESRmfLbM4nMyt2Dbde5wd0Np7BYp2
	9bcqM1UlCIh7F4djL8YORPvbVMIt6ggpaI454jx+L1dXFDleKFhGxRvOgchhXki0
	gNcF8EPfrK3VT9PnpUTXElxL3bYlVrh/Eib71bM3wA5s3M4tUuf4aXwSsAN9ucri
	TC0KEw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf5yjv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 04:46:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0bf6904a6so54140525ad.1
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780894007; x=1781498807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XaXdloh55VzPZiCRBES2vXV1HkRk8zMeWbdqdMEo94w=;
        b=HBGTYaeII3fTv0Njehh4iIJaMI9qWDgw6o1TgwE9j8pJ3hcggy0L1ArYN3l4bF68wr
         7ZoLkYZehEtddviKsNvNGTsTwugWveXPBTAqU7pTDoJobdutNF/SxbqQ9WR1fAZftmUF
         lWw1oDMu8IyBrm91z4tJB16Ssavhhd4nDyJtlNWnsCSVG1iyGYzGSxE3CZhszNgrECiy
         2WLNRo0qs1gZhFGbYYoouf0GThUxjcpM2bRW8sqC6agQKxy2qoo8M31FbE2GYSm8EZvD
         1VLLzjoK8xvCOnGQwSZ5Gn0TNHsL+/Kd79C8Lo4YRGA1NEXkn1Q0I6vAci/V4H3bvxjI
         gmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780894007; x=1781498807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaXdloh55VzPZiCRBES2vXV1HkRk8zMeWbdqdMEo94w=;
        b=ZafRQm2eP8bzPwbaHLJ/JjOow/NvLJhwEUwVaNtVLcs2NZx8jwpullNy6aMWwC5uCG
         RdwtXTE8iwcPTXs17DhNH4ZmZLamcRn3o9npryjo8Pqjw9i/weY8cYaTlXMAS9zEWuQb
         mu1gq3SL2y5PTqGHcv0D3QZQ5UdP22yqc5FX4WuB8a3CESOP2Hh6cJ4c4bAFM7EC7O3/
         fqJf248K7o5+UW+UDbRsFbgazvAxlMaVRYMd/vs4U+MPVP5/sIf0QU3ye6wT3y5CLhp1
         tCmeuR+PqOa6JmKwcRCxw1nPv55iW+wMWu0Ezn5VUxQvoD+Ke4+HP+qJZaRtW5K8PM+G
         2htA==
X-Forwarded-Encrypted: i=1; AFNElJ+CzC6HmsAjxnqrdBe1kcYNTk8F9m0A31ItbA7UML1bVGyx1pXaYQOKyXEb1KtOfMxYkCVM0d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBgihCyj1i5s3Kqlww9gNVPxyv/dTttBhR7Yu2erqepmgkeji
	m3UU5JoO2R3DqcmPtQgSwzQRGTdXMeS7LHVgWzi2yv/C/4DL3+EFl5mYQjqVkxhHWMiqewijFkz
	bGKM08LVx+uIUbFqbXB3ZfvRbdfq9VHZdHjo/tmwy5BFKlN+x+wxZ7hO4EwM=
X-Gm-Gg: Acq92OH6g4m0bFXkqdhVseWd9vz/EssOXgVhH96fnsA7w7ct1fJvHZ/HHr7V4nY5TMl
	oWs+dXzM4GXSZeL1SGt1eaepbGg4N2/QDXeRx4CIe/KCtultVtTsTnKxJwdTSIhWmLE7s+KJfT/
	g62U9P5hELR34rjA3M9/ySl43F84caby12e2yhDsTZ5O59y7nyxJlpcRvqbNuE3tF5zxeydZ8xU
	z9iyF3ARK3wNN4ubpD+dLbAv515gl7a9xro5T1Aa/nbWh4NV4UqHV8l6mBmvbfXvd27FYQeA0Ik
	GxMIRPOhd5bL9n8XVNrBWIToA6jg4+tIFDmZ+KZWm9tA5oz7dndlZtrdlHEGZFPKRHGhmPl2q+U
	w/+wb2RmjlOoRZTaa/WpVyD9h/w3ZsXTvolCD1LUOqflAKcoz5WKaDdE5x8w=
X-Received: by 2002:a17:903:acc:b0:2bd:6e1c:3ce with SMTP id d9443c01a7336-2c1e849512cmr151618405ad.20.1780894007062;
        Sun, 07 Jun 2026 21:46:47 -0700 (PDT)
X-Received: by 2002:a17:903:acc:b0:2bd:6e1c:3ce with SMTP id d9443c01a7336-2c1e849512cmr151618215ad.20.1780894006676;
        Sun, 07 Jun 2026 21:46:46 -0700 (PDT)
Received: from [10.218.5.114] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8bc5asm173655765ad.27.2026.06.07.21.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 21:46:46 -0700 (PDT)
Message-ID: <0a7f8ee4-2bd4-4ae6-ba6c-72b37d6ef92d@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:16:39 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] clk: qcom: Add Global clock controller support on
 Qualcomm Shikra SoC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Brian Masney <bmasney@redhat.com>,
        Ajit Pandey
 <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260605-shikra-gcc-rpmcc-clks-v4-0-a0a7bfb44455@oss.qualcomm.com>
 <20260605-shikra-gcc-rpmcc-clks-v4-4-a0a7bfb44455@oss.qualcomm.com>
 <gvqubjzscwvq4nmerwptrnojrui26ymigzs3mo5yqordyfsnx5@zxtjhsntbrcw>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <gvqubjzscwvq4nmerwptrnojrui26ymigzs3mo5yqordyfsnx5@zxtjhsntbrcw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a264938 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ayl1ZFWQluqbhyEjsXUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: Di2-SxGRHWm1QXfR1A17YV-k1LLg--uK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAzOSBTYWx0ZWRfXyylEMjBdK+Qg
 0S4GWiAY78sP3XN61eIbN7+EAn/Y/sOKfl20jluQisEixjndhi74hcAtTYIKIY7luRf1j+ax/GL
 atXobN8gETjEho28MBEVoKftt0WSqTGy/4mWXAJoKcPcqqyrZvhVqSzbVbrjQl3RJNs5nHiKdnT
 8iBX+vXXh+FpNgNwbYVjbwbQhI3B38HrKB7deAUTSJ6d15s3y52jdRULCXLxOCyOikbbU8VJLPL
 KE0wbRosN5paYj8mCHycgcYkCDpx40zjwEscjl17pMVEAVzBPql9mFYryQ4/zdXpfoLkSjNd9ce
 7xItDWgmh9uAkqeKAqGfhQvQmtujn/0wbBtYpTuyJShTIGXtJSz5mkLdFwtYn44+zCukwRxI90o
 8f6QPfDf7bAW+p6F6pg6Y8g/QONHKiFA5ntvaPgj5Vcb5hMuK5XHBim310UrTAw9vhCgmv8n5sy
 FD3JEF3/SrKoTXq1khQ==
X-Proofpoint-GUID: Di2-SxGRHWm1QXfR1A17YV-k1LLg--uK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080039
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-296365-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmitry.baryshkov@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,gmail.com,redhat.com,oss.qualcomm.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: 514C8652A2D



On 06-06-2026 05:12 pm, Dmitry Baryshkov wrote:
> On Fri, Jun 05, 2026 at 04:49:14PM +0530, Imran Shaik wrote:
>> Add support for Global clock controller (GCC) on Qualcomm Shikra SoC.
>>
>> Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> I know that I've r-b'd the patch. But then I also compared GCC on Shikra
> and Agatti. Is there a chance we can merge those?
> 

The Shikra GCC has new addition of EMAC, PCIe, TSC, USB20, QUP subsystem 
clocks. Along with this, several Agatti clock/reset register offsets, as 
well as votable clock register offsets and enable BITs are updated on 
Shikra, and a few GPLL changes are also present.

I agree that few clocks duplication will be there, but it will be a 
clean and better approach to keep the separate driver and bindings for 
Shikra due to these new clock additions/changes.

Thanks,
Imran

>> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>> ---
>>   drivers/clk/qcom/Kconfig      |   10 +
>>   drivers/clk/qcom/Makefile     |    1 +
>>   drivers/clk/qcom/gcc-shikra.c | 4431 +++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 4442 insertions(+)
>>
> 


