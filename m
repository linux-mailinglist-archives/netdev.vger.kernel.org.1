Return-Path: <netdev+bounces-122920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E569631CE
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75C8285665
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EC11ABEAA;
	Wed, 28 Aug 2024 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+jOcwrw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD921A4F33
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877182; cv=none; b=SL/pSWyF58TUWPAvY+tFdekoS5fbRBK8HJGXm9Y5YwmUvn1xGwyZTruYk/4Qj5UosNCq2CBovE97oS9QtT2XBzcFW8aYc8NoD5ULwDWAfvuSv+f+M/JiFKyfMJp2DIgGdTlR3CF55B6RTCoiJ2BZeYL1KM4XK3N8SQqlUfcLi5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877182; c=relaxed/simple;
	bh=fjtON7CaTVsBHlEvwyfntz+Xq8VlltTKoGm7JGhclEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHTLc62U/u4DFWTLH05fhnPYtPgMdkk1SnquXItvP10KruOcGJuXMBq+eXyxaD4BEfLYuwEI7qdvqP2+mTlSzIkFi/68ujaTF1FDDDf3ZsrAdjjWM2Rphp38T5Tx2P2/0152ySfpFfseN7F7YXttZL6pANehGea8hcFx9AE/ibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+jOcwrw; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4567fe32141so64301cf.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 13:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724877178; x=1725481978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHJLf4Vokck/HtI2mOdPAPAgEFikfsBko2UD6oCkgB4=;
        b=K+jOcwrwlzPbkadNoKf5S+QcYqzZkEC+agpt9CtTe786BHmc5bvXDO/Yg6FF68ms1G
         gFDiPI+Ey8dQxVhFDqT+FuKSiT+WdCvJRrELKcuSI3F6fp0UuWahlYeANmXOnoSdINYo
         JtW/Jjkmpx1I/9C9r5zSryQrwULCCmGB8mlNd47NULASM1CJ3+1OhNa2SrQpvhyGufcd
         QwEwow80x+Mwlrw99GG1O+Fm1NPKJ3Ge7IXbMe8fd4T+aamJO2mGQPjxgq8g1i5CwbS3
         UMctXk2Ut2BAGELhobCH48843PNoC87lwwHoS2JoyJAyRxalWFFq/NVYmTBsNGXHiYdB
         yMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724877178; x=1725481978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHJLf4Vokck/HtI2mOdPAPAgEFikfsBko2UD6oCkgB4=;
        b=OFtao75DUxo90j7oFcUz43BlUdcNQS86zlsjYbiZHGoJkbWu/ZU2NwUNv+3VMdo2dO
         vMkA2R4Pdfa+7ijHR0L/zpZHnBdCfVg+LyT2QzmKaBde5wqpSFr6OPOpy8q2k3dPHZUh
         E0QF8OBWviGGmYlWppT1LIYwyIeQGL3Uh9r/GB8OlFjyoSwFXURpwQu3sTfV5sTqnYEh
         ikdDg8b2ispdyA3WXyacTAFOkMGye25ibULKD+Cmner2MPkehwrW6uqyjK+oosRUs3yk
         rnOPyXr/DoQlXa4ljNbUu7Rl6LfRwulMYPXr2CbiWxEs3CQ7m7Vs64DyrAKS/kwd7PE0
         xVsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7dciS88C7Gl/c1DcKI7BhU9VdypjL3uNHA0YxAw/MGR5BfJUvv+v4mvBGufNN8yvISKUX/CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZuvtDvUMbVNsdOez44Zea9OMLCi1mghR2GsRjJ/r6ADpsr2MW
	0zLNzBGZEupYATuM7H2B9mFQ/ryB2H5VpoPYwkGnz8l3bPqpiahlnvPYtyCtuYy0VyfVBrcD8Oe
	q5PgjDGIU8mMEmSUAI/SkJNuRV55VBABSjHhCGFoNWbtcuVel66o4
X-Google-Smtp-Source: AGHT+IEpedPLMr5w+o90A9kIJw3c9RpSOyYlnsGSmY4cEWmZ9rWpx6G922ciL6XjB9ipiGcR5sMrjmEvH0HHBlmjFGU=
X-Received: by 2002:a05:622a:1895:b0:454:b3a0:e706 with SMTP id
 d75a77b69052e-4567fc6cd3fmr830421cf.18.1724877177997; Wed, 28 Aug 2024
 13:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817163400.2616134-1-mrzhang97@gmail.com> <20240817163400.2616134-2-mrzhang97@gmail.com>
 <CANn89iKwN8vCH4Dx0mYvLJexWEmz5TWkfvCFnxmqKGgTTzeraQ@mail.gmail.com>
 <573e24dc-81c7-471f-bdbf-2c6eb2dd488d@gmail.com> <CANn89i+yoe=GJXUO57V84WM3FHqQBOKsvEN3+9cdp_UKKbT4Mw@mail.gmail.com>
 <cf64e6ab-7a2b-4436-8fe2-1f381ead2862@gmail.com> <CANn89iL1g3VQHDfru2yZrHD8EDgKCKGL7-AjYNw+oCdeBQLfow@mail.gmail.com>
In-Reply-To: <CANn89iL1g3VQHDfru2yZrHD8EDgKCKGL7-AjYNw+oCdeBQLfow@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 28 Aug 2024 16:32:37 -0400
Message-ID: <CADVnQyn2pC5Vjym490ZjjUqak0wRiV5OBhtFU8hqrM6AQQht+g@mail.gmail.com>
Subject: Re: [PATCH net v4 1/3] tcp_cubic: fix to run bictcp_update() at least
 once per RTT
To: Eric Dumazet <edumazet@google.com>
Cc: Mingrui Zhang <mrzhang97@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	Lisong Xu <xu@unl.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:26=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
...
> I prefer you rebase your patch after mine is merged.
>
> There is a common misconception with jiffies.
> It can change in less than 20 nsec.
> Assuming that delta(jiffies) =3D=3D 1 means that 1ms has elapsed is plain=
 wrong.
> In the old days, linux TCP only could rely on jiffies and we had to
> accept its limits.
> We now can switch to high resolution clocks, without extra costs,
> because we already cache in tcp->tcp_mstamp
> the usec timestamp for the current time.
>
> Some distros are using CONFIG_HZ_250=3Dy or CONFIG_HZ_100=3Dy, this means
> current logic in cubic is more fuzzy for them.
>
> Without ca->last_time conversion to jiffies, your patch would still be
> limited to jiffies resolution:
> usecs_to_jiffies(ca->delay_min) would round up to much bigger values
> for DC communications.

Even given Eric's excellent point that is raised above, that an
increase of jiffies by one can happen even though only O(us) or less
may have elapsed, AFAICT the patch should be fine in practice.

The patch says:

+       /* Update 32 times per second if RTT > 1/32 second,
+        * or every RTT if RTT < 1/32 second even when last_cwnd =3D=3D cwn=
d
+        */
        if (ca->last_cwnd =3D=3D cwnd &&
-           (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
+           (s32)(tcp_jiffies32 - ca->last_time) <=3D
+           min_t(s32, HZ / 32, usecs_to_jiffies(ca->delay_min)))
                return;

So, basically, we only run fall through and try to run the core of
bictcp_update() if cwnd has increased since ca-> last_cwnd, or
tcp_jiffies32 has increased by more than
min_t(s32, HZ / 32, usecs_to_jiffies(ca->delay_min)) since ca->last_time.

AFAICT  this works out OK because the logic is looking for "more than"
and usecs_to_jiffies() rounds up. That means that in the
interesting/tricky/common case where ca->delay_min is less than a
jiffy, usecs_to_jiffies(ca->delay_min) will return 1 jiffy. That means
that in this case we will only fall through and try to run the core of
bictcp_update() if cwnd has increased since ca-> last_cwnd, or
tcp_jiffies32 has increased by more than 1 jiffy (i.e., 2 or more
jiffies).

AFAICT the fact that this check is triggering only if tcp_jiffies32
has increased by 2 or more means that  at least one full jiffy has
elapsed between when we set ca->last_time and the time when this check
triggers running the core of bictcp_update().

So AFAICT this logic is not tricked by the fact that a single
increment of tcp_jiffies32 can happen over O(us) or less.

At first glance it may sound like if the RTT is much less than a
jiffy, many RTTs could elapse before we run the core of
bictcp_update(). However,  AFAIK if the RTT is much less than a jiffy
then CUBIC is very likely in Reno mode, and so is very likely to
increase cwnd by roughly 1 packet per round trip (the behavior of
Reno), so the (ca->last_cwnd =3D=3D cwnd) condition should fail roughly
once per round trip and allow recomputation of the ca->cnt slope.

So AFAICT this patch should be OK in practice.

Given those considerations, Eric, do you think it would be OK to
accept the patch as-is?

Thanks!

neal

