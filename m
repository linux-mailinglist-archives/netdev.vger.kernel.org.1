Return-Path: <netdev+bounces-159365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F7DA153EE
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED9E7A022C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F35189F3F;
	Fri, 17 Jan 2025 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNNrxjYT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A11946C7;
	Fri, 17 Jan 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130421; cv=none; b=oXpux3bgA7sahsZU70IxszVUpeeSKbegFSLOIDoJEK9UBIYVoO8X7DtsdK35qFdLR92yiSaI7cgt0BFDOmEYhLybu4Q3BbZzxaSgCIwaVcG76trvIU+O512pdlVvg42H+B2f2DnJ2tM1w1vAPSG6SyfA4RFjNSD2MWZE6fRRsvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130421; c=relaxed/simple;
	bh=WqAOuqNLlt9pAYv+eprXOTHyXXfQBKBjKphozOSHGrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzyRI08tHqKXN3ZeIVoS2LBIKzs7c4LzAXBifgjAvPHe2vKubm/llvgkmUi25ahgL4RAHEwTzd9PRRNW+wYDSlEI7rntpMku2YePNLe8QSwgLTXGfLH5IK58HBQffr0sKvAb1xM6XuHkE5yXVzJVAyoeDz+PVlyWR8ZWhgoHq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNNrxjYT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-387897fae5dso118274f8f.2;
        Fri, 17 Jan 2025 08:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737130418; x=1737735218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xTjtRazBFqm9mEa+dLp9hoPci+MoBLl8j76v97+I31U=;
        b=WNNrxjYTHKUU3hmtCpR5djIretXFKBklO6Hsd/Gg0lQc+iBpZL8dBBdD30jcKycd70
         PalFi/lao6s2IEurEfRIwGw21pAhtKgIcgIVwkILPoC+ZhBWf2FuC05uMa9yjy1Hn0p6
         dAc4GHexBFR7lRQMfB+x+bVenguR6U0GYtdb+DN79Q0D+DHGoD/UQFquxf4gfcxqeDgx
         UsYHvj1JoXVP7icTdkrmtVPzAJ6wipsWQyCpe5NfA6XDBnMR4lMp5ECkd7qfSQ3PcWGK
         kvfJv9AY0q35GNZTzB5SturIpNjworetvDhuvNOvi0Oz6o6NaahiQPaioItlImb1mzo3
         SOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737130418; x=1737735218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTjtRazBFqm9mEa+dLp9hoPci+MoBLl8j76v97+I31U=;
        b=q8tkKgv1qVLXJgCfVCNtEuhRLQ2baniFN5NWDkepx5a8lLOByM57sKGaNJnRk2cL/c
         c+JuQQ/A4VW+F7kfcDTxek9R5STjnGh95FBscMsXOv5BIeROXZ2QS3yuvg105Hqfnv5u
         8GMlIVLTV4TRdiTSbJDgSybGsw+TRVbyCeQGq+efQpkzI1Fr6kesjG0itVAfjkkZSIvh
         iKlxn/7Xl9hEnLoAUMaM2djmGP5KvEAL5GVr4/WaWk02al6df9Uh6usb66/015XdLsOi
         NwUGuybPMFfFmUzp/kECn8zbZNO1wzXG5ehawR3pEfAtpWa/IChdFh2jF4ox49XvHvSB
         vauQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSMSUvh3xKORRQRWd9dHYjPb8ps5+Bov/CUHO6gFzZ8hJ9zJZ+gQeawXJggw4XB+xs4NpbiA4hlJs1/+w=@vger.kernel.org, AJvYcCV9WsPgN/9aoUA3QnBeSOlELAsn3Y+WLSV/NMhS9pUgXDfbnIF/g1CQxLwNVoVRba0rfxu2aXKx@vger.kernel.org
X-Gm-Message-State: AOJu0YxI09fVhOU7SEIHhVs50nAi4Fl4HbwuZf0cyq/SKQ76biermMPY
	zFTvpqSdDHIoyJjK2o+PT6vlVOpyOAqhFWLW5Xo7edYJ36FMoxCk
X-Gm-Gg: ASbGncuI82dnyxhUrwUgj/ZUfVJN85RZ/qD+uHQERWquPE2NyVlgHkqAdY3EPZAWby0
	yn87GMJ/ycwDeUjV0a+1Wwfb/wTlDk1se4xMf5UisQHrRFUHdWv+3IimM5I0tILlv/WnK2iO9aK
	wBYAiyCCDl1FfNF6/NZRBag6vVrJ3uYKWQCGfWWVw6bTkVHxPY+gYgv99qKrZOOTgL7ISL3sXro
	rIojC+yR2lObKmCHH7OP9KI2/od7VKDa5mBrH9fo0dc
X-Google-Smtp-Source: AGHT+IGWl4bM3qjGz+hJyUh3VVukHKrhn0q8En+jf2UTaOMz51thBnLYmV5y/7ZNbywbFnwdexIjJg==
X-Received: by 2002:a05:6000:1863:b0:385:e9ba:ace3 with SMTP id ffacd0b85a97d-38bf56557c7mr1424034f8f.1.1737130417754;
        Fri, 17 Jan 2025 08:13:37 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327de8asm2802424f8f.84.2025.01.17.08.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:13:36 -0800 (PST)
Date: Fri, 17 Jan 2025 18:13:34 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Tristram.Ha@microchip.com, Arun.Ramadoss@microchip.com, andrew@lunn.ch,
	davem@davemloft.net, Woojung.Huh@microchip.com,
	linux-kernel@vger.kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, edumazet@google.com,
	UNGLinuxDriver@microchip.com, kuba@kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
Message-ID: <20250117161334.ail2fyjuq75ef5to@skbuf>
References: <20241212215132.3111392-1-tharvey@gateworks.com>
 <20241213000023.jkrxbogcws4azh4w@skbuf>
 <CAJ+vNU2WQ2n588vOcofJ5Ga76hsyff51EW-e6T8PbYFY_4xu0A@mail.gmail.com>
 <20241213011405.ogogu5rvbjimuqji@skbuf>
 <CAJ+vNU3pWA9jV=qAGxFbE4JY+TLMSzUS4R0vJcoAJjwUA7Z+LA@mail.gmail.com>
 <PH7PR11MB8033DF1E5C218BB1888EDE18EF152@PH7PR11MB8033.namprd11.prod.outlook.com>
 <CAJ+vNU3sAhtSkTjuj2ZMfa02Qk1rh1-z=1unEabrB8UOdx8nFA@mail.gmail.com>
 <55858a5677f187e5847e7941d62f6f186f5d121c.camel@microchip.com>
 <DM3PR11MB8736EAC16094D3BFF6CE1B30EC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <CAJ+vNU2BZ2oMy2Gj7xwwsO8EQJcCq9GP-BkaMjEpLUkkmBQVeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU2BZ2oMy2Gj7xwwsO8EQJcCq9GP-BkaMjEpLUkkmBQVeg@mail.gmail.com>

On Thu, Jan 16, 2025 at 05:25:49PM -0800, Tim Harvey wrote:
> On Thu, Jan 16, 2025 at 5:09 PM <Tristram.Ha@microchip.com> wrote:
> >
> > > Hi Tim,
> > >
> > > > Hi Arun,
> > > >
> > > > Ok, that makes sense to me and falls in line with what my patch here
> > > > was trying to do. When you enable the reserved multicast table it
> > > > makes sense to update the entire table right? You are only updating
> > > > one address/group. Can you please review and comment on my patch
> > > > here?
> > >
> > >
> > > During my testing of STP protocol, I found that Group 0 of reserved
> > > multicast table needs to be updated. Since I have not worked on other
> > > groups in the multicast table, I didn't update it.
> > >
> > > I could not find the original patch to review, it shows "not found" in
> > > lore.kernel.org.
> > >
> > > Below are my comments,
> > >
> > > - Why override bit is not set in REG_SW_ALU_VAL_B register.
> > > - ksz9477_enable_stp_addr() can be renamed since it updates all the
> > > table entries.
> >
> > The reserved multicast table has only 8 entries that apply to 48
> > multicast addresses, so some addresses share one entry.
> >
> > Some entries that are supposed to forward only to the host port or skip
> > should be updated when that host port is not the default one.
> >
> > The override bit should be set for the STP address as that is required
> > for receiving when the port is closed.
> >
> > Some entries for MVRP/MSRP should forward to the host port when the host
> > can process those messages and broadcast to all ports when the host does
> > not process those messages, but that is not controllable by the switch
> > driver so I do not know how to handle in this situation.
> >
> 
> Hi Tristram,
> 
> Thanks for your feedback.
> 
> What is the behavior when the reserved multicast table is not enabled
> (does it forward to all ports, drop all mcast, something else?)
> 
> > The default reserved multicast table forwards to host port on entries 0,
> > 2, and 6; skips host port on entries 4, 5, and 7; forwards to all ports
> > on entry 3; and drops on entry 1.
> >
> 
> Is this behavior the desired behavior as far as the Linux DSA folks would want?
> 
> commit 331d64f752bb ("net: dsa: microchip: add the enable_stp_addr
> pointer in ksz_dev_ops") enables the reserved multicast table and
> adjusts the cpu port for entry 0 leaving the rest the same (and wrong
> if the cpu port is not the highest port in the switch).
> 
> My patch adjusts the entries but keeps the rules the same and the
> question that is posed is that the right thing to do with respect to
> Linux DSA?
> 
> Best Regard,
> 
> Tim

Not sure if that's a question for the DSA maintainers or for Tristram,
because I've expressed already earlier in this thread what is the
current way in which the Linux bridge expects this mechanism to work.
This is not the Microchip KSZ SDK, and thus, following the network stack
rules is not optional, and inventing local conventions when there
already exist global ones is a no-go. If you don't like the conventions
you are of course free to challenge them, but this is not the right
audience to do that.

