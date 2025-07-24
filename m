Return-Path: <netdev+bounces-209784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1499FB10C41
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9465AE53C2
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F028B2E173E;
	Thu, 24 Jul 2025 13:53:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A794A2DCF5F
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365213; cv=none; b=tsafqQ4HhC3B/8/EYRTqkiz3S86CzWZSvGxBM7ATLi0Ts5qUYk72EzZ/tU0f6Kx1J3axFOsCU6OgEAUukqGhIfeQvig58/oOfAegFK5QyR/Zp5Nl8lfoOCQflzGBR7WvUWjSBOYSMEnwYsm9DBCWQ50M+7xYgW6ayzzKe3m8C10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365213; c=relaxed/simple;
	bh=HZRgSR6Xhs/3eA0j7rai6F/vzfme0n6Sih7d4FuhfTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0dIZvrgAWtkqQW9tLzFDpCp9GImnVC+3HVSD39sPeBi7FfngrlGhgqRtR3WqQHeU2ZiT6QCkbw/qIjwjrCpQLZ2etWr0xRGf6opoAqWl3mZ9sNb5syrgaGh4CNMdYJL0BaKmUlHifgkB1XIuIFOXGochbHwzxtJ8mtP3fkCQoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from equinox by eidolon.nox.tf with local (Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1uewO1-00000002zKC-0RpR;
	Thu, 24 Jul 2025 15:53:29 +0200
Date: Thu, 24 Jul 2025 15:53:29 +0200
From: David Lamparter <equinox@diac24.net>
To: David Lamparter <equinox@diac24.net>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Rohr <prohr@google.com>
Subject: Re: [PATCH net-next 3/4] net/ipv6: use ipv6_fl_get_saddr in output
Message-ID: <aII62Z85k7UCX-cY@eidolon.nox.tf>
References: <20250724131828.32155-1-equinox@diac24.net>
 <20250724131828.32155-4-equinox@diac24.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724131828.32155-4-equinox@diac24.net>

Of course I find a mistake half an hour after sending it out...

On Thu, Jul 24, 2025 at 03:18:24PM +0200, David Lamparter wrote:
> @@ -1111,31 +1111,44 @@ static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
>  	struct neighbour *n;
>  	struct rt6_info *rt;
>  #endif
> -	int err;
> +	int err = 0;
>  	int flags = 0;
[...]
>  		struct rt6_info *rt;
> +		bool same_vrf;
> +		int err = 0;

I accidentally introduced a second, shadow copy of "err"...

*sigh* should've built with W=2 so I get -Wshadow

...fixing and resending.


-David

