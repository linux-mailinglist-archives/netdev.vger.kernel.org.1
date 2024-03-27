Return-Path: <netdev+bounces-82619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450D088EBF7
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 18:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740651C3112E
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 17:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D035A14C592;
	Wed, 27 Mar 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H60IOwim"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20121148835;
	Wed, 27 Mar 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558833; cv=none; b=JTVxGiBBt4G1qFygKYUhSA5cT4MNJha/eErT2MSZFW0lNT/NcNdPHkLVnhEEa1bixQaJquxasYlJe6pFc/Cng42irIWNJ7+SLT+OYKGKz9WoBaNiHwGVvJxR6pD9q5cQDw43H76w8QSMW/ebz7oWBzIlhKXpeyrGhCdKOO1XseU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558833; c=relaxed/simple;
	bh=J37ICIcDeIhSRv8OF2aSODi811JNXz0+B8VLSNUEPKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7pD7cPfk3YA3Rl3U2ir7c/6XjcP2dlabzCgE0AxYbF30tSfispgRtQgR7jg9czDlkxhlUjW8RiqLXXJz0YDole5OKQ7o6G2v6rZwlCODJ4wLN2277BJYFYSt1Oeuvyj1VJBUWcoESzZQcuFy5sho1RRH33wZ/Zr7YeIBoBuw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H60IOwim; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ed4d8e9edso5142689f8f.2;
        Wed, 27 Mar 2024 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711558830; x=1712163630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE6PANI0PKpDtDKb8HO4vaBnD1jO6J6fZqWjXbZEANc=;
        b=H60IOwimmt+FNgt1ObLh3qILiMau/xCaHR04oMHt/chcbAwyF3imH9dUdPzWqQ1Llk
         0ylz1BUPSdDHFcw++x3nEMeYdwA2UX0uX4C3B1la52z0ypkTSo8tZ4VQVakGvGcijGX2
         JdkX5hymXpTQ8xCGfcARj3ROd10VW3E2JUM0ii9XpdR9XXrXaTkVyJnFku3N18gLIW7q
         bthDUdY04B2RS4//rdjBbeC5tk6ydjfGYR/R+5DTsXhTuCrdDOiR40jr7AqVbl5X54qx
         4I/oqvLCWxbYJ/eA6xs1qo/DNOAlV5cVZi922/M7kT2l7KRdkp86xRBC73vApb32NRZ3
         LoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711558830; x=1712163630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE6PANI0PKpDtDKb8HO4vaBnD1jO6J6fZqWjXbZEANc=;
        b=M+9wyLakmgW4KZOjln+e2qE/ctMPe/dq03tQCHSuzJm2I/hgsBhbJVFyjbTYKCJ5nA
         Xn56yHjDu1R6LdzoeRHx2ZRkzXiJbXVfm/9AWWXrMa5Ljjsr76kyi+9qQ5v7NkM9zVf0
         V+NfLVD0xYqbKnB1Gojs2dDxGNKJcHQqR+TryivXMPclaLefJLBXqwqFKLS3YDTt7pmW
         95yzEnYLLgP7JAg5a86gyraAJYPKXfgEIBPcmlAb+09T+RrA/dpzvS1ir5XY0hsl2M7V
         YOcvJPe9hdpTwOEUm2yov+BI+ZgpClIqeWIqhB4rrsRanckFCjvC/E4DDCdYt79XQBBa
         H6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEi8bzn9BbqHilUrSFrZ/okK+/pfeMQOISqIzAInxs/s9C/bGJLCLSnmI15YO0AIHbAVOTjJIU3AFZds+9KLRYOQ0Q
X-Gm-Message-State: AOJu0Yzit0JqPqojDQZkuHIZK/9+2N8Hy9CP/cnVZpd1TC/THY/uyJoX
	KdR8fmnQiFwSK1xsRmvCDQzCHCITfykf9KChCIZ9z4AdhwtNb0ApCX4CYydwZvluDvuzZF985OS
	MuZre77D8i8E+PjxEQQzwOC1qg7T9wE/LtzA=
X-Google-Smtp-Source: AGHT+IHhkloAX659y62N9Sgl+ZqyAfY8iq+7jOOX1+KAnA+tCvDhALQMxu4P9hoaXL1TLSv6AhIzTZxYoj35NB0egW8=
X-Received: by 2002:a5d:64a2:0:b0:341:bd4c:f075 with SMTP id
 m2-20020a5d64a2000000b00341bd4cf075mr375333wrp.16.1711558830159; Wed, 27 Mar
 2024 10:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQKCxxETthqDpcE1xMGwa5au8JuLr_49QuwemL7uBKfiVg@mail.gmail.com>
 <8410a6f61e7a778117819ebeda667687353ffb21.camel@redhat.com>
In-Reply-To: <8410a6f61e7a778117819ebeda667687353ffb21.camel@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Mar 2024 10:00:19 -0700
Message-ID: <CAADnVQLj9bQDonRzJO5z2hMZ7kf6zdU-s6Cm_7_kj-wP3CiUSA@mail.gmail.com>
Subject: Re: mptcp splat
To: Paolo Abeni <pabeni@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 9:56=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Wed, 2024-03-27 at 09:43 -0700, Alexei Starovoitov wrote:
> > I ffwded bpf tree with the recent net fixes and caught this:
> >
> > [   48.386337] WARNING: CPU: 32 PID: 3276 at net/mptcp/subflow.c:1430
> > subflow_data_ready+0x147/0x1c0
> > [   48.392012] Modules linked in: dummy bpf_testmod(O) [last unloaded:
> > bpf_test_no_cfi(O)]
> > [   48.396609] CPU: 32 PID: 3276 Comm: test_progs Tainted: G
> > O       6.8.0-12873-g2c43c33bfd23 #1014
> > #[   48.467143] Call Trace:
> > [   48.469094]  <TASK>
> > [   48.472159]  ? __warn+0x80/0x180
> > [   48.475019]  ? subflow_data_ready+0x147/0x1c0
> > [   48.478068]  ? report_bug+0x189/0x1c0
> > [   48.480725]  ? handle_bug+0x36/0x70
> > [   48.483061]  ? exc_invalid_op+0x13/0x60
> > [   48.485809]  ? asm_exc_invalid_op+0x16/0x20
> > [   48.488754]  ? subflow_data_ready+0x147/0x1c0
> > [   48.492159]  mptcp_set_rcvlowat+0x79/0x1d0
> > [   48.495026]  sk_setsockopt+0x6c0/0x1540
> >
> > It doesn't reproduce all the time though.
> > Some race?
> > Known issue?
>
> It was not known to me. Looks like something related to not so recent
> changes (rcvlowat support).
>
> Definitely looks lie a race.
>
> If you could share more info about the running context and/or a full
> decoded splat it could help, thanks!

This is just running bpf selftests in parallel:
test_progs -j

The end of the splat:
[   48.500075]  __bpf_setsockopt+0x6f/0x90
[   48.503124]  bpf_sock_ops_setsockopt+0x3c/0x90
[   48.506053]  bpf_prog_509ce5db2c7f9981_bpf_test_sockopt_int+0xb4/0x11b
[   48.510178]  bpf_prog_dce07e362d941d2b_bpf_test_socket_sockopt+0x12b/0x1=
32
[   48.515070]  bpf_prog_348c9b5faaf10092_skops_sockopt+0x954/0xe86
[   48.519050]  __cgroup_bpf_run_filter_sock_ops+0xbc/0x250
[   48.523836]  tcp_connect+0x879/0x1160
[   48.527239]  ? ktime_get_with_offset+0x8d/0x140
[   48.531362]  tcp_v6_connect+0x50c/0x870
[   48.534609]  ? mptcp_connect+0x129/0x280
[   48.538483]  mptcp_connect+0x129/0x280
[   48.542436]  __inet_stream_connect+0xce/0x370
[   48.546664]  ? rcu_is_watching+0xd/0x40
[   48.549063]  ? lock_release+0x1c4/0x280
[   48.553497]  ? inet_stream_connect+0x22/0x50
[   48.557289]  ? rcu_is_watching+0xd/0x40
[   48.560430]  inet_stream_connect+0x36/0x50
[   48.563604]  bpf_trampoline_6442491565+0x49/0xef
[   48.567770]  ? security_socket_connect+0x34/0x50
[   48.575400]  inet_stream_connect+0x5/0x50
[   48.577721]  __sys_connect+0x63/0x90
[   48.580189]  ? bpf_trace_run2+0xb0/0x1a0
[   48.583171]  ? rcu_is_watching+0xd/0x40
[   48.585802]  ? syscall_trace_enter+0xfb/0x1e0
[   48.588836]  __x64_sys_connect+0x14/0x20

