Return-Path: <netdev+bounces-192668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B756AC0C25
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F2F1892CEB
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B5E28B3F9;
	Thu, 22 May 2025 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZmkZopR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5121635963
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747918976; cv=none; b=Dm6ypOUAh+Y9Cs2FlyNRutB0KLZl/RywrqAkuZA8QTaVfrClYVQ3zLExqcg9hvtS48tjaXqQyWQ/QgvY5Y5kFEGK4teccW7WX+NrHRMBnHvEWPNkQc/RbKI2mnQsPHnYdiifm33XpMc2nIegzY1czNd3mgyK8Qjf44/wS+EYAuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747918976; c=relaxed/simple;
	bh=Zdmq/J4jC/9RoGx6mYI9Ny57vnjoGwqK3Ih9kwM9kj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNkTSrzRdvmUkqcvicLHeQJJSxpaIoKYSwTlRtNRK7nAiso4abLYEJ44sjicYashFe+vnAovSXBt2psMMYcI65g3kwblH1DhJ9ICWaG3P78ojgXa8RPsGKHoJUT8ZepW0KBjGb0+w6ZF1YzNRqwkknBXt9cMCbjf6ejD/xLGbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZmkZopR; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47666573242so1827371cf.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 06:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747918973; x=1748523773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zdmq/J4jC/9RoGx6mYI9Ny57vnjoGwqK3Ih9kwM9kj0=;
        b=hZmkZopRF36wH4Fxlmc3Gfn1gUdE6I3tTEImjrBFTIoYWMy+6t+h+Laji4pqCoJbzd
         2hDheVDKRwKgasJpx1T+DIFMIBHhJSBXi9gL47vFK/7JdNrgDjnQt6cd0PqY+uFnPqPN
         99XljA4MkWRTj2uOZYgh3N1rQhcXHehQDeLDXTwFjiRydEfHL52qWvhZo3ooNdZYlWsw
         8nnKVbQrxbjWXktc4i9vJEBw7TUF/euplarz5tctnQA57hdxbbQ2D3ptlwUuxmjkNslL
         KkhRgTvPEuL2ffHgxvhgZs0v863BNaXVoaaiux7PqSPmPUAL0B/nmh/Dj3mwKkJYkFyh
         6isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747918973; x=1748523773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zdmq/J4jC/9RoGx6mYI9Ny57vnjoGwqK3Ih9kwM9kj0=;
        b=G157Fs6c97qjsupEimWA5s7Gw5Zji895DzZLHUjMbwB96KBARFgc/OdCN52HpNN5IX
         lowE4XpLr6D9If7WQdwlD7tmzeQMX6hzNgpkfxfX6T/wbbSjt40gpQYOaUR0SRzVev6o
         MIyVqOrqOSqkBOigckdCB1Vw6OAYQ0LfcKuEAP/nOK+5d6cRoXNQBpXG86rbNE3rxjxj
         pRjeTOkbKicHpXNvfR52y0p3Ck9d8UpkP37LgbS7W2QixECafLi+iLpc9NKSuMQtcJxg
         vgjIRzCJqhclkGf7SjSJLjNZfxOirlAyo93gNo0a39XrZpBZVofgIDc1xhC7C3YuC3Im
         bHlA==
X-Gm-Message-State: AOJu0YzloW1sTVnJOFNXWIw0yW11hoAhsbeD3I+t8BCFyZq8Q3S3f3lk
	tViYm7jMU7O/g6EeiyXTVBeMH5Lu1bNMr4VvFOKW2iu6i6DQUnI88TehB58csYaZnuqpNUigL2E
	LI2bVpAmoI1TdAs0OOWxUJOzLsnNcPG9dlIUwkAp8
X-Gm-Gg: ASbGnctuHO3CenjmngLLsDsM1XorA98WIsTcQA7qHhPaW5X2hLxSWZHXDTO8dYUCEvM
	LKgMc3MQULnPiPza7kivbHIkOi7kayxvqUeajKP2rlx9S4mQ3bPnvrAM5GoJWhzHlG3m0K8Msa/
	c7H7UdgJgoCGAO4o3etgO7g/5joG9m2HuaMefOEzPa4Z2Zva+7wj8OYVxRlnS0AAcZ/n9dg68gu
	PC7
X-Google-Smtp-Source: AGHT+IH5Im59hQJj6pgAr0wU8NMjEMK0+67zGNqmLaihLEHvRbIaW2GhUbrHfb6CAv2pNAq9zX6hQG9duT/R/uIeBvg=
X-Received: by 2002:a05:622a:120a:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-49cefbe14b9mr2819541cf.3.1747918972690; Thu, 22 May 2025
 06:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAHxn9-ctPXJh1jeZc3bYeNod6pdfd6qgYWuXMb9uN_12McPAQ@mail.gmail.com>
 <CADVnQy=RRLaTG4t5BqQ1XJskb+oxWe=M_qY0u9rzmXGS1+b7nQ@mail.gmail.com>
 <CAAHxn98G9kKtVi34mC+NHwasixZd63C8+s5gC5T5o-vKUVVoKQ@mail.gmail.com>
 <CADVnQyn=MXohOf1vskJcm9VTOeP31Y5AqCPu7B=zZuTB8nh8Eg@mail.gmail.com>
 <CAAHxn9_++G0icFE1F+NCfnj3AkErmytQ3LUz2C-oY-TJKbdwmg@mail.gmail.com>
 <CADVnQymURKQQHHwrcGRKqgbZuJrEpaC6t7tT7VeUsETcDTWg2Q@mail.gmail.com> <CAAHxn9_waCMAh3Me63WQv+1h=FmT10grA13t09xaym4hX1KgCg@mail.gmail.com>
In-Reply-To: <CAAHxn9_waCMAh3Me63WQv+1h=FmT10grA13t09xaym4hX1KgCg@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 22 May 2025 09:02:36 -0400
X-Gm-Features: AX0GCFvNmb9pEkNV2myml4MsTBr5eGLx8GKxb-MAY5A9-OpOoMFHI_a6iFK53KA
Message-ID: <CADVnQynDkHVmTdnMZ+ZvDtwF9EVcOOphDbr+eLUMBijbc+2nQw@mail.gmail.com>
Subject: Re: Re: [EXT] Re: tcp: socket stuck with zero receive window after SACK
To: Simon Campion <simon.campion@deepl.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 6:34=E2=80=AFAM Simon Campion <simon.campion@deepl.=
com> wrote:
>
> On Wed, 21 May 2025 at 17:56, Neal Cardwell <ncardwell@google.com> wrote:
> > For my education, why do you set net.ipv4.tcp_shrink_window=3D1?
>
> We enabled it mainly as an attempt to decrease the frequency of a
> different issue in which jumbo frames were dropped indefinitely on a
> host, presumably after memory pressure, discussed in [1]. The jumbo
> frame issue is most likely triggered by system-wide memory pressure
> rather than hitting net.ipv4.tcp_mem. So,
> net.ipv4.tcp_shrink_window=3D1, which, as far as we understand, makes
> hitting net.ipv4.tcp_mem less likely, probably didn't help with
> decreasing the frequency of the jumbo frame issue. But the issue had
> sufficiently serious impact and we were sufficiently unsure about the
> root cause that we deemed net.ipv4.tcp_shrink_window=3D1 worth a try.
> (Also, the rationale behind net.ipv4.tcp_shrink_window=3D1 laid out in
> [2] and [3] sounded reasonable.)
>
> But yes, it's feasible for us to revert to the default
> net.ipv4.tcp_shrink_window=3D0, in particular because there's another
> workaround for the jumbo frame issue: reduce the MTU. We've set
> net.ipv4.tcp_shrink_window=3D0 yesterday and haven't seen the issue
> since. So:
>
> 6.6.74 + net.ipv4.tcp_shrink_window=3D1: issue occurs
> 6.6.83 + net.ipv4.tcp_shrink_window=3D1: issue occurs
> 6.6.74 + net.ipv4.tcp_shrink_window=3D0: no issue so far
> 6.6.83 + net.ipv4.tcp_shrink_window=3D0: no issue so far
>
> Since the issue occurred sporadically, it's too soon to be fully
> confident that it's gone with net.ipv4.tcp_shrink_window=3D0. We'll
> write again in a week or so to confirm.

Thanks for the data points and testing!

I agree it will take a while to gather more confidence that the issue
is gone for your workload with net.ipv4.tcp_shrink_window=3D0.

Based on your data, my current sense is that for your workload the
buggy behavior was triggered by net.ipv4.tcp_shrink_window=3D1.

However, AFAICT with the current code there could be similar problems
with the default net.ipv4.tcp_shrink_window=3D0 setting if the socket
suffers a memory pressure event while there is a tiny amount of free
receive buffer.

> If net.ipv4.tcp_shrink_window=3D1 seems to have caused this issue, we'd
> still be curious to understand why it leads to TCP connections being
> stuck indefinitely even though the recv-q (as reported by ss) is 0.
> Assuming the recv-q was indeed correctly reported as 0, the issue
> might be that receive buffers can fill up in a way so that the only
> way for data to leave the receive buffer is receipt of further data.
> In particular, the application can't read data out of the receive
> buffer and empty it that way. Maybe filling up buffers with data
> received out-of-order (whether we SACK it or not) satisfies this
> condition. This would explain why we saw this issue only in the
> presence of SACK flags before we disabled SACK. With
> net.ipv4.tcp_shrink_window=3D1, a full receive buffer leads to a zero
> window being advertised (see [2]) and if the buffer filled up in a way
> so that no data can leave until further data is received, we are stuck
> forever because the kernel drops incoming data due to the zero window.
> In contrast, with ipv4.tcp_shrink_window=3D0, we will keep advertising a
> non-zero window, so incoming data isn't dropped and we can have data
> leave the receive buffer.

Yes, this matches my theory of the case as well.

Except I would add that with ipv4.tcp_shrink_window=3D0, AFAICT with
recent kernels a receiver can get into a situation where a memory
pressure event while there is a tiny amount of free receive buffer can
cause the receiver to set tp->rcv_wnd to 0, and thus get into a
similar situation where the receiver (due to the zero window) will
keep advertising a zero window and dropping incoming data without
pruning SACKed skbs to make room in the receive buffer.

(It sounds like in your case the net.ipv4.tcp_shrink_window=3D1 is
triggering the problem rather than the memory pressure issue.)

> ... I'm speculating here; once we confirm that
> the issue seems to have been triggered by
> net.ipv4.tcp_shrink_window=3D1, I'd be keen to hear other thoughts as to
> why the setting may have this effect in certain environments.

I suspect the environmental factors that make your workload
susceptible to these issues are related to

+ the amount of space used by the NIC driver on the receiver to hold
incoming packets may be large relative to the rcvmss

+ the variation in the incoming packet sizes (the hole was 602 bytes
when the rcvmss is a larger 1434 bytes) may be causing challenges

+ the packet loss is definitely causing challenges for the algorithm,
since the SACKed out-of-order data can eat up most of the space needed
to buffer the packet to fill the hole and allow the app to read the
data out of the receive buffer to free up more space

Thanks,
neal


> [1] https://marc.info/?l=3Dlinux-netdev&m=3D174600337131981&w=3D2
> [2] https://github.com/torvalds/linux/commit/b650d953cd391595e536153ce30b=
4aab385643ac
> [3] https://blog.cloudflare.com/unbounded-memory-usage-by-tcp-for-receive=
-buffers-and-how-we-fixed-it/

