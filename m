Return-Path: <netdev+bounces-161112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CFBA1D6FA
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 14:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BA41886BB2
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320371FF1C4;
	Mon, 27 Jan 2025 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVCvCQvF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58A1FDA84
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737985106; cv=none; b=FS8/dkGOybj/6q1lDEKYyapVV3kVg9WCD3/153vxudjb7KsvOSq4oavmmxtesqxI9bgppSP0KjQTze0iUFJi9ALKh0wdnMTSTuIr2FKE78+XnG9xJJ4w2+a03gNOYTMJkCf7LIPRbOMmrRuRSbsky8RcjWkx76fDCj8jAgClCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737985106; c=relaxed/simple;
	bh=JDZMNf7lCYXszFwAnroTEjcwUAmUcn0iF5vKPyHtRjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lz057/5kp12Iku/CJfvfNMG0qyfDBR4R/gCzZq5ZQYbx93NLaBBffJ9Fp9fWNB4y0jjowoUEbXgfthgr4bGwwxsZuDd+C5J4LVHnoukFM2/V2O9AT5A8jOq+K5qJ9hj2JZT5M/pRDnTs8qITwR680lUcdGf62xMS88EV+SzDyZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVCvCQvF; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e479e529ebcso5658116276.3
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 05:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737985103; x=1738589903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/m4bNax3mvm571AsnC8jtRusVwQLXsEzhjxRPyvW2ko=;
        b=lVCvCQvFk9lsILeo017poI0fp5CJG1tQr8SqGm/8GGmNHJ2fOkLoDYJlEe0D1s+Ni/
         XBhJzL57Fb+ecGXG7djmlMf2ZR40cORje5ZeifmaPJRvT2QZPV66MVetcocvO46tSPmN
         IA/Fa5Xq+YhuC0hkc4df9mdLOsAm+hU7fbJjkMAtwRnPG0vtYtropYMwnpZ3MiePhLLM
         ZR3poQwvNvgRA9LaetXXWM95d6dqIYXXA6SnKiOYEP80C2WLRYEhmvqblyL8KMEoBVEJ
         WLqFMZ/S3o9ayPNMim4al8AgmGUrP05uhSohQJpydFyFopjoWY20fD7njj2IfA2uIqYw
         XSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737985103; x=1738589903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/m4bNax3mvm571AsnC8jtRusVwQLXsEzhjxRPyvW2ko=;
        b=uUCyLMTjmVlLD/lwecYLqAQn7lLyipe913fHpTcNNWDju2iJWIdua4qHMEfhoMuK5y
         noG66BFyV8jhKT57EtVVrdolKhkS8mEmnJ9nuZtKhg9zsXQlCajJBTOD95OpD0a58Bd2
         CnQwCzH0+wRn+mEgLLp1WRNza18+hPhZ6LiRFfw8I7SrrFVqKIb+Xq+5HR6dZd6UDaDt
         5as//0gsJZGXlCJvAWEZzGTW/Yf8t1KGZY9wEvm9f1D4KJlxs/6+SpFNqw6sC3bctR3Z
         +fq9h/aj3dZ/wsmeVMDBoitf+AbRY/l30DlqQBQQAIlULDSSjBe7RZ9Z/kGIsStlVhtX
         3orA==
X-Forwarded-Encrypted: i=1; AJvYcCU0VUyK4QnA3x+AgZa/HXTXOEwnq0agU6Er+MUfvYIuzB7ZDo41M0PkMG70keIJuqNk8NK4PfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuSxZyhsGqVBrrsNzTjsLaVFC7gvkk6SUeKHCL5/jl49A6LYxr
	4irLEGyrzg0qiqnsBTLjO8cILRjfoa0geMn9L+zTlBsWS7EmSXF4oVKe9+BnL9fw9GzONUiBP3n
	AwR+JF1SBJL/yzSagsGwCBee/UcM=
X-Gm-Gg: ASbGnctl85lqZZGqilB85VOMoUYEFCyvyfby8gb5gqP77Ql4oIG8xv9V9ujxaci4FFC
	15NL69ti3cxGDpvesc1BsGPxMTx/ErhTPZu2d8hnP6Ik4VzAhYICO54gxdyJstQ==
X-Google-Smtp-Source: AGHT+IHo/v27RytTX8hu0X01pjjFZoduu3VL7UiwWJ9Rz9WpDWaU0bUj6ukOEQxOxclkg+jfZmvUYJYbb81l82UaZh0=
X-Received: by 2002:a05:6902:2e01:b0:e58:30c9:c684 with SMTP id
 3f1490d57ef6-e5830c9c815mr11186277276.15.1737985103294; Mon, 27 Jan 2025
 05:38:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117214035.2414668-1-jmaloy@redhat.com> <CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
 <afb9ff14-a2f1-4c5a-a920-bce0105a7d41@redhat.com> <c41deefb-9bc8-47b8-bff0-226bb03265fe@redhat.com>
 <CANn89i+RRxyROe3wx6f4y1nk92Y-0eaahjh-OGb326d8NZnK9A@mail.gmail.com>
 <e15ff7f6-00b7-4071-866a-666a296d0b15@redhat.com> <20250127110121.1f53b27d@elisabeth>
 <CAL+tcoBwEG_oVn3WL_gXxSkZLs92qeMgEvgwhGM0g0maA=xJ=g@mail.gmail.com> <20250127113214.294bcafb@elisabeth>
In-Reply-To: <20250127113214.294bcafb@elisabeth>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 27 Jan 2025 21:37:23 +0800
X-Gm-Features: AWEUYZlU6knkjXO45irCari8w8PtWQgQolh7IjF_Vp7DArLkHK4uj8TC84dXQwI
Message-ID: <CADxym3Zji3NZy2tBAxSm5GaQ8tVG8PmxcyJ_AGnUC-H386tq7g@mail.gmail.com>
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 6:32=E2=80=AFPM Stefano Brivio <sbrivio@redhat.com>=
 wrote:
>
> On Mon, 27 Jan 2025 18:17:28 +0800
> Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> > I'm not that sure if it's a bug belonging to the Linux kernel.
>
> It is, because for at least 20-25 years (before that it's a bit hard to
> understand from history) a non-zero window would be announced, as
> obviously expected, once there's again space in the receive window.

Sorry for the late reply. I think the key of this problem is
what should we do when we receive a tcp packet and we are
out of memory.

The RFC doesn't define such a thing, so in the commit
e2142825c120 ("net: tcp: send zero-window ACK when no memory"),
I reply with a zero-window ACK to the peer. And the peer will keep
probing the window by retransmitting the packet that we dropped if
the peer is a LINUX SYSTEM.

As I said, the RFC doesn't define such a case, so the behavior of
the peer is undefined if it is not a LINUX SYSTEM. If the peer doesn't
keep retransmitting the packet, it will hang the connection, just like
the problem that described in this commit log.

However, we can make some optimization to make it more
adaptable. We can send a ACK with the right window to the
peer when the memory is available, and __tcp_cleanup_rbuf()
is a good choice.

Generally speaking, I think this patch makes sense. However,
I'm not sure if there is any other influence if we make
"tp->rcv_wnd=3D0", but it can trigger a ACK in __tcp_cleanup_rbuf().

Following is the code that I thought before to optimize this
case (the code is totally not tested):

diff --git a/include/net/inet_connection_sock.h
b/include/net/inet_connection_sock.h
index 3c82fad904d4..bedd78946762 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -116,7 +116,8 @@ struct inet_connection_sock {
         #define ATO_BITS 8
         __u32          ato:ATO_BITS,     /* Predicted tick of soft
clock       */
                   lrcv_flowlabel:20, /* last received ipv6 flowlabel      =
 */
-                  unused:4;
+                  is_oom:1,
+                  unused:3;
         unsigned long      timeout;     /* Currently scheduled
timeout           */
         __u32          lrcvtime;     /* timestamp of last received
data packet */
         __u16          last_seg_size; /* Size of last incoming segment    =
   */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..6f3c85a1f4da 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1458,11 +1458,11 @@ static int tcp_peek_sndq(struct sock *sk,
struct msghdr *msg, int len)
  */
 void __tcp_cleanup_rbuf(struct sock *sk, int copied)
 {
+    struct inet_connection_sock *icsk =3D inet_csk(sk);
     struct tcp_sock *tp =3D tcp_sk(sk);
     bool time_to_ack =3D false;

     if (inet_csk_ack_scheduled(sk)) {
-        const struct inet_connection_sock *icsk =3D inet_csk(sk);

         if (/* Once-per-two-segments ACK was not sent by tcp_input.c */
             tp->rcv_nxt - tp->rcv_wup > icsk->icsk_ack.rcv_mss ||
@@ -1502,6 +1502,11 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copied)
                 time_to_ack =3D true;
         }
     }
+    if (unlikely(icsk->icsk_ack.is_oom)) {
+        icsk->icsk_ack.is_oom =3D false;
+        time_to_ack =3D true;
+    }
+
     if (time_to_ack)
         tcp_send_ack(sk);
 }
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0e5b9a654254..e2d65213b3b7 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -268,9 +268,12 @@ static u16 tcp_select_window(struct sock *sk)
      * are out of memory. The window is temporary, so we don't store
      * it on the socket.
      */
-    if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM))
+    if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)) {
+        inet_csk(sk)->icsk_ack.is_oom =3D true;
         return 0;
+    }

+    inet_csk(sk)->icsk_ack.is_oom =3D false;
     cur_win =3D tcp_receive_window(tp);
     new_win =3D __tcp_select_window(sk);
     if (new_win < cur_win) {

>
> > The other side not sending a window probe causes this issue...?
>
> It doesn't cause this issue, but it triggers it.
>
> > The other part of me says we cannot break the user's behaviour.
>
> This sounds quite relevant, yes.
>
> --
> Stefano
>

