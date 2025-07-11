Return-Path: <netdev+bounces-206252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C6DB02464
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD4B1CA73FD
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE891DE2BC;
	Fri, 11 Jul 2025 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HSfxSvmE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84A1917ED
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261503; cv=none; b=OEio/TCoPFqDmNeUDHGaHdv4ozjbLuj+BCx48raDVwNUurzaSe7Y43OpKoy5xUpZbqPbN6MmvdrV+0W9e+79YNAxYhkctGJe2qAi29ld+e3GMdq/4WBwYCyB5FJC37zKKTOxBmgBphBepimOZ6mr0jhLbEIBw71DSDWvdR+YZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261503; c=relaxed/simple;
	bh=i17k3LttSodPsplzghCSZRXhBNaUwArUo5/h6u1tcjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeyejE6DTLxjLZqGOKCqfTopZtJny4IvdvfHZGMo78CogXldX6cJ8BwWaQL0l+jqgxn3fi8y+27yuMikkfcs0UtqUNuqqfbExjcaohbtQR0Iae6qr4LNFiCN9DKh6beDsr+lIA2T44uR92dJfDmuSYSK/DG5EIY7GKX3lNX290c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HSfxSvmE; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so491627066b.2
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752261499; x=1752866299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OGIcMUli3ztNAnPUcFhR5bM9fuY+7pKG/dEA+I+ib0I=;
        b=HSfxSvmE7OkxedRh5A5RCX96Y7xM9JBJL1gkSfa+ocUpnI5KSq3KnGVTIexxCzNNmY
         XGu1vCzi403yBRGU4c091TCOzCHDGjuqsMqbeWoHRHBtnHmaN6EdY4zpjmFqkKrw+xUC
         vTCEzAfu3MDNcm/SgGL/xNZKTgUc7pKw+IvVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261499; x=1752866299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGIcMUli3ztNAnPUcFhR5bM9fuY+7pKG/dEA+I+ib0I=;
        b=lIR9g84Bqd/mtcrF1TzEd1ikJvd4v1vO3JNgAOM0jFf01wDUlZL9HQVjwX/X+WckFm
         bcHqlheONWfzZbpV2RzJdn3EwRgtR6hZFw5u8i7Wzv71LuczH+F2WHtzIU9/NeWHlv9L
         nOE9gl23nwLvNpDzBHoX+YDYsCg96siXknCLLx3gm8dfxTwOvp/OUBw0M52MQkmfSzs7
         jansjmxVkxTyhHCxJxSHQtbQtOHErv4JGHJvFtRvHLSyyrp114yCfVLfh1ISAR5uiArp
         yHnbeRH6p5d6L1XviSWtTWSwhNPmSbXNvYA20C17I8AuHSitvIzyd3uzYrOgQln1Vb0V
         vxvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZXfde8+uQ0cYj29clHHBNtn4XTjE1ke8rQ44ZmR3pOGFPUUNgBwEXXjI9CzXwTj6e/Ugo7po=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLUkkJX0ft39T5cIskTqzzKkNHXcrLDoMIfe6UZtrS0H4Nmfr6
	g0HTmwUckW1NI0+NIzCgcQ90BvlXG0StaE+WsVfWIIWSHCNsivvuoj4TYOJFGRmx+z3kJapZ/BQ
	Ooo5Oo2h2+w==
X-Gm-Gg: ASbGncsjTvar62Sa0YlUtntqiY7xc1pqxIjcd1nG9un68bkSS1uUUgO2s7OBUXCx9Wd
	xqDnHKNaGSdhqWKUBytVqOT3X6o9i1Su/vBMo/qfQrnNkwOfWI+035dwfGaAEQrgWTTitReTCbV
	KAKrygiyFHroWgQ/Iz1RNLtkT4Xx92QFgci8ni64Poc4t0c1PQCZDIiSTG7GvLZDRsW99EdJzsD
	Mx5OxDoIm0ZMS5PQ1gompCL6YrMs7GxqyDIMlJz7GJN3qsQVaApWvcn6nos68fkQPP+FmmPCFne
	7S40rUR5HEVWVihFcfVpH7Fs8vQCdNV54WkUWG7R+wvParAbS+jfdPKwVqxxCl4PTGD0uX6yaU0
	5w8Dm0YwLz0C32tVQKpd5ktOMLJ2HXxxau6IBNzhpNOTKW07uk6BNrXwflQHHQwmN1t7YDeYD
X-Google-Smtp-Source: AGHT+IE+WpO6dyyzgRKEJLocrAko1302VcVh7B6WZXCz3R/be/Hhho34Nc/QBJAZ9EwgrQXuWfzTnQ==
X-Received: by 2002:a17:907:97cc:b0:ae0:daca:f06f with SMTP id a640c23a62f3a-ae6fc2238fdmr381695766b.60.1752261499126;
        Fri, 11 Jul 2025 12:18:19 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e826452bsm345293066b.92.2025.07.11.12.18.18
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:18:18 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so4603522a12.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:18:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU82yZ63ydK7o0OEjv68BgDWH+lxC3JWxxA1iLNayGs6NzUs/ThIJyrSp0nN25CwcZfxZmOVTc=@vger.kernel.org
X-Received: by 2002:a05:6402:11c7:b0:60b:fb2c:b789 with SMTP id
 4fb4d7f45d1cf-611e84907ddmr3562736a12.21.1752261497669; Fri, 11 Jul 2025
 12:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org> <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
 <20250711114642.2664f28a@kernel.org> <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
In-Reply-To: <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 12:18:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
X-Gm-Features: Ac12FXyQ_YSMvJEi4nfPYDndHOPluuiAs0LoNS1cD3a_Bb9k_MZNqvkWl-g86Aw
Message-ID: <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 11:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Will do more testing.

Bah. What I thought was a "reliable hang" isn't actually that at all.
It ends up still being very random indeed.

That said, I do think it's related to this netlink issue, because the
symptoms end up being random delays.

I've seen it at boot before even logging in (I saw that twice in a row
after the latest networking pull, which is why I thought it was
reliable).

But the much more common situation is that some random gnome app ends
up hanging and then timing out.

Sometimes it's gnome-shell itself, so when I log in nothing happens,
and then after a 30s timeout gnome-shell times out and I get back the
login window.

That was what I *thought* was the common failure case, but it turns
out that I've now several times seen just random other applications
having that issue. This boot, for example, things "worked", except
starting gnome-terminal took a long time, and then I get a random
crash report for gsd-screensaver-proxy.

The backtrace for that was

  g_bus_get_sync ->
    initable_init ->
      g_data_input_stream_read_line ->
        g_buffered_input_stream_fill ->
          g_buffered_input_stream_real_fill ->
            g_input_stream_read ->
              g_socket_receive_with_timeout ->
                g_socket_condition_timed_wait ->
                  poll ->
                    __syscall_cancel

and I suspect these are all symptoms of the same thing.

My *guess* is that all of these things use a netlink socket, and
presumably it's the *other* end of the socket has filled up its
receive queue and is dropping packets as a result, and never
answering, so then - entirely randomly - depending on how overworked
things got, and which requests got dropped, some poor gnome process
never gets a reply and times out and the thing fails.

And sometimes the things that fail are not very critical (like some
gsd-screensaver-proxy) and I can log in happily. And sometimes they
are rather more critical and nothing works.

Anyway, because it's so damn random, it's neither bisectable nor easy
to know when something is "fixed".

I spent several hours yesterday chasing all the wrong things (because
I thought it was in drm), and often thought "Oh, that fixed it". Only
to then realize that nope, the problem still happens.

I will test the reverts. Several times.

             Linus

