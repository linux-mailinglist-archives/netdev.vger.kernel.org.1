Return-Path: <netdev+bounces-221804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798BCB51E89
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 19:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396DF5E39D0
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8622BE7D7;
	Wed, 10 Sep 2025 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkeBAN29"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5F2798F8
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523979; cv=none; b=MCmOlQPggcg0K2PIkCaemMMONbQvvymSMqAxs5zC8+hxSHGmfoTAxZXk7F1x3B3Hp2X+5cfTCuLbieOAWDKn+Chb66eEik7E2qzGaC/Db71zReT62hctIHCSOvp5H4dt71iPHmyww8kZzhemhb0vEUKHwkfi6TuBKh37O/KXcXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523979; c=relaxed/simple;
	bh=whB7nOqi1qIIDXi/OTr7J2+cfFnDVG8mZiG7ZMB1MO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dw9zZNhQk98sRSdfyXl6tC74wxxJ/1LHYynnaiTJWliELkHgfE6Sim/1ZXWlknnh+mlgLehrro1R0j++MHCkMyDZ+89wDLtPuwK+EiCBcWLZiM9Q0pJGZrMr9Lq1at1Y3/7Iby8pfhRN/+gKy2X60xcQI87ChVP+lFQaZRyuv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkeBAN29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB0EC4CEEB;
	Wed, 10 Sep 2025 17:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757523978;
	bh=whB7nOqi1qIIDXi/OTr7J2+cfFnDVG8mZiG7ZMB1MO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkeBAN29JoLnnznOSCvjHPMeZN3xpU/sMfjNLxcjJYJXkeVLHb8yCq8GpqQseuQSg
	 W0NFVVXmfFe5VEV72EkvhiJ+HgQjNRk/l9ToxrN9SC+jRH/arCSsShMrEKCGJcZfMu
	 sbgEP7d7pB+bgAFOMHOqeVvUulqZNKQ87XjJgIVag54L8qpeZkkTZ52SEZ/qRmPoiW
	 1q5kbHEr7yt2AQ7TaH2eHSkYFq2+hDpIVZFVRFfOTnzdzjDZEUKUAyn/Rzd1KFyCoA
	 N45QX5mJ4klOtowB9eunLFD9XOP+6wqvn9ifP0Xlg5Y58lq6AofkRRNJtEIXTUTMfL
	 LH7d6nAoKkTJQ==
Date: Wed, 10 Sep 2025 18:06:13 +0100
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
Subject: Re: [PATCHv3 net 1/3] hsr: use rtnl lock when iterating over ports
Message-ID: <20250910170613.GB30363@horms.kernel.org>
References: <20250905091533.377443-1-liuhangbin@gmail.com>
 <20250905091533.377443-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905091533.377443-2-liuhangbin@gmail.com>

On Fri, Sep 05, 2025 at 09:15:31AM +0000, Hangbin Liu wrote:
> hsr_for_each_port is called in many places without holding the RCU read
> lock, this may trigger warnings on debug kernels. Most of the callers
> are actually hold rtnl lock. So add a new helper hsr_for_each_port_rtnl
> to allow callers in suitable contexts to iterate ports safely without
> explicit RCU locking.
> 
> This patch only fixed the callers that is hold rtnl lock. Other caller
> issues will be fixed in later patches.
> 
> Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array for slave devices.")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/hsr/hsr_device.c | 18 +++++++++---------
>  net/hsr/hsr_main.c   |  2 +-
>  net/hsr/hsr_main.h   |  3 +++
>  3 files changed, 13 insertions(+), 10 deletions(-)

Thanks,

I've done a once over all the callers of these functions
(which was quite a task) and I believe they all hold
either RTNL or rcu_read_lock.

Reviewed-by: Simon Horman <horms@kernel.org>

