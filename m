Return-Path: <netdev+bounces-161979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03612A24E6E
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 14:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826AE18865D5
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1A71F4271;
	Sun,  2 Feb 2025 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAwfEIpl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCAD1F3FC6;
	Sun,  2 Feb 2025 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738504508; cv=none; b=aBZOuTvBF8zv5pTx+GLL9CDP3f2LOUOsKiMqS6UiO69HJzrvHGjeN5O6dDnIPOksFmMS0JJKbnFmtviHdZyPijesznfJWKOkEUeuJje+IVtgmHQQsYtSEBoVGI8xAGvDXhmkUtKiU3Vc0N9dQrrtI868kYMgbP3OHzjxpeXmsL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738504508; c=relaxed/simple;
	bh=19MrJwE2M63Hwc+dNYqRxXWzNQ/4w/DNGEmB3UG29zs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fp5biyry7Zy/5S6oT/Lgj/lLQl+VkpTANYqzy3d/57vCQG6g0OJq/mdChCwT6Fcb1GhaLbwDcGKbVJN88sikMKNglryXMvINGe/gwrWdS5xm9rODd6sGYR0W3Wb7a47rWeVXu8s+LYxSHmTSEBF1UtqrTIvI2sr6QqmKsxzUUSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAwfEIpl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso24110595e9.0;
        Sun, 02 Feb 2025 05:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738504505; x=1739109305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNsfBeiHTtzxl6IYb/LvgDExYuDS/f8NcFRrBwdh198=;
        b=AAwfEIplmHi8RH3tL0c5DBNyY6GDPs6cAp4CbOkuYz5vyNn5tF1D56g1+FFO8QCTFc
         AtSzoIFHyen+YhDueplUms1DXM206bs+FvnDXHhHR7+vaxVN7Jak5NybDulgZ+B0Nbn/
         eeNVkJTDQ9Cpq2sl39bo2clXfoJjsAdXMLvaVP9V8ZsbyS4t5YZ+bREf19REXpCdFAmd
         asWJS4NT6Z8/vDOjlu60HXU93XVtWA96rqKs6az96C3sNVqEOPyCa3yYPeUXpg1PrEza
         TDlk4djxMMCwVVzgAIPmrtwrOqaPaTe8GnMA803ZOagCoy1TxBmIawlwH2FrxoM5P+uZ
         Rk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738504505; x=1739109305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNsfBeiHTtzxl6IYb/LvgDExYuDS/f8NcFRrBwdh198=;
        b=uc8kgoubNfH7mQtp0tPz3OAF7QyjMplY52f0BU5JZox0NKptvBPpow95ICrYKb3o6U
         Byt53Jq83Kh5bBf3odztNGthte1y4A4Y4dKS0D1LjOlAqBem8xYxlyDj/hGl1qAs0Lu+
         bmYrP2LC/7HQZ5HH1DBI0phXKVTgZqR5oV5CNf7h8+72e+hIY+2BCpkCXqO0TXpIVshf
         SQh2e/HPKh24TFEfCXcQouO5fiCuyX5/aVq4tIMadv+EtZ50x/CwG+4C+GYTnVuDSUIr
         +9WgRlNrRoF+uA3wLDAv3Jed7t+2ZRIrKt6dJN22he7gbI4q4a49lvYD7MgFZD+T6Gh6
         p5WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVim1gXMn1UC+csrDLQYjjx4/ToQvnib5uXvzXQ+38Py/PvMgAu4NncHX5Es/u0+pDWBsaD/sXxtvYo3BM=@vger.kernel.org, AJvYcCVld74gXpTgmz7uoU7EKGoBsY1VRWni+j6/4Y5Ub0Oa8wOEzcLq3+Emd8VwvddQgiEUX3DAYpbv@vger.kernel.org
X-Gm-Message-State: AOJu0YxW2L9CaoWYBhKIW1Uof1ZdFR8DgdhMXyzDpCbicylLIBeUhW0g
	CUKCQLF7RFjLefveUgoRd+v+/UWq2tJ8uasGivQHGWndk2RpotZ9
X-Gm-Gg: ASbGncs3aICMRI/PUL1bteIDEQn4nvLVxbDabQ3oPy2aOR2pKJev8iQDHlAaNzzT1Kk
	Mg9ecJrGj9/C2H9jnIbcqJ3OX6gm26hThXrrIVCa6TT5HgxzfVL7p/VmkryxYc241Y0lWOensjX
	Ajan+PEqMofvUW78em2fpo4t+KnSv554N2FyMKChUWlYIhydbY++xAwvzG1k77pKXN2OEakwjth
	JN3181cK0U+1EGAod6BGHUQ/44d45PTxpYmKiP6PzGAWBFij71LSDvgL2IWnlGDN0EEC5sOeI4Q
	I34bp+4EQl11r6x3OirKuLuH/SAJy1L/u1ZYOIlhbPWBQy/s5xVmJg==
X-Google-Smtp-Source: AGHT+IEBNI/DwNheuqMMc3AK7zFn0rGRjMIyiwjKBnh/JppCyA6dLcUGmxYDuLRS1uLCifEG6CJEsw==
X-Received: by 2002:a05:600c:45c5:b0:434:e2ea:fc94 with SMTP id 5b1f17b1804b1-438dc3c3292mr192346765e9.11.1738504504732;
        Sun, 02 Feb 2025 05:55:04 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc6df36sm162294865e9.25.2025.02.02.05.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 05:55:04 -0800 (PST)
Date: Sun, 2 Feb 2025 13:55:03 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, ebiederm@xmission.com,
 oleg@redhat.com, brauner@kernel.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 6/6] pid: drop irq disablement around pidmap_lock
Message-ID: <20250202135503.4e377fb0@pumpkin>
In-Reply-To: <Z56ZZpmAbRCIeI7D@casper.infradead.org>
References: <20250201163106.28912-1-mjguzik@gmail.com>
	<20250201163106.28912-7-mjguzik@gmail.com>
	<20250201181933.07a3e7e2@pumpkin>
	<CAGudoHFHzEQhkaJCB3z6qCfDtSRq+zZew3fDkAKG-AEjpMq8Nw@mail.gmail.com>
	<20250201215105.55c0319a@pumpkin>
	<Z56ZZpmAbRCIeI7D@casper.infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Feb 2025 22:00:06 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> On Sat, Feb 01, 2025 at 09:51:05PM +0000, David Laight wrote:
> > I'm not sure what you mean.
> > Disabling interrupts isn't as cheap as it ought to be, but probably isn't
> > that bad.  
> 
> Time it.  You'll see.

The best scheme I've seen is to just increment a per-cpu value.
Let the interrupt happen, notice it isn't allowed and return with
interrupts disabled.
Then re-issue the interrupt when the count is decremented to zero.
Easy with level sensitive interrupts.
But I don't think Linux ever uses that scheme.


> > > So while this is indeed a tradeoff, as I understand the sane default
> > > is to *not* disable interrupts unless necessary.  
> > 
> > I bet to differ.  
> 
> You're wrong.  It is utterly standard to take spinlocks without
> disabling IRQs.  We do it all over the kernel.  If you think that needs
> to change, then make your case, don't throw a driveby review.
> 
> And I don't mean by arguing.  Make a change, measure the difference.

The analysis was done on some userspace code that basically does:
	for (;;) {
		pthread_mutex_enter(lock);
		item = get_head(list);
		if (!item)
			break;
		pthead_mutex_exit(lock);
		process(item);
	}
For the test there were about 10000 items on the list and 30 threads
processing it (that was the target of the tests).
The entire list needs to be processed in 10ms (RTP audio).
There was a bit more code with the mutex held, but only 100 or so
instructions.
Mostly it works fine, some threads get delayed by interrupts (etc) but
the other threads carry on working and all the items get processed.

However sometimes an interrupt happens while the mutex is held.
In that case the other 29 threads get stuck waiting for the mutex.
No progress is made until the interrupt completes and it overruns
the 10ms period.

While this is a userspace test, the same thing will happen with
spin locks in the kernel.

In userspace you can't disable interrupts, but for kernel spinlocks
you can.

The problem is likely to show up as unexpected latency affecting
code with a hot mutex that is only held for short periods while
running a lot of network traffic.
That is also latency that affects all cpu at the same time.
The interrupt itself will always cause latency to one cpu.

Note that I also had to enable RFS, threaded NAPI and move the NAPI
threads to RT priorities to avoid lost packets.
The fix was to replace the linked list with an array and use atomic
increment to get the index of the item to process.

	David


