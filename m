Return-Path: <netdev+bounces-250450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D18D2C3E5
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 06:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C0BF302E05E
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9C6347FD0;
	Fri, 16 Jan 2026 05:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6a0ZrHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39094346A13
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768543150; cv=none; b=Ddn3vk/QXbjAxOapQ/zwKY+LQNN1jzZE2CVQKoeRz6kxEOgMTWxESNUJ4sPJHhm+3knLQbhuSI3HiPUiqH+5yAyueNpqb0B9JOlqsx9DTwzCCmklXTzAsifQY8m/V1npVW16gNJETux6DFM/QiDSYgNp208wq7ElD/Y2IwxUpJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768543150; c=relaxed/simple;
	bh=gMXjxkRiCG6bc5xzkGJLJJ77xyt0l3ekz9zNbGesmC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCcuuO6yIEXwngIUwNuq2WxppQac6vCpYXZmnM4Vc44kXJbLd77AlHZq541WFmG8T95u170Db5IAFSD3c8pypljUCe9hLoRjeXUQoHIVeGGVskNxsblwLQB0hWIG6P9y3fBCQBP6s0FQ3phJ/O2u0BNZ0XyPI4CSfydH1TEc9WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6a0ZrHZ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so3240524a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 21:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768543148; x=1769147948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gMXjxkRiCG6bc5xzkGJLJJ77xyt0l3ekz9zNbGesmC4=;
        b=e6a0ZrHZpkkcdklONZSXGdrx96ZnXYmp4KISfFnF66zXhdSetyXB8U1WI2beNhN7Ws
         jwzRYrTPrTxinjwVR6HvCmR1yUTDkpKXETCakhRipM/SrCBI/miX4t1MYNZaFX7Fgkb2
         BW3ui2j7rESB0ucNU+J+zg5tuBiFs7/D/2DuJf/7Ioh6u2INt/jbehiAgEnQNXJLzGbK
         4nRFyOBHcuW4IUxk2VIpZT0fDPkdt/oiNG2oj/t2OCDBQrfIWuFu3RbEL9hhCjzdPHhM
         qnfY3BOhedFydL/d7asWI745P65nZf5YUHtNCjLd0fFSuPNSAfYWIQCzXuE8u38o6rbn
         Gdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768543148; x=1769147948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMXjxkRiCG6bc5xzkGJLJJ77xyt0l3ekz9zNbGesmC4=;
        b=j9EvuWFNlDgHxKhnOvA5acDyeRtnTzi4R5BVoFhH2P3Z7AA80S49m6rhNe2qLaeZGZ
         4+jlYthPc83KJsQt7igJtEcGn9bm7MkifS7LPSL+xD0yL7QHsGCTldoO9AZ5EEWxOzOE
         Lgt0+gUH+sn2sCltl5QamUX+sfBXmS/DjqxAQxN2Ap8QYmAUdypYgZLBdNdHECXPpKOP
         03NBrLkFEauqIdzbYPXrSe+raiD6ae7jm+mGwvWsMcsOc8FzTyOEIfukvOhyyfg4tq5C
         QkYINBc8pc5PwvOkmC7srAHP105fVlFPi25JQPOB7S/XUE5GMOg7SoaFxXdkopHXAtx2
         m8Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXiSJa9/3bdZiH41tPKnsS17hfTpC8ApKW45nxzdRqbntn+Bgli2KHHX9fRwkQACvD5Rl9FkFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz87zGFZIJEk25An/oCpsg4mQ5B9ZpMSeHpZ26KwmPihwtzvoJS
	3KfDbaP9QyfoJgIGpjUo7hrnONyIKPs+39uEgghKxkHZY8ZsjTdXHDOmgF/rEAVz4C4Nj9dckaN
	dIQr+Zhv/k8jy9i8yy9cNpHSigkMiSls=
X-Gm-Gg: AY/fxX4JjHmzl3iO4+gkwXufy9s+j/sZRmIx826J2Bsp6rjAz3e8xpMKYHov5BMCHY6
	nbsoElDb4afOx9fgMw9LCOei9ug3g76LYy0WGqzn68aWBpBWLIecf8MO+m99nGsOyBFVdx3Rte3
	qF2LWqPs6MiCKYj4j7BKSYNB4y2BDJZzFBQrTTdCxmfSR5jk04O04DzjBRKA2OutCOJgua+/cuh
	8Q2l/IxLPYiYkR1SAtdlBPAZ8szC4+AwLW+FoPvpEB2L1Y1To0YevaYV88E5WyZXom+pZz2j3+w
	g6qeksp4iufd/KPNYI9pK6afXts=
X-Received: by 2002:a05:6402:1d52:b0:650:863d:3df0 with SMTP id
 4fb4d7f45d1cf-65452ce4e7bmr1441098a12.33.1768543147392; Thu, 15 Jan 2026
 21:59:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
In-Reply-To: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Fri, 16 Jan 2026 11:28:47 +0530
X-Gm-Features: AZwV_QjOfAkZ2vUXIm-6kMTxgl6VawOaDwLVmNCBjmyYhioWn1jf-eouDtywdF4
Message-ID: <CAPrAcgNhpK-cOVenrtw+-t9CV7bb6V+4b-R=_0m9Tv0C7U0ecw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/6] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: edumazet@google.com, horms@kernel.org, sdf@fomichev.me, kuba@kernel.org, 
	andrew+netdev@lunn.ch, pabeni@redhat.com, jasowang@redhat.com, 
	eperezma@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, 
	ronak.doshi@broadcom.com, pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com, intel-wired-lan@lists.osuosl.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1:

> If netif_alloc_rx_mode_ctx() succeeds but ndo_open() subsequently fails,
does this leak the rx_mode_ctx allocation? The error path only clears
__LINK_STATE_START but does not appear to free the rx_mode_ctx. (Yes,
There is a leak)
> Would it make sense to add netif_free_rx_mode_ctx(dev) to the error path,
or perhaps check if dev->rx_mode_ctx is already allocated before calling
netif_alloc_rx_mode_ctx()?

This framework should accommodate future ndo s requiring deferred work.
Therefore, the best course of action would be to schedule the cleanup
work. If we reuse it, we would have a memory leak in case __dev_open
never succeeds as the cleanup is in __dev_close_many

Does it make sense to move

+ if (!ret && dev->needs_cleanup_work) {
+ if (!dev->cleanup_work)
+ ret = netif_alloc_cleanup_work(dev);
+ else
+ flush_work(&dev->cleanup_work->work);
+ }
+
+ if (!ret && ops->ndo_write_rx_mode)
+ ret = netif_alloc_rx_mode_ctx(dev);
+
to a new function netif_alloc_deferred_ctx() and rename
netif_cleanup_work_fn() to netif_free_deferred_ctx()?

Patch 3:

First of all, Does it make sense to call e1000_set_rx_mode when the
netif is down?

Second of all, I am not dealing with the cases where I/O should be
illegal but the netif is still up correctly.
For this, I am thinking of adding netif_enable_deferred_ctx() and
netif_disable_deferred_ctx()

netif_disable_deferred_ctx() will be called in the PM suspend
callbacks and in the PCI shutdown callback while
netif_enable_deferred_ctx() will be called in the PM resume callbacks.

I know this will be a lot of work but this is a one time thing that
other deferred work ndo s can use for free.

Correct me if I have missed any cases.

Patch 6:

This was stupid on my part. I will add back netif_wake_queue(dev) in
the next version.

