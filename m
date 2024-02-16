Return-Path: <netdev+bounces-72229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D19857232
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 01:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A769283317
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 00:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A32624;
	Fri, 16 Feb 2024 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IR3cI7bt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD0170
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041912; cv=none; b=Vmf1a7v1MIOpVb+Ozi0GJp0xSKvK9PGRoB+adXZA1OGsqx2bnJ9rfddpfnA01QXDi3syeSaxVWzn5Ln0mkkURwL4pAVK+UvceUiKe5zJLi9CsEDz9xbNKxqkQruKPOLtmUnsIwmKyHRlClu+dNhFBh1CzXl7IUEyRJo9flxMxcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041912; c=relaxed/simple;
	bh=LoOnC4FQRv0F/O+cUjwXbOIDhDRls+e8GzdMRDc8KhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYbYGZSf0uJnKcifrlbGxmr39HEEguKAUSkExEZ1XNbARZL0HToDRhsPO/+UlIbDktI7M9qYr2geDwU+T0CBTCpKHtgdkpsySVu7SHlIPVLGI5RqQrAUOpw8wwlTnTu5kMIUDmXnOkfIpOul+ArTnDnQzTu2w0oWxcIapiuOOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IR3cI7bt; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so863635241.3
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 16:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708041910; x=1708646710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diXWtKNJBAfA4PgnFo0WoPDjp1XguB77YFwSlLLsiFQ=;
        b=IR3cI7bt53zqM6Rc7R51ECix2OD1Bni9dQscoOPEc91+WbeHHbF3BCKuMNlasG/U4U
         OwGBqeehAdnI5o+KOfuLE90YqX2QiLNHIozy4XyBdQwCjftvbbNkKnC3C5MUUpf35MA/
         EonINoUytCJwydT/Bt33pRiYJ8z+OGM00rPJUwOTMTzZRAlWX4aM7mbLwkm8rrPs/XqZ
         pGiu0YHAl+h7ferrSZGBT/iHOpbLNGzfwzUvyuDzebALNlQxVrjRA0l8BNkvqh6hK14y
         NKwp4TSXgA0LgRim67alJuaPLOly6jjXQYe+KlEfEv08q0nLMrnze/MBx9UBx7rPTRvJ
         nM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708041910; x=1708646710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diXWtKNJBAfA4PgnFo0WoPDjp1XguB77YFwSlLLsiFQ=;
        b=oNTvCkqktfXfEy+Zz7qP+oWGpHEeOJgOuVEXnxsHsFE3SQEHyz/L43/SwLa6NvCvHa
         Wb/g1RoA7ogxkwx0RwWUJOHVs0nCNSYLAsbIgvwpv18yJXFC+X9TnAywvTXMqkFiO6aM
         yaWqH/RAYh7se6s0rQ0vwNTbul55YJzY0LBbGouoZP8bwrIG4d96uFSiyq9+mU80Ad4I
         3XqPx06tu8J2pjKAzfS23ruTVMtxFtnjoRmug+Mzc7vdMf27wht2ATWk1uXmqvMRhz8G
         9GugBbehbVhlV5WrlYJaXVxAs6SC7X2iMflRS5K0xlTlIi5rVaVSs7u21qR1Eh7MAgJ3
         ka1g==
X-Forwarded-Encrypted: i=1; AJvYcCVBh1ocKw0ULl98kZJszqpgmo+4aJbp2gFubD00iA6HaIWp6Hy5SHbEm14MCUPhWHiv4the59FGIXcsrGxfz2NRszE6ZN4a
X-Gm-Message-State: AOJu0Yxyarw3b9KSPfIqpDlP+7/aUyvxgaNOzOuux6fvSVcKxB8B/vaj
	V003GnFH6Zj25NPXllwz/U+ij9KIClzrOCh7RvwWUv2R3vdXciVXrAGCvh0HtYtupNSvFFjrhGa
	0UIKQcponO3cjk3ET8bJGK6fBSRBn1wbtMzlv
X-Google-Smtp-Source: AGHT+IFIplzGzmriL1xaco+Og2hYr/egwhzq10LIBoz2G6IYXCZo3nz2w4ZXagy0mqXn2T0wS9sEvcT0l7HtxNN29lo=
X-Received: by 2002:a1f:edc1:0:b0:4c0:2181:81ac with SMTP id
 l184-20020a1fedc1000000b004c0218181acmr3240323vkh.14.1708041909812; Thu, 15
 Feb 2024 16:05:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADVnQykqkpNTfO30_aswZEaeSkdu5YNuKag++h-RSguALdeohw@mail.gmail.com>
 <20240215201627.14449-1-kuniyu@amazon.com>
In-Reply-To: <20240215201627.14449-1-kuniyu@amazon.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 15 Feb 2024 17:04:53 -0700
Message-ID: <CADVnQynSy8V9etoiL9jLMgqAdGwbLXnCYia4j3pp60pxbdg7zA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, jaka@linux.ibm.com, 
	jonesrick@google.com, kuba@kernel.org, kuni1840@gmail.com, 
	linux-s390@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	soheil@google.com, wenjia@linux.ibm.com, ycheng@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 1:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Neal Cardwell <ncardwell@google.com>
> Date: Thu, 15 Feb 2024 12:57:35 -0700
> > On Tue, Feb 13, 2024 at 3:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
> > > removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22 ("net=
:
> > > remove SOCK_DEBUG macro") removed the macro.
> > >
> > > Now is the time to deprecate the oldest socket option.
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> >
> > I would like to kindly implore you to please not remove the
> > functionality of the SO_DEBUG socket option. This socket option is a
> > key mechanism that the Google TCP team uses for automated testing of
> > Linux TCP, including BBR congestion control.
> >
> > Widely used tools like netperf allow users to enable the SO_DEBUG
> > socket option via the command line (-g in netperf). Then debugging
> > code in the kernel can use the SOCK_DBG bit to decide whether to take
> > special actions, such as logging debug information, which can be used
> > to generate graphs or assertions about correct internal behavior. For
> > example, the transperf network testing tool that our team open-sourced
> > - https://github.com/google/transperf - uses the netperf -g/SO_DEBUG
> > mechanism to trigger debug logging that we use for testing,
> > troubleshooting, analysis, and development.
> >
> > The SO_DEBUG mechanism is nice in that it works well no matter what
> > policy an application or benchmarking tool uses for choosing other
> > attributes (like port numbers) that could conceivably be used to point
> > out connections that should receive debug treatment. For example, most
> > benchmarking or production workloads will effectively end up with
> > random port numbers, which makes port numbers hard to use  for
> > triggering debug treatment.
> >
> > This mechanism is very simple and battle-tested, it works well, and
> > IMHO it would be a tragedy to remove it. It would cause our team
> > meaningful headaches to replace it. Please keep the SO_DEBUG socket
> > option functionality as-is. :-)
> >
> > Thanks for your consideration on this!
>
> Oh that's an interesting use case!
> I didn't think of out-of-tree uses.
> Sure, I'll drop the patch.
>
> Thanks!

Great! Thank you!

neal

