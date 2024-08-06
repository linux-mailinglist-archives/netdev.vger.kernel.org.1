Return-Path: <netdev+bounces-116053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EB3948DC2
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632C81F251BE
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB2E1C2303;
	Tue,  6 Aug 2024 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OccmPPtx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A725E143C4B;
	Tue,  6 Aug 2024 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944087; cv=none; b=gBkZ3FfsFwpE4nVqYPpg/ugg8A87UqVKL7kgNZJC08q7Fy4q5J0AZA1iyMiOF7ADwwc1t6UrO8BJfPNu0Den1ta4wzWOeEgQ3P8ikyqPvqz4v0ptZUM8aHiP+wq3tR1VKzE0+Nf0wdvo0FjgWcaUST73ArPQkz5MsF6c+VoSB60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944087; c=relaxed/simple;
	bh=5D6t1pzUECN2HDNf/G0lGVaxJ+7VHir8lRNzXGlGqno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mT12g3lacd1rc2UzC9WyJizJHiz7cvDTOL3tPVSg+B/QlyRlai3PDaD6q8fRrW6R/tMdq3/ENzXYp9DdXLDmP7IG8zH0CW0mCjbVf6/Kyh+sQogAvhAFrdpPmEqX4Wl/PK2TmxiZ9MUKhs805ooDxe68ttn9wVBAN+pn+FuNPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OccmPPtx; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81f83b14d65so21313439f.1;
        Tue, 06 Aug 2024 04:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722944085; x=1723548885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ddo7iby93cbpq3DE6A/Zpe9D+vuWQ4i5A2oEF0e6FcQ=;
        b=OccmPPtxsdjT5rfvGgP+Jcd92JPPFGOmgmQuEgSHbm1spzppug6R3OAekclVBhZmuv
         iWo55/EgBcjWYNGYmleC86eygLFhIhBIdGilruUpxDR4cc+MiQwKFKDj6UydlqyJLWfB
         eE0FA79crsYCJy3bMoL+1/yNVJ63dnZToqoh+py1zm9NXsPRwfRCQYgsTsyCqTXLaiyC
         y8FMk17ujqCBDr3M2i6rkxJU7svft1AscooAwwVSoXMEgY9SZkZ10dAKzggOH64SoPVi
         wEqaEdubSEFf3uqN2WuR+0eZi9r2EjLZymSIoTh/ywnCNcpQ1340uoZ3XYzX//9NGE9o
         d7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944085; x=1723548885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddo7iby93cbpq3DE6A/Zpe9D+vuWQ4i5A2oEF0e6FcQ=;
        b=lyrQ7h4kkzpgPn+wLNnHHKRSGkI57nNzqh6QPFymuGvy2Gw5tyw+qwrba3lfyv06IU
         TKbHIS1S0N6P/k6mArAdNH0Gq1rYhlx6qa58xsFR8ayytqOaIlTmYmk40WLQkRrxReGi
         tz4gnNji6iy2BtRoeQMWvpLBe8ZVkUwQ+pQn5JGnHskR5tElo/b3R5SDpWxJpm3jOnww
         mRoSmp+9fVEFNYjwZfZ8n+dFTsw5xLBni5YOmIzooOMXlBQnKuVss3T9bUk1gQwvLF6l
         CHpamZBYhjzil/odtUG3CTv5z/K5lrcBRDEHjT5vZxWV44482fhAdNQFCLaAu8wsUd9N
         PZcw==
X-Forwarded-Encrypted: i=1; AJvYcCVdXNgMIcDTWRGuryJJ7ypuKhC6iY8nACLKLMOkSf6c5xjXftOSoE/Mj77vfJLAlNKF1TeG8aB+82BLBnUR4cxc5V0DOIBxOxv/p60SamgTdLefwgSamW0+ku3wGg48GLAd9l6T
X-Gm-Message-State: AOJu0YxSIBX0wTowlBT9I44eWIBlJaVABL/KuXfaIDdXlXOCdjJMc9tN
	tS342VQGBgnle8t7MUTJXmvvXwpHoaxryypLaThp9t2ObG1/MHySwu7kHToTPS4zwdNkgBe6bGV
	FNEo6Mp1evGvdbOwK889XfCm0bys=
X-Google-Smtp-Source: AGHT+IElc5Bl6Zr8a3XieILg1Ia3IaiOdB1V9UU4mnkozO5WCwSzYCm7Lfxoxqij21VfMYYTZ5JE7YyF43fdhCnXWLk=
X-Received: by 2002:a92:d84a:0:b0:376:1cf6:6be4 with SMTP id
 e9e14a558f8ab-39b1fb874a7mr176368565ab.14.1722944084674; Tue, 06 Aug 2024
 04:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoB7F3Aviygmxc_DhfLRQN8c=cdn-_1QrXhEWFpyeAQRDw@mail.gmail.com>
 <20240806100243.269219-1-kuro@kuroa.me>
In-Reply-To: <20240806100243.269219-1-kuro@kuroa.me>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 6 Aug 2024 19:34:06 +0800
Message-ID: <CAL+tcoB2yXa=jj4TgLV7R0-wHW-9taW7o_eBjB85Ne=kdNa2XA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Xueming Feng <kuro@kuroa.me>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e03a342c9162..831a18dc7aa6 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4637,6 +4637,13 @@ int tcp_abort(struct sock *sk, int err)
>                 /* Don't race with userspace socket closes such as tcp_close. */
>                 lock_sock(sk);
>
> +       /* Avoid closing the same socket twice. */
> +       if (sk->sk_state == TCP_CLOSE) {
> +               if (!has_current_bpf_ctx())
> +                       release_sock(sk);
> +               return -ENOENT;

I'm not quite sure about this.

> +       }
> +
>         if (sk->sk_state == TCP_LISTEN) {
>                 tcp_set_state(sk, TCP_CLOSE);
>                 inet_csk_listen_stop(sk);
> @@ -4646,16 +4653,13 @@ int tcp_abort(struct sock *sk, int err)
>         local_bh_disable();
>         bh_lock_sock(sk);
>
> -       if (!sock_flag(sk, SOCK_DEAD)) {
> -               if (tcp_need_reset(sk->sk_state))
> -                       tcp_send_active_reset(sk, GFP_ATOMIC,
> -                                             SK_RST_REASON_NOT_SPECIFIED);
> -               tcp_done_with_error(sk, err);
> -       }
> +       if (tcp_need_reset(sk->sk_state))
> +               tcp_send_active_reset(sk, GFP_ATOMIC,
> +                                     SK_RST_REASON_NOT_SPECIFIED);
> +       tcp_done_with_error(sk, err);
>
>         bh_unlock_sock(sk);
>         local_bh_enable();
> -       tcp_write_queue_purge(sk);

On the whole, it looks fine to me. Please let maintainer take a look
at it finally.

Thanks!

