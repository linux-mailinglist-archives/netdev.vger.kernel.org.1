Return-Path: <netdev+bounces-121229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2C895C3BC
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 05:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED7EB21DDC
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCE52837D;
	Fri, 23 Aug 2024 03:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="KtUxe/uI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095B26AF6;
	Fri, 23 Aug 2024 03:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724384046; cv=none; b=YCIWb2SqhFAtz81Z8VfNGQKkUHl1vXjgx9wImkon/zKoCD/BPEwmF7/6W6F6aA/ZkLqC9klrjLGxH49bJZJDBXVceLrQrmXkQCSoJD5m3Zb7x/PepB0XyQzKeCqLeQEd4/K0k7kKsjVQi02t5uRf90hknPxNBo9XfeFmN49XVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724384046; c=relaxed/simple;
	bh=AAldIjVYJf29Ue28rPhwzXzjdIRqZSAfG4wW3b334Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0TFquufMfgsD1GQ0zMgzOyhiluA3hDgeSCRo85EZLixwSPABFk5mm6+7nY7ue4kGpTbgnqKee6GrfsK0YJ0AG8wbWYSf0KX9CtXZYnL2THHbTmY9v2Ak1/GtZDNbyYYq+X0s3Qmu992UKogAywwAe9XiRCH91x8ZOx8Xhty3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=KtUxe/uI; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MKKZwE021570;
	Fri, 23 Aug 2024 04:33:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=mlzrP82qbhjMuXWnlK5HYZdHIUlg1DeOSmSe1uppHKU=; b=KtUxe/uI/BCB
	VaQ027Gx6b7mSbkb3zerhPrUOuNLCcoefIIjYJABMEQkSbHHgdWBEHujkwrQfMUr
	HdExICQ4Lnfwjlg0iNRXvmDkIo799ALyP63qUPXuptt842XzzyLAfT/DtG+I7IjR
	Qf7Cu5oHUWNM8xCGuParfX7Eo07xg3NGiwHXrkOvufoPh1rd5LVbluWgI8iyjs9g
	G8rgDwxF7zDSWBaIWONQ9wic2uSbI43sEbwzTUEkVqN6lwDYG5zuSfU3CZmPpRwJ
	rlOJY9smi+bOwpv6NRCJw5AfjFcTzdZ0Qy7G7eKh0o1MpBseNa8P8U1H5+4kQhQq
	pGmybp2LvQ==
Received: from prod-mail-ppoint7 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be forged))
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4149pf1abu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 04:33:48 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
	by prod-mail-ppoint7.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 47MNKBBE013466;
	Thu, 22 Aug 2024 23:33:47 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
	by prod-mail-ppoint7.akamai.com (PPS) with ESMTP id 412q6yj8jg-1;
	Thu, 22 Aug 2024 23:33:47 -0400
Received: from [100.64.0.1] (prod-aoa-dallas2clt14.dfw02.corp.akamai.com [172.27.166.123])
	by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 45D08638BC;
	Fri, 23 Aug 2024 03:33:46 +0000 (GMT)
Message-ID: <44bae648-9ced-4b57-b7c4-95f7740dceae@akamai.com>
Date: Thu, 22 Aug 2024 20:33:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240823021333.1252272-1-johunt@akamai.com>
 <20240823021333.1252272-2-johunt@akamai.com>
 <CAL+tcoDh1GUL-m-UXM=WenN74wXLsgudEScJedfa=AEzt1Rs9g@mail.gmail.com>
Content-Language: en-US
From: Josh Hunt <johunt@akamai.com>
In-Reply-To: <CAL+tcoDh1GUL-m-UXM=WenN74wXLsgudEScJedfa=AEzt1Rs9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_02,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=670 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408230022
X-Proofpoint-GUID: kDfnjf8dSUpjEQFTqcX6kFwXInpwxfKs
X-Proofpoint-ORIG-GUID: kDfnjf8dSUpjEQFTqcX6kFwXInpwxfKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_02,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 spamscore=0
 suspectscore=0 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=444
 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230022

On 8/22/24 8:27 PM, Jason Xing wrote:
> 
> Hello Josh,
> 
> On Fri, Aug 23, 2024 at 11:02 AM Josh Hunt <johunt@akamai.com> wrote:
>>
>> There have been multiple occassions where we have crashed in this path
>> because packets_out suggested there were packets on the write or retransmit
>> queues, but in fact there weren't leading to a NULL skb being dereferenced.
> 
> Could you show us the detailed splats and more information about it so
> that we can know what exactly happened?

Hey Jason

Yeah for some reason my cover letter did not come through which has the 
oops info that we hit. I'll resend it now. Fingers crossed it goes 
through this time :)

Josh

