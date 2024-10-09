Return-Path: <netdev+bounces-133863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 811589974E5
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D48B248A3
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11731C2DB8;
	Wed,  9 Oct 2024 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HJ2oOBgd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D981714A4
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498494; cv=none; b=GtVTbe6Bk2sQWQd1CW3yFih7FC/WdMy0DGosP6DSbeFwQKRIkiMH1A3jc8969YJP2Bc29e5bxGAcBFpD32U5Jj864jzhyT1KVgPjovApQYp3BLdV7BPoGDTN1Y889sYnEsTTLh3a2iwCF8nuF8BaCsUop3iXrB7EVjuKENB0RrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498494; c=relaxed/simple;
	bh=DlR5C3N8lf7Sd6QJ/PXzbLiO2dai4102AS6Ho0DrBfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mm0F13aPaaXxPtWWsvLW7a3KxhYb5M5s/h46OBubp4sTJ1YNDxBom6xwWnYbw6aDN9MHQOwG8bJvE/qXaA2C49wXBRWpzdajXXmGq2y6fZXyTWC8bXG5UzQ4JYCtqQ3NQu27uNFUZUg5dtAmD+oU2Z1U5yC7TJJjs4mt4344X6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HJ2oOBgd; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a0c8c40560so601345ab.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728498490; x=1729103290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6jtbe9EClknasbAeRY+gshgY/lQEX5MzFFXUzmJP/WE=;
        b=HJ2oOBgdXVeT1tzaAaZb/sc4nCz/q6GCZNyillrJc73NZOCrP3hZOjj0A2ookcMRIy
         +yiCmJwmZkktu0brJCwziog3jjBbycRLVRk7artffB2LPk/cJsf5YHEAtItZaObr0IhD
         1+ZeD4r2bOWmPQzTthk18e8KxruLNFZ7kW4rTvGHdW6I3yMRG7eJ/E3num4DCHw6lJIm
         Hx3WKPTCNT4RZBtPMibz7BdLsjasEO2Lzk7tlHHsEjlDB/eqCAQHu8o5yvl6E4NYL7Lf
         /a1AGwwjDeU0fAbANSCtqBvMq2TmC80b1wxyeCmSnpunuVGT1Y9VEoxQEas040oLknKu
         Zw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728498490; x=1729103290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jtbe9EClknasbAeRY+gshgY/lQEX5MzFFXUzmJP/WE=;
        b=By/+etLuVScbcH0vjX2kI3cNVvFm8ZALZGEcANhB8mIC0FNvsa+wAZj4F1O64sAmHx
         N99wEHWMBzPwgftElSASMLVxf7o5b2ARXU6JXm0x+gcDx4iXQ+OIGOdJMoBLBUY4I8aO
         Jt8xrmHCV1WA1GPp3QpxxXUOrpezK3C2S2X7N2LjOJBDt46CDQW59cSYZy64l6ockB9+
         ZewA8pXIdtt4C/RdAJRcbRVqqn/R0ImhScAdZw6Gihsn3fIi32yVkD0+XGh7x6qVRakx
         dxQvnF9reFUk3NoQKEV5awh6HiwfnCuimYantE9dwqzjyi4YteRBii/375dCl68xiT5I
         AJyw==
X-Forwarded-Encrypted: i=1; AJvYcCWeeVr9RzXgkF4IGAqdyUlblbP29rfiBVVF14uSkRL+6C5+RWnmoosbAGNEOl+ZD8Esie94nBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSYedUNXUTkgbUfhtePZY8+Ef0AwswFPFg3pRcHu3yFtZZobEq
	xySPhNyEfdqadsl/sqg15Rq2t8uKI905UGD0oGYjCHra1pFs/uhrYj/bOuDjmBY=
X-Google-Smtp-Source: AGHT+IGQrKens2QtTw8cd8USva5Ahs2lit+5Usqb34DUpy4X9GC3miEJvLbIhn70WaxdChPziQUhjw==
X-Received: by 2002:a05:6e02:b29:b0:3a0:9026:3b65 with SMTP id e9e14a558f8ab-3a397d2654emr41799835ab.25.1728498490259;
        Wed, 09 Oct 2024 11:28:10 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a39bdb7f5asm3877875ab.33.2024.10.09.11.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 11:28:09 -0700 (PDT)
Message-ID: <703c9d90-bca1-4ee7-b1f3-0cfeaf38ef8f@kernel.dk>
Date: Wed, 9 Oct 2024 12:28:08 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/15] io_uring/zcrx: add io_recvzc request
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>
References: <20241007221603.1703699-1-dw@davidwei.uk>
 <20241007221603.1703699-13-dw@davidwei.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241007221603.1703699-13-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> diff --git a/io_uring/net.c b/io_uring/net.c
> index d08abcca89cc..482e138d2994 100644
> --- a/io_uring/net.c
> +++ b/io_uring/net.c
> @@ -1193,6 +1201,76 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
>  	return ret;
>  }
>  
> +int io_recvzc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> +{
> +	struct io_recvzc *zc = io_kiocb_to_cmd(req, struct io_recvzc);
> +	unsigned ifq_idx;
> +
> +	if (unlikely(sqe->file_index || sqe->addr2 || sqe->addr ||
> +		     sqe->len || sqe->addr3))
> +		return -EINVAL;
> +
> +	ifq_idx = READ_ONCE(sqe->zcrx_ifq_idx);
> +	if (ifq_idx != 0)
> +		return -EINVAL;
> +	zc->ifq = req->ctx->ifq;
> +	if (!zc->ifq)
> +		return -EINVAL;

This is read and assigned to 'zc' here, but then the issue handler does
it again? I'm assuming that at some point we'll have ifq selection here,
and then the issue handler will just use zc->ifq. So this part should
probably remain, and the issue side just use zc->ifq?

> +	/* All data completions are posted as aux CQEs. */
> +	req->flags |= REQ_F_APOLL_MULTISHOT;

This puzzles me a bit...

> +	zc->flags = READ_ONCE(sqe->ioprio);
> +	zc->msg_flags = READ_ONCE(sqe->msg_flags);
> +	if (zc->msg_flags)
> +		return -EINVAL;

Maybe allow MSG_DONTWAIT at least? You already pass that in anyway.

> +	if (zc->flags & ~(IORING_RECVSEND_POLL_FIRST | IORING_RECV_MULTISHOT))
> +		return -EINVAL;
> +
> +
> +#ifdef CONFIG_COMPAT
> +	if (req->ctx->compat)
> +		zc->msg_flags |= MSG_CMSG_COMPAT;
> +#endif
> +	return 0;
> +}

Heh, we could probably just return -EINVAL for that case, but since this
is all we need, fine.

> +
> +int io_recvzc(struct io_kiocb *req, unsigned int issue_flags)
> +{
> +	struct io_recvzc *zc = io_kiocb_to_cmd(req, struct io_recvzc);
> +	struct io_zcrx_ifq *ifq;
> +	struct socket *sock;
> +	int ret;
> +
> +	if (!(req->flags & REQ_F_POLLED) &&
> +	    (zc->flags & IORING_RECVSEND_POLL_FIRST))
> +		return -EAGAIN;
> +
> +	sock = sock_from_file(req->file);
> +	if (unlikely(!sock))
> +		return -ENOTSOCK;
> +	ifq = req->ctx->ifq;
> +	if (!ifq)
> +		return -EINVAL;

	irq = zc->ifq;

and then that check can go away too, as it should already have been
errored at prep time if this wasn't valid.

> +static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
> +			      struct io_zcrx_ifq *ifq, int off, int len)
> +{
> +	struct io_uring_zcrx_cqe *rcqe;
> +	struct io_zcrx_area *area;
> +	struct io_uring_cqe *cqe;
> +	u64 offset;
> +
> +	if (!io_defer_get_uncommited_cqe(req->ctx, &cqe))
> +		return false;
> +
> +	cqe->user_data = req->cqe.user_data;
> +	cqe->res = len;
> +	cqe->flags = IORING_CQE_F_MORE;
> +
> +	area = io_zcrx_iov_to_area(niov);
> +	offset = off + (net_iov_idx(niov) << PAGE_SHIFT);
> +	rcqe = (struct io_uring_zcrx_cqe *)(cqe + 1);
> +	rcqe->off = offset + ((u64)area->area_id << IORING_ZCRX_AREA_SHIFT);
> +	memset(&rcqe->__pad, 0, sizeof(rcqe->__pad));

Just do

	rcqe->__pad = 0;

since it's a single field.

Rest looks fine to me.

-- 
Jens Axboe

