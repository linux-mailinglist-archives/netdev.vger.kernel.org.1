Return-Path: <netdev+bounces-212127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43023B1E1E7
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 08:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3895722379
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 06:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00912185BD;
	Fri,  8 Aug 2025 06:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhvXsAiT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C338367
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 06:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754632905; cv=none; b=L4IW1VEVt+/l0B48aHxJ+aL/DlIqKKy+2vSKBRVRCxFs4o/s0kMxE6toN2Sq2LqJHGTbVZmCCtCcVTjoGOHKRsCg7Z+4Jxt2ic1h/gfnan0U04Ng/8HDPc9hIbkXFDQUCiVDHJyMoUH0eMPAcJuaxAdTDEwN0Hq+kQ64D/oqan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754632905; c=relaxed/simple;
	bh=wJ2ShD0lLGDBURenwS/7QYIiH7Qe2dT/+RsxUmG5uog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FD3e1aKNQoizgsm61tV+MveoxdliybnHWHKGWIHer1aAaW0jZlw006kwNsL16aJkTNNEZq2iA6P00ozLe4CkNgdSjAkK2V9hdA8ZX1ZVe20N1oRSSXkPkFn6xqReofLHexCT9Ef+4icx9fAvPw/FAqR8taeHJ14BPm4YpArSSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhvXsAiT; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e809baeef7so209802085a.0
        for <netdev@vger.kernel.org>; Thu, 07 Aug 2025 23:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754632902; x=1755237702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJ2ShD0lLGDBURenwS/7QYIiH7Qe2dT/+RsxUmG5uog=;
        b=mhvXsAiTyyCltGekgP5vGsznpH72GLqDpPA2ScFAgVDcdl33KP+mRKP2V99JQkzBWr
         pDOpZP4dpZlJV2ldfHrAy7LeR5gd+RmuAuaSwJSbzFLVCPBulgPsw3LrcL0lpc2R1H3S
         fqF0DimLRRY8oGGLf2DrOUoKf6s57qKDZQQcXL66yHnjg+AY/4JDhs0KU5X6uhEjUM0g
         +B0hA5d8X54pd1D0iYfBeKeiaiUKPVLWSMmHE9UHFCrkJAFpGclGEB6b0+cm+lzrzlPN
         yPoj13HpUG1afgurzTJfQ/JQqsNgUM/ptrzu/53wJyCOIuLiD5SATikwJJpU2Qinp+VH
         dO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754632902; x=1755237702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJ2ShD0lLGDBURenwS/7QYIiH7Qe2dT/+RsxUmG5uog=;
        b=UBuY5bgOux6riEfN39TzzLTGhsJm7tROXHVW/2cBr7KkB5XybSUrx/IihvsvAafJZF
         0fV+L8xPJx7Q1mpfwmFOcAUjPxjiW4qLxf1+hyeVCtcLS7c9FL1AOC+M+M/2eSBjCfmm
         yhgmfMiqSZVzflqaMQJs3SoVWO6Q+MUDCC7SZWGxXqtbsZHlCMVpaCYtbvLZv2/36qpX
         J01ZcGiq8ThVFoCj4LzVWEagr8rAFuTn2rlZ5M5umJ4jPxwKhfIKxP3s2h5Te2zq6sMe
         o9gWdGPdo1ZXsVY2hwC3DBKwP+SEWcHexzbnt2p9gAtebMzr2y9hoXS5eVFIJn+o6nql
         wmfg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3OQW38c9dcQIyVSJpv4cdg/k6cq2HsYdZQrCviPqOWzlrTq4U9SnFR7QvqTIcq6kc5eAUJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyjH7WFdNJAnHwRPrw/rrPvgPR3BS6M6mj89UG5O4phiRTq4+
	nRIBghQ6OKB2NiE3sU2ALdNtUB0orRgtlZQr/CKwaSs4KrIUM0WPgXQShEM1wg4kRL/Z1dxuiDk
	RG5xeIzI3LmgnZLZrly4P8Kft8mdfo0WAPiot/DFL
X-Gm-Gg: ASbGnctEqpz3rcThBGhj0nn1YxtICpydbu5qxpAzRHsUWTnTf5/X0MUx8TMh91h6Oey
	97zw2dH781UAkucCypay4wMSj8Ev+NntlDfESI8UtmpbGnGofb1qd8tyOUmBvNCDVoxt7F6kL0b
	3lsfhYOgTdHgb7wk0Jw548BAd0ds/z/HT/pyLxzhH1jOK0L7Cu0y3FUyk7fiLGIxzi3peOiWNpe
	k+TRDg8IzlnpLQ=
X-Google-Smtp-Source: AGHT+IEDMiWQQp2ySXxb5hGnl3PYQ6rBZyTUMmWdkPYFxZ7Pz87uL93oO/sOKthE6Pw8L97g+0HrGG9ouzcdFiM1VfY=
X-Received: by 2002:a05:622a:548:b0:4b0:86b4:2513 with SMTP id
 d75a77b69052e-4b0aec8e37amr25739601cf.26.1754632901644; Thu, 07 Aug 2025
 23:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808050643.107481-1-jackzxcui1989@163.com>
In-Reply-To: <20250808050643.107481-1-jackzxcui1989@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Aug 2025 23:01:29 -0700
X-Gm-Features: Ac12FXzPxlznul3dZErM2k6olLDrdWJ9vANmmhMhx7XFW35iEJNW8Zi8ExY3IM0
Message-ID: <CANn89iLJHBDqEzumoURtc4ehdZKkchA8hW4ufDZKj=nEzJ=sjg@mail.gmail.com>
Subject: Re: [PATCH] net: af_packet: add af_packet hrtimer mode
To: Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, ferenc@fejes.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 10:07=E2=80=AFPM Xin Zhao <jackzxcui1989@163.com> wr=
ote:
>
> On Wed, 2025-08-06 at 16:51 +0800, Ferenc wrote:
>
> > I doubt we need another CONFIG option ?
> >
> > Also this seems to be beneficial for HZ=3D100 or HZ=3D250 configuration=
,
> > maybe worth mentioning in the changelog.
> >
> > But more importantly, I think you should explain what difference this
> > really makes,
> > in which circumstances this timer needs to fire...
> >
> > If real-time is a concern, maybe using a timer to perform GC-style oper=
ation
> > is a no go anyway...
>
> Dear Eric,
>
> I've thought about it, and I really didn't foresee any obvious drawbacks
> after switching to hrtimer, so in PATCH v1, I removed that config and dir=
ectly
> changed it to hrtimer.
> As you mentioned, this issue is indeed more pronounced on systems with HZ=
=3D250
> or HZ=3D100. Our testing environment was also based on a system with HZ=
=3D250,
> which is still quite common in embedded systems.
>
> Regarding the benefits of using hrtimer, I already provided the test data=
 and
> testing environment in my previous reply to Ferenc, and the improvements =
are
> quite significant.
>
> As for when the retire timer expires, I've reviewed this logic. From my
> perspective, the existing mechanism in AF_PACKET is complete. In the
> prb_retire_rx_blk_timer_expired function, there is a check to see if ther=
e are
> any packets in the current block. If there are packets, the status will b=
e
> reported to user space. By switching to hrtimer, I aimed to ensure that t=
he
> timeout handling in the prb_retire_rx_blk_timer_expired function can be
> executed in a more timely manner.
>

I have some doubts why AF_PACKET timer would be involved in the performance
of an application.

Are you sure about your requirements ?

I do not know what application you are running, but I wonder if using
TX timestamps,
and EDT model to deliver your packets in a more accurate way would be bette=
r.

Some qdiscs already use hrtimer and get sub 50 usec latency out of the box,
or whatever time a cpu sleeping in deep state takes to wake up.


> Thanks
> Xin Zhao
>

