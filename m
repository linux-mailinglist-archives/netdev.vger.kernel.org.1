Return-Path: <netdev+bounces-12795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D52B9738F96
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA482815E1
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD1219BC0;
	Wed, 21 Jun 2023 19:04:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2252595
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9C4C433C8;
	Wed, 21 Jun 2023 19:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687374238;
	bh=4q03yyU/FJ3g5lPg/8gRWiOakRtpt5zl0S2EvIn/fbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D0EPfMSDHzSUXhIHQlpkik5YQ9dTcYPsq665jloCVCugSu3hK1k5IPTyxLs2GT06n
	 +6ITY7jM/csrn8ybVX6UALncU2C/MapkZNw7m/H+qzX7w8wYQygcem9NZZu6NUeVnM
	 PpLInbCh4lJpfretjN8PMMlgALp4mjwyTMhPnJ6/iOM2hTFJvv1lMtRiO0S2YeUlN3
	 VPFjEjR+nv3vNlrVuUPXo+ra+c7sU3KSDIUucd7jNqAYah8e3Zbajn5331Km3fesB9
	 p4AQ4SLvVWdceO0s47vFGFxuw9NSotK+/z8mjptZ08XIcXRXTcKCPiBYkCUsc4TzcE
	 zydWd62kVGl1w==
Date: Wed, 21 Jun 2023 12:03:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 petrm@nvidia.com
Subject: Re: [RFC PATCH net-next 1/2] devlink: Hold a reference on parent
 device
Message-ID: <20230621120357.7a5c4a17@kernel.org>
In-Reply-To: <ZJKZT3LHBN3zEUd1@shredder>
References: <20230619125015.1541143-1-idosch@nvidia.com>
	<20230619125015.1541143-2-idosch@nvidia.com>
	<ZJFF3gh6LNCVXPzd@nanopsycho>
	<ZJFPs8AiP+X6zdjC@shredder>
	<20230620104351.6debe7f1@kernel.org>
	<ZJKZT3LHBN3zEUd1@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 09:31:43 +0300 Ido Schimmel wrote:
> Thanks for taking a look.
> 
> Moving the release to devlink_free() [1] was the first thing I tried and
> it indeed solves the problem I mentioned earlier, but creates a new one.
> After devlink_free() returns the devlink instance can still be accessed
> by user space in devlink_get_from_attrs_lock(). If I reload in a loop
> while concurrently removing and adding the device [2], we can hit a UAF
> when trying to acquire the device lock [3].

Ugh, I didn't look at the second patch, it's taking the device lock
before validating that the devlink instance is registered. 
So we need to extend the list of fields which must always be valid :(

Let's try to fix it at the netdevsim level then? AFAIU we only need the
bus to remain loaded for nsim_bus_dev_release to exist? What if we split
netdevsim into two modules, put the bus stuff in a new module called
netdevsim_bus, and leave the rest (driver) in just netdevsim. That way
we can take a ref on netdevsim_bus until all devices are gone, and still
load / unload netdevsim. With unload resulting in all devices getting
auto-deleted.

I haven't looked in detail so maybe you'll immediately tell me it won't
work, but I'm guessing this is how "real" buses work avoid the problem?

