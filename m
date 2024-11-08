Return-Path: <netdev+bounces-143407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE21F9C24E2
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CA91C23EA0
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 18:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BC8198E85;
	Fri,  8 Nov 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QiDGOCZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E696C233D88
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731090511; cv=none; b=kL1lGP2K/e5mXvaeT/MxLYU7stzCdpiyPXvTgy1WIlEf0ygmRshlo9IsA61ki37eVBDPBLvaCDkwCEymEyWhYXpTRerUvuDMGv1yVXJKX0Q77uvEo5C/IiBIg6EnqDeM6sHY9B1i3lfj8AKKGL0cXM5Jy1nIpw2DqWErK7QBCWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731090511; c=relaxed/simple;
	bh=aomfWlwmh/DGJ3+fy8dkpzWlh+NgDtApGrsMDMYyB5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVNf6TCH4S9uAzqXMQC/Wz1fug54nUfoJI4SUQFwnZpzeNaY9XxTgw9ycZqi4TFkKBIc1RdGo1qCE/Z+ybjc238AOO95iV2LGm8Sq5JxpfQdqaSIhmp44wjffahp5vb1OivbGmvUrVtNrlfMTvl8AukaJuUyr1QGjkKj15sAzGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QiDGOCZZ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b15eadee87so158235085a.2
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 10:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731090507; x=1731695307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWt0QTmkUmV9Tp/JVuTsCK3jbXPMK6hXiV333qvXKtQ=;
        b=QiDGOCZZxblNzWHL0id1BZtHqWX/RYbam7FWXoQ8HYTMK30u2TNVUPTQ8e0oby2XfL
         SBtiVqnA+Y2XdSgfYMljZOYSH4muyWiKcGwC6wZ16bSXS5qQ4Ct7FlBXyEPE66o/L3/i
         7LnUpOsfH4dTiLC8aWYKfdVG/K5y0/jY6F9WyQpNDso5F3DCp0IxdB52DmDcPwG/u1xF
         tqVrv7I8aVWZBMPVJ4hUTQIH5Nvfct3AvATHR9w26V6hNfSCRgVahQ+fjEBngWriJwG7
         5cLlvZ+MRX4u6bMCHei/pmXVyl7YsK16UTTx1W8luCk8Cf4Twhev/hCf2BXlJjMsneNs
         ctsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731090507; x=1731695307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWt0QTmkUmV9Tp/JVuTsCK3jbXPMK6hXiV333qvXKtQ=;
        b=f21ioP3Ct/wqJjuMMSWflqDShKhDQiE6qhAALEfviJ5yLIaVqsS5gRmbzw8wx1RgCP
         HKAoyTKPf/4mVKdluAi+TY+1N2N0todKNGMLtgpSqGF7QF/SGYcDPenhXohJs87eADqm
         O0mx3J/dkNLBAuuK1KiTMdxBDAdLGHVJLn8ocMxd0tvI3HVJT37VkCF2nAJ7vURFwUsC
         GQzh2pqA7sC3eip92leFG63UPqpqfyz7K6sYMmKPQMZPvtJjEbeje9AP//42AePxfbc8
         I6FUFL4ZuerHYFFBuUPzBdpgQni1hzPDPJE0jasvu8XV6wHgGWxUutVkbr9OXfRVt0+J
         DsQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkW/nrsZDXe4h1+0ygwOAAQF3ylbq4cmMlnT4eV2kBphi76XYlwebfrCObL0+DSMVgkzKpemI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXnK6zyR4HBH8jk/sPTCyYucwoYe4hZla3OpL0Gf5lduHtjsWO
	XzdJa2efo+poxsdeE22UIijpqoxyoIPsjrd7IhY4IBaRiEk9NVUn/pbdPiuu4UY=
X-Google-Smtp-Source: AGHT+IHmZYkgO0mMRiqiwCpCNOTh+1bYly26r67Tsj8ccO33Oezw4Rv/52fZCQXG3sX6Lf+gYpAjZg==
X-Received: by 2002:a05:620a:4510:b0:7a7:dd3a:a699 with SMTP id af79cd13be357-7b331d81d49mr504881285a.11.1731090506810;
        Fri, 08 Nov 2024 10:28:26 -0800 (PST)
Received: from ?IPV6:2601:647:4200:9750:c471:fcfc:9a61:b786? ([2601:647:4200:9750:c471:fcfc:9a61:b786])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acb0496sm182379985a.89.2024.11.08.10.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 10:28:26 -0800 (PST)
Message-ID: <1016b317-d521-4787-80dc-3b92320f2d19@bytedance.com>
Date: Fri, 8 Nov 2024 10:28:22 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH bpf 2/2] tcp_bpf: add sk_rmem_alloc related
 logic for ingress redirection
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: bpf@vger.kernel.org, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
 cong.wang@bytedance.com
References: <20241017005742.3374075-1-zijianzhang@bytedance.com>
 <20241017005742.3374075-3-zijianzhang@bytedance.com>
 <Zy2N48atzfYYTY6X@pop-os.localdomain>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <Zy2N48atzfYYTY6X@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/7/24 8:04 PM, Cong Wang wrote:
> On Thu, Oct 17, 2024 at 12:57:42AM +0000, zijianzhang@bytedance.com wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> Although we sk_rmem_schedule and add sk_msg to the ingress_msg of sk_redir
>> in bpf_tcp_ingress, we do not update sk_rmem_alloc. As a result, except
>> for the global memory limit, the rmem of sk_redir is nearly unlimited.
>>
>> Thus, add sk_rmem_alloc related logic to limit the recv buffer.
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> ---
>>   include/linux/skmsg.h | 11 ++++++++---
>>   net/core/skmsg.c      |  6 +++++-
>>   net/ipv4/tcp_bpf.c    |  4 +++-
>>   3 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
>> index d9b03e0746e7..2cbe0c22a32f 100644
>> --- a/include/linux/skmsg.h
>> +++ b/include/linux/skmsg.h
>> @@ -317,17 +317,22 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
>>   	kfree_skb(skb);
>>   }
>>   
>> -static inline void sk_psock_queue_msg(struct sk_psock *psock,
>> +static inline bool sk_psock_queue_msg(struct sk_psock *psock,
>>   				      struct sk_msg *msg)
>>   {
>> +	bool ret;
>> +
>>   	spin_lock_bh(&psock->ingress_lock);
>> -	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
>> +	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
>>   		list_add_tail(&msg->list, &psock->ingress_msg);
>> -	else {
>> +		ret = true;
>> +	} else {
>>   		sk_msg_free(psock->sk, msg);
>>   		kfree(msg);
>> +		ret = false;
>>   	}
>>   	spin_unlock_bh(&psock->ingress_lock);
>> +	return ret;
>>   }
>>   
>>   static inline struct sk_msg *sk_psock_dequeue_msg(struct sk_psock *psock)
>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>> index b1dcbd3be89e..110ee0abcfe0 100644
>> --- a/net/core/skmsg.c
>> +++ b/net/core/skmsg.c
>> @@ -445,8 +445,10 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>>   			if (likely(!peek)) {
>>   				sge->offset += copy;
>>   				sge->length -= copy;
>> -				if (!msg_rx->skb)
>> +				if (!msg_rx->skb) {
>>   					sk_mem_uncharge(sk, copy);
>> +					atomic_sub(copy, &sk->sk_rmem_alloc);
>> +				}
>>   				msg_rx->sg.size -= copy;
>>   
>>   				if (!sge->length) {
>> @@ -772,6 +774,8 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
>>   
>>   	list_for_each_entry_safe(msg, tmp, &psock->ingress_msg, list) {
>>   		list_del(&msg->list);
>> +		if (!msg->skb)
>> +			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
>>   		sk_msg_free(psock->sk, msg);
> 
> Why not calling this atomic_sub() in sk_msg_free_elem()?
> 
> Thanks.

sk_msg_free_elem called by sk_msg_free or sk_msg_free_no_charge will
be invoked in multiple locations including TX/RX/Error and etc.

We should call atomic_sub(&sk->sk_rmem_alloc) for sk_msgs that have
been atomic_add before. In other words, we need to call atomic_sub
only for sk_msgs in ingress_msg.

As for "!msg->skb" check here, I want to make sure the sk_msg is not
from function sk_psock_skb_ingress_enqueue, because these sk_msgs'
rmem accounting has already handled by skb_set_owner_r in function
sk_psock_skb_ingress.



