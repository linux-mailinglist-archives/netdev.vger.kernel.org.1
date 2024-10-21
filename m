Return-Path: <netdev+bounces-137352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5305C9A58F9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 04:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B9B1C210DA
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 02:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEBF2030A;
	Mon, 21 Oct 2024 02:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfuT9TCH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE86347C7
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 02:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729478287; cv=none; b=UhFwUw/lRcsTsihN5pRLhKPM8MoxKA8NnWEt7b/CCxBNqIKisGQcC7bnrRhE2hKeC6RajFz7EQlKX2sVY+pLpu+ivFZVul7boVpEPuhXsKC30myQedJ3L0z3QSwU5nWMEwUCq3hr1+vG1ANhIipfcgdfjrdVQejCExPeVrwn+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729478287; c=relaxed/simple;
	bh=2QBcb1zKoy6oeZMi9qiu2KzvCBJinh7RFbYThfC1g/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CORChrT7d9W/gWkSZGEw9ZUALsiwHL7ivWRvr1Mt8aGTCeMRzoZeo0JnqCkF0ltThUQHv3fxYOMch3a/h/N6yL8dqOlAYuQw4IptCT3dc0Wv5MahqV5Fq87HHh0ObPCfs6xtEj89EZfydYGbdccQprXLgPe3nm4Ain6DITtNGo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfuT9TCH; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83a9be2c0e6so168961039f.2
        for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 19:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729478284; x=1730083084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSRDUJE2sN+JOhUsMJh13VEW5h0PQQtkvxqT2sfTDCY=;
        b=SfuT9TCH1rM3F/+tNOEQpzLYWXGeOD48+ditZAFjgKQ33O4sCCa4wvqIqNFuL+Uq8O
         3DrHK+MMxmv3jtHI32bRR3xOgEZd077n4B0iJNSvqE5PgIIhDmStM0KzcdK/ExCfx7RP
         dUFEtIEIT9L5sBnKmBTjl/SWReE+JSTn5+8sCcH98+UBn4o08fgdBfe0eMgVumTsJX5g
         OaxipyR9CJpdIUgJemwN93yM7TXoQ/JSLKaKZcGeg+E8zks0Qom3WsutD2JDN+SvFKVl
         mCllL0EpKHJbqJunCGig3Ep/ahDMPPvJp+7J/4zlAy9SOCmac6Gq6tskjno32HiEF6JW
         6deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729478284; x=1730083084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSRDUJE2sN+JOhUsMJh13VEW5h0PQQtkvxqT2sfTDCY=;
        b=BXrko2YZehNiGH2Th25NPiDZ1aeVlyoFN6/JPassyrbTywLD80Ut8Q15IqAB3fxwJh
         bBQJNf9BVXNuwi6jX7V9QiaMz92kx+e0QUlxXr3XX4K+qC/qvmOzYHbmQ/VGyQZy4vyL
         ktbQb7l0kKJNemhKretqfzUBkl9AJLs4YWd6cy3IvfBe/3MJ/9SdjEs6+7WMPEyKKMVG
         H9hWaKh7sEOF1zJqmcn/266kMHnZ0OPmST4TXCKBWwQVMV+AHzfiqIrtN42OkJ6AJg80
         zhoSZ6IXOvw2PsekCLGCdj0k1sOC7XxpYvUTuQXdH+X1+rkAM1gPkz6c95gxRfNbScFD
         F3Ng==
X-Gm-Message-State: AOJu0YzzrK1GJaTJ6yxGFpvBJmnTEkUDlXG+K8eiPCBKRxNL2tfFUdf4
	UBeHbaNLfOqMhQ/wn3hY7wlCV/Qby0V53tQhOmZtOTiaJukWaHK9k3yvL8RKv58g1zgoAOcFGTg
	iUdhr2MDXGHPQpeDucdJraqEM8Z8=
X-Google-Smtp-Source: AGHT+IFS0oie8ZUCppP1dQFfEDy6xHUzOglby7UYogm7hEDGFCBXFf1cno6/Ep+ye5SiFiQL1FfWAXBGEnIdbhTLi2A=
X-Received: by 2002:a05:6e02:1c8d:b0:3a0:98b2:8f3b with SMTP id
 e9e14a558f8ab-3a3f405445emr82402145ab.7.1729478284267; Sun, 20 Oct 2024
 19:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020145029.27725-1-kerneljasonxing@gmail.com> <20241020145029.27725-3-kerneljasonxing@gmail.com>
In-Reply-To: <20241020145029.27725-3-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Oct 2024 10:37:28 +0800
Message-ID: <CAL+tcoAr7RHhaZGV12wYDcPPPaubAqdxMCmy7Jujtr8b3+bY=w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: add more warn of socket in tcp_send_loss_probe()
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, ncardwell@google.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 10:50=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Add two fields to print in the helper which here covers tcp_send_loss_pro=
be().
>
> Link: https://lore.kernel.org/all/5632e043-bdba-4d75-bc7e-bf58014492fd@re=
dhat.com/
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> ---
>  include/net/tcp.h     | 5 ++++-
>  net/ipv4/tcp_output.c | 4 +---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index cac7bbff61ce..68eb03758950 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2434,14 +2434,17 @@ static inline void tcp_warn_once(const struct soc=
k *sk, bool cond, const char *s
>  {
>         WARN_ONCE(cond,
>                   "%s"
> +                 "cwnd:%u "
>                   "out:%u sacked:%u lost:%u retrans:%u "
>                   "tlp_high_seq:%u sk_state:%u ca_state:%u "
> -                 "advmss:%u mss_cache:%u pmtu:%u\n",
> +                 "mss:%u advmss:%u mss_cache:%u pmtu:%u\n",
>                   str,
> +                 tcp_snd_cwnd(tcp_sk(sk)),
>                   tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
>                   tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
>                   tcp_sk(sk)->tlp_high_seq, sk->sk_state,
>                   inet_csk(sk)->icsk_ca_state,
> +                 tcp_current_mss((struct sock *)sk),
>                   tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
>                   inet_csk(sk)->icsk_pmtu_cookie);
>  }
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 054244ce5117..295bc0741772 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2954,9 +2954,7 @@ void tcp_send_loss_probe(struct sock *sk)
>         }
>         skb =3D skb_rb_last(&sk->tcp_rtx_queue);
>         if (unlikely(!skb)) {
> -               WARN_ONCE(tp->packets_out,
> -                         "invalid inflight: %u state %u cwnd %u mss %d\n=
",
> -                         tp->packets_out, sk->sk_state, tcp_snd_cwnd(tp)=
, mss);
> +               tcp_warn_once(sk, tp->packets_out, NULL);

Sorry, I noticed the warning:
In function =E2=80=98tcp_warn_once=E2=80=99,
    inlined from =E2=80=98tcp_send_loss_probe=E2=80=99 at ../net/ipv4/tcp_o=
utput.c:2957:3:
../include/net/tcp.h:2436:19: warning: =E2=80=98%s=E2=80=99 directive argum=
ent is null
[-Wformat-overflow=3D]
 2436 |                   "%s"
      |                   ^~~~

I think It should be:
tcp_warn_once(sk, tp->packets_out, "");

Will handle this soon.

