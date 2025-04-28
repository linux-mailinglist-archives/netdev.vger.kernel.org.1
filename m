Return-Path: <netdev+bounces-186568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF24EA9FC30
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6037A30E0
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 21:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB071F872A;
	Mon, 28 Apr 2025 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hp0gO9xh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ACF1632DF
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745875749; cv=none; b=kIDYVndXQwstGXGOeZud64gmLTKLJD+4Tgob6s8WmttiXC8XE/IiTSaJKwgI5zGprl1Vjox81lrKjN2NzLY4MnwkwzfmN5PPszzZGQ/FIxLtjKUDsY+6UMUe/hmIjNkJDR6f/4c1ZCkDE0xJ51gg4CCl+02sqjRVDtrlXwXjM3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745875749; c=relaxed/simple;
	bh=6daYzCFNPaMnx/9IuC4EuT+qbQSxbyCaEef4hqm7f8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNgTK5hUVdA5B2oLx8LLv5yUwDsHnJcw3hHTE8P9cA0JspCGqc3ji3zb3tF91N9jU8cOl8XF2J2Z+PyhWJWLyPdGkiwUd2ylGYCEsFtBqAWs7J9DIiCmS67su6KzeMrXDxMXLRWjxbLrS0aheaPQdRmR2N9wxe2+TEHgO//iTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hp0gO9xh; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7398d65476eso4286163b3a.1
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 14:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745875747; x=1746480547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK8CWFUBdl8KWi4Fr0zEZzn/+N4/xQi+gPLyrPKDzik=;
        b=hp0gO9xhBUh9aGo3yO8aI/uEb3CboTj+tg/Ai3D1jI4KBpahU/uauq8R55b3LbWqZP
         2VVA/o6eaMxV6+UemggevJcMhZjezAa+31J3JAhG9MpYw9HwO3Oew66H2D+YEvxrCofO
         JNEKkCjdNJRIkZInwIofXfUhwkSDdo9+KndiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745875747; x=1746480547;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FK8CWFUBdl8KWi4Fr0zEZzn/+N4/xQi+gPLyrPKDzik=;
        b=wSjzsHvtjIJNFEhlU6jlrT1knHuMwoPOpnjJdjrcCdHv4rLcVpEPsNeh69uPT3XvTe
         bs9F6ka9bW2Szxh0YF4ZRaKT7kxsC7TJ3GLLSP2dsHPKjpXyQBhQrg6egQYHX0iDWPGW
         5OTN7oM2l14FTok6kyZYSDj2jz/StwMclW9ja5vYo6VNlewu0cuXiyUqC80mUXpVFB+t
         yDNnn+00gCf1fJNfIlFb+tyas9DJT9vYoXc3iaVlQF4g2rP5QPX/88XEIj9e2m6e8RJ/
         CRO1XugPrpMpgjY5CtN8kHULSEb3POTWeyK2LxeyLohDgUsqJqTtYpVU6OThtNLL+pob
         If3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtft+SkZpV3eEg2vUIUDFs0JYnosesnHcAaMLn5ZU6RcgTlBqhfis8XPHc7cUXM7NK3rlbuH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8C5gBddGxFnwdah5SP+XaBFOTWpGqf6W6DvpvYsm4j9SJpS9
	Kz+OiKBN9crTdWwucCxc8cVK6/ueuNYy03YuYkIelLoKDuUbATvFKuCODA3WeSA=
X-Gm-Gg: ASbGncvFE6EyF2Q6S6JeNsOVIXHgrdzmArqeWhi80HPhLTB1C5hR/KOAywA0txUlS2u
	Il4PY8zXvhmknJBVzLWF7H7iXKs829yx57a8uW/9nGSveTZlNccJuGKPCFVlBOckeW+xNf+cTYy
	NY/FKR+vpKqi73fZeNPruLf6QuAZpO2ZccoEr2eVAuzIod4kmiIGzxKdhxPHBac89nuumCZx0ev
	VdELHgWfwyKni33agUgYwpYLGBYmmIIeXP4Z/fwsmXBMK6dhsJ/bHob67XoI/PySmzd2UfcgJZv
	Y2qjn2la27NIpeATaWl1Lec6ghCVIh+NFcFrwpJVA+P/s+beIJrs4hdpYAum0X4BJlchHFKVXkB
	hGU3hnLqKDSJ1oqed2g==
X-Google-Smtp-Source: AGHT+IGghGyQxhXqnud5sm7MNXGhV9/+04eLc/SKFYKb0L25hxe3K3KxtPAxICCswZE+EHjkJy1diw==
X-Received: by 2002:aa7:8549:0:b0:740:6f6:7338 with SMTP id d2e1a72fcca58-740289ea08emr859490b3a.3.1745875746907;
        Mon, 28 Apr 2025 14:29:06 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25acccd0sm8815930b3a.178.2025.04.28.14.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 14:29:06 -0700 (PDT)
Date: Mon, 28 Apr 2025 14:29:03 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <aA_zH52V-5qYku3M@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250423201413.1564527-1-skhawaja@google.com>
 <20250425174251.59d7a45d@kernel.org>
 <aAxFmKo2cmLUmqAJ@LQ3V64L9R2>
 <680cf086aec78_193a062946c@willemb.c.googlers.com.notmuch>
 <aA_FErzTzz9BfDTc@LQ3V64L9R2>
 <20250428113845.543ca2b8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428113845.543ca2b8@kernel.org>

On Mon, Apr 28, 2025 at 11:38:45AM -0700, Jakub Kicinski wrote:
> On Mon, 28 Apr 2025 11:12:34 -0700 Joe Damato wrote:
> > On Sat, Apr 26, 2025 at 10:41:10AM -0400, Willem de Bruijn wrote:
> > > This also reminds me of /proc/sys/net/ipv4/conf/{all, default, .. }
> > > API. Which confuses me to this day.
> 
> Indeed. That scheme has the additional burden of not being consistently 
> enforced :/ So I'm trying to lay down some rules (in the doc linked
> upthread).
> 
> The concern I have with the write all semantics is what happens when
> we delegate the control over a queue / NAPI to some application or
> container. Is the expectation that some user space component prevents
> the global settings from being re-applied when applications using
> dedicated queues / NAPIs are running?

I think this is a good question and one I spent a lot of time
thinking through while hacking on the per-NAPI config stuff.

One argument that came to my mind a few times was that to write to
the global path requires admin and one might assume:
  - an admin knows what they are doing and why they are doing a
    global write
  - there could be a case where the admin does really want to reset
    every NAPIs setting on the system in one swoop

I suppose you could have the above (an admin override, so to speak)
but still delegate queues/NAPIs to apps to configure as they like?

I think the admin override is kinda nice if an app starts doing
something weird, but maybe that's too much complexity.

