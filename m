Return-Path: <netdev+bounces-137777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ECE9A9BD6
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218AF1F20F06
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622E5140E38;
	Tue, 22 Oct 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npwaAZ05"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295417758
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584042; cv=none; b=JvbTCEdiQ90Wo3vhD+i697ER0ThulhxPEXVaFKrVN5J8FPRb1sGujyT/+4QNahuvZjVvIBVwdijg2Iqrye0X0rGWSCi0OFjV60iQ21c2g5QHnpgm/lDuLCQxsxsGyLmWVwAUCcbX7HxzVEMcnJ+6or4+Kzh32Yl7h7m/yQtgohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584042; c=relaxed/simple;
	bh=UhibHKrzT+OOlpb9eFtzVdMsF8zu3yNhBoJuEPE7gMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APBLhEFuKejBpyU2ixr38S3vzhyWoZJOsUHeSyeHc8gA5HQPrxTY3/piF7fRELDZdlkZchFAUQ53VgvQZI0szvh9XDMRzdVDCPBdiKK8FJa2t3n6WeZQ/6vsNuk71r75ZRWVdPDDTFtrUlpyx94bG5oXZrwg4aImNU9JJirLkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npwaAZ05; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso724936566b.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729584039; x=1730188839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6c+131tC5YZiXltFvjOnteVQcxE227J2lcDBMT4WLQI=;
        b=npwaAZ05mKzZ7IUn0E9RJebd/HQ7sw30OfdEb8WXP5hcU7LMq08B5Ucs2UbuVHjQ2F
         Jjm8kjR99YEnoFFBjHTzQLxGISb2FuWecT6YUAOYYssFDIYRmw2nSbp5xjqwvhRjkIl7
         TbSuQR/Xi5rt0H6IRKj7cOzOLGBujaIT64fyZQhgAdE3q0BJjecYRx6My+W431CFh5vi
         1QOygqwJlJz/YZPO3PF152Vd7PHDt3yyCYFwAyYP6nQxh5+8Xyoe/+3qTKiTFwIspwOt
         REOHG4mYHmPV0k3gDsCAqvUCWkh2N7Sfc1QTPL2MHb7ZB+hXXXFt4VIoTqjZMEhIjDvI
         zlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729584039; x=1730188839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6c+131tC5YZiXltFvjOnteVQcxE227J2lcDBMT4WLQI=;
        b=qBIPi7TYsJBeyf9N3s48TTmvt5JStGYBbdbr+Gj255pg/oxxPYRc6+yK6LJcuByFuD
         r0yB4h5SniWlYz0m+b71o/XrwNDjpnQgUnphjT3mixkzRyayu5L5CiujNyNJC6Uih8zW
         GA+QsEp/KThCbKwUxs8SQ/BS0JDtJjmY79zBlXwmZggkihIVConOOod70uDkEQZP+QZE
         omqsYCaHiMT9ercy7wu1HF1gDA48/2FIWLJRBABN3M42KIe1+cIwtmWgdDMhUeVjOnGb
         WUd8TWpuZB/AS8oICkHvsTLFqxTSlDoNpxHFuzzW3yU5OYMZPgpbKDB43NTEV8PuViwM
         IoRw==
X-Forwarded-Encrypted: i=1; AJvYcCVInRlXSZbqihdELHw8SjxsegAOx2anILzGLI3pnZSrWfky2yZi4celrquq7x5xSmeyguLKknE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV+Ai95jghTqjLPYxSckVK5A4R8M4QSXWCClxFSAyhqkXJ8FIa
	dDHGdIulht6O75YMOGUXTsMLFxvhuuQv++fDH3W9hgffxFpUNHPOQuXWYvEkPHfnuJ7tBjfl3Pp
	sab/ewlWXePWMaH34RmEaE2eMyVD5QlGh66n1
X-Google-Smtp-Source: AGHT+IEFknbiHWF7QFPgEPUBxCrZOksfizoZh5mtf8lddgvqHv0uoZrmp8RpxBmLCduNUkg/FZTduclh+yJsOQUOz4Y=
X-Received: by 2002:a17:907:3f98:b0:a9a:597:8cca with SMTP id
 a640c23a62f3a-a9aad371779mr176389866b.45.1729584038104; Tue, 22 Oct 2024
 01:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021155245.83122-1-kerneljasonxing@gmail.com> <20241021155245.83122-3-kerneljasonxing@gmail.com>
In-Reply-To: <20241021155245.83122-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Oct 2024 10:00:25 +0200
Message-ID: <CANn89iLmyNnRn27mSy_fYacvacUoNh=fy2qzCP-1tcL5g_r3vg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] tcp: add more warn of socket in tcp_send_loss_probe()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 5:53=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
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
> --
> v2
> Link:https://lore.kernel.org/all/CAL+tcoAr7RHhaZGV12wYDcPPPaubAqdxMCmy7Ju=
jtr8b3+bY=3Dw@mail.gmail.com/
> 1. use "" instead of NULL in tcp_send_loss_probe()
> ---
>  include/net/tcp.h     | 4 +++-
>  net/ipv4/tcp_output.c | 4 +---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 8b8d94bb1746..78158169e944 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2433,12 +2433,14 @@ void tcp_plb_update_state_upon_rto(struct sock *s=
k, struct tcp_plb_state *plb);
>  static inline void tcp_warn_once(const struct sock *sk, bool cond, const=
 char *str)
>  {
>         WARN_ONCE(cond,
> -                 "%sout:%u sacked:%u lost:%u retrans:%u tlp_high_seq:%u =
sk_state:%u ca_state:%u advmss:%u mss_cache:%u pmtu:%u\n",
> +                 "%scwn:%u out:%u sacked:%u lost:%u retrans:%u tlp_high_=
seq:%u sk_state:%u ca_state:%u mss:%u advmss:%u mss_cache:%u pmtu:%u\n",
>                   str,
> +                 tcp_snd_cwnd(tcp_sk(sk)),
>                   tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
>                   tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
>                   tcp_sk(sk)->tlp_high_seq, sk->sk_state,
>                   inet_csk(sk)->icsk_ca_state,
> +                 tcp_current_mss((struct sock *)sk),

You can not promote to non const, because tcp_current_mss() might
change socket state.

If a debug helper changes the socket state, then it is no longer a debug he=
lper.

>                   tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,

This was already reported btw.

>                   inet_csk(sk)->icsk_pmtu_cookie);
>  }
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 054244ce5117..36562b5fe290 100644
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
> +               tcp_warn_once(sk, tp->packets_out, "");
>                 smp_store_release(&inet_csk(sk)->icsk_pending, 0);
>                 return;
>         }
> --
> 2.37.3
>

