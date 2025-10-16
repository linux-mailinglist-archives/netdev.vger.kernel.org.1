Return-Path: <netdev+bounces-230165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D848BE4ED5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9B41A6589E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B742C2236EE;
	Thu, 16 Oct 2025 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3a3pTR0g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBD20E032
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637307; cv=none; b=tXCn8juhEexz1PHTiCDiB3KRJA01Z3aAp9cbZpg0Vzfnr23rHJH4vw0a73j8PjXv9WX/aJGbbm1MyBi+Wfr/VwppunUl5PmnukjfYyuzTNCS9TBj9QAfWCt2g0dDXvOJakDeSmlGX7AUvQ4brFU3MSeCnQ+QmF+TQflqg6c9lP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637307; c=relaxed/simple;
	bh=0U2YPwT5IuocS4Zxg7BVPVyNOsI3pHdeDz8G5cmBOh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=su0Es1QehIld52xBVQIX565QotNGVvBa4TiVoC3W3nWDzrjqZaGceqf2qHHu2ffJLbTmTSGw6zZbaAWk5uhfiLHnTK+x+PHB1taR9KrUS9SPJynIaNBlR3BBYq5WNzHUE/6laHzZtJ4s5C4QsXmLhTTyZT/DjhugZQLfWXDQJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3a3pTR0g; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7f7835f4478so11856936d6.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760637305; x=1761242105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIjtkXtCGWnAXnneUSPNMivA9H34g09v+D25pgVoc9Q=;
        b=3a3pTR0gBn0ZThmxXjsHy4HKjpZrMkX/UpBrS+1dcPJcA4zq9WX6ShrLvi7/NGJMdO
         Jdd/SKx89ws+SM8S/F+J4fxRDOsI1u+F3202Bq42m7jUT0cGWHz1QjRMtGEMYZkLzWki
         xqAJ85zPRzs5p4e+JvVzz8nKtmPjNqcxsUsVfbbUmZYjGNiwV5iptuVh7zpbGes4RO1i
         75yriX0vOyLXy6cfOdG1hd4Z2Q/wlJ64CKXH4/cfbgJZqz6S+q8Y9z56bPsLebVeRQ9i
         VTMX0T0EOhRrCsRBT/F5pwZI+QNLOzXdXnrQRxIen6BIVzHLBe+rUdOTKGUkZcJEiuC7
         rgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637305; x=1761242105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIjtkXtCGWnAXnneUSPNMivA9H34g09v+D25pgVoc9Q=;
        b=fAz70t+lSlG0iNoybbdNts93oFtJN+Lw9D8TN8NYfIT+LkizLQybMVQLfghThsl4H/
         2x6XxUoDkL3quys9q17t07+ILdFBqA4yOBuEK6zLnyZKrz6RPbKuZOHdD9Rg8JzG6NoO
         SRwXQS5txhhdYH8WfTuYa22w/Ta93YLWVMugHkTdo9B8lPOJHHL8UJb6FfchHd9KEYl7
         woFdbP9zHNxgZQ1s3NbGS8l/QQKYCAxMGPtA2GpQ2HAFrpZastuwK2bL6eAE4Qy3qtLX
         4v4Z+zaCRR33qnPUTKPACnf5iKTAyw8u4ANDXPkOrru4MIv0h44xXT1WUCyZBzqXl5ps
         49LA==
X-Forwarded-Encrypted: i=1; AJvYcCXWhhHRuA2LDxZuOO/wL7kclEBPVKPTeH+xRwzOiSIox7E8obcAh0/afGV4pwjFBS/VRw4B6n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNApGZmidjW0nz5Fyf+tRZLmzamRttC1ptVkwl0dFdEv5umy2
	iXm22WyibfNBy/bAh2YJhKO9IfJz23xQHo6f0Tirvv5VmkEBI8oog+HKg6tJZeCKYfNXX/lGRvz
	O4bApP8nzKvwfnXS1AXpSueuuoynLESRNCXB4U7PI
X-Gm-Gg: ASbGnct2XFI6IvFNNnhJRWqLB9AmrcAYWKd/0xXWqcDm5tcRylOeAGcifjH6FEFo8tR
	3d4NQye3kiLfNQOz9zWmuMBXrhvHis/B35ywdTawR6yJH4KBXJUpOSSoWMq40QO79pioari7uXW
	pGEpIM5lxAqmgVO9iQW3jtK3ANdi8wSnjsYyMr5RmvkxK1ZZE5hy7rT8AW5jOyCxvsX/VjuTf7P
	05GCX/VZZTtaKsftYro2cdecT9pds5hx+qVkaA89NT4TewGZ11hBDm0ZNMsAw==
X-Google-Smtp-Source: AGHT+IFoHrb7lHIEiiAK8aaW6KKC58snkUgwhjx0Byg++BKqFntlzdlXyy5glY2nQY83c3PG/rogFra942FQGZqrys8=
X-Received: by 2002:a05:622a:5c8:b0:4d0:7158:b18f with SMTP id
 d75a77b69052e-4e89d3a1a6amr15622141cf.63.1760637304527; Thu, 16 Oct 2025
 10:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016040159.3534435-1-kuniyu@google.com> <20251016040159.3534435-2-kuniyu@google.com>
 <CANn89iJnQErC8OLoTgnNxU8MURKANbiqXBYaUHsNaTO3m+P54Q@mail.gmail.com> <CAAVpQUA+TEDAQ_8ZNuErMMqngVNRSkzArrRQkyaPU3qE2aUFfQ@mail.gmail.com>
In-Reply-To: <CAAVpQUA+TEDAQ_8ZNuErMMqngVNRSkzArrRQkyaPU3qE2aUFfQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Oct 2025 10:54:53 -0700
X-Gm-Features: AS18NWCW3j-oHLJdmtVhLvfW_teFZEqU3b_MDDd7ax_OZwfPiTf_SKjHbicsOJA
Message-ID: <CANn89i+-ZH+4-64ZHJBGU8_x8BdEg5-OaWqkT8C7ZA=1bOwCeQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/4] tcp: Make TFO client fallback behaviour consistent.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Yuchung Cheng <ycheng@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 10:20=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Thu, Oct 16, 2025 at 9:11=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Oct 15, 2025 at 9:02=E2=80=AFPM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > In tcp_send_syn_data(), the TCP Fast Open client could give up
> > > embedding payload into SYN, but the behaviour is inconsistent.
> > >
> > >   1. Send a bare SYN with TFO request (option w/o cookie)
> > >   2. Send a bare SYN with TFO cookie
> > >
> > > When the client does not have a valid cookie, a bare SYN is
> > > sent with the TFO option without a cookie.
> > >
> > > When sendmsg(MSG_FASTOPEN) is called with zero payload and the
> > > client has a valid cookie, a bare SYN is sent with the TFO
> > > cookie, which is confusing.
> > >
> > > This also happens when tcp_wmem_schedule() fails to charge
> > > non-zero payload.
> > >
> > > OTOH, other fallback paths align with 1.  In this case, a TFO
> > > request is not strictly needed as tcp_fastopen_cookie_check()
> > > has succeeded, but we can use this round to refresh the TFO
> > > cookie.
> > >
> > > Let's avoid sending TFO cookie w/o payload to make fallback
> > > behaviour consistent.
> > >
> >
> > I am unsure. Some applications could break ?
> >
> > They might prime the cookie cache initiating a TCP flow with no payload=
,
> > so that later at critical times then can save one RTT at their
> > connection establishment.
>
> For that RTT purpose, we send the TFO request in all fallback
> cases unless the client sets the no cookie option.
>
> I think this is better than sending TFO cookie w/o payload because
> when a cookie in SYN is valid, we do not generate SYN+ACK
> w/ a cookie unless the received cookie is the secondary one.
>
> Also, errno is not changed in all paths.

I am not that familiar with TFO code, maybe Yuchung can have some time
to review/comment your patches.

