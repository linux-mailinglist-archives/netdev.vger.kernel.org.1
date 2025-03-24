Return-Path: <netdev+bounces-177044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3AAA6D7F0
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 11:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EAB3B10D0
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662331953A9;
	Mon, 24 Mar 2025 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1PtXmuX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0782802
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742810490; cv=none; b=b2FbaWDQxIS1k8ox2QcwheIj6yNdfjNg883USSFsPIrFYeyYFhuBSlGmQAyaH7fh3YKKDBDT4/fM7m9ZGepJSSQGWyFooSZdPJmQevOnUe388dtClBMK/beF8ltpsgVpaELQXephg5rvMvVTjeB5fVr07DrijkEOaVthgFSPhO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742810490; c=relaxed/simple;
	bh=rKBqPmc2eP7/uH1lRn1Wjq/c7afolJouynml8bkOrMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuIfulnpCMZiRq055YtiwngpAE1zygXsWtVjRivNYiIzCiEartA4eRQhdh8ntsz9Xq4Bgr9XkBALXpM5Yumv7viGD7ppWNiJYPs7B/Jqs1ZXHiyOrYesY7QszGsldoSvm+JFT/KV0RhVCnCITr0vnyRX3zHNO78TvSyJewaWwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K1PtXmuX; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f7019422so34796996d6.1
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 03:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742810487; x=1743415287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hVsbM6OPeXpSt/Q5vv0fCq6Er/pMh3PwD0M77sgjuU=;
        b=K1PtXmuXDCpfvBp2zGoKC2DNlWDWXIV/eZmlxSPmpsCdubiSnRN0d1NmL5YwzTlApp
         xiKlUQZqe3xfKEyMZLU/hkd8dVeB1g0HtzoSYDACeLrnOgQslbfavwziVMcugsfyBBAr
         Pw6V3Ubk26mdsQ8jCjtlQzD+Qv+C679fXrgZl+SMZnNlJ6RRioVYUXKUPDygLBTItAw7
         IjV86F01LY2RdOSlxialxCp+ljdctBJwBhXYuVTSpqYf/H3IPKo2LoTX9uMEfFrg0/iX
         V3WYJmwMkb+Jhyn6IjwiMSlTBf7bPXPfrE3nSpCTONU7+IU6ywUEmp2/AWBlxKNsfTS1
         cKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742810487; x=1743415287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hVsbM6OPeXpSt/Q5vv0fCq6Er/pMh3PwD0M77sgjuU=;
        b=EJdm1lFfiepNse/Y4UTteK2yFCY/g7hhagtMS58Liq2UIjqvYO1X4jcZtJfa71rweT
         VZ+jiAvVpoWtqWLbvpQGfVfUVkA8ifJeRAqDW3ue5b60lRyqFUIh52VnieMcWHz1kFo8
         KZbbBBrkeJc+UkEpYJx6P5eaphR1DOwrFSjwSktfPux0M/h6NAPTaMJuhtrxaHAs+pYc
         1qvC5a9uuXT9bz/tMqxYsYiaBj+M/28B9CHvfPUQTz4udxlrpyPmOol0jL5FmT+YgYPt
         oSS5L13xy/j03nT8zn6mxON9j41oT5Tiac/JmVQbWV0CkSkvbu+n5zq6ve8HtFDA7xmH
         eIcA==
X-Forwarded-Encrypted: i=1; AJvYcCVLMllgkYHa/A8SXWf8d8i56NpwAWgRjtHBl7w+7MhuiGpBlK0iB2yNl3eUh0vmdh54C+BzpDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGYjfzxAdolDKxiLhfjIoRwauexZ62haqgEqs5Ks8YbVU7sMYQ
	Oh6kghmOaY4sRrT94n2BxLMDpPUKsF0J0kf3io8zOU49bTt/xNAgxB+5Nck+mzT5/vdvbN8L63c
	JGKspfdiznqnD0C4zjWV3zcN6eCA6fBLQBz4P
X-Gm-Gg: ASbGnctUOE47VQyhD4b0JyU43pmtHBVw3WICF1uEGHcGXeEeGld64JsQ9DNiPzfGGq+
	EtJEpzbXkUEsViGAYlz7xrbWWrMo6DPyVkxukbGh+GMtPcohhG4eADN10hS0W2ASdfvRgHg5Sjo
	kh2CTe6WiKhYOPRQd6mgppIKEG8jA=
X-Google-Smtp-Source: AGHT+IGz5poYebQLXDXXH0EohMcwRNgE4HYwUdR4J2sPZv6OJ9B+hbXljv3vvZjR9c4oAx4gzku6rzUApfqAnytM42s=
X-Received: by 2002:a05:6214:212a:b0:6e8:f3b0:fa33 with SMTP id
 6a1803df08f44-6eb3f2799bfmr201072146d6.8.1742810486630; Mon, 24 Mar 2025
 03:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323231016.74813-1-kuniyu@amazon.com> <20250323231016.74813-2-kuniyu@amazon.com>
In-Reply-To: <20250323231016.74813-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Mar 2025 11:01:15 +0100
X-Gm-Features: AQ5f1JqbGCp3r-AGxTkF48Par2deHPYsG-B8oArmo6zsX2jNT3bSMtaiMR0wCDI
Message-ID: <CANn89iLu=6jT_2xvOOzkzQJzXVDroJyiMKC2B83dAwycat2Lhg@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/3] udp: Fix multiple wraparounds of sk->sk_rmem_alloc.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 12:11=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> __udp_enqueue_schedule_skb() has the following condition:
>
>   if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
>           goto drop;
>
> sk->sk_rcvbuf is initialised by net.core.rmem_default and later can
> be configured by SO_RCVBUF, which is limited by net.core.rmem_max,
> or SO_RCVBUFFORCE.
>
> If we set INT_MAX to sk->sk_rcvbuf, the condition is always false
> as sk->sk_rmem_alloc is also signed int.
>
> Then, the size of the incoming skb is added to sk->sk_rmem_alloc
> unconditionally.
>
> This results in integer overflow (possibly multiple times) on
> sk->sk_rmem_alloc and allows a single socket to have skb up to
> net.core.udp_mem[1].
>
> For example, if we set a large value to udp_mem[1] and INT_MAX to
> sk->sk_rcvbuf and flood packets to the socket, we can see multiple
> overflows:
>
>   # cat /proc/net/sockstat | grep UDP:
>   UDP: inuse 3 mem 7956736  <-- (7956736 << 12) bytes > INT_MAX * 15
>                                              ^- PAGE_SHIFT
>   # ss -uam
>   State  Recv-Q      ...
>   UNCONN -1757018048 ...    <-- flipping the sign repeatedly
>          skmem:(r2537949248,rb2147483646,t0,tb212992,f1984,w0,o0,bl0,d0)
>
> Previously, we had a boundary check for INT_MAX, which was removed by
> commit 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc").
>
> A complete fix would be to revert it and cap the right operand by
> INT_MAX:
>
>   rmem =3D atomic_add_return(size, &sk->sk_rmem_alloc);
>   if (rmem > min(size + (unsigned int)sk->sk_rcvbuf, INT_MAX))
>           goto uncharge_drop;
>
> but we do not want to add the expensive atomic_add_return() back just
> for the corner case.
>
> So, let's perform the first check as unsigned int to detect the
> integer overflow.
>
> Note that we still allow a single wraparound, which can be observed
> from userspace, but it's acceptable considering it's unlikely that
> no recv() is called for a long period, and the negative value will
> soon flip back to positive after a few recv() calls.
>
>   # cat /proc/net/sockstat | grep UDP:
>   UDP: inuse 3 mem 524288  <-- (INT_MAX + 1) >> 12
>
>   # ss -uam
>   State  Recv-Q      ...
>   UNCONN -2147482816 ...   <-- INT_MAX + 831 bytes
>          skmem:(r2147484480,rb2147483646,t0,tb212992,f3264,w0,o0,bl0,d144=
68947)
>
> Fixes: 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/udp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index a9bb9ce5438e..a1e60aab29b5 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1735,7 +1735,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, str=
uct sk_buff *skb)
>          */
>         rmem =3D atomic_read(&sk->sk_rmem_alloc);
>         rcvbuf =3D READ_ONCE(sk->sk_rcvbuf);
> -       if (rmem > rcvbuf)
> +       if ((unsigned int)rmem > rcvbuf)

SGTM, but maybe make rmem and rcvbuf  'unsigned int ' to avoid casts ?

BTW piling 2GB worth of skbs in a single UDP receive queue means a
latency spike when
__skb_queue_purge(&sk->sk_receive_queue) is called, say from
inet_sock_destruct(),
which is a problem on its own.


diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index db606f7e4163809d8220be1c1a4adb5662fc914e..575baac391e8af911fc1eff3f2d=
8e64bb9aa4c70
100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1725,9 +1725,9 @@ static int udp_rmem_schedule(struct sock *sk, int siz=
e)
 int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 {
        struct sk_buff_head *list =3D &sk->sk_receive_queue;
-       int rmem, err =3D -ENOMEM;
+       unsigned int rmem, rcvbuf;
+       int size, err =3D -ENOMEM;
        spinlock_t *busy =3D NULL;
-       int size, rcvbuf;

        /* Immediately drop when the receive queue is full.
         * Always allow at least one packet.

