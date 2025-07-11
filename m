Return-Path: <netdev+bounces-206257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73026B024BE
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03C817A455
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708CC2153CB;
	Fri, 11 Jul 2025 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cJ1Okkz2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3161EBA1E
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262995; cv=none; b=tgk0k7cTW8EfhiAKXBn2UGRMGsGEBhSXkPRlTPJkNneI0PVbsEDyxpm9I+7ucE38NqB7ZT4HRC/IAHG73w6A649rMtqCNWC+l8Wp7sglgYwY9SUdI2T908EVAZwAF8rY0bRSelVo8eEjhb9Qn/tgVxi3vCWzeRbTy0xa4cY2rmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262995; c=relaxed/simple;
	bh=YuVVPwZ25CbTKPK3Z0FQD2M2CVGVme349VWUdFJBcsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flnrDpjlN22YAKNrUWDRf4v374DbNOaRh/1ftWrcp05tCLp81f7ojYnHgY+tby7g0TiuAHN62nacAATa7kmyvnIry75UlkMzfAR/cxQufGawSoC12VJGZqP0gjDnLfdmyqqy6aNKQx30z69SrZcWC6pFrUqE+AaEqHVWL3lxzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cJ1Okkz2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae401ebcbc4so433009166b.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752262991; x=1752867791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9ZfdodvbHY+23Mq1hb6r26JRQ5egJtJgCen/4Rtzlo=;
        b=cJ1Okkz21Sejd/Twxuwrt2KXWffnfRmVnT4NW7CfQeAJQdvBWXlLcRU0zRG4igLrhm
         99FztMH0tSQG0+cvJRxx0w7WumcVGI5zNSoxlEgx4qfmAtpMXQJadMzOtGH5zfdCoky8
         6pfmBq9h34TLgyaJckVRjPJVSXd/Doath7COc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752262991; x=1752867791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9ZfdodvbHY+23Mq1hb6r26JRQ5egJtJgCen/4Rtzlo=;
        b=lBe6I6Oo7i+Ud1Ra6X3R++JNxqK04SA9dMeXkPWGM64Isu+qhz7PrMMWuB3uMFmQQ8
         z0kfQZSG7a+8iTQNz2wmB9FBqrLaBuJdM963ihjKy+dxIwVspaEQJytciZP4mxPLUxvR
         oWd9iMkOHrG4qhFqP9ycAQEte6JKvKZue7iJ3hFGcBDHK2Nl7fhXDUQLP2Debky05N/b
         Q31Q8pi01vRNnWdkcg2nVZlBw5D5HZYTttXjf8xRWzJVbFzFIE7+yxcsIiQKsLsSiPaC
         vClDRtNjDr5QRAVSsLCQK/RxmW2vDFuaIjZ/91p+u8uWy95qCicAJ8y5hI+UUHUiFu+a
         yZDA==
X-Forwarded-Encrypted: i=1; AJvYcCVStnLlO+pA0OF4vAiCsTsQrjMXD0tKwf5tdvVkkjzfYc6uDmBk+Gdu92p+khcUpDPNfnYkapc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwj7ZBFu7CNfbysHv/9ErxQwExA8Iww7NppT3FJaxI06sBsZ/s
	W3WcZ1XnttysQOp8usrP4QYRHiWbGDsUySn6PNSetreJ+HlbNUBdIzItnNMODN5eqi1z5nFTTMx
	rnXS1xaysdQ==
X-Gm-Gg: ASbGnculgIHJR5pMUel+AUp8ORscbeyZja3LnPx5268IfzeAYrjSxrHzW1hfFBkC9TC
	hTv+XuV89/RvgEdT0DAVQ8uFqi9+Y64eKLEXBcAKTXhPl/+UPtzfJJndTEoVrChT1KL39CgmieK
	qrRSDo6m0/GW0AbZPdaa9XFQqY+sjkmuLS6wNDVRPHuWNpRh2HDAQqq7FfPstXq7qJ6xvE7XMd0
	gapvSueGGaLt9o89sHefFrLYhCBWG/rN7eyW5UKt2pMrWd82c876rCQiGnNQRmQuRd60HMsCuPh
	1uO1WIr5zHELxasvyrrvi4CAkGNQwnarg0cRECXg1MN4BZN2qNWgH1vQoifecYYvivagyH1cKaS
	ea9QwCE/zJ2UwSwBARE6RjIn/gPm4kLOhwK5Xt/mLjeQL9pCxpK/eDHnU4960xd5PSmUZq7aH
X-Google-Smtp-Source: AGHT+IHDkV+vUHgbHh2SsvXJsbHGTrQ7fv4St7dpwwwy+4ACFINfTjoY7C0M9gfVI5x7ACgqFlacyQ==
X-Received: by 2002:a17:907:f1cb:b0:ae3:a71d:1984 with SMTP id a640c23a62f3a-ae6fc200bc2mr508470366b.57.1752262991321;
        Fri, 11 Jul 2025 12:43:11 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82964f5sm349827466b.143.2025.07.11.12.43.10
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:43:10 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so4639676a12.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:43:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTlxLnQ96LttOJmiJgqNXj2KuvtULn99ix3izplFLNy6bojnV5kUC6WhUPcolTuI6q1GR7j8E=@vger.kernel.org
X-Received: by 2002:a05:6402:b57:b0:60c:6a48:8047 with SMTP id
 4fb4d7f45d1cf-611e765cb6fmr3016397a12.11.1752262990316; Fri, 11 Jul 2025
 12:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org> <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
 <20250711114642.2664f28a@kernel.org> <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
 <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com> <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
In-Reply-To: <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 12:42:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxjOfjufO8hS27NGnRhfkZfXWTXp1ki=xZz3VPWikMgQ@mail.gmail.com>
X-Gm-Features: Ac12FXyPtqVJ9Y08_msIv6jNrtKjZmcd0_WCbnv2xHgZgXnR4R8GpwOuT4Zyud8
Message-ID: <CAHk-=whxjOfjufO8hS27NGnRhfkZfXWTXp1ki=xZz3VPWikMgQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 12:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So that "Oh, it worked this time" has been tainted by past experience.
> Will do several more boots now in the hope that it's gone for good.

Yeah, no.

There's still something wrong. The second boot looked fine, but then
starting chrome had a 15s delay, and when that cleared I got a
notification that 'gnome-settings-daemon' had crashed.

And the backtrace is basically identical to the one I saw with
gsd-screensaver-proxy.

So it's some socket that times out, but reverting these three

  a215b5723922 netlink: make sure we allow at least one dump skb
  a3c4a125ec72 netlink: Fix rmem check in netlink_broadcast_deliver().
  ae8f160e7eb2 netlink: Fix wraparounds of sk->sk_rmem_alloc.

did *not* fix it.

Were there any other socket changes perhaps?

I just looked, and gsd-screensaver-proxy seems to use a regular Unix
domain stream socket. Maybe not related to netlink, did unix domain
sockets end up with some similar changes?

                   Linus

