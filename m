Return-Path: <netdev+bounces-205529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF20AFF15B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 21:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D32B1C85658
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 19:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A614C241131;
	Wed,  9 Jul 2025 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O20vyTVm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212021A452;
	Wed,  9 Jul 2025 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087796; cv=none; b=jgAjPLjQGm843BqP9SmsDfYrL7qcEw6USJU5GVY0n0L42+/E0S1AGY3MiG++WF5lHyHUfGXpRrYARbQsL1lFfKrzNlW4dCjrjG4lhFMFAOWqrKcCI89/mHZ38QVzuNFACrwR6C2tHR306R/omXXioxd7gpfEwLplNIN0GNjghHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087796; c=relaxed/simple;
	bh=w33Yy1b2aTYcQmR5hFPvM8miDleChN70erjham5PHCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJ6Vn5jbgdxHpAbSvdES1Jof4mIbDPAlBZsU6H0f1CmuLz3+/G2oMNPGezUzA5xIiBU9MEMSv+FgntJ3NgkhBTYeMgP8yZ9EnBUg6Ktyzkp38wyaleE6zQw89AoV2HU+aC+BD6JVcDDOUiDrzRhi01k2h7gq+K+/SwgLJv9ubwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O20vyTVm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569F2Quu006870;
	Wed, 9 Jul 2025 19:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ifBq+E
	R6NWxi5h+0YyMfp5vKAFMEsKXlgVcLfp9LX/Y=; b=O20vyTVmt7UI03X1PUbP6v
	gLNn75TGOtHlui9nIWXXF4dW1KRgIQwUcvR8gZdpWNKXBv7cetag6bVmxkFJMYvi
	9pwLjNfrRT4RBU+rR+wWDgiXGwnpAvWzdeH/ZjTH78cdOeUgqvlDGxTfCcPDX+nT
	oFZEFOHFLNh7RCEBP/U+UToxyFDnDLOSzSlzFKZP1VwpuiSi4Rg2TjGn5GNtCBVg
	aU4EbP1QFaoGRd1Og0KyfJ/689L2OzYMcM4ojNdQr1+1uG+2AazxaWMea7nP6YaA
	OU54E3u/lsieh0Ee1gdDZnUFcrqxCS7VJLJM3wwwYmxSV3kXlpzBvRuozU68/1Kw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur787jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 19:03:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569I7DMs021519;
	Wed, 9 Jul 2025 19:03:05 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectsvqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 19:03:05 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569J349930081604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 19:03:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E15358043;
	Wed,  9 Jul 2025 19:03:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9B6E58059;
	Wed,  9 Jul 2025 19:03:03 +0000 (GMT)
Received: from [9.41.105.251] (unknown [9.41.105.251])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 19:03:03 +0000 (GMT)
Message-ID: <1915e11f-9513-4d9a-a46a-3f97ac152a3b@linux.ibm.com>
Date: Wed, 9 Jul 2025 14:03:02 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] vsock/test: Add test for null ptr deref when
 transport changes
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: mhal@rbox.co, virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, v4bel@theori.io, leonardi@redhat.com
References: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>
 <CAGxU2F7bV7feiZs6FmdWkA7v9nxojuDbeSHyWoASS36fr1pSgw@mail.gmail.com>
 <CAGxU2F4GbeCJDYrs8Usd8JJcTrp99gyn3c_zXqpnz+UH2NNBGw@mail.gmail.com>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <CAGxU2F4GbeCJDYrs8Usd8JJcTrp99gyn3c_zXqpnz+UH2NNBGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2OCBTYWx0ZWRfX3evddJ+8NLPa A+2M9HsTl5MiPujeHMFFR02XW0fE5ucHEGxkMPVMHjjdakA2qSTgz9gupgEQbxxuqsuTW91FV1B +fS00PioldEa7EgKcIG2FQuq4JUnRq0AlmDkzuUOmTOcOn2ihxKM2Wnx0Jp+dBKl7O2AXU0XQV7
 PNfStIz7IyyIsvq77z9t4qWHipEzNmKjKubcrdV/t0R2hkSGvxGIFwH0Rt+PiK6Gzt3vBYMZWGp JAsei8gc/RGSlWcVoF65dZ3DIojsGgoiug5vtDPcXo4r3v912fVWeXFmoi4uJdqTeNnNQwhUqcQ MI3wEBEvh9UmniMQTuZzQxDikketwAF3jCVv6Ch+pyWnT4PMFMyByJFY5S2WY84/He7M15l/MM1
 OeBfiJrtau0nC2T+6Jsqhg2W4zMm9TU9Vn/OVnbSzBs6czQova9jCw/FD8F6To4pRj2dBSbz
X-Proofpoint-GUID: EcdP8gGMadH59a8D28cOtQinDaUFNt6X
X-Proofpoint-ORIG-GUID: EcdP8gGMadH59a8D28cOtQinDaUFNt6X
X-Authority-Analysis: v=2.4 cv=W/M4VQWk c=1 sm=1 tr=0 ts=686ebcea cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=yc8Tnp-ilgVpimbPip8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090168

On 09-Jul-25 10:41, Stefano Garzarella wrote:
> On Wed, 9 Jul 2025 at 17:26, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Wed, 9 Jul 2025 at 16:54, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>>>
>>> I'm seeing a problem on s390 with the new "SOCK_STREAM transport change
>>> null-ptr-deref" test. Here is how it appears to happen:
>>>
>>> test_stream_transport_change_client() spins for 2s and sends 70K+
>>> CONTROL_CONTINUE messages to the "control" socket.
>>>
>>> test_stream_transport_change_server() spins calling accept() because it
>>> keeps receiving CONTROL_CONTINUE.
>>>
>>> When the client exits, the server has received just under 1K of those
>>> 70K CONTROL_CONTINUE, so it calls accept() again but the client has
>>> exited, so accept() never returns and the server never exits.
> 
> Just to be clear, I was seeing something a bit different.
> The accept() in the server is no-blocking, since we set O_NONBLOCK on
> the socket, so I see the server looping around a failing accept()
> (errno == EAGAIN) while dequeueing the CONTROL_CONTINUE messages, so
> after 10/15 seconds the server ends on my case.
> 
> It seems strange that in your case it blocks, since it should be a
> no-blocking call.

It was my mistake. The accept() doesn't block. I've retested it more 
carefully and it keeps returning and the loop eventually consumes all 
queued CONTROL_CONTINUE messages and quits, as you described.


