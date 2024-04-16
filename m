Return-Path: <netdev+bounces-88374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5988A6E96
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198711C208BF
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8220C12D741;
	Tue, 16 Apr 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="PHNTRx7R"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429012C7E1
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278420; cv=none; b=isHk7UAgu+WUkOD0Jwrnd74rp3nKp3baS3QSV2m5UQGvWiLxdC9WKpn9oXeMKL6Ma1X6EMS47LQQBlzlB0/dzOZ3prihlTe8+01mYGZzgOpKIZinwVuXjO4NaWOJBFa4dp1SNp84Q5QXDHuggKDDsqNL4LofcXZASslZhIByGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278420; c=relaxed/simple;
	bh=1BdBPVAV0mrWTGTreldc7Ot1QrtRmHp3dJMaCMuooME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/+Z8mGQT3GYRxbQ77PjA6ABbUy0Prs2OKSY+A2VE4dDf164uzqH6IfRiDkz877l6xuf4/SK/gjDf4/JNVEdx46BuujupEuIUN3lW/qVkQ6NffR0n8MHHx4/CeV/10qdePFPoOZghzXg26QgauNiKfarC103Z56J8Nc4K4fKuPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=PHNTRx7R; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
	by m0409409.ppops.net-00190b01. (8.17.1.24/8.17.1.24) with ESMTP id 43GDZM0Y022093;
	Tue, 16 Apr 2024 14:55:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	jan2016.eng; bh=DHwnHypu6sHzP6tjQeyxFr/Sxhwumgdt7dqnAJdslrE=; b=
	PHNTRx7RK0rLBCyG7fLAppwypSKglxCwLuXh3uJpUxeZtmxToAtGiQyNJUw7ZEbg
	q3O0+TE5PUKqhnopDy/j8/GiS+W43XIe9W8NFxfQfzTzwZQi25AiVH5QZsw4gK6/
	1j1TbJyI5wvrnK9OcE/UV1IAYsmfWjH1rWHvBlnSEMWrqcvBG6mARidCFIlamncU
	ywlhkPG4W5Xmvg3t3RkuW4L2cq4yNitOHGncyjISZXVKOQoZoDlzVa9iTTUeEFWr
	ZU+rcPfPydaVhctdizeKLeTDrsA97MqVBv8SubadfxagKud6Tolqw5XhZqqh7h42
	floWpsdKhNtrKaherhEp/w==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
	by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 3xhtbng6j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 14:55:49 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 43GB0p1g008621;
	Tue, 16 Apr 2024 09:55:47 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 3xfncxg04s-1;
	Tue, 16 Apr 2024 09:55:47 -0400
Received: from [172.19.45.47] (bos-lpa4700a.bos01.corp.akamai.com [172.19.45.47])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 9029C33251;
	Tue, 16 Apr 2024 13:55:47 +0000 (GMT)
Message-ID: <f3065c55-5123-4cd7-8e93-85a74b150a27@akamai.com>
Date: Tue, 16 Apr 2024 09:55:47 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mlx5 and gre tunneling
To: Gal Pressman <gal@nvidia.com>, saeedm@nvidia.com
Cc: netdev@vger.kernel.org
References: <c42961cb-50b9-4a9a-bd43-87fe48d88d29@akamai.com>
 <6e722b57-7fd9-40ea-8dc5-0ecf62dcfb66@nvidia.com>
Content-Language: en-US
From: Jason Baron <jbaron@akamai.com>
In-Reply-To: <6e722b57-7fd9-40ea-8dc5-0ecf62dcfb66@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160083
X-Proofpoint-ORIG-GUID: oSfDGNZMXMIDYQ_lZv3n0NaXzOORqvd7
X-Proofpoint-GUID: oSfDGNZMXMIDYQ_lZv3n0NaXzOORqvd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160083

On 4/16/24 8:28 AM, Gal Pressman wrote:
> On 08/04/2024 16:41, Jason Baron wrote:
>> Hi,
>>
>> I recently found an issue where if I send udp traffic in a GRE tunnel
>> over a mellanox 5 NIC where tx-gre-segmentation is enbalbed on the NIC,
>> then packets on the receive side are corrupted to a point that they are
>> never passed up to the user receive socket. I took a look at the
>> received traffic and the inner ip headers appear corrupted as well as
>> the payloads. This reproduces every time for me on both AMD and Intel
>> based x86 systems.
>>
>> The reproducer is quite simple. For example something like this will work:
>>
>> https://urldefense.com/v3/__https://github.com/rom1v/udp-segmentation__;!!GjvTz_vk!TPSVKAaeP_0RAV6hCgRl1GVxyz54xSI1oNXyo8HgWbTXLQ8ZyPRZIlOhPq68YerjtMBMo4bm$
>>
>> It just needs to be modified to actually pass the traffic through the
>> NIC (ie not localhost). As long as the original UDP packet needs to be
>> segmented I see the corruption. That is if it all fits in one packet, I
>> don't see the corruption. Turning off tx-gre-segmentation on the
>> mellanox NIC makes the problem go away (as it gets segmented first in
>> software). Also, I've successfully run this test with other NICs. So
>> this appears to be something specific to the Mellanox NIC.
>>
>> Here's an example one that fails, with the latest upstream (6.8) kernel,
>> for example:
>>
>> driver: mlx5_core
>> version: 6.8.0+
>> firmware-version: 16.35.3502 (MT_0000000242)
>>
>> Let me know if I can fill in any more details.
>>
>> Thanks!
>>
>> -Jason
>>
> 
> Hi Jason, thanks for the report!
> 
> I have managed to reproduce the issue on our side, let me see what went
> wrong.
> 

Hi Gal,

Thanks for looking into this.

We've also found that vxlan encapsulation also fails using the same 
testcase as used for gre tunneling. For vxlan encapsulation if we turn 
off 'tx-udp_tnl-csum-segmentation' then things work again.

Thanks,

-Jason

