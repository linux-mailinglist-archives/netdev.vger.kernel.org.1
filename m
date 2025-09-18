Return-Path: <netdev+bounces-224250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0165CB82E6C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 06:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B6D720515
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 04:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD822586E8;
	Thu, 18 Sep 2025 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c4l3eKoY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68199219A7E
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170876; cv=none; b=ISDEh6Pxpk9f7Qy0EXfudBTDtVnQgUoFdBlgHEvgjnych566nF8BJIDcLi8QfoLSlGKLkE0ozmYORy89OG0VmipY+rfgaSpWXx1IzyCIci1h2GeDZZXoA6FB1hTwi16Q7dWeIQJYa0JUJxDz5ZxM6h7r/qRNDuOnkK4xP/wCjiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170876; c=relaxed/simple;
	bh=/EotVPQ2fazO+q333eMMFjQICAKBRdVhGAXoakK7FcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKrMcIZm+8gB2IxFASb8vpMBeoUyyStIbZKkdVWkb9koCI/srF2sekY8711zN5cfi4rZciaEXz1znw7qlm0aKkP68xZFSAuN8pGFeLBBFnrMGOUbCswJkHneiwT3j2yOtRUkDF0kaqUFP4N4kAgkHcQR00kQde2XIbZBQA03i0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c4l3eKoY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-81076e81aabso56621185a.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 21:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758170873; x=1758775673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icm0Mx0uEIZ2AHKvNR5F63qVMXOP8j6zMjtxQgp3SWU=;
        b=c4l3eKoYjuDmUAFTsSr1mDFjNG/4EseR6OrYvrDeqeDrqt9Uk4Mj0CDVdH6kyTThpr
         4kMFlv1sxJNhLq6m0tOx19k9N9jTUuF9h3DZJtn2MkpXvxLIyKIXS5oimXB4CUQiLNhx
         VDZbJous2PRdOGps36gRUTTuRwqbg94l3tZOBSB/E34rJ/TXJ6QnjkVlAsvoUY0UhSs/
         tJsf/9rS0XG3GnOH2bwcHO1sQMEsaT/V+6Nt+WLsRUkhAiucb7rRzxuaNgv28b8/FPyE
         bTnRNF3ifIIcJexJHPD/Nu4FainRaoW+gL/iVp9Bicz+oS4YIWoQ69fRlDbowOIG4anF
         BSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758170873; x=1758775673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icm0Mx0uEIZ2AHKvNR5F63qVMXOP8j6zMjtxQgp3SWU=;
        b=KXN/sjLDgIaRG7jhF42Wm8o8Mcu/Q5SrMn8DPFrVZUrQeC9mz4wobYYb5TzaZpBwtT
         NCeYjnoM5IGMFw9mpryL1TLAnMzINrcKWn1eLdwBY+dNIbv5nmvp+7QN3cofpCyRZinh
         5a0IU0UWpICRTO8F0mjwfQ/TUeOQdrCuNcVXaaqF5WQv50NgGSpKD3/EqFi6V50gN+fc
         RwBBAnDeHlPIv8iaf47csPYTNUFkFo8pQwEOi8R9DSULRkxGu1Hgkcgtxf/T4RURgL0m
         wP7kjQDeIGwIy7uK//djdFRdbrE2RHSa1W6jUj7VpifiJA7jBfbJCTkAzCYOXfec6UJy
         +sIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuEERRgEXBR99IBAU6chCvOVKN0kR+kKRfhlGvywQavXG13K2WL2D/k4YGLmRlDPvJgCmOU/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVsfFvR7sVStt+4KK43wOXMP+s3J6uouLUGdgSqxYG6P8T6xK
	m+kK6mTg7Kpykb+uE7pfWulxAAu/aHr99vOfDYVel3Pqa5gPnh0aMiQNRS0KOK+fIaL7FIVwkCA
	fgRWxt9pzioJDo+xh5XPZ9AWb5791Qr9BBsSAZ2HF
X-Gm-Gg: ASbGncuIA9a4LDFaIyiRULhNMH6DlcSGxXMCfHjiSF5yi76n051VTZkmX1k9kAtKeQD
	GbUM3pX4JGvvvxvHolDBcT0KIJ4gaKGjQ/nI2r7Tc2M/iMQMlLEPwGZnnJP+2/+OTXRGsoNGSE0
	HJpue1fbK5yPpJ813rsNBBwdM3olZBTXkACDUDsRxbHKw+bDhc/1+395/KfknjM8U6rY+kM+Qy4
	PMWg3SYbfR7WJV8P2V3oZ4rpSUDuLaH
X-Google-Smtp-Source: AGHT+IEE3vW50mN+g7sjB3JgnHPpFDaaYz8tXLvVhOdGDaDQ1ipJAp2C5Ss5TYurb7YYRKBrUGBk9/H1VW7xYygqNI8=
X-Received: by 2002:a05:620a:710c:b0:80b:b8aa:5c44 with SMTP id
 af79cd13be357-8311334b681mr607648285a.39.1758170872886; Wed, 17 Sep 2025
 21:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com> <20250916082434.100722-9-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250916082434.100722-9-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 21:47:41 -0700
X-Gm-Features: AS18NWDnsTzobqovaqJgXSNsHC41dTN6DzbIFMvP6OalmtSpwFDjRSKr7Mn4RAo
Message-ID: <CANn89iK9Ro517nbmNTRfOr3q5-T7iuJUN1QXU2p_5CWKE1aprw@mail.gmail.com>
Subject: Re: [PATCH v19 net-next 08/10] tcp: accecn: AccECN option failure handling
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 1:25=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> AccECN option may fail in various way, handle these:
> - Attempt to negotiate the use of AccECN on the 1st retransmitted SYN
>         - From the 2nd retransmitted SYN, stop AccECN negotiation
> - Remove option from SYN/ACK rexmits to handle blackholes
> - If no option arrives in SYN/ACK, assume Option is not usable
>         - If an option arrives later, re-enabled
> - If option is zeroed, disable AccECN option processing
>
> This patch use existing padding bits in tcp_request_sock and
> holes in tcp_sock without increasing the size.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

