Return-Path: <netdev+bounces-227377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED5CBAD9D1
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66D6188CD29
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C15230597A;
	Tue, 30 Sep 2025 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkX2FHjv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786342F5301
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245206; cv=none; b=Cf6rKVyOnYUrLI2IAbAugZW95yuc98oIw1LM+rmfaYw7Pjvl/mftUdp956mFwj0rvSOlasozHA5FX53gPPjKUNagFq9zsyblCWwFTW/CEEOL5HDwRPX768YrT637FfbTVs4oetzhdPMuXPqw3bxGd0g64cvqPwemDLgN11Otqn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245206; c=relaxed/simple;
	bh=BSewBfFWhJBl490BIH5OZ5knEj952tmRcHjCLHNd3ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNAhVPoOJVS/iQiq+TFX/L88ENFaOFgkDSq3ZKNeHMdZgODHsZpCsIIM+4nHdcAyfKUhQv4s3hfW4Xt2XUpa0w4KL/oaW9tQtyfDQdpVOP5g4h+lLRFGPM3gVeTSPhf8SPE8SeqRX3jaW9HpXiFhnKWzMhyl4jr9V0a4wGM5kHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkX2FHjv; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-36a6a397477so58845581fa.3
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759245203; x=1759850003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSewBfFWhJBl490BIH5OZ5knEj952tmRcHjCLHNd3ws=;
        b=DkX2FHjvnJZkH/LdoCtIYQFCZSWwI/2Va5/I0UK6YIIN7+XvhylrqT1x8k2EV92ueP
         1e/tdcz7vI4lS1MbU3jyD8OkPiHdSWe0JKPyB1DAHrNDcvow5YAmunMVudz3BbykNIWM
         FsZmXJSn3jeRTnC8VvBynrASUfzTAnrs1Ix6cyZWRIzyucT4w32YFJ7qSFMz++DLT2Kn
         KjxvEployqbI4g0t3cQH+MO7L8rFBfP0GlbzwQG3S75dQRu6/k19DfwZyYec+i2x2/OE
         MV3ENHNW4UF0EgsLmQi10prjWjYQq8FXscP0aZF4SG7Xu90IKbsUagZCcJYMromKStGu
         33ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759245203; x=1759850003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSewBfFWhJBl490BIH5OZ5knEj952tmRcHjCLHNd3ws=;
        b=B7xVJdwbjHf6JugTW6v5Y0D4EBG2TLrzQ2NdFwGCyWnozRMrYIn+ESCSXZJNWc0HwM
         qATo75lKQFUsmhZpsN+35VW44QM5rl5UAyDFT9Qk0qH7HO2Sqx74KFTkjo7bFpLLZE49
         +RIQPHSL3R+Eq9p9HBof3W7Hhoe+6jwLP0b9wDj828jRaTs7aKb4rhabVG7BmDdRfRVm
         GKQTciYy6vTiP4mYzhcsjlTavTkzjcRZGF6F7f50cwKDjKKK8G292gITOEOeRWdlvpUM
         fXGy4adHJ3w5ke3FrAB7YkDUDaKyDbVHzMw1Ye8DWvHnngY8P78gKN+GlfvXoin9ITiI
         6rSg==
X-Forwarded-Encrypted: i=1; AJvYcCUBBqHBjNqcyoXJwlU6o8ehWkDg+NnbRwFLYvO45PR2cErgqwek4iy9VjDV0652fZSIFgSkhFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2F2pUtc/J/v3PjsLTw1CaOTYv8JwcR2ivP3fYQhZ8vsLkiaz
	hJEaPZGeW/384KltmNReh1RyeshLwWNMlSJfDNgR+fUmHdbYUcCQct0YuqDaQs4Wobgy9165o5D
	BKDY3P6hhcCMTRFc1PcktKMJkF9io+9c=
X-Gm-Gg: ASbGncvkrhyO7/nxjK1Dwk4oExgf/XxqjXiyWVd0kMypeteKG1AryDC7HgUgF+jR5Tp
	+nemxcXXGr4u24riVttmRXeiG36xHWJXr6LM4H3i591NKrTOf7Ylaoyj60kAAHkW1w5tnk238ej
	Y8Htu+Yzys49yiBGlO/Ddpo8XmlwlSJ0g+/4OYoZ/KCvCk7F/53A7vyWkEFMkNQ8gbz2QbXfw/d
	/H89mibI89SOFJiSSxPDWtdsH27eQWnA5eZWNvzUZ/0WI5p1ce7oiwMjIWg430eSGWcvz27DUzu
	Oy2IinGgXzUoQiP4s+Njmw==
X-Google-Smtp-Source: AGHT+IF4toYIrIqD3kiLsHfmm4JRYPSghmYhxXGwVPbDmOVVXAkp72RxcbXIqWOsLeoh54cMOZe90BiMurhEoL3Goy4=
X-Received: by 2002:a05:651c:2542:10b0:372:90ab:8bfa with SMTP id
 38308e7fff4ca-37290ab904bmr26694711fa.37.1759245202296; Tue, 30 Sep 2025
 08:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925204251.232473-1-deepak.sharma.472935@gmail.com>
 <54234daf-ace1-4369-baea-eab94fcea74b@redhat.com> <CABbzaOUQC_nshtuZaNJk48JiuYOY0pPxK9i3fW=SsTsFM1Sk9w@mail.gmail.com>
 <377697dd-15bc-4a2d-be19-1d136adb351c@redhat.com>
In-Reply-To: <377697dd-15bc-4a2d-be19-1d136adb351c@redhat.com>
From: Cortex Auth <deepak.takumi.120@gmail.com>
Date: Tue, 30 Sep 2025 20:43:11 +0530
X-Gm-Features: AS18NWCPx3KYKK3cvUH6TSzAvXHruvjzP3zvXDvzd6ohqBVPIRDoOlk-IyqoDss
Message-ID: <CAC_ur0rRtuVS7GTxUuEU=yOfrsTRZH0dcGwgoQCy9wB_b6pE2A@mail.gmail.com>
Subject: Re: [PATCH net v2] atm: Fix the cleanup on alloc_mpc failure in atm_mpoa_mpoad_attach
To: Paolo Abeni <pabeni@redhat.com>
Cc: Deepak Sharma <deepak.sharma.472935@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, pwn9uin@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com, 
	skhan@linuxfoundation.org, 
	syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com, 
	syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 8:01=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/30/25 3:33 PM, Deepak Sharma wrote:
> > On Tue, Sep 30, 2025 at 2:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> AFAICS the mpc_timer can rearm itself, so this the above is not enough
> >> and you should use timer_shutdown_sync() instead.
> >
> > Hi,
> >
> > As I understand it, `timer_shutdown_sync` will prevent any further
> > re-arming of the timer. I think this is not what we want here; since ev=
en if
> > we somehow fail to allocate our first MPOA client object on our first
> > ioctl call,
> > and hence end up wanting to disarm the timer, maybe on next call we can
> > allocate it successfully, and we would want that caches are processed
> > (which are processed for every time out). So we still want it to be
> > possible that
> > we can re-arm it.
>
> Ah, I missed the goal here is just being able to rearm the timer (i.e.
> there is no related UaF).
>
> Given the above, I think you could instead simply replace add_timer()
> with mod_timer().
>
> /P
>

I think yeah we could do that.

I have just been going with what code seems to have wanted to do;
Arm the timer if `mpcs` was NULL (no MPOA client existed)
And if there's any error, delete it as (was done in case of error by
the `_notifier` call, where we have no MPOA client yet).

I just extended it to the `alloc_mpoa` failure too, because
in that case too `mpcs` remains NULL

`mod_timer` would still work, because the timer callback will not do much
if it finds the `mpcs` to be NULL

If it sounds good, I can go ahead with it

Thanks,

Deepak

