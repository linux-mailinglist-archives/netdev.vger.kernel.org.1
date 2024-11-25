Return-Path: <netdev+bounces-147131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAEC9D79BE
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 02:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A16A1B22697
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C54EEC5;
	Mon, 25 Nov 2024 01:19:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E53D64
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732497566; cv=none; b=TC4AoWR5wfxa3bCvlgOVo/0sjeCE2p9QZdtJVf6fcS0py8verFgT2I938cVqrT8Cm949Sn0ExUd09aEQ7MV+Ow14IX2IrneDK5WqPhhIw41QvhsbUjxOT3ATYHNNLumXNye+tVEig7bS5SfluDsAxLb1WMp/dWFZ317ZaUY92/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732497566; c=relaxed/simple;
	bh=Gk1VdypdBLttUVNW3c2fmyLCEHdmB5dFaJS3wdAqxRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vi5QRFkwJxWmmaUjEpCKy//MRzEoguq+mq2vUhc3u1EEgtMF1+2NoAePhz6rYyKPjAMHejZKW2nfPwqOt1ATu/a4kA2BkS2DfsC9i4fY/vXEm6+lZnUlL24KqrR0oFUje3cNHoV4AVBoqXml6zS2od5i1SxxhS0c/4OMXP1UvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XxSTT1vdGzPnZq;
	Mon, 25 Nov 2024 09:16:29 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id C157E180102;
	Mon, 25 Nov 2024 09:19:14 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 kwepemg200003.china.huawei.com (7.202.181.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Nov 2024 09:19:13 +0800
Message-ID: <0c958770-2797-4a5c-997a-4df9ed068de8@huawei.com>
Date: Mon, 25 Nov 2024 09:19:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] tcp: Fix use-after-free of nreq in
 reqsk_timer_handler().
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
References: <20241123174236.62438-1-kuniyu@amazon.com>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <20241123174236.62438-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200003.china.huawei.com (7.202.181.30)



在 2024/11/24 1:42, Kuniyuki Iwashima 写道:
> The cited commit replaced inet_csk_reqsk_queue_drop_and_put() with
> __inet_csk_reqsk_queue_drop() and reqsk_put() in reqsk_timer_handler().
> 
> Then, oreq should be passed to reqsk_put() instead of req; otherwise
> use-after-free of nreq could happen when reqsk is migrated but the
> retry attempt failed (e.g. due to timeout).
> 
> Let's pass oreq to reqsk_put().
> 
> Fixes: e8c526f2bdf1 ("tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().")
> Reported-by: Liu Jian <liujian56@huawei.com>
> Closes: https://lore.kernel.org/netdev/1284490f-9525-42ee-b7b8-ccadf6606f6d@huawei.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   net/ipv4/inet_connection_sock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 491c2c6b683e..6872b5aff73e 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1191,7 +1191,7 @@ static void reqsk_timer_handler(struct timer_list *t)
>   
>   drop:
>   	__inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
> -	reqsk_put(req);
> +	reqsk_put(oreq);
>   }
Reviewed-by: Liu Jian <liujian56@huawei.com>
>   
>   static bool reqsk_queue_hash_req(struct request_sock *req,

