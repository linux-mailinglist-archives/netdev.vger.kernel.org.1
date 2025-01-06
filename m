Return-Path: <netdev+bounces-155549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 288E0A02F0C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D761885C2A
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C88E70830;
	Mon,  6 Jan 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6WTQA29"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C812E4A
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184814; cv=none; b=TUq8JeZ5skPASemwrRc2EWGssgpilswlCO1f4u8q1sx7S62MXUn0LyVpwnYKOF7krMOTxFHGfkGBWvYX10WUqry3sah7nEpha8/5c+hfmaCT3QKHDeAk0vBM+vNZCthV84xDH8GEWBY1WzLJRG+E8jFZAz5Kzkyd754hUI7sMJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184814; c=relaxed/simple;
	bh=J0Fp03FhC0uR1cZtSoquQeiDti2qtRoQSRaV4DZNnLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MipNAbwpe2bj2ymafSEuyjRrplF0pXbEeMstw2HweEsUch97C+0tuBEzG3+dJ6sFpIrk8hQxcFcb++pLGT41xNedaFIbf+stEuJ6xmJh1ZaYeFceFy1KPxjTSCMgrh1rcPv7RpCQK+q0+GKqz2zeQDYTl1T5FAmVIxPTkqlFbgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6WTQA29; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-29e842cb9b4so4568759fac.2
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736184811; x=1736789611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J0Fp03FhC0uR1cZtSoquQeiDti2qtRoQSRaV4DZNnLM=;
        b=F6WTQA29XUYWSMW6PSccvGxMdCy/i2ST44TlZsZBTaV36L6YPPuMFIt7j9bs/ME+Jm
         KzPM/t7uAhfyIVOz5avGHUhcziQSaE519CUhlRiY+7CFUR9KKmDGbvc8A/+hcGfm6IJZ
         aOqbAZaHqVq7mR1QvMQVKgIG5U3QLdLLfGqe2FIsf01YcvXfJt4klJUaBC9MFRHKCO6L
         sMJQpo6OTNSBWp6h4BsKdQuWGcQ3K6SrNVCTgRieiZIZjZD5RlXpFSzukeNbnH8HMiUp
         jBP4YPF4mGYWvXOEzovqBFjo+5QPCreTXU7zeu4cibtEr7r13aIXB/P92RMtzLaPKYia
         sU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736184811; x=1736789611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0Fp03FhC0uR1cZtSoquQeiDti2qtRoQSRaV4DZNnLM=;
        b=WGxnD2OsdsFTYAmR5EWie+3CAeCcYF23QJ9sC2BRyizxW9lKGGLoxElX/o/gI/Re7s
         3YIO3zpY4bcOJ58rX0HOeP4BzdR57BCWU5fi/uKuYlz5Tg2RCiVGt9NUeVCmH1D01xZb
         g7pxLc4SaBCCbKAWaq8LIiJz3+nP1PL7J/kI0rauA+EnnzlMoKauZYpgKinNDM29tV7k
         TY4QPbSqUf6YK4iw1eUuFqNzUOdZdNCB/pbQVUJnf0gLNbTINudGK0wDB8q6+0gNpNiH
         Y+ZrkNjHu4egI03h7od0MMNVyp566AwXtwvc0lhx+eSkaC2aXaonlhMvoFPy69xpMRep
         BRig==
X-Forwarded-Encrypted: i=1; AJvYcCWdcpT2ddld2GqJlD4YatktiDQ98A28z1Pm3SvMhu5aLKc0VkOme/iFGFPxHFgY8tZfqX65G0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YykTBbv58WjxHc1tFuVtVuMb/qn+gl+Qr0yzxrnWm4nlqa92sMF
	SOkTrftgkWa2RagjhhsKTsFNp5eTJwpiB8AOXNiTx2J7c4l87+8w1zfA018K1lXdE4RzviZK+94
	XtT5S0FXODLs7Q7UaXZqj2ib67TrwZLAa
X-Gm-Gg: ASbGncvtd4MYo666IsgRSb09Q/QLzEapYYeXV7xHbZAgU0OwECJTcTbgGPihPRM57wc
	j2tN78on/oGVobBObL1vp05edaQEvCUHUaWQfKgoV3O3ta0b7XksDlSm5C7urX8Ub1orI
X-Google-Smtp-Source: AGHT+IErwozEMHkar2ldlh9JO/93aCBCkSLQq1RSnLT9wZQbHSrCa+T/mm1iulifB0WkswCIa9UFLtOfDPtWkLvfs4I=
X-Received: by 2002:a05:6870:4f15:b0:29e:76d1:db4b with SMTP id
 586e51a60fabf-2a7fb00b5c1mr32816168fac.6.1736184811359; Mon, 06 Jan 2025
 09:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105012523.1722231-1-kuba@kernel.org> <20250105012523.1722231-2-kuba@kernel.org>
 <m2a5c4nkbu.fsf@gmail.com> <20250106073641.1003e36b@kernel.org>
In-Reply-To: <20250106073641.1003e36b@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Mon, 6 Jan 2025 17:33:20 +0000
Message-ID: <CAD4GDZwF-ubL+enDVHOBm43CDPgovNHPBycjcNU6t-uADvkxAA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] tools: ynl: correctly handle overrides of
 fields in subset
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jan 2025 at 15:36, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 06 Jan 2025 13:27:49 +0000 Donald Hunter wrote:
> > > We stated in documentation [1] and previous discussions [2]
> > > that the need for overriding fields in members of subsets
> > > is anticipated. Implement it.
> > >
> > > [1] https://docs.kernel.org/next/userspace-api/netlink/specs.html#subset-of
> > > [2] https://lore.kernel.org/netdev/20231004171350.1f59cd1d@kernel.org/
> > >
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >
> > I guess we're okay with requiring Python >= 3.9 for combining
> > dicts with |
>
> Ah, I didn't realize. Does YNL work on older versions today?
> I thought we already narrowed down to 3.9+. That may have
> been tests not YNL itself.

You're right, we may already be committed to 3.9+

> The "oldest" OS I have is CentOS 9(-derived) and has 3.9,
> so from my selfish perspective 3.9+ is perfectly fine :)

To be fair, on a previous commit you mentioned that it affected CentOS
8 which EOLed back in May 2024 so we shouldn't feel compelled to
support it any more.

https://lore.kernel.org/all/20230524170712.2036128-1-kuba@kernel.org/

