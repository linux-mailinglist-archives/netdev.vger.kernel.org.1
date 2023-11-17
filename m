Return-Path: <netdev+bounces-48727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA07EF5B4
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97831C2074A
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CDB3BB56;
	Fri, 17 Nov 2023 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9isK5Q5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F719BA0
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28344C433C7;
	Fri, 17 Nov 2023 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700236303;
	bh=bTHvBLib1aWQhXeKICH0VfvX3+dQ+AMxqEJhvDkVRgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9isK5Q5lXEpMgNiidIeCGEO8AsL+yH5PA5NG6bwCLl00OVepqeG5M/pcqXMiSZqu
	 dv+qlFv+6IpcN3tUtwslVbHtkd3468FYPfoI3qaobOCO6Y3AQ+yPddX8opWcgIhzzR
	 U9YYCDcZTPwAy/ZM7RmVYijxgI4SAgakLC9n6ZA1AOQTDTwuat1obXs9B1ch0MysFW
	 45MDRbujgnjHNdDaENTjGSVnLCLfQhaCvltuJMxMeGDFE773tETyZPPr07ik8YkvPO
	 rgO+MJyXu7mAmc0Su7wxxbqnPeUUy8CHYVhyB/NaYxarh64Te1vU8+nHu+ikGOn7dc
	 z/RTG4sCkBW5g==
Date: Fri, 17 Nov 2023 15:51:38 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 06/14] devlink: Add device lock assert in reload
 operation
Message-ID: <20231117155138.GI164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <bdf5f76deec0e72e25591a4a253648caffb2d6ec.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdf5f76deec0e72e25591a4a253648caffb2d6ec.1700047319.git.petrm@nvidia.com>

On Wed, Nov 15, 2023 at 01:17:15PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Add an assert to verify that the device lock is always held throughout
> reload operations.
> 
> Tested the following flows with netdevsim and mlxsw while lockdep is
> enabled:
> 
> netdevsim:
> 
>  # echo "10 1" > /sys/bus/netdevsim/new_device
>  # devlink dev reload netdevsim/netdevsim10
>  # ip netns add bla
>  # devlink dev reload netdevsim/netdevsim10 netns bla
>  # ip netns del bla
>  # echo 10 > /sys/bus/netdevsim/del_device
> 
> mlxsw:
> 
>  # devlink dev reload pci/0000:01:00.0
>  # ip netns add bla
>  # devlink dev reload pci/0000:01:00.0 netns bla
>  # ip netns del bla
>  # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove
>  # echo 1 > /sys/bus/pci/rescan
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


