Return-Path: <netdev+bounces-121235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE7595C41B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 06:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C66E1C22277
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 04:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330B42E644;
	Fri, 23 Aug 2024 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="kBmFzLSq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149BC8493;
	Fri, 23 Aug 2024 04:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724386931; cv=none; b=uObzMKbL61hfJXxbxWtHYuo9tfRzz/yQf9LgaoZacw2Aq84Z937kxhuhe4W56W515/iAjlzJ9TJL67mytwvjYDiz8l6PJRTvA3abE+WDICkKB/nTqUn7EucwBuFOf0ilZRvOVnj7Zxiz3Jg5e4p0igBEl549uZQzEXrBq5pxURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724386931; c=relaxed/simple;
	bh=UMZmjfIQQppW5FBj5Cfp3EiH06h7bCNCtk7oX1uUOeg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EKAIpqLdcQiBch0aVRCdHEyil1UDGKvMu+FuJe3FngZlC/gKQwW9RYYah2sbhHfbQzXcqobqOlbEcqgh8Yz7ZyeJA4JhAVSVNk2cbldcpI/o/KhWRNfJS9fOVRhcPizS3BhiYePNi5jb+80pScMxS7Dw1mHb657nDMrQs+B1P1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=kBmFzLSq; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
	by m0050095.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 47N00S8A031371;
	Fri, 23 Aug 2024 05:21:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=cGXwzZW6puFHvf9eX5tFFmg48Ujn6u8t7jVW9QRA8V8=; b=kBmFzLSqdnlv
	UElbWA9YM/LgmyZq1/vD4BluEhEhvDxw+KFpI9YLt55M0QlTMH4OBrjmjz9+uVMQ
	A5mEDcNv2xrNq3+8xkbJsvVWiyhVfJCUYY2ivgGuVUKmVL2sksN5SBlR8FV0ha0O
	bwe8g1S08+ZzQxhnV4lnV3Tv5pmXfSXExbUcQT9dmNBMmryKHC6wXb2gzgtBdqIj
	XJtSmV0y5e4ZKkcV1+vp7QHyziy9Av2Pg0yatcDgjUL5659VAq98YELVkgYojm+J
	XE+eRw0BafaUHinUeZlFv9/lz8SioWbVsqrabEzU2pvMcD8Z8ZAKLtnD81JhUJrB
	fuuQvlyGNQ==
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
	by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 4149pgryy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 05:21:56 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
	by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 47N3qi1o010641;
	Fri, 23 Aug 2024 00:21:54 -0400
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
	by prod-mail-ppoint8.akamai.com (PPS) with ESMTP id 412q6y28ck-1;
	Fri, 23 Aug 2024 00:21:54 -0400
Received: from [100.64.0.1] (unknown [172.27.166.123])
	by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id A6D1619F9;
	Fri, 23 Aug 2024 04:21:52 +0000 (GMT)
Message-ID: <759b06be-9fb8-4fc1-bc93-3f03b3665152@akamai.com>
Date: Thu, 22 Aug 2024 21:21:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] tcp: check skb is non-NULL in tcp_rto_delta_us()
From: Josh Hunt <johunt@akamai.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240823021333.1252272-1-johunt@akamai.com>
 <20240823021333.1252272-2-johunt@akamai.com>
 <CAL+tcoDh1GUL-m-UXM=WenN74wXLsgudEScJedfa=AEzt1Rs9g@mail.gmail.com>
 <44bae648-9ced-4b57-b7c4-95f7740dceae@akamai.com>
Content-Language: en-US
In-Reply-To: <44bae648-9ced-4b57-b7c4-95f7740dceae@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_02,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=595
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230027
X-Proofpoint-GUID: _FaWKvZUKphm0-7AgJeyltWnUJo1DGkD
X-Proofpoint-ORIG-GUID: _FaWKvZUKphm0-7AgJeyltWnUJo1DGkD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_02,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=390 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230027

On 8/22/24 8:33 PM, Josh Hunt wrote:
> On 8/22/24 8:27 PM, Jason Xing wrote:
>>
>> Hello Josh,
>>
>> On Fri, Aug 23, 2024 at 11:02 AM Josh Hunt <johunt@akamai.com> wrote:
>>>
>>> There have been multiple occassions where we have crashed in this path
>>> because packets_out suggested there were packets on the write or 
>>> retransmit
>>> queues, but in fact there weren't leading to a NULL skb being 
>>> dereferenced.
>>
>> Could you show us the detailed splats and more information about it so
>> that we can know what exactly happened?
> 
> Hey Jason
> 
> Yeah for some reason my cover letter did not come through which has the 
> oops info that we hit. I'll resend it now. Fingers crossed it goes 
> through this time :)
> 
> Josh
Seems like our mail server is block the cover letter for some reason 
right now. I'll have to figure out why tomorrow. I filed a bug with 
Ubuntu as well as sending this patch upstream b/c the kernel we're 
running is a stock Ubuntu kernel. The bug report there has most of what 
I put in the cover letter:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2077657

Josh

