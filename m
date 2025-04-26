Return-Path: <netdev+bounces-186215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4E6A9D73E
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 04:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8635E7B6240
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9E91E0DE8;
	Sat, 26 Apr 2025 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="l2UntJO0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA4A7081F
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745634717; cv=none; b=Su6BvO3GIBBQooQ5ZZRFgAzjS0sqTv3U/yf1/GlujIyCkTUzj4I917mHSv6bOQcU/MWUNKsOH8FG+xd8S4AxpFXU92vktbRVP8YpaBu5j8wMQgNEx/nKoWH4F6lg35DdS2oSjVRlbOkyo9Jp5FiXPH4sumc0YIOm8uf4cKSV9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745634717; c=relaxed/simple;
	bh=vw61EsCiadYJwzBe3pawkMbBGEqpx1614S3drBhRuM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvJlCA3dpKIR0h2ISBeDSHS3DeH74Pr41sfxDONPY1bIEA0zpQ9/011ija6RFYPGPc8uQPTLg+pJYCbNuKYatIUhyb34mXCv65nE4JHkkxUjtGcIV1qm9jI4u4eZjkARV12KAc306thZBELVxYPdkXwLYFvzzWEUhidotH0v8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=l2UntJO0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399838db7fso3081973b3a.0
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 19:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745634715; x=1746239515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=og7pJj8xGMYdRH6kIetSuyf/jqDm6stfiP6OGIAoADc=;
        b=l2UntJO01qbg5lJ6rTvoomqyyBlJm4Tatr9aB4Pl1OW56d1YBOgt/sgBgdXRtruyvE
         xVQg3X+HojmqGoZ3fJSQpvqlRHJkJcfDYFMJ1VcU6e5/U3xhG4MlxQ/gscXRlVhZByBU
         M6nVW2XEa/HOj6fdfxXjP7fkmDHKltAzn5xN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745634715; x=1746239515;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=og7pJj8xGMYdRH6kIetSuyf/jqDm6stfiP6OGIAoADc=;
        b=uvbndeNWl5R+ELpUSwWyJ2arXzQUuTAHbsdfFNz2whXmp0gb/gcrL3NdVp2OYVT4CD
         dQAQkdlGYFPCcipAcx9HE7FFRPQ67A/OOL5udkuscjfr+ezoj0tuVD23l8lcl8l6hUzC
         /tCeiWBlRiuMUi5hyxvHJd5UyaIdnFP/rvslarH6HmWeve950Fk1h97GboVTMXM7QeMK
         a14KYYJCf71BmftAq+pMuK0mqizEZA87kOXl9QaA8ImM+hMEoTLJB+h+s1m1ZxtXMLee
         W1uQeNBWbA6K0X7VhERmYEwXI4+RjR9My1X8i6hmUBJbwyfknyZ7vm/jiGJKg5WVjobf
         dKpg==
X-Forwarded-Encrypted: i=1; AJvYcCUIglKx4E1ten8/yyTeANpp3U8H3Zrz/WoiA54snrETJMFt6Zw/KVVTg2yXslLFhC3zqTbDSoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3/JBUkTj9uJSfycvGoEO00HD4j9RXyYgFUFY4/IlrqSgHY+hA
	8GFDn8T9vnh2R1JE1PuF7KBtaKkllJvoqU+PAL9M5DHeVV9QIIbslH3UAPfgu97DU7eqL/h5tSU
	P
X-Gm-Gg: ASbGncuPq71/Q9eFZXU83ItKaBjmfZYPld3x2GaMzRtyssi+2lr70mWzGwuBa839V78
	HIU/1JR/q4E7jU1lfPep1irSxz1hYWPeFxt5ze8fJzQajy+FeIv4k6O/uBo2Kiv9qkDC0VHsU5y
	U57V7GW4FFeRzjwZeH2o5L8jwiR8iAfHNLyExd7C2637FjAyc9pMHluAgNxeXm6A5tTe1V+OIUZ
	o6KMJhPnbywoDYZ5IQJytJxLeFg7xk7h18IAEmT9NXzyUBYtSMX0cqiCQOQsE1L9om3gxqoXqY1
	Lg0l3q0JDgDkhGkEd+/lLr9jj7VREr7ZgJ7AG+m89fPl86lkO5T72yPC2KrBGJYbCTXp5SJhfgC
	1pp82MfyTK4nj
X-Google-Smtp-Source: AGHT+IF9S/lOfMmqeIlQOQcwCj+0Na13T9A7AaneT42zkvxtHZ4RCV9+PdevqDKEHdfJZsAeKGV03Q==
X-Received: by 2002:a05:6a00:98e:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-73fd519c414mr7051045b3a.2.1745634715047;
        Fri, 25 Apr 2025 19:31:55 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25accfbesm4021104b3a.177.2025.04.25.19.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 19:31:54 -0700 (PDT)
Date: Fri, 25 Apr 2025 19:31:52 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <aAxFmKo2cmLUmqAJ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250423201413.1564527-1-skhawaja@google.com>
 <20250425174251.59d7a45d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425174251.59d7a45d@kernel.org>

On Fri, Apr 25, 2025 at 05:42:51PM -0700, Jakub Kicinski wrote:
> On Wed, 23 Apr 2025 20:14:13 +0000 Samiullah Khawaja wrote:
> > A net device has a threaded sysctl that can be used to enable threaded
> > napi polling on all of the NAPI contexts under that device. Allow
> > enabling threaded napi polling at individual napi level using netlink.
> > 
> > Extend the netlink operation `napi-set` and allow setting the threaded
> > attribute of a NAPI. This will enable the threaded polling on a napi
> > context.
> 
> I think I haven't replied to you on the config recommendation about
> how global vs per-object config should behave. I implemented the
> suggested scheme for rx-buf-len to make sure its not a crazy ask:
> https://lore.kernel.org/all/20250421222827.283737-1-kuba@kernel.org/
> and I do like it more.
> 
> Joe, Stanislav and Mina all read that series and are CCed here.
> What do y'all think? Should we make the threaded config work like
> the rx-buf-len, if user sets it on a NAPI it takes precedence
> over global config? Or stick to the simplistic thing of last
> write wins?

For the per-NAPI defer-hard-irqs (for example):
  - writing to the NIC-wide sysfs path overwrites all of the
    individual NAPI settings to be the global setting written
  - writing to an individual NAPI, though, the setting takes
    precedence over the global

So, if you wrote 100 to the global path, then 5 to a specific NAPI,
then 200 again to the global path, IIRC the NAPI would go through:
  - being set to 100 (from the global path write)
  - being set to 5 (for its NAPI specific write)
  - being set to 200 (from the final global path write)

The individual NAPI setting takes precedence over the global
setting; but the individual setting is re-written when the global
value is adjusted.

Can't tell if that's clear or if I just made it worse ;)

Anyway: I have a preference for consistency when possible, so IMHO,
it would be nice if:
  - Writing to NIC-wide threaded set all NAPIs to the value written
    to the NIC-wide setting
  - Individual NAPIs can have threaded enabled/disabled, which takes
    precedence over global

But IDK if that's realistic/desirable/or even what everyone else
prefers :)

