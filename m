Return-Path: <netdev+bounces-177305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE23CA6EDC3
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAC23BB35B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 10:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDD825525A;
	Tue, 25 Mar 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke/f4Onm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B091EF099;
	Tue, 25 Mar 2025 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898492; cv=none; b=keTGjsVXhWBPoKgWDVbxh1CVcDAFCJCegYxleJ6ldmLIeGDxyaImJ7T+ljJocyjPRmUp5MqmKgwENDdot62dCx0b7MImKJstK2/d6sbMPBvHbhp9xzxvJxu6Xc7JS6IY77L7wT7W3zUD87JhE5bfrC7MLYmlme8b2PIALzV9eRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898492; c=relaxed/simple;
	bh=ynEc60K6YQeeOcyOvYuKO+SfYNwPtk04/dRhtnauNzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnupKtxV9rlDDEEEPILj8JV/ge7/r5jay5xFz/WUTczQkh+Tt31HiqogIxK0Tg1OuRTX4RpkFA3pYfk9pzo81Xe4SIjhlv59tk2Isrt2etfPxiMkfXUxZXUjcCkZMOhE39HSazrVzMyIwp6Fbb7cGQTEGNuiq2+aLHTKAq6+zTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke/f4Onm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E401DC4CEE4;
	Tue, 25 Mar 2025 10:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898491;
	bh=ynEc60K6YQeeOcyOvYuKO+SfYNwPtk04/dRhtnauNzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ke/f4OnmuUWItLRENhmJy648Pe71M1IKAzs3RZS2h/JjqKNXTmXcWr1AcwZ+yEzkA
	 u+nKn4DKBsNe3A1zp239hJJeT5uwMwwWF/pdQKuceQok3bQN3pa7QeQXicH62/XcrO
	 EO55eBChz7Quc9TxX1Af4ZZZRxoBuTO9tbR75J6Tpt3FZNND2lf2Q8n16FaU3kGSVH
	 FfMnitzr48057ndp1IpkjU2oTbksKQO76XGAoJaqmovvXP+g71pKfuPPZG9FdNhA3Q
	 ZKku/IGxizfNjYJh8K7lYpLtBGIOVwKTORpLxxAa0Z4qlNBZnZZBAAIQaC6FfvsJcF
	 /7HqrFsm3aXEg==
Date: Tue, 25 Mar 2025 03:28:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v2] net: hold netdev reference during
 qdisc_create request_module
Message-ID: <20250325032803.1542c15e@kernel.org>
In-Reply-To: <Z-HbGR1V9-1Fwf0H@mini-arch>
References: <20250320165103.3926946-1-sdf@fomichev.me>
	<20250324150425.32b3ec10@kernel.org>
	<Z-HbGR1V9-1Fwf0H@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 15:22:17 -0700 Stanislav Fomichev wrote:
> > I'm not sure if this is a correct sequence. Do we guarantee that locks
> > will be taken before device is freed? I mean we do:
> > 
> > 	dev = netdev_wait_allrefs_any()
> > 	free_netdev(dev)
> > 		mutex_destroy(dev->lock)
> > 
> > without explicitly taking rtnl_lock() or netdev_lock(), so the moment
> > that dev_put() is called the device may get freed from another thread
> > - while its locked here.
> > 
> > My mental model is that taking the instance lock on a dev for which we
> > only have a ref requires a dance implemented in __netdev_put_lock().  
> 
> Good point, didn't think about it. In this case, I think I need to
> get back to exposing locked/unlocked signal back to the callers.
> Even with __netdev_put_lock, there is a case where the netdev is
> dead and can't be relocked. Will add some new 'bool *locked' argument
> and reset it here; the caller will skip unlock when 'locked == false'.
> LMK if you have better ideas, otherwise will post something tomorrow.

I wonder if we can bubble up this module loading business all the way
to tc_modify_qdisc(), before we look up the dev. At this point we
already checked that user has permissions, so we can load the module,
whether the request is valid or not? Instead of adding another bool
we can probably kill the "replay" silliness.

