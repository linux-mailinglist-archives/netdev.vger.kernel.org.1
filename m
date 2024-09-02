Return-Path: <netdev+bounces-124267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEE4968C08
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F135D1C22457
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81D1A3049;
	Mon,  2 Sep 2024 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VtFKIPq5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D53BB50
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294589; cv=none; b=hAXohTDFKMFVpJt/gHQVcp0YcOSOwD0RUJ+sKeoBqy62Q73zT6MbTlfb3Ej6EfBXbR+fYA/hLTsrvooIQhgI6BztgKtKFHJqpV6KcvJw+6CwPbkThTezv/x06E+u0JUlemJcZNeEm8gyvO9LuOb351WvhPqxj2K9EAsChhyaaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294589; c=relaxed/simple;
	bh=H9KQi/YeoHXtFjvXAZTjfZ0POvVPW/truEu9aI90Uvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQqIPwiZr8vCcrr3SKnfcdxGO7kDlKxKRYQ5dmVv8j66axmDGhpLKnMrMqDzk/1r6e6a4jBqd8jXdy+qTBMNC95PGIyTZ/t8EaQrkf0ID/FO8QV9rk/Hpr/WTGKJ43l9dHkRyT6JP1Um2+rmvGrh9tYj2GNnI5l5vrjjUsoYukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VtFKIPq5; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-533463f6b16so5620727e87.1
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 09:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725294585; x=1725899385; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7kIi9VgkWI5peIYLMCXIR56ai0Kv2Eq0SSJ1yh02a8=;
        b=VtFKIPq5bE1LJoYFrtPjyHh17hBOH0OtCa+BZK6MrQRe4Fj/57EvwWeJtJ8jix2lE5
         SfzxE+MdeOAgWsaRgjKUWcLaUBjFJyTR7GqZPwmmepB5zfhoiAhRd9CQlb+WQmycekcQ
         ESt0m6kkrg6yVIWYYc5WHFVQReiGoh98B8lAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725294585; x=1725899385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7kIi9VgkWI5peIYLMCXIR56ai0Kv2Eq0SSJ1yh02a8=;
        b=OBzTR1Z6qEqFIohBdOUgienJ4Q97/WDVE1xV/K+MECM5uWrenG2WAp8F2RIuesF50x
         3txHMPiyPkaHxMr2qklIpR0nAt3udilmiE35x/CSv4dFVGXwm3wM+Mk/iyVFDUp1dJNb
         L8nlhNBRn09m3qMa48/x6whsYr2xWUp50swYqA0nfBTMR+affamKpu0me+L19nC/Rpvq
         gh8MbTfHTXxPHPSGi+BCAIYMKdZqlngUfFneotiJv16OuBsFFeCDGYXs3FkZbCtjzuTG
         pP9ps5P6/16U9vsgaZNkT9Q4jflmERXux+QvgDNNUsMluYa8FN7cyoUCdXu8iXe1Ygqw
         kZkg==
X-Gm-Message-State: AOJu0YyKStk8YCLfYyETtU+d1wGgoKVj7boz5W8+5xuY7w/rbLhyCScj
	0nC0Cv4EGqQAF4v1c7BovnKGNBpg1mVT6gIc6vQVniFR/y94kjU+3DdNryeAk58=
X-Google-Smtp-Source: AGHT+IHBcGBv97yqXC1II5Ix1onhTrpJagjB0ibZGEXN6my9qc0EYW1Y+PYnB4ikwCdSQkl4/++2ew==
X-Received: by 2002:a05:6512:3f1a:b0:52c:7fe3:d3e5 with SMTP id 2adb3069b0e04-53546bb0855mr7068398e87.50.1725294584621;
        Mon, 02 Sep 2024 09:29:44 -0700 (PDT)
Received: from LQ3V64L9R2.station (net-2-42-195-208.cust.vodafonedsl.it. [2.42.195.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feaf3fsm579944366b.40.2024.09.02.09.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 09:29:44 -0700 (PDT)
Date: Mon, 2 Sep 2024 18:29:42 +0200
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: napi: Make napi_defer_irqs u32
Message-ID: <ZtXn9gK6Dr-JGo81@LQ3V64L9R2.station>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240831113223.9627-1-jdamato@fastly.com>
 <CANn89iK+09DW95LTFwN1tA=_hV7xvA0mY4O4d-LwVbmNkO0y3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK+09DW95LTFwN1tA=_hV7xvA0mY4O4d-LwVbmNkO0y3w@mail.gmail.com>

On Mon, Sep 02, 2024 at 03:01:28PM +0200, Eric Dumazet wrote:
> On Sat, Aug 31, 2024 at 1:32 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> > napi_defer_irqs was added to net_device and napi_defer_irqs_count was
> > added to napi_struct, both as type int.
> >
> > This value never goes below zero. Change the type for both from int to
> > u32, and add an overflow check to sysfs to limit the value to S32_MAX.
> >
> > Before this patch:
> >
> > $ sudo bash -c 'echo 2147483649 > /sys/class/net/eth4/napi_defer_hard_irqs'
> > $ cat /sys/class/net/eth4/napi_defer_hard_irqs
> > -2147483647
> >
> > After this patch:
> >
> > $ sudo bash -c 'echo 2147483649 > /sys/class/net/eth4/napi_defer_hard_irqs'
> > bash: line 0: echo: write error: Numerical result out of range
> >
> > Fixes: 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> > Cc: stable@kernel.org
> > Cc: Eric Dumazet <edumazet@google.com>
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> 
> I do not think this deserves a change to stable trees.

OK, I can send any other revisions to -next, instead.
 
> Signed or unsigned, what is the issue ?
>
> Do you really need one extra bit ?

I made the maximum S32_MAX because the practical limit has always
been S32_MAX. Any larger values overflow. Keeping it at S32_MAX does
not change anything about existing behavior, which was my goal.

Would you prefer if it was U32_MAX instead?

Or are you asking me to leave it the way it is?

