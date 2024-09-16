Return-Path: <netdev+bounces-128539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAA597A296
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4905C1F22CE7
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22851152517;
	Mon, 16 Sep 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZnierOp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798FA175AD
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491369; cv=none; b=bfHJR9mA7864INusvl/uNHDYPmpG17GCfvmfPiSxerkJH6HJeHHbUV/kN2Z+MIFMyDnAIo0aDXAs1gJbBfG/mkrt8QyRwsbyk54PRcnlRCiEbgskiAqPf3jvlXWlzPTUUbLsRRHlw7aymRFnKp7cLAdOGrGTDqIXMnAYgHD4TRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491369; c=relaxed/simple;
	bh=CXR0Aw/mKNiBjS8xTS9DIL/nVCBsiQ4wWbw7avaX9ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrpBoXqM38Zy4/LSEd5MHj6esAvaLvKji6TsPmbY0munSTe7YBnBx1akriqrf7At8vQHOB12YLCtmOm/KIMVNgVSStYqJTq6HS+td4BaMsr+Tckm0w4mUslggLt1MMoHJRdaw4WLZkmTgrPHEk/VZ7y0o0MoO0PX6Q1oMtGpoik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xZnierOp; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f66423686bso39435831fa.3
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726491366; x=1727096166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4NSeUiUFmKGhOq9pmPVcCeEzRIWXcgNUtDDtgQEPYlw=;
        b=xZnierOpJme5Z4RvLOz1HE/fb1W/4UvhGScH3MFzUmBAANqxF4pLxZo5wpNqyhJvXH
         lbc9e/QLlQ6wxw4DPM2Tvt2GjYSu+eCnxi4vu9vYt98yJ5rky7jfgMLrxVHii63AOuea
         KrPLPZq6OO401nLQMXhfse/CWX7dyQZE5uquql1jLFw2xwD4GcroTMi+tMT2ewYxL8MM
         5jvb7GKYv1Ca6t6TE2PN4Ou4ivhnpVFU4rBdG0FU9r+7OeSw2rA6EAhxVAEhuKPe0LNe
         Cou3WTRqwpUateGKvBo//imI9EkxPp7nlFKbXqOgDRYXpxMJV0oHzQrjoNYUACiDjiua
         VN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726491366; x=1727096166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NSeUiUFmKGhOq9pmPVcCeEzRIWXcgNUtDDtgQEPYlw=;
        b=eujeYYqGidefjykiBDB/lfJntZRpGLNioC4QHY2DmeUFJuD3q/cAqOR9fsIuQVg04t
         h0OtYnR6TmxYVwdo1+sp1mGpyD4o9OoVTWHPNktzaZl+WhA6RYFFSBe3CITz8FeEWP1Z
         gt7wmTtulYr8AbZGfIQZGnu9UFPRwo+UU69fnZg7Fm2Zdy+UY9Ha5mget/5rQ4U/Ctk4
         MKC2T6QVYM+jpY92it4sZyWfGXWqDO34+0ypMhCazd6H34/i8smRUfK3A4Dzkfkiye6T
         q2JCmbGpd37csl/JUUBh2dyTWwg1+0Aw2dL95owJDqoPhGAu8Wg2zDUbIM3gshTMmLts
         DzmA==
X-Forwarded-Encrypted: i=1; AJvYcCWI19E6rkYUSwyW9s1MhzpL9vd3bfeRYALKH69hih4vqWWm7iVEYRxQ6Ap2aQXWuvmT1qdU7XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdeuJjCDkXL1pLTznPdNaFwEdMQShSscyRTXEPDGxlHILg0cIQ
	f+gaMvyhwWtYLsKJzaYHFhbeRBFlW6ws7Yt1+n2rDtJOWAL1C6tolqB8guCPvikeckP/BV39mX4
	18XZRcbYoPIWb7Al67rLe8BiNB5oANqhnKFcI
X-Google-Smtp-Source: AGHT+IHsxgmFPsbk+zKV7E1FWylQDNwbKcBeZz6WaPyXeaqjmrVS2H0Awff6LDdt6poIRtEgVlSg/QBPvJCUWUSpa2c=
X-Received: by 2002:a2e:9017:0:b0:2f5:c13:bd11 with SMTP id
 38308e7fff4ca-2f787dcdaf0mr58662251fa.17.1726491365306; Mon, 16 Sep 2024
 05:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000ad94305f116ba53@google.com> <Y7A8r4Yo07BnDxYv@debian.me>
In-Reply-To: <Y7A8r4Yo07BnDxYv@debian.me>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 16 Sep 2024 14:55:53 +0200
Message-ID: <CACT4Y+YN8Hfj4SyaDQoWs8DNU9xGt=LawPdBCJhxZ8qkB17rHw@mail.gmail.com>
Subject: Re: [syzbot] net build error (6)
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: syzbot <syzbot+4ca3ba1e3ae6ff5ae0f8@syzkaller.appspotmail.com>, 
	davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 Dec 2022 at 14:44, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Fri, Dec 30, 2022 at 06:46:36PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    d3805695fe1e net: ethernet: marvell: octeontx2: Fix uninit..
> > git tree:       net
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14f43b54480000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8ca07260bb631fb4
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4ca3ba1e3ae6ff5ae0f8
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+4ca3ba1e3ae6ff5ae0f8@syzkaller.appspotmail.com
> >
> > failed to run ["make" "-j" "64" "ARCH=x86_64" "bzImage"]: exit status 2
> >
>
> I think the actual build warnings/errors should be listed here instead
> of only dumping exit status and then having to click the log output.

Agree. I've filed https://github.com/google/syzkaller/issues/5317 for this.
Thanks for bringing this up.

