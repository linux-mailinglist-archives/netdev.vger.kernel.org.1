Return-Path: <netdev+bounces-102362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B3E902AE5
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004411F22C17
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 21:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F2714F131;
	Mon, 10 Jun 2024 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kq/6plVs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262F14F13F
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056203; cv=none; b=PaqUH1/pcbF99D8x5yggEgXpUmnC4Kok8MRMaDqYavlR9fdAx0eH8BttPHQe80ZJg9p/2Leh85M9T5aTvfIPOSUAxMmnxFTBxrj+a3Aa5Z8FrUYPhWPboBZwvnCgJAO1rc9BET+Mw3qAUmsNBUaPapSC2TG8IREY6Ck+UGfGamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056203; c=relaxed/simple;
	bh=aK+MvmAA8kIOyIRHZX1xsB92zhAqy/GTi5BmrSTv5XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bz/9A7P2fkmmVy0S81HXygO2o9QtymbWOxLcbGqtZFn+nYxlRUaQDd2RswIebzm5vDL9QMWUqXBuI4snNLrN7pvk9hVGT5J0WWua/3rDzdZbI+7oWOaYYRuwqlcWgA4r+gtK0tkzhP9E9I7QsG/sZe5Sf2KaiCV3up3rmbx+RGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kq/6plVs; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c5ec83886so2306a12.1
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 14:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718056200; x=1718661000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eksTqXwNHrouSTPFhnmFlzzMzUPXkraejJkVTgCmu2Y=;
        b=kq/6plVsRZ6oo66v8nVl5OXkCnnrRNuBXdQHHKKD7UiNlyko4L78ORAq7cdrEMI7wa
         Y8p1jgmSBtY1lLT1kWaPF74NBdLYMhaQx6FRDips1IENSp+F7+527X3HJ23290XPHO9j
         c34bcNZGtWGLR0Y0jr/pii8HY4Wbx5AHuuDxdNjS69kjLKddj0D5LAolhaz5qV+OZlPR
         muxekwYRon/7rzlJVOyTDUWCMjyUw71WtwpoVISkbjASmm09FXdyZEiIDt7vMrN+0Wq1
         sf0D0uwL+SdtLe3Q1u0IfIpzfwttT4xrXV06veFH0p7BcOakpe718MX4UdIR0of3N9No
         YWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718056200; x=1718661000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eksTqXwNHrouSTPFhnmFlzzMzUPXkraejJkVTgCmu2Y=;
        b=JlLOeliyZfDIYCuDikLnFm2EkDwuCEmim8wiXLEVAyOMlZNIN6DWmNOjCG1UkVWvnI
         eJbuEsga+0zjoswo0QYU8Ww3Vq4N8tDargAyijFAQ9+5jCYOgiRvLK8IiieaxDvlWiRU
         /GEXDJYYIYXpp1/r6XdICWrZTuGYgTK7TXjE13Egl48zpulWN2b3qaMysE+zsKloV6a2
         0iyCBetg7n8j2SxDutBf017hq8l8q9YnWmAtBtJ2QXBKxD6CGPcsJE0DiDm710gOrRH0
         QaQnqiPtjVbfOj09Vhv633le1jFJBEpmHEc7ou/Ira1AaVZ9ZOcWE9wTBu7xWF9O8PbE
         NDmg==
X-Forwarded-Encrypted: i=1; AJvYcCVlMdY+/8JmqZH9fx2Y1MuJ32FA3u6T0OCUQzVpDZf4EEDHAhGbT2FNn3JxhZ7qu/IQ1IitDYUT0ypT2sv8VvqBXa/TjITY
X-Gm-Message-State: AOJu0Yx4+G3Z+CodQn7VvljGzLGqG1iLkcuKCpfC50XtX35XLrsyRgWk
	0r9FwqSOK7cMKcUp1xxTKps+AGehSreC6Gue62AFvoYXNCEmCGkHFZwxZLFc7C0yEWFUCmZZdoB
	vWWKCaVjMDMoM2jivVqFWV11TOzsPcRfGV5kdIeuu7MP15l/MnfYnl5w=
X-Google-Smtp-Source: AGHT+IEozEHs8y0agsnFtGYgTtaJTexOkSr0dHamKFFC+EB2Pbn/u2SuG9c90Sc0TBhIuA40/EQByAp0Kf4h7dBxnoA=
X-Received: by 2002:a05:6402:746:b0:57c:93b9:1f34 with SMTP id
 4fb4d7f45d1cf-57c93b91fc2mr3662a12.0.1718056199485; Mon, 10 Jun 2024 14:49:59
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000> <ZmLEoBfHyUR3nKAV@google.com>
 <ZmNic8S1KtyLcp7i@tahera-OptiPlex-5000> <20240610.Aifee5ingugh@digikod.net>
In-Reply-To: <20240610.Aifee5ingugh@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Mon, 10 Jun 2024 23:49:21 +0200
Message-ID: <CAG48ez3MBGi6i9Xcj29+pD9Lo1_hKkEtWYn-jNqvOZ_WWQZjYA@mail.gmail.com>
Subject: Re: [PATCH v3] landlock: Add abstract unix socket connect restriction
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 6:36=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Fri, Jun 07, 2024 at 01:41:39PM -0600, Tahera Fahimi wrote:
> > On Fri, Jun 07, 2024 at 10:28:35AM +0200, G=C3=BCnther Noack wrote:
> > > Is it intentional that you are both restricting the connection and th=
e sending
> > > with the same flag (security_unix_may_send)?  If an existing Unix Dom=
ain Socket
> > > gets passed in to a program from the outside (e.g. as stdout), should=
n't it
> > > still be possible that the program enables a Landlock policy and then=
 still
> > > writes to it?  (Does that work?  Am I mis-reading the patch?)
>
> If a passed socket is already connected, then a write/send should work.

If I'm reading unix_dgram_sendmsg() correctly, we'll always hit
security_unix_may_send() for any UNIX socket type other than
SOCK_SEQPACKET (meaning SOCK_STREAM and SOCK_DGRAM), even if the
socket is already connected, and then we'll do the landlock check.
That's probably not the intended behavior for Landlock, unless I'm
misreading the code?

Maybe to get nice semantics it's necessary to add a parameter to
security_unix_may_send() that says whether the destination address
came from the caller or from the socket?

