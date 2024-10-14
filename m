Return-Path: <netdev+bounces-135205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2899CC3F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195DB1F23A79
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC1D1AB501;
	Mon, 14 Oct 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+O7Pu0k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935731AAE0B
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914752; cv=none; b=dG0yLzjfKGp5iGBqq8hzkG1BceSf8iX/2Ephqm+4qGI6lJbibtF4fn/khrerqSVXrCKd5lPxG+u/FI5w+gHRhqGmBo5vqDIuY5p3ZEeqfPH5eo5/LoraGoxMnNxnaSIi5fT62UpuHOzTVtxOv8CQkOZ902naeQO6vCYCaWYScts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914752; c=relaxed/simple;
	bh=6fPO77+EzGyxw6f4+GGwtN86sfvVHsrqTxSXRjTcGDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3sil4aDWMx9biyY2azCSY3V0/8ROFrCB99z0q+jgx4ub7YEF1AR006rr6iepvSuShxzfUfCLKD+XAy1KWXbIECAO2C6loqQePwYFoOSDKkGQpfTljm2Oq+xAhBcp5FbwAX+RYNsdXhg6U22rWEbTdtxoXp38Ef5uuVtm2IC/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+O7Pu0k; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b111e086e0so353815785a.0
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728914749; x=1729519549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nau8PqkOFeGKHjfoj66fq488F8cJu4VGD9OWnUV5d4=;
        b=S+O7Pu0k3kIZ/GmO7ayv+K7SvWgmyOX4VEjhY3EUrdbwA+bwjUXkmli7XAayea0oBd
         E/lY+iJuuYBRnxrGC69WUeNhpsDwt4ndSn/neQy+B9xscJlR99QGLavGNYKVRh5UuT6W
         5YHk8OL/lQEwzKtNbSjkRrcYNSXOW+N6rZng7o1hFoRetTdrYEYJqEa19s/11GZAAGWe
         B9ZZNURN0YG7pEt70onnkS/GzSEHZHNzxszekfoeQbs4xhXA7Rawd0anuohDrm0RgPaG
         pK7sO3KH5pjyScEfFmoRiknjcR+WYRaCL4W6uJ7zlZ5dx/7nx1QmsPhE5EgmMjPhI4V+
         2lzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728914749; x=1729519549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nau8PqkOFeGKHjfoj66fq488F8cJu4VGD9OWnUV5d4=;
        b=ULY451UZNnYdCbhxg/0x6QGWoHF7hG5to1ysoNxwQib3PRm+fAbxvUW2tW2ELrjQlJ
         i/IMkWQAFTS98F+zP7DP1ORM+iAwkMyjueWmHYHQq6qfiQXpImv5nWw+mIkMzJD3ldnL
         oN58k61Y371/3EhwVs7d/Wudr5ilwjREaOPtDXc6CBiWDi+85xCllZ7pEDtGxdbK7jK3
         f/eB/4bkwO0KKbQudWcnOgSQc+uCiE3kBfGKMGpH2xWWX8WLqGMV2PaARqpexaMN+/gJ
         Vs3Obau28jBPzvTeyPfOZOFpqgd33Bvgulhb7Sznb9Pvnxpc1TCtv/sbVzqUfpwF03W2
         K8Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXiTyO3aKmlxNIG6e1aWCfWcySAOR6DkkG0p4zEPMZVRzeSCgTsZ6piOYvu9rL/mF2r+ESVi3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcE++GFBJg51WYFq379XOClOUWevrm7YdFwt6Qcw+D0p//lpm1
	hQLGeSwpVLWP8WOGtusrsEwgiZTiGTLRym98+O1exy3HbR/fIrjsXJ+Dxwicidgls7oV4aLaE5k
	r24FMcBP19xW8PuGOikKGplqJbUaeto6t/tvFUH1VXCo6zeo8+sir
X-Google-Smtp-Source: AGHT+IGcGD8y2As5viTGaZXTCqPW/ozU/b3qHUJYOHBSlckPl+EM5MWHrKfDvD0ADkU5DdgNnB/ZKWCw1pOKeNQMCYU=
X-Received: by 2002:a05:6214:460b:b0:6cb:e813:523a with SMTP id
 6a1803df08f44-6cbeff75306mr169781126d6.4.1728914749252; Mon, 14 Oct 2024
 07:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com> <20241010174817.1543642-3-edumazet@google.com>
In-Reply-To: <20241010174817.1543642-3-edumazet@google.com>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 14 Oct 2024 10:05:36 -0400
Message-ID: <CAMzD94SDZueOVkm+X7Lowfy700rJQtBKUcpzxUArRLLbVNNknA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/5] net_sched: sch_fq: prepare for TIME_WAIT sockets
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:48=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> TCP stack is not attaching skb to TIME_WAIT sockets yet,
> but we would like to allow this in the future.
>
> Add sk_listener_or_tw() helper to detect the three states
> that FQ needs to take care.
>
> Like NEW_SYN_RECV, TIME_WAIT are not full sockets and
> do not contain sk->sk_pacing_status, sk->sk_pacing_rate.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Brian Vazquez <brianvv@google.com>

> ---
>  include/net/sock.h | 10 ++++++++++
>  net/sched/sch_fq.c |  3 ++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index b32f1424ecc52e4a299a207c029192475c1b6a65..703ec6aef927337f7ca6798ff=
3c3970529af53f9 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2800,6 +2800,16 @@ static inline bool sk_listener(const struct sock *=
sk)
>         return (1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV);
>  }
>
> +/* This helper checks if a socket is a LISTEN or NEW_SYN_RECV or TIME_WA=
IT
> + * TCP SYNACK messages can be attached to LISTEN or NEW_SYN_RECV (depend=
ing on SYNCOOKIE)
> + * TCP RST and ACK can be attached to TIME_WAIT.
> + */
> +static inline bool sk_listener_or_tw(const struct sock *sk)
> +{
> +       return (1 << READ_ONCE(sk->sk_state)) &
> +              (TCPF_LISTEN | TCPF_NEW_SYN_RECV | TCPF_TIME_WAIT);
> +}
> +
>  void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);
>  int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len, int=
 level,
>                        int type);
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index aeabf45c9200c4aea75fb6c63986e37eddfea5f9..a97638bef6da5be8a84cc572b=
f2372551f4b7f96 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -362,8 +362,9 @@ static struct fq_flow *fq_classify(struct Qdisc *sch,=
 struct sk_buff *skb,
>          * 3) We do not want to rate limit them (eg SYNFLOOD attack),
>          *    especially if the listener set SO_MAX_PACING_RATE
>          * 4) We pretend they are orphaned
> +        * TCP can also associate TIME_WAIT sockets with RST or ACK packe=
ts.
>          */
> -       if (!sk || sk_listener(sk)) {
> +       if (!sk || sk_listener_or_tw(sk)) {
>                 unsigned long hash =3D skb_get_hash(skb) & q->orphan_mask=
;
>
>                 /* By forcing low order bit to 1, we make sure to not
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

