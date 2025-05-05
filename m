Return-Path: <netdev+bounces-187824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA617AA9C3F
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 21:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F34189E488
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1B526C3A5;
	Mon,  5 May 2025 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VCeLJmEz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4C1AA1C4
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472268; cv=none; b=K8zP3j2qyxxVj1HK7hnmbtVTSlEsx7D9O+inGXjbZefL7w9+ly023R9+BvFeyxGWVeN2mfC7GfcNrIXjiLuShdbhp5fxi0Ii5EJD20dskCoXndzWLuE3qk4M1bDCyB6yu3sucWqjUvjFWBNjFwr0fnPWYUyELYqibeyGCYuyY5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472268; c=relaxed/simple;
	bh=pAknAznVkP3PWsitz4sVuSAnL0zOvo9smehn1BcwQ1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kznt4O7Mawp80bovyl60eAKPUHjfkgtVXjsoYeDY9dslDuoPTpFZultHDdiTAujRywV/ratUnPrUlcPifJ3ukNpNKdaRXvaDmDSOxC46MSItvkd2uIvXY+EGG5YM1roI3dqVlUZCPU9CdZVExPffaf28Et8Xpw/P0iP1TsCZiTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VCeLJmEz; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f88f236167so2195a12.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 12:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746472265; x=1747077065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAknAznVkP3PWsitz4sVuSAnL0zOvo9smehn1BcwQ1c=;
        b=VCeLJmEzjLMcoftheRs6vqqfe9m4EIvfehn/xh0U/kj0TlpbHlPyptrGmueT7EcCkw
         65aIUkBufPiF+K2PSwh35Bcc595rwVJ4Oq6fC+201YWNIziFAVUFSonKLzuPdo6mQACH
         fNydJkHYG6dQwijWrsxxTi2coNFv3twHpII/jHpW43avtS7DdoeVfcJpC5ifGmRAR7gm
         oXYQsuSqihwG2fIw0r/ET05AYgNW2vdocSnoaQBno9WXK07vnBEQz+lM5lb68SN6k9RG
         EqNFEKN6EUg1VVyK6FuXHS0xtQWR+ikPP4bFq5Ir3Y7DWy/ZsYp7IuTkBZxpcrwB+lrh
         nmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746472265; x=1747077065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAknAznVkP3PWsitz4sVuSAnL0zOvo9smehn1BcwQ1c=;
        b=GVY7ODVaGlQsdioNlS1E+TjTbCAA5gHh3pXhfy8syUzdxww0MTk9kQe+w5g5jy4s8O
         GB5c8lfvShQYt0nf11EBMROShfTa6Ki9PrFTKhrh84NpWOnAf0U8X97Z+T3vcYvfbk0v
         qlpbOgpbeWm5S15sAKnaI8FH6mrCtHB2Ic2ebB+YDLN5YSYJxgFivXEGcPkDCCmiiyAf
         kFUS9r7EnYlsOgaxqn7lZ6NQrx3TFosZfnMrCYlf3qaq0a2Y1q0aYJ8+5GutbTBSCfHE
         GLLtUtMibAZxOu0NMhHvxGZlk56u/sv6ww2f2TIO4d63O6ztMavLcnb661IYAIvyMYJZ
         /g8A==
X-Forwarded-Encrypted: i=1; AJvYcCWWzdqcwfWte+g9vtgAFWWAt51o8/O4a5gmUI+nf7VoKxI8lwxcZH0zVQz1bS2yBwLJByfmKfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywck+PswI4gRO6ZM08FCeCvG5Uka593RJ5QiNJ5fmjTwhgkCI5F
	xhnlsnEpxV+CnbA0tTZkpTpxqNJutQEoBa10OUdjxEx+HGcgrFYzYQEJsvxVpnDC4fhJDgJKCrS
	XpmCrLp85dnxzLz73VnBVFFyYHtS3cvzMzVmo
X-Gm-Gg: ASbGncvNtlHScEjiH4Jb14NncLOwYcdOSmdK3UqSw94j2UhUEG6UQQS9L1tecZtOX4p
	7W6xErhZawciLcoD05XWPqKiNcLOplTW2LWPIMU6UVxWK057XKI0qnBHGNLI9DT9cLGGi0nNT1p
	3bWfuMkbBI9hTv3rMFMSXJkr5lkbGR0HU3D3a1nYHSOnEDG4+VSg==
X-Google-Smtp-Source: AGHT+IGwZGxg96ElZslVmbfeSZeSCp6jF1H2BA5MmcSCrGlICW244/v/lyYSx0dACBSYjKs0D1e/Y5tW6omcN2BLXPI=
X-Received: by 2002:a05:6402:c92:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5fb6e6182eamr7154a12.7.1746472264493; Mon, 05 May 2025 12:11:04
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-dompteur-hinhalten-204b1e16bd02@brauner> <20250505184136.14852-1-kuniyu@amazon.com>
In-Reply-To: <20250505184136.14852-1-kuniyu@amazon.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 5 May 2025 21:10:28 +0200
X-Gm-Features: ATxdqUGIZsct8Z3NMZ5k4I15ZXbUNsHbBRTzP0WkqnCmU97QaFVoUgE4Cb_ED7A
Message-ID: <CAG48ez35FN6ka4QtrNQ6aKEycQBOpJKy=VyhQDzKTwey+4KOMg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow coredumping
 tasks to connect to coredump socket
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: brauner@kernel.org, alexander@mihalicyn.com, bluca@debian.org, 
	daan.j.demeyer@gmail.com, davem@davemloft.net, david@readahead.eu, 
	edumazet@google.com, horms@kernel.org, jack@suse.cz, kuba@kernel.org, 
	lennart@poettering.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, me@yhndnzj.com, netdev@vger.kernel.org, 
	oleg@redhat.com, pabeni@redhat.com, viro@zeniv.linux.org.uk, 
	zbyszek@in.waw.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 8:41=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
> From: Christian Brauner <brauner@kernel.org>
> Date: Mon, 5 May 2025 16:06:40 +0200
> > On Mon, May 05, 2025 at 03:08:07PM +0200, Jann Horn wrote:
> > > On Mon, May 5, 2025 at 1:14=E2=80=AFPM Christian Brauner <brauner@ker=
nel.org> wrote:
> > > > Make sure that only tasks that actually coredumped may connect to t=
he
> > > > coredump socket. This restriction may be loosened later in case
> > > > userspace processes would like to use it to generate their own
> > > > coredumps. Though it'd be wiser if userspace just exposed a separat=
e
> > > > socket for that.
> > >
> > > This implementation kinda feels a bit fragile to me... I wonder if we
> > > could instead have a flag inside the af_unix client socket that says
> > > "this is a special client socket for coredumping".
> >
> > Should be easily doable with a sock_flag().
>
> This restriction should be applied by BPF LSM.

I think we shouldn't allow random userspace processes to connect to
the core dump handling service and provide bogus inputs; that
unnecessarily increases the risk that a crafted coredump can be used
to exploit a bug in the service. So I think it makes sense to enforce
this restriction in the kernel.

My understanding is that BPF LSM creates fairly tight coupling between
userspace and the kernel implementation, and it is kind of unwieldy
for userspace. (I imagine the "man 5 core" manpage would get a bit
longer and describe more kernel implementation detail if you tried to
show how to write a BPF LSM that is capable of detecting unix domain
socket connections to a specific address that are not initiated by
core dumping.) I would like to keep it possible to implement core
userspace functionality in a best-practice way without needing eBPF.

> It's hard to loosen such a default restriction as someone might
> argue that's unexpected and regression.

If userspace wants to allow other processes to connect to the core
dumping service, that's easy to implement - userspace can listen on a
separate address that is not subject to these restrictions.

