Return-Path: <netdev+bounces-114818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB669444FC
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FCE2B2130F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 06:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535342C853;
	Thu,  1 Aug 2024 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4dBb27Pi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A500158554
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495387; cv=none; b=QBoSyx8Ppn8cByF9kMf0EMcEH96K9IaA66JVHra7krY2iaKVrX4zyzwwv/z5wQvhKpEJZ/O1NdosjVUFP13A4bwRave6k6j9htPQQG8fFWn1bLDiuv8qoVFJeKJ1KrOzoYJNtrY6JaYWCpe62y5uWpIxbpiz6BdmAeIQ8us8+4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495387; c=relaxed/simple;
	bh=UWC1Pilw1r7nqapxLEBJmGxceBgEs7DfVXXSz0dLdy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6ho5HvJM+2PIcb2a06+onYr8KVx63BTvpUIJfRVTQ46uzNU9ED+UvB9uevsOWW2iXjD56kNvK0Gr3SbKC00jO7HWtntFGuH9yjDXykwymcI5sUf8SSO+fFQCrc5WQopasPMmUzbvnHO5mmaJa74odWKFzP2hwMvAMHIbalM9Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4dBb27Pi; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so28788a12.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722495384; x=1723100184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcNhJ2EqP4JJ1DVaO4uA2KkFy1T4U2ydNGCznE+PwzY=;
        b=4dBb27Pi97QhT7Dw8/pGE4FNUqQxMjP6UoYOINmZldDJlyUMpy6eW20Nqt0t2q9Egr
         lLGdIHisnigFX0hDneDmh4WNF80dg1fQ0/NOc2vhwdODR2l1cxESL6ai0LyocHi3ICqA
         qAaUVqA2OlC99+5pBntDJKnFnMYFIir+eM3g/t4NZiIivFqHmdkNqWF0FZOdwX/WYudR
         Lbg7k8IaNnJiZv07lKRSuWldSyKDiGFFaQQ6wLBO3X3E9HIFFoZ/3ceAnxKKLVi8Ziwl
         zbqCX/QFhcV4BQjGn2dYbi+hWvlH/aQy7ibkkvhvg+LVXUZeuZuxVPtevlmkZFfbMCYV
         B6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722495384; x=1723100184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcNhJ2EqP4JJ1DVaO4uA2KkFy1T4U2ydNGCznE+PwzY=;
        b=ATMMgKkRZaTMAWQhBoO9edtVLFgKKz/+spK9rDF6cy4ubuhUZkkN2XYTIvogphU+pa
         4JTEL0iw4Zlne6uhFc7ypVjbWWkyZJ0NyGUk0sPxFS16Dsbb7ZmdRvsS+839p/zAlRUC
         shZvPT7hcicXwOntUm/a1dXRId8NLughuT/No6habB9gi+h0FS+rlm8tdW5oFX6fixwF
         sXHGyTe6eDh5BEh4umMLkFXZXyg8DmNd3XnADV1r5rXMzkcqQdYgj9pZWLpMCbCFoQQA
         MBgsHn9/t3HgYTBLGq0IA24sD5dNNy3CFsD6SwYruqvGLY/AaygiH36SXKhhjYiscATb
         tDIw==
X-Forwarded-Encrypted: i=1; AJvYcCVQLLp/XRWUcK4O77F6qBPi0s5S9F7fmIKh2rr81x6PD5zQbdMYTPxJllJP2zsrTICn/NvYdsuUiO+c/zT6OniVvtY5R37L
X-Gm-Message-State: AOJu0YxK2EY1WZulsGDUlyDeGj1NH0a03lvBjKFTz/oARKqNb6DmH2xI
	lZlgcOwC3uS0WZ5fMdCGt7r1ScdhL1jAcSHiv3lVkhZd6Ns6k3KUoIqPv6O+pt4wSRzKtagoS7A
	0KE0b0jepCjox7ufQpjpvfKroQ3ly8mkkOttC
X-Google-Smtp-Source: AGHT+IHZIE5m7KArZ+x7UdCP8XzVG84I79fY+DjEuaFsmdX4bdmafCl7BBouoPlbtTFtsPwoU53p2YzGjAlXSaLHSR4=
X-Received: by 2002:a05:6402:3553:b0:57d:32ff:73ef with SMTP id
 4fb4d7f45d1cf-5b71b5f4bfdmr99644a12.6.1722495383432; Wed, 31 Jul 2024
 23:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731120955.23542-1-kerneljasonxing@gmail.com> <20240731120955.23542-5-kerneljasonxing@gmail.com>
In-Reply-To: <20240731120955.23542-5-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Aug 2024 08:56:12 +0200
Message-ID: <CANn89iJGco0f2RLBm4bW3QpRHwscwZhc287RX+mWA0Q_=hfTYA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/6] tcp: rstreason: introduce
 SK_RST_REASON_TCP_STATE for active reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:10=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Introducing a new type TCP_STATE to handle some reset conditions
> appearing in RFC 793 due to its socket state. Actually, we can look
> into RFC 9293 which has no discrepancy about this part.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> V2
> Link: https://lore.kernel.org/all/20240730200633.93761-1-kuniyu@amazon.co=
m/
> 1. use RFC 9293 instead of RFC 793 which is too old (Kuniyuki)
> ---
>  include/net/rstreason.h | 6 ++++++
>  net/ipv4/tcp.c          | 4 ++--
>  net/ipv4/tcp_timer.c    | 2 +-
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> index eef658da8952..bbf20d0bbde7 100644
> --- a/include/net/rstreason.h
> +++ b/include/net/rstreason.h
> @@ -20,6 +20,7 @@
>         FN(TCP_ABORT_ON_CLOSE)          \
>         FN(TCP_ABORT_ON_LINGER)         \
>         FN(TCP_ABORT_ON_MEMORY)         \
> +       FN(TCP_STATE)                   \
>         FN(MPTCP_RST_EUNSPEC)           \
>         FN(MPTCP_RST_EMPTCP)            \
>         FN(MPTCP_RST_ERESOURCE)         \
> @@ -102,6 +103,11 @@ enum sk_rst_reason {
>          * corresponding to LINUX_MIB_TCPABORTONMEMORY
>          */
>         SK_RST_REASON_TCP_ABORT_ON_MEMORY,
> +       /**
> +        * @SK_RST_REASON_TCP_STATE: abort on tcp state
> +        * Please see RFC 9293 for all possible reset conditions
> +        */
> +       SK_RST_REASON_TCP_STATE,
>
>         /* Copy from include/uapi/linux/mptcp.h.
>          * These reset fields will not be changed since they adhere to
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index fd928c447ce8..64a49cb714e1 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3031,7 +3031,7 @@ int tcp_disconnect(struct sock *sk, int flags)
>                 /* The last check adjusts for discrepancy of Linux wrt. R=
FC
>                  * states
>                  */
> -               tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_NOT_SP=
ECIFIED);
> +               tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_TCP_ST=
ATE);

I disagree with this. tcp_disconnect() is initiated by the user.

You are conflating two possible conditions :

1) tcp_need_reset(old_state)
2) (tp->snd_nxt !=3D tp->write_seq && (1 << old_state) & (TCPF_CLOSING |
TCPF_LAST_ACK)))

>                 WRITE_ONCE(sk->sk_err, ECONNRESET);
>         } else if (old_state =3D=3D TCP_SYN_SENT)
>                 WRITE_ONCE(sk->sk_err, ECONNRESET);
> @@ -4649,7 +4649,7 @@ int tcp_abort(struct sock *sk, int err)
>         if (!sock_flag(sk, SOCK_DEAD)) {
>                 if (tcp_need_reset(sk->sk_state))
>                         tcp_send_active_reset(sk, GFP_ATOMIC,
> -                                             SK_RST_REASON_NOT_SPECIFIED=
);
> +                                             SK_RST_REASON_TCP_STATE);
>                 tcp_done_with_error(sk, err);
>         }
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 0fba4a4fb988..3910f6d8614e 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -779,7 +779,7 @@ static void tcp_keepalive_timer (struct timer_list *t=
)
>                                 goto out;
>                         }
>                 }
> -               tcp_send_active_reset(sk, GFP_ATOMIC, SK_RST_REASON_NOT_S=
PECIFIED);
> +               tcp_send_active_reset(sk, GFP_ATOMIC, SK_RST_REASON_TCP_S=
TATE);
>                 goto death;
>         }
>
> --
> 2.37.3
>

