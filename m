Return-Path: <netdev+bounces-158523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF11A125C0
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DDBA3A70FD
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B395D8F0;
	Wed, 15 Jan 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrnEH5eH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20344EB48
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950702; cv=none; b=ZIeyrtq+Zj/WWsYVQg/i0tPQ9UeflcDx14MHYrpdJzOu7EqSExoF9qKlFJ2/e/gB6LZP1lcGAvvjpB7TWVTxLTyQ6RTqbT/2c8wgqVmFsJlvBpAoubG9rdRWSaW5m3AgDOmW+TKkpmckF6O4d90aB7q1lPvhsNfWU9KQ/GUVPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950702; c=relaxed/simple;
	bh=sxOwuhIjz2aYw/uHxqhO5dZBRyz+NQqmZTxQ/5BJ5tw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4kH6Arvv8RL4ZsyqLVvsqmw1+/oVIRWd1UI2I+m5z3zTkFh5J3RAo5Tq/8EqpeUg2mJ7ouIciu8oNEcnjc+81VDNFWhgM03z6c8LPMZ7Tncf7vpiqF1z81abgVFA/gRJzT7PmE4P7IX4vsBVOND8U5s1xPp7nXj+B32Cu3DLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrnEH5eH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2314CC4CED1;
	Wed, 15 Jan 2025 14:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736950701;
	bh=sxOwuhIjz2aYw/uHxqhO5dZBRyz+NQqmZTxQ/5BJ5tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QrnEH5eHXOhtvtRO1QwSzcT6+dXJswuLGlpsPYr5+BAVgsO3rovgOadFRyeYwEdCp
	 m8LeU4Y5BMo6O0dBvoiLv7RYYIaB/kft1hteLYh+IXw1j9Hp+0gCKBZoEZkUrTIhTN
	 gYhh6rSkBYszHJlAE19WrUNMx619HnN64+/0258coeU7lhbKqPo+Ly4MvqbwEJZ3MB
	 AuKpOwVuN7e1TNODFF3InfCnNVjqWWbXSRSOVEq+UqBSmv92EHhuZyxwUtixd7vRU8
	 6LRf9GFDBMWtiODwo9n/mTpiLGiiFGxgKuxVbVv2ASgZLOOr1NLlOp4CbTJa8sLklK
	 DWuEFERWRsgNw==
Date: Wed, 15 Jan 2025 06:18:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <jdamato@fastly.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 02/11] net: make netdev_lock() protect
 netdev->reg_state
Message-ID: <20250115061820.4d6d03a9@kernel.org>
In-Reply-To: <20250115083023.31347-1-kuniyu@amazon.com>
References: <20250115035319.559603-3-kuba@kernel.org>
	<20250115083023.31347-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 17:30:23 +0900 Kuniyuki Iwashima wrote:
> > @@ -10668,7 +10668,9 @@ int register_netdevice(struct net_device *dev)
> >  
> >  	ret = netdev_register_kobject(dev);
> >  
> > +	netdev_lock(dev);
> >  	WRITE_ONCE(dev->reg_state, ret ? NETREG_UNREGISTERED : NETREG_REGISTERED);
> > +	netdev_unlock(dev);  
> 
> Do we need the lock before list_netdevice() ?

Fair point, we don't. I couldn't decide whether it's more logical 
to skip the locking since device is not listed, or lock it, just
because we say that @reg_state is supposed to be write protected.

