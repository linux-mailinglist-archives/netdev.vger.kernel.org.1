Return-Path: <netdev+bounces-158135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1832A108EB
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206E21884A88
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AE27E105;
	Tue, 14 Jan 2025 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cohrFAPM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABA23244E
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864217; cv=none; b=OrKImeXu5FoPZE3wWJvH3JDwrjHvrvF453yShqzX1HHNR334FV2Og+CkqdPhCewOLgtWyAVj/3y0Q6TNu2dkcRTxWMUO8MnkW4mjxhteYGmSqJvXebSvF5wNiscsZKedk/0QScyoSbPG7JwDX9WrGOgJ9G/PI6Jafvez3yIgRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864217; c=relaxed/simple;
	bh=5etmMSFaNroOZ0H16WZ8hvo9Fv0af24VNmWvvi7Z9PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzNLWlMzolpeUryVQWA9Yfg1sILIZatuUhTbH79JClUxMBDOepKdIpHl7WERdoHifuslcAfTSdRB8FeBb9j2LuoZkru0KEJGtaP7hFCG47Q3hq0MF52Gs65DrowzasFh+pd3yHEae8cnOKdzEythRwyg3mlxXHIJdN+EdXYS9fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cohrFAPM; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4678c9310afso187291cf.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 06:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736864215; x=1737469015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJjhO2/G8D7kaH4mvqN35RKWShRj2YA1s6DjrPp/blY=;
        b=cohrFAPMEFr60BfHvEEGB6TIqw/UaqEK2D158wZLR/86nmYevWlnVXMRmyYdhRfP5i
         fy/PH5BB+G1iiXQWHlr6tLTRxjaGr6Ku2EiM5pFVWGSUQ9BfcV59dFPgFtD3DgRSa/ej
         jSdveArhi9SdZ4swoG9EibQs6ez1S0GEN4TWogr1BA8YqFvmruwF0RQ7drzs4frvfAVn
         +iokMw7H3HBQ8+PMn2pHvifHEnUly7/XrwFv9ELw8hAOatb3qQ0G5/hGFWxfoF53aGj3
         CvC0P1/V23CHT6eWZ5nDSjgqdpdZE6qcMgWxsbJFxHvZH0e+RVkYw+DdqMwfJxZxz99B
         PmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736864215; x=1737469015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJjhO2/G8D7kaH4mvqN35RKWShRj2YA1s6DjrPp/blY=;
        b=Zjlf0wH95yIkBWBgParUkuTgvRSk/cqfPQzFue4ScNfBhBs1lEuE8tqlypISqPX74J
         ywJjYV6e46P7JMaETFupYfeiXuRJbe66j2kzIxYTog0woww0ZjGb2goIdrXe3qvPgdeI
         pFbZvW8+vyKVUsI26R2lSMdgGpmhwvnz/wfW+NPSdv6MWZTegOspj/8sgg7Y0EQLyR1d
         gEUJip/v6pGnd2XlctILjzmKY/9oWJEG7bAh8pNSczMC8RXgLT9AhGNKr0j/0+4krI0a
         EFrYVlzjaBaCvftUK2LOzDJs+VtV8ajwdfnva0JvKmjIJriYb9KQ2gIOKx3paMzY1gAC
         w3Jw==
X-Gm-Message-State: AOJu0YxCd/1oRzIrBJ9Q8nRHiev0BefXijXjiK0NO/k7R1OxDGaqqVUS
	6b+IMFt/XPVwGwZpW7H/M6avDW2DA1GLMyDq8Aa0+STaEhbVzD6eql4PwK2Nso2sARei6T+KK36
	LIvcoSZba28vW8pPTNmD2k8YHvNc1V2h5FKW1pCAyv5KFGfNcqjE/ee0=
X-Gm-Gg: ASbGncvGxnnEwXdSVeoECT0BxQ7jnROIVe2qqF6b9x6mCYlt81o7MJANA1pPMnZCIHW
	w8XlEh9nbBjdlBtQzo6hFlO0S+7k4nlEkB+iH1engGiiDvB99RJ4NZdF0NpdJHht8X+aN16o=
X-Google-Smtp-Source: AGHT+IGoesQ9QFM9eK/F4CkTzeJv1wnpeqkSK8Ku1JwrEG7zr+Gj7O569HjpwNHxN6lbOC3OmnLuSJgGpSPZFznOnzw=
X-Received: by 2002:ac8:5e07:0:b0:465:c590:ed18 with SMTP id
 d75a77b69052e-46dea8f93c4mr2704861cf.9.1736864214578; Tue, 14 Jan 2025
 06:16:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114043131.2035-1-ma.arghavani.ref@yahoo.com> <20250114043131.2035-1-ma.arghavani@yahoo.com>
In-Reply-To: <20250114043131.2035-1-ma.arghavani@yahoo.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 14 Jan 2025 09:16:38 -0500
X-Gm-Features: AbW1kvbVZkNuqLxxf64E8Iywv0eu1LOo3axhYRh01qq3JMksupmgIWwahPiecqg
Message-ID: <CADVnQy=n8VvNONU74GqB9a8HbbPxGj-C3KO=nREEKrTf+p+hYg@mail.gmail.com>
Subject: Re: [PATCH net] tcp_cubic: fix incorrect HyStart round start detection
To: Mahdi Arghavani <ma.arghavani@yahoo.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, haibo.zhang@otago.ac.nz, 
	david.eyers@otago.ac.nz, abbas.arghavani@mdu.se
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 11:31=E2=80=AFPM Mahdi Arghavani <ma.arghavani@yaho=
o.com> wrote:
>
> I noticed that HyStart incorrectly marks the start of rounds,
> resulting in inaccurate measurements of ACK train lengths.
> Since HyStart relies on ACK train lengths as one of two thresholds
> to terminate exponential cwnd growth during Slow-Start, this
> inaccuracy renders that threshold ineffective, potentially degrading
> TCP performance.
>
> The issue arises because the changes introduced in commit 4e1fddc98d25
> ("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limit=
ed flows")
> moved the caller of the `bictcp_hystart_reset` function inside the `hysta=
rt_update` function.
> This modification added an additional condition for triggering the caller=
,
> requiring that (tcp_snd_cwnd(tp) >=3D hystart_low_window) must also
> be satisfied before invoking `bictcp_hystart_reset`.
>
> This fix ensures that `bictcp_hystart_reset` is correctly called
> at the start of a new round, regardless of the congestion window size.
> This is achieved by moving the condition
> (tcp_snd_cwnd(tp) >=3D hystart_low_window)
> from before calling `bictcp_hystart_reset` to after it.
>
> Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train detection=
s for not-cwnd-limited flows")
>
> Signed-off-by: Mahdi Arghavani <ma.arghavani@yahoo.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Haibo Zhang <haibo.zhang@otago.ac.nz>
> Cc: David Eyers <david.eyers@otago.ac.nz>
> Cc: Abbas Arghavani <abbas.arghavani@mdu.se>
> ---

Thanks for the patch!

To comply with Linux commit description policy, please remove the
empty line between the Fixes: footer and Signed-off-by footer, so
tools and readers can be sure to correctly parse all the footers.

Note that this page:

https://patchwork.kernel.org/project/netdevbpf/patch/20250114043131.2035-1-=
ma.arghavani@yahoo.com/

...highlights that issue in the "netdev/verify_fixesfailProblems with
Fixes tag: 1" row:

https://netdev.bots.linux.dev/static/nipa/925140/13938399/verify_fixes/summ=
ary

Commit: 08181a887689 ("tcp_cubic: fix incorrect HyStart round start detecti=
on")
Fixes tag: Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK
train detections for not-cwnd-limited flows")
Has these problem(s):
- empty lines surround the Fixes tag

To help maintainers understand the relationship between your next post
of the patch, and the current one, can you please use the following to
apply a "v2" in your git format-patch command line:
  --subject-prefix=3D'PATCH net v2'

Also, can you please either (a) respond in the other email thread on
this topic, attaching your updated packetdrill tests, or (b) post a
pull request on the packetdrill github repo at
https://github.com/google/packetdrill with your updated tests?

thanks,
neal


>  net/ipv4/tcp_cubic.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 5dbed91c6178..76c23675ae50 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -392,6 +392,10 @@ static void hystart_update(struct sock *sk, u32 dela=
y)
>         if (after(tp->snd_una, ca->end_seq))
>                 bictcp_hystart_reset(sk);
>
> +       /* hystart triggers when cwnd is larger than some threshold */
> +       if (tcp_snd_cwnd(tp) < hystart_low_window)
> +               return;
> +
>         if (hystart_detect & HYSTART_ACK_TRAIN) {
>                 u32 now =3D bictcp_clock_us(sk);
>
> @@ -467,9 +471,7 @@ __bpf_kfunc static void cubictcp_acked(struct sock *s=
k, const struct ack_sample
>         if (ca->delay_min =3D=3D 0 || ca->delay_min > delay)
>                 ca->delay_min =3D delay;
>
> -       /* hystart triggers when cwnd is larger than some threshold */
> -       if (!ca->found && tcp_in_slow_start(tp) && hystart &&
> -           tcp_snd_cwnd(tp) >=3D hystart_low_window)
> +       if (!ca->found && tcp_in_slow_start(tp) && hystart)
>                 hystart_update(sk, delay);
>  }
>
> --
> 2.45.2
>

