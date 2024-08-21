Return-Path: <netdev+bounces-120468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72649597D8
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D001C20442
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038711D461C;
	Wed, 21 Aug 2024 08:44:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958E1D45EC;
	Wed, 21 Aug 2024 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229871; cv=none; b=K1eDCQopp8KeXtLdzLZrf7Rt4lb+qSTtNUrOtemo32HOIl0IgxuXJgEOmrIYW8Mf8U4VSO4FPQCBbRJVzI3A811gaFnW+2OvV0u+1Ean/+gQQyiFdmy8lyXl8l1E+SZhloXk47tMXBTDUw9OqXdBwPGUU43hzQya1uK3Xc2d3ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229871; c=relaxed/simple;
	bh=MzbJQMhdHxMEZLqfAWfHBeIliiLFphSOkPs8Xk/x3Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvPruQ58fRXbMMojT55oovLZrr8KU6I6TOGT67D9zUOPm3yMDtJInZrswuWBPgvMP6nLEyJcdGaHNrXlyoYRN/UpNmPhnhaJ7LU3csgamxgnVZXzJF2voC8rKKZq7gvGPeOTnB4nd8c5amxVPDYtasuujpJlZsWNE7OLgWNClrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53349ee42a9so378164e87.3;
        Wed, 21 Aug 2024 01:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724229868; x=1724834668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ycs+3o+17AbjjdX8MMOnXXW6/O0lw1yJAwUwvxTlASI=;
        b=WKDwlNpNuFOw9np8LKkiMvRQ1u0mv7ObDd9HC7DI3o8J1Rf8eDhFewGsE9BBxcmLqy
         lqk6Ie7a9/seQm4n7jtEeC1bYVg2F4OsJNgP8hiJOEjd8eRDvhZkVbR4J7xd6J+7/xtY
         NKjirDjDbu/fl3nDjntKM4ncTNaiEQXzBDiWDfdqc7HTlV/yMTM7SjLcBFxpINas12DX
         O6WzZ6E1T6D0mVVWn1jRGHs0qAO8UAc1vksQv8PfuF9jiI32cHUzkz7VtBa7uUdpa8tE
         /BeEpNDeF/yjjOCLwVKMjqC/nqasLELNq/wKlL6Oujstcs7KLiSnNi2zo54o6sOa0VQq
         gdAQ==
X-Forwarded-Encrypted: i=1; AJvYcCURHFMr+NXMsk6w0/I5qyFIGD0X/X4v2vTV3GVOVB2+MeYZRm+IryNJ4kVRj2S37mvTXeO6pC3RPqt/Bh0=@vger.kernel.org, AJvYcCXZifmLdtoP+EFiWRIT738mSA9dYuw7ku2hhi8Bakr8pTsI1KnwR/p1cOhnU+y24wDcyih/9yom@vger.kernel.org
X-Gm-Message-State: AOJu0YzbRPuB7OpASa6ONtOPOWHbT1Gy9Cw2ZzR7YhHh2dw9h/Fd+4qp
	OfU1DR2F4ingz0ydZnkLqCpf5fWXgvKc97eYLSkORsGiBlwMoy+R
X-Google-Smtp-Source: AGHT+IHMeY9I+w91+AZ0kSAEH+L7sAqulqxd5iLx/yQAb/XNduF09Zo1DBTrJWWhPch1DKwcWaNVBA==
X-Received: by 2002:a05:6512:3992:b0:533:77d:116f with SMTP id 2adb3069b0e04-5334854a579mr857790e87.9.1724229867572;
        Wed, 21 Aug 2024 01:44:27 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-010.fbsv.net. [2a03:2880:30ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a867eeab2b1sm23410266b.114.2024.08.21.01.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:44:27 -0700 (PDT)
Date: Wed, 21 Aug 2024 01:44:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH net-next v2 1/3] netpoll: Ensure clean state on setup
 failures
Message-ID: <ZsWo6Vestqw0fFAO@gmail.com>
References: <20240819103616.2260006-1-leitao@debian.org>
 <20240819103616.2260006-2-leitao@debian.org>
 <20240820162010.1e89b641@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820162010.1e89b641@kernel.org>

Hello Jakub,

On Tue, Aug 20, 2024 at 04:20:10PM -0700, Jakub Kicinski wrote:
> On Mon, 19 Aug 2024 03:36:11 -0700 Breno Leitao wrote:
> > +	DEBUG_NET_WARN_ON_ONCE(np->dev);
> >  	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
> >  		np_err(np, "%s doesn't support polling, aborting\n",
> > -		       np->dev_name);
> > +		       ndev->name);
> >  		err = -ENOTSUPP;
> >  		goto out;
> >  	}
> 
> >  put:
> > +	DEBUG_NET_WARN_ON_ONCE(np->dev);
> 
> nit: having two warnings feels a bit excessive, let's pick one location?

Sure, I think it might be better to keep it in the fail (put:) case, so,
we make sure that netpoll is in a clear state in the failure path.

Thanks
--breno

