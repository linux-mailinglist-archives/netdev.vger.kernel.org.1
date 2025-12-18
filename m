Return-Path: <netdev+bounces-245442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D560BCCD8A5
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 21:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86111301C902
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 20:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CB527E05A;
	Thu, 18 Dec 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVxV79I6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF64238D27
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090122; cv=none; b=P+mpinlfCJyA/skjkxDGP/d/Ff/RFmr0cqCiEx+u0rvN6+Jc9t6TgXvXX8wrUP65mocJUJ+nOskNfbls1QR2yNb0TBXPDXagtScgNhwXAxZtGblmwWXkxUhf9oUWgJe6ZeiVffy6EXMnXW6B1mWVX9sK0nqZr9x9WWZ8xw46MYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090122; c=relaxed/simple;
	bh=SV/yxfA6ffFKpwbHoj2MuZU5tIDRHrG3GNh8PCpiVG0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Dv6GNZ2yxc/XaAXSJiHMdCF4RDGZtYs7xAqZVZduwEyeVhagY7xt+WRrpesfgl7U1DJiMEjEVheyfzPUUN0KAg555Pz/LNJZHHUVUTVnGVtFMfSMprZCXHCwbah7zrFcLPrd2mS2lgzTaNqsNnn5mya1Nuz98BijZ058Hx/qz+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVxV79I6; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64471fcdef0so830717d50.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 12:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766090119; x=1766694919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0/cZFBKqjjJFvInhQlzAavQ+9hRc0yhLfJNykw1dYM=;
        b=jVxV79I6hdgdTcTPA2YTIW5LM6U8g9jLKTGMf0qbspazzS14PYSFKb63rNmYB5iyso
         B4ZwbnsHAxp8hxjDtG3kaO+1ulpadHG31BfqcF4GjuQrFR138QDl4aYFp+lZfq+jnXf7
         aHJk5hKmobeBgizu0veatAdaF5FV47Pm9acHyF6O1J97DdDaREPMSMS4KnE7/itlxyd8
         irfS1+wCzcMFZnJ2aS7Cb9UbMCB6pNGOqaOGsna+0yndq/Aekvkb/PVlXf1tpV9/k7QJ
         0bAdRiZ2xuen8fvkWe8nlzPpX1RX3tk33S3gMPeEwVDodZ/pN7uEUfj0O8jEejAH1+CM
         D4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766090119; x=1766694919;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0/cZFBKqjjJFvInhQlzAavQ+9hRc0yhLfJNykw1dYM=;
        b=GjI4mdCQgSeyI2NBvcY4chrvtfdsI3ybyFD3Rfu5JbvH7KmYTgH6a+dGkkFy2rOWzT
         Db+0SVSn0z83IHQ8fLOpupUXZQAKlhebhkBUm887SHxTyc/ViOjfwedhjoMXfeMDqH2v
         fw9I215Ncwo4obfht7u1v83xUjv0sZXHRixO5RA5d/QOaxysgpe03iPCt+vUDYvxbQjf
         W0/WegsAJD59YpeyWpmWuqjp5lbcz3fhAqCyomGg7ONn1y4MBNb3SXqDO1HuOjze6AcA
         rbkH+OksBuwIetL7S1CvzFcbVWdoXG5EcIuMv6Vl04T80Y6s892n0FxNFNHwBDEQ0T42
         S91Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3nR8YIr2rdvG9DCktTdJ0DNkRrYxWBn+lMFvLU7ZSUbCOCn7RGwtc5lr/79tv5NUi9ZsjILE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXwjFDfWRG3/Qu+nLHJpSLXOg/iq8csetEv7h1utq9KA4pSELl
	IfOA52i82tiw/5+Kp+2jFOb2w/oI0HTDkEi9GddiVbA1qHvb/+EpskReqYbkqo07
X-Gm-Gg: AY/fxX7yJg6alnCUq8vVxX6sKMFU2dqG4YJqV4CNqOGo0rNKX9ua+JpbIQ18ByfyXkc
	5GaTmSyoV5tqqL2c596+U5JW25ctPJnRyJsgZyejr4biuvrbd8msrY+OSpRM0U9FfhJt1Mikdh2
	s5XQN4mLuauU+ohQD2S9Wm7lsSL3VKKVtAn32sgT9InawcwKQgAYous3fhnT1gpDS1yAeVOo3AC
	vbH5TGxO8sRgARCkih6OJvu6FGmdnDPp3x7oxmkV9ta1drwk79gY50lAU1KvbuliO+xNgdL8Gni
	XwUtc/D8rH6i1tNPzmIr3YwB7UFuNalTuq/eR7OTBa5mgVJXaqjaRTkEjoPN8m5vkHbSCIOGUN+
	4EuHO3/hghYUNNa+kmCQGLzrYXr8ZUdCUeUUbRl+n61YBRCaWROwvNt5t4wvRBghpfLKHKX82ip
	O1UQ7KNJT1ybh6R02+K2VJVjSGxiydvXOekmhEzIm7vfHiymX2c0W2sfCN+Njn8kNetfWtMZDZm
	5pMiw==
X-Google-Smtp-Source: AGHT+IE/PTz7lwoVk2d92IkLpCT58pSQHfpqtjhEn+V5RE7UzfgDmzH8g5VVaZONxYWcBA3jIdntKQ==
X-Received: by 2002:a05:690c:6e06:b0:787:e3c0:f61f with SMTP id 00721157ae682-78fb40915a6mr11136217b3.57.1766090119475;
        Thu, 18 Dec 2025 12:35:19 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78fb43bb8d9sm1751087b3.20.2025.12.18.12.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 12:35:18 -0800 (PST)
Date: Thu, 18 Dec 2025 15:35:17 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, 
 netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org, 
 kuba@kernel.org, 
 kuniyu@google.com, 
 willemb@google.com, 
 Jens Axboe <axboe@kernel.dk>, 
 stable@vger.kernel.org, 
 Julian Orth <ju.orth@gmail.com>
Message-ID: <willemdebruijn.kernel.2e22e5d8453bd@gmail.com>
In-Reply-To: <20251218150114.250048-2-axboe@kernel.dk>
References: <20251218150114.250048-1-axboe@kernel.dk>
 <20251218150114.250048-2-axboe@kernel.dk>
Subject: Re: [PATCH 1/2] af_unix: don't post cmsg for SO_INQ unless explicitly
 asked for
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:
> A previous commit added SO_INQ support for AF_UNIX (SOCK_STREAM), but
> it posts a SCM_INQ cmsg even if just msg->msg_get_inq is set. This is
> incorrect, as ->msg_get_inq is just the caller asking for the remainder
> to be passed back in msg->msg_inq, it has nothing to do with cmsg. The
> original commit states that this is done to make sockets
> io_uring-friendly", but it's actually incorrect as io_uring doesn't
> use cmsg headers internally at all, and it's actively wrong as this
> means that cmsg's are always posted if someone does recvmsg via
> io_uring.
> 
> Fix that up by only posting cmsg if u->recvmsg_inq is set.
> 
> Cc: stable@vger.kernel.org
> Fixes: df30285b3670 ("af_unix: Introduce SO_INQ.")
> Reported-by: Julian Orth <ju.orth@gmail.com>
> Link: https://github.com/axboe/liburing/issues/1509
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  net/unix/af_unix.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 55cdebfa0da0..110d716087b5 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -3086,12 +3086,16 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>  
>  	mutex_unlock(&u->iolock);
>  	if (msg) {
> +		bool do_cmsg;
> +
>  		scm_recv_unix(sock, msg, &scm, flags);
>  
> -		if (READ_ONCE(u->recvmsg_inq) || msg->msg_get_inq) {
> +		do_cmsg = READ_ONCE(u->recvmsg_inq);
> +		if (do_cmsg || msg->msg_get_inq) {
>  			msg->msg_inq = READ_ONCE(u->inq_len);
> -			put_cmsg(msg, SOL_SOCKET, SCM_INQ,
> -				 sizeof(msg->msg_inq), &msg->msg_inq);
> +			if (do_cmsg)
> +				put_cmsg(msg, SOL_SOCKET, SCM_INQ,
> +					 sizeof(msg->msg_inq), &msg->msg_inq);

Is it intentional that msg_inq is set also if msg_get_inq is not set,
but do_cmsg is?

It just seems a bit surprising behavior.

That is an entangling of two separate things.
- msg_get_inq sets msg_inq, and
- cmsg_flags & TCP_CMSG_INQ inserts TCP_CM_INQ cmsg

The original TCP patch also entangles them, but in another way.
The cmsg is written only if msg_get_inq is requested.

	-       if (cmsg_flags && ret >= 0) {
	+       if ((cmsg_flags || msg->msg_get_inq) && ret >= 0) {
			if (cmsg_flags & TCP_CMSG_TS)
				tcp_recv_timestamp(msg, sk, &tss);
	-               if (cmsg_flags & TCP_CMSG_INQ) {
	-                       inq = tcp_inq_hint(sk);
	-                       put_cmsg(msg, SOL_TCP, TCP_CM_INQ, sizeof(inq), &inq);
	+               if (msg->msg_get_inq) {
	+                       msg->msg_inq = tcp_inq_hint(sk);
	+                       if (cmsg_flags & TCP_CMSG_INQ)
	+                               put_cmsg(msg, SOL_TCP, TCP_CM_INQ,
	+                                        sizeof(msg->msg_inq), &msg->msg_inq);

With this patch the two are still not entirely consistent.

>  		}
>  	} else {
>  		scm_destroy(&scm);
> -- 
> 2.51.0
> 



