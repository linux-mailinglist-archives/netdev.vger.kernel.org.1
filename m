Return-Path: <netdev+bounces-110505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F8492CBDF
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00C51F23B9D
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 07:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381758248C;
	Wed, 10 Jul 2024 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRs3JNub"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084B729AB;
	Wed, 10 Jul 2024 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720596427; cv=none; b=qI2eO1+TFJdZYY0qrOfexaU+XQChQ6ZlhHkrx4AMzBXmIAbNIHSeZdlyRbSXQo7HGsE60vEcBFX6koeL4qKf8ldSSZl6PyqSUr+Oq+si/Nb4QSE6VVQamemj1JaesMFhCm84Zlbs+pU70hcFyWjZaMUCyMUkqkkKywgpIOz20yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720596427; c=relaxed/simple;
	bh=+KMYWayEGAvxREze4tvIWkgB2gUtkxFPdOXXQOZS2cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zmnb/TIjws0Nhz57SbYejgRdjMWn7QPr0aLSL31q0uq9EIo7hHM9zXNFQrHsGmtgatOqQ/rt2PypiYjKd9BI0VUJJj1QDc7VdZtQ2WZ8bDF2qa7j8CaU3X3oKZ7ooukZLtdNDL9OC+K22I0y03tOJlXXQ7uAGR4sVbK+7nqxt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRs3JNub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B783AC32781;
	Wed, 10 Jul 2024 07:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720596426;
	bh=+KMYWayEGAvxREze4tvIWkgB2gUtkxFPdOXXQOZS2cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rRs3JNub5pwPBgZpiCL8Fu8uN22NItrtnjuO5+x+qI3Z0SN+JuL3+7gKNORDaOQjq
	 HOdXrUGCEmB6yIW84UejzwZg31Olr1JUu3NbJypVVtIE+ue5B/EcYuL9xtMZdzRJ2G
	 ssSqq/Ne8W2ri/oW7/OOLxeJDr5LXgH1sUmFSLzAnnh8IvVCFe48uf4vvx3SW2ERH/
	 7iLF52Ck+aSwwwA+0pkrFNEH0XoVjj6OoAJcltAghbI5DFEtMy0NcbK3lQLTFttShp
	 GD5RXxMWxMLqn5oGA6emAFG6DIRbR+Dd0KUNg4tjg/b51PU92VjkQf1eHTbw6fdD6b
	 pFOSPs4dVEJeg==
Date: Wed, 10 Jul 2024 08:27:00 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	keescook@chromium.org, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device
 _properly_
Message-ID: <20240710072700.GQ346094@kernel.org>
References: <20240709125433.4026177-1-leitao@debian.org>
 <20240709181128.GO346094@kernel.org>
 <Zo2bYCAVQaViN6z8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo2bYCAVQaViN6z8@gmail.com>

On Tue, Jul 09, 2024 at 01:19:44PM -0700, Breno Leitao wrote:
> On Tue, Jul 09, 2024 at 07:11:28PM +0100, Simon Horman wrote:
> > On Tue, Jul 09, 2024 at 05:54:25AM -0700, Breno Leitao wrote:
> > > From: Alexander Lobakin <aleksander.lobakin@intel.com>
> > > 
> > > In fact, this structure contains a flexible array at the end, but
> > > historically its size, alignment etc., is calculated manually.
> > > There are several instances of the structure embedded into other
> > > structures, but also there's ongoing effort to remove them and we
> > > could in the meantime declare &net_device properly.
> > > Declare the array explicitly, use struct_size() and store the array
> > > size inside the structure, so that __counted_by() can be applied.
> > > Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
> > > allocated buffer is aligned to what the user expects.
> > > Also, change its alignment from %NETDEV_ALIGN to the cacheline size
> > > as per several suggestions on the netdev ML.
> > > 
> > > bloat-o-meter for vmlinux:
> > > 
> > > free_netdev                                  445     440      -5
> > > netdev_freemem                                24       -     -24
> > > alloc_netdev_mqs                            1481    1450     -31
> > > 
> > > On x86_64 with several NICs of different vendors, I was never able to
> > > get a &net_device pointer not aligned to the cacheline size after the
> > > change.
> > > 
> > > Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > 
> > Hi Breno,
> > 
> > Some kernel doc warnings from my side.
> 
> Thanks. I will send a v3 with the fixes.
> 
> > Flagged by: kernel-doc -none
> 
> How do you run this test exactly? I would like to add to my workflow.

It can be run like this:

./scripts/kernel-doc -none include/linux/netdevice.h

Or this:

./scripts/kernel-doc -none -Wall include/linux/netdevice.h

In this case the second invocation has a lot of output relating
to documentation of return values which is unrelated to your patch.

But the first invocation shows the issues that I flagged in my previous
email.



