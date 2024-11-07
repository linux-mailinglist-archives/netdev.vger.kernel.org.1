Return-Path: <netdev+bounces-142682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D28AE9BFFF1
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6261F226EC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9241D63F1;
	Thu,  7 Nov 2024 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RsVuYFJe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AFD17DE36
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968099; cv=none; b=YS9YFu3Erc9dneRaJiQ1mbV7ujP5o5zZjqJUYj7VGRHH0zzejkt/GZSkIxmmu0YueO284Py01SJQanQXIBJsMyUpmwecqTY1nmtUQth0V93VDCTyAgyb8Jt0wH1hzgI5KkeNjAWuA9/9JoY0FsZDVIjAWNdkhgte8I4VSFSx0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968099; c=relaxed/simple;
	bh=vqH5zzpGAYZuQVUPfpKU7gijFnNsYyeu8zpRuaj92vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMvuXHVNDALIS8Sw+ttcsUBQKnU8EZJfOzPwrzgSDj+lXFIf6n719IGcQIMXHX2JxstFPx8eG+DfpRyUFkSqaTfEg0kJICkzEMOfiwTJzkCx8rkXioxLE8YoDU59wDpw+i7tqzzgJOEFc0+ZU7A10CLAcgykmca7fHK5cP7Y6xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RsVuYFJe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A786p8u015222;
	Thu, 7 Nov 2024 08:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sGWrJp
	6pHKGOtRavLIm3HxEn4SJ8BT6oMPwwtEvFyJI=; b=RsVuYFJeIJhcswNnWVlkr7
	uPuhiP4KbIVj9lECSLEi23PIMjn24XgXqPiMv1PBPTqhk6r9K7trHQYG0Y21c/9T
	iZUIJV1B452i/xMoAo+M7Tniz6NsWormSlxRoB6jFS9+SRz4vrEXaFQN+mA6dFNL
	XIjufPcKOTNzwztjVAsZRKTfxhbQVMbAQsYEykSOxoRQAMqENGgZPXd507Bm6sJA
	YkMMaHphTB/pAERDyNJt8WTY46qjCbG8B7J6uJCUzcuEHtx7ogLquerVtNbQV9gb
	dLv52qaTtnjSzZ7X4x7nVIxsZWiYOftTXHihVd85eR2RFliVXZXgQjCzOh96o0xg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rsbx86ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:28:10 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A78SAOX030254;
	Thu, 7 Nov 2024 08:28:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rsbx86y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:28:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A70d5X2031474;
	Thu, 7 Nov 2024 08:28:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nydmqvs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:28:09 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A78S9Nx18875118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 08:28:09 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFDE358056;
	Thu,  7 Nov 2024 08:28:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 646DC58060;
	Thu,  7 Nov 2024 08:28:07 +0000 (GMT)
Received: from [9.171.9.213] (unknown [9.171.9.213])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 08:28:07 +0000 (GMT)
Message-ID: <ac3a7d28-0a0b-413e-8e9c-44b81fbe9121@linux.ibm.com>
Date: Thu, 7 Nov 2024 09:28:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: do not leave a dangling sk pointer in
 __smc_create()
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Ignat Korchagin
 <ignat@cloudflare.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>
References: <20241106221922.1544045-1-edumazet@google.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241106221922.1544045-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RFs-ticGXD8Ty7gKgA0wqbj5fYxvcEmh
X-Proofpoint-ORIG-GUID: KEdLEIHuqXf7rxWbChs0xK7nEu2XN5gj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=550 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070061



On 06.11.24 23:19, Eric Dumazet wrote:
> Thanks to commit 4bbd360a5084 ("socket: Print pf->create() when
> it does not clear sock->sk on failure."), syzbot found an issue with AF_SMC:
> 
> smc_create must clear sock->sk on failure, family: 43, type: 1, protocol: 0
>   WARNING: CPU: 0 PID: 5827 at net/socket.c:1565 __sock_create+0x96f/0xa30 net/socket.c:1563
> Modules linked in:
> CPU: 0 UID: 0 PID: 5827 Comm: syz-executor259 Not tainted 6.12.0-rc6-next-20241106-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>   RIP: 0010:__sock_create+0x96f/0xa30 net/socket.c:1563
> Code: 03 00 74 08 4c 89 e7 e8 4f 3b 85 f8 49 8b 34 24 48 c7 c7 40 89 0c 8d 8b 54 24 04 8b 4c 24 0c 44 8b 44 24 08 e8 32 78 db f7 90 <0f> 0b 90 90 e9 d3 fd ff ff 89 e9 80 e1 07 fe c1 38 c1 0f 8c ee f7
> RSP: 0018:ffffc90003e4fda0 EFLAGS: 00010246
> RAX: 099c6f938c7f4700 RBX: 1ffffffff1a595fd RCX: ffff888034823c00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00000000ffffffe9 R08: ffffffff81567052 R09: 1ffff920007c9f50
> R10: dffffc0000000000 R11: fffff520007c9f51 R12: ffffffff8d2cafe8
> R13: 1ffffffff1a595fe R14: ffffffff9a789c40 R15: ffff8880764298c0
> FS:  000055557b518380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa62ff43225 CR3: 0000000031628000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>    sock_create net/socket.c:1616 [inline]
>    __sys_socket_create net/socket.c:1653 [inline]
>    __sys_socket+0x150/0x3c0 net/socket.c:1700
>    __do_sys_socket net/socket.c:1714 [inline]
>    __se_sys_socket net/socket.c:1712 [inline]
> 
> For reference, see commit 2d859aff775d ("Merge branch
> 'do-not-leave-dangling-sk-pointers-in-pf-create-functions'")
> 
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Ignat Korchagin <ignat@cloudflare.com>
> Cc: D. Wythe <alibuda@linux.alibaba.com>
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: Dust Li <dust.li@linux.alibaba.com>
> ---

Thank you, Eric, for fixing it! The code looks good to me.
Should the fixed commit not be 2fe5273f149c instead of d25a92ccae6b?

Thanks,
Wenjia

