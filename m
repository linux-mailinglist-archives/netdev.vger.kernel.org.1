Return-Path: <netdev+bounces-177711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 939A6A715CA
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF6B188AAFB
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE7B1CF284;
	Wed, 26 Mar 2025 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfyxRNz/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E974419CC3E;
	Wed, 26 Mar 2025 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988737; cv=none; b=ZNtHOFmB9rFQziSLHJLFUvE1awvfps5OAemGXCjX0s4frBHEOUnY3SsnVQGsg+riBLtSWvS8Yc8U69Hop5hUBk92pOo+AG9Kdh1gUlFXqZMWc1uHEP+QxzZxvPUdJ19iCPTaev42qUvZmfBa9xE+GBxBA5ox8/S2XWxzU5QuZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988737; c=relaxed/simple;
	bh=XxJ/R0A/6NU31gwxUHeMvI7IXUrOyXZ4+BIOOlGBELY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jm0/5dXEDYHvyfotmRB9JQjrFYpVsMrOItGI4zyz0BETk39Vc9U/+A3uXiRel77KwkL22AsbLhL1pZ2vLOy4eVDfAGvsLleYuXGQZcBtuJB7J6nc7iEkQzGLBXf6TXwJ33yWwJpBQLjj8uU5vzVmEcjk8NaxyCErhkQl1UYbeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfyxRNz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D548CC4CEE2;
	Wed, 26 Mar 2025 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742988735;
	bh=XxJ/R0A/6NU31gwxUHeMvI7IXUrOyXZ4+BIOOlGBELY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IfyxRNz/pYcvbpAAeRWZHVDS6crXRdg9850zG5hM+4EtY81L/chaI0ujWXqg0xhPG
	 6gWZNb2iJD4G5OrhEwAAHbOyBh93Pt91YFcaoICxV4E3a2arHYs7Mx1DZwOJJ+jLkA
	 wvQQ4C30upC1Sh/kdcrdNvO+sAT5Jtn03yFbZKHeDoz+z3NVqJAgxKcmvIuDRWLlT6
	 BvLQAYkV2dpUtHZnhNs+aSbQMB98MkM5CT8S2Mpqnjlw0cdoKYNL+3H9IB0AF4OdNJ
	 tCxIIPyPhdL2TeWotpDIrnNvWWbld9Yq05Ahg8Lr/BQ4Kg7febSMl0bOyZDVZxSAbW
	 d33iNYQZeei8g==
Date: Wed, 26 Mar 2025 04:32:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>, Cosmin
 Ratiu <cratiu@nvidia.com>, linux-kernel@vger.kernel.org, Liang Li
 <liali@redhat.com>
Subject: Re: [PATCH net] bonding: use permanent address for MAC swapping if
 device address is same
Message-ID: <20250326043213.5fce3b81@kernel.org>
In-Reply-To: <Z-PVgs4OIDZx5fZD@fedora>
References: <20250319080947.2001-1-liuhangbin@gmail.com>
	<20250325062416.4d60681b@kernel.org>
	<Z-PVgs4OIDZx5fZD@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Mar 2025 10:22:58 +0000 Hangbin Liu wrote:
> > I don't know much about bonding, but this seems like a problem already
> > to me. Assuming both eth0 and eth1 are on the same segment we now have
> > two interfaces with the same MAC on the network. Shouldn't we override
> > the address of eth0 to a random one when it leaves?  
> 
> Can we change an interface mac to random value after leaving bond's control?
> It looks may break user's other configures.

Hard to speculate but leaving two interfaces with the same MAC is even
worse? I guess nobody hit this problem in practice.

> > looks like this is on ctrl path, just always use memcmp directly ?
> > not sure if this helper actually.. helps.  
> 
> This is just to align with bond_hw_addr_copy(). If you think it's not help.
> I can use memcmp() directly.

Yes, I don't think it helps.

