Return-Path: <netdev+bounces-41776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2497CBE20
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B020B20F61
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B253C6BC;
	Tue, 17 Oct 2023 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdxGa5zm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0370BE6D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F27C433C7;
	Tue, 17 Oct 2023 08:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697532709;
	bh=Bg0LkH+yHeoMGGJe2bDNU8n9U3MpiXVKfEYjCW7rZ3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AdxGa5zmIceb0A/IvLo30mO4goGgLGIKcicxVgU5Dhad9i2mXASBGEghU61wuqkqK
	 Kirnxkw4kRRemXDRN/l8MphPPVnMck6uqW4N4bx78yr+37u3CW5En7yjJPdmxjAag9
	 78pMxTP5PD63qHicYgAxRrICmn51QikbKQ7yI3EOJ32G+8hpon6kkEKrOFz17mcMBF
	 GyPHiis5Dt6ESjXLK6vVzp7yPm8wpF2MIV6Uqtuz8q9EQiPFsL7Zc3+DEbHaFXN0PO
	 LXHRKKUMetq/sNPmWIZnjT2zFrpOZiQsr0ipYw1sQx1YvVV5yy8RuWIcxkw0QmqU6T
	 jqjjedZbrjABA==
Date: Tue, 17 Oct 2023 10:51:46 +0200
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [patch net-next v3 4/7] devlink: don't take instance lock for
 nested handle put
Message-ID: <20231017085146.GL1751252@kernel.org>
References: <20231013121029.353351-1-jiri@resnulli.us>
 <20231013121029.353351-5-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013121029.353351-5-jiri@resnulli.us>

On Fri, Oct 13, 2023 at 02:10:26PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Lockdep reports following issue:
> 
> WARNING: possible circular locking dependency detected
> ------------------------------------------------------
> devlink/8191 is trying to acquire lock:
> ffff88813f32c250 (&devlink->lock_key#14){+.+.}-{3:3}, at: devlink_rel_devlink_handle_put+0x11e/0x2d0
> 
>                            but task is already holding lock:
> ffffffff8511eca8 (rtnl_mutex){+.+.}-{3:3}, at: unregister_netdev+0xe/0x20
> 
>                            which lock already depends on the new lock.
> 
>                            the existing dependency chain (in reverse order) is:
> 
>                            -> #3 (rtnl_mutex){+.+.}-{3:3}:

...

>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(rtnl_mutex);
>                                lock(mlx5_intf_mutex);
>                                lock(rtnl_mutex);
>   lock(&devlink->lock_key#14);
> 
> Problem is taking the devlink instance lock of nested instance when RTNL
> is already held.
> 
> To fix this, don't take the devlink instance lock when putting nested
> handle. Instead, rely on the preparations done by previous two patches
> to be able to access device pointer and obtain netns id without devlink
> instance lock held.
> 
> Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


