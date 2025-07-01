Return-Path: <netdev+bounces-202972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F5CAF0003
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FB718871FC
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B9927C145;
	Tue,  1 Jul 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNG+gFTN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97036276058
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387872; cv=none; b=bkXBcZ7S5Uef7gVjf3dUYTUS58r+zlIpw0GajbCZmTWkM2K+E/eWf0H0huzLWcAk78xkeb6ZYF+BJXgrPfB7PoyjyPq0WW5eebLWD4V5OQ/zmCx1zyVacFVlHAaSyXSHX1vJYF+pjDO7B6v9hKFHJ5A8bYmz1wyuDV5/aNLcbAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387872; c=relaxed/simple;
	bh=X6kzkxRq62hrdupe3Qvl/V+UACrDKcA+1A0KKz6FZ1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJzB1s7CZncqGFocuK3SHXPVz/qoqLm7ef75K0faQlwY5tNNjYWWX0KMvauMedQ+yAYw1ue7i2AKOCOFP+wewdIDtXxH90JowPmYvx0atnaUMCdGYhjK+9rJTJjO+gKYMAxYfNUvUgwHqE6Mwgsu46Q0KJ7e83R0m1NnX6ztqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNG+gFTN; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a44b3526e6so77214501cf.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751387868; x=1751992668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ISLdnPxtlGKf/l3qBzDBKL53pla5A655ILSzv3SOEo=;
        b=CNG+gFTNiS8q27Lc3rAnzX2kqNYFwukkVeemw3MluDuzyhQL2rUyRS1VnsylKJbj08
         NPTWiDrPhE0iFKGcu2nORXtov1juVEPoskpIrpDyJl5jMjGD0J5UUvlWyRyf6SzB8nFQ
         Tvo9lQo7RFYf6rPFAFGUAODPWhZS52gMYenzVkD9sWPXuU5LdLS0ZbY9wt19mlYpBj07
         b+CGfZ+QuYZR2z8qXQcoTXVHGCESIg3qrPMhFCa29psLvkBb3cp7gElcBZFnlJoAd7KT
         lmklmf6+1Po2EpUf5wF3urrEsniunuA2PPlgYS7xQVaw3RNvKKOfoqYUeQTVXfsFdxQ6
         OZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751387868; x=1751992668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ISLdnPxtlGKf/l3qBzDBKL53pla5A655ILSzv3SOEo=;
        b=m19ANLR/qezABZRZYVv8d2jU1jXNxZ4TYXs52MME+XtEkqDcc81Z0rYJUL/xCXCEr0
         kWMLhf6LmVs/Hb4ZN3CSx+O7pETVMjNfb0yeS9H0fDvQYI/yhsv/447wt5FhNDcZ6GgL
         43OEGou5nISw5W6P7nEmLn7ozHBHxJXBHu6ZgBsUY8CnEU9eTqdCIZvu/DZiUzHQNCJT
         31XlvzaKv0Jd9DSVx7VnufjGwEMmiFufv9KXXshniKlksWfSkjHpGA6a0b6atNjdo7vj
         WslnLJz98wJdlnPIqBzHjUqH/6DDPGXzcY8mxx1YJzjCCLpelUmztLeyScfkzSv5E+9F
         9sTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwvrBGp03TxYpjFOijbuzattzIc7UbpP4RN2Wublo0IzcYkmqz1NMac8U5d7ewNcmH1ocxL6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhy+zfOWbdxITA+ckP2PL1dbzHwDrHIq4NRrOpiJ2qeN4D+twL
	kg9oPC3oECU7//xd41FaBQp+PMHmvOL3I/9scRDHuVYBtfELC6Wp3yqyxJsPHgS5+occYFPrS1B
	GUAODdtZvZBRyTcMilRzCBbyvq40w8+8jAPwuXtDP
X-Gm-Gg: ASbGncs+VlKldl8T9nVS6Yja3FIkC99FGEc+I9dkFvLrPMOKAowWXVj2tR1b2xKugHW
	VgcNYwNFpHZb7pgMHevzI4tvFsXRIXEK4xQnlQIlbabnZ5yEDSO9+BJ4ITtWF/CcxHspr33wgPj
	tis4gb7/Kb7rigvqS87xHKCf0Lkjo9KVM2Yt5F5jbv+sk=
X-Google-Smtp-Source: AGHT+IHAiK9oEfXH92Sml4i6lZf1ziKhaKb1A45g7ei6HvCGgdoXpQF1Hurv306Xf8kKYruBW3bAWalu9wYw+TNdGaw=
X-Received: by 2002:a05:622a:54f:b0:4a7:ba7:1a2d with SMTP id
 d75a77b69052e-4a7fc9cfbd9mr291679101cf.4.1751387867916; Tue, 01 Jul 2025
 09:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701174051880riwWtq_0siCJ5Yfsa6ZOQ@zte.com.cn>
In-Reply-To: <20250701174051880riwWtq_0siCJ5Yfsa6ZOQ@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Jul 2025 09:37:36 -0700
X-Gm-Features: Ac12FXzwmxaj70tKP4W8HtmDFZSM027mPiLZs_ytA57MBpY7K3gg1Pk__C05asI
Message-ID: <CANn89iJvyYjiweCESQL8E-Si7M=gosYvh1BAVWwAWycXW8GSdg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: extend tcp_retransmit_skb tracepoint
 with failure reasons
To: xu.xin16@zte.com.cn
Cc: kuba@kernel.org, kuniyu@amazon.com, ncardwell@google.com, 
	davem@davemloft.net, horms@kernel.org, dsahern@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, fan.yu9@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 2:42=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
>
> From: Fan Yu <fan.yu9@zte.com.cn>
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> When TCP retransmits a packet due to missing ACKs, the
> retransmission may fail for various reasons (e.g., packets
> stuck in driver queues, sequence errors, or routing issues).
>
> The original tcp_retransmit_skb tracepoint:
> 'commit e086101b150a ("tcp: add a tracepoint for tcp retransmission")'
> lacks visibility into these failure causes, making production
> diagnostics difficult.
>
> Solution
> =3D=3D=3D=3D=3D=3D=3D
> Adds a 'reason' field to the tcp_retransmit_skb tracepoint,
> enumerating with explicit failure cases:
> TCP_RETRANS_ERR_DEFAULT (retransmit terminate unexpectedly)
> TCP_RETRANS_IN_HOST_QUEUE (packet still queued in driver)
> TCP_RETRANS_END_SEQ_ERROR (invalid end sequence)
> TCP_RETRANS_TRIM_HEAD_NOMEM (trim head no memory)
> TCP_RETRANS_UNCLONE_NOMEM (skb unclone keeptruesize no memory)
> TCP_RETRANS_FRAG_NOMEM (fragment no memory)
> TCP_RETRANS_ROUTE_FAIL (routing failure)
> TCP_RETRANS_RCV_ZERO_WINDOW (closed recevier window)
> TCP_RETRANS_PSKB_COPY_NOBUFS (no buffer for skb copy)
>
> Functionality
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Enables users to know why some tcp retransmission quitted and filter
> retransmission failures by reason.
>
>

...

> +enum tcp_retransmit_quit_reason {
> +       TCP_RETRANS_ERR_DEFAULT,
> +       TCP_RETRANS_SUCCESS,
> +       TCP_RETRANS_IN_HOST_QUEUE,
> +       TCP_RETRANS_END_SEQ_ERROR,
> +       TCP_RETRANS_TRIM_HEAD_NOMEM,
> +       TCP_RETRANS_UNCLONE_NOMEM,
> +       TCP_RETRANS_FRAG_NOMEM,
> +       TCP_RETRANS_ROUTE_FAIL,
> +       TCP_RETRANS_RCV_ZERO_WINDOW,
> +       TCP_RETRANS_PSKB_COPY_NOBUFS,
> +};
> +
>  #define tcp_sk(ptr) container_of_const(ptr, struct tcp_sock, inet_conn.i=
csk_inet.sk)
>
>  /* Variant of tcp_sk() upgrading a const sock to a read/write tcp socket=
.
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 54e60c6009e3..3e24740d759e 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -13,17 +13,38 @@
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
> +#define TCP_RETRANSMIT_QUIT_REASON             \
> +               ENUM(TCP_RETRANS_ERR_DEFAULT,           "retransmit termi=
nate unexpectedly")    \
> +               ENUM(TCP_RETRANS_SUCCESS,               "retransmit succe=
ssfully")              \
> +               ENUM(TCP_RETRANS_IN_HOST_QUEUE,         "packet still que=
ued in driver")        \
> +               ENUM(TCP_RETRANS_END_SEQ_ERROR,         "invalid end sequ=
ence")                 \
> +               ENUM(TCP_RETRANS_TRIM_HEAD_NOMEM,       "trim head no mem=
ory")                  \
> +               ENUM(TCP_RETRANS_UNCLONE_NOMEM,         "skb unclone keep=
truesize no memory")   \
> +               ENUM(TCP_RETRANS_FRAG_NOMEM,            "fragment no memo=
ry")                   \

Do we really need 3 + 1 different 'NOMEMORY' status ?

> +               ENUM(TCP_RETRANS_ROUTE_FAIL,            "routing failure"=
)                      \
> +               ENUM(TCP_RETRANS_RCV_ZERO_WINDOW,       "closed recevier =
window")               \

receiver

> +               ENUMe(TCP_RETRANS_PSKB_COPY_NOBUFS,     "no buffer for sk=
b copy")               \

-> another NOMEM...

> +
> +


> +               __entry->quit_reason =3D quit_reason;
>         ),
>
> -       TP_printk("skbaddr=3D%p skaddr=3D%p family=3D%s sport=3D%hu dport=
=3D%hu saddr=3D%pI4 daddr=3D%pI4 saddrv6=3D%pI6c daddrv6=3D%pI6c state=3D%s=
",
> +       TP_printk("skbaddr=3D%p skaddr=3D%p family=3D%s sport=3D%hu dport=
=3D%hu saddr=3D%pI4 daddr=3D%pI4 saddrv6=3D%pI6c daddrv6=3D%pI6c state=3D%s=
 quit_reason=3D%s",

quit_reason is really weird, since most retransmits are a success.

What about using : status or result ?

Also, for scripts parsing the output, I would try to keep  key=3Dval
format (no space in @val), and concise 'vals'

