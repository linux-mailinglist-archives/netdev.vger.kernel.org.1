Return-Path: <netdev+bounces-138388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA39AD455
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 20:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966351F226E9
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F7A1D12EC;
	Wed, 23 Oct 2024 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A2wP0WMx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827F883CDA;
	Wed, 23 Oct 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709910; cv=none; b=sGEIDWf8WNqE9ye+h9vblML27dHu34xBw07bc3e+KrJMPGWBWjQVxDBNeYFl+MnG+/bFsfexaHSJ43lDz0yXGhdz1PgtIRWT/tgxDm5mhxjF90WY20zZvtLHfqBrJkv+z3Fl86z50Ns9fiyhG71fYgC8q9O35gRZRx48iHGtNfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709910; c=relaxed/simple;
	bh=rcYqs8WxAXoMxce9UI7AdY0n5dCYUtnjFG7JTfh1AJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s66cX9Z1UTAA9Po0Y0Xfxunp6yqw/vejwEcRRaklR9Bm0OIfuUWMyy1L93lxegBrj8jRj9W8Viz/0N67hUvFp5zjOp7wP74++dYE4ZSct4nvYD7bDMizI9AXLr8SgvwaUj+aBVdgGPjXAwE/9JpQPAb2aZzN/gADWKQRymqaeBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A2wP0WMx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NDI0xP025218;
	Wed, 23 Oct 2024 18:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r/Qqxj
	blBJWojKe0KlwoCvmdu8op31yPwNG0aKoFEKM=; b=A2wP0WMxKhHp0Qkmd0CXrt
	VrdCBQ8cUfDBneCXbm7mC5C5j5DtFqp0KyIYyrjAlS+04ZrE/mHscCNlWUwYlml6
	x7y+da3H8HNDTvRhS8XMswxejY5iNHFCVLKNtvUjycW9iVOnfLFv7+GBxYxK4Zc3
	KLpp9q8lA5IJ0NdxK6ql6uKt9JtbZPHfh0EpMgg0kjCHsLKncY7Vrw++hjqoCrOp
	U4wUvi1b30XXWqQL1blLbYhoN99Or7NomEfgOydrH0lNcwbhYuivpf3iVsZfuKEo
	QgOU/WgGuS78UzRcgbYLwpYJ2rFiLT49AG1SHNe/93ny1n/bdbNmBHzjjyH1D+/w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaevm0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 18:58:05 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49NIw40G002651;
	Wed, 23 Oct 2024 18:58:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaevm0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 18:58:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NIjrp0014303;
	Wed, 23 Oct 2024 18:58:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emhfmdk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 18:58:04 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NIw25739846204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 18:58:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACF3458053;
	Wed, 23 Oct 2024 18:58:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D75958043;
	Wed, 23 Oct 2024 18:58:01 +0000 (GMT)
Received: from [9.24.4.192] (unknown [9.24.4.192])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 18:58:01 +0000 (GMT)
Message-ID: <bbeede5b-3568-4ae6-a844-88ff1e06359d@linux.ibm.com>
Date: Wed, 23 Oct 2024 13:58:00 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ibmvnic: use ethtool string helpers
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Haren Myneni <haren@linux.ibm.com>,
        Rick Lindsley <ricklind@linux.ibm.com>,
        Thomas Falcon <tlfalcon@linux.ibm.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20241022203240.391648-1-rosenp@gmail.com>
Content-Language: en-US
From: Nick Child <nnac123@linux.ibm.com>
In-Reply-To: <20241022203240.391648-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TnOPjsNF8DYuwR0ea2GOoCIlEgMtLL2p
X-Proofpoint-ORIG-GUID: 8lJsUry5mbrxGGcbZMFRg1Ou9DSyY6bJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=668
 priorityscore=1501 suspectscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230120



On 10/22/24 15:32, Rosen Penev wrote:
> They are the prefered way to copy ethtool strings.
> 
> Avoids manually incrementing the data pointer.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/ethernet/ibm/ibmvnic.c | 30 +++++++++---------------------
>   1 file changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index cca2ed6ad289..e95ae0d39948 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -3808,32 +3808,20 @@ static void ibmvnic_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>   	if (stringset != ETH_SS_STATS)
>   		return;
>   
> -	for (i = 0; i < ARRAY_SIZE(ibmvnic_stats); i++, data += ETH_GSTRING_LEN)
> -		memcpy(data, ibmvnic_stats[i].name, ETH_GSTRING_LEN);
> +	for (i = 0; i < ARRAY_SIZE(ibmvnic_stats); i++)
> +		ethtool_puts(&data, ibmvnic_stats[i].name);
>   
>   	for (i = 0; i < adapter->req_tx_queues; i++) {
> -		snprintf(data, ETH_GSTRING_LEN, "tx%d_batched_packets", i);
> -		data += ETH_GSTRING_LEN;
> -
> -		snprintf(data, ETH_GSTRING_LEN, "tx%d_direct_packets", i);
> -		data += ETH_GSTRING_LEN;
> -
> -		snprintf(data, ETH_GSTRING_LEN, "tx%d_bytes", i);
> -		data += ETH_GSTRING_LEN;
> -
> -		snprintf(data, ETH_GSTRING_LEN, "tx%d_dropped_packets", i);
> -		data += ETH_GSTRING_LEN;
> +		ethtool_sprintf(&data, "tx%d_batched_packets", i);
> +		ethtool_sprintf(&data, "tx%d_direct_packets", i);
> +		ethtool_sprintf(&data, "tx%d_bytes", i);
> +		ethtool_sprintf(&data, "tx%d_dropped_packets", i);
>   	}
>   
>   	for (i = 0; i < adapter->req_rx_queues; i++) {
> -		snprintf(data, ETH_GSTRING_LEN, "rx%d_packets", i);
> -		data += ETH_GSTRING_LEN;
> -
> -		snprintf(data, ETH_GSTRING_LEN, "rx%d_bytes", i);
> -		data += ETH_GSTRING_LEN;
> -
> -		snprintf(data, ETH_GSTRING_LEN, "rx%d_interrupts", i);
> -		data += ETH_GSTRING_LEN;
> +		ethtool_sprintf(&data, "rx%d_packets", i);
> +		ethtool_sprintf(&data, "rx%d_bytes", i);
> +		ethtool_sprintf(&data, "rx%d_interrupts", i);
>   	}
>   }
>   

Tested-by: Nick Child <nnac123@linux.ibm.com>

