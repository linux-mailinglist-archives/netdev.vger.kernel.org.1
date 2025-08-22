Return-Path: <netdev+bounces-215908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD56B30D87
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EAF6870F5
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92F127A935;
	Fri, 22 Aug 2025 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="Eov/N93I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68652773FC
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 04:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836605; cv=none; b=FPxQeGovmZ8yEBOn6CEghEhY2HPHvr6HhIwrvi0qF9poK6QyAnhhUPV5kh3wSY7ZheBokEGQLaLaj1Czo1Dtza4feKqXc2Gp4WyUbDJ/+VoFCuJrkpXHrIYJIg1xr+7q+1x0n5bcEdlRvg/LCZvvWiYYF6N5m9z1jOSo3Y9NHC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836605; c=relaxed/simple;
	bh=rcfw7pKOmFxog5o6Pv8xbpuXN5/vYailwsWhsRDTQPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmLguNn6n44YL7DGY+WDwlNiG5Xmu9wJa5T7nvJYUA3+1UwP8MuCdXvOKHFApilBN3cxpI7NX5htmietaVwnmWPb/fZcAcDKeZy4uaWs7GhpYyun3IO4HNqXjwvLt9MPXBkHHR4dmkxUWCogAkZYEXiDhS5p6/ZaCLJl82KDF4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=Eov/N93I; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b47174c8e45so1558600a12.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755836603; x=1756441403; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8OYbr6Zeb0In7ciWZAGGuuclyk12KWAFQqeCkPJi8ew=;
        b=Eov/N93IZjIkQ+77ciJVgTSnW6Ujqs8bTmTJKNvSRscUCK5WqKE0DiO8iGETuhQbGj
         SAGK/cbBtR6ER+t8/NgZyj9kKWNxsS+oJxcvVAodtpicveJQTkhQWVBme0i+jNk4u4ZQ
         IiVBD5wmsQlYhALJWtkDjUjimTadpCmxO/kPkAsF0rGA6TRUBo4Mr/hwBdvjwINq0uXF
         +5urKAS79vt5J/g6lqgJKB2USSWxToQYBgm5R3FQDxEplw83YWMf3CpKzTjzI/dvUhIo
         vEQwfBqMz81chUP1fp3eWV7UASSD8JYxGy58g/tYh3L5tXMa2Pk7OEvXbJlha8Qawlla
         bxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755836603; x=1756441403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OYbr6Zeb0In7ciWZAGGuuclyk12KWAFQqeCkPJi8ew=;
        b=V1NRfZSXCtx23MBGAs3Eh+WhZ7Yyfsrj2B9XlCjL8GycgZg3lMG39cAG2Qm+s/8puY
         77RY55h87fYexjCBe9MoK8XOZRO7n8l2JJkgB0Jk3vV7nWim/UeE1ZqaSLWcyNqJ+jYR
         XNeLCikOmo5aGQaTVhiVd4HVYYaK9hJcQRdj0E58njxwhiyR1KgNHD6DEIMWbiUkEWUd
         6DWA89kXH4OeQjoAjdG4fOVeHKHP8AojOC6WIqze12WDDGLuKP7QItL4NhsxVjKlJFsp
         GWDCjhTHV8NQpJ8C+YacJ3nkEvmOfQX02WoCrG/tQcnjLkoCUGnT/rqXHeOYQXKy3uKG
         ZVxA==
X-Forwarded-Encrypted: i=1; AJvYcCUzvMOFnarqod2bssrEGPnJ3VTpxN+PVcKgzoXndVF0sSTY3RfCBTp/g4seMwoOow12Viq4ZzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa1CEY32HTL6w1ZwI6aF+M8A4s3YAiO06ORIytEgEmc7FbfDzs
	1gYj0Uresr/7QZEzNc66XH0MednlSB7EkJWmyOTlx3hACCJL2fJjdDg/WsEyv0GhoFc=
X-Gm-Gg: ASbGnctVBdjUpY1HKLXNFQf86eb1TNyvTofNB1F3HKMd3ebT/tpOyw9BITia0Kv/Wy3
	5KEuyrB4oDqNXdhjP7U9X+zRup9XVPkSruEl/FqpLIELhFvQ5znSTZK9K0WH6UltZLoyCLRjlaq
	q4fL+cilOXmRF6QF5kBoHoYEJbNR7UD7NwmvZBde76bxlkLEPFAwVfQiJNesINAVWrLIV2bpYBW
	QdjS7hQ7GR6mbrt3pjJQwC5zWIUtyAU2B7dV+cfYnrAEC35lkaLbS4D9XaQT4BTQRyUEkLQiEIf
	TwuRocwDwFQuiQTFkmngSDgZAo0wlt7Q34UQUuH5DIWBgV+fG4/3uwr3x9mX8ONB/ncapg/d6Dl
	eB/wgBlaYDKgC1WyC5aRd+/cI
X-Google-Smtp-Source: AGHT+IGkr6KG1Nu9z0iOHepL9KnzdBIr5e1tJ3KsMa+xu1RZViZOdy4PjdjRbUW4MQjoOYoW45A27Q==
X-Received: by 2002:a17:902:ce01:b0:245:fcc6:a9d8 with SMTP id d9443c01a7336-2462efbe05amr28662875ad.54.1755836603033;
        Thu, 21 Aug 2025 21:23:23 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24636064715sm8694255ad.29.2025.08.21.21.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:23:22 -0700 (PDT)
Date: Thu, 21 Aug 2025 21:23:20 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Michal Schmidt <mschmidt@redhat.com>, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] i40e: Prevent unwanted interface name changes
Message-ID: <aKfwuFXnvOzWx5De@mozart.vkv.me>
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
 <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
 <aKXqVqj_bUefe1Nj@mozart.vkv.me>
 <aKYI5wXcEqSjunfk@mozart.vkv.me>
 <e71fe3bf-ec97-431e-b60c-634c5263ad82@intel.com>
 <aKcr7FCOHZycDrsC@mozart.vkv.me>
 <8f077022-e98a-4e30-901b-7e014fe5d5b2@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f077022-e98a-4e30-901b-7e014fe5d5b2@intel.com>

On Thursday 08/21 at 22:39 +0200, Przemek Kitszel wrote:
> On 8/21/25 16:23, Calvin Owens wrote:
> > On Thursday 08/21 at 10:00 +0200, Przemek Kitszel wrote:
> > > On 8/20/25 19:41, Calvin Owens wrote:
> > > > On Wednesday 08/20 at 08:31 -0700, Calvin Owens wrote:
> > > > > On Wednesday 08/20 at 08:42 +0200, Michal Schmidt wrote:
> > > > > > On Wed, Aug 20, 2025 at 6:30 AM Calvin Owens <calvin@wbinvd.org> wrote:
> > > > > > > The same naming regression which was reported in ixgbe and fixed in
> > > > > > > commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
> > > > > > > changes") still exists in i40e.
> > > > > > > 
> > > > > > > Fix i40e by setting the same flag, added in commit c5ec7f49b480
> > > > > > > ("devlink: let driver opt out of automatic phys_port_name generation").
> > > > > > > 
> > > > > > > Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
> > > > > > 
> > > > > > But this one's almost two years old. By now, there may be more users
> > > > > > relying on the new name than on the old one.
> > > > > > Michal
> > > > > 
> > > > > Well, I was relying on the new ixgbe names, and I had to revert them
> > > > > all in a bunch of configs yesterday after e67a0bc3ed4f :)
> > > 
> > > we have fixed (changed to old naming scheme) ixgbe right after the
> > > kernel was used by real users (modulo usual delay needed to invent
> > > a good solution)
> > 
> > No, the "fix" actually broke me for a *second time*, because I'd
> > already converted my infrastructure to use the *new* names, which match
> > i40e and the rest of the world.
> > 
> > We've seen *two* user ABI regressions in the last several months in
> > ixgbe now, both of which completely broke networking on the system.
> > 
> > I'm not here to whine about that: I just want to save as many people out
> > there in the real world as I can the trouble of having to do the same
> > work (which has absolutely no benefit) over the next five years in i40e.
> > 
> > If it's acceptable to break me for a second time to "fix" this, because
> > I'm the minority of users (a viewpoint I am in agreement with), it
> > should also be acceptable to break the minority of i40e users who are
> > running newer kernels to "fix" it there too.
> > 
> > Why isn't it?
> 
> I think we agree that it is ok-ish to sometime break setups for bleeding
> edge users, then fix (aka undo). It's bad that this time it was with
> effect equivalent to the first breakage (hope that it was easier to fix
> locally when it occurred second time in a row).

I just want to re-emphasize, it was *not* my intent to gripe at you
about this. A big reason I test new kernels is in the hope I can hit
things like this myself and get them fixed before they impact the wide
userbase, I'm only frustrated I'm probably too late here to do that.

> But we dispute over change from Oct 2023, for me it is carved in stone
> at this point. Every user either adjusted or worked it around [1]

IMHO the date of the release (Jan 2024) is more relevant than the
commit date, but it's not really that different in this case.

I think there's merit to the idea that the lack of complaining is a sign
that most users have not had to adjust yet, because if they had, they'd
have complained about it. But I don't have any real data either way.

The objections raised over the new interface naming in ixgbe are in no
way specific to ixgbe. You can s/ixgbe/i40e/ any mail about it and
nothing really changes. They're generalized objections against the
renaming of interfaces, so from a certain POV people *are* actively
complaining.

> > > > And, even if it is e67a0bc3ed4f that introduced it, v6.7 was the first
> > > > release with it. I strongly suspect most servers with i40e NICs running
> > > > in the wild are running older kernels than that, and have not yet
> > > > encountered the naming regression. But you probably have much better
> > > > data about that than I do :)
> > > 
> > > RedHat patches their kernels with current code of the drivers that their
> > > customers use (including i40e and ixgbe)
> > > One could expect that changes made today to those will reach RHEL 10.3,
> > > even if it would be named "kernel 6.12".
> > > 
> > > (*) the changes will likely be also in 10.2, but I don't want to make
> > > any promises from Intel or Redhat here
> > 
> > But how many i40e users are actually on the most recent version of RHEL?
> > Not very many, is my guess. RHEL9 is 5.14, and has the old behavior.
> 
> RHEL 9 backported devlink for i40e in July 2024 [0], together with undo
> of interface name change [1] (this likely tells why there were zero
> complains from RH users).
> 
> [0]
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/commit/bcbc349375ecd977aa429c3eff4d182b74dcdd8a
> 
> [1]
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/commit/5ab8aa31dc2b44fbd6761bb19463f5427b9be245

Heh. Thank you very much for checking that, and for the links.

> > 
> > If you actually have data on that, obviously that's different. But it
> > sounds like you're guessing just like I am.
> 
> I could only guess about other OS Vendors, one could check it also
> for Ubuntu in their public git, but I don't think we need more data, as
> ultimate judge here are Stable Maintainers

Maybe I'm barking up the wrong tree, it's udev after all that decides to
read the thing in /sys and name the interfaces differently because it's
there...

In any case, Debian stable is on 6.12 and didn't patch it (just
checked), so I concede, it is simply too late :/

Thanks,
Calvin

