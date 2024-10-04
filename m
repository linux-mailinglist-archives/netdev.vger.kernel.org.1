Return-Path: <netdev+bounces-132248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF32D9911E8
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE771F24218
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5217A1AE00A;
	Fri,  4 Oct 2024 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9KFGEEM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A9A14659F
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079003; cv=none; b=dnegCksxsJbN8TvKNj6IvAEUVPXfWtK8T9IzKCiWS0IApYYP/wPk1dQ30LphO8CyIha/CDg2uLDb31WYmYBlya7S6j+IP3EQg3qyxl5RryDrkPxwF5xiTIRuI2vmGqHMgrllNwBni4yp/ua6VGLlHfnzGi5jb/K3rMerynnDst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079003; c=relaxed/simple;
	bh=Q6JArbmv7j4PGndq5OKtf0limDngnhIiTxvZBF3Aeu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKaruvgRmjsn+UkgXlUCsAfk5AKQ8K5v65muOVkb7uf5KtdXO7gdz6kxPEWNtYsUi4QpXsM7luJGPxaxhk2XwiZrQ3zaF+S+jRxUxpbZmkkHT6SWlDyUF7AXJtCcT5uirzp+eIOzZxHoOGtaQgM3cP3tLVy7LNq8FugqeOFUKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9KFGEEM; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398fb1a871so2733762e87.3
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 14:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728079000; x=1728683800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IePwo1y1FASkkqF6e1LjfIG72RoRM9tcgJDPeMe7io=;
        b=l9KFGEEMAm2WrRxlt5xDdkVK6Mtc/TZyIreLBZgJQPMQ/lDSf8dxPUk0vF7dexDTUe
         bI/xIMLfSGPR+NoDmBD/Lc6fSZS6Z6AXcp5HvfYZZrk+3cXLCVPL7XExyeR0zL3+AOEt
         AjFGTs6JjCjPcKtCAtBvhVPQPoa1f26ZUulZ4f5l99rn7NSDjMXymxqgAhCaQS7ZME/m
         ayUBv5N/Y8E1dfJaYHepARDB09SE7cVfMxxtK7dwnpG1piSOv7bsuYv/apL0cdy9TbFi
         NP02S9TQgaoF4E6hPB0ifJrRLYD981Wy4W3D0nkRZdp55SAHsHjawCpBViMNIfy78/CF
         DkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728079000; x=1728683800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IePwo1y1FASkkqF6e1LjfIG72RoRM9tcgJDPeMe7io=;
        b=Yh3zlCljO7ucPps1ofmIOhYpRz/rBLwK9VEgDml0KlUxjMWOKEVjPcFHg1PXI7X131
         1bJDj/hw+uWQW6BDhfJfln5InG/7+18PGmeaPpxPw8V0FsNFieuLuRzGtj8mARVpWdiq
         j0ifQDRA4AboNc8k038x28Qt5dUBPD7gfwryz0TeWKk25TiPzXtWjo2zMgixDF348JH3
         CZbRxkBeO2t/4uI+pmzpR2oX9d6PhwYgkQXcgS7hI0Im+Sbq0euLymSxrRphER+HOnQe
         N5D/aoP+rZPILO2tjieLSq4HMTOuUmOu00WbuRDTm7tckc9UpvtCV9I907jRGqyMvF4o
         ELGw==
X-Gm-Message-State: AOJu0Yx2myOM2VTas/6YH4ePoktWYmA/ScvaY0djUi/6v5DjfD484f78
	ieTZC9xbGU4SIK2HKN7VIOkcDPvUKrFw7rFfMoKSUqQttvRq9qBw9ISP5ZzvhiL8XDAD1QLSjur
	23AyyDL2i0h6evGtQkK9+4crONr7V+T/QNC/t
X-Google-Smtp-Source: AGHT+IHEM+TDfmr3IscAFpaP6Rf4gxiA5WPLK/dNXy3EygDL1q/sLW/SrKxoCa7SRm4pirwJitDw8OkqTFnO+teEp7E=
X-Received: by 2002:a05:6512:23a8:b0:52e:be50:9c55 with SMTP id
 2adb3069b0e04-539ab8c1be2mr3158975e87.52.1728078999397; Fri, 04 Oct 2024
 14:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004191644.1687638-1-edumazet@google.com> <20241004191644.1687638-2-edumazet@google.com>
In-Reply-To: <20241004191644.1687638-2-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Oct 2024 23:56:26 +0200
Message-ID: <CANn89i+PxDFAkc_O9VdP3KgdBsRtpgaTCuYnH11ccLZAzpKMpA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] net: add TIME_WAIT logic to sk_to_full_sk()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 9:16=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> TCP will soon attach TIME_WAIT sockets to some ACK and RST.
>
> Make sure sk_to_full_sk() detects this and does not return
> a non full socket.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/inet_sock.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index 394c3b66065e20d34594d6e2a2010c55bb457810..cec093b78151b9a3b95ad4b36=
72a72b0aa9a8305 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -319,8 +319,10 @@ static inline unsigned long inet_cmsg_flags(const st=
ruct inet_sock *inet)
>  static inline struct sock *sk_to_full_sk(struct sock *sk)
>  {
>  #ifdef CONFIG_INET
> -       if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_NEW_SYN_RECV)
>                 sk =3D inet_reqsk(sk)->rsk_listener;
> +       if (sk && READ_ONCE(sk->sk_state) =3D=3D TCP_TIME_WAIT)
> +               sk =3D NULL;
>  #endif
>         return sk;
>  }

It appears some callers do not check if the return value could be NULL.
I will have to add in v2 :

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index ce91d9b2acb9f8991150ceead4475b130bead438..c3ffb45489a6924c1bc80355e86=
2e243ec195b01
100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -209,7 +209,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock =
*sk,
        int __ret =3D 0;                                                   =
      \
        if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {                =
    \
                typeof(sk) __sk =3D sk_to_full_sk(sk);                     =
      \
-               if (sk_fullsock(__sk) && __sk =3D=3D skb_to_full_sk(skb) &&=
        \
+               if (__sk && sk_fullsock(__sk) && __sk =3D=3D
skb_to_full_sk(skb) &&        \
                    cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS))     =
    \
                        __ret =3D __cgroup_bpf_run_filter_skb(__sk, skb,   =
      \
                                                      CGROUP_INET_EGRESS); =
\
diff --git a/net/core/filter.c b/net/core/filter.c
index bd0d08bf76bb8de39ca2ca89cda99a97c9b0a034..533025618b2c06efa31548708f2=
1d9e0ccbdc68d
100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6778,7 +6778,7 @@ __bpf_sk_lookup(struct sk_buff *skb, struct
bpf_sock_tuple *tuple, u32 len,
                /* sk_to_full_sk() may return (sk)->rsk_listener, so
make sure the original sk
                 * sock refcnt is decremented to prevent a request_sock lea=
k.
                 */
-               if (!sk_fullsock(sk2))
+               if (sk2 && !sk_fullsock(sk2))
                        sk2 =3D NULL;
                if (sk2 !=3D sk) {
                        sock_gen_put(sk);
@@ -6826,7 +6826,7 @@ bpf_sk_lookup(struct sk_buff *skb, struct
bpf_sock_tuple *tuple, u32 len,
                /* sk_to_full_sk() may return (sk)->rsk_listener, so
make sure the original sk
                 * sock refcnt is decremented to prevent a request_sock lea=
k.
                 */
-               if (!sk_fullsock(sk2))
+               if (sk2 && !sk_fullsock(sk2))
                        sk2 =3D NULL;
                if (sk2 !=3D sk) {
                        sock_gen_put(sk);
@@ -7276,7 +7276,7 @@ BPF_CALL_1(bpf_get_listener_sock, struct sock *, sk)
 {
        sk =3D sk_to_full_sk(sk);

-       if (sk->sk_state =3D=3D TCP_LISTEN && sock_flag(sk, SOCK_RCU_FREE))
+       if (sk && sk->sk_state =3D=3D TCP_LISTEN && sock_flag(sk, SOCK_RCU_=
FREE))
                return (unsigned long)sk;

        return (unsigned long)NULL;

