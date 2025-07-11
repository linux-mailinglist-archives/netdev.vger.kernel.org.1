Return-Path: <netdev+bounces-206269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744A4B02684
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 23:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076143A0109
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91765214A93;
	Fri, 11 Jul 2025 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HwfEjbRc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670DE1F4E34
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752270385; cv=none; b=F0jHVlaqwKE+AIUDCoOPQz2MgfBC4mn24xwulnrQuAYpGpPd0SbFlaf7Xe+LazOt61LMEYAK5UfHOt7ol5Edo9uWwzSNaC8a/pOy4z/og768oVQ5yB+GywnJLKeabbzmRdBn1mU43JEo28e0rCzKxzUVXGuKWlDJUwbpTmM/a8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752270385; c=relaxed/simple;
	bh=H/zPEzC8h/rhWeEV39tcr+XT+TN9zJHsawYYmLNzQ0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hayh28V7tTsPgxHEgqs6sUwSPfd2NhROmFi+KVOqcEqPKXlVEAgEwIu7hredeEFqaOCw+WnB90QbT2jiPmmG8G9+NcPcm5Bcy3M0HvsZOf3YkVkzP7Y3MPydFWNuKzHxrccbLjbrtXmMeb2pvAP0h1XYw3FQdd4TeZ6Z7aliB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HwfEjbRc; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so4783648a12.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752270381; x=1752875181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LWl0ZCeXiXBuL5nfGt864S3rVP453Egy/lQ9GBy3dco=;
        b=HwfEjbRcPHf1GqZOgi3MjyDkDYhUUjOSUY6tizY8ZcgXyxEw8+7AewG3g9qb6VFSHC
         vUsOqyWG/1wi/fC7S6L3iInETF3jo1kanvkg3NsVQXalVpC5qzRBs6faxGOt90+TaHK+
         xg/bi2SSgUAF1R4k0MvYXMG63sbdZtkieMeXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752270381; x=1752875181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWl0ZCeXiXBuL5nfGt864S3rVP453Egy/lQ9GBy3dco=;
        b=hXauALvuhuBq6He+PPQOhJJdduBXMC/1whWlC5Ea+e8SU5PIEIq3b9wphAXJWmZbP3
         jT6hfli6+H86ByT+ZMCocUtiBTRfKBxtqAEk6p72+zeps165UlD4uDHZHZ9Qg8XZonVh
         iAngl6U44X5SjQjhuyxkeXzSA9Ec3a8C48WuZczfF2XASvt3ckxAMaFfGtJFkFIKyZge
         eksxi+PMR2BeUcGcSl4XAAOcRO61kCm43HnPblxLm7Io9+mnKeNLThswAIaCzxj0yrXP
         dxWS3RYVKlfsg+Nu0WFFE0SPK1yv/j2qdxCsMKWmdVY2UYb/ONdxbBjL6fqg2aSkg0s1
         qSGg==
X-Forwarded-Encrypted: i=1; AJvYcCVlSDqzgWkQJ1AbuMs9MTZKI01IpuGyQtfDZT71GzBcbeiHJ9xZA0IkYEP9MAsMM4rjwm6o0CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFapslJf+mTbKV2tYD4LW10xER6cD+eqG9lU26tz8z55csHIRO
	udAh8PQJ/fbXuhZxXeyI33OfZ9zFiSOHEZ7e8IQ4Ra6MlqVH/xRqkVeC8xxlH0SebHZ5NElxkV1
	69DOD5EVXSw==
X-Gm-Gg: ASbGncspEAFGiAtQsaPi+qtvhiUjqWFQ2jDHJXXvTfQlgnAnKYF8yqiqYPkA9m+GouQ
	O16KtQPN0OfSmeI/4Vy9iQ5tGle3Je3/UvShqmIvZlgZXT5RPy2HuTy0SjGGsbxY6xfhiHzk62z
	rjB/Tx9+n/5D3e3jHQQ7UqOOLcUhId5CUQuqcAXSDC/ybUllmOhQL2l9xd5khAoe09Bfzxj2m7l
	TIld91+/5IWg5+d3siGoyBb1S0EOYI4XuuCKmPDJ2TYx5AkYLL6N1j4Y7Z1/YzItSSm0Bl4/7nu
	ZR7PlXrlhQzX7mzX7HbSzcPQl0sXd4jPVjIkt0PeGuJUKbOFCo3vSg4BHDoauyhdlAz4x8EMKF7
	XqsFULwhMaNmRGwWfeSk0WqsEZGLg2HqpuhdaWh2YWaA4m5PYyrBuoNL2o/2zMN1lOl0EOdydgF
	TDx9n/xlw=
X-Google-Smtp-Source: AGHT+IEdDKA1hsIqyx6AaD7gyzAC1zPb2Uf9T4ZZ4WRWISa4DHkOjSDMAdc4OT5IGoJaSKRD8G7yqg==
X-Received: by 2002:a05:6402:3491:b0:607:2e08:f3e6 with SMTP id 4fb4d7f45d1cf-611e63b91b9mr4180274a12.17.1752270381383;
        Fri, 11 Jul 2025 14:46:21 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9734069sm2746787a12.48.2025.07.11.14.46.19
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 14:46:19 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so4783604a12.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 14:46:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEpKQk8Is7IgD2qUAXA1eM4XOiHF8y40ATeUgCzQRjgWKd/kzEgr/8ROffAa2ghvHTWboHDu4=@vger.kernel.org
X-Received: by 2002:a05:6402:350b:b0:608:ce7d:c3b8 with SMTP id
 4fb4d7f45d1cf-611c1df53aamr7638873a12.17.1752270379368; Fri, 11 Jul 2025
 14:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org> <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
 <20250711114642.2664f28a@kernel.org> <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
 <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
 <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
 <CAHk-=whxjOfjufO8hS27NGnRhfkZfXWTXp1ki=xZz3VPWikMgQ@mail.gmail.com>
 <20250711125349.0ccc4ac0@kernel.org> <CAHk-=wjp9vnw46tJ_7r-+Q73EWABHsO0EBvBM2ww8ibK9XfSZg@mail.gmail.com>
 <CAHk-=wjv_uCzWGFoYZVg0_A--jOBSPMWCvdpFo0rW2NnZ=QyLQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjv_uCzWGFoYZVg0_A--jOBSPMWCvdpFo0rW2NnZ=QyLQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 14:46:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8+Ecn9VJH8WYPb7BR4ECYRZGKiiWdhcCjTKZbNkbTkQ@mail.gmail.com>
X-Gm-Features: Ac12FXz-E7TSeMs6PS6FH7HeMIkvC5P9gc2EaFCqanu5QU51-la_uVcLprbUluM
Message-ID: <CAHk-=wi8+Ecn9VJH8WYPb7BR4ECYRZGKiiWdhcCjTKZbNkbTkQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	Christian Brauner <brauner@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 13:35, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Indeed. It turns out that the problem actually started somewhere
> between rc4 and rc5, and all my previous bisections never even came
> close, because kernels usually work well enough that I never realized
> that it went back that far.

It looks like it's actually due to commit 8c44dac8add7 ("eventpoll:
Fix priority inversion problem"), and it's been going on for a while
now and the behavior was just too subtle for me to have noticed.

Does not look hardware-specific, except in the sense that it probably
needs several CPU's along with the odd startup pattern to trigger
this.

It's possible that the bisection ended up wrong, and when it appeared
to start going off in the weeds I was like "this is broken again", but
before I marked a kernel "good" I tested it several times, and then in
the end that "eventpoll: Fix priority inversion problem" kind of makes
sense after all.

I would never have guessed at that commit otherwise (well, considering
that I blamed both the drm code and the netlink code first, that goes
without saying), but at the same time, that *is* the kind of change
that would certainly make user space get hung up with odd timeouts.

I've only tested the previous commit being good twice now, but I'll go
back to the head of tree and try a revert to verify that this is
really it. Because maybe it's the now Nth time I found something that
hides the problem, not the real issue.

Fingers crossed that this very timing-dependent odd problem really did
bisect right finally, after many false starts.

                 Linus

