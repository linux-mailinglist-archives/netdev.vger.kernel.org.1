Return-Path: <netdev+bounces-157463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A52A0A5F1
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB17B162563
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 20:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BAC1B86F7;
	Sat, 11 Jan 2025 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4H6o2g3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36E14A0B3
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736627723; cv=none; b=XaVetRP5jyFrrbCY/owQNvufryOwGzEFgg0VKeqiqCY01Zl4rHQUeEmCPmDyB7lYLkkfldznlQY4ciAnuTGwNEOZWCC8680ZokD3bmtu7VT5ivkb3VGVD0oW9+uUDSe8Idg4JX57HpCNwHUeJZxhg2VS2dCsEKJcUGNHS+waEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736627723; c=relaxed/simple;
	bh=wvK0osaqfGEwdEjk/jOpzfs/W64YRiag0XrbSnwXKiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXgNEiJgox9ti6Qg1FR+voOlX3Uy3DMOnvPDN80E/YePsYG+N6X5SZyyN1DWQSLvM+9AP9cPpGyAj8uh2rqCMtEEHrL0dBVxC+bIgQ0Dibb6VFFyOTDVeYCm8AS47L+8oEoJNK+QcqBpbBtfuYJTPq8JFhYqD1K0B3913VxZAlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4H6o2g3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBA3C4CEDD;
	Sat, 11 Jan 2025 20:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736627723;
	bh=wvK0osaqfGEwdEjk/jOpzfs/W64YRiag0XrbSnwXKiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U4H6o2g3W8u8hSbK8xuvKGxNQ1bj2djIjbyDKZBkCWufdmUUUOxUoepTCEgAsXw+H
	 QlKYdM/rHcefLCS6DRTx41L7PRB/QIjH3Q9YKVryC1gtTndZgiXrQBU8OEHkJ7uzHG
	 K6BczRei8YG3HRgoR4rTNd8nrOeUgzvyiRYImzJtFTFum0dw0nN7q2Fw/vrOoilS0C
	 +l6FbyKWELJnSIKlQUZZFQhZ3rtQ27CNsMqgXDhc17y/ilQRDmSCrnaPLjOVFjGORL
	 45pxYdGgU1iLQ6CuDrF/dqpTBLEgGQe71r4wAoXCNJujjU4dLywGpk4sGMdkVodPwn
	 fkPuI00onzvDw==
Date: Sat, 11 Jan 2025 12:35:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 2/2] net: initialize netdev->lock on dummy
 devices
Message-ID: <20250111123522.7e4d1519@kernel.org>
In-Reply-To: <30c4dfe3-8991-4659-8379-47f0ac0d6f31@lunn.ch>
References: <20250111065955.3698801-1-kuba@kernel.org>
	<20250111065955.3698801-2-kuba@kernel.org>
	<30c4dfe3-8991-4659-8379-47f0ac0d6f31@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 19:58:40 +0100 Andrew Lunn wrote:
> On Fri, Jan 10, 2025 at 10:59:55PM -0800, Jakub Kicinski wrote:
> > Make sure netdev->lock is always valid, even on dummy netdevs.
> > 
> > Apparently it's legal to call mutex_destroy() on an uninitialized
> > mutex (and we do that in free_netdev()), but it doesn't seem right.
> > Plus we'll soon want to take netdev->lock on more paths which dummy
> > netdevs may reach.  
> 
> I assume here that dummy does not call alloc_netdev_mqs() or one of it
> wrappers? 

Yes, we have both dummies which go thru alloc and static ones.

> That is how the lock seems to get initialised for real MAC
> drivers. Are there other bits of initialisation in that function which
> dummy is missing? Should we really be refactoring alloc_netdev_mqs()
> to expose an initialisation helper for everything which is not related
> queues?

You make a good point. Let me do the opposite, we only have two callers
of init_dummy_netdev(). Instead of unexporting it let me delete it
completely and make the two callers allocate the netdevs with
alloc_netdev_mqs().
-- 
pw-bot: cr

