Return-Path: <netdev+bounces-168807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D587A40D45
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 08:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C45E3ABBC1
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 07:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076D41FC7D5;
	Sun, 23 Feb 2025 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/G3YDKc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DEB1DC9AF
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740296224; cv=none; b=ojLLH2o47Deykoyjne0kPLZNEid1yWwqZdFtIECEt4NetltUJkJPvOR0SJd2mrjgRKYUaQLaLQhTjJJAICUsW/IaW6dPttaFruuZH3zNGV+spyq+sy/sx6EMgnUp8NOTsjgBz1blIyoCQT9/3AjFzQMhFofUJ5oFJOlT86cMmAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740296224; c=relaxed/simple;
	bh=wErTi4756Ynjumj/XyH5jU6b8LO5JVWVPhoAX6mvnDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDo022sJyGGlK8RfWi1jnfc5rQiD4vwLxcPv9cu6DHStaqBADOmmw6dzi6CWPK1jK+lsBQ87yF1ajUKq9eZKzVu6m1jALoBIohYJ9uw90exzsjtX7le1uaQSx4OzR/4llbS3KtNvUJELbaVRYjn/EaYRO6axmEgRwn2FpMLL8Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/G3YDKc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so6156311a12.1
        for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 23:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740296220; x=1740901020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8goVZQ95WyGU+2ZEZvM7AhD/4mdcpJhd77dwy4JYII=;
        b=J/G3YDKc+cBEN5MuNc8YHuqVDkCwzGd6Lrm3pwLKpkBSGvitkDrNjNxvoy8LD9/g5k
         yhsQtBy+evGNk3T46/m/ZVez9guOyIWad5PIqBySQ1vqYv5dDIlzaSvNcWEuWdD9t/vP
         pYHrAFIExKztEg1/x8PcwggU13Us7pp1swxjupMXp2+hYP3y4IbtB4BxEj6kZTRpJuXN
         viaIevm+pMoohrDOfqaywaIhMiKrhTiHWcjgtX/7TFQHj3xeTs1VnAk+/vug4lX58Ew6
         rm8slWkUx2fm/fpLGBOn3FYMQ4D3XzmJaj/tQ9CjzIsHFDy14+n1qn6dNftYad91JjII
         fNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740296220; x=1740901020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8goVZQ95WyGU+2ZEZvM7AhD/4mdcpJhd77dwy4JYII=;
        b=meA1UZXFkMldF5t9PVPfil6kG4XAzabBrNxj3NJM+lELzMf/iUbO1ZrxoTU3hZwlIZ
         m46tr6yTZGvsgayvBII6DU6WfN5j392MvS7sNg1xhuONWcIzkBz0j7Y1yYEy9P4biEcw
         WUmHsPTaFnMR5Wknz3ZeWMu1wbGDBJ9C89ttf0jj1a8qIuMzEqHD98i2p2aSZfpWVGDQ
         CG9zNm+9Q/Dg2jyPXKgRcGth5OdZRhljN16gydrPajLNB/KYb7DbLOnQfgG/Zmp3bVfj
         dFERqxM3zTdJjgpGoconAjuRUKdJCL28NOtAp33bCdmZgp1Kqc/T4EVhqnb1bShX8qjP
         +QYA==
X-Forwarded-Encrypted: i=1; AJvYcCW0b7d2WgA0WsKrQ+5HakZSQzBhx9AIUhP1JwAUxMrTVw4HtZ81To5JPgqrycl7bWCVuFulQVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJsON9nGjT+L6Q/T1pcjMK1FS6HT6j433nHXnswVi6N7lrKZC
	kJj0+v5+gFVF+8eK8AmvATfKpi5m11BiKhL5mTDuEOvIu4CKYC/lT1rA+4VgepKJotN9Z4DmIFC
	/XOgXWG46dHqu6AI2bvuCZK1vF9iXjum2Abbv
X-Gm-Gg: ASbGncugY8+zRzhA5nDecl3Rj6XN1IH+vQCrsQ7QksnxrHSsN5/yqrrvxq9dyvbGg9u
	LsySDX+pO2pkBpH/n61RQMBgqszyMN3vjK4/11SUgzhhpIWMA5qkO18Xm8zEPXYB5uo3Y6W7vbr
	CHHSYrdK8=
X-Google-Smtp-Source: AGHT+IHJAHo6n65GT48nDSDcLG1tHqaBenUUdZAbJqEJkFd2nwDXzXtAB6KeYT9LB2o8SHPWvs+dT8ECCdua9bOGGL0=
X-Received: by 2002:a05:6402:1f03:b0:5e0:3447:f6b7 with SMTP id
 4fb4d7f45d1cf-5e0b70e4cebmr7543654a12.8.1740296220091; Sat, 22 Feb 2025
 23:37:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222103928.12104-1-wanghai38@huawei.com>
In-Reply-To: <20250222103928.12104-1-wanghai38@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 23 Feb 2025 08:36:48 +0100
X-Gm-Features: AWEUYZkKvGc5WMjNlOKJij0qTrmTigftM57iXQWpByQ31Fz6enSlI53uTzAQfMk
Message-ID: <CANn89iJfnmsZHtcc7O1oQSutgC5m_Jrhkxy3EYeOxQnjz4wwUQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: Defer ts_recent changes until req is owned
To: Wang Hai <wanghai38@huawei.com>
Cc: kerneljasonxing@gmail.com, ncardwell@google.com, kuniyu@amazon.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, zhangchangzhong@huawei.com, liujian56@huawei.com, 
	yuehaibing@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 11:41=E2=80=AFAM Wang Hai <wanghai38@huawei.com> wr=
ote:
>
> The same 5-tuple packet may be processed by different CPUSs, so two
> CPUs may receive different ack packets at the same time when the
> state is TCP_NEW_SYN_RECV.
>
> In that case, req->ts_recent in tcp_check_req may be changed concurrently=
,
> which will probably cause the newsk's ts_recent to be incorrectly large.
> So that tcp_validate_incoming will fail.
>
> cpu1                                    cpu2
> tcp_check_req
>                                         tcp_check_req
>  req->ts_recent =3D rcv_tsval =3D t1
>                                          req->ts_recent =3D rcv_tsval =3D=
 t2
>
>  syn_recv_sock
>   newsk->ts_recent =3D req->ts_recent =3D t2 // t1 < t2
> tcp_child_process
>  tcp_rcv_state_process
>   tcp_validate_incoming
>    tcp_paws_check
>     if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <=3D paws_win)
>         // t2 - t1 > paws_win, failed
>
> In tcp_check_req, Defer ts_recent changes to this skb's to fix this bug.

I think this sentence is a bit misleading.

What your patch does is to no longer change req->ts_recent,
but conditionally update tcp_sk(child)->rx_opt.ts_recent

>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
> v1->v2: Modified the fix logic based on Eric's suggestion. Also modified =
the msg
>  net/ipv4/tcp_minisocks.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index b089b08e9617..53700206f498 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -815,12 +815,6 @@ struct sock *tcp_check_req(struct sock *sk, struct s=
k_buff *skb,
>
>         /* In sequence, PAWS is OK. */
>
> -       /* TODO: We probably should defer ts_recent change once
> -        * we take ownership of @req.
> -        */
> -       if (tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq, tcp_rsk(re=
q)->rcv_nxt))
> -               WRITE_ONCE(req->ts_recent, tmp_opt.rcv_tsval);
> -
>         if (TCP_SKB_CB(skb)->seq =3D=3D tcp_rsk(req)->rcv_isn) {
>                 /* Truncate SYN, it is out of window starting
>                    at tcp_rsk(req)->rcv_isn + 1. */
> @@ -869,6 +863,9 @@ struct sock *tcp_check_req(struct sock *sk, struct sk=
_buff *skb,
>         if (!child)
>                 goto listen_overflow;
>
> +       if (own_req && tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq,=
 tcp_rsk(req)->rcv_nxt))
> +               tcp_sk(child)->rx_opt.ts_recent =3D tmp_opt.rcv_tsval;
> +

Please split this long line.

 if (own_req && tmp_opt.saw_tstamp &&
    !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))

