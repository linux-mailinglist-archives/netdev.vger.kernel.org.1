Return-Path: <netdev+bounces-247151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF01CF51B2
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C94A31357DE
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE2131ED65;
	Mon,  5 Jan 2026 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2l6UzjnX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC533D4F9
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635079; cv=none; b=bWxbJDHR5FlqpSA/G6qPM2T71vg5tomrRXrGv6evjAbPoHzow616dQqLq6G6/f+Ed/nFsjwo6JsRw2iwfYdzZNmuyC1rtA1P2NPnz1bNYoYkL5upp2y/D87wYExUH0/Fn1b3SgTdHYnBKnKYN7fPbM6acnNh4aIrDb+fBrsxGTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635079; c=relaxed/simple;
	bh=hPJbDaXUwn6+S4UogOPljRu1DWljmyRCCvAdJdLC0qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EB4E+Kz2W4iI5rF95H2PTZpPQ8CuEbFxXG+uC4Jt80ubAhkMJnWv8xHKU3r0rLHdPoi0iNZM5xZpksDq6wHmYVlpNiclC21zl6R1FKLsMRdy9W+b87TDiaZdzKEg/jR++qnTct7vXnbRhiHcC6fwTyuz5ju1yF1NN3CcDPlSUGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2l6UzjnX; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3ec96ee3dabso133804fac.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 09:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767635073; x=1768239873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uA5IvrpLmM313YIb38ib/rrfho7f35fE5FlmsQpABeg=;
        b=2l6UzjnXmd8j9iiuxoh4wGpE1gNfaxtesg9MbDZI+9UVTnQdFwAi0W3lSE3ljByAEj
         m+tbFiop+LiQJnVjdatye5Cdee4m5gRSTaY27M1F90v3u0BIe0TxgL1z8UeoaOXLhk+K
         CQALa4IIEG5maDwxr+6L2qiA+TEx02/IL/GXZcICdhhpAMfkKT/KKZAURJvth1oKNJAU
         lmwLXKf5Hay/MXfHY9Ul4oLzh+Aa/oyAZZeBJI1t4jKUZcNNcwctZlYEm6Vqz/ilW3K8
         pdTEDxAGK8TpNl1g+/6QbNkRDWBQvJocVbUA9c8H0AYISmCTXEsitXCSakSWPJC6lnzu
         hy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767635073; x=1768239873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uA5IvrpLmM313YIb38ib/rrfho7f35fE5FlmsQpABeg=;
        b=oR/Xb0udOzLWg55DIuZi/H/tY025o0MQtqEuFThxfj1F3CJrJOMPXY8pFFAVyO0zRT
         d1QnomoGXbV3Xr/OkATMrMAVa5wDtlzLzhpiahqXc/SmNNfPpAxaCXI9cHFHLMPvzOav
         sgH1baw0lyTnkTeeDPPkWQPGw7+PL/Wc1Jd0NX2f8y2mes3WpfiwJr4dnYvFQOzJsdaH
         CujpLiHb5wndjh/zRy2x236qv321TNIRPfOV/nR7E6F2MsTXHtypPaQNZMshuHyI6gBr
         mDISxN3rsQsd/HYjQ41HSvIaWkzSimENGR9Xfolv0NKhTHlX+Kmir6DIW3oT2IW2mQxN
         S+hA==
X-Gm-Message-State: AOJu0Yx/oxN7bCZ/IH3BCafr0vCF58/SDTVLk1pnxKhAVPCbWfcRIXcR
	HYELL0tqdEoc9YL9IzDBNYpvFV8zVOtzocnFMWxgIMtsEDn3CCkgNzwdTWOrqpaf5KWVK0hXcOs
	9wx+H
X-Gm-Gg: AY/fxX6Z3wry3N7iQGRXrpOCIxlaW53M765oZYY3ZBI5o7dYnjjIO+3bci8rpTLIY9d
	wynVKxADaibWoPB+JFscTfCcYBclMN3Z30L5R1N8zuZEK0pPH86+Rcmctc4qRRfez1JbmcsIOAx
	/vZhnqgwlpNV++CA05zRizDLyzoUmhcpBmj57DrqCA0/1fZKcqZRZ1Dmmf9znpCmoshQuBU0zOd
	z0OZCKFZZbg5goZ5I8/ZaxVYLyoMpQpH/zs/O1pxgHz+NlmsQUekzH+Nkc7leD11xZTK5f1Qrhf
	5u05/49UnsuirO5GWyvzoJMufhH5wWxSGLllXdHOIqdJFiMshX3ReDHi02vqeo+leM0EagtMPgv
	rOW6b+3893rRrWCMnfPNFsQdpHiWJYvL5Y/1Kk3Mj7XW7JSyQFaJuz3PQzM9c/fF7EfctqROw1y
	5HhhMs+nSy
X-Google-Smtp-Source: AGHT+IFzphEV/+E3/qSvu5CiAOMeAiv/SQ8UP15NHxQELCgVQkuLmtYudu/y3WEWDUbBBi5pxtCLBw==
X-Received: by 2002:a05:6870:f116:b0:3f5:5af:c9d3 with SMTP id 586e51a60fabf-3ffa0dc0cdcmr105743fac.52.1767635073328;
        Mon, 05 Jan 2026 09:44:33 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa03b7a71sm137654fac.20.2026.01.05.09.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 09:44:32 -0800 (PST)
Message-ID: <5ce5aea0-3700-4118-9657-7259f678f430@kernel.dk>
Date: Mon, 5 Jan 2026 10:44:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: do not write to msg_get_inq in caller
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 Willem de Bruijn <willemb@google.com>
References: <20260105163338.3461512-1-willemdebruijn.kernel@gmail.com>
 <CANn89iL+AuhJw7-Ma4hQsgQ5X0vxOwToSr2mgVSbkSauy-TGkg@mail.gmail.com>
 <willemdebruijn.kernel.2124bbf561b5e@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <willemdebruijn.kernel.2124bbf561b5e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 10:42 AM, Willem de Bruijn wrote:
> Eric Dumazet wrote:
>> On Mon, Jan 5, 2026 at 5:33?PM Willem de Bruijn
>> <willemdebruijn.kernel@gmail.com> wrote:
>>>
>>> From: Willem de Bruijn <willemb@google.com>
>>>
>>> msg_get_inq is an input field from caller to callee. Don't set it in
>>> the callee, as the caller may not clear it on struct reuse.
>>>
>>> This is a kernel-internal variant of msghdr only, and the only user
>>> does reinitialize the field. So this is not critical.
>>>
>>> But it is more robust to avoid the write, and slightly simpler code.
>>>
>>> Callers set msg_get_inq to request the input queue length to be
>>> returned in msg_inq. This is equivalent to but independent from the
>>> SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq).
>>> To reduce branching in the hot path the second also sets the msg_inq.
>>> That is WAI.
>>>
>>> This is a small follow-on to commit 4d1442979e4a ("af_unix: don't
>>> post cmsg for SO_INQ unless explicitly asked for"), which fixed the
>>> inverse.
>>>
>>> Also collapse two branches using a bitwise or.
>>>
>>> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.24d8030f7a3de@gmail.com/
>>> Signed-off-by: Willem de Bruijn <willemb@google.com>
>>> ---
>>
>> Patch looks sane to me, but the title is a bit confusing, I guess you meant
>>
>> "net: do not write to msg_get_inq in callee" ?
> 
> Indeed, thanks. Will fix.
> 
>>
>> Also, unix_stream_read_generic() is currently potentially adding a NULL deref
>> if u->recvmsg_inq is non zero, but msg is NULL ?
>>
>> If this is the case  we need a Fixes: tag.
> 
> Oh good point. state->msg can be NULL as of commit 2b514574f7e8 ("net:
> af_unix: implement splice for stream af_unix sockets"). That commit
> mentions "we mostly have to deal with a non-existing struct msghdr
> argument".

Worth noting that this is currently not possible, as io_uring should
be the only one setting ->recvmsg_inq and it would not do that via
splice. Should still be fixed of course.

-- 
Jens Axboe

