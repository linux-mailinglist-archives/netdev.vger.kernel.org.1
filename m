Return-Path: <netdev+bounces-161083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BD1A1D3E5
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41E71656AF
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0543F1FC7D0;
	Mon, 27 Jan 2025 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2S5ySR4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5D25A63B
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737971645; cv=none; b=AssmJ4qx0/rwtzJrbOIZiyBZCUPIePQv9pXOW7tg2ypVb8LRfQHLDP+2GHepimM4CNJ45aVerwzXxp4CF/XvUAGY9U+DxIy44vmclWedUTRLg0E8JUxc+S8w2g83yxEkmpY3X3IADeZ8jY+hIGzkC4ApHlmv7Wx4cl+Zp6bi/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737971645; c=relaxed/simple;
	bh=hwLtkRe8AaTQn0PAhr3cXOffRsJL+ZQovNSoSksz4R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8gZ/JZTbXd8I2/iBNsBEkqWKirLnVrJhSLA3+fwBEksSMXOFsDKaAN8yzLQoQDnq/CzKSP5LqAswVPiVuStn1dXCdAhB9x1BstCZ1q+3n8TNmkmgqNQm42CNJC9cMy+Ls/SgIuMXYc2OSGfRw5ThlTVLZ1+ly7jfICgBP9reJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z2S5ySR4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5db6890b64eso8662752a12.3
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 01:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737971642; x=1738576442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma4xWZqtERgcJwwLrYW9gZ1pylvK07Wq2ibrzUvGFoQ=;
        b=z2S5ySR4aHjz3zDCn+enJJT/C+r7W9lHQiw0UFt2HYMSjzN1t4MS4bJG9cy2Waw1Ck
         WyKKd9SOq1bYooaH6RCHHfHsCKw9U/iHZqYWH2MBFp5kVi+ZinFyokz+W+210nwDXcU4
         BJdd/xdAU/rqhBfNAy6tk2b+jnVqR7qJxvqBm5zxX7ZesxMwyl2+9qVO6wWKGZpwoJNS
         tNYOQMB7AwK+q1HJEHRBM7Dd3JyDAkGF4p/lBtVAeOv92rUa6aDgRF7wB39vm8FKnUpa
         9lcLMPlrpOfOFvkCNtiwrW05c1v5P/TFpn582fb0daXZ1MiWpdkuOE4Xbhdq7pEreRHs
         7IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737971642; x=1738576442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma4xWZqtERgcJwwLrYW9gZ1pylvK07Wq2ibrzUvGFoQ=;
        b=SP0Xx639Qo7VdLqM0TKdrXHikhipNJQY0fFea5Dxamom3Pr6cP39Ynuqiz1ca2YPWp
         HDdhBFPaHE+weS5e7D5LfkFReEhmgX8AmDzy2NVLQFO1UVNNyecR1ftaYdmZ+TuWwtst
         802r5GkZwzsXC4MEnaemCrnZVLiC2BGre0CXFZVnmOLxH3tCqt9ut4nQa3C4KdiEeYIR
         SBjDlNIsnKY/2yIfHGcSZdqfWwQwUMksgu1rujrgJKWIcm2rs2P+Txd45HqEIZsLXA+V
         +TM3eRMAI6nJic3FFd1L28K8E+nObyuGdRuFopMk177DzGZdWM6wSRt+aRvTIut3F56W
         76kQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0vEMl59McvFEw4d7cqdfMIMtTdX3Vl/XItREGHmPuMC7G2o1WC3iZKYpfU+ILPl0lD5EHdnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytjnQ5kc+YBISljVQCblzGe37arl2qBteFgRtMFgbABOK8Nu0R
	AYrbSeI/p0CsZr14fn2ycs0lgcEFq6NEe8/bCAVstEZMojrizN1Dq6rxy4zKdnG5FG+VnIa/Qnq
	NLa1qUUO5sNLlTElod12I2Hx7hszuV3l9SY0e
X-Gm-Gg: ASbGncsu9BexCkagHgJ8Bf2+qMdm31zv3Mygxd+oxIXQ6rgsqZvBiR1Fq9pBVAhfLcH
	Ekxm1LmY05ROSpSTXD3tJxrQjBXljPp1apP63+ekZlk2avQvElcWHP4mOekwaT9ffvKOk9pGz
X-Google-Smtp-Source: AGHT+IEmaJXq2g4rc62972VT9fXm4yWlnYthW0YtJduUthkxDklMiCIaNjWtCluaTI9eIj8koZzfM4WatksMZ/2dBfQ=
X-Received: by 2002:a05:6402:268e:b0:5d3:ce7f:abe4 with SMTP id
 4fb4d7f45d1cf-5db7db06dd7mr35494579a12.25.1737971642271; Mon, 27 Jan 2025
 01:54:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117214035.2414668-1-jmaloy@redhat.com> <CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
 <afb9ff14-a2f1-4c5a-a920-bce0105a7d41@redhat.com> <c41deefb-9bc8-47b8-bff0-226bb03265fe@redhat.com>
 <CANn89i+RRxyROe3wx6f4y1nk92Y-0eaahjh-OGb326d8NZnK9A@mail.gmail.com> <e15ff7f6-00b7-4071-866a-666a296d0b15@redhat.com>
In-Reply-To: <e15ff7f6-00b7-4071-866a-666a296d0b15@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Jan 2025 10:53:51 +0100
X-Gm-Features: AWEUYZll_MgNF4TmyyjJCRECouNnTMg1NhAdqvkdaiFbOabe2hKTbmMR0pTCu8I
Message-ID: <CANn89i+nYrqoxWH_16J6=dcnau_6_jzgfkhx5YnXkUMzm7JXJA@mail.gmail.com>
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
To: Jon Maloy <jmaloy@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com, 
	Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 6:40=E2=80=AFPM Jon Maloy <jmaloy@redhat.com> wrote=
:
>
>
>
> On 2025-01-20 11:22, Eric Dumazet wrote:
> > On Mon, Jan 20, 2025 at 5:10=E2=80=AFPM Jon Maloy <jmaloy@redhat.com> w=
rote:
> >>
> >>
> >>
> >> On 2025-01-20 00:03, Jon Maloy wrote:
> >>>
> >>>
>
> [...]
>
> >>>> I agree with Eric that probably tp->pred_flags should be cleared, an=
d
> >>>> a packetdrill test for this would be super-helpful.
> >>>
> >>> I must admit I have never used packetdrill, but I can make an effort.
> >>
> >> I hear from other sources that you cannot force a memory exhaustion wi=
th
> >> packetdrill anyway, so this sounds like a pointless exercise.
> >
> > We certainly can and should add a feature like that to packetdrill.
> >
> > Documentation/fault-injection/ has some relevant information.
> >
> > Even without this, tcp_try_rmem_schedule() is reading sk->sk_rcvbuf
> > that could be lowered by a packetdrill script I think.
> >
> Neal, Eric,
> How do you suggest we proceed with this?
> I downloaded packetdrill and tried it a bit, but to understand it well
> enough to introduce a new feature would require more time than I am
> able to spend on this. Maybe Neal, who I see is one of the contributors
> to packetdrill could help out?

 I will spend some time this week preparing for some tests.

I would prefer not merging new code without a clear understanding of the is=
sue.

Thanks.

>
> I can certainly clear tp->pred_flags and post it again, maybe with
> an improved and shortened log. Would that be acceptable?
>
> I also made a run where I looked into why __tcp_select_window()
> ignores all the space that has been freed up:
>
>
>   tcp_recvmsg_locked(->)
>     __tcp_cleanup_rbuf(->) (copied 131072)
>       tp->rcv_wup: 1788299855, tp->rcv_wnd: 5812224,
>       tp->rcv_nxt 1793800175
>       __tcp_select_window(->)
>         tcp_space(->)
>         tcp_space(<-) returning 458163
>         free_space =3D round_down(458163, 1 << 4096) =3D 454656
>         (free_space > tp->rcv_ssthresh) -->
>           free_space =3D tp->rcv_ssthresh =3D 261920
>         window =3D ALIGN(261920, 4096) =3D 26144
>       __tcp_select_window(<-) returning 262144
>       [rcv_win_now 311904, 2 * rcv_win_now 623808, new_window 262144]
>       (new_window >=3D (2 * rcv_win_now)) ? --> time_to_ack 0
>       NOT calling tcp_send_ack()
>     __tcp_cleanup_rbuf(<-)
>     [tp->rcv_wup 1788299855, tp->rcv_wnd 5812224,
>      tp->rcv_nxt 1793800175]
>   tcp_recvmsg_locked(<-) returning 131072 bytes.
>   [tp->rcv_nxt 1793800175, tp->rcv_wnd 5812224,
>    tp->rcv_wup 1788299855, sk->last_ack 0, tcp_receive_win() 311904,
>    copied_seq 1788299855->1788395953 (96098), unread 5404222,
>    sk_rcv_qlen 83, ofo_qlen 0]
>
>
> As we see tp->rcv_ssthresh is the limiting factor, causing
> a consistent situation where (new_window < (rcv_win_now * 2)),
> and even (new_window < rcv_win_now).
>
> To me, it looks like tp->ssthresh should have a higher value
> in this situation, or maybe we should alter this test.
>
> The combination of these two issues, -not updating tp->wnd and
> _tcp_select_window() returning a wrong value, is what is causing
> this whole problem.
>
> ///jon
>
>
>
>
>

