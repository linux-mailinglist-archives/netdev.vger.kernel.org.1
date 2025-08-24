Return-Path: <netdev+bounces-216328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18964B3322E
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 20:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2373B1BED
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDFE2264B8;
	Sun, 24 Aug 2025 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="ZSGN4OgV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11761B5EB5
	for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756061973; cv=none; b=WUjigLVDEMda32sZDQJXkC0XemE1gSZqbLvpoU6pRgTMWvJEDptzj5RY/xmaJu2o06jcAYsyjrxipbzMZp57tt4/9ZXAmejyqi68s3VtNY4ecxk0QjnwLFB4pFRurxBMnxbdBZM3vf+DPSvkZvLo7HK0ki6t/iIuQYhjhDtqZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756061973; c=relaxed/simple;
	bh=BnvchpbfuwNWq7Nl3K1zjneGZqvsA6KybiXB/LPTQF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwZWktStD90IWWsKHBdfUVFZiRyPqGG3lbso4W0IeNl44ld9QUAAmYTPPgoEqMCaYs8lqfY0zNHWHAzmwbQ+9c028c6CDxRD7GTtj37a3IT7H87vnBsZwkgRqDKit6cytXbGvRf/hIyc3fXiiIDkk+7hkWbWOYuo3Eu1NVxRyaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=ZSGN4OgV; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-323266d6f57so3871515a91.0
        for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756061971; x=1756666771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WgUhXr4F5aTrg6STFBoaBNVOBpBCCAFD9jOjviiLi7U=;
        b=ZSGN4OgVwgjXcCUFy18njiYNoSd9iH0ZuGhNJUQ54FANuJ8VNfWnYCGkNen+MF/i1G
         +PoL47SQSJlta94q5BUoAuKW5kFJ6ys7MMe3vhwdH5fBI196yIl2Yb6kBzxnCV6Nx564
         eJnkvS1OAvBMF9Cq0PMWoqjZ6Ub6JFoQ1awf7oK2gWo6BsiOpYbjB3bbAuaszwgGzqiE
         uDtKHS4rcYRFXvJ9mOJW4bWB0BwQonn9CWSBnVWJcJRkeilc5aS/RZR6TD3793H723Ra
         Qa918VrTiSa1Wi1g0xGZdSwe23sYNwgbdBpmuo8Rd+DKphhvdim/P1gdfumHink5WbDK
         52og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756061971; x=1756666771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgUhXr4F5aTrg6STFBoaBNVOBpBCCAFD9jOjviiLi7U=;
        b=vz8MV/32+SljVhmeV0a0QexdTdLAjZ0gLfllP7KEyp7c+ronlNRXEcFSPYXcYKWTIn
         YHZjd5lYwEh1vF6f5/W9hAfdL+e44D9apAMZvQpJ9GxbQqAKc6ULYvZJo9GtPVO8pY04
         R/ZRZZGcUekUVnBqIvxJBo226OnuffLfRE4daNY5v4oNuiDTLE/DDAhFfjl80au6vd7J
         9SyI2dhOtv4dwypfmMLkXWPfS7EONCHaa1qXTTvU73DXDEb90qHXnjl5fHK8IjcPp7w/
         CLRYS+ZZfPQIf86NSw6gF50QIdXEUqy6Yl9c9R8a6G+CrQpbR1gAsFDxdzH3Y2e4BPMk
         Ehpg==
X-Forwarded-Encrypted: i=1; AJvYcCXu8HPoRMFybUyMH90MsLMzusKDjnGYhKMrhmZEu09ztJLDmAPw03u7PkyiO+cyoztKqRKYk8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaHpxsDPkJeunI3SFrGRJvDytvW7Df4iRNkpyFwYUu9m23djMn
	2woEfAYTxtVfkYlK2DmmqLr5GrrxKkAqYQ8r1XsMFxIC+NxdOeok/DKHB5gZ8/xHQy4=
X-Gm-Gg: ASbGncthSFQCY4EdPUwRT2yON9ETRG1IoAztDT8cENgb9k5LxW7vvLMmxwIHWSa8E9C
	Nc+YAN/iYnJq1QyAQP7JvNoUW8JzVm2X4RlDox9pKRuhkdWJ93x1ZW+xqpZkEgyQCZOJuIxUY99
	fJGoZhfhQbijHfx9cX5SEF4KhOmrdxQiL+wewB0yydqQyTQdRZMtnphCHaTe1Bo+lz1GJvQwcfF
	1krGwXzJsNRkl+CAZnr8DpoyDZULS2scAlarak2Ooqz5QYkoKqlBA6nINC92xp1d8C67tqBX4TV
	nPD0/ahX1dwZyRrkWOSJTSyWwxK7AeTuC15N4dRC72oeN7Ga7hk/rGyyI/OUy6nke37e7Hqqbu/
	UX+ioRIZMEoHCQR3Ig8n6DkC9v+2/q+3q7pA=
X-Google-Smtp-Source: AGHT+IEBnPJSYGQSDsTaSJ2fe+K+NSUWm5ONkS7xAAjriSULC2FqOnxhgD/A++McgxcezIJd+A99AA==
X-Received: by 2002:a17:90b:1f91:b0:325:83:e1d6 with SMTP id 98e67ed59e1d1-32515ee21bbmr11146129a91.2.1756061971113;
        Sun, 24 Aug 2025 11:59:31 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254aa503dasm5021039a91.15.2025.08.24.11.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 11:59:30 -0700 (PDT)
Date: Sun, 24 Aug 2025 11:59:27 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] i40e: Prevent unwanted interface name changes
Message-ID: <aKthD02IN3-l-Rbj@mozart.vkv.me>
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
 <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
 <aKXqVqj_bUefe1Nj@mozart.vkv.me>
 <aKYI5wXcEqSjunfk@mozart.vkv.me>
 <e71fe3bf-ec97-431e-b60c-634c5263ad82@intel.com>
 <aKcr7FCOHZycDrsC@mozart.vkv.me>
 <8f077022-e98a-4e30-901b-7e014fe5d5b2@intel.com>
 <aKfwuFXnvOzWx5De@mozart.vkv.me>
 <20250822072326.725475ef@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822072326.725475ef@kernel.org>

On Friday 08/22 at 07:23 -0700, Jakub Kicinski wrote:
> On Thu, 21 Aug 2025 21:23:20 -0700 Calvin Owens wrote:
> > > > If you actually have data on that, obviously that's different. But it
> > > > sounds like you're guessing just like I am.  
> > > 
> > > I could only guess about other OS Vendors, one could check it also
> > > for Ubuntu in their public git, but I don't think we need more data, as
> > > ultimate judge here are Stable Maintainers  
> > 
> > Maybe I'm barking up the wrong tree, it's udev after all that decides to
> > read the thing in /sys and name the interfaces differently because it's
> > there...
> 
> Yeah, that's my feeling. Ideally there should be a systemd-networkd
> setting that let's user opt out of adding the phys_port_name on
> interfaces. 99% of users will not benefit from these, new drivers or
> old. We're kinda making everyone suffer for the 1% :(

Thanks Jakub.

I let myself get too worked up about this, I apologize for being such a
pig in this thread. My frustration is not directed at anybody here, I
hope it hasn't come across that way.

