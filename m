Return-Path: <netdev+bounces-165138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F864A30A8C
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71B61624AF
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E4421516D;
	Tue, 11 Feb 2025 11:36:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB622144C5;
	Tue, 11 Feb 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273810; cv=none; b=d+oDLv4eJ6kS5Yw7PMC0ADOWjLVTfiSRWBqtlDt1W3a2Tjgo2YTnpH1AvfQpClddTfB/E8u/pgwY1qwsH/v3NQ6ff5jEg4PG/Bppf4VKUZgJXsF9nWDMWQfQOB5DT1T8Qj4LoJBRXqZ9c4mVPp0ZWVW7/yEJWcVss2wefT9ckt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273810; c=relaxed/simple;
	bh=E7oh2SjjGR1Mn5hcxaRTc4mk07uSnr6Aryfek8+tegg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gb6vWhasTw4hViSIEWVsP6KMRMHaQD392fOsR6+9vWD/LcWij+P0UlOksHtuagTWigbkZ6i3p61MPeWQftoWKyZBHmZ050+ktwxvT9yOEqqHZAxe5LPzw8IimNFa6WTtT0JcUEWtqsquEXorgv1NPE+6BMXZuob+VWrCWZVtC3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7e9254bb6so38544766b.1;
        Tue, 11 Feb 2025 03:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739273807; x=1739878607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYyw0APdT+rf83fedE72h4J9b7YA2HwXPp+MMP73iXo=;
        b=rmJItvhCsU2GgD1pjbloGPNitjOmbGkwGzNo9baTtHX4kKYlkCSWGkMS6UiAW/jIO9
         nszgtfypHqXOagGf8u1pNKwuiY2fLyXjh2nVI0sQnTag7T3HGtEg7c2NN3ak04GxHYhX
         Gs3hyGvmqsf/ej7D3Gb+/S4834tRp8VKjI+KSNIxMzOPkwbBjwVrO3z4ra/PueibFJZ9
         bKikW0nE2bSaUr+3au2/bK9SutWL9fLsIfpgbDgs2852s3v4fhaJnhTDTa97gitRB2gs
         LiG6loalWvjCCts7joiZe3+8tSdL0zccMqFI6/jUOj/8lzEslCwgAsTaPf/Zl434sLpN
         jHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcmNNeREK/V9W1JoeXolEvOCjmZmWI7H85ndwynNfdPiHKzEG/FDgw7KgMeNoYD6i4kmUJVk8h@vger.kernel.org, AJvYcCX+uXIM+LnoAQKGN3Qb0/d2AwfERtPgK5ZnINF3OGzidsc9S0LuWLOCcWYFfm04q6XcRCvTv/cLx2PNdjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9sPnSm/7T22CNy2yj9VLfMAs1pHx6go9fYNRQkVYhq5tY4vO
	G60N1rVzdsSRENMJ5fQWOodQ9xYc1NLPe9ppSXXpzHwGiXTYdZJU
X-Gm-Gg: ASbGncs7kVp/MRlgRRCkBgVJMqPBtVpq2YJRgmdaFyXthFvzwi5zvxnBGtcRui04HTm
	8ndu078YcYu6D75SADz+mxf1Maj2EtBdxUdGq2QCigd0sX1o4cE1komHG78gEwjSGVrghYjXDq0
	rToMzeT7KLLTumvifxtYWCXSLWlZLZTyaNAGtGdOwyn5anNcaPPIE6G/L5ADi88QRUrXvWeASrT
	aFMFkpAiJ7aINT3fEqK5IzMHW0/AsXBck4JPdq6cGDvtGLnjGDStSxoGPcZbFCFUBig13hlltG5
	V+O8u5U=
X-Google-Smtp-Source: AGHT+IGzPsFBJKgnh+006HX3RnUxVF10Oj5CmIofHbgv3TvQgbAI1Q1gXjymKBCrjbHAzMtV53JFkw==
X-Received: by 2002:a17:907:9447:b0:ab7:b043:bebd with SMTP id a640c23a62f3a-ab7b0449e02mr1100079666b.5.1739273806641;
        Tue, 11 Feb 2025 03:36:46 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d4d291bdsm203125766b.17.2025.02.11.03.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 03:36:45 -0800 (PST)
Date: Tue, 11 Feb 2025 03:36:43 -0800
From: Breno Leitao <leitao@debian.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, kernel-team@meta.com, kuniyu@amazon.com
Subject: Re: [PATCH net-next v2 2/2] net: Add dev_getbyhwaddr_rtnl() helper
Message-ID: <20250211-discerning-greedy-nuthatch-b20c4b@leitao>
References: <20250210-arm_fix_selftest-v2-0-ba84b5bc58c8@debian.org>
 <20250210-arm_fix_selftest-v2-2-ba84b5bc58c8@debian.org>
 <Z6sF2RZRdqnH6MQR@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6sF2RZRdqnH6MQR@dev-ushankar.dev.purestorage.com>

Hello Uday,

On Tue, Feb 11, 2025 at 01:10:01AM -0700, Uday Shankar wrote:
> On Mon, Feb 10, 2025 at 03:56:14AM -0800, Breno Leitao wrote:
> > +/**
> > + *	dev_getbyhwaddr - find a device by its hardware address
> > + *	@net: the applicable net namespace
> > + *	@type: media type of device
> > + *	@ha: hardware address
> > + *
> > + *	Similar to dev_getbyhwaddr_rcu(), but the owner needs to hold
> > + *	rtnl_lock.
> > + *
> > + *	Return: pointer to the net_device, or NULL if not found
> > + */
> > +struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
> > +				   const char *ha)
> > +{
> > +	struct net_device *dev;
> > +
> > +	ASSERT_RTNL();
> > +	for_each_netdev(net, dev)
> > +		if (dev_comp_addr(dev, type, ha))
> > +			return dev;
> > +
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL(dev_getbyhwaddr);
> 
> Commit title should change to reflect the new function name in v2.
> 
> Separately - how should I combine this with
> https://lore.kernel.org/netdev/20250205-netconsole-v3-0-132a31f17199@purestorage.com/?
> I see three options:
> - combine the two series into one

I would suggest you combine the two series into one.

I will send a v3 today adjusting the comments, and you can integrated
them into your patchset.

Thanks
--breno

