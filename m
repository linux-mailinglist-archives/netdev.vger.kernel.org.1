Return-Path: <netdev+bounces-193613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EF2AC4D0C
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBB5165FAE
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 11:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781BD258CDC;
	Tue, 27 May 2025 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IJUp31k+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBFD1EF0A6
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748344775; cv=none; b=L+LOHhEhtdhXBGAhL5dMrLZpiSIVMWOJXuTxG9OZmlwFe2jGrEPYSc0X3qBtVjMt2pDb9O0FId4o762/B+n4X93eWjDYb6TomcW/7URtUfyG6iwr73GTrUQPnEkQFLRQeX2ym5uq99c+0kr6K0N4tx0zzX9NS+q391ezEqqa8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748344775; c=relaxed/simple;
	bh=19feJZZTbb+km5oSmqKqxCaJrNvkXHMQEj7v3RsRCgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qla9eIH5sYkNWqdxjq9hd7o/NuTbUvfRvPHauby36Jq6fy/DdEjoGBsPK7fIxu+0jCpNh0W/0MT8SavCWThS7Dfs0fHUY3FrgRjAxBZaglAxanU0LtrlUtL0d+LePpDhaCFiyFSY5EJduBVwAZgfBONbwD0FLY8ag/PhKMEsuu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IJUp31k+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R3umuO003683
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sGGnr2Cf6uz/5zgl9H9llVxN13njxFiPARnslx3OyQY=; b=IJUp31k+8iZ8fZ75
	0IwkgnNKcfWG8ZX6uBxvXyY1Pmba9MTgMyJ9hqR/1Gcp+7OmWHv9LA8JhHQdA7i3
	0aP3cvkaobNyLO6lUXfZI/r5rOmMnNC/Kk4VIT7VLVcFNxBQNaWwqTUs1p6XoQXu
	IkRafdp2EyegDVWCus8pQ8A/XQAfHuBaonnhptNyzYVipO5H13DaAsEqum0kSqCE
	S9gCjy/EmPKtHuvimd1LZxt4GPWzAXaZ8NGenBMk9FQtlRDoAVv8iw9IKr4P63V0
	0KwSVQQfRuSO+4HlfdQGBD5BkolkRSTbb8/iuv3xdX0bX/NX11e5MtPohfZTLmUE
	AS6T4g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u5ejxkcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:19:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5466ca3e9so44637085a.2
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 04:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748344771; x=1748949571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGGnr2Cf6uz/5zgl9H9llVxN13njxFiPARnslx3OyQY=;
        b=qAPIpfsisJzMUmciAqh7m7hA+qnH+XUtn+U2qv8myHWUsQGoWSLI5n+M46hauLbuDN
         rJ6ZRaXR5kshgH96/ssp9sxQFLio/ox6hFniXlXFa8VkR82Ujr+kEGQL1eT32N8xJJZH
         lpJwzvV1cHTS8lrYFA9/uLb5+sahTLAK9wjkdyFnc7bSHmautyxbzslFgbhQL1+jb6wY
         pETa29NjaGiSBggxmnxD1bCfrUodJc2E9hl2V47OCGeVmrT4mqDpfPZOp8dD7P1F71qb
         Q08olyoDMnJFDbY/raJ0JA+hTkDQMuRLK5hP1mWCmAeJRbp1HIYDMw5Gy4Y//shCn+KT
         UnOQ==
X-Gm-Message-State: AOJu0Yz9FcISUJD33tN9ENQ2WAj+wyZBfsr6ut1A7PgMVD8jhg2kM4JQ
	7EnFglocopbWWVKS/E2kMmDdizhKCLcBEgDfFcgAANYtvOm+AVTswqu1K6S1+U5uQNt76puPVj2
	x+8v5DSh4cLu3TMurWb8xcfOs83yg5Z4k6M3yk6i4O8SDOecGPSqXoNY/VmQ=
X-Gm-Gg: ASbGncvM1grCizsUfcUqcdAxkrJk13KvPPGpVIOdCycVrA1o8NA3rf71//BX3mq/BkC
	HBrJM3Z9mWQ1tNAYoISAwQp+2hZHPzSf3AQK8d0UeO0c4EhocM1RNnlsJp+JMXGL3f+HKvakBQW
	fjpzMmSRZ1ppRsweMnIPytspvsT6O+TIF4gx/jgWiQ/VkmlLZFRWr7JWXdUuEl21hcW7ZxWnLh0
	33q6c7nf+0sdtl058CWFxVEsahyQCtVhRWcbzIceimfIE/lTmrM11mceR2az0HAeWWdjL4y/Ugo
	qthylRrJHzWhumercO0YVplcX/3PYjv6pSLQQWS1PKjSH9lp2DtG1GozTIF6tNmoZA==
X-Received: by 2002:a05:6214:2124:b0:6f8:e438:6a31 with SMTP id 6a1803df08f44-6fa9d38a281mr84868936d6.9.1748344770692;
        Tue, 27 May 2025 04:19:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVX0YQa52wzPt5zotLH02+4Oq1iIQcnbNqEa0aCHbsQCwGP7XhMmeQ5L88JOR1OO1b3BhmMA==
X-Received: by 2002:a05:6214:2124:b0:6f8:e438:6a31 with SMTP id 6a1803df08f44-6fa9d38a281mr84868616d6.9.1748344770315;
        Tue, 27 May 2025 04:19:30 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6049fe0e94fsm3125097a12.26.2025.05.27.04.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 04:19:29 -0700 (PDT)
Message-ID: <99fd4103-97e0-486d-9e6c-66c8adb70b3b@oss.qualcomm.com>
Date: Tue, 27 May 2025 13:19:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] clk: qcom: gcc-ipq5018: fix GE PHY reset
To: George Moussalem <george.moussalem@outlook.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20250525-ipq5018-ge-phy-v1-0-ddab8854e253@outlook.com>
 <20250525-ipq5018-ge-phy-v1-2-ddab8854e253@outlook.com>
 <337068fa-adc2-478e-8f3f-ec93af0bb1c6@oss.qualcomm.com>
 <DS7PR19MB8883BE13166F7CD5DCA777DB9D64A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DS7PR19MB8883BE13166F7CD5DCA777DB9D64A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GIgIEvNK c=1 sm=1 tr=0 ts=68359fc3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=qC_FGOx9AAAA:8 a=UqCG9HQmAAAA:8
 a=2jJET5DcvFRXXXsR3agA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-ORIG-GUID: DkY3C5n0Tu5ovBcfXOXtXu_fm9HzIYfh
X-Proofpoint-GUID: DkY3C5n0Tu5ovBcfXOXtXu_fm9HzIYfh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5MyBTYWx0ZWRfX32ytFG7mLCgg
 SfGBpsY2jq767jH689T+kv/0cEvV9nil9FGvVr57USmWYUlybiiAvTsur01RnZ2sLmEpcMTWG6Y
 TFqvVPdr6+EhCtikdE3a7DXSZfWY7lrT8JZGC2l9fMUsEzNv/ZmeJHUZigCENBWIH4LjvXOKFzU
 MkpzTnhq0h4anCVT/MS8HZqaR8t9aHu5qUCFNccxAc1jP9fJIgEw2qNQRigYeap+HznpF5ej3C1
 5Q872hVq9ZtPnlc7QO+GPiFLwdspKms5dsJv8YJkhq4aOBOHD7YilXW2L9wC65sYltHMg2CNudv
 rLzNSetw0W+9fHr7NIRVOXFSSd3LRS1zM0ndR5Zv3CjS6BEB06WwIT3HmWCkYH8nDYxeHZm9pfk
 S8d4VQlfCevtZPPIq8ij6DCjdJCv+8Ui0MXLLY3mJBz3XqQ7anRkWVXzSU66FZmt1UIue8LN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270093

On 5/27/25 1:14 PM, George Moussalem wrote:
> Hi Konrad,
> 
> On 5/27/25 15:00, Konrad Dybcio wrote:
>> On 5/25/25 7:56 PM, George Moussalem via B4 Relay wrote:
>>> From: George Moussalem <george.moussalem@outlook.com>
>>>
>>> The MISC reset is supposed to trigger a resets across the MDC, DSP, and
>>> RX & TX clocks of the IPQ5018 internal GE PHY. So let's set the bitmask
>>> of the reset definition accordingly in the GCC as per the downstream
>>> driver.
>>>
>>> Link: https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/commit/00743c3e82fa87cba4460e7a2ba32f473a9ce932
>>>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> ---
>>>   drivers/clk/qcom/gcc-ipq5018.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
>>> index 70f5dcb96700f55da1fb19fc893d22350a7e63bf..02d6f08f389f24eccc961b9a4271288c6b635bbc 100644
>>> --- a/drivers/clk/qcom/gcc-ipq5018.c
>>> +++ b/drivers/clk/qcom/gcc-ipq5018.c
>>> @@ -3660,7 +3660,7 @@ static const struct qcom_reset_map gcc_ipq5018_resets[] = {
>>>       [GCC_WCSS_AXI_S_ARES] = { 0x59008, 6 },
>>>       [GCC_WCSS_Q6_BCR] = { 0x18004, 0 },
>>>       [GCC_WCSSAON_RESET] = { 0x59010, 0},
>>> -    [GCC_GEPHY_MISC_ARES] = { 0x56004, 0 },
>>> +    [GCC_GEPHY_MISC_ARES] = { 0x56004, .bitmask = 0xf },
>>
>> The computer tells me there aren't any bits beyond this mask..
>>
>> Does this actually fix anything?
> 
> The mask is documented in the referenced downstream driver and allows for consolidating:
> 
> resets = <&gcc GCC_GEPHY_MDC_SW_ARES>,
>      <&gcc GCC_GEPHY_DSP_HW_ARES>,
>      <&gcc GCC_GEPHY_RX_ARES>,
>      <&gcc GCC_GEPHY_TX_ARES>;
> to:
> 
> resets = <&gcc GCC_MISC_ARES>;
> 
> to conform to this bindings restriction in ethernet-phy.yaml
> 
>   resets:
>     maxItems: 1
> 
> Effectively, there's no functional change. So we can also list all the resets in the device tree, whatever is preferred.

+ Kathiravan

are there any recommendations from the hw team on which one to use?
As far as I can tell, the _MISC one simply pulls all the aforementioned
resets, like George described.. it seems weird that it would be designed
like this

Konrad

