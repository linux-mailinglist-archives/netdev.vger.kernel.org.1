Return-Path: <netdev+bounces-207560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E70B07CFA
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 20:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6417F3B4694
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1579287245;
	Wed, 16 Jul 2025 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjCKFUg+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9363242909
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690825; cv=none; b=puU0gVPBY1Gy8RtgkHZwlhQWiWUp+qqI4uBv1v9LEtQ4Vyy18OTKnSapM4KtyYaAX0BcGd1lX2FzgoGFrlnqTiGrXyGEOjn+NBCOwIS18LFkZ7/QYFVb4vFZzSsUIAQVe1SfJNxGdOZlK3G2698Evi+NTb0QSQeJ2cBbgHOo8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690825; c=relaxed/simple;
	bh=2PlGqhByxxmNPpy9WqSdbiYQvFGS2+QpVzWrzY9yVGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8C7MQcJibcJxKnH875Gr6JnIQpAOhAKYDdpMqk/jdyDragljHgHNcfy88lV7reLPjf19qXBwy5PuFhwqJutImrC1adXvpXAOpbw+CCnPSq+V0rmaTuMp5dqu5mPexsb3h+424P2mCodL7VUeFe8ZTpJ92LkNqIdvDlluL5maTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjCKFUg+; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3226307787so87412a12.1
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752690823; x=1753295623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpbBIE6VZb4neKxYjg4Tskes73yyrFR7E2JPnsAnw/I=;
        b=qjCKFUg++Pe+gE30OiassXye1/82wR3X0y3gNJycS30k5Sl7ajirHLRRjDmU1lBqbw
         XBRdx4e9BEzh6HVeXPrxGhN+89JZSMZloEqdAWmb77P6k3J42tbOu6XfkHCXfuX0hpvg
         h6d8pJ4m7832iLwa+bpGsZRwJgsGEY0TBJQ2ti3BBN0FrwzId0eHlfGrAkbPE6LMq6jk
         taBKvEz0h2WreOEYXxWsIcFa+1cO8AEqvjPNccGE59b4UkOd8Ac086pVrMpZbBrodBAc
         zsOFdl6uV/ov+3HSJi57oxHVY6Q96A/V+3CtpRx1W5xZNJB3lzj46C+yzBLuiXZCTZ6h
         6wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752690823; x=1753295623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpbBIE6VZb4neKxYjg4Tskes73yyrFR7E2JPnsAnw/I=;
        b=YMi7pBBGjTBqvr0MJIv0ejmrnxjrGYH+AKaJ8Ue2jOHstcpqW/svY9olC7wTc+EuEl
         ryEMK7zufxPzug2U7XwLLRnYc6myYsP4+34KBDTOh/1Ls/kK/VAfuHdUPzKkmW0T/dvW
         mGg5Y7LiC4oixT3Ftf8L5yL3GWlmIy4K/IYWOg7GxYJ3scdR/DbYvRpv/3BBEmA2IWqN
         GoEN9zJHSYWJF5VQF7GnIcO4dp/QAvYsjhA+wrZ1L/e8+0P8X8OLBk8TrC+ep2pUdCr/
         be49MgKkGPl0Wjic+SExsPVrDBQh8mnEvKw9Hznn62D8Pfnq5uKYjJ873x2HTJSNATAI
         0mZw==
X-Forwarded-Encrypted: i=1; AJvYcCWy5/UPfBWf7ZjyEc9/UQPCHGkYIiCbDfjsy99xRWyfiDHhZJtVTsayTR5vTsNs9PRVv/E9AiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH9gKsQG454UBK7kU4AQf+gmpIZwnIMKV7tKsYOjKaF/wtwyU+
	lTgjxQiFfA2EFMJfoMFW0Besukx8qDzjqS7PPaz7HQUMaNl+rmXihTDLfcm98yzzghrYuzcaaHG
	SKLVQLDix+QeZr3VAnEl/058T8Exu/9VAqSXTDavd
X-Gm-Gg: ASbGncss8aSteK1xXyeITmgR/V9kz4gGqGgbjmcENxmB7gpc1e3ww9VnTmAe1IY78jN
	NZlycu5Mh+L4KfhWa/q8BPnZjrr8lpxh1Z8u4QnxCPnZQ4q+biykaPg9w0C33MJmx45yjkiNiA2
	T66DmGDGPOS+AduKUgqK9qBcf00bFK98l+VHN+6HLRvZG5GxACWdtSDHrYPsmpLPYcQk7j3UO0g
	Kxa7eVd+vLrNcJd4qD66ZLkzoH3ZiX0hesKBNQFX2UBWdx5
X-Google-Smtp-Source: AGHT+IFhda0RVK/FgbAFUsObdIzmqEGoa3JbuNgOYmUB3mkLE67GWjOdBeit0I+XoV41s9AepKz862Wnzvy60WFoWXY=
X-Received: by 2002:a17:90b:224e:b0:311:c1ec:7d0a with SMTP id
 98e67ed59e1d1-31c9f4cf4bemr4276917a91.25.1752690822850; Wed, 16 Jul 2025
 11:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716100006458kPWBPIJB6IdzWuUKlv4tF@zte.com.cn>
In-Reply-To: <20250716100006458kPWBPIJB6IdzWuUKlv4tF@zte.com.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 16 Jul 2025 11:33:30 -0700
X-Gm-Features: Ac12FXyOspCHhAx87c88VO1duhZR6TZrGQh2VzNA4krdYiossFF4birkUv2k-pc
Message-ID: <CAAVpQUCDJOnwRhjcwFke2vTZQ8rymopC3hpyPteLA3cRgXFz9Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6] tcp: trace retransmit failures in tcp_retransmit_skb
To: fan.yu9@zte.com.cn
Cc: kuba@kernel.org, edumazet@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, yang.yang29@zte.com.cn, 
	xu.xin16@zte.com.cn, tu.qiang35@zte.com.cn, jiang.kun2@zte.com.cn, 
	qiu.yutan@zte.com.cn, wang.yaxin@zte.com.cn, he.peilin@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 7:00=E2=80=AFPM <fan.yu9@zte.com.cn> wrote:
>
> From: Fan Yu <fan.yu9@zte.com.cn>
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> When TCP retransmits a packet due to missing ACKs, the
> retransmission may fail for various reasons (e.g., packets
> stuck in driver queues, receiver zero windows, or routing issues).
>
> The original tcp_retransmit_skb tracepoint:
>
> 'commit e086101b150a ("tcp: add a tracepoint for tcp retransmission")'
>
> lacks visibility into these failure causes, making production
> diagnostics difficult.
>
> Solution
> =3D=3D=3D=3D=3D=3D=3D=3D
> Adds the retval("err") to the tcp_retransmit_skb tracepoint.
> Enables users to know why some tcp retransmission failed and
> users can filter retransmission failures by retval.
>
> Compatibility description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> This patch extends the tcp_retransmit_skb tracepoint
> by adding a new "err" field at the end of its
> existing structure (within TP_STRUCT__entry). The
> compatibility implications are detailed as follows:
>
> 1) Structural compatibility for legacy user-space tools
> Legacy tools/BPF programs accessing existing fields
> (by offset or name) can still work without modification
> or recompilation.The new field is appended to the end,
> preserving original memory layout.
>
> 2) Note: semantic changes
> The original tracepoint primarily only focused on
> successfully retransmitted packets. With this patch,
> the tracepoint now can figure out packets that may
> terminate early due to specific reasons. For accurate
> statistics, users should filter using "err" to
> distinguish outcomes.
>
> Before patched:
> # cat /sys/kernel/debug/tracing/events/tcp/tcp_retransmit_skb/format
> field:const void * skbaddr; offset:8; size:8; signed:0;
> field:const void * skaddr; offset:16; size:8; signed:0;
> field:int state; offset:24; size:4; signed:1;
> field:__u16 sport; offset:28; size:2; signed:0;
> field:__u16 dport; offset:30; size:2; signed:0;
> field:__u16 family; offset:32; size:2; signed:0;
> field:__u8 saddr[4]; offset:34; size:4; signed:0;
> field:__u8 daddr[4]; offset:38; size:4; signed:0;
> field:__u8 saddr_v6[16]; offset:42; size:16; signed:0;
> field:__u8 daddr_v6[16]; offset:58; size:16; signed:0;
>
> print fmt: "skbaddr=3D%p skaddr=3D%p family=3D%s sport=3D%hu dport=3D%hu =
saddr=3D%pI4 daddr=3D%pI4 saddrv6=3D%pI6c daddrv6=3D%pI6c state=3D%s"
>
> After patched:
> # cat /sys/kernel/debug/tracing/events/tcp/tcp_retransmit_skb/format
> field:const void * skbaddr; offset:8; size:8; signed:0;
> field:const void * skaddr; offset:16; size:8; signed:0;
> field:int state; offset:24; size:4; signed:1;
> field:__u16 sport; offset:28; size:2; signed:0;
> field:__u16 dport; offset:30; size:2; signed:0;
> field:__u16 family; offset:32; size:2; signed:0;
> field:__u8 saddr[4]; offset:34; size:4; signed:0;
> field:__u8 daddr[4]; offset:38; size:4; signed:0;
> field:__u8 saddr_v6[16]; offset:42; size:16; signed:0;
> field:__u8 daddr_v6[16]; offset:58; size:16; signed:0;
> field:int err; offset:76; size:4; signed:1;
>
> print fmt: "skbaddr=3D%p skaddr=3D%p family=3D%s sport=3D%hu dport=3D%hu =
saddr=3D%pI4 daddr=3D%pI4 saddrv6=3D%pI6c daddrv6=3D%pI6c state=3D%s err=3D=
%d"
>
> Suggested-by: KuniyukiIwashima <kuniyu@google.com>

I don't deserve this tag.  (Also, a space between first/last name is missin=
g.)

Suggested-by can be used when the core idea is provided by someone,
but not when someone just reviews the patch and points out something
wrong.

But code-wise, the change looks good to me.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Co-developed-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> ---
> Change Log
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> v5->v6:
> Some fixes according to
> https://lore.kernel.org/all/20250715183335.860529-1-kuniyu@google.com/
> 1. fixed HTML entity conversion in email and adjusted error counting logi=
c.
>
> v4->v5:
> Some fixes according to
> https://lore.kernel.org/all/20250715072058.12f343bb@kernel.org/
> 1. Instead of introducing new TCP_RETRANS_* enums, directly
> passing the retval to the tracepoint.
>
> v3->v4:
> Some fixes according to
> https://lore.kernel.org/all/CANn89i+JGSt=3D_CtWfhDXypWW-34a6SoP3RAzWQ9B9V=
L4+PHjDw@mail.gmail.com/
> 1. Consolidate ENOMEMs into a unified TCP_RETRANS_NOMEM.
>
> v2->v3:
> Some fixes according to
> https://lore.kernel.org/all/CANn89iJvyYjiweCESQL8E-Si7M=3DgosYvh1BAVWwAWy=
cXW8GSdg@mail.gmail.com/
> 1. Rename "quit_reason" to "result". Also, keep "key=3Dval" format concis=
e(no space in vals).
>
> v1->v2:
> Some fixes according to
> https://lore.kernel.org/all/CANn89iK-6kT-ZUpNRMjPY9_TkQj-dLuKrDQtvO1140q4=
EUsjFg@mail.gmail.com/
> 1.Rename TCP_RETRANS_QUIT_UNDEFINED to TCP_RETRANS_ERR_DEFAULT.
> 2.Added detailed compatibility consequences section.
>
>  include/trace/events/tcp.h | 27 ++++++++--------------
>  net/ipv4/tcp_output.c      | 46 ++++++++++++++++++++++++--------------
>  2 files changed, 38 insertions(+), 35 deletions(-)
>
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 54e60c6009e3..9d2c36c6a0ed 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -13,17 +13,11 @@
>  #include <linux/sock_diag.h>
>  #include <net/rstreason.h>
>
> -/*
> - * tcp event with arguments sk and skb
> - *
> - * Note: this class requires a valid sk pointer; while skb pointer could
> - *       be NULL.
> - */
> -DECLARE_EVENT_CLASS(tcp_event_sk_skb,
> +TRACE_EVENT(tcp_retransmit_skb,
>
> -       TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
> +       TP_PROTO(const struct sock *sk, const struct sk_buff *skb, int er=
r),
>
> -       TP_ARGS(sk, skb),
> +       TP_ARGS(sk, skb, err),
>
>         TP_STRUCT__entry(
>                 __field(const void *, skbaddr)
> @@ -36,6 +30,7 @@ DECLARE_EVENT_CLASS(tcp_event_sk_skb,
>                 __array(__u8, daddr, 4)
>                 __array(__u8, saddr_v6, 16)
>                 __array(__u8, daddr_v6, 16)
> +               __field(int, err)
>         ),
>
>         TP_fast_assign(
> @@ -58,21 +53,17 @@ DECLARE_EVENT_CLASS(tcp_event_sk_skb,
>
>                 TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_dadd=
r,
>                               sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
> +
> +               __entry->err =3D err;
>         ),
>
> -       TP_printk("skbaddr=3D%p skaddr=3D%p family=3D%s sport=3D%hu dport=
=3D%hu saddr=3D%pI4 daddr=3D%pI4 saddrv6=3D%pI6c daddrv6=3D%pI6c state=3D%s=
",
> +       TP_printk("skbaddr=3D%p skaddr=3D%p family=3D%s sport=3D%hu dport=
=3D%hu saddr=3D%pI4 daddr=3D%pI4 saddrv6=3D%pI6c daddrv6=3D%pI6c state=3D%s=
 err=3D%d",
>                   __entry->skbaddr, __entry->skaddr,
>                   show_family_name(__entry->family),
>                   __entry->sport, __entry->dport, __entry->saddr, __entry=
->daddr,
>                   __entry->saddr_v6, __entry->daddr_v6,
> -                 show_tcp_state_name(__entry->state))
> -);
> -
> -DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
> -
> -       TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
> -
> -       TP_ARGS(sk, skb)
> +                 show_tcp_state_name(__entry->state),
> +                 __entry->err)
>  );
>
>  #undef FN
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index b616776e3354..caf11920a878 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3330,8 +3330,10 @@ int __tcp_retransmit_skb(struct sock *sk, struct s=
k_buff *skb, int segs)
>         if (icsk->icsk_mtup.probe_size)
>                 icsk->icsk_mtup.probe_size =3D 0;
>
> -       if (skb_still_in_host_queue(sk, skb))
> -               return -EBUSY;
> +       if (skb_still_in_host_queue(sk, skb)) {
> +               err =3D -EBUSY;
> +               goto out;
> +       }
>
>  start:
>         if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
> @@ -3342,14 +3344,19 @@ int __tcp_retransmit_skb(struct sock *sk, struct =
sk_buff *skb, int segs)
>                 }
>                 if (unlikely(before(TCP_SKB_CB(skb)->end_seq, tp->snd_una=
))) {
>                         WARN_ON_ONCE(1);
> -                       return -EINVAL;
> +                       err =3D -EINVAL;
> +                       goto out;
> +               }
> +               if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)-=
>seq)) {
> +                       err =3D -ENOMEM;
> +                       goto out;
>                 }
> -               if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)-=
>seq))
> -                       return -ENOMEM;
>         }
>
> -       if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk))
> -               return -EHOSTUNREACH; /* Routing failure or similar. */
> +       if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk)) {
> +               err =3D -EHOSTUNREACH; /* Routing failure or similar. */
> +               goto out;
> +       }
>
>         cur_mss =3D tcp_current_mss(sk);
>         avail_wnd =3D tcp_wnd_end(tp) - TCP_SKB_CB(skb)->seq;
> @@ -3360,8 +3367,10 @@ int __tcp_retransmit_skb(struct sock *sk, struct s=
k_buff *skb, int segs)
>          * our retransmit of one segment serves as a zero window probe.
>          */
>         if (avail_wnd <=3D 0) {
> -               if (TCP_SKB_CB(skb)->seq !=3D tp->snd_una)
> -                       return -EAGAIN;
> +               if (TCP_SKB_CB(skb)->seq !=3D tp->snd_una) {
> +                       err =3D -EAGAIN;
> +                       goto out;
> +               }
>                 avail_wnd =3D cur_mss;
>         }
>
> @@ -3373,11 +3382,15 @@ int __tcp_retransmit_skb(struct sock *sk, struct =
sk_buff *skb, int segs)
>         }
>         if (skb->len > len) {
>                 if (tcp_fragment(sk, TCP_FRAG_IN_RTX_QUEUE, skb, len,
> -                                cur_mss, GFP_ATOMIC))
> -                       return -ENOMEM; /* We'll try again later. */
> +                                cur_mss, GFP_ATOMIC)) {
> +                       err =3D -ENOMEM;  /* We'll try again later. */
> +                       goto out;
> +               }
>         } else {
> -               if (skb_unclone_keeptruesize(skb, GFP_ATOMIC))
> -                       return -ENOMEM;
> +               if (skb_unclone_keeptruesize(skb, GFP_ATOMIC)) {
> +                       err =3D -ENOMEM;
> +                       goto out;
> +               }
>
>                 diff =3D tcp_skb_pcount(skb);
>                 tcp_set_skb_tso_segs(skb, cur_mss);
> @@ -3431,17 +3444,16 @@ int __tcp_retransmit_skb(struct sock *sk, struct =
sk_buff *skb, int segs)
>                 tcp_call_bpf_3arg(sk, BPF_SOCK_OPS_RETRANS_CB,
>                                   TCP_SKB_CB(skb)->seq, segs, err);
>
> -       if (likely(!err)) {
> -               trace_tcp_retransmit_skb(sk, skb);
> -       } else if (err !=3D -EBUSY) {
> +       if (unlikely(err) && err !=3D -EBUSY)
>                 NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRETRANSFAIL, seg=
s);
> -       }
>
>         /* To avoid taking spuriously low RTT samples based on a timestam=
p
>          * for a transmit that never happened, always mark EVER_RETRANS
>          */
>         TCP_SKB_CB(skb)->sacked |=3D TCPCB_EVER_RETRANS;
>
> +out:
> +       trace_tcp_retransmit_skb(sk, skb, err);
>         return err;
>  }
>
> --
> 2.25.1

