Return-Path: <netdev+bounces-165715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D1AA33379
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 00:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750CA3A7F39
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 23:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A84209F4F;
	Wed, 12 Feb 2025 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGWqlPWa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120DC2080F6
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403475; cv=none; b=Fn/QPdAYatTTU+gb4XJzw9VAjptELKuacub4R8R4v6F4np8iLo+zvxiYwypYR5yFw0b5Zm4TEuHyJJ/amT3EGnjUvjvxKmE8PhnE6DeMU3PZJ3fK7NdNKpvC4fBrZQZZ4XqAB9OUYh6o4xlGTOzrKkW7AI1T9c0T/J8xUMtJgyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403475; c=relaxed/simple;
	bh=dTQLOhR+CQoKJF532Wr0i5ZcN5Mu5bKXfeCZtpiByzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xmq/jP2GKatbfw2C827jVAbvQzD+10BydHFO0n4BdMMLPjk7QkYatkx/hmnCRiqC64Op9YL8gJK1UFIxsOf5Gje3yEd4QqwpblwJ/Kx/QceeN/RxqaAyowdppDWMNzirNoTs8ECJh9XZT8DduL2NW+PiLxHVguXbtUeHSO19l54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGWqlPWa; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce85545983so777895ab.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 15:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739403473; x=1740008273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTQLOhR+CQoKJF532Wr0i5ZcN5Mu5bKXfeCZtpiByzA=;
        b=mGWqlPWarrzqAvz4wy9z0dAs03toqQl2xUDFWbJoZXILC4ofapTAfTDyH7H+2FdHy4
         uNLvZTpRuMu8sJZnBaRFM1mOgVD/fZQt+WZEZs1JA6BrtHtvJTZY2dBcAnhp4P8PQulh
         OHYSlGuY9T3DMGHDlVAH2vIpuzeao/PyM4o7/E8fSnVUjqtdEb2Xe/WwOoLdfSOfWfTn
         ATReBY2HWua7rY+jn8PrrcU0ESUZMslSXjm4sv1yiJn0SUmazqBc+Xt3EFknTOiu4pe3
         Dpty2evx+O6btsKgaH9TMDUN/2//X/SfETt6KMHaw9dEdzzh/6V+9hQtoA091NQrNOxc
         ediQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739403473; x=1740008273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTQLOhR+CQoKJF532Wr0i5ZcN5Mu5bKXfeCZtpiByzA=;
        b=usINyxM2ksF+8cFMP7NditzssEzbB8CYH0o6B/GqTXSVjK80kAyH/MyvaNuxuLLIEo
         1oMvA/oMnP8QemvTdpUUVV+uNrr92die5PFH13HHi9KqJX5oAInBLiMuhaKqQVIshh5x
         lJbmoRuSNbxfMK4QL+xyR40jXb8EyOqvN1kEnmZHaK6+yU0mSVgP5qroo+hX60JI5TdC
         SgP7A9DEQT4AvrAPC2op6ZGBLQue8ZBvwW+GH2WQEjF9e2oc+8GEvh4cg+ZwtqWCxBmM
         WnM4fEQ0dMP4XL9nfkD/apU8wT71bh2zM4T2hIy2oYLc5/uICfcdhIXyUVrPGFF0pQB9
         PRvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpCy57bbjNRpXRIv2G2CtoEXTmp0YOwTYFJh/1OgktG4kcjoTMurzW3YIMz9RMtKxNUSTUqjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8j5APiuqZ9pAJysd9PR/TXM00bdtoqa9DRPgK8UVRu4ZejyS
	g5WnOm5UrIF4ytdTP1be8NrhdGe6PijoZDRJbo+MIC2a+f+w4WS69UeUDHC5WEvSwYdkRhoSPAg
	CJq+AUxmlQ3qI96CVnW7p0JM4ZXo=
X-Gm-Gg: ASbGncuLzB+rFDs6F1CLxtb3aX4kUESwtYvCbvG1COp1mEDx62Y66F4t7moTOuJtOFr
	1AmZ2LuOjiK1HHgY04weKO+NLLPOki1KUj/69rAaE3bTIv4O2WFqbgPKc9oXx6X5isZJnMAv3
X-Google-Smtp-Source: AGHT+IEpq+vsvOGfPXKDlGSxIXPudGiNKKHnFnLbYT+LNZsLL3EftaM8w2vAwpz4ZMdB5tPqxHkJUu4FW1vWYHHRnZI=
X-Received: by 2002:a05:6e02:8e5:b0:3d0:59e5:3c7b with SMTP id
 e9e14a558f8ab-3d18cd12b2emr5353815ab.8.1739403472962; Wed, 12 Feb 2025
 15:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210130953.26831-1-kerneljasonxing@gmail.com>
 <CAHS8izMznEB7TWkc4zxBhFF+8JVmstFoRfqfsRLOOMbcuUoRRA@mail.gmail.com>
 <20250211184619.7d69c99d@kernel.org> <CAL+tcoA3uqfu2=va_Giub7jxLzDLCnvYhB51Q2UQ2ECcE5R86w@mail.gmail.com>
 <20250211194326.63ac6be7@kernel.org> <CAL+tcoATHuHxpZ+4ofEkg7cba=OZxnHJSbqNHxMC5s+ZMQNR9A@mail.gmail.com>
 <20250212105307.400ea229@kernel.org>
In-Reply-To: <20250212105307.400ea229@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 07:37:16 +0800
X-Gm-Features: AWEUYZlc5MM9b3FQ8E1NIx3i-BSL5eFnm_jY7y7jBSz1OzIUnzREgClHXfASAlM
Message-ID: <CAL+tcoCiwc3TH+iB+6OpbTr6OPtO-gpmH3407hZ8G+CDrGUWmw@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: avoid infinite loop to schedule
 delayed worker
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 2:53=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 12 Feb 2025 12:38:28 +0800 Jason Xing wrote:
> > > Initializing a work isn't much cost, is it?
> >
> > Not that much, but it's pointless to start a kworker under this
> > circumstance, right? And it will flood the dmesg.
>
> There's a seriously buggy driver potentially corrupting memory,
> who cares if we start a kworker. Please don't complicate the
> code for extremely rare scenarios.

My points are:
1) stop the kworker because it's useless.
2) avoid flooding so many warnings and calltraces in the dmesg

The modified code is not complicated.

>
> > > Just to state the obvious the current patch will not catch the
> > > situation when there is traffic outstanding (inflight is positive)
> > > at the time of detach from the driver. But then the inflight goes
> > > negative before the work / time kicks in.
> >
> > Right, only mitigating the side effect. I will add this statement as
> > well while keeping the code itself as-is.
>
> What do you mean by that?! We're telling you your code is wrong.

Sorry, I misunderstood your suggestion. So the patch I replied
yesterday to Mina seems acceptable?

Thanks,
Jason

