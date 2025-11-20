Return-Path: <netdev+bounces-240491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E442BC75766
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id AD5CF2BFED
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB86369992;
	Thu, 20 Nov 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ih0BDNKS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAEC35E52C
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763657308; cv=none; b=T4f5kaLLU7p657swvWSnOfxlGynXNganqOLYKarI98khWkG/PepgSIAMTZWeE1ze/Gm6szwFiV9GposZ5SPRQQKilGw3HRLvjOH+MUPi0t1G0CfOY+veEKu+OMUNOFo1/DpHlJtPNxAvk0oQyFbNP/yfBsBwn6M6Qc97N1dia2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763657308; c=relaxed/simple;
	bh=N+av1V9z9y7TptkRFnUJpYIorgVfCv8xrM7rU+y2IP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjRFwc3pfzu0kq4bA6WIz8xx9ra6ezjiZpIgB7/JuU93qgeQCl51y2/Y6FuT3y4v3qZskqv0os538Htv9mSWqnZNvEGOyz/FMdxahJ2mPguq30rcoEtlHtKGBIuzf138nh6poHy6USUNKMFOSbEboM4mS9WH6EUryIl6DC1Y3Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ih0BDNKS; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee243b98caso292161cf.1
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 08:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763657306; x=1764262106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxGjazSHqn9sM/he04tGkXIBH0z5/kApvL+Oqyzo8W8=;
        b=Ih0BDNKSqbZudF0GKH9vCQLp8a7TSFC93QW4oKev46bvuYg1yV80ziiaYXaj5WL07V
         DT8Bt1hUznPvAGi79IUcT7GRTRCxNodDq5SJXR4f8XYNVUJltQSjAs8B0txmT8gRUtbr
         D69BJf/K7ZYQPraQr3Yv9FDpSK5r0JPDsrLcjjEKMy6rXN+svi1pv/Ee2RK37ABhPfyj
         /i9b0+2itL7m9EXkNpg28lHGGCfXR0zIz2GkabMhUz9QyKQKHqP0tlBf/q/Jwg0+wqCp
         Ib899suoxrZ7wUE4yZWTIGbVtPBQxHzZYXkKh9gSc87rUHKxegXHO0hA3rZvzmCCOdPN
         9UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763657306; x=1764262106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LxGjazSHqn9sM/he04tGkXIBH0z5/kApvL+Oqyzo8W8=;
        b=MjuVRiUK20Y65ZghFUzfTRWT/iWCVmxPFQRzELsA1iQ713LE/kw7FzyKnsTDBzhSTN
         CdnrPvQafI3VxT9qX7L9Er7VatiPS9RGn1ajDo3krBhhGa7EWWvCPAcFKMHFHets4NPe
         A9Em/KvsuMkv7T73OLjcom46ri8jZPTv7UYfKUfvSQq4f5kDi8bnSfJUYcr0F8XIsKtR
         Q7PYJS/VRWPFwARpaKMJQB/sFBW9KeiIdrLrARnK02AhbaZPpMvG8PeZICkX3phvYLht
         91pKnfvsHdOiv/rbGAuP6XgrM14aTqaZILs+EvuE2+wjnZm0XG3AOHKpDaxvsRdOwiLA
         +Veg==
X-Forwarded-Encrypted: i=1; AJvYcCVPojtvtqG9cptk9ioBlx83NgRh6SD8LbEIXGT3xyB2PmgLYj402dbepo+3FcU9VOtcZ/BgYq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztUtO/iS5Sk/mTnZb9Ij68v2noeeWbJad/KC37eB4ImCu/6Y+v
	44KGDzvWonf6YhETHBpUk6kNUPm36ystIGoegDKubu/MYtPeAZAxmSz7gPHLjmCkW+0opoo9L6K
	yG7uZUrO9/B50GGfDS2L9yXp+gKFrjV087szuc46R
X-Gm-Gg: ASbGncv8fAd6yjp6XxPaGnJDbQA9bdodN7XrqQX6OE/PFeUfjeNRdNKyeRnFBFT2bbS
	xcBXwbBDPaJfsswL690dy1bzJE3XHmnD08p0uCPWjf0jRHNe5u3bMKdCPbKyFIDMzKSVW+696ZA
	7DbZoJnCxIc5gaxmQ+t9xCiI2PSxkhdmyvMlpoZbzFy6GBm25trOSv5s5JDfyS2ini/6TIGfgK4
	+Irgd9e9L5fGjsHCBzU2YZaHmeEDJsYm8MsxQqkt2BQYZ8JkaESAXHeRYZE4jG6HJBzftSaVUGn
	cr9bmwky3jFpPHxMDeJ1L7l9IKGZ9VCBiaqI2eiaLlLHSHOFNTEUYvWHlfxBIb2q0uRTlw==
X-Google-Smtp-Source: AGHT+IGTAh/1TkE04XJgeZYaG8lKCNKCk6OAgW2sS1qehNlP8IA0/2tKgcJW5Oya3vDRMJpBYq0x9BK3/tmK6tTd0G4=
X-Received: by 2002:ac8:5792:0:b0:4e6:eaea:af3f with SMTP id
 d75a77b69052e-4ee4ae9fe3cmr4987121cf.3.1763657305485; Thu, 20 Nov 2025
 08:48:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OS7PR01MB13832468BD527C1623093DDDA95D7A@OS7PR01MB13832.jpnprd01.prod.outlook.com>
 <CADVnQy=4BRX-z97s2qnNjLDSOr5hce4x6xknaySy6=Wrpjhn1A@mail.gmail.com> <OS7PR01MB13832DD044176D127AEE48B2995D4A@OS7PR01MB13832.jpnprd01.prod.outlook.com>
In-Reply-To: <OS7PR01MB13832DD044176D127AEE48B2995D4A@OS7PR01MB13832.jpnprd01.prod.outlook.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 20 Nov 2025 11:48:05 -0500
X-Gm-Features: AWmQ_bmQiP2Dis9rTUQjYuez6mruv-YAlfA8yi8NnGmKgixOQ-5WNm3HL3ektKk
Message-ID: <CADVnQykxV+E6VqsZTSi9pnQNgZ5xFFbdtJTafU_yUShghmjnMA@mail.gmail.com>
Subject: Re: [PATCH] tcp:provide 2 options for MSS/TSO window size: half the
 window or full window.
To: "He.kai Zhang.zihan" <hk517j@hotmail.com>
Cc: edumazet@google.com, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 11:13=E2=80=AFAM He.kai Zhang.zihan <hk517j@hotmail=
.com> wrote:
>
>
> On 2025/11/20 00:43, Neal Cardwell wrote:
> > On Wed, Nov 19, 2025 at 11:30=E2=80=AFAM He.kai Zhang.zihan <hk517j@hot=
mail.com> wrote:
> >
> > Please read the following before sending your next patch:
> >
> > https://docs.kernel.org/process/maintainer-netdev.html
> > https://docs.kernel.org/process/submitting-patches.html
> >
> > Rather than attaching patches, please use "git send-email" when
> > sending patches, with something like the following for networking
> > patches:
> >
> > # first check:
> > ./scripts/checkpatch.pl *.patch
> > # fix any issues
> >
> > # then send:
> > git send-email \
> >    --to 'David Miller <davem@davemloft.net>' \
> >    --to 'Jakub Kicinski <kuba@kernel.org>' \
> >    --to 'Eric Dumazet <edumazet@google.com>' \
> >    --cc 'netdev@vger.kernel.org'  *.patch
> >
> > On the specifics of your patch:
> >
> > (1) Can you please send a tcpdump packet trace showing the problem you
> > are trying to solve, and then another trace showing the behavior after
> > your patch is applied?
> >
> > (2) Can you please provide your analysis of why the existing code in
> > tcp_bound_to_half_wnd() does not achieve what you are looking for? It
> > already tries to use the full receive window when the receive window
> > is small. So perhaps all we need is to change the
> > tcp_bound_to_half_wnd() logic to not use half the receive window if
> > the receive window is less than 1 MSS or so, rather than using a
> > threshold of TCP_MSS_DEFAULT?
> >
> > thanks,
> > neal
>
>
> Thank you for your reply! I will submit the patch according to your
> suggestions next time.
>
> soon
> (1) This issue actually occurs on Linux 4.x.x, caused by the function
> tcp_bound_to_half_wnd().
> This function first appeared in 2009 and has never been modified since
> then. Moreover, Linux
> 4.x.x is no longer available on the homepage of www.kernel.org, so I
> assume you probably
> won't accept patches for Linux 4.x.x. Therefore, this patch is based on
> Linux 6.x.x. I will prove
>   based on my analysis that this issue has existed for a long time.
> Regarding the tcpdump you
> requested, I will send it to you later for reference.
>
>
> (2) In the current era, when dealing with embedded devices which often
> use the lwIP or uIP
> protocol stacks,MSS is generally around 1460 bytes. However, in the
> tcp_bound_to_half_wnd()
> function, the value of TCP_MSS_DEFAULTis 536U/* IPv4 (RFC1122, RFC2581)
> */. When the peer
> has only 1 MSS (i.e., 1460 bytes), and we want to send 1200 bytes, Linux
> judges that this exceeds
>   the 536 threshold and thus segments the data, sending it in two parts
> (the first 730 bytes, and
> the remaining in the second). But Windows 10 sends it in one go. What I
> want is to send it in
> one go. Previously, I considered changing the threshold of
> TCP_MSS_DEFAULT to 1460, which
> seemed convenient and safe, but it doesn=E2=80=99t seem appropriate=E2=80=
=94this
> threshold originates
> from the RFC 1122 and RFC 2581 standards. What do you think? Is it
> feasible?When the peer's
> receive window is less than or equal to 1 MSS, we can avoid using half
> the window. The
> tcp_bound_to_half_wnd() function introduces a variable parameter mss_now
> and then
> performs a comparison. I'll modify and test this approach later.

Yes, something like that. I agree that when the peer's receive window
is less than or equal to 1 MSS, it seems to make sense to avoid using
half the receive window.

Please keep in mind the tcp_bound_to_half_wnd() comment:

* On the other hand, for extremely large MSS devices, handling
* smaller than MSS windows in this way does make sense.

thanks,
neal

