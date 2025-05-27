Return-Path: <netdev+bounces-193609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E60BEAC4C8E
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 12:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBBC189ED76
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0682586C7;
	Tue, 27 May 2025 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RTRsl6f+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF7256C84
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748343568; cv=none; b=mvSsPMML0DL5iYdfjbVY2yRdDXQ7ITBTWu5V/DOeBrD0/UWUI3fNgY0uyMVzhOimiRnngw+4WaX8M9An0+FsWQvUH4VIpR98zKH7xAZBLBm3wbjujfigBxiu+dMkEIJcSmbB/qzTYm9JkyRVXzuijEz0aQO2hFwTDIDYXhyAiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748343568; c=relaxed/simple;
	bh=nAhhNH6vu5VSXZoeXbMVn7GYF7eDAXmR/I2kCc4UShE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poyEAInqXWEsyAfeEdwSLx/nJKXxMkGG7iCLO8ffrG61k9S7QvYWbfOt020UFXtiQB+CeqNnJurv6LMVCqKTtwZQ/xC4Lq8WgVFzDre8LXTFqzISnGG3q0L0vfFg11HGtiDlw8U0ZG9CqGojDWIq+0zS0SLaEnFE2gVF/pcvfN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RTRsl6f+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R9YLpD001765
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 10:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dVRH8mgws61DCnh4JmBYd/UFPtwOI3PX+7lhuMe5vMw=; b=RTRsl6f+rxZwqFg2
	crtUAHbU2YP3TKS1eFoMYKeeqPfoel5yumU3H/6lRRMbAFGPBH8jZDB6BK3bTnGL
	6gjWDHUip6UHUgS761v5RtuACJLjmJxtMm5czUfz04/bY0uPyWcbPYsjc6Hd/11s
	AJ/7DgWU2Z6JevyKjGl8oTiFUFrzmAZHF78UBh9BDA+CdaEyVOvQNQxXIIIjFkhw
	4fR8heZWPboq5piWRgmLUv3Ps54u0yXI5Y1QuEpsk/2Xyc7cPmM/NcZZM3nI/fOJ
	4R/SPrRkyicqsAuCVSIFCKCxMxoGZLew2ebZ1pIYyLUr2ClEMsa93HUI0hsu2iuj
	YsPcTw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46wavkr7x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 10:59:25 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fa9cc8eb70so1279146d6.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 03:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748343564; x=1748948364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVRH8mgws61DCnh4JmBYd/UFPtwOI3PX+7lhuMe5vMw=;
        b=RgPWWG2oMv+OFkejyTL+QOpwPnE3xZ73vISw4PcdGe8LoXwm+NtffzYnEr9nbvm1E0
         uU5MU6QzDgIwD/EO96wdglfOXBSsaMJzFbVtLcUO+RWD1xx+YRM7wlJLBWh1/kIyCDgO
         fz0aRauaKTsRQjlI36GWquTWMOXkB3y2gUlj27KjnRYKRtgfdmVC6Vhxi2kHtDgqHWkH
         7hF6JHHDvTkGcs34fkQhii4ApdfkNE4u0K1sFDCsgJnxQvW4oxwEA0oC71tz58iwhP5t
         B6dDJDrmhslFlFIMv3VkB3whLn88bT2Y5qk9BT9vz6TEq8SpbxdkzuK8pyN4DF50GUDN
         z59Q==
X-Gm-Message-State: AOJu0YwceKzMaw4jqwlYG2/bxmZUtp9Wle2jNd3KfHedN/lprudltbj/
	a0DgvqY32nsTr4D0d7jEcBXgfS4TxJDxXeCnVujdnF4WIbPJM2ntZuauCMRNwXKsn2MhfAfQenb
	N8wyHUKeEUlunJyQ3R6M3TFv+ZkmnWq95vp6wI0wIiZrB9WFQgvBpiro8Gps=
X-Gm-Gg: ASbGncuutm5A3SSszdltEec69y+RaeyCS8GmO4nzLbz4n9on0VmNT1XAV/HYb/3ZAd6
	diTzg85mmGS2a1Po/DGbJYyr1uiCAj5+qGchoLZgUPflwIes1cW3uUL8ejCmgcqr+nGGH3nwOl4
	H1XOQAV/EKTx1U6inAv9nTnBI33sVl4UYCYOsKETozJ8zOCzL54xxE8ZCKcXzpw8iFTA8atyTd4
	RXPoEcKfHvphI6YljDTGJGQzR+lBA2De0JAGw43ANOG/uhTSgGpLHEKmE5yX/GiK4ztw/QnNviu
	4qg+pcOJ5JuBNK53GxfCoUf3299iMN3e+evvuVyWTEa2M5/6FtkjmsZdOuIMogoZaQ==
X-Received: by 2002:a05:622a:148a:b0:494:b829:665 with SMTP id d75a77b69052e-49f4703eb42mr68702301cf.9.1748343564562;
        Tue, 27 May 2025 03:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbqhUM+kngM9h8FOZPZbOSvqul+W4jdRKAgtAArw3nUiRXyCMh/+aUX7lcOuXcL6YHsU61/A==
X-Received: by 2002:a05:622a:148a:b0:494:b829:665 with SMTP id d75a77b69052e-49f4703eb42mr68702021cf.9.1748343564099;
        Tue, 27 May 2025 03:59:24 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d44205asm1845574266b.100.2025.05.27.03.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 03:59:23 -0700 (PDT)
Message-ID: <df414979-bdd2-41dc-b78b-b76395d5aa35@oss.qualcomm.com>
Date: Tue, 27 May 2025 12:59:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: net: qca,ar803x: Add IPQ5018 Internal GE
 PHY support
To: Krzysztof Kozlowski <krzk@kernel.org>,
        George Moussalem <george.moussalem@outlook.com>,
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
        Stephen Boyd <sboyd@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20250525-ipq5018-ge-phy-v1-0-ddab8854e253@outlook.com>
 <20250525-ipq5018-ge-phy-v1-1-ddab8854e253@outlook.com>
 <aa3b2d08-f2aa-4349-9d22-905bbe12f673@kernel.org>
 <DS7PR19MB888328937A1954DF856C150B9D65A@DS7PR19MB8883.namprd19.prod.outlook.com>
 <9e00f85e-c000-40c8-b1b3-4ac085e5b9d1@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <9e00f85e-c000-40c8-b1b3-4ac085e5b9d1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -jt8GSQihj7EIP891E9Zhq1YiH3hxsWn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5MCBTYWx0ZWRfXymqg6io0X3/w
 Zz6sgYz6LnJTd08SiIkEH0LTDinvnxbijraDCEuUypCRVrdnqVjX3IMow3d+hOSqzvxVQe4XswH
 Rt15rJKCO+GGEHgWLKja02bBMuqxfk9PBe1kcT6eUNylovC5ZlIr/UnJ7mQ6TPPJ6SvptonvIVy
 K9RIi1lRmPhVTvVfNFpi+HG18tl2Lf5AX7m0u+xIMno4T6mbEnp6JinDevDX1HeynatQOmq8jPN
 FwKq/OrijMwthfoFNcNAHo2889CuUbAW4l/VsnyeDXjLd9sGXm/0JF2+Paz1zQCXfM3zRAj5CdR
 mtLt3tDxI3xHoXlvJIoxxj5LVvkFI8cF5xFHjyPxqjpSbV/0A/Ymmk5IvWzBhe5s9SZtaE66jyZ
 r5RjIF6QRlnqXcYstNHBa02H6vSrPPaHugtY2kN3UdE0bFidQ8k1RVN0wZJY5r8dw7y1Igdr
X-Authority-Analysis: v=2.4 cv=fMk53Yae c=1 sm=1 tr=0 ts=68359b0d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=_VzbdjocUJMGqeFO5uwA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: -jt8GSQihj7EIP891E9Zhq1YiH3hxsWn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=985 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270090

On 5/26/25 2:55 PM, Krzysztof Kozlowski wrote:
> On 26/05/2025 08:43, George Moussalem wrote:
>>>> +  qca,dac:
>>>> +    description:
>>>> +      Values for MDAC and EDAC to adjust amplitude, bias current settings,
>>>> +      and error detection and correction algorithm. Only set in a PHY to PHY
>>>> +      link architecture to accommodate for short cable length.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +    items:
>>>> +      - items:
>>>> +          - description: value for MDAC. Expected 0x10, if set
>>>> +          - description: value for EDAC. Expected 0x10, if set
>>>
>>> If this is fixed to 0x10, then this is fully deducible from compatible.
>>> Drop entire property.
>>
>> as mentioned to Andrew, I can move the required values to the driver 
>> itself, but a property would still be required to indicate that this PHY 
>> is connected to an external PHY (ex. qca8337 switch). In that case, the 
>> values need to be set. Otherwise, not..
>>
>> Would qcom,phy-to-phy-dac (boolean) do?
> 
> Seems fine to me.

Can the driver instead check for a phy reference?

Konrad

