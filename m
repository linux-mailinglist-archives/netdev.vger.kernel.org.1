Return-Path: <netdev+bounces-165958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72382A33CBB
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9213A16F4
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297F8212B39;
	Thu, 13 Feb 2025 10:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8E41C6A;
	Thu, 13 Feb 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442585; cv=none; b=JNmH2M6asPXCCHLSGIQLv3ZOuat2S0JkMem0+x2PCuPaNUFaZmMbb6pcIgXINN1QXPchOIuA1HYH7yVcaymZkT0eNFu3nu1Ex+kgQTCyqZrBDt0jUL39OGt2H/N7kRQJanNgMbXiVKgrjNdqai8UQpBh01fZj5NAFdGjWrIhEbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442585; c=relaxed/simple;
	bh=HwZ1wnhGMDRvzC5/CiIbbh8YNJW3bp6hthYz06OuL+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7WqnQRjOBVya6grIAMKOeOUfpY4NGAPcxg1ZYmttrPLc8B81/5m5dWyRbx4BZ/BcXNRwjuHINRc+OEBWxHyJ+5fLA0YzaNgi9GNgffrSez/X5oDMREG8wC+U8YSo5IrP/hgUOqIGr838jfLSpLQp0w10q/CG1ExKuRrnTiuksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso122512266b.1;
        Thu, 13 Feb 2025 02:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739442581; x=1740047381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHMz81HNAoHjFTg7qKY5ym35WvloID/eRZqyssA2bH0=;
        b=tKjmj4wTwYXP4LtqKCQC2ZufLg7S4Iky0gghd18YFGMk/HuTG9JX5YPdr3Pg06HMdi
         xsJHUEVpKZFL7SZNaRFYuwQVSrMQaqJFPyqnu397cAM2X00zb/G394TQCpE2OtP9oohM
         9KPHIj+Xqepr108Dh+XwYcYKagCqId50Nw8cQYm4gfX5Dyzv25b199wMjQUkYFDU3KQT
         nPK6hMHItVVY3fqZ1tF28dvj+Uv9svE+0zUxIVC/8QYG/huFxyB5VJ1UowBX9fW6CIGj
         9umRCHsj8ZIMcrLFBqBhX9J6reoNigwTbjKea4e7+3DwnRLXomGexHJA0s3T3qAd+oF+
         V+pA==
X-Forwarded-Encrypted: i=1; AJvYcCV15n8uuD+7yC9YSdHvA72CmMs9ryvxw7XhW0O7FAGxzgPKU2X7SDUPMS9nXh1/hQHE7qDfhZ9fpMVNpfA=@vger.kernel.org, AJvYcCWSuZ4u5Akvi129YTKTctwh3yVHWaEGljMw6PNQb4dNMhkUwRIZ03Px1z/tFCxXtJ5w2g0xSnEl@vger.kernel.org
X-Gm-Message-State: AOJu0Yynk7OvX05If0VFD7Bx/LACPK1Vb8bvBXFKkv0NRgUr1N8V3Dux
	kl1IBSkG4ciAzwTsWxtTvBmoC8yAS10FJUKnSxhbc63zeTl0NGvo
X-Gm-Gg: ASbGncumG+RqdBUsJBu3rpDBxRJy7d0pu1D0mkifhwPQynvZLZA9CM3Bm+/MUY86Y4d
	37KF8BoPhv9gASEiYVpjLpuGPKpfb3ruN3V2Hq9UNuKPtC8opiLLmPxv/azphIdGJzOALC32zNK
	lORIYjprysxn/18+vEnXi5NvUwJn3GBWlUirtIs5h8NEm5VvUSbViLsHX8sypQTV/SMVDcCAE/B
	oByAtmpau5q6U9J9c6/25qufwGItIX7JV0+Ja8P22DrPW4FMN96uw8T1tzTFnxedtF/EuXUGDi0
	V/grjfA=
X-Google-Smtp-Source: AGHT+IEcXiR9DvkyBph6N2BufcLwHqGvfgWr/sKzoDXhuCOv3FoI7ud9NMgA/z3DYhMasNiK6zZmQA==
X-Received: by 2002:a17:907:86a4:b0:ab7:d87f:6662 with SMTP id a640c23a62f3a-ab7f34a6156mr585936766b.52.1739442581073;
        Thu, 13 Feb 2025 02:29:41 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322fcsm106491066b.15.2025.02.13.02.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 02:29:40 -0800 (PST)
Date: Thu, 13 Feb 2025 02:29:38 -0800
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, horms@kernel.org, kernel-team@meta.com,
	kuba@kernel.org, kuniyu@amazon.co.jp, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, ushankar@purestorage.com
Subject: Re: [PATCH net-next v3 2/3] net: Add dev_getbyhwaddr_rtnl() helper
Message-ID: <20250213-prudent-olivine-bobcat-ffa64f@leitao>
References: <20250212-arm_fix_selftest-v3-2-72596cb77e44@debian.org>
 <20250213073129.14081-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213073129.14081-1-kuniyu@amazon.com>

Hello Kuniyuki,

On Thu, Feb 13, 2025 at 04:31:29PM +0900, Kuniyuki Iwashima wrote:
> > Subject: [PATCH net-next v3 2/3] net: Add dev_getbyhwaddr_rtnl() helper
> 
> s/_rtnl//

Ack!

> looks like Uday's comment was missed due to the lore issue.

hmm, I haven't seen Uday's comment. Didn't it reach lore?

> From: Breno Leitao <leitao@debian.org>
> Date: Wed, 12 Feb 2025 09:47:25 -0800
> > +/**
> > + *	dev_getbyhwaddr - find a device by its hardware address
> 
> While at it, could you replace '\t' after '*' to a single '\s'
> for all kernel-doc comment lines below ?
> 
> 
> > + *	@net: the applicable net namespace
> > + *	@type: media type of device
> > + *	@ha: hardware address
> > + *
> > + *	Similar to dev_getbyhwaddr_rcu(), but the owner needs to hold
> > + *	rtnl_lock.
> 
> Otherwise the text here is mis-aligned.

Sorry, what is misaligned specifically? I generated the documentation,
and I can't see it misaligned.

This is what I see when generating the document (full log at
https://pastebin.mozilla.org/YkotEoHh#L250,271)


	dev_getbyhwaddr_rcu(9)                                                         Kernel Hacker's Manual                                                         dev_getbyhwaddr_rcu(9)

	NAME
	dev_getbyhwaddr_rcu - find a device by its hardware address

	SYNOPSIS
	struct net_device * dev_getbyhwaddr_rcu (struct net *net , unsigned short type , const char *ha );

	ARGUMENTS
	net         the applicable net namespace

	type        media type of device

	ha          hardware address

			Search for an interface by MAC address. Returns NULL if the device is not found or a pointer to the device.  The caller must hold RCU.  The returned  device  has
			not had its ref count increased and the caller must therefore be careful about locking

	RETURN
	pointer to the net_device, or NULL if not found

	dev_getbyhwaddr(9)                                                             Kernel Hacker's Manual                                                             dev_getbyhwaddr(9)

	NAME
	dev_getbyhwaddr - find a device by its hardware address

	SYNOPSIS
	struct net_device * dev_getbyhwaddr (struct net *net , unsigned short type , const char *ha );

	ARGUMENTS
	net         the applicable net namespace

	type        media type of device

	ha          hardware address

			Similar to dev_getbyhwaddr_rcu, but the owner needs to hold rtnl_lock.

	RETURN
	pointer to the net_device, or NULL if not found


>   $ ./scripts/kernel-doc -man net/core/dev.c | \
>     scripts/split-man.pl /tmp/man && \
>     man /tmp/man/dev_getbyhwaddr.9
> 
> Also, the latter part should be in Context:
> 
> Context: rtnl_lock() must be held.

Sure. Should I do something similar for _rcu function as well?

	Context: caller must hold rcu_read_lock

Thanks for the review
--breno

