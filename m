Return-Path: <netdev+bounces-171286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A8DA4C5D6
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2834A189264E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F2821504A;
	Mon,  3 Mar 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWScENMa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB141CAA90
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017344; cv=none; b=PhCCIWavcQ1reeqO/jU/N1q1bDrlwkSonaTSvumZ+SKhiarZ/TUUEfwU5HEKSAlT+a++DbLh1XyQEobqY1PFT27/vJKlCbLOKbsHLYFcVclu7q1yvcp9UrqTBV9oNsoTNGhvot5Onz3LHnFPIdq1jpq06CpEggK4Segsd2hBWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017344; c=relaxed/simple;
	bh=mKXKHJYEMH744ZGxhBiluNHMKbuNGYCWviBPcyRym/k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oC9LxA2MZc+3aNRzHitsGs28Ge7Z7z7xsAxBYFKnyYB5pfg80k9PM8Mhoj/s2nFuMhuErV9Xro4o5YsnTk/PgOkpXDHaBZiUnhgx9zUogkugR8ZDPzpQAZtnqumRianH+AJ/X0TteLlQg8P58qRAqsb7Z7sV1Nzp47HoYSg7nj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWScENMa; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd420f82e2so65360816d6.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 07:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741017341; x=1741622141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKXKHJYEMH744ZGxhBiluNHMKbuNGYCWviBPcyRym/k=;
        b=BWScENMaSBYbvHGlYb349PTfWHYhPoc2rA5Dsf1limvEduO7MszGTfbJ4KJL7EedY2
         +Az237ThWQynZY5wkxDTCzmYtbb3Ae9tKTM8lig7M1FqrEFMEb7Elk040cFvNPBg142u
         IwjEwlLPOhKyAwnPXzamKX3s9gP0kbjfBrKnK9TLujzWMqZs+/5jJx87So5c3LY8B1zp
         XBt/adSOmnlDjfzYXavETz3gRrz+ylW0Ac2rNU4hJXKBxzi1h3sYw/ZwDj6eXIE0aUiq
         1eFGX4fKEogW97VDdV0CcCbMFaxQT8S+tGk4tYyJQGzHEVpmWYn8N2EZ5YwjHgdI7IIk
         pqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017341; x=1741622141;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mKXKHJYEMH744ZGxhBiluNHMKbuNGYCWviBPcyRym/k=;
        b=htzsxsReksZcSfYCPSccYGkacj9gi2Ty4o76/Kf4OtcIyYop8zMQXIUeNQsIxwMSD8
         DC+GEkrn7iny0SIYR5F2vp1/zX4VSHX0yxrFNtDYP27hVjs/WuWc7plE3R3tDxyh0gBR
         eS7h0nGtJ1qu2ynAhqufO0SC3nIKU2Fnu/5QGqQlNfTyPbAnZGidMkh1+mrwoMQAmV7l
         cDWEq9gjfTd7sSPi4rZ0S5qsIaVwyWLyVdggFbBPDMeLB35LNETZg6mwEcXHinYS+Dwe
         JLzrbk7C6Jabs9ATYbBFMimj6vi71CzldoGr12D+QGN7kbFvm5gJzfw7GLlVosXIU+Cp
         KnOw==
X-Forwarded-Encrypted: i=1; AJvYcCWp+e0dOTNUpiNQWw/7QkISlFEhmgkIhPO6KU8Gzhx8WAZhozer5C2ybML0sE7xtytQr1SLqbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4iPwXNyyiYYIiuZunDRkLCeIj8h6subE4amdxEpilCRdHsddJ
	hJsTF2TZ9QMgQQYGnCgIjmqkY924tgHZifpVRnNcoFieGd+0Bd5W
X-Gm-Gg: ASbGnctUTRl2dUF+Ix4BcXJT25fDYGe2XMy3AyU9egXmvM4KLI8carU9hMQ9jKf4S/0
	SZsuiHAblKSZHIiDIZHWX3fjVzjtGBFzO9UNIa0k4j5pGLiZATTPAnnmmFOijZ2s9W6AgihsAyb
	ZKxsWXklTW5hdVALcKJA1LunC0MPKX8RIlfPXtiU6WgjEwBBcJShZgqard1RSRL/ZvIFk79V12E
	avl4+w4UAwCfw3wXHAAWhjuKpVHtGhH8hIP2l1BqgACcrYluLdMn6XvzvFW10G2C4q303r9BMqE
	SBvCABDlFUli1UGD3duTGuDGSU7whaAwBES/etfVMxfkvYw9L0f3qXXNYPU4cV0f21Qs+M3C6TX
	kI4B1UMqm66WQ8a//q9MaXw==
X-Google-Smtp-Source: AGHT+IGzeWSwvJTCdoC28dVL1qImQtpztnvRolgvrLPEx5Wyxmr844ID/v+qgkP8xxdTs1GuZY/3tA==
X-Received: by 2002:a05:6214:20aa:b0:6e6:5865:fdfb with SMTP id 6a1803df08f44-6e8a0d779b6mr192821836d6.44.1741017341260;
        Mon, 03 Mar 2025 07:55:41 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c1c5b10asm96993785a.100.2025.03.03.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:55:40 -0800 (PST)
Date: Mon, 03 Mar 2025 10:55:40 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ncardwell@google.com, 
 kuniyu@amazon.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67c5d0fc3c3d_1c3b1029469@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCTddpJxx6uCo9b-7Qy=CpVW1YU=pO4S0pKniHsS9fSzg@mail.gmail.com>
References: <20250228164904.47511-1-kerneljasonxing@gmail.com>
 <67c5111ae5754_170775294fe@willemb.c.googlers.com.notmuch>
 <CAL+tcoDg1mQ+7DtYNgYomum9o=gzwtrjedYf7VmHud54VfSynQ@mail.gmail.com>
 <67c5b3775ea69_1b832729461@willemb.c.googlers.com.notmuch>
 <CAL+tcoCTddpJxx6uCo9b-7Qy=CpVW1YU=pO4S0pKniHsS9fSzg@mail.gmail.com>
Subject: Re: [PATCH net-next] net-timestamp: support TCP GSO case for a few
 missing flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Mon, Mar 3, 2025 at 9:49=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Mon, Mar 3, 2025 at 10:17=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > When I read through the TSO codes, I found out that we probably=

> > > > > miss initializing the tx_flags of last seg when TSO is turned
> > > > > off,
> > > >
> > > > When falling back onto TCP GSO. Good catch.
> > > >
> > > > This is a fix, so should target net?
> > >
> > > After seeing your comment below, I'm not sure if the next version
> > > targets the net branch because SKBTX_BPF flag is not in the net bra=
nch.
> >
> > HWTSTAMP is sufficient reason
> =

> Got it.
> =

> >
> > > If target net-net tree, I would add the following:
> > > Fixes: 6b98ec7e882af ("bpf: Add BPF_SOCK_OPS_TSTAMP_SCHED_CB callba=
ck")
> > > Fixes: 4ed2d765dfacc ("net-timestamp: TCP timestamping")
> >
> > Please only add one Fixes tag. In this case 4ed2d765dfacc
> =

> Okay, I will do it as you said.
> =

> Sorry to ask one more thing: should I mention SKBTX_BPF in the commit
> message like "...SKBTX_BPF for now is only net-next material, but it
> can be fixed by this patch as well"? I'm not sure if it's allowed to
> say like that since we target the net branch.

Absolutely fine. That is relevant information.


