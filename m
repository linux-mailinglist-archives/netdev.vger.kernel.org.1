Return-Path: <netdev+bounces-94776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD1F8C09E5
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2086B283B83
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73AC13BC13;
	Thu,  9 May 2024 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TcRoAy5a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA413A87A
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 02:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715222922; cv=none; b=aKgiFcB+x48J2miuSutRyWrhnR3ZvtCes9j4/I/4ZLXiQ0W8CPwsUSyihP3rR67+crrZwZZjDksLVN1krLVLbGKkf+klQ0Xa3HeRJ5eyAZU2E/gwCT4vzXWwjIChx/y2xMB4hO6tOVlFjOny60fSGUZ16d2bffGRfWH70xo4xmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715222922; c=relaxed/simple;
	bh=wQkXTf5xKOi/jkQqHQ2AkEYJzxMOlLiqa4piZ7/Gmgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNdo6kMlmiuKOtinD+t2jBo/qzt0hps3fSLgiD2dd7QRY+7dV5VB+xN+jHicO2FC+r/BpPOOFzfJD43dAzT1wBveRYOTDGt3KA7nUSN/cbSkzziX2Pe9uASNPaQp14ySsodMW55Ey9qNi3AALWgZKJnYaZ6Zw4ELW+z+fN64YrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TcRoAy5a; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7f7809ae952so111019241.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 19:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715222920; x=1715827720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8t5MjaAMAXet3sIw/oEjf3p3suprAqTqym8YuM7ds4g=;
        b=TcRoAy5aqnI587XnOMn5ebUnicnkw7crwSX07/GOUk0GtH5SvTYF9P967pqaePynoE
         AFPK66gy439+gLl1qKNB/HMhq4j0mzFU6EENi6crc8yPziKd8z+t9ERJYVJyF6ahcOJP
         7YegStGQo8+eI17SlqpPHSktNXIrc/bnzsdBBObgbKMAYOtFCA862/3WN4kOkS3ZML+M
         LG52WDZ/Egv1dk7U+yqtYTzbirWSapSaY21wSk8j4EndGwoc7bhTvWoSHSVSuF/MjMkt
         VcyyEomnOl1exDFGrI5z3n9l/TxsvzZfh1/1YHMKlKMcCGksLJ0GmivSzG8wN2qRmL9U
         vK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715222920; x=1715827720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8t5MjaAMAXet3sIw/oEjf3p3suprAqTqym8YuM7ds4g=;
        b=wKCh+aIKMrbynq+2S18G4jQC+QL0cHQZ1Ntw58WH75FAcnNSQ9563MSAX1RBLK7jSo
         tsLlCgWVbbPxx+KEoIu9i9yiPt0hLOhzEFdRfoB8hCBLM0Q5agdOTmFaONZVTojAAZHO
         KP2DPSMm6/dwbFHc+FRBIuZn3f9qek/TIKo9Gp6WzU2/beCm76ENZsqDWTP8q7ARNfCq
         qKw1sDTEPGho8qvuLkxwryKw4lJaxliow9HX7hudrAD92rG/zGADf9dPuSoQp4RvR987
         tXsr9C1EUWncyWeHKYAxv8mf5WUbhXEJBwb6l1MQ4IH4NuBZ8NIMfhjBgvlJzoRKl5/f
         EUPA==
X-Gm-Message-State: AOJu0YymZjxtf4G2TPu1XdgqwAIv+/mFEjNzl3mtUZeVe9IrHB9BtV4P
	zydQX1z1UlLZ4gLqxRi6TCXtd2rtWe4CLlhnFvk51dgno32XMQqO26Lr5gLzKuICVAP3GEoVVls
	2rmyEH6ZBS0MSGFJVq8bHglHdzton91BkmGXB
X-Google-Smtp-Source: AGHT+IGwP7bmrs8c6H2dNlHWYWMc4pvUuN7R8ssTqnmr7Fu6RYzEU/zJq2dOHJYvSw7IotqU7XqRa2ac2bYn+xiOn/I=
X-Received: by 2002:a67:f448:0:b0:47e:f147:ca71 with SMTP id
 ada2fe7eead31-47f3c2eaa12mr4070131137.19.1715222920018; Wed, 08 May 2024
 19:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502211047.2240237-1-maheshb@google.com> <ZjsDJ-adNCBQIbG1@hoboy.vegasvil.org>
In-Reply-To: <ZjsDJ-adNCBQIbG1@hoboy.vegasvil.org>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Wed, 8 May 2024 19:48:12 -0700
Message-ID: <CAF2d9jgzsOMQcOv=bhFqWuo2+8wjsEmwmcwnMrVy6gKLXohHMw@mail.gmail.com>
Subject: Re: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps
 for PTP_SYS_OFFSET_EXTENDED
To: Richard Cochran <richardcochran@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Sagi Maimon <maimon.sagi@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 9:44=E2=80=AFPM Richard Cochran <richardcochran@gmai=
l.com> wrote:
>
> On Thu, May 02, 2024 at 02:10:47PM -0700, Mahesh Bandewar wrote:
>
> > @@ -457,14 +459,34 @@ static inline ktime_t ptp_convert_timestamp(const=
 ktime_t *hwtstamp,
> >
> >  static inline void ptp_read_system_prets(struct ptp_system_timestamp *=
sts)
> >  {
> > -     if (sts)
> > -             ktime_get_real_ts64(&sts->pre_ts);
> > +     if (sts) {
> > +             switch (sts->clockid) {
> > +             case CLOCK_REALTIME:
> > +                     ktime_get_real_ts64(&sts->pre_ts);
> > +                     break;
> > +             case CLOCK_MONOTONIC_RAW:
> > +                     ktime_get_raw_ts64(&sts->pre_ts);
> > +                     break;
>
> Why not add CLOCK_MONOTONIC as well?
> That would be useful in many cases.
>
In fact my original implementation had it but my use case is really
CLOCK_MONOTONIC_RAW, however, the general opinion on the thread was to
implement what is needed now and if someone needs (CLOCK_MONOTONIC),
it can be added at that time. So I removed it.

> > +/*
> > + * ptp_sys_offset_extended - data structure for IOCTL operation
> > + *                        PTP_SYS_OFFSET_EXTENDED
> > + *
> > + * @n_samples:       Desired number of measurements.
> > + * @clockid: clockid of a clock-base used for pre/post timestamps.
> > + * @rsv:     Reserved for future use.
> > + * @ts:              Array of samples in the form [pre-TS, PHC, post-T=
S]. The
> > + *           kernel provides @n_samples.
> > + *
> > + * History:
> > + * v1: Initial implementation.
> > + *
> > + * v2: Use the first word of the reserved-field for @clockid. That's
> > + *     backward compatible since v1 expects all three reserved words
> > + *     (@rsv[3]) to be 0 while the clockid (first word in v2) for
> > + *     CLOCK_REALTIME is '0'.
>
> This is not really appropriate for a source code comment.  The
> un-merged patch series iterations are preserved at lore.kernel in case
> someone needs that.
>
This was added in rev3
(Also this is the API version-history which intends to track how the
fields have changed / morphed and not to be confused with the patch
versions)

> The "backward compatible" information really wants to be in the commit
> message.
>
I have the last paragraph in the commit log about compatibility.


Thanks for the comments,
--mahesh..

> Thanks,
> Richard
>

