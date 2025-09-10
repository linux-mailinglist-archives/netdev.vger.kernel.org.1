Return-Path: <netdev+bounces-221807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCFEB51E9B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 19:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 428AC7B3CAC
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45C028A73F;
	Wed, 10 Sep 2025 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg5+ZY3+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A3199BC
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524083; cv=none; b=kJl+oSgcE1uZSNVDY83vCLP+ZXQvZYdaDkTbF73SnCu6CeppLfCI/HHQIZgQU5cmYjrRnOY9epi3nqRBGYaksZ2lrzwYNy82FKx7yWRXa6iAxhl2w7vtypo+HXA9vqI5jYF9RTYQhxlMGCfEDyKPlCwATqj1575iqUx8/KFHE00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524083; c=relaxed/simple;
	bh=P1PZxmhLFUxUAn9bK7+XNkeiu3mkphjr56ZLZUDJPUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLWI68iDBtzpOb6xWOfTmIaz9ThjU/gWzr2xZKnOL75zNUzdAUhApZLQhlVlUK1gi8H25FR/9TycWa4gAoFdcmY2Wx4LnWoaNZyPNw24ChwoiTyYiPRvCNZZn/+YEjEa+4VWSb6Atflgke/SJVNqW9icq+3Y+V1/duJ0fP1IZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg5+ZY3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB90C4CEEB;
	Wed, 10 Sep 2025 17:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757524083;
	bh=P1PZxmhLFUxUAn9bK7+XNkeiu3mkphjr56ZLZUDJPUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jg5+ZY3+CQM3mVPjAwRuDjZXxPJMUbY9V1njiF5zPWtGQrQ3GuRuqs8bXkHkuWBeq
	 AAAJ7b/nyDL3453NJtCP7n/DRv9TC5F09WYzfW13foZnbXWUA3Xdtvu4m8Wnc3snAb
	 E5QmZ6AjK+Tttn6K7GApsh34ak7gpucBt+IPWjoRn6WWOtd7PUuasm63oCdwSr9R6y
	 qW9P+D9har2ZYKkSqTR27IVndnDHeWSu0+PHzwqPEvhyeTqS9+R1hyllYwf6ZzRHtH
	 YOKHfJ2ASLNQye84hC5BgfJh+7wIWdlW5w/lB8cqFFR18Jfdr6+OGlZlsDlI9ysg6b
	 AsU51sA30NHvA==
Date: Wed, 10 Sep 2025 18:07:58 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Murali Karicheri <m-karicheri2@ti.com>,
	WingMan Kwok <w-kwok2@ti.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCHv3 net 2/3] hsr: use hsr_for_each_port_rtnl in
 hsr_port_get_hsr
Message-ID: <20250910170758.GC30363@horms.kernel.org>
References: <20250905091533.377443-1-liuhangbin@gmail.com>
 <20250905091533.377443-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905091533.377443-3-liuhangbin@gmail.com>

On Fri, Sep 05, 2025 at 09:15:32AM +0000, Hangbin Liu wrote:
> hsr_port_get_hsr() iterates over ports using hsr_for_each_port(),
> but many of its callers do not hold the required RCU lock.
> 
> Switch to hsr_for_each_port_rtnl(), since most callers already hold
> the rtnl lock. After review, all callers are covered by either the rtnl
> lock or the RCU lock, except hsr_dev_xmit(). Fix this by adding an
> RCU read lock there.
> 
> Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array for slave devices.")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Thanks,

I agree with your analysis.

Reviewed-by: Simon Horman <horms@kernel.org>

...

