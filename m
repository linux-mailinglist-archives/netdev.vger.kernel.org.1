Return-Path: <netdev+bounces-206270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5E5B026DE
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 00:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DC11CC0567
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38681E833C;
	Fri, 11 Jul 2025 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aD3ISiPY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4119995E
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752272362; cv=none; b=ii9JtQ7CcoK/MlSo3COi0l8lW1WrX7iLRp5fFI658A77XW5zvQYKoMcB0PBAw4sbmF+zc92VS62kT+19Doi4rsNgMnt9a3Vh77umGL2cCYltKBRZPn5IqFXgFOMIh1H8TK1LpevryD6CbNh3Ompb9HGArx9nUcmJcyf99L2jFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752272362; c=relaxed/simple;
	bh=cV4UcqxxRYWfbmVEzgOiPRHwVxe4uXh/78AqAa2cIOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijWRy5aYyNabvULcokbjwUeqNGWLQoGRzu3dMwbL/a5KruEXonXO53lYq2g++QHzxbavyd1rMlcqLJ/w6P2PLiGZUFa72qsnHsEuVRrz4d/8YbUc6tdKsOSI765TPE7xRltRZqqFOTnG8HaXvmZgLqmkfQ7ZYknbOCEzdMyOQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aD3ISiPY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0d7b32322so411482766b.2
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752272358; x=1752877158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hD1RvSl+QN1nzm7kw4Vc4aGimUiL6opjjB0+F8WN/BE=;
        b=aD3ISiPY8L/TpSIppiWqnRZMvEHjOY7sjh9sVm9yUpVR2SpsTBDpTjyICA3aT5grxj
         iLO/HWhod6tdxnLks3eslzfpvnEhFrSsIQwCLur1U7UVjMmpOCooDfas3kv32gyrs4CU
         n6FPMltPxyVPRH14Zt29KYSuZpE06/C8092Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752272358; x=1752877158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hD1RvSl+QN1nzm7kw4Vc4aGimUiL6opjjB0+F8WN/BE=;
        b=f0l2S2rzAXyT0qZ9WX/2ejqDGOrA/WRsUSuExkPQBzocFCwrrWdw5BayIfyCusE3JO
         EWgUjJLCTzG7+4jeOAyeoM2sod+twoK++mYbD8ls97DICPsbRW1L9X3kuCEXyq4IXdB3
         PlLH7VYzUMg6fF1oZNnA7WTSLnr9reDg22WXXdKkEV9QKIJ4ypPdKTXGYPWWfwGw+tiO
         VqL1ps5ilrmNFPQQEH1iPeTIHpuz/NnBkBuh5Rnk7eN7k12v1rHzqjpRBuGXg2exZK2H
         WNO+asupgjvTnU+5FUgmjWx2138GBkws6vks72xtAAcbx/0NBfrFNo4humEmE0LMQkCI
         zc3w==
X-Forwarded-Encrypted: i=1; AJvYcCV+oMnHELtbYF2+bqZGxMPUg4oprgDy+9Rx76ffnuwwyrjnksJ0CcON2WVrD5qvA/4vjEl3yU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRyPwFnrfUE3AN7BGwW5wa5l8YX3/H1I99xrjwyIiGcUfHcWjc
	0n9JD6xwmTJyknvistVgDY/BJJS93HSbJxSWJpZTqVgE8mFlGsryeyWPrA3CMWXfH3/V5xiCH43
	jxKlRYpd43w==
X-Gm-Gg: ASbGncu/iQP8I6A5e3t2stme5v+NhJ2jWj9U7QGMk1heckNEMB6ytptezmF7nk1cai1
	Q2WRr8/aCSPn3pP1RpXmuiIMHrnzM4BIEu8E9331k7pWrx4zBipB9jqkzxSmnqnrwEsTRo84L4E
	0ifvdMFbFFNl/h+K+hhQXRhSEvLjgLO6nF14lfGK9Qc/SRFsHMoPIM4tagrm51Z8DdA13sXYM/O
	XtSDY4JA/4VpCar6WJHXBRf2a/oYR0gtNynjLAqG9nnDefvzY3XB+Q+/LUuCkOXKuQy0+ePNuor
	N1GEXV0sK7sJdVDsDPyJNSPFY1rXNx4YwxjlYPG6Q9FW43rTFYsQaIxA461AMuxtiFNtxdxjiol
	kfol/5yV4nXHXIOViNoBK52/3IuAd8pkvkufFzEfaI+1aYXShQ/Y2oRsZ/SF4w+2CjAjxU+g+cp
	8YSx8cxh4=
X-Google-Smtp-Source: AGHT+IEVH8Ykp2JYVhoZu2Gw6kdkV2llLKTaiKvLGkq/2MVguZ+eHp4s5r/ZSotxR3qKLRCFikXTmA==
X-Received: by 2002:a17:907:75c7:b0:ae3:a716:492f with SMTP id a640c23a62f3a-ae6fc403e59mr359632266b.61.1752272357608;
        Fri, 11 Jul 2025 15:19:17 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91a1bsm365379866b.29.2025.07.11.15.19.17
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 15:19:17 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so4218631a12.2
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 15:19:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3HY/B4I31rUwDmti6XwC+M71qH6rJ3kbwq5HQKMBQw6Q82clwjIrK6yCawavLLYU7+F/Xf88=@vger.kernel.org
X-Received: by 2002:a05:6402:26d5:b0:607:2469:68af with SMTP id
 4fb4d7f45d1cf-611e763864emr3673212a12.9.1752272356713; Fri, 11 Jul 2025
 15:19:16 -0700 (PDT)
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
 <CAHk-=wjv_uCzWGFoYZVg0_A--jOBSPMWCvdpFo0rW2NnZ=QyLQ@mail.gmail.com> <CAHk-=wi8+Ecn9VJH8WYPb7BR4ECYRZGKiiWdhcCjTKZbNkbTkQ@mail.gmail.com>
In-Reply-To: <CAHk-=wi8+Ecn9VJH8WYPb7BR4ECYRZGKiiWdhcCjTKZbNkbTkQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 15:19:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMJWwgJ4HYsLzJ4_OkhzJ75ah0HrfBBk+W-RGjk4-h2g@mail.gmail.com>
X-Gm-Features: Ac12FXwhFwpN-9mAZlnlZx9S5volUcLxcJpIoAPgiTJHzwbOULl1vFp-wYR4lIE
Message-ID: <CAHk-=wiMJWwgJ4HYsLzJ4_OkhzJ75ah0HrfBBk+W-RGjk4-h2g@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	Christian Brauner <brauner@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 14:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I've only tested the previous commit being good twice now, but I'll go
> back to the head of tree and try a revert to verify that this is
> really it. Because maybe it's the now Nth time I found something that
> hides the problem, not the real issue.
>
> Fingers crossed that this very timing-dependent odd problem really did
> bisect right finally, after many false starts.

Ok, verified. Finally.

I've rebooted this machine five times now with the revert in place,
and now that I know to recognize all the subtler signs of breakage,
I'm pretty sure I finally got the right culprit.

Sometimes the breakage is literally just something like "it takes an
extra ten or fifteen seconds to start up some app" and then everything
ends up working, which is why it was so easy to overlook, and why my
other bisection attempts were such abject failures.

But that last bisection when I was more careful and knew what to look
for ended up laser-guided to that thing.

And apologies to the drm and netlink people who I initially blamed
just because there were unrelated bugs that just got merged in the
timeframe when I started noticing oddities. You may have had your own
bugs, but you were blameless on this issue that I basically spent the
last day on (I'd say "wasted" the last day on, but right now I feel
good about finding it, so I guess it wasn't wasted time after all).

Anyway, I think reverting that commit 8c44dac8add7 ("eventpoll: Fix
priority inversion problem") is the right thing for 6.16, and
hopefully Nam Cao & co can figure out what went wrong and we'll
revisit this in the future.

               Linus

