Return-Path: <netdev+bounces-188375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA92DAAC8B9
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5564A883E
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02715283FE8;
	Tue,  6 May 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9BTVn+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAC8283FD7
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543126; cv=none; b=RPZ24cV3B3FqXAxJ62bnR9ugmgzeqAMmLuZ+p/mjvCqBUy5MU878HAmZrMWnFhQOneQI+8uSZuNL0fwgqZPP1ulHnxAFQFCuzpg7QHSW3tOK/uF3frNMGw2V02IuLVQuaulACwMCupwfct/2zSoAVXeBQmsImoaPY5NQgdJdZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543126; c=relaxed/simple;
	bh=x9hPRiKZTwD/NdReE9abUiOntHFDdU4cLMKbdDazvmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjM566QRdqoQzXGFwhYqWgSFiTcDwSU2n7cX1vl/XaiZtL6JhLLz25e41wIl0mpfacS4oTQsLdgW6bQ9ah3VsyAYs4NX/viUnrFAV01q8ggaTVA8TWBFVBO0V4ZHYY0FPneju4YK6ieOtoYU5Sy2hpebr886/gyL9S/BJ0AIoIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q9BTVn+Y; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5fab85c582fso12031a12.0
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746543123; x=1747147923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9hPRiKZTwD/NdReE9abUiOntHFDdU4cLMKbdDazvmk=;
        b=Q9BTVn+YlmEf5cCv62m8neZmOklT7cqsnk1gcTsFsX5mOYjTyINhcLuEwEdgk5LDcn
         FwUVIc844rVCfyWGEpdtX+7nKuydsV6tKUE8xOOEqe0wnxTayjda48FcnfPh7x0O/Py4
         suu8ZRF3j6A6SZXCZb6vpKM3mCIKeXyXF7+HZZ2m1w7iaTKx1vW6rxbaUeLOYjUSpnV/
         IHEstSBJiRgwAAptTQVYWsQVGwq1IAxKZGjb50OcV7uPZdBeYhmbC7FHUe25DiAFPO8o
         R1zsYUQ4EFP0kgQPK/C+FkDFFfjfbxDZM1Af2XCLWzepAcZ9uX3c6jTZS/I1/Am8U7Kf
         98mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746543123; x=1747147923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9hPRiKZTwD/NdReE9abUiOntHFDdU4cLMKbdDazvmk=;
        b=MyMhYl88aOVCxQguQpYk9qlohLySemKQlPmLDa4k6Uy+G1XyEx8fEzdUZ9erq9HR5O
         8MpYwx09y4LWvfy5NlA5dK+lYf+Rof8yoXkOpPm/57ayFi7LdQhwZG6GXmVR4HUMk7Tr
         /NIE1mu6vp2cw5k1vpp7yoAqWurG+vUQoR4x4iQcXe3oWXni2BW6SUY/LnL6PRcmxp9/
         FwM+AXKL2NS46J8tX7nvX2ZUugId95xHudmM+4LwtnQiqfOlwQWl7ovczifspO2Lf+SN
         TuPU90SeRstoUJSp/SWdj0iQJk9p/8my1ikgeQPuAhaxbS391AT1j7y8ey7i8Grxcjhl
         RX2w==
X-Forwarded-Encrypted: i=1; AJvYcCUoKr+FED2azVodOJMP94kR75nLVY8/hTeuGxxEy0UDOvFQ9nrq1Jq0mC4C7/JvHcYTdrq7Uac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAqwkwLDZSLCCr84QXKCq+izUrBQzgZRmn8DjKDpb06CMCeEhI
	PKM+e4Nx8YG+YzaOpwtT7cjA+7aI164JJ6t0tV9iNj7YpWQfM3G29b8uoeOt13PySuFUN4yd0AF
	pJq9mfeMXDSWlg+kWcwfVpA9UqaEfTInkAJ6/
X-Gm-Gg: ASbGnctGbZpB1XgiQSkEH9ZnS1UDlo/LjYchFYUdWgPV88oNiAMRMXiNF0m6OIHXoNy
	su4a1+4Akec0nuiZaOhqqfBUKbld5BLoOrrc38v9kFpIAJwnrvWskbboep5mTfTVsGL3TEGj77Q
	hMeJY64ptADGh1hVpZ0Q2ojzX0M9DQQwJeg9vH4cFDGvDjDTryaQ==
X-Google-Smtp-Source: AGHT+IHLzZqsyxKnFOlVbanhCF6K+dSqiXmiGykJHfhgZkYJbBPhDSJj+AaO+At+BG53ifRemilin7/tcbsNCn+/UW8=
X-Received: by 2002:a05:6402:34b:b0:5f8:7b57:e5c2 with SMTP id
 4fb4d7f45d1cf-5fbe76e3f1amr2232a12.4.1746543123157; Tue, 06 May 2025 07:52:03
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505193828.21759-1-kuniyu@amazon.com> <20250505194451.22723-1-kuniyu@amazon.com>
 <CAG48ez2YRJxDmAZEOSWVvCyz0fkHN2NaC=_mLzcLibVKVOWqHw@mail.gmail.com> <20250506-zertifikat-teint-d866c715291a@brauner>
In-Reply-To: <20250506-zertifikat-teint-d866c715291a@brauner>
From: Jann Horn <jannh@google.com>
Date: Tue, 6 May 2025 16:51:25 +0200
X-Gm-Features: ATxdqUHI--OKwW_7qiujfbC9sS_wAultDtuvkQ3Tg-rFn9ttA_E9C5i8WH_N6MI
Message-ID: <CAG48ez25gm3kgrS_q3jPiN0k6+-AMbNG4p9MPAD4E1WByc=VBA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow coredumping
 tasks to connect to coredump socket
To: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alexander@mihalicyn.com, bluca@debian.org, 
	daan.j.demeyer@gmail.com, davem@davemloft.net, david@readahead.eu, 
	edumazet@google.com, horms@kernel.org, jack@suse.cz, kuba@kernel.org, 
	lennart@poettering.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, me@yhndnzj.com, netdev@vger.kernel.org, 
	oleg@redhat.com, pabeni@redhat.com, viro@zeniv.linux.org.uk, 
	zbyszek@in.waw.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 9:39=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
> > ("a kernel socket" is not necessarily the same as "a kernel socket
> > intended for core dumping")
>
> Indeed. The usermodehelper is a kernel protocol. Here it's the task with
> its own credentials that's connecting to a userspace socket. Which makes
> this very elegant because it's just userspace IPC. No one is running
> around with kernel credentials anywhere.

To be clear: I think your current patch is using special kernel
privileges in one regard, because kernel_connect() bypasses the
security_socket_connect() security hook. I think it is a good thing
that it bypasses security hooks in this way; I think we wouldn't want
LSMs to get in the way of this special connect(), since the task in
whose context the connect() call happens is not in control of this
connection; the system administrator is the one who decided that this
connect() should happen on core dumps. It is kind of inconsistent
though that that separate security_unix_stream_connect() LSM hook will
still be invoked in this case, and we might have to watch out to make
sure that LSMs won't end up blocking such connections... which I think
is related to what Mickael was saying on the other thread. Landlock
currently doesn't filter abstract connections at that hook, so for now
this would only be relevant for SELinux and Smack. I guess those are
maybe less problematic in this regard because they work on full-system
policies rather than app-specific policies; but still, with the
current implementation, SELinux/Smack policies would need to be
designed to allow processes to connect to the core dumping socket to
make core dumping work.

