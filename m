Return-Path: <netdev+bounces-245270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA45CCA13D
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 03:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7BA7301EFBE
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 02:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C822F7AD2;
	Thu, 18 Dec 2025 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rGYQDKcQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBF21EF36E
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766024700; cv=none; b=T929b8HYheOVCrp+X4RqFp/mdfIhILfgLmfTDzdrDcjWhlH4Chbdop6bdzWZgHOZSqRLqJGVkjBm/IUrfXWJeESbIRgenfh9U0EEt5XrO1kj+itSlJi4CRXNgtLIucLZADP/0eqF7W/WFwo7oHLpvY/mChiefNLwhhe33g7Ovec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766024700; c=relaxed/simple;
	bh=q2/AOVQqFfFu2Othv1PTDVvgn6iCLxX9QkHI7dBq/6s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WEas252m02tAfSyxmgpu4OpY1AWoHG3QecXRFfcEzSgaqLU9jQictjtoh+/qOUMeVz2U+B2rOfp3O2TovXs1j8e6muWBLO1Q5X3MEvON41C3TMqf1t4O6DcAsH437dYcYlB3nUh1OxWge4yIx2nG7wwalMJLKs0f6L8TRX5iT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rGYQDKcQ; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7c730af8d69so79811a34.1
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766024696; x=1766629496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lbN2GZrogzd6ZoVf/l4oC+ehQnMHX6Enqblytpo7ffo=;
        b=rGYQDKcQPdc/Zq6ann4XEeOOzE8CXkTV8rWrK4p1MFpffU+xE6Y09jll1t9kgczgGN
         zk3UQDNySrR1t5oVBkFgESWuYzgCrEinRl4osrf/fYMVWJthjR2lK3nIXRj/diBjqBRo
         jl8+ryePhuj2tGxxbtKC3UmviguSAe5hHmlkKTe87f+nhZLisyuJb47t93EsCvUPgQcb
         c0ZshJzR10aJqy+yRSi01HnIMUUxGk+e8zjd6jm+g4rly6QYRyENOXzfC9vE5NrsT7La
         j3ICCnso3LoQ5HkEVyS70crzR6vAAoSSOFP9jVHkb7VOz0oQ6/Bfw0W/0kc7yc175P7O
         yb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766024696; x=1766629496;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbN2GZrogzd6ZoVf/l4oC+ehQnMHX6Enqblytpo7ffo=;
        b=GPdabvel752Eep7i9PjdY5QYViRkD9UqY0VNz6jFb8W2cOAWgefkZA/yUO9rgdn67d
         Li6Y8nO4k0bZInjcyT9ofUIVVdm5TsCxk9ZScqy81PUJfATBYtNKeq+aXY5ebWId0lUq
         If+o2ekSjSTzfJzLpTnvEJBkhz+trQw9957WB9k1fCTvMj1ceN/PMrGoBKvQftUfjJ5Y
         YJubRhINEvS4w1xO6KqYuSmSFuBM5cKCTowbow4mM+shJt2BiarjyIxPPvQp1lF5olp+
         /8Ts0A30YTxOC1G0avcQtbLzHpbyqQakpDs6GqcFxPzd7R9qeQ45wsJ3w7RY6hUDVV8K
         U8rA==
X-Gm-Message-State: AOJu0YwP3oRIleWtGzWa7dvhBYu+fXVYgMboaSm/U7ZgnAiXUy1Xl/69
	AMNM1gYoao5xbpkBdwsVCRWXpcvjFpLr3Bhv322Cz5sroe4c/VK07TK7Q+o+mhjGZusnXyZW5OV
	A5nG1eqL9GQ==
X-Gm-Gg: AY/fxX6brYRQUCpXhJu169lo2zyDDYsW83VsnvHrI6wWyP3Lgmc4IasdSjl+xF6mRvZ
	ZJkToays+LViduh9mw+9+FXc5p3hDrOfsISk6k5WtREx2IZCDSJPSPBsWWyBLp3msvQa+pjDy6F
	DU9tkr32O/BBBKsJ/wkRhjJh1B1HjsbxGbsI2fCEVc2MTdtutqH3UofuG4hHmLoaL6o068LOBns
	kmVE5kp5rvUM+ckPch9KLa2pUGd3vifBg7BsUrJZNHk4v4VcHq1antOJQiOADwmWCgmiWqnYfFs
	2ZvXj9l+v24M5FFGSBbHdWxaXfma4wQ5wfPcWd75TVDdYMssIHtxi6NnAtp1gh87ar4VI0NobGk
	HW0FQQLYwcMwcVUzropDExNUYn+bXcb66/4e7ZleyV76BGalQQcrc/x+/aOZmQXqAyZXfZH4dDT
	rWf/ewcdYl
X-Google-Smtp-Source: AGHT+IHru59lpPqzlvGXzgmyFGP7fEvQaY6UDPjGVSVy6vxz3iEEstCwYMUjK4gDkFpVUV0VR+Gi7w==
X-Received: by 2002:a05:6808:3505:b0:450:d1ba:151b with SMTP id 5614622812f47-455ac87b97emr8372432b6e.29.1766024695880;
        Wed, 17 Dec 2025 18:24:55 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17fc418fsm791220fac.19.2025.12.17.18.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 18:24:55 -0800 (PST)
Message-ID: <72a26b79-a469-4e6e-b0f0-92c72014e7fb@kernel.dk>
Date: Wed, 17 Dec 2025 19:24:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] af_unix: don't post cmsg for SO_INQ unless explicitly
 asked for
From: Jens Axboe <axboe@kernel.dk>
To: netdev <netdev@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>
References: <ca5fe77f-f7a8-4886-b874-0e7063622ab7@kernel.dk>
Content-Language: en-US
In-Reply-To: <ca5fe77f-f7a8-4886-b874-0e7063622ab7@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/25 7:19 PM, Jens Axboe wrote:
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
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
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
>  		}
>  	} else {
>  		scm_destroy(&scm);
> 

Note, on top of this bug, I also believe the correct check here should be:

if ((do_cmsg || msg->msg_get_inq) && copied >= 0)

rather than always post a cmsg (or pass back inq data) if the socket
read has failed.

Was going to post that patch separately, but can fold it into this one
as well. Let me know.

Also note that this is commit is actively breaking some io_uring uses on
streamed sockets, as you can now end up with multiple SCM_INQ cmsg
postings per socket with retries. These were not requested. So would
appreciate if we can get this one sorted out soonish and post for stable
too. It affects 6.17 and newer.

-- 
Jens Axboe

