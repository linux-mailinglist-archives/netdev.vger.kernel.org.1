Return-Path: <netdev+bounces-164809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727ADA2F35A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2853A1A53
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3FE2580EC;
	Mon, 10 Feb 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cNWL9oMr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D42580ED
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204699; cv=none; b=Jp4xaPuaP0RRMtwtNYgTzaXw3GIDpTjxCvRncViDHQkRny+O7KCGR9qOYfYNGSgtkug/DI0AyTNdq61+mv4fPhETjnVXE0FOfDlK/ooblY0D73nEVK+GE/0PNhX5RYyOmW4Wj0OHiKmulnWH2RCtuaruhscKCc6EdPZ2WfLE+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204699; c=relaxed/simple;
	bh=uYPhpbf8sYyWMU6Y+JaAgZfM9vVxxSXPJUquU4WZAgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G25DkeuUkC6bJRX2cVNPlnjllQ6SkhHTaxQhPeCao8VBKhHE3BEZTwSdu8bzjyN0rXnapmJ40oPgEnS5GwNrGYYkzsY43CGG+41pTfuImyQgFK22CNAegJixmUveL3NyLdYHdb91f1oG5jluC5Ng5jQ6S4rcbPrbav/gik4Jahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cNWL9oMr; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de63846e56so3849654a12.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739204696; x=1739809496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cxv2DoiY5hvteQgWt2u0iBZc/1tku2C1hsGccXYkGeU=;
        b=cNWL9oMriVhHoIRVOT93DK+I1BeLSrjwm8Bqo+NPH7pa9l6nU5YPxWORQJB6QZzr2i
         cTRzdkJctOEYxQ13BDDk459kaBY+XTiVh6jUBKpfSQihxMOUaM7P/sYbohIa0XGB4Hc6
         zBSEZ+BRNT5qE5xMPt/f3QbfibzFmpVoplU5DdHXmCixuW+y/x0NGEki1YSvtPAeZhKC
         c3qvEeq+9hormM0/+s8zd+BXfoLgRUggHiDm1GUMdJXztLhZwPR0ul6BJKUvEB+7hG2C
         3Fr2IkDCsxMKFBYc5RHJAFMP3xNSsgc6qzkM0Q+pMZo/Nu8O9B+jKRYc4VxF+etHlMWr
         PfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739204696; x=1739809496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cxv2DoiY5hvteQgWt2u0iBZc/1tku2C1hsGccXYkGeU=;
        b=URoSwd2VrkjrKFZal4dUyypOk1QxZe9JX2InSawtSB3McxZd/HGT1/CtGrs8OcLIu8
         AxNcLCUJwGkQGGMxUDTeS5n9vbzAnsMYTWf9VhSbkzK/ceS6iuojWO4wqPdNYZjU/FoP
         diwI7HLQR1JODtjHOidjjxgIykokMUcEoiLzDmDXjIKhgr8GupP4mzTdf2emU1TizRj/
         GVuvzOJ4f8lFSQVQxTgp5JC44j3wUbqKEsvHnnhIHdYpCsJUa0ZNUUWPZ5y1jI6ZoR/9
         M8R0C5Y6t8ifq7hG4fy6jgR2nkqpWNdo0mCHBjWF0b/85UjqBw+YBjvxrWWzXCtHK4S0
         E/4g==
X-Gm-Message-State: AOJu0Yw0iveKfxo6QSaWlAVFMTvAZ32VMFHcORp3rtGWG0jPnJTgrddd
	eGGYQAQY6vX+W8XU1EBqao+aGWw4wFQS9hdLLaWwhNdM3edo5qWRfHXVPnl8vUp9qvvcpVr8Wey
	YTwm/5D3LKYJY1zXQel/eZixdOiSUyR4+EjSe
X-Gm-Gg: ASbGncvOeeY0/FwGcgLRxGU9NK/dSezpCxwx/KntWqlmFvOYJ03D0oxCx7hHjEKqSf7
	pDj5Xlh6iokunj2gqQIypaUvZaEfuur0ZUMVSjUpv3iYn79s4Pl8MV2PYr26bCsg97oYGRAB4
X-Google-Smtp-Source: AGHT+IHJYpixPy77hP63GYqvF40vRk3QaGGVb8byszkR8zhmuEwBdHXVm2Hpyu4jBi9jkFdwpF1L+Y0CPQ06EpCmaTI=
X-Received: by 2002:a05:6402:2381:b0:5dc:1273:63fd with SMTP id
 4fb4d7f45d1cf-5de9a4646eamr274876a12.20.1739204695720; Mon, 10 Feb 2025
 08:24:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <879a4592e4e4bd0c30dbe29ca189e224ec1739a5.1739201151.git.sd@queasysnail.net>
In-Reply-To: <879a4592e4e4bd0c30dbe29ca189e224ec1739a5.1739201151.git.sd@queasysnail.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 17:24:43 +0100
X-Gm-Features: AWEUYZkX2JGspd2GM3MOKIESOydu5Row57bsLw2gt5LCEzmtTCUIZhnGM04lFcM
Message-ID: <CANn89iJbzed1HnW7QHSRWno92hLAbQH+iaitAutqRh=CK9koaw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: drop skb extensions before skb_attempt_defer_free
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	David Ahern <dsahern@kernel.org>, Xiumei Mu <xmu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 5:02=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> Xiumei reported hitting the WARN in xfrm6_tunnel_net_exit while
> running tests that boil down to:
>  - create a pair of netns
>  - run a basic TCP test over ipcomp6
>  - delete the pair of netns
>
> The xfrm_state found on spi_byaddr was not deleted at the time we
> delete the netns, because we still have a reference on it. This
> lingering reference comes from a secpath (which holds a ref on the
> xfrm_state), which is still attached to an skb. This skb is not
> leaked, it ends up on sk_receive_queue and then gets defer-free'd by
> skb_attempt_defer_free.
>
> The problem happens when we defer freeing an skb (push it on one CPU's
> defer_list), and don't flush that list before the netns is deleted. In
> that case, we still have a reference on the xfrm_state that we don't
> expect at this point.
>
> tcp_eat_recv_skb is currently the only caller of skb_attempt_defer_free,
> so I'm fixing it here. This patch also adds a DEBUG_NET_WARN_ON_ONCE
> in skb_attempt_defer_free, to make sure we don't re-introduce this
> problem.
>
> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lis=
ts")
> Reported-by: Xiumei Mu <xmu@redhat.com>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
> A few comments:
>  - AFAICT this could not happen before 68822bdf76f1, since we would
>    have emptied the (per-socket) defer_list before getting to ->exit()
>    for the netns
>  - I thought about dropping the extensions at the same time as we
>    already drop the dst, but Paolo said this is probably not correct due
>    to IP_CMSG_PASSSEC

I think we discussed this issue in the past.

Are you sure IP_CMSG_PASSSEC  is ever used by TCP ?

Many layers in TCP can aggregate packets, are they aware of XFRM yet ?

>  - I'm planning to rework the "synchronous" removal of xfrm_states
>    (commit f75a2804da39 ("xfrm: destroy xfrm_state synchronously on
>    net exit path")), which may also be able to fix this problem, but
>    it is going to be a lot more complex than this patch
>
>  net/core/skbuff.c | 1 +
>  net/ipv4/tcp.c    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6a99c453397f..abd0371bc51a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7047,6 +7047,7 @@ nodefer:  kfree_skb_napi_cache(skb);
>
>         DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
>         DEBUG_NET_WARN_ON_ONCE(skb->destructor);
> +       DEBUG_NET_WARN_ON_ONCE(skb_has_extensions(skb));
>
>         sd =3D &per_cpu(softnet_data, cpu);
>         defer_max =3D READ_ONCE(net_hotdata.sysctl_skb_defer_max);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0d704bda6c41..e60f642485ee 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1524,6 +1524,7 @@ static void tcp_eat_recv_skb(struct sock *sk, struc=
t sk_buff *skb)
>                 sock_rfree(skb);
>                 skb->destructor =3D NULL;
>                 skb->sk =3D NULL;
> +               skb_ext_reset(skb);

If we think about it, storing thousands of packets in TCP sockets receive q=
ueues
with XFRM state is consuming memory for absolutely no purpose.

It is worth noting MPTCP  calls skb_ext_reset(skb) after
commit 4e637c70b503b686aae45716a25a94dc3a434f3a ("mptcp: attempt
coalescing when moving skbs to mptcp rx queue")

I would suggest calling secpath_reset() earlier in TCP, from BH
handler, while cpu caches are hot,
instead of waiting for recvmsg() to drain the receive queue much later ?

