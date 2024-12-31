Return-Path: <netdev+bounces-154631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30769FEF24
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 12:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A163A2E21
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 11:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADC4191F68;
	Tue, 31 Dec 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOj3Op1o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33238944E
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735645800; cv=none; b=T1gPOaYEJE5d1SMoUmokb672Ap4vngZlqANOuDlPKAQ5hdf9quqafJTNeUOzbqMDBjONwRCCiVVV0nUKXyCIB/pZT3qqvZ0Rw97FUFJGqmL5xfjxqSOAar+yfX3CmlSCUdWFPseHMfvt5RSkD6cZGlaVmzhW5XkAXiTA6ZZx0VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735645800; c=relaxed/simple;
	bh=Je6rE9hXlygFYmcNYWN+ICtuBbSax3c/AdGVSoLjpfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qq4wgwzeJm6P8WY3oE1eRaqtmEeULOhxI1SPiTaRXiUEZvNzi7T0SozOp2Oryyu4ItHso0VX6IxJncbnq8dxS3kodlRqwmQ4S80QwIJhFIKb17V+ZWbfnXWSIxRfbEGP+634+2Oyv/kYBMqnkbPIQnncavquXd+qrV/MqoqYnao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOj3Op1o; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d884e8341bso72185226d6.0
        for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 03:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735645798; x=1736250598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68Ng8j0qgtjR5QxXcGYaxbKj4Qx5VIr0AC5D3afX7vQ=;
        b=FOj3Op1ooFN9tMZF0rKNKMGKYmKZ22v+ErLRy4qMoy4rTE/fgFa/OAMdMW3qU3U6M7
         ayT/2iJeLNPkLIkniFci9207bPSAdadX398trTa7DdXMkL+1bxKzoj/PxWB9/JuG9qJE
         IRoTaA4iWWDDcEqIIPV52LdsuemL8VWHmlVas840rX9dR3C6TTLf3mbGVWVR1r9FYDWy
         4z7Qxvtmeyq/WiT1pQj3tH63jCObwN609lTnRGBBt93MEyKdNi0r/0nTpE2DttOL/ty9
         Hu5KxSthiqHElXHNgG3vvBK6S/fqWOl2b04La132KlbXyIOS95vVaGLocJluYr+Bab/B
         wvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735645798; x=1736250598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68Ng8j0qgtjR5QxXcGYaxbKj4Qx5VIr0AC5D3afX7vQ=;
        b=qIK9tnrEF15CedIq2G4L/e8ijAGszVYqdXLzV56ljXQxmPiWLpyXCnrz6cJcFbOVP5
         pKxwzsxZxcs8xHprDTth1SKXxFWVN5TfcTttLn0OXbu5zG+u15HtduFOcNp1pVd67XxE
         ygaO/m4EzN+4KV1xS/dGO7Lty8Rg+GnUfBUOkzFHBoR3vcO4Xei5vlZL1wqvSTRbLYFZ
         gn850xUaz9qRorBf3sJZnkL2i4tQ8BP0V2AoE8OP5jJ1iXcUBR6BFLHrF0O7Drddh4kE
         fM+5ywPRISpzXN4p1OkZvooZl0EFlSy5F286uLKVefdI82eoHb4XDuV8oB6T5lFeeiiK
         0HLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsxI+1ZRN5kPRZQfzdmKFIE9wZy/Em9HI0v4NV0W6yyxgjCDaFgx85AEyKOTMgMpAC95pxrIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO1PIFrbG5LmHiFDnHVcUSlF6K0xHzL3OjWwkTekADU5axGaGl
	gi4Rp5GenUvnPiGv3bm9UhltGtrgsnLtzGm5vhctyZdar/5bLbiTZR0l4XJ8gt7MOcNnBIKrE4W
	xmwssugMmzqWc45Bsx0sZYA3DivY=
X-Gm-Gg: ASbGncs/pnZWzPZl6rRsNzTeOtcui8bidx75W/lcFsi0B5EkcClYQxHE7yy8keKHczq
	kT8Elu0Y95XFu2HqNb9IYQJeocLRuZgG0b72yQLU=
X-Google-Smtp-Source: AGHT+IHHziNed1z2bQmlMF56AtgTv9T8Y1HFblP/iV50yFsfIoTTUq/+U1lCG1qlEBbyNfXMKPPod2+3oqSVZ5nYRug=
X-Received: by 2002:a05:6214:d4b:b0:6d8:96a6:ec31 with SMTP id
 6a1803df08f44-6dd2339e0e2mr641795516d6.35.1735645798125; Tue, 31 Dec 2024
 03:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231055207.9208-1-laoar.shao@gmail.com> <CANn89iL2qZwc7YQLFC8FQzrn_doD4o13+Bk-0+63aGEFFo_7xA@mail.gmail.com>
In-Reply-To: <CANn89iL2qZwc7YQLFC8FQzrn_doD4o13+Bk-0+63aGEFFo_7xA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 31 Dec 2024 19:49:21 +0800
Message-ID: <CALOAHbDLQhU5c+P_TiOQb9mjpgJkdfK21WemydVja+eyC0DkRA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp: Define tcp_listendrop() as noinline
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 5:26=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Dec 31, 2024 at 6:52=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > The LINUX_MIB_LISTENDROPS counter can be incremented for several reason=
s,
> > such as:
> > - A full SYN backlog queue
> > - SYN flood attacks
> > - Memory exhaustion
> > - Other resource constraints
> >
> > Recently, one of our services experienced frequent ListenDrops. While
> > attempting to trace the root cause, we discovered that tracing the func=
tion
> > tcp_listendrop() was not straightforward because it is currently inline=
d.
> > To overcome this, we had to create a livepatch that defined a non-inlin=
ed
> > version of the function, which we then traced using BPF programs.
> >
> >   $ grep tcp_listendrop /proc/kallsyms
> >   ffffffffc093fba0 t tcp_listendrop_x     [livepatch_tmp]
> >
> > Through this process, we eventually determined that the ListenDrops wer=
e
> > caused by SYN attacks.
> >
> > Since tcp_listendrop() is not part of the critical path, defining it as
> > noinline would make it significantly easier to trace and diagnose issue=
s
> > without requiring workarounds such as livepatching. This function can b=
e
> > used by kernel modules like smc, so export it with EXPORT_SYMBOL_GPL().
> >
> > After that change, the result is as follows,
> >
> >   $ grep tcp_listendrop /proc/kallsyms
> >   ffffffffb718eaa0 T __pfx_tcp_listendrop
> >   ffffffffb718eab0 T tcp_listendrop
> >   ffffffffb7e636b8 r __ksymtab_tcp_listendrop
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > --
>
> Are we going to accept one patch at a time to un-inline all TCP
> related functions in the kernel ?

I don't have an in-depth understanding of the TCP/IP stack, so I can't
consolidate all related TCP functions in the error paths into a single
patch. I would greatly appreciate it if you could help ensure these
functions are marked as non-inlined based on your expertise. If you
don't have time to do it directly, could you provide some guidance?

The inlining of TCP functions in error paths often complicates tracing
efforts. For instance, we recently encountered issues with the inlined
tcp_write_err(), although we were fortunate to have an alternative
tracepoint available: inet_sk_error_report.

Unfortunately, no such alternative exists for tcp_listendrop(), which
is why I submitted this patch.

>
> My understanding is that current tools work fine. You may need to upgrade=
 yours.
>
> # perf probe -a tcp_listendrop
> Added new events:
>   probe:tcp_listendrop (on tcp_listendrop)
>   probe:tcp_listendrop (on tcp_listendrop)
>   probe:tcp_listendrop (on tcp_listendrop)
>   probe:tcp_listendrop (on tcp_listendrop)
>   probe:tcp_listendrop (on tcp_listendrop)
>   probe:tcp_listendrop (on tcp_listendrop)
>   probe:tcp_listendrop (on tcp_listendrop)
>   probe:tcp_listendrop (on tcp_listendrop)
>
> You can now use it in all perf tools, such as:
>
> perf record -e probe:tcp_listendrop -aR sleep 1

The issue is that we can't extract the struct `sock *sk` from
tcp_listendrop() using perf. Please correct me if I=E2=80=99m mistaken.

In a containerized environment, it's common to have many pods running
on a single host, each assigned a unique IP. Our goal is to filter for
a specific local_ip:local_port combination while also capturing the
corresponding remote IP. This task is straightforward with bpftrace or
other BPF-based tools, but I=E2=80=99m unsure how to accomplish it using pe=
rf.

--=20
Regards
Yafang

