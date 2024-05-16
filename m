Return-Path: <netdev+bounces-96680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410F68C71E0
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 09:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D263B20EEF
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 07:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20B825765;
	Thu, 16 May 2024 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MOkONVXm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942410A26
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715843800; cv=none; b=jGBcuIBdYcZCCg6Jd2vKCAnUCfyKuUuGdgYtIf/npcqGDNaF9ca48RqAP3cNJD6MP/tH1cERH4X7zISaTx+xQ1UxAnHsb73yYoDmfXNhQorTQHcibUqcbKYRe/ZV/7wCKUbKqmG0DOQk510FszLgli72HPP+KcCiSHznyTqxKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715843800; c=relaxed/simple;
	bh=MbheoSNBz8GTcK8zgg1rp3CDQ6E/XZ4PVqndWeYq4zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b3FtFwmOfHJSVFek3pGtDYeFPpeQWGWdtL4wySZkrCNYEukpZtFZM97C76eqg4XLNdC6UNBZnwecH5rDS5H4Gv28foRLeGCVciNaThkLMCwAJTGQNKdOyM/qUb1PwaMOz7vWVxt6haA8+SQqdQQyXTAo3JXffWNO060OsOe1AhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MOkONVXm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FHpi3B002468;
	Thu, 16 May 2024 07:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tNGv9zP6R4hvEkkOU6L8626izOjceDm6nUegDVe0gVU=; b=MO
	kONVXmVscmxKU56M/D5YxzUVpWaQRj9BtENc7teChMgW8CLQw3JNZ+njzn4yaiF0
	1nz3XuibT242/TldeLN0T0sSv6oORkjmPLH5OIl2NYp3t/fqyPTKsCaxfMCI6IES
	lHf8056ATO9PscXDX1VN8t1EbKfElk9JvUOkq/UfTJIXjEp2rwdjN9b3Cedkv3dQ
	t/WDoY2bWg04CHogP3MbjSHqEy/lEIRmvBAWP53DuAYRkU5Hts1eLuxtB4KrxJrX
	rZvEj2Ba/1sHljk0dncM8uY8On9NWEh6VvyoowiJIRLHFlsPP+/XSmtMnlMZ7PQJ
	eUGrg8/Iypxt0phNqgbA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y51tuh84r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 07:16:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44G7GV16005860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 07:16:31 GMT
Received: from [10.110.99.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 May
 2024 00:16:30 -0700
Message-ID: <c0257948-ba11-4300-aa5c-813b4db81157@quicinc.com>
Date: Thu, 16 May 2024 01:16:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential impact of commit dfa2f0483360 ("tcp: get rid of
 sysctl_tcp_adv_win_scale")
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
CC: <soheil@google.com>, <ncardwell@google.com>, <yyd@google.com>,
        <ycheng@google.com>, <quic_stranche@quicinc.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>
References: <7ec9b05b-7587-4182-b011-625bde9cef92@quicinc.com>
 <CANn89iKRuxON3pWjivs0kU-XopBiqTZn4Mx+wOKHVmQ97zAU5A@mail.gmail.com>
 <60b04b0a-a50e-4d4a-a2bf-ea420f428b9c@quicinc.com>
 <CANn89i+QM1D=+fXQVeKv0vCO-+r0idGYBzmhKnj59Vp8FEhdxA@mail.gmail.com>
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <CANn89i+QM1D=+fXQVeKv0vCO-+r0idGYBzmhKnj59Vp8FEhdxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UHPWRS4lIlHXmom_V5AZODchUroq4Gxv
X-Proofpoint-GUID: UHPWRS4lIlHXmom_V5AZODchUroq4Gxv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_03,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160050

On 5/15/2024 11:36 PM, Eric Dumazet wrote:
> On Thu, May 16, 2024 at 4:32 AM Subash Abhinov Kasiviswanathan (KS)
> <quic_subashab@quicinc.com> wrote:
>>
>> On 5/15/2024 1:10 AM, Eric Dumazet wrote:
>>> On Wed, May 15, 2024 at 6:47 AM Subash Abhinov Kasiviswanathan (KS)
>>> <quic_subashab@quicinc.com> wrote:
>>>>
>>>> We recently noticed that a device running a 6.6.17 kernel (A) was having
>>>> a slower single stream download speed compared to a device running
>>>> 6.1.57 kernel (B). The test here is over mobile radio with iperf3 with
>>>> window size 4M from a third party server.
>>>
> 
> DRS is historically sensitive to initial conditions.
> 
> tcp_rmem[1] seems too big here for DRS to kick smoothly.
> 
> I would use 0.5 MB perhaps, this will also also use less memory for
> local (small rtt) connections
I tried 0.5MB for the rmem[1] and I see the same behavior where the 
receiver window is not scaling beyond half of what is specified on 
iperf3 and is not matching the download speed of B.

>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c?h=v6.6.17#n385
> 
> Hmm... rmnet_map_deaggregate() looks very strange.
> 
> I also do not understand why this NIC driver uses gro_cells, which was
> designed for virtual drivers like tunnels.
> 
> ca32fb034c19e00c changelog is sparse,
> it does not explain why standard GRO could not be directly used.
> 
rmnet doesn't directly interface with HW. It is a virtual driver which 
attaches over real hardware drivers like MHI (PCIe), QMI_WWAN (USB), IPA 
to expose networking across different mobile APNs.

As rmnet didn't have it's own NAPI struct, I added support for GRO using 
cells. I tried disabling GRO and I don't see a difference in download 
speeds or the receiver window either.

>>
>>   From netif_receive_skb_entry tracing, I see that the truesize is around
>> ~2.5K for ~1.5K packets.
> 
> This is a bit strange, this does not match :
> 
>> ESTAB       4324072 0      192.0.0.2:42278                223.62.236.10:5215
>>        ino:129232 sk:3218 fwmark:0xc0078 <->
>>            skmem:(r4511016,
> 
> -> 4324072 bytes of payload , using 4511016 bytes of memory
I probably need to dig into this further. If the memory usage here was 
inline with the actual size to truesize ratio, would it cause the 
receiver window to grow.

Only explicitly increasing the window size to 16M in iperf3 matches the 
download speed of B which suggests that sender server is unable to scale 
the throughput for 4M case due to limited receiver window advertised by 
A for the RTT in this specific configuration.

