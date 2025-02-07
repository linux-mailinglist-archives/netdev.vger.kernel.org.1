Return-Path: <netdev+bounces-163935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B5AA2C175
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 12:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F25116AB0F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33C71DE886;
	Fri,  7 Feb 2025 11:26:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFC11AB50D
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738927581; cv=none; b=YzRApKgaIFt7bXCo3cMpbDAKSnrOGVD963c34AIgpMk8v7qkw/uBp8v08TN16VlQa51/9GYlTGyeSXWLagwP90qlOtxjCG1NV92L+Nb6Ri498bgJy53/5r/Ue4JzRohHXE3OWUJLuv3a+kzceg7T1v9XFm/2bcNTZOR96+x5l9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738927581; c=relaxed/simple;
	bh=A4MWwDO+EC6h2NVGi/wpJl6YikbNA82pnPhv6CmFTeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/n45vOapKcu16eaL6a0ptn0C3ZJL4YlVoGYtMjTPqZvUs/TjwdFM6hpSbPsnWGsTitTt4GeHKnnSNkF6SY9I/BsxSMrcSQ7spaFkGVFZq0JDvgY/nKXNsPSZ/srodZdcMc1w16E+sEWwHECJPP+qx1cBiAad5m6/80l99UALmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaeec07b705so344154466b.2
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 03:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738927577; x=1739532377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWh94EtXCDhDqr1icqhVIF+ck9xtHGANZJfC+IEuyf4=;
        b=rEsbnd3keM107fkbKA0IAhv3eTQZp2G7SpSBbPDd+/O7/DUduOejASYHWiNA3SulYd
         w63gPRHep6ZNIn1BqE5T0VpceCv0IhcJV+5BkqqXNky43vB1gAiuxfnLA7NkfNTnAykp
         3HOVfF5vKbtoy6mfCWyE7bwD1PEz8/c0Coqcz1L+mLu+jtm109bg81Eh0Tcq9P9rrLR9
         lKQCrVGYbW2IpM13B22MPz3FDJgbLUzABAkPx87qwfiZ8wDWivMvf4ujrJiZms8+a9tH
         dq8fwoaViSmD3rnh6wwML91XFaGDiqoZOrR1xVR1ZObPAXA/sZE5J3xwl3FDuXilPot8
         5yxw==
X-Forwarded-Encrypted: i=1; AJvYcCXFJRpiw5lb7bw9B8of38Ia6TE1JWFDatyc+9aIwFEE1CKtMOOBSqwZ+lNhTXklEYZew+ojIco=@vger.kernel.org
X-Gm-Message-State: AOJu0YyttpKFu3XGG8gGgFWa2UzrlfJCy+sRD+OqL59iui7toaRKYy5z
	UbFq69KR+jFv0+CISCYVRuc7m/+ezG+pZSDfoHEq2FC8BJur8VXT
X-Gm-Gg: ASbGnctzHoZSPXoGkvTcKpZ9gk6L8wdqEkOFfL2zd5pqynWMjKfFXn9WLu+SzIcd3tv
	cWizC5Jrniz1w25rcj0okgPB6gUYcLlqaxBgZ3qQ7LT5H6Imp0072dPNoWukp+OcI1ixnkVSI0g
	wfWla/8ZY8Lh/T7SR7QxXpPf0E5zqFzzOVCJInl15B3rRVx1J6lAMVHYLRG5nF/6bEU6MU8oY9M
	L+4yAYM1ikHzFrzd83ik+3Zg//ndq1TZWguMghy/jAK5niKW/hvXPQutmk76zVJOA5urTIy6i+H
	LegTQg==
X-Google-Smtp-Source: AGHT+IG9cUt6tVcqX1h0/65FzslG19XUckEykxSWc9MqiTncNNxs+taQo+zQb/+x9C9cVY8mLKAwxw==
X-Received: by 2002:a17:907:3dac:b0:ab7:83aa:b19 with SMTP id a640c23a62f3a-ab789bfab8fmr246819566b.42.1738927577033;
        Fri, 07 Feb 2025 03:26:17 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab77365c9fdsm248556566b.169.2025.02.07.03.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 03:26:16 -0800 (PST)
Date: Fri, 7 Feb 2025 03:26:14 -0800
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, andrew+netdev@lunn.ch,
	kernel-team@meta.com, kuba@kernel.org, netdev@vger.kernel.org,
	ushankar@purestorage.com
Subject: Re: for_each_netdev_rcu() protected by RTNL and CONFIG_PROVE_RCU_LIST
Message-ID: <20250207-adamant-copper-jackrabbit-27e9fc@leitao>
References: <20250206-scarlet-ermine-of-improvement-1fcac5@leitao>
 <20250207033822.47317-1-kuniyu@amazon.com>
 <20250207-active-solid-vole-26a2c6@leitao>
 <CANn89iJ0UdSpuA9gMEDeZ1UU+_VwjvD=bdQPeEA0kWfKMBwC8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJ0UdSpuA9gMEDeZ1UU+_VwjvD=bdQPeEA0kWfKMBwC8g@mail.gmail.com>

Hello Eric,

On Fri, Feb 07, 2025 at 11:56:53AM +0100, Eric Dumazet wrote:

> > I suppose we will need to move some of definitions around, but, I am
> > NOT confident in which way.
> 
> Note that we have different accessors like rtnl_dereference() and
> rcu_dereference_rtnl()

Makes sense. I suppose that would be a for_each_netdev_rtnl().

> It helps to differentiate expectations, and as self describing code.

The problem with this approach, is that we don't know what lock the
caller of dev_getbyhwaddr_rcu() is using, thus, we cannot leverage
a possible for_each_netdev_rtnl() inside dev_getbyhwaddr_rcu().

> I would not change  for_each_netdev_rcu(), and instead add a new
> dev_getbyhwaddr_rtnl()
> function for contexts holding RTNL.

Initially, I had reservations about this approach, but after further
consideration, it seems that creating separate variants of
dev_getbyhwaddr() might be the most effective solution.

By doing so, we can introduce dev_getbyhwaddr_rcu() and
dev_getbyhwaddr_rtnl(), each tailored to specific locking mechanisms.

To explore this idea further, I'll create a proof-of-concept
implementation to see how these new functions would look in practice.

This will help us determine whether this approach is indeed the best way
forward. Thanks for the suggestion.

> Alternatively, add one rcu_read_lock()/rcu_read_unlock() pair as some
> dev_getbyhwaddr_rcu() callers already do.

Fair, we can do that as well, but, it seemed weird to me to have
something like:

	rtnl_lock();
	rcu_read_lock();
	dev_getbyhwaddr_rcu();

Thanks for chiming in
--breno

