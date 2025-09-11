Return-Path: <netdev+bounces-222025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA36DB52C41
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13753BBA60
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 08:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F0B2E62C5;
	Thu, 11 Sep 2025 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OrIY/QGA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77E2E5B1F
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580814; cv=none; b=h3It2/VdGyMMkStwtEC1z9H/RCUDgeYSuHAmfoH6QqCiZRMEiq0oZrBRTnI99zUihikG7yAFux3vGewaRxNLaKT9ecxDHVqqIHd1XZdNoISLDkoTRpMNQlNtY3ZPV89YspkRqXUL94arvLh6AjwwutQf7KQLIohRcAgI4Ajx8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580814; c=relaxed/simple;
	bh=rAsx1W0BJTPP4nRI2Q1Nmo+8/AQQ8dP4RLS8RmnUsy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+2Rg8nW7AiYQmcEW8kkUHlsy5h1V5tVMD6TreAoZ++Bia7Y2z8fhN+3/6tcMghAvC+O8uPnWaq0pN+eOSgPqDlubBv4GwOmCRC7PxNG522YfYjYweEVow8TDOEphSEY38CwJc8r05yCQH2xPUMFbVSB/5/dHKm90Xw3B8hx3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OrIY/QGA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IUAI026249
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 08:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ynWl2+LN0okkZhiNEn8Jl42YKjFcoHHouZf21AAoHq0=; b=OrIY/QGAjyiGsCvf
	Dmxj++57E6yEaDivTVuW7agmMUOYVnC/DM5C3oLOgZuxx0OCoj8r3Lf58/yLCjNx
	x2zKTAvM6/VIyfu4Ob/p2P+uMLolymGRxGIjExVMyPEy0Wz8bz1SH1/CEMDJKN17
	AJFUJ39O3bXtCI0zB99HZs2ouvKC/RrC1QH/CN0frAAic/bLsJGwXY96olQSdPdD
	aLJgznelxD2iQAATm+WkFealh2YMeYNtuscpRVSqXQcUhIn+ONuHSDzRP5FwU+xv
	0Sx0y+JpQh/Vq3qzD6Wer6WeilyLnVDkDGpEM1EDHM2arVchyWdLKp4UOurR27dI
	nAYTaQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493f6h1y0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 08:53:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b604c02383so2510101cf.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757580811; x=1758185611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynWl2+LN0okkZhiNEn8Jl42YKjFcoHHouZf21AAoHq0=;
        b=ZSaqmNuG3PwF+1xfDwwpK1TYIgDxoV4nTXyX2t0Dqm6+WSX63cFEQ4xVI1zP9nrhtF
         9L7oVnF6ZXSAOR/ZxnONVAcjAFYFJWKzSwHcK05DiTQEwi75cK+yiDGe4mgdT7elO6Mh
         Y/3KHnufAnJFkmqAPDSCxM1jafAfjPc5YDjUu4Oh1U+RFT0FEkOsXT8kHznwuIzyeMj4
         EgQ6qFMKniyUVq+5HVq4zvh5QYA5i3oHrBvJgKI0AglTw5tm+aQ16KlY0AoOsMXtzK1J
         gptsyuwmpsiQKebhp6dDRxbSTcykU1jUVGDVvW7hHJl+t8tD+9YcqwJZvSL05oBJa0dn
         DUGg==
X-Forwarded-Encrypted: i=1; AJvYcCURLUJIvcKc/iWKc33ScLESLcLHmGWRKPKSuubKcj9Ov3OgDbK5LxwMWyg2ZrBgtb5FEqGyA4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1u9hV4dh7ltByPtIgZ8om2mbFRgBLxlTH4EPjOZV9ZUTj1JlQ
	Ti2zSokH39pNDMwbdCRmwLE/w1aEmj7MYEAQ6yK8L28LvmWiGXZkUhNO18jv7arwjDRxtc0X/ZF
	npoADmJrvHzhAdRTPgB6TU+gichOADD0j1ptSgQJi2tOxuzRXnczV4THOCyY=
X-Gm-Gg: ASbGncsOBd1t9/oB5GIjD2+b1wa7PGpkRqOVW5qhX2a8zZIJgayVv+1oA2xqD9useUv
	Yo29Mx2OaEGFea/PV1Lpn1fOveSAZXo0ufxIhSOrHRg/SkGtBadlib1G9u7uA0wWimAcL+cGX+X
	8PKEzBUmwa++8yRQJHbVDSgVCKdcaL6bvgociwXhgKsH0JwwV1E3Lkwtz8Yum07lPJWioXcZACv
	0Gx4ywkhEvOfn49rl+7bUmodZ1IXL6j7i084vkA5UultpClo5hHdGZ2nn1+OLNS6MBG0z1Zw7DQ
	Wvq16pJ6QPRGRhjcZ1ieadpCNQ/0LH/dGMA7yQ/W0LeiE3VHowI6LWf0NzTo52QJAHA+vQlV5AX
	x6/tZXRqr9lx/XQX0ZNpqsg==
X-Received: by 2002:ac8:5e09:0:b0:4b5:f68b:86a0 with SMTP id d75a77b69052e-4b5f83aa98fmr140394471cf.5.1757580811161;
        Thu, 11 Sep 2025 01:53:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwrCXlNX3e4J1CCi9Qj59YkjWyURxTP0akIJvONe/E360yXgamsqbmCNGDwjWVWtWm2ONHng==
X-Received: by 2002:ac8:5e09:0:b0:4b5:f68b:86a0 with SMTP id d75a77b69052e-4b5f83aa98fmr140394291cf.5.1757580810734;
        Thu, 11 Sep 2025 01:53:30 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f20ffsm86223766b.79.2025.09.11.01.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 01:53:30 -0700 (PDT)
Message-ID: <b83a59f9-16ae-4835-b185-d5209d70a0f6@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 10:53:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: net: qcom: document the ethqos device
 for SCMI-based systems
To: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMRc=McKF1O4KmB=LVX=gTvAmKjBC3oAM3BhTkk77U_MXuMJAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0ml25m9pUiYKsbnmPGshNmoBnTiNiv-x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDE3NyBTYWx0ZWRfX/TgX9eFE9/4M
 0i364eeEfwjx+3lw6wMHCT3pmV7hABgUclFrUC9063+HSCtC16/nd95y4ol59ELKL8g5cxQp842
 Lja8YNPy5QW7liZghXW8i/J7XBUM3DSnmnMjRQLNjVsZbBORfKYE64FFLFmkZemCDUlrk0X/sAo
 dQfCI6y72JEs0CvN/oXz/DkF/ivfKKwSwk2jADe0Wqb6pw3YP8TLCx9zAoDEPpb/Fi8qx7Nc/Th
 PpRfZKNC4kbjb88otF84cT2sEW5Y8ydhRC6BUDZw3blTblVSj9AzyW6tIl3nKSsmkx0F0pLdqIA
 3WCsFjF6naPUt9c7gK+2Ebu6CVzwUNJeuGOrk5Rl5EQ5MMd0gvvBHxRgOi7jnFR65WyKP77qlb1
 Jv5o1MwJ
X-Authority-Analysis: v=2.4 cv=WPB/XmsR c=1 sm=1 tr=0 ts=68c28e0c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=E8Hth7WlfHmEou41Ml8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0ml25m9pUiYKsbnmPGshNmoBnTiNiv-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100177

On 9/10/25 4:42 PM, Bartosz Golaszewski wrote:
> On Wed, Sep 10, 2025 at 4:36 PM Rob Herring <robh@kernel.org> wrote:
>>
>> On Wed, Sep 10, 2025 at 03:43:38PM +0200, Bartosz Golaszewski wrote:
>>> On Wed, Sep 10, 2025 at 3:38 PM Rob Herring (Arm) <robh@kernel.org> wrote:
>>>>
>>>>
>>>> On Wed, 10 Sep 2025 10:07:39 +0200, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>
>>>>> Describe the firmware-managed variant of the QCom DesignWare MAC. As the
>>>>> properties here differ a lot from the HLOS-managed variant, lets put it
>>>>> in a separate file.
>>>>>
>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>> ---

[...]

>>> These seem to be a false-positives triggered by modifying the
>>> high-level snps.dwmac.yaml file?
>>
>> No. You just made 3 power-domains required for everyone.
>>
> 
> With a maxItems: 3?

In the common definition:

minItems: n
maxItems: 3

In your new file that includes the main one:

properties:
	power-domains:
		minItems: 3

Konrad

