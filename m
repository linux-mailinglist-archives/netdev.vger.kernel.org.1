Return-Path: <netdev+bounces-83176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1604A89132F
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 06:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7721C22524
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 05:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0EB3BBE3;
	Fri, 29 Mar 2024 05:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKexp1E2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981D2232A
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 05:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711690311; cv=none; b=rr3oFJ8X2EkSREeF8nwRYjLYUY1IrlM238plUZZofbgwIkgw1OCPgluyWzu5xe7RZfNeJOrCzfuDVWjR4cJ5KacQ8dGdmUrWOwO+FD2p0T/YHJv/449U6CzoY0g8vxlk+WdaUlhiVh5bVlq41JPJkyt+w9w21yGJRaAgWRP1h1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711690311; c=relaxed/simple;
	bh=k8Cr7OAeZOxEl1Mq9doorzeoodfWH4GqnXyMkzgpLl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZqqET+kbPS5KCAZWGCPAMbl67T02zxw2WEr5FU1ABM8XT9frq4n3ezPmdYqwjjI7pICmfBDJwjuesxR2TlKkZcRCS3mXLAw1nZQZB2NIUM+bja/uSSKrW5+sBcOZEDyc1PyYRyq9Zgq3QArTYe1wICxGBm8OAJxIvCobWk2UVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKexp1E2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F081C433C7;
	Fri, 29 Mar 2024 05:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711690311;
	bh=k8Cr7OAeZOxEl1Mq9doorzeoodfWH4GqnXyMkzgpLl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AKexp1E2wh0GWz82ezCcBmPvICC+cl1y1o8LbMK5qFDYMNaESRGPatSNi5+bNB0RB
	 Z0d2uNl07MyEpew4vF37OgacnkM5HJV9UsMD84tkI1KZMBJytTWnp8eiZt0cj5FNrT
	 pEduIhwpXZgmp1E3nEKUBEZ3z3LaEomEdWHBuDGXB2YxHJo3vcYhXq04pHeNLjJ8Cy
	 j1JAcl4+DER/DAMgZpQWmxN6TNLFiVjxRncwc1ZeMni+cTiecezHgkfueSsRU8YFNv
	 utBkQiSx/b246eN0ogNDyQw1FpLUmzsy+I+JSltiw5qmdGoq2BqIKf0j2UPiyxjGLy
	 6dMLoEF7YqIdg==
Date: Thu, 28 Mar 2024 22:31:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [net 06/10] net/mlx5: RSS, Block changing channels number when
 RXFH is configured
Message-ID: <20240328223149.0aeae1a3@kernel.org>
In-Reply-To: <20240326144646.2078893-7-saeed@kernel.org>
References: <20240326144646.2078893-1-saeed@kernel.org>
	<20240326144646.2078893-7-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 07:46:42 -0700 Saeed Mahameed wrote:
> Changing the channels number after configuring the receive
> flow hash indirection table may alter the RSS table size.
> The previous configuration may no longer be compatible with
> the new receive flow hash indirection table.
> 
> Block changing the channels number when RXFH is configured.

Do I understand correctly that this will block all set_channels
calls after indir table changes? This may be a little too risky
for a fix. Perhaps okay for net-next, but not a fix.

I'd think that setting indir table and then increasing the number 
of channels is a pretty legit maneuver, or even best practice
to allocate a queue outside of RSS.

Is it possible to make a narrower change, only rejecting the truly
problematic transitions?

