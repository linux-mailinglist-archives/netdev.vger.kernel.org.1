Return-Path: <netdev+bounces-144084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3BF9C5846
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7111F211CD
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA21150990;
	Tue, 12 Nov 2024 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bymiCwOO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B73D145FE5;
	Tue, 12 Nov 2024 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415748; cv=none; b=AmVyl0aNycRgM35c4p9JSmS8PGAkhfgiCuhFns9p0jCzoaP/w2PrbCX8PFLUTP8n4sVfWsmj2p8JpAGMXcGIPoI+gvXNmjKn0J/Iq0G0rs7RLxbKnK/dm+LWi8p1RwvPpMiAkYXV+it6U7QNUfuemIaXsncMnGTDFvMIUyKBZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415748; c=relaxed/simple;
	bh=gihI+UyP0xz/4nL4XaP9AyrL3fvtn5BQxcVZq3dAg8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Zi4ly+7jqdT3XZoy1L8cnbqkoAXaLKYHCGkMN2JNDtYHaWtIDTeNrHRuSy82Fvi7zRZ6rVSxHELZiubvJeZRxbWKZRw6UcNL2h2w7ybdu297Aj6l8bgZY9NRTMZVREdS1NQrodjoh27k3kZSaeBzzlE0p/MQISDulEuPpTMbAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bymiCwOO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACCOXQ5028090;
	Tue, 12 Nov 2024 12:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xbhmlm0PmIzqTXAdFDt5A5FVPcXGjy8qgW/6BhEzPtw=; b=bymiCwOO03MvFoCg
	VsT+pi+9ftb0tapZGjWw/LqSw4ljJ4YqCfqW6IXPaTWjvrCpgxHQ606y8XS0B5Le
	Kk6xYQwiszVMy3pleTRgfEaLv426ucnwn+UC82CVEK2nL0g+nIY6NUUBZhqjZyiO
	UrcPOj8yqsoXJ90imTXrnGkukIHRrrGcDSE0xNusnnNapyltAt17APFzT2GVyzRN
	Kwe+0ixWEJ866HA/ZOHe+6eWa0ApwP5tvXNqhPz7AjBsMUUrKUVY9Qz62vSUDwJh
	tIZOGRugGjovigbGm8c5cPwLHJdhy0AlHgdQmXM22Wyz6ykmO4/BOAKSSeeuAbGG
	+xsfjg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sytsq9rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 12:48:51 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ACCmosj020679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 12:48:50 GMT
Received: from [10.253.79.133] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 12 Nov
 2024 04:48:45 -0800
Message-ID: <8f319458-96fd-42dd-9580-cee3f2b00341@quicinc.com>
Date: Tue, 12 Nov 2024 20:48:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] net: pcs: qcom-ipq: Add PCS create and
 phylink operations for IPQ9574
To: Andrew Lunn <andrew@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_luoj@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <bartosz.golaszewski@linaro.org>, <vsmuthu@qti.qualcomm.com>,
        <john@phrozen.org>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
 <20241101-ipq_pcs_rc1-v1-3-fdef575620cf@quicinc.com>
 <d7782a5e-2f67-4f62-a594-0f52144a368f@lunn.ch>
 <9b3a4f00-59f2-48d1-8916-c7d7d65df063@quicinc.com>
 <a0826aa8-703c-448d-8849-47808f847774@lunn.ch>
 <9b7def00-e900-4c5e-ba95-671bd1ef9240@quicinc.com>
 <17ae9ace-55a6-4e09-ba1a-889b5381fb0f@lunn.ch>
Content-Language: en-US
From: Lei Wei <quic_leiwei@quicinc.com>
In-Reply-To: <17ae9ace-55a6-4e09-ba1a-889b5381fb0f@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xIt24bxKN3Hx8vltGBTSt7S9QC8N-b-L
X-Proofpoint-ORIG-GUID: xIt24bxKN3Hx8vltGBTSt7S9QC8N-b-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxlogscore=776 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120103



On 11/8/2024 9:24 PM, Andrew Lunn wrote:
>>> Another artefact of not have a child-parent relationship. I wounder if
>>> it makes sense to change the architecture. Have the PCS driver
>>> instantiate the PCS devices as its children. They then have a device
>>> structure for calls like clk_bulk_get(), and a more normal
>>> consumer/provider setup.
>>>
>>
>> I think you may be suggesting to drop the child node usage in the DTS, so
>> that we can attach all the MII clocks to the single PCS node, to facilitate
>> usage of bulk get() API to retrieve the MII clocks for that PCS.
> 
> I would keep the child nodes. They describe the cookie-cutter nature
> of the hardware. The problem is with the clk_bulk API, not allowing
> you to pass a device_node. of_clk_bulk_get() appears to do what you
> want, but it is not exported. What we do have is:
> 
> /**
>   * devm_get_clk_from_child - lookup and obtain a managed reference to a
>   *                           clock producer from child node.
>   * @dev: device for clock "consumer"
>   * @np: pointer to clock consumer node
>   * @con_id: clock consumer ID
>   *
>   * This function parses the clocks, and uses them to look up the
>   * struct clk from the registered list of clock providers by using
>   * @np and @con_id
>   *
>   * The clock will automatically be freed when the device is unbound
>   * from the bus.
>   */
> struct clk *devm_get_clk_from_child(struct device *dev,
>                                      struct device_node *np, const char *con_id);
> 
> So maybe a devm_get_clk_bulk_from_child() would be accepted?
> 
> However, it might not be worth the effort. Using the bulk API was just
> a suggestion to make the code simpler, not a strong requirement.
> 

OK, I agree.

For the PCS instantiation for child nodes, I would like to summarize the 
two options we have, and mention our chosen approach. 1.) Instantiate 
the PCS during the create API call, and export create/destroy API to the 
network driver similar to existing drivers (OR) 2.) Instantiate the 
child nodes during PCS probe and let the MAC driver access the 
'phylink_pcs' object using a ipq_pcs_get()/ipq_pcs_put() API instead of 
ipq_pcs_create()/ipq_pcs_destroy().

The other PCS drivers are following the create/destroy usage pattern 
(option 1). However we are leaning towards option 2, since it is a 
simpler design. Hope this approach is ok.

> 	Andrew


