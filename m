Return-Path: <netdev+bounces-120161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3AC958775
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0F31C211B4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9B718FDD7;
	Tue, 20 Aug 2024 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpLoToj4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489F018FDD6
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158597; cv=none; b=pnQrD2aqKarJ9sTghBsJrdUi6OfOsN44BPQFgIsNDjrouSu2BMUHyWAUPlbqEmd78Frqo9p9DEXh05VdJbwB7IySybux/WY4wysN7AXF2vMaHMtHzRrCT/0WdI4Sh1zTGz2AI4DpJJ73QbZjcgDlxC0BnD1KStKCkP6TAfW0E4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158597; c=relaxed/simple;
	bh=2agLDYvfmRHIoYioG5EBQ4mhTF+2q27mh66dpq/qJe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeggRMnAJ32HRBJnKPauMj/m2MIdjeY18b8KhvqN2vekQHDb+3Pz9cscBFiT/EoOhMXybk+HVepaeZzhx0R2Fppik3QqUL5L0SDXizS0L5DCY0U3KcJKqSdwG51ZjcgV3KBQs6tUOOBGmTg4X7YGEdU+Ep4FDIVYhK03WOms1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpLoToj4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so586714766b.1
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 05:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724158593; x=1724763393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOASvQ4CR++EtYZUJV4rjQZRusWTnHENwwMDQoZt+Bk=;
        b=lpLoToj4Dcmt9N+Nra1C75AGaEyFH7+7Zx66lRRiEM0O1IT+rH+s/oc0ESm0BAwl6e
         j60B0F80XzPJBhMErd5YxobwcVHfycpQ0D/PhGh6y3TA+K0EX2W4cP+qVQUk0lAuQBai
         NeaSWYm4kqzI1Zqu8REiImJK79DfZNKoKt6+AC/PA72r96BmLXUIHcUgfz2jHXni71Sk
         QiyL51EWphW74ZuX+bLdwtSBFsz/9J5yzfeeLnrFuNIiCbx3UOxRWteiwXfYAHs45zDK
         Ag3Q2RpJo243zwPfiHwesiVBEsqaGR/SlM30yJS3N0EANovD81ZXfcxu79LX1EJvXSvS
         CaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724158593; x=1724763393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOASvQ4CR++EtYZUJV4rjQZRusWTnHENwwMDQoZt+Bk=;
        b=Gc1cFUs8dZQ9ep+QcXWXvWUHeR/NA7539XhH+X4S8Vww0Mjg8f75cI9E1AIp+zACTE
         L1c6nkTEc7lo5d3yFw5q0eo0+uh/8VUosApUArqgB11cxj1zyVssJUCoLnhLGAdwqexH
         V9DCjIEoXvwTBFnlwATaP1pGckz6Gx2J86V+RrOk1nPS4mlVvURpe/WML5xM6ZK1mPaC
         XzhJMLZCEAylCNN0g8BMzVBhDlnvs7EbthBtOaG/I9pYKSZg4mCiaPuXLntMTBfcrJ8q
         XdgSA3fKW4CYk69UiX+DrUvVxPw59J5qLGBQVFgzPLbI4KJkZJvGY2ANb6LSnLgFAUPF
         faFg==
X-Forwarded-Encrypted: i=1; AJvYcCU3LDRvqc38Ioo+6NYKT3oQAN1vqQQYcEN37Jf0PB4Y2x77S1CkuWIntM+ENj4Hkr2B5tIdK/yC1hE38Gh7R996nc+a3GMI
X-Gm-Message-State: AOJu0YwgOXTzMCw/K9ppyh1vhiu69bacu2tJDnW/uVsyCS1cWb6uzr79
	IZ55RtZ/PnH+KPQXRCWEOmzqbgVzRWsU49YPCUTR4gwjA7Dz7L/aww8tNgjfwAc9tsIbZzs2xHE
	Oi32vMV743MWq6DejZ2R3Y5cbXTnUKo3vl4KK
X-Google-Smtp-Source: AGHT+IEmLq2BI+DvwvjHc16CImQdYkMwYKajt/Sd60mxa1nFDccqd2vW2ord3NN8n3+ScxgIFw0T5BhSxSFRa4ldbgM=
X-Received: by 2002:a17:907:efca:b0:a7d:33f0:4d58 with SMTP id
 a640c23a62f3a-a83929d2e13mr1017451366b.48.1724158592777; Tue, 20 Aug 2024
 05:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817163400.2616134-1-mrzhang97@gmail.com> <20240817163400.2616134-3-mrzhang97@gmail.com>
 <CANn89iKPnJzZA3NopjpVE_5wiJtxf6q2Run8G2S8Q4kvwPT-QA@mail.gmail.com> <adb76a64-18de-41b4-a12d-e6bc3e288252@gmail.com>
In-Reply-To: <adb76a64-18de-41b4-a12d-e6bc3e288252@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Aug 2024 14:56:21 +0200
Message-ID: <CANn89iK+d65eT3sP8Wo8cGb4a_39cDF_kHG=Fn5cmcv93gzBvg@mail.gmail.com>
Subject: Re: [PATCH net v4 2/3] tcp_cubic: fix to match Reno additive increment
To: Mingrui Zhang <mrzhang97@gmail.com>
Cc: davem@davemloft.net, ncardwell@google.com, netdev@vger.kernel.org, 
	Lisong Xu <xu@unl.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 11:03=E2=80=AFPM Mingrui Zhang <mrzhang97@gmail.com=
> wrote:
>
> On 8/19/24 03:22, Eric Dumazet wrote:
> > On Sat, Aug 17, 2024 at 6:35=E2=80=AFPM Mingrui Zhang <mrzhang97@gmail.=
com> wrote:
> >> The original code follows RFC 8312 (obsoleted CUBIC RFC).
> >>
> >> The patched code follows RFC 9438 (new CUBIC RFC):
> > Please give the precise location in the RFC (4.3 Reno-Friendly Region)
>
> Thank you, Eric,
> I will write it more clearly in the next version patch to submit.
>
> >
> >> "Once _W_est_ has grown to reach the _cwnd_ at the time of most
> >> recently setting _ssthresh_ -- that is, _W_est_ >=3D _cwnd_prior_ --
> >> the sender SHOULD set =CE=B1__cubic_ to 1 to ensure that it can achiev=
e
> >> the same congestion window increment rate as Reno, which uses AIMD
> >> (1,0.5)."
> >>
> >> Add new field 'cwnd_prior' in bictcp to hold cwnd before a loss event
> >>
> >> Fixes: 89b3d9aaf467 ("[TCP] cubic: precompute constants")
> > RFC 9438 is brand new, I think we should not backport this patch to
> > stable linux versions.
> >
> > This would target net-next, unless there is clear evidence that it is
> > absolutely safe.
>
> I agree with you that this patch would target net-next.
>
> > Note the existence of tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
> > and tools/testing/selftests/bpf/progs/bpf_cubic.c
> >
> > If this patch was a fix, I presume we would need to fix these files ?
> In my understanding, the bpf_cubic.c and bpf_cc_cubic.c are not designed =
to create a fully equivalent version of tcp_cubic, but more focus on BPF lo=
gic testing usage.
> For example, the up-to-date bpf_cubic does not involve the changes in com=
mit 9957b38b5e7a ("tcp_cubic: make hystart_ack_delay() aware of BIG TCP")
>
> Maybe we would ask BPF maintainers whether to fix these BPF files?

We try (as TCP maintainers) to keep
tools/testing/selftests/bpf/progs/bpf_cubic.c up to date with the
kernel C code.
Because _if_ someone is really using BPF based cubic, they should get
the fix eventually.

See for instance

commit 7d21d54d624777358ab6c7be7ff778808fef70ba
Author: Neal Cardwell <ncardwell@google.com>
Date:   Wed Jun 24 12:42:03 2020 -0400

    bpf: tcp: bpf_cubic: fix spurious HYSTART_DELAY exit upon drop in min R=
TT

    Apply the fix from:
     "tcp_cubic: fix spurious HYSTART_DELAY exit upon drop in min RTT"
    to the BPF implementation of TCP CUBIC congestion control.

    Repeating the commit description here for completeness:

    Mirja Kuehlewind reported a bug in Linux TCP CUBIC Hystart, where
    Hystart HYSTART_DELAY mechanism can exit Slow Start spuriously on an
    ACK when the minimum rtt of a connection goes down. From inspection it
    is clear from the existing code that this could happen in an example
    like the following:

    o The first 8 RTT samples in a round trip are 150ms, resulting in a
      curr_rtt of 150ms and a delay_min of 150ms.

    o The 9th RTT sample is 100ms. The curr_rtt does not change after the
      first 8 samples, so curr_rtt remains 150ms. But delay_min can be
      lowered at any time, so delay_min falls to 100ms. The code executes
      the HYSTART_DELAY comparison between curr_rtt of 150ms and delay_min
      of 100ms, and the curr_rtt is declared far enough above delay_min to
      force a (spurious) exit of Slow start.

    The fix here is simple: allow every RTT sample in a round trip to
    lower the curr_rtt.

    Fixes: 6de4a9c430b5 ("bpf: tcp: Add bpf_cubic example")
    Reported-by: Mirja Kuehlewind <mirja.kuehlewind@ericsson.com>
    Signed-off-by: Neal Cardwell <ncardwell@google.com>
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

