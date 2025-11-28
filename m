Return-Path: <netdev+bounces-242549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A18C9201A
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BCC3AA39F
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D64C322C9A;
	Fri, 28 Nov 2025 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="2AaxUO+N"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17A302140;
	Fri, 28 Nov 2025 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764333588; cv=pass; b=SYOPFfnWk2BSMXSwFa7zbSmzcduMArcFYCYVYxA9qD92alyd7Ndd7PJzeki6SfmxdneuGwpLUXmIRVD4X4FgkoUAqev7KtaYk0Yt3FaJK7/U1siAdw689BW+FJ3nY7wcwBwtATvokMsOZxc8Dzz4+gs9F6ZvRu+31yM6yiI1Vkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764333588; c=relaxed/simple;
	bh=z/hyl7WHpqzOxQdhSDlneWqV3+5Rcynfl1n2Iv6ZVjk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XzK4o7ho1R0VFpGVpZr41MTRVy3N2kILMCXm3kyX4GNBFSA8CerBCBxJZogp+CVa2jnCLKU9XdmdVcUxoKiyw30IPlGwLCTKDj+3WzHwFfrSF1rQi/UmxPf9xdq3tV2lYM042B4qJMiPKugBHTRfdLQK4duS3fNcB76P+DE6jiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=2AaxUO+N; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1764333541; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=N7hBEF44j33W5RRBjfiCnLO81LikSVPrzPgUY8zDwoLq0zBZ/sTYBtqYPHP/W9UsdXvTek0GYAIprs2CuWrhxUfUDXDcC6oTZnl5cZ2ajYqMFqMrmXl2nUQa73y36AFx5o57tllRlGCtiYFf7tbIOciF93GQYuJCh4s9pd5002w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1764333541; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Qff3YTwy34TMvs2vGS2LCJPVox+9U8C+N/xmeQUSwtE=; 
	b=lTMt4IF+p3juWW11yMnT1hPaYtcew9qLKEEosT0Bs/87Cq8QXgviwbTi1/ykOHOngVRyOc75oeOPmv843IENxrcNPKzYvWUoY1uJQyx7yXAIf0aMM8QJ/5qJnkRiM91Y/tv3zRoCmwEiB8Z8Oq+C5hAnR3bdSAnQCO7rZQGgiKA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764333541;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Qff3YTwy34TMvs2vGS2LCJPVox+9U8C+N/xmeQUSwtE=;
	b=2AaxUO+NOPsLD01L7ATdWdtMAOYpXc17UbRHTLJpE6UItKTXRafAMT9XGU7kCM+6
	PErIj+ZR+otaanhQJxdTxPkUGkBLW7OZXpgn/W2iZNUSosLeSclNAgPZfJQjKpcWsQI
	QUsiWGECZ8LS7QvhNKpii/p/iC+bxt2G3LGAGuVI=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1764333538812689.0522516836196; Fri, 28 Nov 2025 13:38:58 +0100 (CET)
Date: Fri, 28 Nov 2025 13:38:58 +0100
From: azey <me@azey.net>
To: "nicolasdichtel" <nicolas.dichtel@6wind.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>, "David Ahern" <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19aca794ddd.105d1f97f173752.5540866508598154532@azey.net>
In-Reply-To: <1d44e105-77bd-42e7-81f5-6e235fd12554@6wind.com>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
 <20251124190044.22959874@kernel.org>
 <19ac14b0748.af1e2f2513010.3648864297965639099@azey.net>
 <85a27a0d-de08-413d-af07-0eb3a3732602@6wind.com>
 <19ac5a2ee05.c5da832c80393.3479213523717146821@azey.net> <1d44e105-77bd-42e7-81f5-6e235fd12554@6wind.com>
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On 2025-11-28 09:38:07 +0100  Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> With IPv6, unlike IPv4, the ECMP next hops can be added one by one. Your commit
> doesn't allow this:
> 
> $ ip -6 route add 2002::/64 via fd00:125::2 dev ntfp2
> $ ip -6 route append 2002::/64 dev ntfp3
> $ ip -6 route
> 2002::/64 via fd00:125::2 dev ntfp2 metric 1024 pref medium
> 2002::/64 dev ntfp3 metric 1024 pref medium
> ...
> $ ip -6 route append 2002::/64 via fd00:175::2 dev ntfp3
> $ ip -6 route
> 2002::/64 metric 1024 pref medium
>         nexthop via fd00:125::2 dev ntfp2 weight 1
>         nexthop via fd00:175::2 dev ntfp3 weight 1
> 
> Note that the previous route via ntfp3 has been removed.

I just tested your example in a VM with my patch, and everything works
as you described. This is due to fib6_explicit_ecmp not overriding
rt6_qualify_for_ecmp(), but rather supplementing it with || - the
intention was for default behavior to be preserved for routes that
aren't created via ip6_route_multipath_add(), and from this example it
seems to work correctly in that regard.

And for ip6_route_multipath_add() routes, as I stated earlier the
behavior should not change either (except for the gateway check,
which is the only thing this patch wants to change).

wg0 has fd00::1/64, wg1 has fd00::2/64; Exact command history:

$ ip -6 r add 2002::/64 via fd00::2 dev wg0
$ ip -6 r append 2002::/64 dev wg1
$ ip -6 r
2002::/64 via fd00::2 dev wg0 metric 1024 pref medium
2002::/64 dev wg1 metric 1024 pref medium
...
$ ip -6 r append 2002::/64 via fd01::2 dev wg1
$ ip -6 r
2002::/64 metric 1024 pref medium
	nexthop via fd00::2 dev wg0 weight 1 
	nexthop via fd01::2 dev wg1 weight 1
...

To also test the patch's functionality:

$ ip -6 r add 2003::/64 nexthop dev wg0 nexthop dev wg1
$ ip -6 r
2002::/64 metric 1024 pref medium
	nexthop via fd00::2 dev wg0 weight 1 
	nexthop via fd01::2 dev wg1 weight 1 
2003::/64 metric 1024 pref medium
	nexthop dev wg0 weight 1 
	nexthop dev wg1 weight 1
...

And to make sure the v1 regression isn't present:

$ ip a add fd03::1/64 dev wg0
$ ip a add fd03::2/64 dev wg1
$ ip -6 r
2002::/64 metric 1024 pref medium
	nexthop via fd00::2 dev wg0 weight 1 
	nexthop via fd01::2 dev wg1 weight 1 
2003::/64 metric 1024 pref medium
	nexthop dev wg0 weight 1 
	nexthop dev wg1 weight 1
fd03::/64 dev wg0 proto kernel metric 256 pref medium
fd03::/64 dev wg1 proto kernel metric 256 pref medium
...

