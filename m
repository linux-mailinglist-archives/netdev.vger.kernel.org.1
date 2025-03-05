Return-Path: <netdev+bounces-172110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CC3A5042B
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D943A345E
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D2C24CEF1;
	Wed,  5 Mar 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vE3so+VU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73A7250C0E;
	Wed,  5 Mar 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190967; cv=none; b=WYDFgFjPVO3p2zhTCB2uHJ83YS013SlAhRImugN9hNCCDy49indemTrqmfLHv/oclXtjESH3Q8yUPIzp6D+1j2w0dFrYx0VqmsYqjCViJdF/oFRA6ivsJs7HLTit6kb28B60Ct60XCNnIMmirQYwrAxXVexGGGh5KrEM6k2lNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190967; c=relaxed/simple;
	bh=34ESxOJEeAs4fjL9yCcbHLzn+raX+7vFYbT1qaZP/yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAwk8pLK/XZGQUmLui/GYndrMlqvYSbWefunElnyCL7Eexs39KA6Mc4z7RlH0Q3ULLOyCiCdAMAyvPg42sOrvlvJGzf/PbeqBP6K/tueL7WR5NYUMdX1nyRl8Z0vU6KKwalh6zT8JoV0WzAs+4ekLETXHPpAPTg82s0Lz07gU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vE3so+VU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=b1nfU4FT3QIaUOdeRhwuaCwP2Gua24dGPYjqzZUZaB4=; b=vE
	3so+VUbnNuEVru+YiIzdQihTLQDgAR+WtENCQIHSvr6ugYsIQZSGS5DNXs/iwzGVAkScLb2NyRuqQ
	Gg2jIPuQ7o1+hwBsx/rHTg9pZGNSIkNwim06TXw8L7YH67NOvbsDjNxf1ZJGQwxpbgXwEBvLBDrCM
	9i+I2c/+qdQmtfY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tprJ4-002Wey-F8; Wed, 05 Mar 2025 17:09:14 +0100
Date: Wed, 5 Mar 2025 17:09:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Amerigo Wang <amwang@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net] netpoll: guard __netpoll_send_skb() with RCU read
 lock
Message-ID: <580ce055-b710-4e97-8d91-1cfea7ec4881@lunn.ch>
References: <20250303-netpoll_rcu_v2-v1-1-6b34d8a01fa2@debian.org>
 <20250304174732.2a1f2cb5@kernel.org>
 <20250305-tamarin-of-amusing-luck-b9c84f@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305-tamarin-of-amusing-luck-b9c84f@leitao>

On Wed, Mar 05, 2025 at 01:09:49AM -0800, Breno Leitao wrote:
> Hello Jakub,
> 
> On Tue, Mar 04, 2025 at 05:47:32PM -0800, Jakub Kicinski wrote:
> > On Mon, 03 Mar 2025 03:44:12 -0800 Breno Leitao wrote:
> > > +	guard(rcu)();
> > 
> > Scoped guards if you have to.
> > Preferably just lock/unlock like a normal person..
> 
> Sure, I thought that we would be moving to scoped guards all across the
> board, at least that was my reading for a similar patch I sent a while
> ago:
> 
> 	https://lore.kernel.org/all/20250224123016.GA17456@noisy.programming.kicks-ass.net/
> 
> Anyway, in which case should I use scoped guard instead of just being
> like a normal person?

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

  Section 1.6.5: Using device-managed and cleanup.h constructs

  Netdev remains skeptical about promises of all “auto-cleanup” APIs,
  including even devm_ helpers, historically. They are not the
  preferred style of implementation, merely an acceptable one.

  Use of guard() is discouraged within any function longer than 20
  lines, scoped_guard() is considered more readable. Using normal
  lock/unlock is still (weakly) preferred.

  Low level cleanup constructs (such as __free()) can be used when
  building APIs and helpers, especially scoped iterators. However,
  direct use of __free() within networking core and drivers is
  discouraged. Similar guidance applies to declaring variables
  mid-function.

So you need to spend time to find out what each subsystems view is on
various APIs.

	Andrew

