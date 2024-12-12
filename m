Return-Path: <netdev+bounces-151522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1B79EFEE2
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8F5287C75
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57681D7E5F;
	Thu, 12 Dec 2024 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GAAe8xCX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E491D9353
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040798; cv=none; b=N0gc9YgTnue+jchlRx9+w2aM/9p/DHGYsaozv93AAZJFqyCogVjjj0naWZPrCnw8OEGo04plT5SgaIc798VReEuVM2IFmgfhdzT85lEQbHnGn9A35GGbWqCoN9bes3bz/fDFmMqZegyGs7utvBBnWiv+d8+8gf2Cs6Q+K9ZLxMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040798; c=relaxed/simple;
	bh=GMIVjeyPNFdTXswqKXuialJkrxchMW3sjbOcMtodrsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na9eiss/o7dIxH9M2Y5LJVPrLfbWHXy5gY2D2tjQIYJyN7yii/Ss4NpffmpW8XS0VY3hkqx38JVjdGAWBWdxDrD5DGnImI7YCs+ej5lLgGWqcSPgc7flhGwQXPjxRats6EY2AL/PJQmrSIYQuvZgnxxmGCQUusGZMvLXmT+ZqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GAAe8xCX; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-844ce213af6so36240939f.1
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 13:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1734040796; x=1734645596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hOQbkhwq3FFTGQHk7qUWLKgXG3C44RKLYDc+WfIMGtI=;
        b=GAAe8xCXC2Gw11eRucawY327rz+EtPSulXFx+cIB11tw6x/ZTUD9cnkmhE6bjmrBxj
         VkHUt3/79tNsGL9/V2V3xVk3i5PWpLNP/e2iBlpazm4yTnddfsQW0eGnR0GZA8+cufFe
         5y5Ke5oXuPXNK/nKAYz7CnAocgoN+ZmT7zGC1XWMaxj/H8tBqQMphlHF8LIkKdEXrL8/
         Ne1ItamBJBaztKSujYRFWBxYJC23lrALZbioCr7+PiIz8MF/N+TQme+xyA/QF6Y/8yxW
         oeH8tMWC/QKJd3qUqevrPDQ0b9SBesktF5AAv3uG+FcbeUyNXapd5mGLkK1Bje/oLTrv
         xSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734040796; x=1734645596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOQbkhwq3FFTGQHk7qUWLKgXG3C44RKLYDc+WfIMGtI=;
        b=aNBvXYEdibVpEyWNLKcM5iSGP/OdSNPQzU0Yct48sWj83pbFau1TRWetF3NbkOQQBV
         YbOdEzC0dJlhKOBbw1WVVmkgGUDj/bsoeBGzH+tSdrnsIZ8uZQHKL5ROkoxSiMpkPwnM
         b4eVjc2/Zx/M3BS8DyUSyYGzFAIt45eLyAdowPSdCjRDrqik2AKluqMC6Lq/QZG6c+93
         2CB50npbhPBr+IvtpRsOmYorZHDJuEFB8g4HDE0ddThmt0ydTVeZI6kpcBMyEWYxnyFe
         wSLYu3jl6lgNTJz0HckCDoO2mFjQmj+TTn17WANjREDHoQIQyDi/Psv4RfnIEZRmy+fX
         do6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQfFnyHYIQRwjxJa2zE6CII28c2pTHk4qUGJtcEJU/5cE/+PxMPcMBadwfPR/9LagNEuROGg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3hbY2oMSR2HREyw2mm+JTqUjcobsu7D+7JjalYT9fgv6lG7pN
	u4+zGTmLyHXRnSTYxwZET2bI24I1oOY9QhEjMbr16HfLbYmlAWTkGp7mfokVijz8s7Slw41PgoO
	e6CVnmR4RCe9UBzlPsk+e7S52oaLilYeu
X-Gm-Gg: ASbGncv7rD3pqtdLa8+deSesQxa3oji0HoyLnAwngA1Zu2p1tNArcDchNsVzcQ5z0dG
	rzCfik92RGt2louOqgb5LZyzx0tUTmzeLXqwZXyE5z2uwkHgQZKd3lYVI8RGIf4L0c2eEsg7Gn5
	wQ6JooCzryPZ5gu4K6WKvDpBzyz/aPlZa22xBKpsYqqsBYbGixuBf3+7NQxvNOSgS0A1rlllwqe
	WI/zX+imfUwdo/Qsgy0gUYZI95iswV7NL9BXX7nCvPQwBxHi9NjcNki4Vkfn8l4EmQzx3sGUgo1
	AuswlD/QoszQ2ns=
X-Google-Smtp-Source: AGHT+IFmgcEnblD3FXiYRcJjFBf+ppQw1TJ2ZALYTr5OwoIWeREvCIYRKm9LoAA9A+G3mI3KK2UecgEHGYYL
X-Received: by 2002:a05:6602:6c16:b0:832:480d:6fe1 with SMTP id ca18e2360f4ac-844e86d570cmr58214939f.0.1734040795959;
        Thu, 12 Dec 2024 13:59:55 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-844738d75c8sm65980439f.12.2024.12.12.13.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 13:59:55 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 422973401BC;
	Thu, 12 Dec 2024 14:59:54 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 340F4E55E56; Thu, 12 Dec 2024 14:59:54 -0700 (MST)
Date: Thu, 12 Dec 2024 14:59:54 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] netconsole: allow selection of egress interface via MAC
 address
Message-ID: <Z1tc2j88lNv19gzq@dev-ushankar.dev.purestorage.com>
References: <20241211021851.1442842-1-ushankar@purestorage.com>
 <b7bfd346-71d2-481f-bb9f-e3bc1d6d53f0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7bfd346-71d2-481f-bb9f-e3bc1d6d53f0@redhat.com>

On Thu, Dec 12, 2024 at 01:34:12PM +0100, Paolo Abeni wrote:
> On 12/11/24 03:18, Uday Shankar wrote:
> > +static ssize_t local_mac_store(struct config_item *item, const char *buf,
> > +			       size_t count)
> > +{
> > +	struct netconsole_target *nt = to_target(item);
> > +	u8 local_mac[ETH_ALEN];
> > +	ssize_t ret = -EINVAL;
> > +
> > +	mutex_lock(&dynamic_netconsole_mutex);
> > +	if (nt->enabled) {
> > +		pr_err("target (%s) is enabled, disable to update parameters\n",
> > +		       config_item_name(&nt->group.cg_item));
> > +		goto out_unlock;
> > +	}
> > +
> > +	if (!mac_pton(buf, local_mac))
> > +		goto out_unlock;
> > +	if (buf[3 * ETH_ALEN - 1] && buf[3 * ETH_ALEN - 1] != '\n')
> > +		goto out_unlock;
> 
> I think you should instead check 'count >= 3 * ETH_ALEN', and do such
> check before calling 'mac_pton'.

Is that needed? mac_pton has an internal check based on strnlen, which
is guaranteed to succeed because the kernfs layer will NUL-terminate buf
for us.


