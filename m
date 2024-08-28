Return-Path: <netdev+bounces-122785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517B6962904
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3621F20C85
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5720187FE5;
	Wed, 28 Aug 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNlOYlQJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34A168489
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852666; cv=none; b=L1h2mq8Bcf8GsLDkHDJ2YhrkWSEepdhecDY+p8O9wUrrgFXY+Deu7T9YQ05dRlUFpx9krUYc+kZMYH/hcI81acIQGbWsocOyn8L3BJTb3tv76Y1n0sX54UJ6yZNJdghbh124vPJdOzqT/iO54WwV+mPeqmfM5dVZzjGpHHttE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852666; c=relaxed/simple;
	bh=tReBmlgQW9C+YOLz8Y7ukIdcAQB9KEjgKtUQlfHgpLc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aWiNLqlKldca3L+l3id8GiLOabEAo3Kjg5pOaQsMzIzUeZpsOgsEmq+3ZDr6+eamtiA3kruL0ubOBF4IDFS3hiE1Am2tBDtoUKmv6ZguzVFi+1VC6ZF6FZT5HQwRxXnwBDumVtwbYBRdqbdRD8IB+k9rUtdxJdlDCDfUapTN+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNlOYlQJ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1da7cafccso394340585a.3
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 06:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724852664; x=1725457464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v85yCRJBE0E1sWrbKGquXZ9YVIJ4IPG/mulPy6b/v4=;
        b=dNlOYlQJqcHTmY2Eg0woGCT1+RLMFWQr+DgDAZHKgt3nhYohyE87sLmnXoqABM/1hl
         nSoaeUM8fuG4H1m0hrX/0BG8ZZXgfmefhOk9D4ZIHUBxreL54JK5GzjspOlkw7vHSeeS
         hvbtzsVZt6SpnCe5RGnF30Pp/H939Ip64MeBQMszZfic7xycoop7jbXHxVn4lRbGh56l
         +FtwrRvP2l5/06MjazqLM/8drjUoWr/2w2iYcAffBnCLXT4pCNnsIRcUR0F/6HtE2aX2
         Rq2E4//uLPX16ZR2v45FPUyuEivDQCWoC8GVcBvI+K0yYsk4WeaalSWky7AyNYZi7uwb
         3U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724852664; x=1725457464;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3v85yCRJBE0E1sWrbKGquXZ9YVIJ4IPG/mulPy6b/v4=;
        b=dK7pjhVM6h0GKOHLyopwqHyhLrGH4L5e3mrLJJ0x0mt1GgENz1UAmc0HRwDFQizuN/
         Y2UhO9EhK6iMI+LtIz4yF8PDOSVMBOuxETQG1Lw8SHKkYhnwOcHOqFaG1TRlmaYg5eQT
         feEp9P6bZy/033Z23BpaspnY+tpcHDqspeQVKxIfqgDWaz8TX5P4d4R3apy6jcO7Q5UB
         sl5vtPPWhNvkm4KSxeMDpsOXmGb5nCLmNuVe4U6w0eUJ5yVpBC4gkUd46fD1XR0TB2Rl
         M85c/a8qklHxYC35ZUIMtFkmNidpH3SYPToD2zcdtKSSKJXna96xiH3B26rgoffevQkN
         5O9A==
X-Forwarded-Encrypted: i=1; AJvYcCVCQDKPRCj1EgB0bQLM2FRY/AlsbPaVD45meR1SvrAUb+tAKsm9P97fxzk7bE8FAL19e1XCmrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKVgrWzUEf4P7oXNHLef8Da3y2BwxMvqUdVOMkgLKU22ErA+aR
	ulK4SYMfpgwuMd4lpEZ52pvDLTAb2a8YD1Rt7/DGj2tMBgYdHZHA
X-Google-Smtp-Source: AGHT+IGD3IPxI5EsV4S4ySea4adm4uBRHy3r4E8OjDFfLKSe22gh2JEnLx2W3DJRGsbPDBoCFxW5FQ==
X-Received: by 2002:a05:620a:4542:b0:79f:a2f:a673 with SMTP id af79cd13be357-7a7f4d1c4e0mr199349785a.68.1724852663603;
        Wed, 28 Aug 2024 06:44:23 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f361c16sm642027785a.66.2024.08.28.06.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 06:44:23 -0700 (PDT)
Date: Wed, 28 Aug 2024 09:44:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66cf29b67d686_336087294f0@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDVhYpQwZ7xX4Lv+0SWuQOKMpRiJxH=R9v+M8-Lp9HGzA@mail.gmail.com>
References: <20240825152440.93054-1-kerneljasonxing@gmail.com>
 <20240825152440.93054-2-kerneljasonxing@gmail.com>
 <66cc82229bea2_261e53294fd@willemb.c.googlers.com.notmuch>
 <CAL+tcoBWHqVzjesJqmmgUrX5cvKtLp_L9PZz+d+-b0FBXpatVg@mail.gmail.com>
 <66cca76683fbd_266e63294d1@willemb.c.googlers.com.notmuch>
 <CAL+tcoCbCWGMEUD7nZ0e89mxPS-DjKCRGa3XwOWRHq_1PPeQUw@mail.gmail.com>
 <66ccccbf9eccb_26d83529486@willemb.c.googlers.com.notmuch>
 <CAL+tcoDrQ4e7G2605ZdigchmgQ4YexK+co9G=AvW4Dug84k-bA@mail.gmail.com>
 <66cdd29d21fc3_2986412942f@willemb.c.googlers.com.notmuch>
 <CAL+tcoCZhakNunSGT4Y0RfaBi-UXbxDDcEU0n-OG9FXNb56Bcg@mail.gmail.com>
 <66ce07f174845_2a065029481@willemb.c.googlers.com.notmuch>
 <CAL+tcoDVhYpQwZ7xX4Lv+0SWuQOKMpRiJxH=R9v+M8-Lp9HGzA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > > I can see what you mean here: you don't like combining the reporting
> > > flag and generation flag, right? But If we don't check whether those
> > > two flags (SOF_TIMESTAMPING_RX_SOFTWARE __and__
> > > SOF_TIMESTAMPING_SOFTWARE) in sock_recv_timestamp(), some tests in the
> > > protocols like udp will fail as we talked before.
> > >
> > > netstamp_needed_key cannot be implemented as per socket feature (at
> > > that time when the driver just pass the skb to the rx stack, we don't
> > > know which socket the skb belongs to). Since we cannot prevent this
> > > from happening during its generation period, I suppose we can delay
> > > the check and try to stop it when it has to report, I mean, in
> > > sock_recv_timestamp().
> > >
> > > Or am I missing something? What would you suggest?
> > >
> > > >
> > > >         /*
> > > >          * generate control messages if
> > > >          * - receive time stamping in software requested
> > > >          * - software time stamp available and wanted
> > > >          * - hardware time stamps available and wanted
> > > >          */
> > > >         if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > > >             (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
> > > >             (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
> > > >             (hwtstamps->hwtstamp &&
> > > >              (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
> > > >                 __sock_recv_timestamp(msg, sk, skb);
> > > >
> > > > I evidently already noticed this back in 2014, when I left a note in
> > > > commit b9f40e21ef42 ("net-timestamp: move timestamp flags out of
> > > > sk_flags"):
> > > >
> > > >     SOCK_TIMESTAMPING_RX_SOFTWARE is also used to toggle the receive
> > > >     timestamp logic (netstamp_needed). That can be simplified and this
> > > >     last key removed, but will leave that for a separate patch.
> > > >
> > > > But I do not see __sock_recv_timestamp toggling the feature either
> > > > then or now, so I think this is vestigial and can be removed.
> 
> After investigating more of it, as your previous commit said, the
> legacy SOCK_TIMESTAMPING_RX_SOFTWARE flag can be replaced by
> SOF_TIMESTAMPING_RX_SOFTWARE and we can completely remove that SOCK_xx
> flag from enum sock_flags {}, right? Do you expect me to do that? If
> so, I would love to do it :)

I did not say that. I said that the specific line here appears
vestigial.

> > > >         if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > > >             (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||

One thing at a time. Let's focus on the change you proposed to me.
 
> But I still don't get it when you say "__sock_recv_timestamp toggling
> the feature", could you say more, please? I'm not sure if it has
> something to do with the above line.

SOF_TIMESTAMPING_RX_SOFTWARE is a request to enable software receive
timestamp *generation*. This is done by calling net_enable_timestamp.

I did not immediately see a path from __sock_recv_timestamp to
net_enable_timestamp, so I don't see a point in entering that function
based on this flag.

> > > > I can see the value of your extra filter. Given the above examples, it
> > > > won't be the first subtle variance from the API design, either.
> > >
> > > Really appreciate that you understand me :)
> > >
> > > >
> > > > So either way is fine with me: change it or leave it.
> > > >
> > > > But in both ways, yes: please update the documentation accordingly.
> > >
> > > Roger that, sir. I will do it.
> > >
> > > >
> > > > And if you do choose to change it, please be ready to revert on report
> > > > of breakage. Applications that only pass SOF_TIMESTAMPING_SOFTWARE,
> > > > because that always worked as they subtly relied on another daemon to
> > > > enable SOF_TIMESTAMPING_RX_SOFTWARE, for instance.
> > >
> > > Yes, I still chose to change it and try to make it in the correct
> > > direction. So if there are future reports, please let me know, I will
> > > surely keep a close eye on it.
> >
> > Sounds good, thanks.
> 
> So let me organize my thoughts here.
> 
> In the next move, I would do such things:
> 1) keep two patches in this series as they are.
> 2) add some descriptions about "this commit introduces subtle
> variance, if the application that only pass
> SOF_TIMESTAMPING_SOFTWARE..." something like this in the Documentation
> file.

Make it crystal clear that the distinction between timestamp
generation and timestamp reporting, which this document goes out of
its way to explain, does not hold for receive timestamping.

> 3) remove the last key SOCK_TIMESTAMPING_RX_SOFTWARE from enum
> sk_flags, if you want me to do so :)

Nope.

> If there is something weird here, please point it out so that I can
> make the right move.
> 
> Thanks,
> Jason



