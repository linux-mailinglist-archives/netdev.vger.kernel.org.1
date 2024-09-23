Return-Path: <netdev+bounces-129325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E51497EDD5
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB3C1C213E4
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8255F199FD3;
	Mon, 23 Sep 2024 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i1t6kIfh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9E819CC09
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104333; cv=none; b=JgjKvFX2gk+g1mtzYQyZY130+oJHfowfNyxNmVHqov5TIYqHhfJ7Ha50mvzctyQyGY9gne4AmZ/rbo6aYmXOcefNnLXKobdD2sM8OTiuHDCvRJKzLBAL5a19caeVCyxTSjIjYTLVAhdj57eZoIFRUIG8pDW8Gxd38U0XpoLVnwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104333; c=relaxed/simple;
	bh=dcOMDd7mee95UGije5TC8WrTFGVb1+c+/xbcP1DjM8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2i8RCM7+PpmW8jHB3kM4FHmsqtmjOBkJr0mdslaS0//Z9WgbIjwOBFmBvE3eaykkSDrwIJ4Vqpr8NyYsbcuqRDktQ8isCVEJ5K/BbKf32cwXwImA+i/jhIezdCYy5vqvcAYtp54b5+Z49TSxm0MlUSDpC87M8S8WOKCqpTMV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i1t6kIfh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c24c92f699so4457849a12.2
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727104330; x=1727709130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe+ySTQB1+4cX2xK7FvmZ7DSinfI+1IXb6ME192/krQ=;
        b=i1t6kIfh7hBJJ+lNC6ODzRyOfPm0/Rjmjpiji8G0paQK7r9OaPBZcIoZRCqbVVL0AG
         tybb4UILlQu5TcjDdy+P+WgHIOTtd/JAslzEi8Cvn0WquU9VyKs4aiapKlDGblhv50pu
         p6DIrBgLJflMEHluTdfYtvJhBG/taxmkjwainF9GqIeRUrL+zVafv6ScuAdFgjVklSg5
         wKkRb8+fjUhDYkXN/pQOn7xT4vSHlfUaK9K1Ult9LxfR4V9N3CuLkunlB6M8FR54mBfN
         FEfhpBI4HqP6xJB7XAoHMnUuxwk4M8Yu1tGdV9pc0MTiMwMAmehl5CKd3UZH7KtXqSdV
         4mOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727104330; x=1727709130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qe+ySTQB1+4cX2xK7FvmZ7DSinfI+1IXb6ME192/krQ=;
        b=tvac1rFo+XBA8V9vH1jFLbMobfn0znrSJFtAmai0mU4Gedd3NJUxmVLGgDbxn324AX
         j+F3BCXXhQOEUVY39lPRkZN0pjvC3bSTrZlndUTKLPRINkV4DyNI7uu9EQE6WI7reUzi
         DhHiwi8lBicprlH3rptXl+t7ZyPm39RmxGRzOF47l65TeArSXX2UFyOi1zcX+aSWqCQY
         7LvLS3ic7gcEpRjcWJLzfbeHK6IyGPaBqjrk3kFSQulfezgaAvhH5A7zX5xpZiC25p6D
         WIfobUfoEgtCAND+HDm4OMJP1XnK0WMuful08NPgyJY18PEw98z8Pj7bYNQmvhVutvNH
         dT0w==
X-Gm-Message-State: AOJu0Yww5qbJMl7brj5JS2CFkwbU6to4bvLeU0FQyReuAAOyBMELOwT4
	1HCcRfTTmyC8vEYTtR0mnUZtwFQX5kNmQJf4KIasqE1iY+BYNTYcr3ikjFRo1mNH8qdGQpRmhww
	iAoLX7s8CGkvgqzCRxN9anzlgLQSnskUMBQIx
X-Google-Smtp-Source: AGHT+IHwwKGK9sYHlMIZUVAAs01tSifbciyvuskPRyE0loriFYLyd+PsmH+ZfUCMAb1G7MWOm/vEwn9xPd03cNEgqtI=
X-Received: by 2002:a05:6402:234e:b0:5c4:2b0f:fef7 with SMTP id
 4fb4d7f45d1cf-5c464daabfdmr11831651a12.4.1727104329639; Mon, 23 Sep 2024
 08:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1727103691-29383-1-git-send-email-guoxin0309@gmail.com>
In-Reply-To: <1727103691-29383-1-git-send-email-guoxin0309@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 17:11:55 +0200
Message-ID: <CANn89iLLe1-XxnqDqZbJZGmCGypFVf_22o+ZYqBkXX4cRgN8FQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: remove unnecessary update for tp->write_seq
 in tcp_connect()
To: "xin.guo" <guoxin0309@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 5:01=E2=80=AFPM xin.guo <guoxin0309@gmail.com> wrot=
e:
>
> From: "xin.guo" <guoxin0309@gmail.com>
>
> Commit 783237e8daf13("net-tcp: Fast Open client - sending SYN-data")
> introduce tcp_connect_queue_skb() and it would overwrite tcp->write_seq,
> so it is no need to update tp->write_seq before invoking
> tcp_connect_queue_skb()
>
> Signed-off-by: xin.guo <guoxin0309@gmail.com>
> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 4fd746b..f255c7d 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -4134,7 +4134,7 @@ int tcp_connect(struct sock *sk)
>         if (unlikely(!buff))
>                 return -ENOBUFS;
>
> -       tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
> +       tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
>         tcp_mstamp_refresh(tp);
>         tp->retrans_stamp =3D tcp_time_stamp_ts(tp);
>         tcp_connect_queue_skb(sk, buff);

This seems fine, but net-next is currently closed.

Documentation/process/maintainer-netdev.rst  for the details.

