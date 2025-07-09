Return-Path: <netdev+bounces-205493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62135AFEEFC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56BD5A4AF9
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAE0217F29;
	Wed,  9 Jul 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MBToRWA/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B44C6E;
	Wed,  9 Jul 2025 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079535; cv=none; b=Has0lxh5FyA4xw8n7kceDrZ0iOoXXs/jhtTd5o6B2g+WzEHlZvuESe4LXJ1KRRElo0H97uCWvwPu0WEmasnpSl2lRjcvV+zmQ+wVnnex8v7tkOwQ5ISOwL2TiB1tDgbfWVnPX54oZM4MduljGl2TagRuqupCORv4asNir0Xw69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079535; c=relaxed/simple;
	bh=P/SeqXWOKCy1GEablUE/0A0Farmu6+UYN0NKR9q48ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uw0mTnEnxtMLwfh4fBOOFn+xXS4YnisM4FTMni4a2HvoRhLp4ajcM4bohZ1HhFOzyxw6WOF980pN93wahVWVUDo05PwXlH0DoX1N7kqYDdB1Rapuqhcv2lVKM6dH+X8anEUWPEA0SuvOSR9H3zo8cRFkvOm+Ce2SoKv8Ib/H2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MBToRWA/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569G6JI6017556;
	Wed, 9 Jul 2025 16:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aog7Hv
	P6JF0CHZvERP9cBdq/G3HkEkoIxWoZljCEm+0=; b=MBToRWA/mNqnWxQio7K/qe
	58XwHtWlhrDRFH7dCef6wZzs0+vqGK6LJVzizS1uWP4Q9RW655mFMFf2RMgDpQkk
	VBpI9wD11r9/9SDTKdlgvOHXgrkAcUVMhPhJ5E5y/5c4MjIxfLR0zlelHGDFk78j
	jgqMXUjcCX121PuqK7Fa6XGnPVi5HQ/q5ONq3damrRQibuqGxpcwj+XzjbpegNt1
	2+9Msdsw8jFDqh4iDok60AiZRUOhiOqmHqcj9Gu2F+mOSLoRgHFYDZgTG5I6gN9e
	1josJ081d438WqEKeYo5SMSU+C8nqmmdrQWZZO0NaZQ0vwF8314y+hvHLXVijx4w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur77gv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 16:45:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569GDVVM013562;
	Wed, 9 Jul 2025 16:45:23 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkm0w3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 16:45:23 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569GjNsI1508348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 16:45:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E678E58053;
	Wed,  9 Jul 2025 16:45:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B48958043;
	Wed,  9 Jul 2025 16:45:22 +0000 (GMT)
Received: from [9.41.105.251] (unknown [9.41.105.251])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 16:45:22 +0000 (GMT)
Message-ID: <0ea1ac72-a914-4a64-b82e-39b78685f51a@linux.ibm.com>
Date: Wed, 9 Jul 2025 11:45:21 -0500
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
To: Luigi Leonardi <leonardi@redhat.com>
Cc: mhal@rbox.co, sgarzare@redhat.com, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, v4bel@theori.io
References: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>
 <brnvavvmkbxcvzy6ahwyissqnmjl7db2w6yfk5pmipuhuvsdu4@qwoeyioaues6>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <brnvavvmkbxcvzy6ahwyissqnmjl7db2w6yfk5pmipuhuvsdu4@qwoeyioaues6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE0NyBTYWx0ZWRfX2xfNTNxwjzEl DqBHqDdFS6J7hxBc+NJnNp2IoYXywrmn7iuDX1duQiKx7mzu7fNOpb9y499AVM4m/L2CvOzbgbA yRtlqxWJucXDMQk/lFHiyr/x3PL9C5JYscv/udBRC34iW3I+Sq25L6N+btilSlQDKkjC62DyIk7
 6x8+IDiCLHSjX9Jx4qnbOpLTzE0xRld/TaA2BxVDDTUtXV0KASJqzF4gSS14eKX67Y4yYz5l5e0 C4MFlASWBfoOzF09ERwN3QoyqgPFYrpd1GWb57EACDVKr5g6+YcA0Ws6t4WFg9y//AR0INk4/d4 tnpXDkrCPMfAZ4t6MuPRxZqnBQ3KUVmaLbaTn5c1BCojJQBTLIVjWDMZ6otZT+Yp/e/x9O0tUFA
 KJsRBdiRo5pGAlg3yBzWmQBjQSbi87eUVEggE9Rbbvpa4nRersM2HAjj1vXsUlyG81CrA1+b
X-Proofpoint-GUID: TP63BPCDFdqiSFK_vyzrLvUtQEE_pIkb
X-Proofpoint-ORIG-GUID: TP63BPCDFdqiSFK_vyzrLvUtQEE_pIkb
X-Authority-Analysis: v=2.4 cv=W/M4VQWk c=1 sm=1 tr=0 ts=686e9ca4 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=fAZRErWDavPNBwaSLAUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_03,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090147

On 09-Jul-25 09:57, Luigi Leonardi wrote:
> Hi Konstantin,
> 
> On Wed, Jul 09, 2025 at 09:54:03AM -0500, Konstantin Shkolnyy wrote:
>> I'm seeing a problem on s390 with the new "SOCK_STREAM transport 
>> change null-ptr-deref" test. Here is how it appears to happen:
>>
>> test_stream_transport_change_client() spins for 2s and sends 70K+ 
>> CONTROL_CONTINUE messages to the "control" socket.
>>
>> test_stream_transport_change_server() spins calling accept() because 
>> it keeps receiving CONTROL_CONTINUE.
>>
>> When the client exits, the server has received just under 1K of those 
>> 70K CONTROL_CONTINUE, so it calls accept() again but the client has 
>> exited, so accept() never returns and the server never exits.
>>
> 
> Thanks for pointing this out!
> I had an offline discussion with Stefano about this issue.
> This patch[1] should address it.
> Please let us know if it works on s390 too.
> 
> Cheers,
> Luigi
> 
> [1]https://lore.kernel.org/netdev/20250708111701.129585-1- 
> sgarzare@redhat.com/
> 
I've run it 40 times with this patch, and it seems OK now. You can add 
my "Tested-by" if you wish.

