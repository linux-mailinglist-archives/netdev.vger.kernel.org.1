Return-Path: <netdev+bounces-130105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BE1988387
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 13:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF2C1C219B9
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFC618A6DC;
	Fri, 27 Sep 2024 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b7Aj4U0D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3D143C4C
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438113; cv=none; b=WXBT+5JIh2T0Sc+6TWg4OjgqSKfihgWQNnZe33sO/zdXQAJDOngphKyGGdF4h4VKaSHaQI4gm6d0jNnF5lXHOLE3IxUIizG3yVgtVnBiBpdFCoNlOE0YyvIEzVicdS1+Dw/ujygaz6OgCBvvBN3NAvvO3ATvzPa1NQm26LFxUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438113; c=relaxed/simple;
	bh=5IelYLJtGCyBpA7doHnIKZw/Gl7uWB2w/o9JZrMS+Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKf+h/K6647/Q9d3r7rfslgJVWrsqXboMb83aainmuhTLpnwU4XB2p41wqVMoxaIeP+LJ2HPe0XZAlkGJfKqzNrbB4Zi1Rfml3D4z8/goa3+zjXigO0K+8f1FtohflCsocHnoZs/gcXNn+ev7vJl8QfwohyZrBvu+IknBXy/uh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b7Aj4U0D; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82cec47242eso102305539f.0
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 04:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727438111; x=1728042911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IelYLJtGCyBpA7doHnIKZw/Gl7uWB2w/o9JZrMS+Uo=;
        b=b7Aj4U0D0AcHc27q1LZJM5zixeIK1i0UD4YNznARQzDTEv0NBGu1Iu3/GBfcgQBVAh
         5umS6hFIg+4f3Vv8uy+S1+Flh7wJlX/8AG9I/BLcWY5UZOerEONo6m0/Uhk2xOF1Pklk
         6KSS1P3FyA3aUFKqnLZ+3iqIq90soR1mp3bHAxVEyoQ0k+h2qSw6rztmxDMoXhoiQhCz
         wEncIlRuoDRDab4GF2XkSHpfMC0eWPlqTFrulJWUVaIOpoUWMb3J62iQEYDhpW/MO1S1
         mBm4WmD6cgj2Hexx3MzxZyPqvpb4vvVAVL4X1dBKeOfRaE3Xdd9BSL8iIH3La9nVGhza
         EApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727438111; x=1728042911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IelYLJtGCyBpA7doHnIKZw/Gl7uWB2w/o9JZrMS+Uo=;
        b=DSJB/hjahSCePICvc850quMpTo4Z466jzxPxKl7sB34v0jbz3Ja+8cwtfUR8t0dwaD
         p2mP5OyUNZXpWalvqoFP0h9f7QVJC5XQ5qkpYqTM6WhTS0YcE/AeNcVAs2mUstBK2GQH
         RySY8xC+t8/pnWzcp5BuGpS//KNAz/BODknJTuT0SW2C/CpQvRbF7to4meXth3i/1nD+
         Y66oVXNRj31oVFo3aou5yC2UNpGTMsmHvsQ9Xdo/EG+KOavh5a0GPtprad9PzIE6wiIi
         6gRawsNotuketmze7CABINMttPPjV6temdcWaILpeSF9MjkM/VNu2VzJfI45E+9JZ6C1
         FdDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw91PiabhHNg4R4dO5Ece8t+UUoBGFRZs/4VbVis4RkrlmDOkAkG3sIAXXA1tL7DKqRI+mEOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhK1LL/LtcdXT5oIykgYxMB+sMmvhMqc3AEshNVtzoLHuko1rh
	0tvU8d4grW7fza8UrCIgPJs0tXwaClRgzUimlvmj8hx0zLp3ozNnn1opucKOY3xz8pxzEnuBOOD
	+QzIlqVGX+Hk0GTQafnHc6gNyDsoA02cDdpdlYP26zp/ZsSOJJA==
X-Google-Smtp-Source: AGHT+IHQTZWHKkEbSKCyJsvEMcbPA/10XDV8GU1FMkAPGvZdeDFF6FsI0tkhCNu8S09/3QLHyN/aXXPqhjI4etM9I6w=
X-Received: by 2002:a05:6e02:13aa:b0:3a1:95d9:6f36 with SMTP id
 e9e14a558f8ab-3a2768beb2amr45557025ab.13.1727438111397; Fri, 27 Sep 2024
 04:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f5a0ca.050a0220.46d20.0002.GAE@google.com> <CANn89iKLTNs5LAuSz6xeKB39hQ2FOEJNmffZsv1F3iNHqXe0tQ@mail.gmail.com>
 <20240927110422.1084-1-hdanton@sina.com> <CANn89iLKhw-X-gzCJHgpEXe-1WuqTmSWLGOPf5oy1ZMkWyW9_w@mail.gmail.com>
 <20240927114158.1190-1-hdanton@sina.com>
In-Reply-To: <20240927114158.1190-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Sep 2024 13:54:59 +0200
Message-ID: <CANn89iJMHqg4e_tErTERx=-ERXbA+CRbeC0chp9ofqANwwjhLA@mail.gmail.com>
Subject: Re: [syzbot] [net?] INFO: task hung in new_device_store (5)
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Boqun Feng <boqun.feng@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:44=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Fri, 27 Sep 2024 13:24:54 +0200 Eric Dumazet <edumazet@google.com>
> > I suggest you look at why we have to use rtnl_trylock()
> >
> > If you know better, please send patches to remove all instances.
>
> No patch is needed before you show us deadlock. I suspect you could
> spot a case where lockdep fails to report deadlock.

Please try to not educate maintainers about their stuff.

lockdep is usually right. And here there is an actua syzbot report.

