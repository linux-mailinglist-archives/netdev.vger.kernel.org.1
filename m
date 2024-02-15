Return-Path: <netdev+bounces-71996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5371856112
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1414D1C21255
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C352F12BE8A;
	Thu, 15 Feb 2024 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3a9XxhZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B0812AAD6
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995456; cv=none; b=mO7vU0gfdhUFMr5Nv2kd11yMMvD0i8jgH/6IkcSNCCySDCOZOCIrwn2f0RbZDiY3sX2mjM7oA/H6biwlkDJnXoQlk08UpxocJg3pAA1aaf8hsSeQoQsbCOeYkstcvVq5apxg0CVDsS3+v67Q8mMDqNMUdoFVPowk/BryE1Ez4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995456; c=relaxed/simple;
	bh=ZDiELU1jsPTiD3JKAh+/XIyTSS23xbyEr99u1lE9Ejo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7eZodEFukm7gy0x8OQhqbOVBPYpXag/q+uFU0rwX/X59qKx4q9FkYLPuKVCdDP0/YUSltf20kF4vGB8BID73EVrFzowdQpm2d0Xxqnmdt+XvQ15pnc2dx9p620M5i7Od658ahD608NIQW0htUx+KlY1VwreuZQwywVIyjaKu4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3a9XxhZ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5116b540163so1171781e87.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707995453; x=1708600253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4Gti3bIwc1p+CTHoXEGQMBiCl6NHy2ixnQbXd0gIF4=;
        b=U3a9XxhZQEEVuTgstrr5jom5O2RRmtTe3dwmTBViuJ1gs5bc2QUUXMbWy35Pzg5XT9
         d+75O2xLQ77BVKStyoqwi+xb/zlEwXONfzXvGi3+ieXGCaF1riuG4nxGAbJXPtu/Vgny
         AcrkC4LuzdkS6ktOq/wwjr+6ow7RzsdydIOZZAEkUXLlEK6wFGCQCAd/S7UxWGCe5ydE
         ISsDS4xeA7ohWDDn4R6lqlxtLN53DPvyZHIlv5SndypR5DiVZ3dj+qhe5RyauEfjpFgF
         wZiivyBu2Yocr/RhJXK/pTvuseBmJUt6t1cmty3sYQp9IA5V3nHOz9+B+IVwy7L8m47q
         5jsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707995453; x=1708600253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4Gti3bIwc1p+CTHoXEGQMBiCl6NHy2ixnQbXd0gIF4=;
        b=xK3VgagqY6Mr3IKFeMD58LSUAde/zZf1d0PtAivJg1XtLIACjdqHgk7XRUgpbVnh7n
         Z1bfhptNcASi/MTjRSFL8IsHsSVKzuOZ0ltiDmjX3Df8EpfSdSnCPuExjHQw0dTMEpOT
         FM8NB6LSce7fBsbFkVuVvNtXqC+8l2ur1YrVuaHXFzkTXWRwGQ3H2JVeZSc6G/ar1a6O
         wr5NT7SPhwZPl4IduW3rZD68vDf91E6Ytxo9ovKByWDlH8kHlGFfVNep5wVSUfRTB71l
         LatjRVzbuWg1hsb1fYvreUnyDx3objmLUavgdcKa97fPAfBuvS4KcNTQGbFOwVKXM5QN
         AHOw==
X-Forwarded-Encrypted: i=1; AJvYcCVKt+AKoDuf/JT7wGbkQe3A3t8PJbL4T2TmYYcLxGiBOjnqm03+fePEAG32ik2bY6jTI+uwnXf+dZ+dp0O0Q1FkfOav+SrT
X-Gm-Message-State: AOJu0Yw4VD/4jVD7iPr4N1fLl9SSeUFOrE0bSY4o2bSqmzuRngZG0dHE
	lHR7MNfZec8Z792QJnrhRP+sUuMbDF6ZYb1bTqilEBQjQ19OjOir83vYnG1x2QfYmLQ+2jcLvbD
	YeVGL7JkjSFw8jrFyKL0grHrSv5gvzRP48xU=
X-Google-Smtp-Source: AGHT+IEa5GnNmsElTjs5cpmGdpszWmtj+9Kv9d5FBTQEMptq2kxympkXXYtRWmdMs0rB0Q8tDlb+3y8s5I6b9edfgT8=
X-Received: by 2002:ac2:5dfb:0:b0:511:8dae:6e59 with SMTP id
 z27-20020ac25dfb000000b005118dae6e59mr1200895lfq.38.1707995452629; Thu, 15
 Feb 2024 03:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215012027.11467-1-kerneljasonxing@gmail.com> <c987d2c79e4a4655166eb8eafef473384edb37fb.camel@redhat.com>
In-Reply-To: <c987d2c79e4a4655166eb8eafef473384edb37fb.camel@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 15 Feb 2024 19:10:15 +0800
Message-ID: <CAL+tcoCvZE4F=Br5UgXzp7cQORNMAB8gVMnZm5QT-xXdqD9=AA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/11] introduce drop reasons for tcp receive path
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:12=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On Thu, 2024-02-15 at 09:20 +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When I was debugging the reason about why the skb should be dropped in
> > syn cookie mode, I found out that this NOT_SPECIFIED reason is too
> > general. Thus I decided to refine it.
> >
> > v5:
> > Link: https://lore.kernel.org/netdev/20240213134205.8705-1-kerneljasonx=
ing@gmail.com/
> > Link: https://lore.kernel.org/netdev/20240213140508.10878-1-kerneljason=
xing@gmail.com/
> > 1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new
> >    one (Eric, David)
> > 2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket
> >    allocation (Eric)
> > 3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
> > 4. avoid duplication of these opt_skb tests/actions (Eric)
> > 5. Use new name (TCP_ABORT_ON_DATA) for readability (David)
> > 6. Reuse IP_OUTNOROUTES instead of INVALID_DST (Eric)
>
> It looks like this is causing a lot of self-test failures:
>
> https://netdev.bots.linux.dev/contest.html?pw-n=3D0&branch=3Dnet-next-202=
4-02-15--06-00&pass=3D0&skip=3D0
>
> due to tcp connect timeout, e.g.:
>
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/466281/9-tcp-fasto=
pen-backup-key-sh/stdout
>
> please have look.

Thanks for your report. I double checked the series and found out my
new version of patch [4/11] is wrong. I will fix that.

I will continue to check the logic of the rest.

Thanks,
Jason

>
> Thanks!
>
> Paolo
>

