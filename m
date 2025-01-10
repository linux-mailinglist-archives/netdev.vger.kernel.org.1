Return-Path: <netdev+bounces-156897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F7AA083DD
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 01:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250C97A056F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 00:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B585F9F8;
	Fri, 10 Jan 2025 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVGNX4E7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D329CE7;
	Fri, 10 Jan 2025 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736468308; cv=none; b=MUJ1hSOdWbzRY5tDEZWRnVCSFDA3MERXuJWJk/ch9t5E+mjNDjHmCax+ZBG+yTreToX3/emSaP2w5wgBLIOvkIAytEOld8ZP+kRbR0eJH3X6FHr1480PGdfJLQS7iK+ZfkRsCDVS32+L5pjDs6Zh4JUTi3nrm2EmPW2MfjvHnOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736468308; c=relaxed/simple;
	bh=XO4//si7CRhEuWaTig7kim5mVTo/v8SrkRAwabOzcQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUuhXnI6BHYQ63rlNl8yFQIyoOQgW4MrCb/nGyL+U8P9n4QbLwqy+KjWfx4qTpdCxZvJvK6ovrVz5Dg2s8uHQxDoAMlLSxZIcgqtU8/eKf8s0ResUqFHWzTHX+nsOFtKhDYFFJ2fiUi6EIdTAo0UtLYaEnMTYleMVdInD5hHZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVGNX4E7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE26FC4CED2;
	Fri, 10 Jan 2025 00:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736468307;
	bh=XO4//si7CRhEuWaTig7kim5mVTo/v8SrkRAwabOzcQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mVGNX4E7JGngZ+ef3EZWmMM7bxIAwsbvifxEcqHbHsqFlhvVAs/tLorLFZnLkKfSf
	 tZPh+kBA1hgJj1NucTzrhfL3NEEGelBI+9s8d4JzSxknsbL8oOfM5yl2DJP5x81iRs
	 MMzTlu6duY4dTn/bjfpyk66GLR26p4NA6W7TQ68OwyuRYK5Cokovc6P7xAb5Y1h0zd
	 rOiI82dEPF7ku0aI9L6U6/nxnIhYk9hRKchtyDdLJBTP8zueIeZQ32sG8Z7HFOKYQW
	 SSqCqGAwZF6PbWeQ7Vat3fvkOyMW9+kxhPpxASWO7yo+OqKNTsctxzjcCwLvXw8DfI
	 jZ4H0xrvAWTNg==
Date: Thu, 9 Jan 2025 16:18:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Li Li <dualli@chromium.org>, dualli@google.com, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com,
 tkjos@android.com, maco@android.com, joel@joelfernandes.org,
 brauner@kernel.org, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org,
 bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com,
 smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH v11 2/2] binder: report txn errors via generic netlink
Message-ID: <20250109161825.62b31b18@kernel.org>
In-Reply-To: <Z4BZjHjfanPi5h9W@google.com>
References: <20241218203740.4081865-1-dualli@chromium.org>
	<20241218203740.4081865-3-dualli@chromium.org>
	<Z32cpF4tkP5hUbgv@google.com>
	<Z32fhN6yq673YwmO@google.com>
	<CANBPYPi6O827JiJjEhL_QUztNXHSZA9iVSyzuXPNNgZdOzGk=Q@mail.gmail.com>
	<Z4Aaz4F_oS-rJ4ij@google.com>
	<Z4Aj6KqkQGHXAQLK@google.com>
	<CANBPYPjvFuhi7Pwn_CLArn-iOp=bLjPHKN0sJv+5uoUrDTZHag@mail.gmail.com>
	<20250109121300.2fc13a94@kernel.org>
	<Z4BZjHjfanPi5h9W@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 23:19:40 +0000 Carlos Llamas wrote:
> On Thu, Jan 09, 2025 at 12:13:00PM -0800, Jakub Kicinski wrote:
> > On Thu, 9 Jan 2025 11:48:24 -0800 Li Li wrote:  
> > > Cleaning up in the NETLINK_URELEASE notifier is better since we
> > > register the process with the netlink socket. I'll change the code
> > > accordingly.  
> > 
> > Hm. Thought I already told you this. Maybe I'm mixing up submissions.
> > 
> > Please the unbind callback or possibly the sock priv infra
> > (genl_sk_priv_get, sock_priv_destroy etc).  
> 
> Sorry, it was me that suggested NETLINK_URELEASE. BTW, I did try those
> genl_family callbacks first but I couldn't get them to work right away
> so I moved on. I'll have a closer look now to figure out what I did
> wrong. Thanks for the suggestion Jakub!

Hm, that's probably because there is no real multicast group here :(
genl_sk_priv_get() and co. may work better in that case.
your suggestion of NETLINK_URELEASE may work too, tho, I think it's 
the most error prone

