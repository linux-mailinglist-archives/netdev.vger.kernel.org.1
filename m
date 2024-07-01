Return-Path: <netdev+bounces-108178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210E391E28F
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 16:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5E428CF05
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00098169AE7;
	Mon,  1 Jul 2024 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0h3UWA4L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB9168C32
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844463; cv=none; b=ZfrjSrbFUy4nK0Tfx0RVOXX4vB5pv/cFP1ldIRz4t+5+9aTtwIXkzk8wUDEVLHlPjAKOoR6MrimuHfVPiLgFFEo7fewPytYKJusrY4qNlUSXe7wiSTTPRWi4w3xmJ+UOBt+99iAsfJEEc6NHf9XRtNOI2Yt+Iy/1asQvUSjZvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844463; c=relaxed/simple;
	bh=hZLVczWVYkqc2NwpQBQa0JHuez8yTDOyIZgUgtuj9/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsMuQ0msW435mV4b0Q2yTYI/IZ5hVd469V4lnFX4fcsMTwfa48eibpgxItJUdcqBbtq4Tl+0UFathYZxrOPzZTe+PyKWmuMG6+PuLtKbj0Qsa4dQyho0FKPUexm9oDPDWgQHenzCjMmbDl5psJXI2bYF9LcKtYPPVS2X97MBYTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0h3UWA4L; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-424acfff613so28122275e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719844460; x=1720449260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxm2/286zsrii1K3SQifylk+j5wAvP1Kfw/1i+juyX0=;
        b=0h3UWA4Lzbf2GRKZFA4ueMIgw4AieAt1eoGbCOiLWGPFKAc9YafLtOCu3hqQXIS7Nh
         BVfWvvwv6gJFzkuVR2q490u2Yua90h645qnA0fXaIu30sq2JWYPjSY4G+NNnTRMl5mLL
         Xl+QiABQvOozNIEwoWd6r8qN24JfLwZOmUY2YLuiO0xZnYH/bHwOHFCbIpE5N458JA+l
         6cGvnnMtI+WGFctbUpOOZjYd2rNfkpQPwXXgHbVgTJDAbFnhi+etcoe9v0hwZp2fUj75
         Ayb3ef0zStw1KtEPsznFxitwskxSh61ti+rjeK7o4JPcfoq/LYaDsaX1vLFTFF2hMGSN
         faFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719844460; x=1720449260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gxm2/286zsrii1K3SQifylk+j5wAvP1Kfw/1i+juyX0=;
        b=O+ZaikgtusGyVQQ9vLqo1uTl5mTYmUGln+49chY5dyqhkeCwMeVrKy+sslIIrMjVeR
         y8GZHF0gRZoFGQFkhJwnEEBB5f9G3xThEhR8R5152IVdihXdgMDCaRfr1sKHModQMZm1
         /3M8t/HeDo5ScIEaOPDA8CFlPtFFoT4vl0/TSrAaAj5wwwEv8mLmKQx0MCgS4QiMMoiR
         4W4C1EldY4kmOBjShuN2SlNsMwjjDICQIvWum4dD8YWwn++G0qtqTMMelkgvx1m9CyuI
         zg1HwTBFsCJQKYTJQdxFwvIuVX29+oVNxWAWB4kJJUct8Pyq8HaFOxbgY6oBuNt7o0yv
         QnTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtKA48i/V6V0cZw4z+QTDI/9u99E3tRqj/NaHX+DQ7UWo+Rg3OeD6pevhcIgtQeDAiPszDIe5MYS1YJnOP/NuCexAzm5il
X-Gm-Message-State: AOJu0Yw/eBesfKHgpVJ63LJ3ZR7lH9gHCe7axBLmjdgruGHWPmzTQ2Cc
	Gw6CXKrMWk8Pguc2H07hGVZ3SLldH6yK8Bqbfv75N2wSGsB84slvkpALg3wsLjQ=
X-Google-Smtp-Source: AGHT+IGVYBgZ9oMxQW7NLdq5XyBXrfpX9j7PfBdVZGzczzJCDXaM89KFp5oFBhxPCvOq5UKcLe0pCw==
X-Received: by 2002:a05:600c:5129:b0:425:63b9:ae2c with SMTP id 5b1f17b1804b1-4257a02008fmr50852905e9.27.1719844460124;
        Mon, 01 Jul 2024 07:34:20 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b097b82sm159225445e9.34.2024.07.01.07.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:34:19 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:34:18 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Tony Lindgren <tony@atomide.com>, Judith Mendez <jm@ti.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: Kernel hang caused by commit "can: m_can: Start/Cancel polling
 timer together with interrupts"
Message-ID: <h7lmtmqizoipzlazl36fz37w2f5ow7nbghvya3wu766la5hx6d@3jdesa3ltmuz>
References: <e72771c75988a2460fa8b557b0e2d32e6894f75d.camel@ew.tq-group.com>
 <c93ab2cc-d8e9-41ba-9f56-51acb331ae38@leemhuis.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c93ab2cc-d8e9-41ba-9f56-51acb331ae38@leemhuis.info>

On Mon, Jul 01, 2024 at 02:12:55PM GMT, Linux regression tracking (Thorsten Leemhuis) wrote:
> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> 
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> Hmm, looks like there was not even a single reply to below regression
> report. But also seens Markus hasn't posted anything archived on Lore
> since about three weeks now, so he might be on vacation.
> 
> Marc, do you might have an idea what's wrong with the culprit? Or do we
> expected Markus to be back in action soon?

Great, ping here.

@Matthias: Thanks for debugging and sorry for breaking it. If you have a
fix for this, let me know. I have a lot of work right now, so I am not
sure when I will have a proper fix ready. But it is on my todo list.

Best,
Markus

> 
> Ciao, Thorsten
> 
> On 18.06.24 18:12, Matthias Schiffer wrote:
> > Hi Markus,
> > 
> > we've found that recent kernels hang on the TI AM62x SoC (where no m_can interrupt is available and
> > thus the polling timer is used), always a few seconds after the CAN interfaces are set up.
> > 
> > I have bisected the issue to commit a163c5761019b ("can: m_can: Start/Cancel polling timer together
> > with interrupts"). Both master and 6.6 stable (which received a backport of the commit) are
> > affected. On 6.6 the commit is easy to revert, but on master a lot has happened on top of that
> > change.
> > 
> > As far as I can tell, the reason is that hrtimer_cancel() tries to cancel the timer synchronously,
> > which will deadlock when called from the hrtimer callback itself (hrtimer_callback -> m_can_isr ->
> > m_can_disable_all_interrupts -> hrtimer_cancel).
> > 
> > I can try to come up with a fix, but I think you are much more familiar with the driver code. Please
> > let me know if you need any more information.
> > 
> > Best regards,
> > Matthias
> > 
> > 

