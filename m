Return-Path: <netdev+bounces-79532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F6B879D53
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC8AB22652
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 21:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4068414291E;
	Tue, 12 Mar 2024 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cljudx1v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4061428FC
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277906; cv=none; b=W9FIISrH++BzWY46URwf+DfzwOes2Njk5eH5/bukz2HK9HD66tqY0/5mkNIDWm0RMWjsyC+2YqA2/sR11sikKtwRRI7Mg1JXb85KBNdcmkTZS2FloTbaAFJ/4z+9jICH7bFT1cTfRPBqv3e9Rtik3m9z+fB9QREaz5qi+l7aNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277906; c=relaxed/simple;
	bh=T3kzBY9GfAnM+q51fC0moJWtnEIIEoGiMeFr1W4OVzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9SY1+KiIvr4W8jDU+1V0TRatKIpAIz8wGoHrl7OdB0VDh9yUmcow2IuHEN5uFa8tQv4HBDdXNtNuvYVhMvQrGfOjoXcZlgewUhVaZACJ/IeyKw3RGVC3a5SgVrlF0Gdfmh3sRgsdaDXE1kDIs2JfoVSgIYBlMBOubMYZxMBi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Cljudx1v; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so5708166a12.1
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 14:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710277902; x=1710882702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FBYUhCU7Eheux/pd0BVM48w4mv0asJqGomAvUXs2qr4=;
        b=Cljudx1vYJXDdMdiE3dye/gbHq8S4nyYIVFbs98B9Em7f/veNGS3Mx6HB5XC5+D2tC
         UE3wqGQBz8OR6KZ0fV5AFzkgl7a9NyogrPfZb5auuJ7Y5NgdE/ni/vJotZ72w0e7c52w
         5g9KTmq00zB+0BeKEvKQ9ChCS7rF9Szsj7vSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710277902; x=1710882702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBYUhCU7Eheux/pd0BVM48w4mv0asJqGomAvUXs2qr4=;
        b=UHU2JK2b4IKKqdoPIhE10eVwBet3mFk39nlR7HcaaVAifIwJvqSFoHu44spcNruFm8
         paYDC9+AviV22BW4goD8HqANemcf4gG1ji9atSr9stXarJERGwePLeqNKAqF3uYmCZ9/
         tH+btc0ch199VihnDRApHQzWYOYDX8WZ0kPXeRx9q+egvEePHhllbgo4mwsEpkrqGGC8
         SR5gNHNR8J2vuRgMi3svROlQ89RD5mrJjs1l7DZ3V2YKx37Hj92wKdIViWUxSvfg3Qsy
         SmZR5C2lfl2C/hSZQ+b+V2D/P0rUOX/l0mkTXgaIX4YJfPxoSYrEKgDtBupZwLn5EKFa
         Tfdw==
X-Forwarded-Encrypted: i=1; AJvYcCVnMWihzEN1wDiLlsNVvWJYZB5WDQaiKIkcSs5nO8tmDIvFxq74+Y6+MQgu+tT8iR9w1mVQCijNQskJNWgcF9T+WtkBbcLj
X-Gm-Message-State: AOJu0Yw79IE9MkyAj37Hmzd/TDR+ZLtMsKIZevgmNWYcz27Xirkhnfa8
	j8YY2PJwvXdluRX6AtEXmsSPz9syMRKg4B3aEyCxE6oua0l/AyMKBBRm9NnL0R2mmEif1ZsZcEk
	pOtNDvw==
X-Google-Smtp-Source: AGHT+IE4Y7TDwWyCR2fkQu95w/5rWvwV1+jDR4bOKih/X3PB4DaixU0noCf5wT3hn5LtSgtskkwU0Q==
X-Received: by 2002:a17:907:72c5:b0:a46:220b:25b4 with SMTP id du5-20020a17090772c500b00a46220b25b4mr5999964ejc.11.1710277902216;
        Tue, 12 Mar 2024 14:11:42 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id kk28-20020a170907767c00b00a4547925e3asm4278262ejc.141.2024.03.12.14.11.41
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 14:11:41 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a462a1b7754so339166966b.2
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 14:11:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUXeVF/5lHH1oLJkey3PNhuo5hyARu96bwR1zj3vFsgfnxwyAdh5tOV7TOx4SUKGuIM0aKDh1BlHZb0MLqeIUMKo9BBV/e
X-Received: by 2002:a17:906:e0f:b0:a45:da1:9364 with SMTP id
 l15-20020a1709060e0f00b00a450da19364mr6434203eji.19.1710277901356; Tue, 12
 Mar 2024 14:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312042504.1835743-1-kuba@kernel.org> <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
 <20240312133427.1a744844@kernel.org> <20240312134739.248e6bd3@kernel.org>
In-Reply-To: <20240312134739.248e6bd3@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 14:11:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com>
Message-ID: <CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.9
To: Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 13:47, Jakub Kicinski <kuba@kernel.org> wrote:
>
> With your tree as of 65d287c7eb1d it gets to prompt but dies soon after
> when prod services kick in (dunno what rpm Kdump does but says iocost
> so adding Tejun):

Both of your traces are timers that seem to either lock up in ioc_now():

   https://lore.kernel.org/all/20240312133427.1a744844@kernel.org/

and now it looks like ioc_timer_fn():

  https://lore.kernel.org/all/20240312134739.248e6bd3@kernel.org/

But in neither case does it actually look like it's a lockup on a *lock*.

IOW, the NMI isn't happening on some spin_lock sequence or anything like that.

Yes, ioc_now() could have been looping on the seq read-lock if the
sequence number was odd. But the writers do seem to be done with
interrupts disabled, plus then you wouldn't have this lockup in
ioc_timer_fn, so it's probably not that.

And yes, ioc_timer_fn() does take locks, but again, that doesn't seem
to be where it is hanging.

So it smells like it's an endless loop in ioc_timer_fn() to me, or
perhaps retriggering the timer itself infinitely.

Which would then explain both of those traces (that endless loop would
call ioc_now() as part of it).

The blk-iocost.c code itself hasn't changed, but the timer code has
gone through big changes.

That said, there's a more blk-related change: da4c8c3d0975 ("block:
cache current nsec time in struct blk_plug").

*And* your second dump is from that

        period_vtime = now.vnow - ioc->period_at_vtime;
        if (WARN_ON_ONCE(!period_vtime)) {

so it smells like the blk-iocost code is just completely confused by
the time caching. Jens?

Jakub, it might be worth seeing if just reverting that commit
da4c8c3d0975 makes the problem go away. Otherwise a bisect might be
needed...

          Linus

