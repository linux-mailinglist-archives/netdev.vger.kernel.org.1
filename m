Return-Path: <netdev+bounces-222037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA21BB52D4A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18691188B506
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 09:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE59C2D6608;
	Thu, 11 Sep 2025 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BN8DNZeu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C02DFA2B
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583011; cv=none; b=ayvW/uJtVsC6V4xfa1IVxN9QpG4UJyRjRSpmazCfhYQM0ubqkBYcBy7oROwrVNpAr2vtSUBpM0eiIUhx7CBB91dN2NdKenr6MDPdR6i7JshAm0sKN3Mq0PP1O0AY05wFFTMEOSRJGX+5uL21jhccM/KND5IoAzbKQh5uyaFTJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583011; c=relaxed/simple;
	bh=9gYtag9MLEOCAGI7tG4fC8gYTxz7HysnYeVHwJfhGyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYpPLCkiaA52dDedmxFTOyB6orb7REqrQShLlaVWUnIfL5aW8TRGLuDnOvWuglkk+0FIdYRJZBFGplxg9gxG3OQ8dDDCahQyujMrtyExj1buR/yN8yNEeTXCHc2RXKjpR9aLxmW/4tciaA64GuxjwxiMpvObuSuT14ZyOMgu0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BN8DNZeu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B4kGXN019107
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 09:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4zEnPzFVE8t3bC1R9rCg0zuwA6Ldkx+mgUvoY3rTxV0=; b=BN8DNZeu+8SuM/Zt
	ubyblklFV4TBsBtcvSlCa3YYL/fKjTtbAxMGIY5EGTx98snDFeQEvNV1uv+fr6U6
	pE7DVv6JRC2n/LgbwTInJ+92NMjiuXmneW+76eFUXw9ogHh4ZxtJ5HK8x4mps8bh
	z/Eq8BX0gkk/M9GHq/c7nuswTXXPKJLyREDUlChhXfgfDzEwz66IP6M5Odndo1n4
	IUws9MYf/twsG1VPSMRdjczq2R0TijdGzDMTsS0L+ni+YF/8JI6riJ5Xc2mj4QIn
	fvotVWT3gBJJ9nI96oy7ujVnaRFK5z+zValRjkgZmEccmDDM3+jWm62mUOfjSP49
	XoKbKA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493qphrtm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 09:30:08 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-726ac3f253dso1909896d6.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 02:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757583008; x=1758187808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zEnPzFVE8t3bC1R9rCg0zuwA6Ldkx+mgUvoY3rTxV0=;
        b=S4r7efMXwl5W2eDiw6JURbGSSpY+IPAcy1iyAOTyq1ahHY5CNv1k+pR5I5zwRnaIzN
         h4JyWctiddFwpePPDwIo9s1HO3w6IxggBQnhYyRKiGLTmmc6icUcx2aegL50EJO/gqo5
         zEtegISCExJoAFYj124B4syQaYpgRYQYGOdGaYzcfb8+D5ZqsFIcnXkuohSDp1U/mPOb
         B9+a/FJpViUOGime4wwhkDplrdS5kNXsuIWOHiw4m3RARXBfOgqf8rq2C7X4NZgozaWI
         YpfJ3RvsJ6HMpz4M4YCCYCG/Cun4qg+jDDxIc6Arw9XXBM+OENW1ogXx4Aqbi/vtWEqs
         KpPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSxoaf+jgTbyo2Ctp2WZAkrw+uDAqD2ShND3FGH3y3JMf2X2uyJ6jdmDhwNxZ7Qpz6zS4R+y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoppnvNFsji0EXE8UGBqWPix8CQ/kiNpo/UtU0qZzd8Nx9v1Vs
	DKMuBKiEslp3y78tH7DfXol2v4b1zoQ7qve1pl5lCWpGqYnqW36UjgjEP3R9haTxSx3xioH6F+q
	eBW3/dnSQztUw3qeX7lRx5ZCq6NEgbctaPxmLn/+yPXZF3TKMoX4fxHJ4gb8=
X-Gm-Gg: ASbGncv+3HRuri2AbwkdWzbqqJTMcXajpIBo8ltKclrVjJSODBwcjQ8fp5Q57JHPVvF
	1bnluHXyrDY0xJssygg+IuqdCYE0Y9cJCkS/FtNv05INWgqfifDFUPzKETLYxFp7Jc41gydw/zl
	/H70BrA690WGGRIBMwudYK7NxATCNaTvjV/NaCnCIM6p1hLWVatOEaocoCk/dtIWq9ZIdQ1O77I
	zEd/yV3PaH6y3drfSvFd5kuFzAGz4omAV32icnRXDQbSHMEahogKUsnDVzJh7ekuQwfAhbetgGQ
	1+Ittg0dJuaZu+9pTBXVnF2nvwknO7AR+wEVv2uHVSt2qBnKe25X1/7Hp5dsPAYRE5SmO1lq6TL
	jAOOmTKOlS9yF6V0xCb0hNQ==
X-Received: by 2002:a05:622a:190f:b0:4b5:f4c0:5fd with SMTP id d75a77b69052e-4b5f8531717mr137696111cf.8.1757583007535;
        Thu, 11 Sep 2025 02:30:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVS5MMc+bsMDXcW/LDyPpJzdvX7Md47Pa7qu67qrv0jvmEfxL8qsY01l4Lv89+nv+0uNmnfQ==
X-Received: by 2002:a05:622a:190f:b0:4b5:f4c0:5fd with SMTP id d75a77b69052e-4b5f8531717mr137695811cf.8.1757583006940;
        Thu, 11 Sep 2025 02:30:06 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31287a9sm91470866b.41.2025.09.11.02.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 02:30:06 -0700 (PDT)
Message-ID: <96f7cd40-e5ef-461b-9dc5-44e23bdb4bfd@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 11:30:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: net: qcom: document the ethqos device
 for SCMI-based systems
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh@kernel.org>,
        Giuseppe Cavallaro
 <peppe.cavallaro@st.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew+netdev@lunn.ch>, Vinod Koul <vkoul@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Jakub Kicinski
 <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org
References: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
 <20250910-qcom-sa8255p-emac-v1-2-32a79cf1e668@linaro.org>
 <175751081352.3667912.274641295097354228.robh@kernel.org>
 <CAMRc=Mfom=QpqTrTSc_NEbKScOi1bLdVDO7kJ0+UQW9ydvdKjQ@mail.gmail.com>
 <20250910143618.GA4072335-robh@kernel.org>
 <CAMRc=McKF1O4KmB=LVX=gTvAmKjBC3oAM3BhTkk77U_MXuMJAA@mail.gmail.com>
 <b83a59f9-16ae-4835-b185-d5209d70a0f6@oss.qualcomm.com>
 <CAMRc=Md83STGFYya5eu4j33=SQ+D6upcP-7fnBwKo2dPdTtX+g@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMRc=Md83STGFYya5eu4j33=SQ+D6upcP-7fnBwKo2dPdTtX+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aPDwqa9m c=1 sm=1 tr=0 ts=68c296a0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=QdYl_KjyuFFhde6HtdwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0soF5t1xEPDe0irjug42s7hPm74bpVre
X-Proofpoint-ORIG-GUID: 0soF5t1xEPDe0irjug42s7hPm74bpVre
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA0MCBTYWx0ZWRfX5TysRIvlgKvZ
 T1kAGgw6uJgkCPCO6mgaUZrhW/KQPSLJP//ivWyO8GnfVvKem1UFLDpTLiDU6/bsx1rdOH1QVmG
 v2e9WKf7hhMNbS4rSslmQz+4vdrVNWXLCeXAoWJUOmdhKDnZLhm37c6tWd0LYfcf7R6tiUplpJO
 w6ydUO0uT2QuRhpSQcH1T2S5JEBe+bL2PBzA1+Jl5gYGiX4FbiNXpw0wfNQucvMn4dPR1c2ctg7
 I6EgsgQgBj7u4jFgAj07vouPzXnuvU4aZPe+Dbq6pEkT4JqahOn7R0oXkBfLphXBGKWzSMerH0K
 P+X9XUMWntbhsE5Mgkim11oRHz7b453eLXSTWHnVWj7BjhSZRzIsWiy+je+EdSzCQZXoyalSTVr
 S/gSgIwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110040

On 9/11/25 11:22 AM, Bartosz Golaszewski wrote:
> On Thu, Sep 11, 2025 at 10:53 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 9/10/25 4:42 PM, Bartosz Golaszewski wrote:
>>> On Wed, Sep 10, 2025 at 4:36 PM Rob Herring <robh@kernel.org> wrote:
>>>>
>>>> On Wed, Sep 10, 2025 at 03:43:38PM +0200, Bartosz Golaszewski wrote:
>>>>> On Wed, Sep 10, 2025 at 3:38 PM Rob Herring (Arm) <robh@kernel.org> wrote:
>>>>>>
>>>>>>
>>>>>> On Wed, 10 Sep 2025 10:07:39 +0200, Bartosz Golaszewski wrote:
>>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>>
>>>>>>> Describe the firmware-managed variant of the QCom DesignWare MAC. As the
>>>>>>> properties here differ a lot from the HLOS-managed variant, lets put it
>>>>>>> in a separate file.
>>>>>>>
>>>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>> ---
>>
>> [...]
>>
>>>>> These seem to be a false-positives triggered by modifying the
>>>>> high-level snps.dwmac.yaml file?
>>>>
>>>> No. You just made 3 power-domains required for everyone.
>>>>
>>>
>>> With a maxItems: 3?
>>
>> In the common definition:
>>
>> minItems: n
>> maxItems: 3
>>
> 
> Just to make it clear: if I have a maxItems but no minItems, does this
> make maxItems effectively work as a strict-number-of-items?

Yes

Konrad

