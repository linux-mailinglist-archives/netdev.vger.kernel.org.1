Return-Path: <netdev+bounces-154764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA5D9FFB3F
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE673A375A
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7801AE876;
	Thu,  2 Jan 2025 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXSzYTVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A061ADFE0
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735833452; cv=none; b=YZgrV2HiTvHmxi6EeIIMeIUM6WwK3wWfQ4EZVJaSMtAGJMXVYgmyNJaqbUfjPs+ZX0HK4GOqnQY0/QD3GN4Kfvit1aOhRZMYV96atxe2So75t1SoYCrqNcC3AjAB/7GaHrjb3mI3kn0yvzj6OQILZxGhe+3tUQ43J/3+WAPZqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735833452; c=relaxed/simple;
	bh=hSF/gFT+7oCtGF/jqYkMV+u/e+GFqRaaslIIj5mjOWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5hbJg1VoB8cqFFel5zGqj2oQF4dR78bhRBthhss8edD6o86/u/C/hSHNFttc+XWLYqR6+OR/VGgMBwi+HrxKyRIyhPxjNMFjYwQuvIwQ/1kI7DsDKLoFX8ZKTZ2Z8XX7ndcRMoFWnrnfFH1U3lpdXI5jCT7P6TwHkyeaCxCEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXSzYTVV; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467a6781bc8so82560031cf.2
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 07:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735833450; x=1736438250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f8hlL9BRDkOZu56JhLd5dFau8J6UXbtNH8q4mFqnZU=;
        b=XXSzYTVVbPHKqVpW4iD/V5W+p5YZKS/ZzTwvkN3Kva6Qp375N1xGc4xamONB8uAnOb
         HP1t4KUVz8/+gbl/I49S/AGxfnZGsQ/onsTOHDwNBDfGbwXf5jRtDFQzK502MzvvdrKh
         f/RvdBQ9a+yBgPedfdv4c2xqaCLsPz4F1hAIZd2io/d+APcbffYjGlwN5akL2xQXKEZD
         iZqN71o4iWFYf49ESzYv7FN1nyX+j4IeiKvUTlMxTnJtdZR08uQKbkAtctpcMrixrrI2
         B9nEhlWPEVMSURG9CViEXy0vRAwcCpgGcnLzei/68zUQfHfF4gq1Ydtgps2tYqGMki+a
         bRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735833450; x=1736438250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5f8hlL9BRDkOZu56JhLd5dFau8J6UXbtNH8q4mFqnZU=;
        b=uBrGtCdILO1XkuWM5juVL3sQG/w13fT8PqahJATYt84OGXXT0dihfuyvIRoYWbNcjy
         5iF3UW80ySUHmCUBKU45DrZaBGsU0F997wdyQziM7bJCBmffZ16bJq+xWpeWgfREbuU/
         qBZk7jsPPzR/3iWf12mGwZEfAPSmnyAe39KToiyODM1QyZl4PcLJ5yOGQc2FKwRDAtpn
         cNRQgTnHLIcS06S4Po8YpmxYdSvCgHbBI6YkDR0VoBmAKKIU439RUIB1Goe9i2tfCRN8
         FakdlY43YRcbBX5cVlRaLWDE6XtoTpJQnz/XmLOGGPzDrGLIZe7zBB6bQfPO8kPpegRB
         kWBA==
X-Forwarded-Encrypted: i=1; AJvYcCUDjTa8xvPhiz2GbbgR8yRRuDJ/gDRe8S8ECOSidjjENpYpq8EdyRbM7J4WvgVwt/kGUyioN+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjy3+h1M2+ibEYu0PssOUtcDvr+ShfZzcnnlIYTE3L9UZSCM3h
	MyqT2v1vuxhYYs/ktIgHSwiOD3K3P9ohKjJpEbmLK45Tv+vPOjii7R2/9lIKv/TnRlyzkK+Lr+d
	peLXHNlKZF/+aZNYHdM446/kuCGA=
X-Gm-Gg: ASbGnctnmQrFmryu8aLWOYvKD/7mfDzVsctrW7F0FkmX+35w4W1EEq9lzWmTQxVC1Fg
	vsDyjzWdNFSKHvMyeo2pn5Oh6CSbEvtrV50cMEQ==
X-Google-Smtp-Source: AGHT+IGWWG/8FknTiGM5IWIK5/t2GJB7a770QBe6q6N0FyVn3StVfGZrpChLuqCSSJ9KfwEYNnxDL1XsdTMcFBwSmlA=
X-Received: by 2002:ac8:5acc:0:b0:462:e827:c11a with SMTP id
 d75a77b69052e-46a4a8cb0c6mr751458321cf.19.1735833449819; Thu, 02 Jan 2025
 07:57:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFmV8NffAhhBR74xiq6QmkmyDq00u9_GxORNk+0kbFHk9yNjcw@mail.gmail.com>
 <20250102080258.53858-1-kuniyu@amazon.com>
In-Reply-To: <20250102080258.53858-1-kuniyu@amazon.com>
From: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Date: Thu, 2 Jan 2025 23:57:19 +0800
Message-ID: <CAFmV8NdMqfajmq1W=zAPpeJ28tCwekfi6-7jy6wunYDZXKRVUw@mail.gmail.com>
Subject: Re: perhaps inet_csk_reqsk_queue_is_full should also allow zero backlog
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kerneljasonxing@gmail.com, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 4:03=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
> Date: Wed, 1 Jan 2025 23:02:56 +0800
> > On Wed, Jan 1, 2025 at 9:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > On Tue, Dec 31, 2024 at 4:24=E2=80=AFPM Zhongqiu Duan <dzq.aishenghu0=
@gmail.com> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > We use a proprietary library in our product, it passes hardcoded ze=
ro
> > > > as the backlog of listen().
> > > > It works fine when syncookies is enabled, but when we disable synco=
okies
> > > > by business requirement, no connection can be made.
> > >
> > > I'm not that sure that the problem you encountered is the same as
> > > mine. I manage to reproduce it locally after noticing your report:
> > > 1) write the simplest c code with passing 0 as the backlog
> > > 2) adjust the value of net.ipv4.tcp_syncookies to see the different r=
esults
> > >
> > > When net.ipv4.tcp_syncookies is set zero only, the connection will no=
t
> > > be established.
> > >
> >
> > Yes, that's the problem I want to describe.
> >
> > > >
> > > > After some investigation, the problem is focused on the
> > > > inet_csk_reqsk_queue_is_full().
> > > >
> > > > static inline int inet_csk_reqsk_queue_is_full(const struct sock *s=
k)
> > > > {
> > > >         return inet_csk_reqsk_queue_len(sk) >=3D
> > > > READ_ONCE(sk->sk_max_ack_backlog);
> > > > }
> > > >
> > > > I noticed that the stories happened to sk_acceptq_is_full() about t=
his
> > > > in the past, like
> > > > the commit c609e6a (Revert "net: correct sk_acceptq_is_full()").
> > > >
> > > > Perhaps we can also avoid the problem by using ">" in the decision
> > > > condition like
> > > > `inet_csk_reqsk_queue_len(sk) > READ_ONCE(sk->sk_max_ack_backlog)`.
> > >
> > > According to the experiment I conducted, I agree the above triggers
> > > the drop in tcp_conn_request(). When that sysctl is set to zero, the
> > > return value of tcp_syn_flood_action() is false, which leads to an
> > > immediate drop.
> > >
> > > Your changes in tcp_conn_request() can solve this issue, but you're
> > > solving a not that valid issue which can be handled in a decent way a=
s
> > > below [1]. I can't see any good reason for passing zero as a backlog
> > > value in listen() since the sk_max_ack_backlog would be zero for sure=
.
> > >
> > > [1]
> > > I would also suggest trying the following two steps first like other =
people do:
> > > 1) pass a larger backlog number when calling listen().
> > > 2) adjust the sysctl net.core.somaxconn, say, a much larger one, like=
 40960
> > >
> > > Thanks,
> > > Jason
> >
> > Even though only one connection is needed for this proprietary library
> > to work properly, I don't see any reason to set the backlog to zero
> > either. But it just happened. We simply bin patch the 3rd party
> > library to set a larger value for the backlog as a workaround.
>
> A common technique is to specify -1 for listen() backlog.
>
> Then you even need not know somaxconn but can use it as the max
> backlog. (see __sys_listen_socket())
>
> This is especially useful in a container env where app is not
> allowed to read sysctl knobs.
>
>

Thanks for sharing this information I do not know.

> >
> > Thanks for your suggestions, and I almost totally agree with you. I
> > just want to discuss whether it should and deserves to make some
> > changes in the kernel to keep the same behavior between
> > sk_acceptq_is_full() and inet_csk_reqsk_queue_is_full().
>
> I think you can post a patch to make it consistent with 64a146513f8f:
>
> ---8<---
> commit 64a146513f8f12ba204b7bf5cb7e9505594ead42
> Author: David S. Miller <davem@sunset.davemloft.net>
> Date:   Tue Mar 6 11:21:05 2007 -0800
>
>     [NET]: Revert incorrect accept queue backlog changes.
> ...
>     A backlog value of N really does mean allow "N + 1" connections
>     to queue to a listening socket.  This allows one to specify
>     "0" as the backlog and still get 1 connection.
> ---8<---

Okay, I will post a patch later.

Best regards,
Zhongqiu

