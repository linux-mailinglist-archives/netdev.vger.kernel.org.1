Return-Path: <netdev+bounces-71979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C68855D91
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 10:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93FD1F2E546
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 09:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2571713AF0;
	Thu, 15 Feb 2024 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VewnZo9W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E0617586
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988527; cv=none; b=SqUbaCst5EZfZ1ThAgW+WVhuCFg4fP+eGZaQlItl6wakwbE2gBpO68S2UmAVmV1o2mrkJOeRslmcBrIN/GgTQKSxbD+d2ZSTyAKs1Naxc0v0alrYiUDMqtKPBC6/ibXsQiWNnqPngDmQM3TvW48eURNZnv2UR15fmRINMQJinoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988527; c=relaxed/simple;
	bh=sBn199/CHvvcjuUPEXeizIbfUA5cjaqgjgVHVTnUWTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKoHD4RjyvtKfGNGFoWdPT2CfKkRh8wGAA+xud9Z1HG2XSmmTVAq7HdlFLcjGBFLN1A3FQlDCloe5z5/p8dKVRY+HdXz1sJaTzIWLzC47hyZarXTH8rlTfWXr6UnZpHBWg5/m64JXAXEtVaahzjc+hrblfFaJyJT0h8I71w3K6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VewnZo9W; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563aa20313dso4924a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707988523; x=1708593323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUn7iktxnSCs9/aTk5cnSbTp1Sitzo+giYpoSXQVzdE=;
        b=VewnZo9W2VUJ/m0sK8iFyypxP0bs3LLlLXpE7+lT1lDAxNIqkprIJcPodV//3BJbEe
         Nof/h0SkO38v3hm73rqVseoOp13GzwIXltDAY2P1aYxp/aYtEWjKC/PdIA5XKGG+Hhp3
         j1Xly1Qk/s9vbUwHVRhPG01n0K1uacgOS7SzXGcfez84Ub3DNFLOI4C/2urLNpMauzZr
         8ZsDDXc4RedMuvK93mJWnEdgtm1BvNRiM9qVkagt1VCyqSFLXZHiRBehm4LvL7Z/AlCz
         /k+nFdKzFnMx6ge9z+gqwkhOC8SbGn6jZTk35iKROxXB1bnoBuJfWmujb8f/8pWSdf2e
         Wa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707988523; x=1708593323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUn7iktxnSCs9/aTk5cnSbTp1Sitzo+giYpoSXQVzdE=;
        b=KZhlcZJGhTz3Rb8nrQykIZlKt1wBcZ5xcZ1bFpP9X+2IXMRwXA+fbi113w94CvWGLd
         xhwXXzOdFR+JI1HxYozvsg53HRfEZpqEHmLXkhh/8jws2Snp6f2+IYd9+oLKN1FuxLDC
         QbdOisQszwHlR9lrzM8HMj6LLZs2G7kOHYB9JNOLL5xP3DvLBavhgYwzOryuD+gChgoL
         SskSbKEtmFC4RKEnrowvRcjzA2c10s7cDPu09RSMAvyxb0L1TmtS0RZ5JO0oFt7nlDbT
         1MeP1slf3w9IjtWUU2h+oPsThWBESBaaW7VNtXfNKUHV26TC9t0NfRk6bUx8dNoRn1WM
         vajQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqQmhxbtOIh3aVzRytQdzQCg0Rt8nLblwrZZ6y6Fvl9MtZp3kn+wA4yBP7ACCN5bHHDktZ9PXl3xTYCOo471eg9o7ImZjb
X-Gm-Message-State: AOJu0YxVb7qz7s8+3SnRdyCo746pB9zj99Si0Doz4B530/C8mVY7BZ7B
	4Eyd1hKdfwfrtopyPg7gL1oXCOs64SEgwM9mtgh33s9lIDKmom3v76cgpZ5Gr008F0by5OAnnar
	aQ1teddUSGpFXAOMCvOVjjsVG7pbIqiR7XlMl
X-Google-Smtp-Source: AGHT+IGF7WCK5ODqdqCdP1dePcGD18OQNMYgqjn0nvc78bZt5z2jfPx5i1+1lZXluHxeZv3S0xZVf/VhQOgXlBl3e1g=
X-Received: by 2002:a50:a417:0:b0:560:f37e:2d5d with SMTP id
 u23-20020a50a417000000b00560f37e2d5dmr365698edb.5.1707988523206; Thu, 15 Feb
 2024 01:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209221233.3150253-1-jmaloy@redhat.com> <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
 <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
 <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>
 <Zcv8mjlWE7F9Of93@zatzit> <Zc2DPq8Sh8f_XoAH@zatzit>
In-Reply-To: <Zc2DPq8Sh8f_XoAH@zatzit>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Feb 2024 10:15:08 +0100
Message-ID: <CANn89iLZAEYTpZNhGnDUfVyGXQtciZwY_aJ3xTVh=A+R5fXnqQ@mail.gmail.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, passt-dev@passt.top, 
	sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com, jmaloy@redhat.com, 
	netdev@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 4:21=E2=80=AFAM David Gibson
<david@gibson.dropbear.id.au> wrote:

> Btw, Eric,
>
> If you're concerned about the extra access added to the "regular" TCP
> path, would you be happier with the original approach Jon proposed:
> that allowed a user to essentially supply an offset to an individial
> MSG_PEEK recvmsg() by inserting a dummy entry as msg_iov[0] with a
> NULL pointer and length to skip.
>
> It did the job for us, although I admit it's a little ugly, which I
> presume is why Paolo suggested we investigate SO_PEEK_OFF instead.  I
> think the SO_PEEK_OFF approach is more elegant, but maybe the
> performance impact outweighs that.
>

Sorry, this was too ugly.

SO_PEEK_OFF is way better/standard, we have to polish the
implementation so that it is zero-cost for 99.9999 % of the users not
using MSG_PEEK..

