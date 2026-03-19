Return-Path: <netdev+bounces-269452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI0+HjD/u2murAIAu9opvQ
	(envelope-from <netdev+bounces-269452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:50:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D2B2CC33C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 006C6300D340
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5C82C1780;
	Thu, 19 Mar 2026 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IuI2TldG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EuGS26ls"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7FA259CA9
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928236; cv=none; b=UaTSY14UTGcxG42Wotnsw8XL/HFC/oVYVbjKGBbqZxo1yFMOhiDgTsnzLXClU5DGzOh/UHPS20odxgvf9m3NzDx6RZuwEQsicl5olNaTBeGm1/27QWFLYdRQkpbgVqBOjRDQAl6PCRFBRNMYrmWmEgdHv84zTWS+FsHIitUAHKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928236; c=relaxed/simple;
	bh=dQVdjw87sBvKPcjUeJ6Wk7DOjdeLv2QTztp2sAiPup4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ie2bTX3Gz8nnnWcea9Iy1gu9nmG9gzdJxzmgdDjrMkSXRD/Rx/eyC5hk0SQSI5r1+Wf9bWFZMdsbZRYmyXnL9YnccR22aytxqAXtIcpK1U81McPxf1Q8ZGzCffIp7U4AAwtRlaD5bKuS/nzhzCu1eGyjJdDFpIh11/SIVGD80HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IuI2TldG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EuGS26ls; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J74Drr2667311
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yGnqwVoeYcW8W8OE5dLl7cCg9GnEoBMh2C6juWu7YIw=; b=IuI2TldGbTeO1qOd
	T0bsZ0Ejm+yCkLIXovag4tC8Q1EfpPq9+7qsvWduPeuvyV36vJycPA9eFUhm5uac
	eman+oQZZDmIKxadtUgNxvMVDX30gUMjkuFPwbgPbHjUyfUdAiByfKGanto/cz+I
	sKpwiggt90ElyijYFMQAT7JHsitnAEBEJGzXUOFq0vxVK06Z2eAnmMj7YqyiKOhz
	H7S18hC7MEDHuHqer12XHZWkMGLcw80UNrdRn6BgA4GsGq4KyA0dWsLVUlwpyAXQ
	+2gjnWc7r/WUtCxURQ+263VxqdNgPGpa6spJSdtfadrbGSvJk49OWUIWqAW+vR3t
	GFAkPw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cytj54x4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:50:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b2fbb5136so2723451cf.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773928234; x=1774533034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGnqwVoeYcW8W8OE5dLl7cCg9GnEoBMh2C6juWu7YIw=;
        b=EuGS26lsGagpUuElz2k/MCf9qHg378VdnzBcHv+kEyjXL2sIaJ3oajsBDPbAn8EqfC
         OWvGS6CXIrv1XKqpQ+9sNdhPJZ73oJ+ysxBV+DA/w3cT3uNn5yFi5NvRsaWWp+ymB9pm
         ZzrAbyH9kO2jf3z+cgXOkqHUF6M7bKtlLgiFgOUZJB/bwu40bRl9xV8+kqmbcjgWeWrl
         9FKQsnmg0mHDyqIMnIHufIGqB7l7IDwwTuzu3yJJIBGs4QTA7m7U0E+GKHsFcLIghlVp
         0AAJ4pp+pzikJwlhgvWk+4jHSicOkyC6zMYmyIYE3npeQ2mnekqGi7pXvKDpjumbzm06
         ITYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773928234; x=1774533034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGnqwVoeYcW8W8OE5dLl7cCg9GnEoBMh2C6juWu7YIw=;
        b=iywpH3+9P+dzhvChvTregC4tw8HoGg4neCjQ8xyPk1GHwWpqN2KePqNXcHcTBWgUCE
         /2WyNZG5Ih986QfzjZcuNptoIj0CZCGJhEtmvA46aBTCmU5nfEvpiVWRW5auiJXkLcKH
         JCZKsx0vJ2idc2JXaPpX5ZXjIi3FFEEpCzhSExc6N9WVkPLuqq16ppCGi9A2QdP67yqC
         /2BXR8BzMNCS4fwfJ63lv+mEqaXulcgAxJLem6Kce5H1+aCqhwc4TWuArEH4piIMA0p9
         iHUV10QArtvOTSUFh6YetKhEFtWrWZNFoQqhmf4uUDI8VBDohNfaF/aVa3CmqFuqjjvF
         lROA==
X-Forwarded-Encrypted: i=1; AJvYcCWMYV60kAVtEJUlqvcxk9aItSypR9jBz2Rcr4kOgIUsIUkEBysIWUF3wA3Co9plRqIpvszLm7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCau3rffplU1CNcGmMovvGG+J7Fzxzbw73modNhq7FzMUqyDK
	H/26TBJm6kOgTO1VCuPOX8w3JudKmq0ofZU03U2MMsRiMjwFR49iHynMxnu2jz32qUY8jmAb4x0
	5W6+jpuR8fvibQSFywshvRhP6oCdBEWYoL7X23wUzuLbCs2iSHvbMml1f6Mo=
X-Gm-Gg: ATEYQzyKCnstw9Uub6gOAHqFiU+ECePHnbx+bGhEASBZ1pLYp+M8QF4rAL2hamLOaSu
	ANX7RHfssbRNXtRJMqOGgB8+I/DHECzcoEJ8BHAlWXF+3STKsCVbA9AjHagpGYdpefYAnJ9r+Zk
	l0jW6e6taUCurXDvBV75Z9QTIj4eqqjX9nINKPaLvjigihmLkZHoNJEnRaW39sz5wx/6r7wyWIs
	p5NKwtfJYc5w3CYhN3fLsF+4CuB6X3hkXm15Cacr3YhpM2a9z9Kf/cFpBZzxfqfJFeSbRstH7DQ
	TGbfje4W8xbDjaAwx6NSX02aheFvCMLidzmnXuWZnSunwRGib6IIjnlOcTopFgTfPpCFQXzeiKa
	KPTjZ93vPqwW/2mnHVEQmaprB9Z8MxJa47qH7R4YGKDFdDVRJzua7XLBqSHNUHIDni0VUEiNLzw
	zyv20=
X-Received: by 2002:ac8:5f4e:0:b0:501:4767:a6f with SMTP id d75a77b69052e-50b1478e819mr78290791cf.3.1773928233290;
        Thu, 19 Mar 2026 06:50:33 -0700 (PDT)
X-Received: by 2002:ac8:5f4e:0:b0:501:4767:a6f with SMTP id d75a77b69052e-50b1478e819mr78290561cf.3.1773928232827;
        Thu, 19 Mar 2026 06:50:32 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f144e53bsm462429666b.25.2026.03.19.06.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 06:50:32 -0700 (PDT)
Message-ID: <bcab38a5-e7f7-47c9-ab9c-99294e095c22@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 14:50:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] net: stmmac: improve PCS support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue
 <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
References: <abQC7r38QLhSeadl@shell.armlinux.org.uk>
 <abdEscs44fU4kRag@oss.qualcomm.com> <abdYu864OmNWiWIW@shell.armlinux.org.uk>
 <ablpxwGks9m38fhM@shell.armlinux.org.uk> <absjNQ2s3Z5N2Zwo@oss.qualcomm.com>
 <abtE7sDT75I7uPnk@shell.armlinux.org.uk>
 <abvAuHFZzCFobO-V@shell.armlinux.org.uk>
 <7566c66b-2dda-4b29-b59e-4e4a7e159e21@oss.qualcomm.com>
 <abvy6nZyjyxUXMuf@shell.armlinux.org.uk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <abvy6nZyjyxUXMuf@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEwOSBTYWx0ZWRfX1X3eb0Zo+ag4
 VUGvOtfR6Q/j9sowHpuoG/wevdMVB0wglSb6SgjJDLEK28STyyb4F3WpZTT6peJTt1x7Mqsx7ND
 Tv78wbhH2HcBn4UnwRMIdTHdGRFJimlgAVFUNX1hJ8hrzZwCi4SB11mwJ05orgFLxBhWY696vS+
 dAoU2qUxwNwAURmmqnPPqISr/MP7HIeZM+HvIHpd1q3IUYsZk9SNC+KXOLcHLD0SZMn3H1sxV8Y
 yOSmjY+mV1QOq9bETEovk+OpEVdmzzquL5ctAbekl9UtgnxSkDedNDx7GBEJFwo/pwq9RCQAAQD
 K2z+aFYuWs+AJPR0HmuFahHRXXdULqRXN2oUgao0iJkH7ac3rWIFHQrgtIODW1fMDk44z2BR3cz
 SffQcHHSPKCKueEthiid+RbFQ0W4cmnx2j8QLMszd5EQW3n/rAZTxSM+FWTOX56VlKacYA/Y3kv
 nfWNfdDi/3U5lsCs4AQ==
X-Proofpoint-ORIG-GUID: Zbo1qw5ZMjKbauCqYVBSuMH0ROEqxp1e
X-Proofpoint-GUID: Zbo1qw5ZMjKbauCqYVBSuMH0ROEqxp1e
X-Authority-Analysis: v=2.4 cv=dM+rWeZb c=1 sm=1 tr=0 ts=69bbff2a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=WgXOwRHnL7ZWy7TE_9QA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190109
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269452-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 17D2B2CC33C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 1:58 PM, Russell King (Oracle) wrote:
> On Thu, Mar 19, 2026 at 11:09:33AM +0100, Konrad Dybcio wrote:
>> On 3/19/26 10:24 AM, Russell King (Oracle) wrote:
>>> On Thu, Mar 19, 2026 at 12:35:58AM +0000, Russell King (Oracle) wrote:
>>>> On Thu, Mar 19, 2026 at 03:42:05AM +0530, Mohd Ayaan Anwar wrote:
>>>>> [    8.650486] qcom-ethqos 23040000.ethernet: clk_csr value out of range (0xffffff00 exceeds mask 0x00000f00), truncating
>>>>
>>>> Please look into this first - with the MDIO bus operating at
>>>> who-knows-what frequency, this could make reading from the PHY
>>>> unreliable.
>>>
>>> My guess is clk_get_rate(priv->plat->stmmac_clk) is returning zero,
>>> which means we don't know the rate of the CSR clock.
>>>
>>> From what I can see in drivers/clk/qcom/gcc-qcs404.c and
>>> drivers/clk/qcom/gcc-sdx55.c, this looks like this case - the
>>> struct clk_branch makes no mention of any clock rate, nor does it
>>> have any parent. From what I can see, neither of these drivers
>>> specify any rates for any of their clocks, which likely means that
>>> clk_get_rate() will be zero for all of them.
>>>
>>> Sadly, when I designed the clk API, I didn't think that people would
>>> be stupid enough not to implement the API properly, more fool me.
>>>
>>> Under the old code, we would've used STMMAC_CSR_20_35M, which means
>>> we're assuming that the CSR clock is between 20 and 35MHz, even
>>> though the value is zero. Is that the case? If it's higher than
>>> 35MHz, then you've been operating the MDIO bus out of IEEE 802.3
>>> specification, which can make PHY access unrealible.
>>>
>>> In any case, please fix your clock drivers.
>>
>> I'm not 100% sure the currently-passed AXI clock is what we want
>> there and the docs aren't super helpful.. is there a synopsys-name
>> for it? What rates would you expect it to run at?
> 
> There is no easy answer to that - it depends on the bus interfaces
> and whether the CSR (register) clock is separate.
> 
> The likely possible names are hclk_i (for AHB master), aclk_i (for
> AXI master), or clk_csr_i.
> 
> It does state that the CSR clock should have a minimum frequency of
> 25MHz to allow all statistics to be properly collected.
> 
> The rate of the CSR clock needs to be known, as selecting the divider
> for generating MDC within IEEE 802.3 specifications is rather
> fundamental. You may find something there which hints at what rate
> the dwmac's CSR clock runs at.

If it's either AXI or AHB, in both cases their direct parent is controlled
by an entity external to Linux and their rates may change at runtime,
based on aggregated needs of the bus. They're defined as levels/corners
(abstract term for a hidden volt+freq combo).

It may be that the operating range for the EMAC removes that variability,
but with no concrete evidence and just anecdotal experience, that's only
the case for the AHB clock

Hopefully Mohd knows more 

Konrad

