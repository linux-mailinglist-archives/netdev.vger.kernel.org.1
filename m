Return-Path: <netdev+bounces-145214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 765999CDB50
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169B8B22E43
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8537518FDC8;
	Fri, 15 Nov 2024 09:16:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA2318FC92;
	Fri, 15 Nov 2024 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662193; cv=none; b=ICGH3uyd/S2ODVqVhbO37TCgzRIB6VdoVs+C+0LCVfa2gHbxaT5lln/lSyAnVvIWQDiKx8j1+en/gD7KydHKKBSlkeEhSwhr5FN6mKj9Eoa1jRlf7QeMIC+MnmRoPfpKxjgPD30WGZo3ULo6UbRs11D0wiJ8580AJEVRdRTIVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662193; c=relaxed/simple;
	bh=dyPkdLpUfXDOK1yrYRW6owXeDxKrFxkeaRDPQLniLxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRVva9jQpt+3dX2EDwn9Ph2RU56UBsZ0hToVb3MMTs3+L/wpwMGbSWZUQpY3SSDGdAmm14TDxG0y2JVxYkEuSDiAR3sylxNgKSGGuOEk5OoOWb2GhgXSUHbNtqBzDa07QU/9EtsvBvZvkxYqLdMaJjvkxV2WMkwSrdEc644xoHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ed7d8c86cso94976466b.2;
        Fri, 15 Nov 2024 01:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662190; x=1732266990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1YCJ4GAnRyuvlUQb0fCuSFp/2mSZlhiUxYRKGG5sWI=;
        b=q2GqjB2Ry5FalYXmyDinau/g11RZh2qnPNYN6+uSIzARsQabcrSfBj0tcG5I11neLz
         sLZytF1gp0yisZ1AA/lbeXiY3Y59sOFoBGhJnIACjYjwk/d2nCB6bCvmzwfT7jpWT6tn
         cFWgN51HUksrEeLBinPQGcgnCM4pyNHWIsgw64aGC4qm1gfmyaZvNB6d+D4tt3ZZ9qJo
         bQyI2CsddnxtF+8egO+IgL3MspSqWwC+m761qFnK8XICrn5/Z/GKb+UPcNN8y/H6MGEe
         Btzfmh7EAsP7jC5dPXZNu8Y7zUmfkv/YNukOxA+5o6xZjQBzeBykefY2V91PXZMQ3ioT
         bXxA==
X-Forwarded-Encrypted: i=1; AJvYcCVIwSqH/IIY0z6xHpLxo8172jGQ3acVNKfBi2hlOg6qN3OlhHCpl5otL/jOjlqW0Ydi/WH8aDMjvjZtlWk=@vger.kernel.org, AJvYcCWWNylOVTtkGvABhEbXEX2zw3z3vq81+kV2n0HkNgfZld+KA7YuRJUKoAAnOsE6SCTVHKZHOLHK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3vVBrUdXGNoZDNIiSDbIF7SUA2dqMm+1a/b94mxYk3RpkFMMe
	tYnQn83njkRfe60LPs1WNPM0/qlOsOTGr1in3wrR/Ne6rEhY1XNxkW8cUw==
X-Google-Smtp-Source: AGHT+IGNU3XxE6ca1qfJzJ60Vxc/ZS1iQh+1Bya1oIiyn1mGGmJ1u+8EqVjj6K4K9A41x8ZqjNVDgw==
X-Received: by 2002:a17:907:981:b0:a9e:447b:6f76 with SMTP id a640c23a62f3a-aa483454450mr157810666b.31.1731662189856;
        Fri, 15 Nov 2024 01:16:29 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dfffcbasm158825066b.111.2024.11.15.01.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 01:16:29 -0800 (PST)
Date: Fri, 15 Nov 2024 01:16:27 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, stefan.wiehler@nokia.com
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net v2] ipmr: Fix access to mfc_cache_list without lock
 held
Message-ID: <20241115-frisky-mahogany-mouflon-19fc5b@leitao>
References: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
 <20241113191023.401fad6b@kernel.org>
 <20241114-ancient-piquant-ibex-28a70b@leitao>
 <20241114070308.79021413@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114070308.79021413@kernel.org>

On Thu, Nov 14, 2024 at 07:03:08AM -0800, Jakub Kicinski wrote:
> On Thu, 14 Nov 2024 00:55:57 -0800 Breno Leitao wrote:
> > On Wed, Nov 13, 2024 at 07:10:23PM -0800, Jakub Kicinski wrote:
> > > On Fri, 08 Nov 2024 06:08:36 -0800 Breno Leitao wrote:  
> > > > Accessing `mr_table->mfc_cache_list` is protected by an RCU lock. In the
> > > > following code flow, the RCU read lock is not held, causing the
> > > > following error when `RCU_PROVE` is not held. The same problem might
> > > > show up in the IPv6 code path.  
> > > 
> > > good start, I hope someone can fix the gazillion warnings the CI 
> > > is hitting on the table accesses :)  
> > 
> > If you have an updated list, I'd be happy to take a look.
> > 
> > Last time, all the problems I found were being discussed upstream
> > already. I am wondering if they didn't land upstream, or, if you have
> > warnings that are not being currently fixed.
> 
> https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/859762/82-router-multicast-sh/stderr

This one seems to be discussed in the following thread already.

https://lore.kernel.org/all/20241017174109.85717-1-stefan.wiehler@nokia.com/

