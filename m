Return-Path: <netdev+bounces-168269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E22A3E506
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFAA1890948
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31DE2638B4;
	Thu, 20 Feb 2025 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="qpPcsQyI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38792213E80
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079745; cv=none; b=MRTurHibM5DWErN4UiSyk1eUW7SAQhHOuT3YXQA9E2W6PjMVtzvmQC/9Lu8cpH3566GuqiFuGqjMKVp2uF+jASqY+BCDjTI3uXbbN/Fu//eTJvJkXQYol5ssqRM1IqTUzlcE2SWeCoRKEBGob7n8Nn95K0CyvFh2D/rPbHHCHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079745; c=relaxed/simple;
	bh=Z5WG/dXI1BeTd8dauMdu8taEINCJjgvylDcox/Y6vps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S12sj+uQheEIQAQjnXnIlwssspVThBJ3FEv7PVrqwc9zPCPE8KaR/RqvhkbHByHoxq7yiGlSBICpteXjEwZODQE+e1Jgfw0OY4pOlOVbK3DE+xqZuODpzermW5B85TWfV9Y3e0DdXe7t1a9xNOdBfZupxHFJJa6bLllQdrShl4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=qpPcsQyI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220f4dd756eso26893965ad.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 11:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1740079743; x=1740684543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8YHsuiy1+f/A6GfVm+1NpN16RWiUayntjMvwwlwPWo=;
        b=qpPcsQyIqtrKSsBtLqjPU/TXXELHrfOI5cHOlpPz2EwEgnKXqPd9884HJhILh6iJEK
         uPWw+IJAk8IcEZGsO4tSeZgq0dJHH2mmgfKpHZJYKtfmr/404WSW+hAaIh4UZXIH1qDG
         u0riQ6e91xytgu2UNley9YzCOpWELP22S36WH/cOPilQzn5YNKHyosLCE8SRkoxIltqU
         tGnbxbuRWQ2sprCuF/OvYkQCerxcGK6hP/GREDHIuZMXt88cRg+C8N9Vt624nVUSo8wQ
         yl9m67/YnJwtVQ+X7aNovZozRA/C1+xIfXOXOwSzST6kxlSTgZK66UUEiBho+E0pLBR6
         b3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740079743; x=1740684543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8YHsuiy1+f/A6GfVm+1NpN16RWiUayntjMvwwlwPWo=;
        b=rs/SQP+VRyWQACQoDdTnzIzBKZF7KExfRWY1/rQDPJ0z1hE8G+2s/qcPe/a3x63bik
         a4Rq/N0R6lz/0gknEPXIUY73yHsTpDhg4/b2fF5XbyT27aUtIgSMJe2vn4b/Z3bgfKbr
         O9QSN7N6ujqLaf2IBp5ex42lqzES4CI7vBVPDRvgpQA432t6Fxyf3PRXrwhAwWhVAvVf
         bPcq4vVFseHRMdnQwujTUL4gyJeunZjj7ea8DEdXmbxlXmvul+zcLMoGyRqJv2TbCIeT
         EuZGox44kwBS3jQuP9W3dCwUThRk46y2UqVH7CDKh5X5py/Xf+5/O75/3MSJUD9LKvf1
         qjFg==
X-Forwarded-Encrypted: i=1; AJvYcCVBuZG0Y5Uxb7NE6UrYTdf8F96HRddis3hB6E0kT+UEd0hEx/VAxKRbQrOSMvv6ROoUl0hrpHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KLL+B13kuBEesSonMgIjK8goe3xPHHa2pVjG5/sX3kcw2Af3
	xHO9UYVjKfOVOsmg8HliOoSdv2l1ptijb4vNXfjYVcpExoKwV7ugitFDeG0f8k0=
X-Gm-Gg: ASbGncuSdzb9bZalrdD7t6oaY783n3RnVc9vH1mcjSdsW6kYcxQ3EqEmI5rA2v9RuD7
	F/IRuOXcYH4+DyCo2cYgP1++4EzugHCaHM9X3D8a75iHRc2NpcG+jE0HdzQamenGB8SWhy1V9Sz
	xmKNUWSXNR6ea2byvo0zwd8lfkCHJRr1Ihusj9FvlSv++E3f+If3VEWLS2YnGP87+GifIRdUSw1
	m5FD+rhGwu/l+MP8IK1MRDl5QSzXLfx9euPqcvGpFqbLKomJwB57puiVTVAsv8DRcsgNzV3krZo
	DXMjcn1+569K1J/GLmP4XwHhhoGHniPGecqA5f0RBtLbGd1V4nHsYQ==
X-Google-Smtp-Source: AGHT+IEWL1CJJIlw8wKxBVIA4VDp1ROlSiE+1PdAElJt82OynPmlWxDAlVLjKvSBprf2tnzuTuNdxA==
X-Received: by 2002:a05:6a00:3e14:b0:730:949d:2d36 with SMTP id d2e1a72fcca58-73426d77d68mr97516b3a.18.1740079743390;
        Thu, 20 Feb 2025 11:29:03 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:18cb:90d0:372a:99ae? ([2620:10d:c090:500::6:d6c0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568adasm14683273b3a.52.2025.02.20.11.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 11:29:03 -0800 (PST)
Message-ID: <32e90909-f6b5-4810-b2f1-30c6c9767159@davidwei.uk>
Date: Thu, 20 Feb 2025 11:29:00 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] io_uring/zcrx: add single shot recvzc
Content-Language: en-GB
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
References: <20250218165714.56427-1-dw@davidwei.uk>
 <20250218165714.56427-2-dw@davidwei.uk>
 <270ce534-d33e-4642-b0dc-87e377025825@gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <270ce534-d33e-4642-b0dc-87e377025825@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-02-20 05:45, Pavel Begunkov wrote:
> On 2/18/25 16:57, David Wei wrote:
>> Currently only multishot recvzc requests are supported, but sometimes
>> there is a need to do a single recv e.g. peeking at some data in the
>> socket. Add single shot recvzc requests where IORING_RECV_MULTISHOT is
>> _not_ set and the sqe->len field is set to the number of bytes to read
>> N.
>>
>> There could be multiple completions containing data, like the multishot
>> case, since N bytes could be split across multiple frags. This is
>> followed by a final completion with res and cflags both set to 0 that
>> indicate the completion of the request, or a -res that indicate an
>> error.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>   io_uring/net.c  | 26 ++++++++++++++++++--------
>>   io_uring/zcrx.c | 17 ++++++++++++++---
>>   io_uring/zcrx.h |  2 +-
>>   3 files changed, 33 insertions(+), 12 deletions(-)
>>
>> diff --git a/io_uring/net.c b/io_uring/net.c
>> index 000dc70d08d0..d3a9aaa52a13 100644
>> --- a/io_uring/net.c
>> +++ b/io_uring/net.c
>> @@ -94,6 +94,7 @@ struct io_recvzc {
>>       struct file            *file;
>>       unsigned            msg_flags;
>>       u16                flags;
>> +    u32                len;
> 
> Something is up with the types, it's u32, for which you use
> UINT_MAX, and later convert to ulong.

Inconsistency is my middle name.

I'll fix it up.

> 
>>       struct io_zcrx_ifq        *ifq;
>>   };
>>   
> ...
>> @@ -1250,6 +1251,9 @@ int io_recvzc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>       zc->ifq = req->ctx->ifq;
>>       if (!zc->ifq)
>>           return -EINVAL;
>> +    zc->len = READ_ONCE(sqe->len);
>> +    if (zc->len == UINT_MAX)
>> +        return -EINVAL;
>>         zc->flags = READ_ONCE(sqe->ioprio);
>>       zc->msg_flags = READ_ONCE(sqe->msg_flags);
>> @@ -1257,12 +1261,14 @@ int io_recvzc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>           return -EINVAL;
>>       if (zc->flags & ~(IORING_RECVSEND_POLL_FIRST | IORING_RECV_MULTISHOT))
>>           return -EINVAL;
>> -    /* multishot required */
>> -    if (!(zc->flags & IORING_RECV_MULTISHOT))
>> -        return -EINVAL;
>> -    /* All data completions are posted as aux CQEs. */
>> -    req->flags |= REQ_F_APOLL_MULTISHOT;
>> -
>> +    if (zc->flags & IORING_RECV_MULTISHOT) {
>> +        if (zc->len)
>> +            return -EINVAL;
>> +        /* All data completions are posted as aux CQEs. */
>> +        req->flags |= REQ_F_APOLL_MULTISHOT;
> 
> If you're posting "aux" cqes you have to set the flag for
> synchronisation reasons. We probably can split out a "I want to post
> aux cqes" flag, but it seems like you don't actually care about
> multishot here but limiting the length, or limiting the length + nowait.

Yeah, it's still "multishot" because there are still aux cqes for data
notifications. The requested N bytes could be in multiple frags. I'll
make sure REQ_F_APOLL_MULTISHOT is set.

> 
>> +    }
>> +    if (!zc->len)
>> +        zc->len = UINT_MAX;
>>       return 0;
>>   }
>>   @@ -1281,7 +1287,7 @@ int io_recvzc(struct io_kiocb *req, unsigned int issue_flags)
>>           return -ENOTSOCK;
>>         ret = io_zcrx_recv(req, zc->ifq, sock, zc->msg_flags | MSG_DONTWAIT,
>> -               issue_flags);
>> +               issue_flags, zc->len);
>>       if (unlikely(ret <= 0) && ret != -EAGAIN) {
>>           if (ret == -ERESTARTSYS)
>>               ret = -EINTR;
>> @@ -1296,6 +1302,10 @@ int io_recvzc(struct io_kiocb *req, unsigned int issue_flags)
>>           return IOU_OK;
>>       }
>>   +    if (zc->len != UINT_MAX) {
>> +        io_req_set_res(req, ret, 0);
>> +        return IOU_OK;
>> +    }
>>       if (issue_flags & IO_URING_F_MULTISHOT)
>>           return IOU_ISSUE_SKIP_COMPLETE;
>>       return -EAGAIN;
>> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
>> index ea099f746599..834c887743c8 100644
>> --- a/io_uring/zcrx.c
>> +++ b/io_uring/zcrx.c
>> @@ -106,6 +106,7 @@ struct io_zcrx_args {
>>       struct io_zcrx_ifq    *ifq;
>>       struct socket        *sock;
>>       unsigned        nr_skbs;
>> +    unsigned long        len;
>>   };
>>     static const struct memory_provider_ops io_uring_pp_zc_ops;
>> @@ -826,6 +827,10 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
>>       int i, copy, end, off;
>>       int ret = 0;
>>   +    if (args->len == 0)
>> +        return -EINTR;
>> +    len = (args->len != UINT_MAX) ? min_t(size_t, len, args->len) : len;
> 
> Just min?

Yes :facepalm:

> 
>> +
>>       if (unlikely(args->nr_skbs++ > IO_SKBS_PER_CALL_LIMIT))
>>           return -EAGAIN;
>>   @@ -920,17 +925,21 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
>>   out:
>>       if (offset == start_off)
>>           return ret;
>> +    args->len -= (offset - start_off);
> 
> Doesn't it unconditionally change the magic value UINT_MAX
> you're trying to preserve?

Yes, you're right. I will fix this and add a test case.

> 
>> +    if (args->len == 0)
>> +        desc->count = 0;
>>       return offset - start_off;
>>   }
>>     static int io_zcrx_tcp_recvmsg(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
>>                   struct sock *sk, int flags,
>> -                unsigned issue_flags)
>> +                unsigned issue_flags, unsigned long len)
>>   {
>>       struct io_zcrx_args args = {
>>           .req = req,
>>           .ifq = ifq,
>>           .sock = sk->sk_socket,
>> +        .len = len,
>>       };
>>       read_descriptor_t rd_desc = {
>>           .count = 1,
>> @@ -956,6 +965,8 @@ static int io_zcrx_tcp_recvmsg(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
>>           ret = IOU_REQUEUE;
>>       } else if (sock_flag(sk, SOCK_DONE)) {
>>           /* Make it to retry until it finally gets 0. */
>> +        if (len != UINT_MAX)
>> +            goto out;
>>           if (issue_flags & IO_URING_F_MULTISHOT)
>>               ret = IOU_REQUEUE;
>>           else
> 

