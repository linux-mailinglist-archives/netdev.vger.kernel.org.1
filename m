Return-Path: <netdev+bounces-214129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFDFB28539
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DA7171A39
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441C43176FA;
	Fri, 15 Aug 2025 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="LeKaBqFb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B446F3176EC
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279446; cv=none; b=T/VWd5XU92wxoGdm3i5g/NpaL+j4sHobNXMzodDthefUTgccLym/7AymDeVY1gtRZN2VQWzYbKu6CULFiR41QSbsgbm+v2DtF4OUxBlwSU4ZZZlx0lyq98VZDrdX17Ot1nZeBrKMACgwBVuPWEESAqYB1qChrel6KpvmhzTOLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279446; c=relaxed/simple;
	bh=EZaKhemVJPR3sq5XowvTLO9YcYMWZSlYjjnux2apyDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw+2vvY8zmQ2ucwQGAHDnHAINsFlFhkhLpVzGvkFp/q2MwnbSWHKn6NSmm2n9qZLn5LHiO4BM7dupzj1Yneeav0pLgDhGatlSCjvuvtnxzOAwURIkxvhLGnngUkrl/PfDax0hUbvV/uc/JLN5NGWjBoW30F4jW5G9vL5KGWe+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=LeKaBqFb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32326e69f1dso2382246a91.3
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755279444; x=1755884244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8VgHIJEM7JM7qYl6oFnfKU/T+pMHjuErX1yO4TYSJrk=;
        b=LeKaBqFbSZA3wUvjGMh/OpDhJW4jjvc6uxDXT9LRCWg+ZzcXldRvSuImG1j557ukYs
         BU6OwdS9/QisWdl87VpSw4B40qtIITCdMgs0biznP7zluXHnktQ9OgYT9Hd8nzGEt6To
         QW5azGxjwhvQjm//G5WkwW0q5y22muDkXhSH+0Ikxp3cVHRGzl+dlfH8WaDuwugzma+7
         Kidc0WW/6kv27Za2qQJ4ULbeii5imtZFy1FJUXNx0UGQHgiSx+UbIxkee9Apa0G/6N0C
         i8Q93u9TDXlOwxnbIi2DfvxNUJDr8W0DqBOTNU0DF3+nA46rtgTzFvkpuIXscEaZqOHD
         lSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755279444; x=1755884244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VgHIJEM7JM7qYl6oFnfKU/T+pMHjuErX1yO4TYSJrk=;
        b=AmDip1EHzYe4KsH6zBMYDb1Ml1+eTGtMJS/msGNXHqnB4zadVNwvIOHc8VjNzrFCOg
         drUZsdU+kglvtw+sueXt4UQd5XaHm6tydRxzyYlvuMYoB/NI35VEQwzbNwuh65O6sZfD
         MIKuf6qHw+WatVQq9V0H4/JAY6ATQGyEqH2rj3EkkfcSsheI24P/TFEjDSAO64CJLnbB
         /pDadIoGKUPC31aytfxix/Dv/nFiUSa9vhkMXgX1o2QEcrnQXiW8b5xthupF/kshmljy
         LchGTnNeHIKOI6R3rWMjYRsWb9fdDQsx0zF5RQOpv59M3jM68CPoTUYnDlrJrUIddYbZ
         7S/g==
X-Forwarded-Encrypted: i=1; AJvYcCX4FYlIsomluGPqh16tqtIEvESm4UhS5Dac9W1nIc4RbHlQaspBvjWALa47sqmDsv4EPSmbnCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9qVjZSz0Zo67ExK1ZUNtmreck4TTeHDc6bZ6hThQyml0IVTyX
	d8vYxXzmHDl/K/bvrttk3KgnjBsQpiEAwMb4SxfqAE2jQSOj5YY/8id2UzkC9/7vpT8=
X-Gm-Gg: ASbGnctxVsGBowpWXDjPWjp1DY3D064TXH7fyjegBmBxVBFBisilSSF42UafU6acL0i
	vIhmRwguOkJNCka/pjDXVp6tn574XJ6KAt23VKpVdkfsHiZLy/rI+QD2j638bA73SWGRCvCogO6
	++OJDVWDnDBPyPwpq/Z4PqJQI5jKtx2Pty5iA76kQy79dKUQKfpnC30ryfEe6HiuLZIwd5mY1n/
	fNUnbsKrM1V5RotarU7e1PjCyuHn4fVbMRHrk1/Z10wI1cM2EiSTadr8fsOKIr6POhEWLKxGD5w
	zNFCFocgau1vV9VNDY91Gcw/v2j3XJ8hI65RvDTQrUmWm356Z88oZ++9VD4A1EpZjg9v4BpJ54x
	ZhPUkvfWkC5BZ9kFxrvi/0Ll7
X-Google-Smtp-Source: AGHT+IEzUlJW393LwpN228NDGcrlLOOrIrGuJW5vYjizbAfS8DKPO5gF4B6eusG0NuaiUrpfH4afSw==
X-Received: by 2002:a17:90a:dfcc:b0:31f:eae:a7e8 with SMTP id 98e67ed59e1d1-32341ebf8a0mr4878804a91.11.1755279443694;
        Fri, 15 Aug 2025 10:37:23 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232ae14f6dsm1947455a91.6.2025.08.15.10.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:37:23 -0700 (PDT)
Date: Fri, 15 Aug 2025 10:37:20 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>,
	paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	netdev@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <aJ9wUAZRzqX5361i@mozart.vkv.me>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
 <20250814172326.18cf2d72@kernel.org>
 <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
 <20250815094217.1cce7116@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815094217.1cce7116@kernel.org>

On Friday 08/15 at 09:42 -0700, Jakub Kicinski wrote:
> On Fri, 15 Aug 2025 11:44:45 +0100 Pavel Begunkov wrote:
> > On 8/15/25 01:23, Jakub Kicinski wrote:
> > > On Thu, 14 Aug 2025 03:16:11 -0700 Breno Leitao wrote:  
> > >>   2.2) netpoll 				// net poll will call the network subsystem to send the packet
> > >>   2.3) lock(&fq->lock);			// Try to get the lock while the lock was already held  
> > 
> > The report for reference:
> > 
> > https://lore.kernel.org/all/fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de/> 
> > > Where does netpoll take fq->lock ?  
> > 
> > the dependencies between the lock to be acquired
> > [  107.985514]  and HARDIRQ-irq-unsafe lock:
> > [  107.985531] -> (&fq->lock){+.-.}-{3:3} {
> > ...
> > [  107.988053]  ... acquired at:
> > [  107.988054]    check_prev_add+0xfb/0xca0
> > [  107.988058]    validate_chain+0x48c/0x530
> > [  107.988061]    __lock_acquire+0x550/0xbc0
> > [  107.988064]    lock_acquire.part.0+0xa1/0x210
> > [  107.988068]    _raw_spin_lock_bh+0x38/0x50
> > [  107.988070]    ieee80211_queue_skb+0xfd/0x350 [mac80211]
> > [  107.988198]    __ieee80211_xmit_fast+0x202/0x360 [mac80211]
> > [  107.988314]    ieee80211_xmit_fast+0xfb/0x1f0 [mac80211]
> > [  107.988424]    __ieee80211_subif_start_xmit+0x14e/0x3d0 [mac80211]
> > [  107.988530]    ieee80211_subif_start_xmit+0x46/0x230 [mac80211]
> 
> Ah, that's WiFi's stack queuing. Dunno whether we expect netpoll to 
> work over WiFi. I suspect disabling netconsole over WiFi may be the 
> most sensible way out. Johannes, do you expect mac80211 Tx to be IRQ-safe?

It'd be a bit of a shame IMHO to summarily break netconsole over wifi:
it works well enough in practice that I've personally found it helpful
for quick debugging across large numbers of IoT devices (user context
OOPSes outside net/ usually seem to make it out, as do WARNs and other
non-fatal splats).

But if Johannes' answer is "no", maybe there's no way out :/

