Return-Path: <netdev+bounces-190924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4F3AB941C
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 04:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCADD4A8617
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 02:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8241F1510;
	Fri, 16 May 2025 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAoxE5I5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809A157A72
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747362971; cv=none; b=To2N9taV5njKA2ovDPRm7HPKB34Gmv9vCOh22Pa6ODD9VEVVQevhH3iL7tjY5XWL98iPPRuJ0+KGnH3lj8YOL8kVh294wr6Uzs2kriObgKzoVHqRUL65IesLD5uTgkK2ziUNFUNHnRtMFAzy9n/v8W9i1bhUERDxSMFZtyY6mHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747362971; c=relaxed/simple;
	bh=7lct8O6mJswgOdTwBIRtg+wZI8EOJpAs/M9T2luQz3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ia8HlrHJ3eR7g2eBf7gAJbe+z9JU9C3gk2Qwd/kQBVE5agHaHenNOByTQaZGZnYf4udukmiTUykhrGdnLby2vp2I98Irk/iO/Bsg5DJUT97UdqRtsmA8fZl0gOzQ8K4qFut7LI+NrV4RigrBkRwKbdgl7dQiM6lgGa4kTVs4WrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAoxE5I5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CA6C4CEE7;
	Fri, 16 May 2025 02:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747362970;
	bh=7lct8O6mJswgOdTwBIRtg+wZI8EOJpAs/M9T2luQz3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VAoxE5I5+GtwtT8Jhbc7PHAK/ZfS7lB4pEHmbpGeCpltcYdGyU0oXkKAySuXknpUN
	 HC6j1gEbcfDRhgq9L9iZZFgvUSq1MNmH7TxhbU7/Neou6Vdz5EfRow7AEUaUBU6N0A
	 ycvQoLC2w+lGjQzWh7pdgTh24vkADXg8Vs4u39/z7bmlYVS0nMvu6q25/dlPK93wLW
	 wPtJdTrhdsi6L6JeYTfP24i2UYs0tBWA3/Uf62Wp/PAjYZoMiXuPmiJqEFfJA0pQhZ
	 1tnTzhbRH0mtO657C5M0sJjYe+r38P55LvruMbjjoar3E3hW/AD8eWpP7SIk/ZYA+C
	 b/0zE970G1o3g==
Date: Thu, 15 May 2025 19:36:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <sdf@fomichev.me>
Subject: Re: [PATCH net-next] net: let lockdep compare instance locks
Message-ID: <20250515193609.3da84ac3@kernel.org>
In-Reply-To: <20250516015114.40011-1-kuniyu@amazon.com>
References: <20250516012459.1385997-1-kuba@kernel.org>
	<20250516015114.40011-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 18:49:07 -0700 Kuniyuki Iwashima wrote:
> > +#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
> > +	/* It's okay to use per-netns rtnl_lock if devices share netns */
> > +	if (net_eq(dev_net(dev_a), dev_net(dev_b)) &&
> > +	    lockdep_rtnl_net_is_held(dev_net(dev_a)))  
> 
> Do we need
> 
>   !from_cleanup_net()
> 
> before lockdep_rtnl_net_is_held() ?
> 
> __rtnl_net_lock() is not held in ops_exit_rtnl_list() and
> default_device_exit_batch() when calling unregister_netdevice_many().

Or do we need

  if (from_cleanup_net())
  	return -1;

?
Is the thinking that once the big rtnl lock disappears in cleanup_net
the devices are safe to destroy without any locking because there can't
be any live users trying to access them?

