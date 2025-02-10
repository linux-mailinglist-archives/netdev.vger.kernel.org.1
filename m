Return-Path: <netdev+bounces-164857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E82A2F644
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75744164969
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4942324418C;
	Mon, 10 Feb 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FLJQE7ms"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCDC1F4623
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210473; cv=none; b=dvfT4xOdI9VEdnIqHczRQ6ccRSmqwG1wkEqI+ox2JVF97cFi27umTiHtVerZF22TRVrBHRvz9lFycWcrzNEnWHEa6U5Qsi0YOHDFfoVsTWBSCq1SdrGar0SfT4rsFo/x+85SobcizLA21WzsU5wv6P2GHet99ODnVbgzvl62eL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210473; c=relaxed/simple;
	bh=bXKPEZV4wENG737JGPA+HkpmUFoh6MHiuktEhTC6J9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsUjc23tvSMNFpxSjMDcJPQ0YY++GuLmHoDJMK0GMw7ZZeMqAMplErgGEVzB+QLJdq2jt6ruIqcOZHhSmNc0sXAj++Tn9zLUCk5KQVKs4ngC6b+PjRfq3Sz4rkosjSq+iEqI0FzUioKTNpY3Zgj5ZNdRmgWS3iDe+cUrLDUyAh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FLJQE7ms; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A9Vtsi008337
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 18:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nRIgquMblxmiFtLWE8uSlg81ZeJdWHIECgta1ooGHZE=; b=FLJQE7msxiBv8Q2e
	4t0V7pAIGLQlOUGGIjezyRn6OOlV+w4kLff7G3L8ZGX8rXTcXLdtL1TR//N1n2R0
	RpdnZD6WhU+UkqjL+zw6qbvllZ0vZnsZ/VD9AwWjShj0quKK6MncNf8tqECZ4Gjl
	ebG6NURd4oveqz0xbJlPiFv+K23YlJRRDZgS4EzEXIbV8zCpjkW7A4RKFoV4+yay
	j8vN8dT3ZVzDPDDmygbIzb8nU0A7laM7V6IcGdbURUfM0BUZq7ja9v6Kpjv+jXkt
	9DDR+Vv9zxfPUEW4WY5J2ObSXNISHdofzxfR6oJZ+bcmj4RYb+VtsZGzKu/gibVJ
	R3ic4w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qewh1cuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 18:01:10 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e44a0bfc3eso2878686d6.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:01:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739210469; x=1739815269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRIgquMblxmiFtLWE8uSlg81ZeJdWHIECgta1ooGHZE=;
        b=mzP5cqfjZogHn5DzW3g6cavX4EUCJCug1pht9/dix/wW/Z7uZpBffGxuNtv2NmFOXt
         NEuvKPKhYqEatJmVYRfyKvvN6m3ohmzPEdZhqSXLKsaZQKVxWl9spcqJ9tXLrgD1rkpS
         69PyilgSv6wRaeIlp2qtUg7ILVSQhIiPhrMS5whd3jcYqg/UVvIKu8rs0MWgtpw5lvKH
         ofSF4x0wrxGk1DEGCIPqTgzJIixIQT9qRqBB+ZG4YWK9SZz25pCdm2SCaGFMTCwoDKi+
         3ZQBH6BYrvf1KFKp4zpdkXXI2zj93fZRtoKv0Bm2fZGa1UcwZkg4kutqnO/YxOGELfU4
         QGjQ==
X-Gm-Message-State: AOJu0YxMlwj1yk5TZTtbX29XEYW7P7ug53jR0+ZpV2B80Dbx5nZQzAm7
	V5LNTsVnIolboP2eXipbkUMY6f/WfHb1nNWJr850QeCAmgE+lbvQeIhDv7oRB4lHwk95Pi3Fv2f
	k92pRupAKdFlIMJmf3HJxFrzWdSbXBTe8jFNGM4pST1zYsuyCehI2GF0=
X-Gm-Gg: ASbGncsdhH6Z3uY0jmF2GP/Hv8t4yz+q3DTO7BltclE6o+T61LKNX3J8WgpaGDapqG/
	vxl7bGlAGouRaDkml4+gp5XP54LjgvIqp46HpHHt8FPKo3Ow2l/4qtgwlEt7OGFFHiBeoY/MVOF
	N9vV8ue5Ipl6AhcvuSCLXWS5hEiVlTcIKGm3AufrmHNjOECT4PaQFMa/Q8HulSonbN4nXIRyJUD
	USqzCyz+616BpPpLAz5DjuSe6BiofDTvuliaPBAKiYO3PlfCKSyCZYU5RXpaarc7jrobfxGervV
	PW5bDeRAZ6W6W2TYKy2liStpviUenIJtAxIWji1HZ1jJutoo+vskDBewpPo=
X-Received: by 2002:ac8:57d1:0:b0:462:b46b:8bf8 with SMTP id d75a77b69052e-47167b066cbmr77016731cf.14.1739210469196;
        Mon, 10 Feb 2025 10:01:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjNHMrPdlFQI52pflImfeJmycM/6sYmtEApuonTlMDTKaYLqKa6DC/5hsEpJ2wVSAK4BNHWA==
X-Received: by 2002:ac8:57d1:0:b0:462:b46b:8bf8 with SMTP id d75a77b69052e-47167b066cbmr77016271cf.14.1739210468350;
        Mon, 10 Feb 2025 10:01:08 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b77d58bdsm351070566b.130.2025.02.10.10.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 10:01:07 -0800 (PST)
Message-ID: <60fecdb9-d039-4f76-a368-084664477160@oss.qualcomm.com>
Date: Mon, 10 Feb 2025 19:01:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] net: stmmac: dwmac-qcom-ethqos: Mask PHY mode if
 configured with rgmii-id
To: Yijie Yang <quic_yijiyang@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20250121-dts_qcs615-v3-0-fa4496950d8a@quicinc.com>
 <20250121-dts_qcs615-v3-2-fa4496950d8a@quicinc.com>
 <30450f09-83d4-4ff0-96b2-9f251f0c0896@kernel.org>
 <48ce7924-bbb7-4a0f-9f56-681c8b2a21bd@quicinc.com>
 <2bd19e9e-775d-41b0-99d4-accb9ae8262d@kernel.org>
 <71da0edf-9b2a-464e-8979-8e09f7828120@oss.qualcomm.com>
 <46423f11-9642-4239-af5d-3eb3b548b98c@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <46423f11-9642-4239-af5d-3eb3b548b98c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rVkJaAowl2rkwGTUTSr0YXgdBFK-6-Gz
X-Proofpoint-GUID: rVkJaAowl2rkwGTUTSr0YXgdBFK-6-Gz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_09,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100147

On 10.02.2025 4:09 AM, Yijie Yang wrote:
> 
> 
> On 2025-01-27 18:49, Konrad Dybcio wrote:
>> On 22.01.2025 10:48 AM, Krzysztof Kozlowski wrote:
>>> On 22/01/2025 09:56, Yijie Yang wrote:
>>>>
>>>>
>>>> On 2025-01-21 20:47, Krzysztof Kozlowski wrote:
>>>>> On 21/01/2025 08:54, Yijie Yang wrote:
>>>>>> The Qualcomm board always chooses the MAC to provide the delay instead of
>>>>>> the PHY, which is completely opposite to the suggestion of the Linux
>>>>>> kernel.
>>>>>
>>>>>
>>>>> How does the Linux kernel suggest it?
>>>>>
>>>>>> The usage of phy-mode in legacy DTS was also incorrect. Change the
>>>>>> phy_mode passed from the DTS to the driver from PHY_INTERFACE_MODE_RGMII_ID
>>>>>> to PHY_INTERFACE_MODE_RGMII to ensure correct operation and adherence to
>>>>>> the definition.
>>>>>> To address the ABI compatibility issue between the kernel and DTS caused by
>>>>>> this change, handle the compatible string 'qcom,qcs404-evb-4000' in the
>>>>>> code, as it is the only legacy board that mistakenly uses the 'rgmii'
>>>>>> phy-mode.
>>>>>>
>>>>>> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
>>>>>> ---
>>>>>>    .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 18 +++++++++++++-----
>>>>>>    1 file changed, 13 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>>>>>> index 2a5b38723635b5ef9233ca4709e99dd5ddf06b77..e228a62723e221d58d8c4f104109e0dcf682d06d 100644
>>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>>>>>> @@ -401,14 +401,11 @@ static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
>>>>>>    static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos)
>>>>>>    {
>>>>>>        struct device *dev = &ethqos->pdev->dev;
>>>>>> -    int phase_shift;
>>>>>> +    int phase_shift = 0;
>>>>>>        int loopback;
>>>>>>           /* Determine if the PHY adds a 2 ns TX delay or the MAC handles it */
>>>>>> -    if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_ID ||
>>>>>> -        ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID)
>>>>>> -        phase_shift = 0;
>>>>>> -    else
>>>>>> +    if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_ID)
>>>>>>            phase_shift = RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN;
>>>>>>           /* Disable loopback mode */
>>>>>> @@ -810,6 +807,17 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>>>>>>        ret = of_get_phy_mode(np, &ethqos->phy_mode);
>>>>>>        if (ret)
>>>>>>            return dev_err_probe(dev, ret, "Failed to get phy mode\n");
>>>>>> +
>>>>>> +    root = of_find_node_by_path("/");
>>>>>> +    if (root && of_device_is_compatible(root, "qcom,qcs404-evb-4000"))
>>>>>
>>>>>
>>>>> First, just check if machine is compatible, don't open code it.
>>>>>
>>>>> Second, drivers should really, really not rely on the machine. I don't
>>>>> think how this resolves ABI break for other users at all.
>>>>
>>>> As detailed in the commit description, some boards mistakenly use the
>>>> 'rgmii' phy-mode, and the MAC driver has also incorrectly parsed and
>>>
>>> That's a kind of an ABI now, assuming it worked fine.
>>
>> I'm inclined to think it's better to drop compatibility given we're talking
>> about rather obscure boards here.
>>
>> $ rg 'mode.*=.*"rgmii"' arch/arm64/boot/dts/qcom -l
>>
>> arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>> arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
>>
>> QCS404 seems to have zero interest from anyone (and has been considered
>> for removal upstream..).
>>
>> The ADP doesn't see much traction either, last time around someone found
>> a boot breaking issue months after it was committed.
> 
> But what about the out-of-tree boards that Andrew mentioned? We need to ensure we don't break them, right?

No. What's not on the list, doesn't exist

Konrad

