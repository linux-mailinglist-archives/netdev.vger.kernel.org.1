Return-Path: <netdev+bounces-183899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5D6A92BD9
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD087B2836
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7666F1FFC49;
	Thu, 17 Apr 2025 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VBPn+fdt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C601FECB0;
	Thu, 17 Apr 2025 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744918350; cv=none; b=UixlPcY3SL9A+RP1GfNgeOYHJRtshpFlkGrTnN6+HErr1OF2BUZwo04opCuylaHkUzg5uL5x3qqxEFjsj8St5J6D9GdfPQ1uzYB/t+wsJQwKWPZwtrPh2IrsNINoONkzrejDzjydSBUw/zdWVJixlDkzIZhvL3VYM+qFPl7IjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744918350; c=relaxed/simple;
	bh=MIc4Fa3UNak1GOKDFG/+Phqs38nCj6oMBoNExcxtdu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGry1dujIqB7qJVJHEjFDogxBjcW59u0mvc6jiX+C0pJm+FhxEZ7FO6FcoVF7Xo2xfXbJJMmQ4ASSpXHrl5OJMivQB6bf5BjskMRjAZU3HlA/HpcA9Uf1YgQ/+2uY4SS6GqUn9oOsktEJUHRQNFa9MN3a0jsryld05et9+VXrgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VBPn+fdt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ax2uSXScmj7yDhI+qlN3Eb7imhRX9BqV/YdJ2tBns6w=; b=VBPn+fdttnap7ChBbym3IH8GGX
	Pc6up9go8ANclrT4BvHXPSWt5C5Wh6HpqYXisS5YDerXxpms+N4RWFxOa5NIaduiwV5iFErhb5Oig
	OIBP7rDLHFCUsBeKjaONQjiWEWXs8G72o/clXbUfZpn/fwaQF7QjH9s2P9FeQNdaTjq4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5UyD-009pCG-Tg; Thu, 17 Apr 2025 21:32:21 +0200
Date: Thu, 17 Apr 2025 21:32:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v3 0/8] ref_tracker: add ability to register a debugfs
 file for a ref_tracker_dir
Message-ID: <0f25e2ae-70e4-442d-af45-fd927c6faafe@lunn.ch>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>

On Thu, Apr 17, 2025 at 09:11:03AM -0400, Jeff Layton wrote:
> I had previously sent some patches to add debugfs files for the net
> namespace refcount trackers, but Andrew convinced me to make this more
> generic and better-integrated into the ref_tracker infrastructure.
> 
> This adds a new ref_tracker_dir_debugfs() call that subsystems can call
> to finalize the name of their dir and register a debugfs file for it.
> The last two patches add these calls for the netns and netdev
> ref_trackers.

Thanks for reworking this to make is more subsystem generic. I hope
the GPU people also find it useful.

	Andrew

