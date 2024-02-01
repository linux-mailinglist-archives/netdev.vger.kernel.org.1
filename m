Return-Path: <netdev+bounces-68005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C2E845936
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63956B26A85
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAADE5CDFE;
	Thu,  1 Feb 2024 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJFdmqgP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7EE5D461
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795202; cv=none; b=U6Ay1/BRnqBIKs7gncWbynUIo2Bb34THQk4jgSZotPcAmXdZl+XZnV+ogXpV3b8PQUEVPu3YPmtUZYVHh6guQIsGFvYv+rAZmArxWN7pCqHzNjmJwGDS4sWfifWIl4R8UetOJL+nEHUrhtABFRuKcmxYWUsDebUTy0w1VdrcFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795202; c=relaxed/simple;
	bh=suoI7qvddasF6ze11GbOGjsGkZl9FBFquOHwW330phg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGBS2ivCa9C1rBeZHJJQv/xZ7Nw3p5CbaLBgGCnyMJZm3h8HfDdU+rCxWKqRdZ15tbqyEpMVVEZ6sSLEj6WDFAvBDTglGUknkT8bW77mH5sABvNN1UcVnUOhOpJIdQ2SINivszmUunLO1VmHjpFJMdkWwAkS6kjzeJ2yY07juSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LJFdmqgP; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4bfe04cd2b0so424444e0c.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 05:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706795199; x=1707399999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYWYexFtoJ2yHocou+INVoUtLbF8tOuPvQoRlZwm2yg=;
        b=LJFdmqgPnybJIumvPpfSejLkIEttxsn08suUHDAHBBpYlnfLY7vD/jAwsollH7N3F7
         /3cqzMeD9q0atz+INW14/C+UpgvO/tSxQ3fo6LkcKvgvw4f2O2tNhFpqec8Fur9gMv3v
         riRH9dgwwFJulRbu22STv/MYccrOLORyGL5QxMh/eUmOqx/CtxxU0kTQRX3Xlpy9U69n
         YitNBjDNPl2IwwKRgG0yobZ+WUWalQ/yECvaisqyoop6BsFZXarkvBv0ii1pE/W0beLw
         1xWK4Z/1h78PaQ7lFPIkIfmVGgl0xy/YC9sLuvBzw+MVlkobmg8Mtz/9WpmMqItaonPl
         hcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706795199; x=1707399999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYWYexFtoJ2yHocou+INVoUtLbF8tOuPvQoRlZwm2yg=;
        b=DKG3cUFRHAUWk/kLMziWH1Z8koR/IpbXs45mHqfQmoe+jttoxOrFne4T50iUS/n121
         /EFxPZ4dojPWTcVF8ZUXNQHf/sx7//RygaFv+ry1ngnHQyosthHo5MunwdAGRU5O5N8w
         JTEYfRpkQZbYrhgro4dIHfK+iBUF3R4ev+RK/6rBJDsrJhtXdHvg6cNVKFXmhIMlLGM8
         sCXfLwc8dLQXbWYSu9AuoUGF7cSdfhMiY2SYc7MyMC13XVsKkFmWUBjIboisHJxejOzU
         MXYVGL2pc5u2yF2wnmmIla+AlEGr+lNVd7vPDsPsTytNBaAIeAa72rHFtDRzvHv3vwag
         Diog==
X-Gm-Message-State: AOJu0YzNr78SsXDJCQ6l4L6t4gUqRVu0/0FAk3qgPjwR5ffRu1KR2IuG
	rF+JugQUHlp+bkNtagsX2b25GLbXVcKgCfxkZ/88310X385Fz0rEzmw8iW865As5uH/veneAYvi
	j5+vVsaXNllcnUU4wmXrwKkr6s7M3iLz7i5oY
X-Google-Smtp-Source: AGHT+IG80kHJI3o0nh9nc37cFYAZfNgIoolcnGet/bLjzO8FQfWUZqIqvqwlp1tA8htBaza2xRqZOec13j3l2wPN17s=
X-Received: by 2002:a05:6122:2a0d:b0:4b6:be94:acc6 with SMTP id
 fw13-20020a0561222a0d00b004b6be94acc6mr5599008vkb.10.1706795199311; Thu, 01
 Feb 2024 05:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-2-aleksander.lobakin@intel.com> <3f6df876-4b25-4dc8-bbac-ce678c428d86@app.fastmail.com>
In-Reply-To: <3f6df876-4b25-4dc8-bbac-ce678c428d86@app.fastmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 1 Feb 2024 14:45:58 +0100
Message-ID: <CAG_fn=Wb81V+axD2eLLiE9SfdbJ8yncrkhuyw8b+6OBJJ_M9Sw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 01/21] lib/bitmap: add bitmap_{read,write}()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
	Marcin Szycik <marcin.szycik@linux.intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andy@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jiri Pirko <jiri@resnulli.us>, 
	Ido Schimmel <idosch@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Simon Horman <horms@kernel.org>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, 
	ntfs3@lists.linux.dev, linux-s390@vger.kernel.org, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, Netdev <netdev@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, Syed Nayyar Waris <syednwaris@gmail.com>, 
	William Breathitt Gray <william.gray@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 2:23=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Feb 1, 2024, at 13:21, Alexander Lobakin wrote:
> > From: Syed Nayyar Waris <syednwaris@gmail.com>
> >
> > The two new functions allow reading/writing values of length up to
> > BITS_PER_LONG bits at arbitrary position in the bitmap.
> >
> > The code was taken from "bitops: Introduce the for_each_set_clump macro=
"
> > by Syed Nayyar Waris with a number of changes and simplifications:
> >  - instead of using roundup(), which adds an unnecessary dependency
> >    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
> >  - indentation is reduced by not using else-clauses (suggested by
> >    checkpatch for bitmap_get_value());
> >  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
> >    and bitmap_write();
> >  - some redundant computations are omitted.
>
> These functions feel like they should not be inline but are
> better off in lib/bitmap.c given their length.
>
> As far as I can tell, the header ends up being included
> indirectly almost everywhere, so just parsing these functions
> likey adds not just dependencies but also compile time.
>
>      Arnd

Removing particular functions from a header to reduce compilation time
does not really scale.
Do we know this case has a noticeable impact on the compilation time?
If yes, maybe we need to tackle this problem in a different way (e.g.
reduce the number of dependencies on it)?

