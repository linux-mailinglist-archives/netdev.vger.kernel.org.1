Return-Path: <netdev+bounces-163607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EFEA2AEA7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386EF16520D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4F239584;
	Thu,  6 Feb 2025 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTzfh4ty"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E98748D
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738862239; cv=none; b=sltAIn+mWNVbghns0iZfV8ck+YCSNv3ByGavWMkhIDAmAR3pJDL+mmMHmKA0+/FfUfF3zQsD6uOpLAZ2rdb71hUoqbvaG2gyKbO2t4iqSgOKLXgEKlqvd8UtLI5e4cxn52FxPrWA7NhHaacgGVeweOaln8BYW6MSegHNK0iGUgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738862239; c=relaxed/simple;
	bh=KmjOzcHaejdcZTso1nzY7ZxaJ7Si9WZZkz0elRyW7gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNQBNwbPz33L0TpnjqRwcXDeBFZGcJDY6RWlYKLBBCaLtPI+1sPrtqIdLIaf8L3j9LYLapYz2wG0aHB6nPgGI2/GWjnVKWsKLm/GiyvGM+mUOcCfheMQkkigjDBiWgSmqBojhsdEl182WSO8Vn+0kcw/Ab+N7SflzXnV7Bcw5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTzfh4ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB72C4CEDD;
	Thu,  6 Feb 2025 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738862236;
	bh=KmjOzcHaejdcZTso1nzY7ZxaJ7Si9WZZkz0elRyW7gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cTzfh4tyneK+1zn77smSYBoVFat5BA6kMQnfjUfthcPWyU3WJEZfC11G6rgMo41J5
	 /MO8Sikho7g4mUwg02faGG5LQGzSaIq3FdzQfqdbMqiabtFOsrh6YoMkGb/PQI6KYL
	 aRQv8I89WnBb1OVxBCkR0KwgBdCHQ8HYX6Iapw9MbaS43PJyOvBaYv5f+oBrldIXuA
	 6GXcdRXUmDl7FK95QY8NZKVPOLGH30YB2A2qZEibDEo2hEWR/UaL3RnWj73zGoQOTC
	 L3E5NHcYSs4EyAGKeTjALOZxw3KkoyMebVkCahWVyHczzrNERzSq6HNmXgl4ciBBKn
	 nh4TNCO0Lutrw==
Date: Thu, 6 Feb 2025 09:17:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 3/3] netdevsim: allow normal queue reset while
 down
Message-ID: <20250206091714.684b592d@kernel.org>
In-Reply-To: <CAHS8izNWmcYvFBNwa_kUrWFWAHO_6h9Pd67BTCadeaDX3H8GhQ@mail.gmail.com>
References: <20250205190131.564456-1-kuba@kernel.org>
	<20250205190131.564456-4-kuba@kernel.org>
	<CAHS8izNWmcYvFBNwa_kUrWFWAHO_6h9Pd67BTCadeaDX3H8GhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 08:43:58 -0800 Mina Almasry wrote:
> > diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> > index 42f247cbdcee..d26b2fb1cabc 100644
> > --- a/drivers/net/netdevsim/netdev.c
> > +++ b/drivers/net/netdevsim/netdev.c
> > @@ -644,6 +644,9 @@ nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
> >
> >         if (ns->rq_reset_mode > 3)
> >                 return -EINVAL;
> > +       /* Only "mode 0" works when device is down */  
> 
> Just to make sure I understand: modes 2 & 3 should also work with the
> device down, and this is an artificial limitation that you're adding
> to netdevsim, right? I don't see how changing the call order to
> napi_del and napi_add_config breaks resetting while the device is
> down.

It should work, but I sprinkled a bunch of checks in page pool which
expect idle NAPIs to have the SCHED bit set. So we run into false
positive warnings if we create and destroy a page pool for NAPI which
was never initialized / listed. Let me take another look.

