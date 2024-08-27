Return-Path: <netdev+bounces-122438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05388961521
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E581F237D8
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AB01C9EAD;
	Tue, 27 Aug 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g06wOX15"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C4D45025
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778485; cv=none; b=oNJj9thgEpsxGiA7SytSfS02OHjTNmDPvKKsTSPUDoB6jyKTst2jAMiEPsiuw3FcEglH8CB6auulNzHPYgJLGTy9b/uYbNQn6Wa5q6Lzr7eRbbsTs/SMt3zc28K9em95KwhtGoM8z3vGVbpOCuCy1zsGCoHFEdYZKJBbKw66M6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778485; c=relaxed/simple;
	bh=zkooE6sJuV2dTH2Xq+qjYDakginVX45NqfwtfIx0m/A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rK0VF8/OXlOnXhGavT7nHaCATYaiooR+YL63vRmJsCZKjcAIzdxCVtXt4NGseAKsbpb/SzSA6muFqLkoBUi1bz+q5rBsR+nhitSRqn7FNfCufp0wT307ZGArd0UStXwNnA30iyz4Ffu+OxpP5xk08Ek0eB6MOYPPErdiHsVb1+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g06wOX15; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1d6f47112so391261785a.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724778483; x=1725383283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nzyafaviKHNiYiuV2YpkSR3aeOPN/uP83yfShSJf6M=;
        b=g06wOX15O+qWDRr5hA018ZgeKe9OtWJ9AcNyu2tiTwbMs23qR7jBl1PokeIjE6JEqc
         4MiteIySaRcEx1H3bBuC52aK/PPpv7z6hAygNN7oMOXnkYQbYlT3ZBGc8oWMu1j5Rdpl
         5FArXAFCOgwhzxKCWg+HFk0CUeanspGZoKNOoVfW5IuP2H+7hCD76QPmg7Odlaq3Eemw
         EfJpWxSt8OkK6ocL2GgNUhqtvfdPwcJ2m9/b1EN3V08XIzCGHZ7FBdwwxauzmCzTeNoo
         W9nUiM5nW+zu7Uf1/qtAUZqO3ZO6BMKahD4LHiOtlRn2mynSiF+t/Iy7qe7+PJ5nIgSa
         J42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724778483; x=1725383283;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2nzyafaviKHNiYiuV2YpkSR3aeOPN/uP83yfShSJf6M=;
        b=rAiZcw5VwuuWkvLU1giIaZnBkjm7zrabc5HjqhKO3yjYPlZ9scxMVxIUvRHnYJrECX
         UZ5/d8pirj1vOSiARhHcVL3Dh81gLLj5C/fH3KN4az96ml4HWQ9DTS1Sw9hQZUlfQdYv
         zTFjrFS4WApHjMn8BJ9a6guZcfUG8+2R4vyMZ/3jOVMbVD/fqc707ayX/Tl/sbr6plDA
         NbYtph6+dSB7qHip0X9sEIk7jzBkvIBbwZct0XupUvpDsroAPOEjj0CO/lh9EWhORNud
         +BNoEi50uxRTKiu75QFopRunWhU0EKZOJ7IfBphz0j651Jgy1RPh9SuPxnw0oJLl0r6s
         KO4g==
X-Forwarded-Encrypted: i=1; AJvYcCXzzDW7jxspn44k61tB7ItY77RXniMH+Ffr2woZbawn36FR+HgtYX6b5EcM4S82tdjNaLqOyWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr5MMkjmIsl0fR+e3/6CBmFT8lXPGEQmMfD/JJ83b5jR8eNB56
	EH+wrPZv38tANHJg0bE1lozG/Q4BBmdWfHoFV1D5njH7Xgpgm+6w
X-Google-Smtp-Source: AGHT+IHNNA1B2L5G/1ZY8tsNsGCozeR95LCLABC8HcgjwIwF/ilP8Ndr3rcM64omsnw84FRhC7w1+g==
X-Received: by 2002:a05:620a:4096:b0:79d:6169:7ab9 with SMTP id af79cd13be357-7a7e4e717aemr422596385a.68.1724778482666;
        Tue, 27 Aug 2024 10:08:02 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3421basm566362485a.36.2024.08.27.10.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 10:08:01 -0700 (PDT)
Date: Tue, 27 Aug 2024 13:08:01 -0400
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
Message-ID: <66ce07f174845_2a065029481@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCZhakNunSGT4Y0RfaBi-UXbxDDcEU0n-OG9FXNb56Bcg@mail.gmail.com>
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

> > > > > Besides those two concepts you mentioned, could you explain if there
> > > > > are side effects that the series has and what kind of bad consequences
> > > > > that the series could bring?
> > > >
> > > > It doesn't do the same for hardware timestamping, creating
> > > > inconsistency.
> >
> > Taking a closer look at the code, there are actually already two weird
> > special cases here.
> >
> > SOF_TIMESTAMPING_RX_HARDWARE never has to be passed, as rx hardware
> > timestamp generation is configured through SIOCSHWTSTAMP.
> 
> Do you refer to the patch [1/2] I wrote? To be more specific, is it
> about the above wrong commit message which I just modified?
> 
> Things could happen when other unrelated threads set
> SOF_TIMESTAMPING_RX_SOFTWARE instead of SOF_TIMESTAMPING_RX_HARDWARE.
> 
> Sorry for the confusion.

No, this is referring to the current state.

> >
> > SOF_TIMESTAMPING_RX_SOFTWARE already enables timestamp reporting from
> > sock_recv_timestamp(), while reporting should not be conditional on
> > this generation flag.
> 
> I'm not sure if you're talking about patch [2/2] in the series. But I guess so.

Nope, same thing. I mention a commit from 2014.

> I can see what you mean here: you don't like combining the reporting
> flag and generation flag, right? But If we don't check whether those
> two flags (SOF_TIMESTAMPING_RX_SOFTWARE __and__
> SOF_TIMESTAMPING_SOFTWARE) in sock_recv_timestamp(), some tests in the
> protocols like udp will fail as we talked before.
> 
> netstamp_needed_key cannot be implemented as per socket feature (at
> that time when the driver just pass the skb to the rx stack, we don't
> know which socket the skb belongs to). Since we cannot prevent this
> from happening during its generation period, I suppose we can delay
> the check and try to stop it when it has to report, I mean, in
> sock_recv_timestamp().
> 
> Or am I missing something? What would you suggest?
> 
> >
> >         /*
> >          * generate control messages if
> >          * - receive time stamping in software requested
> >          * - software time stamp available and wanted
> >          * - hardware time stamps available and wanted
> >          */
> >         if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> >             (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
> >             (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
> >             (hwtstamps->hwtstamp &&
> >              (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
> >                 __sock_recv_timestamp(msg, sk, skb);
> >
> > I evidently already noticed this back in 2014, when I left a note in
> > commit b9f40e21ef42 ("net-timestamp: move timestamp flags out of
> > sk_flags"):
> >
> >     SOCK_TIMESTAMPING_RX_SOFTWARE is also used to toggle the receive
> >     timestamp logic (netstamp_needed). That can be simplified and this
> >     last key removed, but will leave that for a separate patch.
> >
> > But I do not see __sock_recv_timestamp toggling the feature either
> > then or now, so I think this is vestigial and can be removed.
> 
> I'm not so sure about the unix case, I can see this call trace:
> unix_dgram_recvmsg()->__unix_dgram_recvmsg()->__sock_recv_timestamp().
> 
> The reason why I added the check in in __sock_recv_timestamp () in the
> patch [2/2] is considering the above call trace.
> 
> One thing I can be sure of is that removing the modification in
> __sock_recv_timestamp in that patch doesn't affect the selftests.
> 
> Please correct me if I'm wrong.

I think we're talking alongside each other. I was pointing to code
before your patch.
 
> >
> > > >
> > > > Changing established interfaces always risks production issues. In
> > > > this case, I'm not convinced that the benefit outweighs this risk.
> > >
> > > I got it.
> > >
> > > I'm thinking that I'm not the first one and the last one who know/find
> > > this long standing "issue", could we at least documentented it
> > > somewhere, like adding comments in the selftests or Documentation, to
> > > avoid the similar confusion in the future? Or change the behaviour in
> > > the rxtimestamp.c test? What do you think about it? Adding
> > > documentation or comments is the simplest way:)
> >
> > I can see the value of your extra filter. Given the above examples, it
> > won't be the first subtle variance from the API design, either.
> 
> Really appreciate that you understand me :)
> 
> >
> > So either way is fine with me: change it or leave it.
> >
> > But in both ways, yes: please update the documentation accordingly.
> 
> Roger that, sir. I will do it.
> 
> >
> > And if you do choose to change it, please be ready to revert on report
> > of breakage. Applications that only pass SOF_TIMESTAMPING_SOFTWARE,
> > because that always worked as they subtly relied on another daemon to
> > enable SOF_TIMESTAMPING_RX_SOFTWARE, for instance.
> 
> Yes, I still chose to change it and try to make it in the correct
> direction. So if there are future reports, please let me know, I will
> surely keep a close eye on it.

Sounds good, thanks.

