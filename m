Return-Path: <netdev+bounces-221207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F88B4FBC4
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1710188C816
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FF73314A4;
	Tue,  9 Sep 2025 12:50:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CAF33CEAE;
	Tue,  9 Sep 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422208; cv=none; b=gI44aV1iH70HQM5Nof730zKXLtwzUsplZkqeJIU0hXtXWxRAb1sozpALZlKA3t3JPeySeHBTd4PzcFIdr7ycOlkjsQySvYTvOhbDwriOXXXQ0TGHWy+zouP8cV3ytYIdWlmCRtWoJxd3SH7+rK1k0b0sQG3hdyYCFFvsOUjjxTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422208; c=relaxed/simple;
	bh=PuVjVHV1wc9pYl8GdTdV3JGTO6HWYNhQHMq2EYi4iJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIWpKr3ecn78U3Uw2S9EniTuXF+pf9NeKRq2GZKzHFcjeoX4PL9+XrPKPCb0Y24588B2Jr9t36hSmBCvC3h1Tjqyv3iDVBzszbPlnUZJOCfVggagqCp2EMvwivXGq4aHcU6cUF3DxEg8/pEUcv1/lwVsLtLYdthVkDfDeuPZcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b00a9989633so172200266b.0;
        Tue, 09 Sep 2025 05:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757422205; x=1758027005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PL5W7r7SW+5I44FlF/G9YaBRML8VYNr4bNZkUgMqIaA=;
        b=OHxkZGRvBOI7Kz/dyyFtyhCH/OZLAg5XULST6Se8Ox7BYqqOj+yrpUFBBnJVt+K4K5
         TID3RB2ggCRi6azvidc0Ns5XoRjDvaS/BaB+6uiB5lY5ARYkxWjSURvzTWW0AbdoudUr
         3Ne9zq4f7/Ww9veWBt5FswwpanZRXSdR3YNL6QlYvcmxuv++6hhkdURT82tPpLilBLld
         BYBY8mgz+AM3iDzJ2it7VJS0fdZhcp/qCsnWZfWVIjfzb6vDZ4ZnLzFeKLAQs9fUip4o
         txhL8LdbE/KlHz7QAZ3cPm2mVkzmb1kD+ZKPTChfo4vMN5BKEvSeUkXmFkBe/GwZC8CJ
         WSuA==
X-Forwarded-Encrypted: i=1; AJvYcCVhY9jHNaHIyn1JZQqYkI4cKkw+EVKYf76nINxSEse265gAI45rm6tsN0fXg1lZOyz7OaMY69notxjmu/Y=@vger.kernel.org, AJvYcCW0o/MBESfSQpc2ByLYK3BiT2FQcAV4pq5mhn9VutRCYFuCwoyVMEt3+Ep/mWHgXpl7Nv3c9hxh@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAQWNCb2mzpvLf4Epf1XZ9WgUTUh+OopisuI8w6lvmJCFbh6a
	dUywrr3u8iIrn9DmS312fQh1z2h4pv+SfzFYvaqUF3bDVZYMpdKhRiFD
X-Gm-Gg: ASbGncv6nbOnD5npl1ql8uj+0qimhsxtMTgzIs9jAmf+ObexqlmknZB1/pCi1NCeAi0
	PJi5L6qxRuNFRHy+e3O2kM87Y5Bn42NdRV6JA6uyuL5iFdkp/bgB3PScQMTU2yvmyzYIazP+0JA
	z+EV7/0YJSXeSQHJBb6bnmnt2VQkKk5CBSiOpRMfrwaFOn+dXVC8t4smobKvKm+Jcim3iyGDBww
	Ka2AEJ/N6jp/mIyrLDXwt3bWsgZd2So9UErpPVDZRaVnZGruc2foFMOUGzAJVGZHiAhfVKWcVW/
	tzk3dowk/soMHQ+X2HxC7Knt21PPxYJE9A0WxZNC0P7usE+Vpdl4+bDemMZ6shso68BHHSvri+O
	n0Ea47P2LuDGYNA==
X-Google-Smtp-Source: AGHT+IFt/HhYIRfjMPYRAmI2pRuNGPplO0iIBQjsLKZgH0ZZ5p6msexYhicjU4gVciMaUBH61p47eg==
X-Received: by 2002:a17:907:a088:b0:b04:3cd2:265b with SMTP id a640c23a62f3a-b04b1dd47b0mr1190898466b.5.1757422204798;
        Tue, 09 Sep 2025 05:50:04 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0413ee67a3sm2273063466b.24.2025.09.09.05.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:50:04 -0700 (PDT)
Date: Tue, 9 Sep 2025 05:50:01 -0700
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Mike Galbraith <efault@gmx.de>, Simon Horman <horms@kernel.org>, 
	kuba@kernel.org, calvin@wbinvd.org, Pavel Begunkov <asml.silence@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	netdev@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <trqtt6vhf6gp7euwljvbbmvf76m4nrgcoi3wu3hb5higzsfyaa@udmgv5lwahn4>
References: <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
 <84a539f4kf.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84a539f4kf.fsf@jogness.linutronix.de>

Hello John,

On Fri, Sep 05, 2025 at 02:54:32PM +0206, John Ogness wrote:

> >> The bigger issue for the nbcon patch would seem to be the seemingly
> >> required .write_atomic leading to landing here with disabled IRQs.
> 
> Using spin_lock_irqsave()/spin_unlock_irqrestore() within the
> ->device_lock() and ->device->unlock() callbacks is fine.

But it is not fine for netpoll, given that netpoll calls the network TX
path, that in some cases, tries to get a IRQ-unsafe locks, such as
&fq->lock. This is the current issue reported in this thread.

In other words, netconsole/netpoll cannot call the TX path with IRQ
disabled for some devices, due to some driver's TX path using IRQ unsafe
locks.

> > 1) Decouple the SKB pool from netpoll and move it into netconsole
> >
> >   * This makes netconsole behave like any other netpoll user,
> >     interacting with netpoll by sending SKBs.
> > 	* The SKB population logic would then reside in netconsole, where it
> > 	  logically belongs.
> >
> >   * Enable NBCONS in netconsole, guarded by NETCONSOLE_NBCON
> > 	* In normal .write_atomic() mode, messages should be queued in
> > 	  a workqueue.
> 
> This is the wrong approach. It cannot be expected that the workqueue is
> functional during panic. ->write_atomic() needs to be able to write
> directly, most likely using pre-allocated SKBs and pre-setup dedicated
> network queues.

Netpoll has pre-allocated SKBs and, although not the primary way
of allocating it, it can easily be set up to do so.

The problem happens later, when netpoll calls netdev_start_xmit(), which
calls ops->ndo_start_xmit(skb, dev), which might have some IRQ unsafe
locks (depending on the sub system).

To summarize the problem:

1) netpoll calls .ndo_start_xmit() with IRQ disabled, which causes the
lockdep problem reported in this thread. (current code)

2) moving netconsole to use NBCON will help in the thread context, given
that .write_thread() doesn't need to have IRQ disabled. (This requires
rework of netconsole target_list_lock)

3) In the atomic context, there is no easy solution so far. The options
are not good, but, I will list them here for the sake of getting things
clear:

  a) Defer the msg as proposed initially.
    Pro: If the machine is not crashing, it should simply work (?!)
    Cons: It cannot be expected that the workqueue is functional during panic, thus
          the messages might be lost
   
  b) Send the message anyway (and hope for the best)
    Cons: Netpoll will continue to call IRQ unsafe locks from IRQ safe
          context (lockdep will continue to be unhappy)
    Pro: This is how it works today already, so, it is not making the problem worse.
         In fact, it is narrowing the problem to only .write_atomic().

  c) Not implementing .write_atomic
    Cons: we lose the most important messages of the boot.

  c) Any other option I am not seeing?

Thanks for the insights,
--breno

