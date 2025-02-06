Return-Path: <netdev+bounces-163472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E4DA2A595
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC7787A3BEC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C856226558;
	Thu,  6 Feb 2025 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcE4Spji"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F01213240
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836595; cv=none; b=JbzYPE0ZjlBmTz1D5Jo02iS7jDalJdkZUq2c6suijTrl+sMZY/6SUTiNNy3zQT9H4bzRu2oRDoD6goqoumk+7tWquWl00fupEMaxMislEh/gX1w8lsNlleo+PqYhDhVqSWftaKBW62GPJGNhayXV89BdF9Cggp3jbwvKFtt/Gns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836595; c=relaxed/simple;
	bh=ZKuwgtDky8Xhvl3M5A4riV3YCHfxsc86ad2FkrZnwH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eypm1XJYpS+yqU/2fSHcN/fMuVvzQkuk+v6X/dCu8G3fB+Da95byTWnt8fj84nOXR8O0eqiJJ6N8ewjxb/tsgHCBoDLAoDUpcApxnhr40NI5ppkXxs7o/P2DReJDvV3z2RStuFYkWecD/r2fbJ3BrU3dZw3GaoxrnLfXSsD6hBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcE4Spji; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dcedee4f84so1258514a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 02:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738836592; x=1739441392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/mS+2eKExtyTN8Vh4IHH9mnRtV5vHTtYoa32EFAd2o=;
        b=XcE4Spji8nuxLrB+Hur+CsJpythTP+Uwzan3CkG3tKmbqsE6L7AUDrUGi9c296gOUo
         V7/Z3OugoRIa8nsyvLydx8JdJ6r7eKhJFopjdr5LsthBUuVq/Ny5KISNamBxoZzkDyX/
         HMFzESvx8/dWid8gBeffpdv4wilnm6MQAxAmkQ3KRWwJ1bxaBt5ferpAWHR8lFPA3XRY
         nsxujNXXdwxXac0uglLBkf411eukbY70rhya+XDQ+U0g7j2oRD5+zep6AZODSlaujPfa
         4kzAPuGhRWpaz2zy/juFXhm6RP8gs9SsG3mxhu6ryZ3IBFvjXVFsvj2cB4SBQwebTp+N
         5xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738836592; x=1739441392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/mS+2eKExtyTN8Vh4IHH9mnRtV5vHTtYoa32EFAd2o=;
        b=U9cAonWUOkXyD8ElA+VpfXoJ9bXXEwFt7teGwe4n2TfeR03JZpI1Fb3MhhJzO+skKI
         ctys/xupZhG4Z30tAwEOmKnWLFTTxFMFsHoINNsYtUu7q50tqDZS6ohRk8cFkLy/4jZt
         MXuZhirAk+pNqJ4szceupGBT9ce8hYEm41yCXzMqyNIjNigFn/YbWfQ5d2WQusN65ZGt
         yIMmboMlI6ecJzP/W+aa3wO4nfKU9/4RpKRb/Yr8vI64Edfw1RUA2XH3IBgUvYv8wPDh
         9w3CgzLLxUlPVLPYn/+Z39jPvSLw6SFUmlAdAfa8VRL0w0MrGCxTTQ/89UT5xdOvgDjf
         o0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsjH9DpOOLAaKByuzQxW2g/lI/JZYa5ao2Avl7VpRW08VNbLt07S/qAcSSRVWiCns6RF4RrWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypZooWQTI1uqPoT7evqvje+eOCQ2/V1x9lVEBgGjM8KTVmwgNl
	da7eCO1iXDNISoEiRILTSOrUZ5UlEeZmWMZG3QFjKo28pyyaNkajg2f5StTWGi+xNMpBYA6Pzjr
	HHihF4PJ1YRGAIbUA73ud4T2GnZZYjgL9fxMX
X-Gm-Gg: ASbGncvbl0ayHZH+8p2MZQxLJLJcl/rH+iVOKyM/7rZpT7XbNuM1WJPe54w2g2oTBkP
	qJMNsRXtxGWH7VAgbhae/+iltzS/BW16w1mUxQMofmiA7AVTQ7rR3pSl4uR37Euebh7EN15iSew
	==
X-Google-Smtp-Source: AGHT+IGFKTjHRLId4nFdVIg3ODAcW2J4cs6ogAI1LmO1CoOh8Ex4tMJTJEHvJbynBPllxErs4E2UPC8o2j0J9lonb/4=
X-Received: by 2002:a05:6402:5251:b0:5db:e88c:914f with SMTP id
 4fb4d7f45d1cf-5dcecc86fc3mr2937575a12.4.1738836591837; Thu, 06 Feb 2025
 02:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206085834.17590-1-kuniyu@amazon.com> <20250206094457.196837-1-buaajxlj@163.com>
In-Reply-To: <20250206094457.196837-1-buaajxlj@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Feb 2025 11:09:40 +0100
X-Gm-Features: AWEUYZn8RPseVUE6PE6vSWtPVOwP4H5ImNtxgeSrgvVvG1jZvCKDknd4smT8iBI
Message-ID: <CANn89iLYV+R1CQiuvjtU=aQinVAKyhQiJVUxWG7t=-M72ZsToA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] af_unix: Refine UNIX pathname sockets
 autobind identifier length
To: Liang Jie <buaajxlj@163.com>
Cc: kuniyu@amazon.com, davem@davemloft.net, horms@kernel.org, kuba@kernel.org, 
	liangjie@lixiang.com, linux-kernel@vger.kernel.org, mhal@rbox.co, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 10:45=E2=80=AFAM Liang Jie <buaajxlj@163.com> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date: Thu, 6 Feb 2025 17:58:34 +0900
> > From: Liang Jie <buaajxlj@163.com>
> > Date: Thu,  6 Feb 2025 16:19:05 +0800
> > > Hi Kuniyuki,
> > >
> > > The logs from 'netdev/build_allmodconfig_warn' is as follows:
> > >   ../net/unix/af_unix.c: In function =E2=80=98unix_autobind=E2=80=99:
> > >   ../net/unix/af_unix.c:1222:52: warning: =E2=80=98snprintf=E2=80=99 =
output truncated before the last format character [-Wformat-truncation=3D]
> > >    1222 |         snprintf(addr->name->sun_path + 1, 5, "%05x", order=
num);
> > >         |                                                    ^
> > >   ../net/unix/af_unix.c:1222:9: note: =E2=80=98snprintf=E2=80=99 outp=
ut 6 bytes into a destination of size 5
> > >    1222 |         snprintf(addr->name->sun_path + 1, 5, "%05x", order=
num);
> > >         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> > >
> > > snprintf() also append a trailing '\0' at the end of the sun_path.
> >
> > I didn't say snprintf() would work rather we need a variant of it that
> > does not terminate string with \0.
> >
> >
> > >
> > > Now, I think of three options. Which one do you think we should choos=
e?
> > >
> > > 1. Allocate an additional byte during the kzalloc phase.
> > >     addr =3D kzalloc(sizeof(*addr) + offsetof(struct sockaddr_un, sun=
_path) +
> > >                    UNIX_AUTOBIND_LEN + 1, GFP_KERNEL);
> > >
> > > 2. Use temp buffer and memcpy() for handling.
> > >
> > > 3. Keep the current code as it is.
> > >
> > > Do you have any other suggestions?
> >
> > I'd choose 3. as said in v1 thread.  We can't avoid hard-coding and
> > adjustment like +1 and -1 here.
>
> The option 3 would result in a waste of ten bytes. Why not choose option =
1.
>
> I have a question about the initial use of the hardcoded value 16.
> Why was this value chosen and not another?  sizeof(struct sockaddr)?
>
> Its introduction felt abrupt and made understanding the code challenging =
for me,
> which is why I submitted a patch to address this.

To be clear, we are discussing here about using kmalloc-16 slab
instead of kmalloc-32

I find this a bit distracting to be honest, given the cost of a file +
inode + af_unix socket.

IMO it might be more interesting to document why abstract sockets
names are limited to 5 hex digits...

