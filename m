Return-Path: <netdev+bounces-186244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41D3A9DB7C
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 16:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD6D17E77E
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF6E253F24;
	Sat, 26 Apr 2025 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyJde0sy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C757A31
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745678475; cv=none; b=LMJcAupVhXNThL9hXK8nHH5lX+Zwd4bvSQvuxcYdUGqCKl5bY7CQdWPxIzogBIIbJZEwPyZOz5BTwjYaVbQiBMDypCe0nnFHT2PXExVlSNOdq5odlTkyzrS2H+ll+k47mEATBMsLh8r+D6QvEOvQMW4Stb3YZwJbkP/gWcT3yjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745678475; c=relaxed/simple;
	bh=3MChHGIAxr2wCLjOEGjVktjQkHTwOLlF05+KbxFU138=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VTcuepWlIHpAMNDZ2dNuFMwDyPPUYL/Qq2G6IOxhNf7fPPkBjHYEwnbqaQ1acBnJPCLpYpEfp3OCLy2orf0ON4h1phTng+X6+SG3BlJ9/NDQ8RuP0+MrE+aWX5KbVC06TrtkMndSfZe7Frl8cnOPKPwewUmdgqwJVIPrINISsy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyJde0sy; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47690a4ec97so38929711cf.2
        for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 07:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745678472; x=1746283272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPGLmeChCi55yYwofeq9TWGMEgD3TCkdRzlZw8FAJwY=;
        b=IyJde0syrwZKmR/bX6xzgIKET3GKmUMiLWztmjcvl0IDJNa32HiB73Gegq/b+wgBKN
         ez5WVBN94dhXHWjBFxzIu3FFpjPogV9Rp1lzAsFPfGguSjQ7Cfb0IIpfseudZinRTLos
         QTPfthBPEStDgJ3eFovwztvwiignMsl5YviT6jAvazcGo0mIFeoqfNAUZDW94bb7zNx0
         lz1xXmJwK9rNzPi5/m93khYQzPa8Lo/1qOV7F5ZgWxOErNfgMmCDIQecgxpqGFLMOxhU
         u61F8IRdJ44DsF+0DxvJd53mhOOgWyWbU3/2V5Je2vLqZ2uPnn6neUKke/QvdLU96z+G
         +4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745678472; x=1746283272;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FPGLmeChCi55yYwofeq9TWGMEgD3TCkdRzlZw8FAJwY=;
        b=cZEQBoXCqW/m6MliShaHm1ObkSBWPKQtnUadD8443gAAnCBSMKw6evioBamabomtgL
         L1GntewewNi4bjh6kw6HUtSSlJGrhAJzHWPtNI7V0dEX1Psw6T8FqoUmUG8/Nxm8IhpF
         m8iMY1jdNiTfSQGpgPRE6UPMYhHtzRPu7x4QUJMjIqyT973lXGBqftPgqOwXHY1Nz3s8
         vbXBTRAMyY/DAfanMPkamy6VoQtvFh642tMzaDdvSHx6FoAH1OkTGbqj6fbj1C34EfML
         12eMIe35I/qpqTpDJVOLgvrIT9GzPdBvY/0NnNXy6FbYejHeASXeUsQMVpSwYDO1IZHl
         Rwlw==
X-Forwarded-Encrypted: i=1; AJvYcCVouF6vW67Zzeb6SV+0xaZZsvDRNvUXzTE9Uk1j6h1Z0it7gO7PxpMnc+WQfryOwPwEokTk5+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVGEdHrYo6ExLn/zpCMOfU59Wb8sqtQ0DW7kTtpgnwQqvvxrq2
	ayKgL3PFh0bfl6EzEqmRwgizZUOje6gDC0F/OLxbzSXOihDnhqkd3QLasg==
X-Gm-Gg: ASbGncup61GTNrbpGnyadNrsPKIXhlW2qPJ15Ce9C+D3XaIyoVtSZTF+/WKM9fooeCo
	H4xk80CQQ3rSiZVxortAJRpL3eD8xsB3SqtuEnoP6eIQe+Gb8hD1i+NfHbOkkBRUqKReh9PMJ93
	q3hBfHhjJeSXnA++0z06+tfBVoyGg3xit8onta8PsUP8szF5XEusFQiQiGnF8yXKgURteVPmRns
	sH6upUW9Ou70A4ogjFexnJ2ymhtK1cWBXfIZ/IVN58Z4QmiwDcPTkomWt1Lqnv808GSFZf6NqL0
	DxGQufBQhsVbCSFBXnCSlYfmSd9mWSDhYERnf9NLKYtiHzVCjiTGP3RH8IgdZntPIIHJcCAOCFZ
	BhlnuGdDhnj0hbUzugBYx
X-Google-Smtp-Source: AGHT+IHhW7jcgU9hx5LwLhK1Yyr5bl/qI1KK8nMxsEiWyb6eWDuc1eNStbd+uYMTpLoB5GqZ4D4pxA==
X-Received: by 2002:a05:622a:1a21:b0:477:1e66:7442 with SMTP id d75a77b69052e-48022b3c111mr111669541cf.5.1745678472033;
        Sat, 26 Apr 2025 07:41:12 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ea1693378sm39676171cf.64.2025.04.26.07.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 07:41:11 -0700 (PDT)
Date: Sat, 26 Apr 2025 10:41:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <jdamato@fastly.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 almasrymina@google.com, 
 willemb@google.com, 
 mkarsten@uwaterloo.ca, 
 netdev@vger.kernel.org
Message-ID: <680cf086aec78_193a062946c@willemb.c.googlers.com.notmuch>
In-Reply-To: <aAxFmKo2cmLUmqAJ@LQ3V64L9R2>
References: <20250423201413.1564527-1-skhawaja@google.com>
 <20250425174251.59d7a45d@kernel.org>
 <aAxFmKo2cmLUmqAJ@LQ3V64L9R2>
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> On Fri, Apr 25, 2025 at 05:42:51PM -0700, Jakub Kicinski wrote:
> > On Wed, 23 Apr 2025 20:14:13 +0000 Samiullah Khawaja wrote:
> > > A net device has a threaded sysctl that can be used to enable threaded
> > > napi polling on all of the NAPI contexts under that device. Allow
> > > enabling threaded napi polling at individual napi level using netlink.
> > > 
> > > Extend the netlink operation `napi-set` and allow setting the threaded
> > > attribute of a NAPI. This will enable the threaded polling on a napi
> > > context.
> > 
> > I think I haven't replied to you on the config recommendation about
> > how global vs per-object config should behave. I implemented the
> > suggested scheme for rx-buf-len to make sure its not a crazy ask:
> > https://lore.kernel.org/all/20250421222827.283737-1-kuba@kernel.org/
> > and I do like it more.
> > 
> > Joe, Stanislav and Mina all read that series and are CCed here.
> > What do y'all think? Should we make the threaded config work like
> > the rx-buf-len, if user sets it on a NAPI it takes precedence
> > over global config? Or stick to the simplistic thing of last
> > write wins?
> 
> For the per-NAPI defer-hard-irqs (for example):
>   - writing to the NIC-wide sysfs path overwrites all of the
>     individual NAPI settings to be the global setting written
>   - writing to an individual NAPI, though, the setting takes
>     precedence over the global
> 
> So, if you wrote 100 to the global path, then 5 to a specific NAPI,
> then 200 again to the global path, IIRC the NAPI would go through:
>   - being set to 100 (from the global path write)
>   - being set to 5 (for its NAPI specific write)
>   - being set to 200 (from the final global path write)
> 
> The individual NAPI setting takes precedence over the global
> setting; but the individual setting is re-written when the global
> value is adjusted.
> 
> Can't tell if that's clear or if I just made it worse ;)

That does not sound like precedence to me ;)

I interpret precedence as a value being sticky. The NAPI would stay
at 5 even after the global write of 200.

> Anyway: I have a preference for consistency

+1

I don't think either solution is vastly better than the other, as
long as it is the path of least surprise. Different behavior for
different options breaks that rule.

This also reminds me of /proc/sys/net/ipv4/conf/{all, default, .. }
API. Which confuses me to this day.

From the PoV of path of least surprise, minor preference for Joe's
example of having no sticky state, but just last write wins.

> when possible, so IMHO,
> it would be nice if:
>   - Writing to NIC-wide threaded set all NAPIs to the value written
>     to the NIC-wide setting
>   - Individual NAPIs can have threaded enabled/disabled, which takes
>     precedence over global
> 
> But IDK if that's realistic/desirable/or even what everyone else
> prefers :)



