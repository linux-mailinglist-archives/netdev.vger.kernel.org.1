Return-Path: <netdev+bounces-152259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF869F33E0
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304A57A1893
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6105B216;
	Mon, 16 Dec 2024 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUxjsV3U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831AD4D8D1;
	Mon, 16 Dec 2024 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361187; cv=none; b=iM9eKImE22zCiiJjEbj3UKSZRtN9saYWVI2JejmMngDCndFWFT0Grfk/12rL6T+0u0ox7FiTpD8HZvHgmd2NTlLkD7MJ1gnUtxlAxZWcVu1oZtocy7Qb9N17XrB52of6wDBntORqcK8Mn8PcMmg/htYoC5/OfH3Z9RWS8mVY71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361187; c=relaxed/simple;
	bh=9yBMXSvjHyO3OgaQroXVrz9wGXooF5YdM7RdE1sYspE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaSbSZGXfTUa9NcNbScfS4rpEDVE9ESnyYAkHRex0GlJPAgUiAWcdbNUdZUShVrnJN8dKc+wJg2QVq4jXC6q7i2DhBxP6ernCjgvZUahwyV3ELNLn/Msb1i0K4bqaybIlZx6Z8/W2pv5kD3NTqXOcrseWR/Aqw53OHILY8s9WRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUxjsV3U; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e0d47720so412734f8f.0;
        Mon, 16 Dec 2024 06:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734361184; x=1734965984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yLF4x21xNTyOHzkaSMkcHulKhqRy00jOgWZ/SKyRtZI=;
        b=kUxjsV3UhnfIpravvC09EInlFVYYogMmPWAIMCn5TgONGTsNOP0HX9N61xLcwO4oy8
         IibH8fLTotV7fa1a/DMq3p3QhhtxOB3b/0vVxBjNRZBUNR2XgfVxrXuQpveno9wF9b3X
         pJ9ZJ1m2THWgzQijhME/WWW3+AHc9MJtiUdwz4zacW4nToC21CsL4a71u2KP7ZlJB2mx
         kyGWlHgKPKVGrE+Q1pV7dh6mI5vfS+n0oAfdjtRit2psR/wOWCfTHgnBc/IeIkEB4i9Y
         G7aQFGS0Q4tWSyZzRqR3OepHIIts/jwRp393HDUy931SIcQBbAL3+/YedK3roQ9sTwW5
         EJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734361184; x=1734965984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLF4x21xNTyOHzkaSMkcHulKhqRy00jOgWZ/SKyRtZI=;
        b=Ww3RYHQes0C18Ec82rYG4pUfk+AOqPtr6J3+djY53ZXveKsJC8hljvboGxuk+JCLzN
         IAdw6PGSkk09swo3wVl7r1isPBAnLjgD9ynasv80EXo5GE/In07oaEOo2fProhp4LLJk
         EZyzXEN54Rgui8AZ0n+hletv47J0urZlgUyZ3On8xcWIMc4c2UIqlYuvrYwUXNZZpx9O
         s6+aEznYwS0RVQYM6Tc2Jl5YSzYqCyLSRZ5VvWOcWpBMwPtjRb47/Iyr206ajUzFB3j5
         W1T5q+2vDabxp1qdc6fvDqX+6oa0T7YTsgPdxppq1PaDDeWoOxMe1XjkhAuhxTlEOivp
         qfpg==
X-Forwarded-Encrypted: i=1; AJvYcCVJAsQNZCJIFFiac0o0USM4daGOUIgozpPidBiQyglUclyGbt0tqydcd2Zt+ZOo2uyx3iBTRPTC2xzCn0o=@vger.kernel.org, AJvYcCXE2k/Gjxv6Olu0VUeBSNtEISEf8Nh1Z+ShVU9WVMhrokec0dBLIcJi8nfN52OxpbJwBJ4ycMti@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvKIKkhp0woPvoQ/5mY1WFVujnnJIzp/+sfY4jJvGkUBYzLyr
	HC4JDsofG/6NWT4Tg8I8bpjfgjdPQ18QHF5SAhnnZikuOf1tR8il
X-Gm-Gg: ASbGnctpWgH8X3vGALqG2dbYMr6Re0BHXQWORMIOF7IAsY1lItHiEPqgYccP7Ju0La2
	RI1WgrwkQ0Z5la81yiNeE9hTBm5OgXEmcf/uqbG8tfB/Dt3FCeA2H+R2XUBZnlrhNwECzqEFuYo
	FauI4HNnrOMHHjWrPPmq24ilF4uepUN69Jq7q2/YhL/VHs20uTKWnjJY3Ez0cQoDuaYtWSCJHN8
	nTBSDwCrSZzKxOgiwWmoSyyp2IatpA2aIPu2dqpr67S
X-Google-Smtp-Source: AGHT+IFO6AzYSfhYUAho4hJ0jVZPEqAxfHWDaVWrIYHb+ZIKH6lObW+sJUZiFg+okWGsIO6hO0Cxfw==
X-Received: by 2002:a5d:584d:0:b0:385:e16b:72be with SMTP id ffacd0b85a97d-3888e0c249fmr4135436f8f.14.1734361183390;
        Mon, 16 Dec 2024 06:59:43 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8047089sm8496167f8f.85.2024.12.16.06.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:59:42 -0800 (PST)
Date: Mon, 16 Dec 2024 16:59:40 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mattias Forsblad <mattias.forsblad@gmail.com>
Subject: Re: [PATCH 0/3] dsa: mv88e6xxx: Add RMU enable/disable ops
Message-ID: <20241216145940.ybbwiige7dhkpzaa@skbuf>
References: <20241215-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-v1-0-87671db17a65@lunn.ch>
 <20241215225910.sbiav4umxiymafj2@skbuf>
 <289fa600-c722-48d7-bfb9-80ff31256cb5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <289fa600-c722-48d7-bfb9-80ff31256cb5@lunn.ch>

On Mon, Dec 16, 2024 at 10:50:47AM +0100, Andrew Lunn wrote:
> > How big is the later patch set? Too big to accept even one more patch?
> 
> The patchset is 21 patches, if i only support one switch family.
> 
> I can remove a couple of patches, getting statistics via RMU, and
> timing the RMU vs MDIO and disabling RMU if it is slower.
> 
> The other way i can slice it is split it into two patchsets:
> 
> 1) incremental modifications to qca8k to centralise code
> 2) implement the mv88e6xxx changes to add RMU to it.
> 
> I did not really want to slice it like this, because the central API
> is designed around what both QCA8K and Marvell needs, and hopefully is
> generic enough for other devices. But there might be questions asked
> when you can only see the qca8k refactor without the Marvell parts.
> 
> I can maybe squash some of the QCA patches together. Previously i was
> doing lots of simple changes because i did not have hardware to test
> on. I do have a QCA8K test system now.
> 
> > There is a risk that the RMU effort gets abandoned before it becomes
> > functional. And in that case, we will have a newly introduced rmu_enable()
> > operation which does nothing.
> 
> True, but i'm more motivated this time, i'm getting paid for the work :-)
> 
> And there is one other interested party as well that i know of.
> 
> This patch series is fully self contained, so it easy to revert, if
> this ends up going nowhere.

So what's a no-go is introducing code with no user.

Splitting into 2 sets like this should be fine. You could post a link to
Github with the complete picture when you post the qca8k refactoring, so
that we know what to expect next and where things are going. Hopefully
it makes sense on its own and does not leave loose ends hanging.

I don't think that squashing multiple logical changes to fit the 15
patch limit is a good idea.

