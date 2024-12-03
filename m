Return-Path: <netdev+bounces-148582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124069E284C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF65B3CB40
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCCD1FC7E3;
	Tue,  3 Dec 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGz2/l5v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012E520C038
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240105; cv=none; b=j6UWZVUk3qGbZAUAxTYnI7Mjokza/RqI8mXIuSsuyfY/4Gc5exhWARq0nBkHXQwz/W30PfKDhtoHMoEpD+1WUniy+bsc9J/jd30SjvhDVDFjd0SrAG9qq1hAvUov++0g1WzlTvU6PDPfa72/p4nzJB2DhM7tsvCWicEBYDuyiAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240105; c=relaxed/simple;
	bh=1e4MjF93tkjg0YGVYUqFUbB08zsiPvN+Sk4f5cTiydc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaDtrugGkVPBlVgdYVzDcwopVut3Hfzk1ebpiMyoYZMRUFz2zblgEId+DQ9S4FO7yt1Mv4/fnAQwWlNyHnsmjDM1k00oPEyKMKFVRdBRJJMizAnWuP6RHib6+riJUBdKwzU2JZAEAPkpIH+hHw5U9dfwD/teu0mzEpzWZL6mCRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UGz2/l5v; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4668194603cso183561cf.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 07:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733240103; x=1733844903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CIzRsQC52+ZzIB8OpI8Cic6pwbdqgp0qwyGOZqbtlI=;
        b=UGz2/l5vBrnbjGj0CjFyHK6GWTK4vABgJfmX+QiQJp9J+HmJuR1oPNdHlcLetCMJ7O
         TlPk3cn10q5I7m2nzF7VpaX4V6Nf4UqNQLk6S7jl4NXntMyvnLb5k+KJKncfE1Ke9lzz
         BjOs/211h6SwPOvU3QDN9AjNkKTLJSTjQRVZJWKX4CRRCmojgFI/Jp+rOTJXuhy8ABDa
         hykNRiAsW8uAzIBOZ5Xz4aFDw6MKXmOL0Ov+1YVTR7oCWOBvUwktIeZ5hk3lZLB2+Ame
         bRjgn4a4rgH/871bfgKuOU4U0KJ9wYQPgeOgc5lQbOGLyR6Df/EDRh0A7/J0MXKqbEAR
         XiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733240103; x=1733844903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CIzRsQC52+ZzIB8OpI8Cic6pwbdqgp0qwyGOZqbtlI=;
        b=QE2xGF6tym+S47D+dkcs13K2WjQ6ZfkvGMlZCJxo1dVSplhfZL7JkDilUGv6jp3I7O
         XVgZVhopB0MqPy9lh6hQW2PVrRwoI/fy3CshXucrgbj706Z6PMqkZi/Yr7YXt6bFnwfe
         bbwWnOflWBsHEo4yxs/WZqPMfxOpppOqq+E3Dnb6jF5ZLLXED5H9fgZmlm414cGHEMQ7
         pklW9CHajEdACvB3nYso0jbkvVPripM+oMEfLDd6vXdw06qPxL8r+caljOIER+0UETpp
         S8M4Quseh0QJJnNXV4K0r7a/rWy8Ai4NMzqb5v0i3qM3PwnI3mYXdNtr92uSuaUOMlSS
         myLg==
X-Forwarded-Encrypted: i=1; AJvYcCU7SnK6Zau8L3s/SOH7AckiGrirKiecKWc9cxLa5sgu1DUJIPeLVu42om1FPT7QRrQXKl8yDwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+g+PpuzPUDyekYkusrQcWo3YsqJpowfzPyDtzvk4ROwrN+Tx6
	5rS2y8A2kmve9ObvjZ9h46SXva3lEJFot2KIC0n5xoeNF7/kYxf+/twu5mA20LJVJ7pqh3anD4O
	1nBu1293u680wQCu0MGfV7Y2nG+5tX+APzd5Lg+u67gQxX2Pb06oO
X-Gm-Gg: ASbGnctwjWj4sjDOFgAaQ4g/0Gl3V6T1SL/GCTYDTTD6GVMzQU9v5oEbKotsnW3idE3
	I/ztQcGAEXR2N4AGESPeA/Vv6FYbEpc8nxRtTgUKblY8gGUFx2CzekAqGi1EHDVV9
X-Google-Smtp-Source: AGHT+IH6dSSGPfhUjUKRPLNKLdBO56X9AviG1EOomPsp2BsLghb521e+GCD1jR+tXn6zmu4S3GND8HOwHsMqdq4HEl0=
X-Received: by 2002:a05:622a:4889:b0:466:97d6:b245 with SMTP id
 d75a77b69052e-4670b295a30mr3548461cf.22.1733240102601; Tue, 03 Dec 2024
 07:35:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
 <20241203081247.1533534-1-youngmin.nam@samsung.com> <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
In-Reply-To: <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 3 Dec 2024 10:34:46 -0500
Message-ID: <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: Eric Dumazet <edumazet@google.com>
Cc: Youngmin Nam <youngmin.nam@samsung.com>, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dujeong.lee@samsung.com, 
	guo88.liu@samsung.com, yiwang.cai@samsung.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joonki.min@samsung.com, hajun.sung@samsung.com, 
	d7271.choe@samsung.com, sw.ju@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 6:07=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Dec 3, 2024 at 9:10=E2=80=AFAM Youngmin Nam <youngmin.nam@samsung=
.com> wrote:
> >
> > We encountered the following WARNINGs
> > in tcp_sacktag_write_queue()/tcp_fastretrans_alert()
> > which triggered a kernel panic due to panic_on_warn.
> >
> > case 1.
> > ------------[ cut here ]------------
> > WARNING: CPU: 4 PID: 453 at net/ipv4/tcp_input.c:2026
> > Call trace:
> >  tcp_sacktag_write_queue+0xae8/0xb60
> >  tcp_ack+0x4ec/0x12b8
> >  tcp_rcv_state_process+0x22c/0xd38
> >  tcp_v4_do_rcv+0x220/0x300
> >  tcp_v4_rcv+0xa5c/0xbb4
> >  ip_protocol_deliver_rcu+0x198/0x34c
> >  ip_local_deliver_finish+0x94/0xc4
> >  ip_local_deliver+0x74/0x10c
> >  ip_rcv+0xa0/0x13c
> > Kernel panic - not syncing: kernel: panic_on_warn set ...
> >
> > case 2.
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 648 at net/ipv4/tcp_input.c:3004
> > Call trace:
> >  tcp_fastretrans_alert+0x8ac/0xa74
> >  tcp_ack+0x904/0x12b8
> >  tcp_rcv_state_process+0x22c/0xd38
> >  tcp_v4_do_rcv+0x220/0x300
> >  tcp_v4_rcv+0xa5c/0xbb4
> >  ip_protocol_deliver_rcu+0x198/0x34c
> >  ip_local_deliver_finish+0x94/0xc4
> >  ip_local_deliver+0x74/0x10c
> >  ip_rcv+0xa0/0x13c
> > Kernel panic - not syncing: kernel: panic_on_warn set ...
> >
>
> I have not seen these warnings firing. Neal, have you seen this in the pa=
st ?

I can't recall seeing these warnings over the past 5 years or so, and
(from checking our monitoring) they don't seem to be firing in our
fleet recently.

> In any case this test on sk_state is too specific.

I agree with Eric. IMHO TCP_FIN_WAIT1 deserves all the same warnings
as ESTABLISHED, since in this state the connection may still have a
big queue of data it is trying to reliably send to the other side,
with full loss recovery and congestion control logic.

I would suggest that instead of running with panic_on_warn it would
make more sense to not panic on warning, and instead add more detail
to these warning messages in your kernels during your testing, to help
debug what is going wrong. I would suggest adding to the warning
message:

tp->packets_out
tp->sacked_out
tp->lost_out
tp->retrans_out
tcp_is_sack(tp)
tp->mss_cache
inet_csk(sk)->icsk_ca_state
inet_csk(sk)->icsk_pmtu_cookie

A hunch would be that this is either firing for (a) non-SACK
connections, or (b) after an MTU reduction.

In particular, you might try `echo 0 >
/proc/sys/net/ipv4/tcp_mtu_probing` and see if that makes the warnings
go away.

cheers,
neal

