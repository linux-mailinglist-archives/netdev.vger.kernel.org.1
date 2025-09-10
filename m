Return-Path: <netdev+bounces-221819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 995EEB52034
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 20:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B3117F501
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5114127605C;
	Wed, 10 Sep 2025 18:23:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A52B26F2B2
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528596; cv=none; b=En4oJB0RBy45DT8GZL2zWhajdZ46AmuiB5NCs9SsxAA4/+4Aq1oDqeVZ/fwzn348FHW6WztLouv1Ko5wXUc04bMmZJQqljLV2VYlH/9xIyd/Sw1pu0k5zE+Yk0ZrvJ5I3Rx5J9otvt/uKXkQpPlfvGin0vPNVIVuRmgtaQ/Kf4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528596; c=relaxed/simple;
	bh=RbZB2QdvXdQC93hIZTWCMHxfBgllHO53876Due/cfHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyVLzINOuVrt952VpY7B7EyVihdP6cG1vDkneyT8lOBZfeSdHutq8jblSs7SNLg2gcD5E47PfrgPJvByM0xgSpcGIcDtnI5BxuyGQAhRrbF7fNxKVwCNfmegXopAStKWsun9WpF+womOdDpJSib11/XmbVO4mccCtfjAnm4vheQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0449b1b56eso1054098866b.1
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 11:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757528592; x=1758133392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmFXFgSBxNTUpOGRx+AfdRKGmjlssb6jAEn00Lu8FBY=;
        b=LbPZH9OE3957MvwLS1os0XagwHn6CPyS6NmCb9RHLyNmsjoml5Qq8JrCkjqrZ2A7AD
         woq5EKTRnqGvEPRGomAF1Yw8PLYG+rtVFnS+odEsFAiBzPAg2rNmDSn2tJNy4qZGBC3i
         CD1s8gCzaHcvXF/XskcSTSGhCpqQ2EFUzV6K3PSbyY5iqJfkJdwTdrlvZFOjo3gdC1l1
         Dlvr1f8+1molMaQmrBN92qpQjq7MLlNi2P/Xj31ys2Wal2QBQFFGRx5Vp423uHKKqBC5
         FhKVFdUHllut92qXu8Cp+J0iIIQf/Myul1eGtefvUyW5PMSH6KmCj9mxSfXBAM05loM1
         4Sew==
X-Forwarded-Encrypted: i=1; AJvYcCWBVRJbEeuckkzNRa4xJXpdmz3NFOOKy8uDNHJBjlMCiWPcMqriqZMN8QgZNhG9SRMGUBT7pW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3hNGcDjKBcAof5cc902IconkEILBT0djI1+DePdSQBGvQSlWZ
	3x1vKj3FBN9u2kI5np7ImkeRYimaKN6JAtTx71akQik1NOSzHZQN58Vz
X-Gm-Gg: ASbGncvb58U8OtEucX4AQ8OmNvT7HyZm1pIJzr1Cd5kQnqSyM9j7fe6vr3TX0Zganhh
	W6GEAmA8lVvq0fnMAJKF5mJzpFqvYnysF57ofov5P0BaDY7VxLtSATgOrGbPK9AhvD2FjG8N5A7
	YFAYWTbIROBx2B678dw+0r+Z0f3pJ+jrr4iEuRSqfJV7qZL5WeXeNCwqVBiYr1awS0oE/sNfNTe
	59Ln6eNP85SGs7zdvm6P9RPImzRK5JrWaYuzp053/6Kbbu9xtEs2z/tbEd12wVIkn1IpKsSf3QJ
	82YE3ypVdLKoq8ANn3jxeV+DlLR2jhLP53aS8FIvY9ObUU8Retjf8xtPMEjrH78fa/5cOSj1CPa
	KtEo9z5eKNF28
X-Google-Smtp-Source: AGHT+IHbHsFjicTmkBhhDK0SwLgSuiGScEUPM0kKkIXxZFZUbT4mc+5rRFWNh8O7jTHDdbNFXbzBJQ==
X-Received: by 2002:a17:907:1c26:b0:b07:892d:6769 with SMTP id a640c23a62f3a-b07892d67d9mr319644166b.2.1757528591432;
        Wed, 10 Sep 2025 11:23:11 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830aa7cesm205651866b.30.2025.09.10.11.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 11:23:10 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:23:08 -0700
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Mike Galbraith <efault@gmx.de>, Simon Horman <horms@kernel.org>, 
	kuba@kernel.org, calvin@wbinvd.org, Pavel Begunkov <asml.silence@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	netdev@vger.kernel.org, boqun.feng@gmail.com, Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <cbvfyefqdyy6py2fswqp3licm3ynrsmc3jclgnbubp72elmai7@kwvks5yhkybc>
References: <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
 <84a539f4kf.fsf@jogness.linutronix.de>
 <trqtt6vhf6gp7euwljvbbmvf76m4nrgcoi3wu3hb5higzsfyaa@udmgv5lwahn4>
 <847by65wfj.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847by65wfj.fsf@jogness.linutronix.de>

On Wed, Sep 10, 2025 at 02:28:40PM +0206, John Ogness wrote:
> On 2025-09-09, Breno Leitao <leitao@debian.org> wrote:
> >   b) Send the message anyway (and hope for the best)
> >     Cons: Netpoll will continue to call IRQ unsafe locks from IRQ safe
> >           context (lockdep will continue to be unhappy)
> >     Pro: This is how it works today already, so, it is not making the problem worse.
> >          In fact, it is narrowing the problem to only .write_atomic().
> 
> Two concerns here:
> 
> 1. ->write_atomic() is also used during normal operation
> 
> 2. It is expected that ->write_atomic() callbacks are implemented
>    safely. The other nbcon citizens are doing this. Having an nbcon
>    driver with an unsafe ->write_atomic() puts all nbcon drivers at risk
>    of not functioning during panic.
> 
> This could be combined with (a) so that ->write_atomic() implements its
> own deferred queue of messages to print and only when
> @legacy_allow_panic_sync is true, will it try to send immediately and
> hope for the best. @legacy_allow_panic_sync is set after all nbcon
> drivers have had a chance to flush their buffers safely and then the
> kernel starts to allow less safe drivers to flush.
> 
> Although I would prefer the NBCON_ATOMIC_UNSAFE approach instead.

Agree. That seems a more straight forward solution for drivers, and it
is clearly a solution that would help netconsole case.

> >   c) Not implementing .write_atomic
> >     Cons: we lose the most important messages of the boot.
> >
> >   Any other option I am not seeing?
> 
> d) Not implementing ->write_atomic() and instead implement a kmsg_dumper
>    for netconsole. This registers a callback that is called during
>    panic.
> 
>    Con: The kmsg_dumper interface has nothing to do with consoles, so it
>         would require some effort coordinating with the console drivers.

I am looking at kmsg_dumper interface, and it doesn't have the buffers
that need to be dumper.

So, if I understand corect, my kmsg_dumper callback needs to handle loop
into the messages buffer and print the remaining messages, right?

In other words, do I need to track what messages were sent in
netconsole, and then iterate in the kmsgs buffer 
to find messages that hasn't been sent, and send from there?

>    Pro: There is absolute freedom for the dumper to implement its own
>         panic-only solution to get messages out.

What about calls to .write_atomic() calls that are not called during
panic? Will those be lost in this approach?

> e) Involve support from the underlying network drivers to implement true
>    atomic sending. Thomas Gleixner talked [0] very briefly about how
>    this could be implemented for netconsole during the 2022
>    proof-of-concept presentation of the nbcon API.
> 
>    Cons: It most likely requires new API callbacks for the network
>          drivers to implement hardware-specific solutions. Many (most?)
>          drivers would not be able to support it.
> 
>    Pro: True reliable atomic printing via network.

That would make more sense, but, it seems deciding about it is above my
pay grade. :-)

Thanks for helping us with this issue,
--breno

