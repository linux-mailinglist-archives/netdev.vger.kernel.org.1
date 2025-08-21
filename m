Return-Path: <netdev+bounces-215654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96532B2FD1B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A01764143F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41942882B2;
	Thu, 21 Aug 2025 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="PHuUhUtE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356C122E402
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786224; cv=none; b=kZjGUIK9uH5LPQOVy/xzXPxH8T6a6ztBl/8saKtu4s8ScnxkV5h2maWAs1sHI8ys9QHuNAdWG8WAY9XkI/aw0QoCiSbRF/YA9yoz6ouEqoayjeLTkJVNb/sIg09+iKQblEyAk2FAjFecX7lGH50fs5B6gbdaGJKEMnYLmBsSzCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786224; c=relaxed/simple;
	bh=/Q42VOBv5rtxb0pQz7EKEZooplEopOXO5j7KPdqQ/U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTAOoEIpCYyCPd/bU1iRFFdLS+IZZWIM+V7fEPBRB6IRm1Pcc8Qh41zmLYCQ/Mgby9VZFz5ZP3o/hiiOQ/8HQ3wF6a60msn9ECeV6IC3+tjSPzFekJ7yHKpnXfCC0BioVwlutMQ/jXejVTyjNPnjgwUP37EqVU5520BH0uowwbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=PHuUhUtE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2eb49b83so790661b3a.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755786222; x=1756391022; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gltw2YB8idtK1To8X9NeA2NjVxqELvTwQkrDIQqvz6Q=;
        b=PHuUhUtEoNZg6ZiytAWpNhYKglZiNMNurT3t9fPRCto/opRDgsWecwuUfpMG2sc6P1
         AG4SZT6kWgSWfCKd4LRZ+c+keiNqG++GiV7+lVjA6+Dw1/UYGqDYvf2y8oeTbe/08XvK
         Erhkw5rvRIQspIbSOLmWSvjXJuM+oKJ9ddnTiLUF7W19vAXXo7QLDYo7/VPqrVlljs6X
         NANeskRIPBEsrWwT4VoeQRqeY0ejJZ0GstYYYMXgRrYqu3RqpqwpLV0MxZ1By/PSAOwE
         lVp3YBbG7aYUUZdbJvI4XXEjcug0diYYO8W3FDDEAvI6yaNItgsuBKYPlkEqAkU68yeB
         CEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755786222; x=1756391022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gltw2YB8idtK1To8X9NeA2NjVxqELvTwQkrDIQqvz6Q=;
        b=FmPp9rYFo9P0/9fEk08RY00+xzwK3/9cP0fV51K6AVuk5ZvGzl+KoRh12hBQp3emzr
         nTCJ/FEsye6B9U9i48M26x/Y346isEo5SKN9FgQBO733xmIfA60SLI8+IKhDm7jq3fGJ
         qRrP6l1PfrjqbSAC5/uQQUirZRdKxu684Llqd59/3WEloKxa0bhOruPIGU0ZQMtJLW/r
         h9up2KpRYWoROWi/HVzbMB8w1lBAQYIMQ86bvLQLT2y6cICnMMc7u6JmPbvmFaqIs4kG
         jwoObd3Ur08teB9Iz2Ty3SpI2QJUgsUvOdQNdMx6+0IjKsveCxpAHr+XYtaWMn3Xwe0n
         jR7w==
X-Forwarded-Encrypted: i=1; AJvYcCXgLgxub9W4yyvOe/TflTTMEIlNatoubrp0TiCjtaTLNt6hzgahbjhg9jS3vjrkonD6VL1u7CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJh+ZiLONY208u/SNjaK0AcE4i0ucjCz/DnNPVAgY4Yn3s3P5K
	DOh9rX23Kon1FpUiX2nkX0+IzG+S4Fbpf89YQmoFcwQ9ufX61/U5ZqlPaxz2MIs9TAI=
X-Gm-Gg: ASbGncul99dlIpoMy77Qs0WxS1yvfyEOh4NclCZAg5yH/vtGOs9ZZRWjWHE+jz4AI3H
	kIhUEegbKwhuCxxZhtacJNteqmYN53bKU9fABAJ4QZkLvitMMdNg3HHMvUcEzQPLz2jNQQ7K+0T
	cRc3MhSPlLZou4/YcqDAhgCxPU+PWKHOJHo3nq1hLwb6lEl7qg6L0XPaxYGiQ59OQngGph1tsuP
	vYBUlsUlGXh3v5Ull1nK9o3m8VpQgh+RDvF7zhjq7ITOPZJWBnRhADev32ZZiJVGffTT5bN+Uix
	O2+15ewbDrb70cv2PlTEQmkcHD1RWUBkjhFePDEMcoTkFAKukqF0JYSfBJN97j/jqlfnbz4ZH43
	ZwBaQ9mmimv53w21/RDDqdKNz
X-Google-Smtp-Source: AGHT+IHC9kZMbllRdoU5B4ZJo00K1PDPDVqdvazp9vl34+r/qKCj0BP9ePp+tekV3D9iBLHdu8oAsA==
X-Received: by 2002:a05:6a21:998d:b0:240:27be:bb99 with SMTP id adf61e73a8af0-2433074e72bmr3189057637.9.1755786222380;
        Thu, 21 Aug 2025 07:23:42 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d62f3sm8455613b3a.19.2025.08.21.07.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:23:41 -0700 (PDT)
Date: Thu, 21 Aug 2025 07:23:40 -0700
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
Message-ID: <aKcr7FCOHZycDrsC@mozart.vkv.me>
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
 <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
 <aKXqVqj_bUefe1Nj@mozart.vkv.me>
 <aKYI5wXcEqSjunfk@mozart.vkv.me>
 <e71fe3bf-ec97-431e-b60c-634c5263ad82@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e71fe3bf-ec97-431e-b60c-634c5263ad82@intel.com>

On Thursday 08/21 at 10:00 +0200, Przemek Kitszel wrote:
> On 8/20/25 19:41, Calvin Owens wrote:
> > On Wednesday 08/20 at 08:31 -0700, Calvin Owens wrote:
> > > On Wednesday 08/20 at 08:42 +0200, Michal Schmidt wrote:
> > > > On Wed, Aug 20, 2025 at 6:30 AM Calvin Owens <calvin@wbinvd.org> wrote:
> > > > > The same naming regression which was reported in ixgbe and fixed in
> > > > > commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
> > > > > changes") still exists in i40e.
> > > > > 
> > > > > Fix i40e by setting the same flag, added in commit c5ec7f49b480
> > > > > ("devlink: let driver opt out of automatic phys_port_name generation").
> > > > > 
> > > > > Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
> > > > 
> > > > But this one's almost two years old. By now, there may be more users
> > > > relying on the new name than on the old one.
> > > > Michal
> > > 
> > > Well, I was relying on the new ixgbe names, and I had to revert them
> > > all in a bunch of configs yesterday after e67a0bc3ed4f :)
> 
> we have fixed (changed to old naming scheme) ixgbe right after the
> kernel was used by real users (modulo usual delay needed to invent
> a good solution)

No, the "fix" actually broke me for a *second time*, because I'd
already converted my infrastructure to use the *new* names, which match
i40e and the rest of the world.

We've seen *two* user ABI regressions in the last several months in
ixgbe now, both of which completely broke networking on the system.

I'm not here to whine about that: I just want to save as many people out
there in the real world as I can the trouble of having to do the same
work (which has absolutely no benefit) over the next five years in i40e.

If it's acceptable to break me for a second time to "fix" this, because
I'm the minority of users (a viewpoint I am in agreement with), it
should also be acceptable to break the minority of i40e users who are
running newer kernels to "fix" it there too.

Why isn't it?

> > 
> > And, even if it is e67a0bc3ed4f that introduced it, v6.7 was the first
> > release with it. I strongly suspect most servers with i40e NICs running
> > in the wild are running older kernels than that, and have not yet
> > encountered the naming regression. But you probably have much better
> > data about that than I do :)
> 
> RedHat patches their kernels with current code of the drivers that their
> customers use (including i40e and ixgbe)
> One could expect that changes made today to those will reach RHEL 10.3,
> even if it would be named "kernel 6.12".
> 
> (*) the changes will likely be also in 10.2, but I don't want to make
> any promises from Intel or Redhat here

But how many i40e users are actually on the most recent version of RHEL?
Not very many, is my guess. RHEL9 is 5.14, and has the old behavior.

If you actually have data on that, obviously that's different. But it
sounds like you're guessing just like I am.

