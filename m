Return-Path: <netdev+bounces-71693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 091F5854C33
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5CD289076
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2E55B671;
	Wed, 14 Feb 2024 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mLhaSdPT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84F5B67A
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923414; cv=none; b=WTPKng/ffvYEj6h+KWjX8Bl7c47/o8q83cpEqf1otDcS38wPU/5ecHPc7EJo4m8N6DL2Tv5fH4BMxdKimBUmuhyJYrL0mo9DKBWG4E+51LPz+FvXfoF8qS59yOLjge6TEh9u0j3czMxvEfV2jckH3cXhicw7LQVN45vhgsA48LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923414; c=relaxed/simple;
	bh=TiLzshauKvEqriLWxnoCBYQ+tgtcJF+xqx3cl3DKqJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfySP6Kc9DT87pChb5bFg3ZXDJPBi+JMhooaReiB3irfC4rM6BDi6SXHcOOwfXewp0+M+Hk1ZeBTHSDTN8yECjM/lEhx0W38IouD/Fd0iGqPASjrDCxzFkIAn/fcKSxvFqx6i+eSH04MLEVQrtTtPZ3ytxxZyKwti2iveILJ0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mLhaSdPT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EEH5Rl002706;
	Wed, 14 Feb 2024 15:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iLHUZgjwt4pL37NB7/FOHQ0QYfJ+TvVSGc/KfaE4bWE=;
 b=mLhaSdPTNwN2aWeYchIjmHBat7MGD/+gNS5qMpJUIyeJsUxXuhAalbNgdNtJikfaicvE
 HClIP3yYopAMjM+boEblWUwOnSnLkMyeamsFn0CJToriyOtVoOiWKDJU5FUPj/hDwr8/
 0lU4B0FtOLcadV9GAgE3mPuCC7YmYjt2QDT898MbEpIkJPxlV8rJDvI6AiVFn7/jOxdH
 iM+sZ2xQaghCcZocSde2CPpCHyhKKPZAEH23IT7YuXUcWnch6AVHVOSpydFSNUayymqi
 JrlKK47m1iPae4+QuSI4/g4zEmij+eSk4c1+y980ikxSPmews2IrwYt9H/D6SDedj4uG IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8rmvu6je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 15:10:06 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EEuW1O013825;
	Wed, 14 Feb 2024 15:09:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8rmvu63r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 15:09:54 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41ED6h4R024975;
	Wed, 14 Feb 2024 15:09:14 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfpejxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 15:09:14 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EF9Buw49676694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 15:09:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EADE358053;
	Wed, 14 Feb 2024 15:09:10 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8342E58043;
	Wed, 14 Feb 2024 15:09:09 +0000 (GMT)
Received: from [9.179.7.81] (unknown [9.179.7.81])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 15:09:09 +0000 (GMT)
Message-ID: <50244213-5d12-4919-837d-66364f1ae8b5@linux.ibm.com>
Date: Wed, 14 Feb 2024 16:09:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: smc: fix spurious error message from
 __sock_release()
To: Dmitry Antipov <dmantipov@yandex.ru>, Ursula Braun <ubraun@linux.ibm.com>
Cc: Karsten Graul <kgraul@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20240212143402.23181-1-dmantipov@yandex.ru>
Content-Language: en-GB
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20240212143402.23181-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rwGUvgDQdUgF-SzhaI5Kzuc3E3hcawia
X-Proofpoint-ORIG-GUID: nvVMiR-psmyq6ILjV9MbUJdl-qIzgZZ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_08,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 clxscore=1011 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140116



On 12.02.24 15:34, Dmitry Antipov wrote:
> Commit 67f562e3e147 ("net/smc: transfer fasync_list in case of fallback")
> leaves the socket's fasync list pointer within a container socket as well.
> When the latter is destroyed, '__sock_release()' warns about its non-empty
> fasync list, which is a dangling pointer to previously freed fasync list
> of an underlying TCP socket. Fix this spurious warning by nullifying
> fasync list of a container socket.
> 
> Fixes: 67f562e3e147 ("net/smc: transfer fasync_list in case of fallback")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
I see my antwort is too late...

But I still want to send out my comments:
- please check current MAINTAINERS to put all of the related person in 
your recipient list.
- It looks reasonable to me. I'm curious how you got the warning. By 
using ULP, right?

Thanks,
Wenjia

> ---
>   net/smc/af_smc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index a2cb30af46cb..0f53a5c6fd9d 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -924,6 +924,7 @@ static int smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
>   		smc->clcsock->file->private_data = smc->clcsock;
>   		smc->clcsock->wq.fasync_list =
>   			smc->sk.sk_socket->wq.fasync_list;
> +		smc->sk.sk_socket->wq.fasync_list = NULL;
>   
>   		/* There might be some wait entries remaining
>   		 * in smc sk->sk_wq and they should be woken up

