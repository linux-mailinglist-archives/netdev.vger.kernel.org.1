Return-Path: <netdev+bounces-180286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98881A80E36
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2713BF711
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C0422A4EE;
	Tue,  8 Apr 2025 14:27:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D522A1D4;
	Tue,  8 Apr 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122476; cv=none; b=QCl7mY612Uo30oRvVe1+ob0sXilymU/BnzKQ50b7mhrHXQ0RTo3zbaOenOWV0eVEppx1FcQmEgDy7j9F/36lM/iYItmPMm0sBezKks50UPm4BlBV8/WgNlyCo2Vm9G2utqHsptCe+7Ivwww0fiAUSApiun1rramMPDf/gI9ZZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122476; c=relaxed/simple;
	bh=xCQx6pVBQuY50n/ThS6l3eDpdCQ0n7uANGpFPi/NPf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQ5lDWUDJWZ8xCQqULUU1Tx+3C+fWCeo/zWrHRXdnallq5XfQJSgDs7rFO0BW/YWV0YoPsqPTWrL323uyhNkRovoVU0/RgzjkUrmxdyNn4Wv7r+J/DclXwL8GFsfzOj6RWYeQHviZUv0x4j8TvUEt+6X4Mody0Fuu8QylFUE5VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2c663a3daso1048706566b.2;
        Tue, 08 Apr 2025 07:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122472; x=1744727272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SznZ6qZnobtkHQp+nWu8KywESKsAZVjAuQpll7td4h0=;
        b=kM6UYY4ppU0bIHMfIpLqDC0eQd3sg/cMUL933Ejdfz9K8lkLmG4Iiwbw7Fc9NAWRev
         dZZKfKHlDTiHX7mnxVxn6On4z+R2j04qUdTxs2FByl8pF1vFtSDkaOWB4ONliQAQQhuQ
         /ltCKywfr5hJqs5Js7rfH8dzcDw/hwQM7cbywWCT8WNS0x+UHn733kiwJdAwYdQHuSYS
         nwXRDyR2PoEskfkXsE7rnKI1dyyTf5tCsjAZKrNxmZ9GIw4XGEr6dg0oFw+gIuBdXB4I
         7MNbulBHxq7mka5vb818IuEqRW6It8mPgYuOq0qaSEBBG6zp4vfw3ydJkOdwy9jgl/Qy
         Litw==
X-Forwarded-Encrypted: i=1; AJvYcCVL9ufNNsgyPqxTbKBzjZelXuk03yANFDbiMo42HcoIiZ/RsCV9ZWlN4eEe4bjChwCXvmuQ2rm/AAX11dkP+QI1HTeK@vger.kernel.org, AJvYcCVVoFfjgBk1zlVPLiuHDNYuqYNCl3lezs2d1+g21yi0Oes4ThAfhLc5w8GvlEbcC5kly8QAgDTOSslqwJY=@vger.kernel.org, AJvYcCW0JT0KUimyaqVUnGm+UDCTVBfNBR4Mu3mTK6xh5juVqGR7w0RvKccD58yEG6YfxbW+Q1uFUJTq@vger.kernel.org
X-Gm-Message-State: AOJu0YxwhArUAT8ZZUoP3frmYahyNUbrlBy74jln0ArRtVq2VmX5RIJC
	Kf/m8KlgCY0AEsuJQbQn/MJ3C9WQtMO8pGVtcSMxsNF8QDtbyz5Y
X-Gm-Gg: ASbGncsLVqHFl6HMeDh8amNCG54qVpwjjheXcpio5ncVhXnv2l+Sb5BHxzSa8tGtONE
	JwSGb/NLhy4kTjNwf9uIjy4e1Dyq8Vu9AwnO5KJimXuTgnUIi70talVOW2OZ4QENzbwxpYRnxQz
	te/F1c3mkcbfpn4/Cs+dIBPtSledTwCRV8qeeX/Z1tAC2OqQlSwvYE9GAJdGlw5z455LknjcM7a
	AO1MhmRP8hVXndreDz6MUGTkz15DS+rwMhmUg1mszP2bsLPrMlI6lPi7mLkrwdVdTVHb5q8/RK0
	WRw/4IRJcSVaJX9N89aY4Aos0SmAfC2X+PnXY4FYHmuQIdw=
X-Google-Smtp-Source: AGHT+IGett8TErJin1Ya7KdCWqWrSSa5r8YUYvZ4okNkGjCVk5JAd1RrGPiUJkuyGAwb5+W3jA2waA==
X-Received: by 2002:a17:907:1c0e:b0:ac3:bdd2:e70c with SMTP id a640c23a62f3a-ac7d195c0e2mr1468071966b.35.1744122472109;
        Tue, 08 Apr 2025 07:27:52 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe988b3sm909323166b.40.2025.04.08.07.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:27:51 -0700 (PDT)
Date: Tue, 8 Apr 2025 07:27:48 -0700
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
	rostedt@goodmis.org, song@kernel.org, yonghong.song@linux.dev
Subject: Re: [PATCH net-next v2 2/2] trace: tcp: Add tracepoint for
 tcp_sendmsg_locked()
Message-ID: <Z/UyZNiYUq9qrZds@gmail.com>
References: <20250407-tcpsendmsg-v2-2-9f0ea843ef99@debian.org>
 <20250408010143.11193-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408010143.11193-1-kuniyu@amazon.com>

Hello Kuniyuki,

On Mon, Apr 07, 2025 at 06:00:35PM -0700, Kuniyuki Iwashima wrote:
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index ea8de00f669d0..270ce2c8c2d54 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1160,6 +1160,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
> >  		if (skb)
> >  			copy = size_goal - skb->len;
> >  
> > +		trace_tcp_sendmsg_locked(sk, msg, skb, size_goal);
> 
> skb could be NULL, so I think raw_tp_null_args[] needs to be updated.
> 
> Maybe try attaching a bpf prog that dereferences skb unconditionally
> and see if the bpf verifier rejects it.

I've been trying to dereference skb (while 0), and bpf verifier rejects
it.

Here is the code I wrote to test:

	SEC("tracepoint/tcp/tcp_sendmsg_locked")
	int bpf_tcp_sendmsg_locked(struct tcp_sendmsg_locked_args *ctx)
	{
		bpf_printk("TCP: skb_addr %p skb_len %d msg_left %d size_goal %d",
			ctx->skb_addr, ctx->skb_len, ctx->msg_left, ctx->size_goal);
	
		return 0;
	}

And it matches the tracepoint, but, trying to dereference skb_addr fails
in all forms. I tried with a proper dereference, or, something as simple
as the following, and the program is not loaded.

	bpf_printk("deref %d\n", *(int *) ctx->skb_addr);

Here is all it returns.

	libbpf: prog 'bpf_tcp_sendmsg_locked': BPF program load failed: Permission denied
	libbpf: prog 'bpf_tcp_sendmsg_locked': -- BEGIN PROG LOAD LOG --
	0: R1=ctx() R10=fp0
	; int bpf_tcp_sendmsg_locked(struct tcp_sendmsg_locked_args *ctx) @ tcp_sendmsg_locked_bpf.c:16
	0: (bf) r6 = r1                       ; R1=ctx() R6_w=ctx()
	; bpf_printk("TCP: skb_addr %p skb_len %d msg_left %d size_goal %d", @ tcp_sendmsg_locked_bpf.c:19
	1: (79) r1 = *(u64 *)(r6 +8)          ; R1_w=scalar() R6_w=ctx()
	2: (7b) *(u64 *)(r10 -32) = r1        ; R1_w=scalar(id=1) R10=fp0 fp-32_w=scalar(id=1)
	3: (61) r1 = *(u32 *)(r6 +16)         ; R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R6_w=ctx()
	4: (67) r1 <<= 32                     ; R1_w=scalar(smax=0x7fffffff00000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))
	5: (c7) r1 s>>= 32                    ; R1_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
	6: (7b) *(u64 *)(r10 -24) = r1        ; R1_w=scalar(id=2,smin=0xffffffff80000000,smax=0x7fffffff) R10=fp0 fp-24_w=scalar(id=2,smin=0xffffffff80000000,smax=0x7fffffff)
	7: (61) r1 = *(u32 *)(r6 +20)         ; R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R6_w=ctx()
	8: (67) r1 <<= 32                     ; R1_w=scalar(smax=0x7fffffff00000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))
	9: (c7) r1 s>>= 32                    ; R1_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
	10: (7b) *(u64 *)(r10 -16) = r1       ; R1_w=scalar(id=3,smin=0xffffffff80000000,smax=0x7fffffff) R10=fp0 fp-16_w=scalar(id=3,smin=0xffffffff80000000,smax=0x7fffffff)
	11: (61) r1 = *(u32 *)(r6 +24)        ; R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R6_w=ctx()
	12: (67) r1 <<= 32                    ; R1_w=scalar(smax=0x7fffffff00000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))
	13: (c7) r1 s>>= 32                   ; R1_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
	14: (7b) *(u64 *)(r10 -8) = r1        ; R1_w=scalar(id=4,smin=0xffffffff80000000,smax=0x7fffffff) R10=fp0 fp-8_w=scalar(id=4,smin=0xffffffff80000000,smax=0x7fffffff)
	15: (bf) r3 = r10                     ; R3_w=fp0 R10=fp0
	16: (07) r3 += -32                    ; R3_w=fp-32
	17: (18) r1 = 0xff1100010965cdd8      ; R1_w=map_value(map=tcp_send.rodata,ks=4,vs=63)
	19: (b7) r2 = 53                      ; R2_w=53
	20: (b7) r4 = 32                      ; R4_w=32
	21: (85) call bpf_trace_vprintk#177   ; R0_w=scalar()
	; bpf_printk("deref %d\n", *(int *) ctx->skb_addr); @ tcp_sendmsg_locked_bpf.c:22
	22: (79) r1 = *(u64 *)(r6 +8)         ; R1_w=scalar() R6_w=ctx()
	23: (61) r3 = *(u32 *)(r1 +0)
	R1 invalid mem access 'scalar'
	processed 23 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
	-- END PROG LOAD LOG --
	libbpf: prog 'bpf_tcp_sendmsg_locked': failed to load: -13
	libbpf: failed to load object 'tcp_sendmsg_locked_bpf.o'
	Failed to load BPF object: -13

I've pushed this example to the following URL, if you want to experiment
as well:

	https://github.com/leitao/debug/blob/main/bpf/tracepoint/tcp_sendmsg_locked_bpf.c

> See this commit for the similar issue:
> 
> commit 5da7e15fb5a12e78de974d8908f348e279922ce9
> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date:   Fri Jan 31 19:01:42 2025 -0800
> 
>     net: Add rx_skb of kfree_skb to raw_tp_null_args[].
> 

Thanks for the heads-up. I can populate raw_tp_null_args with this new
tracepoint function, if that is the right thing to do, even without
being able to reproduce the issue above.

Thanks for the review,
--breno

