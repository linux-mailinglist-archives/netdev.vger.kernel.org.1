Return-Path: <netdev+bounces-134778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 164B699B164
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 09:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEADF2830A2
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 07:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406A412CDBA;
	Sat, 12 Oct 2024 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0f7PkmT9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8554184A5B
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728716618; cv=none; b=pJH26cm2YXe2OsiR0uompJRyrv0wl2G9cRcLQw1ERr1bCYEfXlXo/dMtGR8qLLKqtboooY1/4RNd1rh7nRRp1Kg7Snhg+5y0HatoptMhd7E/QhTRPjS5fTcntaJ5vbQXifa+6P9tkQ+nIRMaLl04Sj8kTygv7qSr7T7w0Tee+Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728716618; c=relaxed/simple;
	bh=APnDpgyafhu7FduXwy4WSCU73GPSShIJxFxXkdGNTqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7yuB/Wub2mz5Op2+poVO4FtNRCQUwvll9GrE+vUBvH+WP+34RpVXu1gMXBkAVNwDKpAViIEDIWOnpoKQti/f7YlhR1fwyJ2iE2dSGp9WL7dJx3p86UaeswyzLeNp0vBb0zpbLnxHCEj+EttHvhsXtM/MnYdbQqHfwSo74VIoKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0f7PkmT9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-431141cb4efso5815e9.0
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 00:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728716615; x=1729321415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APnDpgyafhu7FduXwy4WSCU73GPSShIJxFxXkdGNTqM=;
        b=0f7PkmT9GhnkKYkn02Uk5E4pG/7b6gE+wYCkhu1xDV2seXBoLkQsHSCNe0fIfv07R3
         6dm6TvnVXRkritTU+xq2jG05UaRjPjp49iKU7I+chL6zZsjdBWjQvcZHvv2U64c6bM3E
         6M1SJFORmF004uQx72d0EYoOgHTP4cwczAqyjDwE1MzhsXcK1euiIJNM4MBtJSCbaUfj
         U7EA8XjiHgu56N/zvNKfwE+ZV8tlHLmbAHRKaNJuw2xru7X2eYrEaakb3LabTOt5sLMl
         VQviKso6UU13MGrA5wGwP4QxESq3XPflLoZSIgcYh6UH9LFflKTcFE0CSiRCmkyrerGo
         3Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728716615; x=1729321415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APnDpgyafhu7FduXwy4WSCU73GPSShIJxFxXkdGNTqM=;
        b=KJRsC2Z2LiAxWPSCQdQo+b8Pp+Kxq2zx6ZTiNk0LQcqox0X9wp29+ktI4nkj63a7vO
         Hhg5C6G+oS2vgERWA8fgj3qNvO7uPkVEo7yE7Zb/DQgQY47XDcxA5QWaQA5VR7kErwGO
         twFj+JStfPgRuAPBmjOLlJRRSnoAvV0Zl2kUIqMM3zcN1pwnqK+yAMo0bnP8n945zoHl
         2pHSq0RSACOFLNGo4ZwIWLNQTecBun0o0PmaITT18bGimgpYN766NicXh7S91b19oNzG
         4/J8EWXRuoLkowBMBvn7j+37llUUoW6NzwMUbcMyatAtiw1O+57ztgGAHCqrF5UM0wLk
         BdQQ==
X-Gm-Message-State: AOJu0YzsfZO7xP2cXzSe5qpPODfVGhbyqJWtL6o1UZ8nPGjbCk+6YBj3
	Q7oNyQRgeUBEhJ2SL3QujjI3rnH0ziB/7BeNrvzj/UCYcw1kOlRNTnt12rq9cZrfWgAcMjmucSy
	lEukiiV9ARSthvxP+FI81ColP/D2RUXgZEb3/
X-Google-Smtp-Source: AGHT+IG7eycOy6lYLVes+zpDq9wE2/Ufn6TACCiWH0h4vKLBuT/99Nutknx+/W+t+IH0V1Knw/42Cux9h7Kyeqolcgs=
X-Received: by 2002:a05:600c:3ace:b0:42b:a8fc:3937 with SMTP id
 5b1f17b1804b1-43125a3a397mr164725e9.4.1728716614623; Sat, 12 Oct 2024
 00:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008104646.3276302-1-maheshb@google.com> <749706b1-f44a-4548-9573-5f7b3823be67@redhat.com>
 <9b36bb45-a31c-4cf7-a6af-cd77cc55e011@redhat.com>
In-Reply-To: <9b36bb45-a31c-4cf7-a6af-cd77cc55e011@redhat.com>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Sat, 12 Oct 2024 00:03:07 -0700
Message-ID: <CAF2d9jjpcpyNQr3nUZG_Dj7hj=hMqeNK_D+f2XtneOiFVpeufg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mlx4: update mlx4_clock_read() to provide
 pre/post tstamps
To: Paolo Abeni <pabeni@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
	Richard Cochran <richardcochran@gmail.com>, Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:44=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
>
> On 10/10/24 10:36, Paolo Abeni wrote:
> > On 10/8/24 12:46, Mahesh Bandewar wrote:
> >> The mlx4_clock_read() function, when called by cycle_counter->read(),
> >> previously only returned the raw cycle count. However, for PTP helpers
> >> like gettimex64(), which require pre- and post-timestamps, simply
> >> returning raw cycles is insufficient. It also needs to provide the
> >> necessary timestamps.
> >>
> >> This update modifies mlx4_clock_read() to return both the cycles and
> >> the required timestamps. Additionally, mlx4_en_read_clock() is now
> >> responsible for reading and updating the clock_cache. This allows
> >> another function, mlx4_en_read_clock_cache(), to act as the cycle
> >> reader for cycle_counter->read(), preserving the same interface.
> >
> > It looks like this patch should be split in two, the first one could be
> > possibly 'net' material and just fix gettimex64()/mlx4_read_clock() and
> > the other one introduces the cache.
>
> My bad, I was too hasty and actually missed that the gettimex64()
> callback is implemented in the next patch.
>
> The main point still remains: the cache infra should be in a separate
> patch: it can introduce side effects and we want to be able to bisect.
>
Hi Paolo,

Thanks for the comment. I'll send the v2 with the separation where one
patch introduces just the time-cache
and the other piece adds the pre-/post-timestamps.

thanks,
> Thanks,
>
> Paolo
>

