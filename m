Return-Path: <netdev+bounces-101619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76618FF973
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 02:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C6D1C20A44
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CE29443;
	Fri,  7 Jun 2024 00:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIrvQ933"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B72F37
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 00:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717721796; cv=none; b=LYVzAO0/yDI/jIVN0uiDwHkxJP9gxGy0xLnszaPH25iINKWsrPrx0Yhio8fHpseUMeGe2QXTDa6R/pjZqup3+jKTe6UDlYhaNkjVn14f31+JR3wKcHZ3Zk9oM7ZX//HzCyroo9ENsIIfIe9pPPTQg4Fcp4Qh9Wm3JazzJjK+Q9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717721796; c=relaxed/simple;
	bh=4zIN6yVfkke/97buSvUvyXvnBSv3QZEJepXEyHp1p0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozPsw2BAEE93pdDxWiqwOwPISNWPWMNqdL9v0O9DyFZo/fqlKK4pWUKp0w1rnUD4scvNdRwtzJoDO9z3q6rzgL8xekjn1HWJwEXl9Hf+U0oM8ekitXKEW12Fxf8DeRSXMt5cFzU6gCBqU6dqTJzG2Yw44/fBmarZ9fbFCu2h4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIrvQ933; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89312C2BD10;
	Fri,  7 Jun 2024 00:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717721795;
	bh=4zIN6yVfkke/97buSvUvyXvnBSv3QZEJepXEyHp1p0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NIrvQ933HjuuB+DYpKLT2KAAiM8/CSQhTLhhruqzn09qUeyL2fipROZOLClEBar//
	 KaBxAwhPCwUTB+qZVgrMeFngxfy1S7zZ3dAJhphmqib3XFie/G3VIeVlJpJ+T/MlW/
	 d2dXulkFKQkIFNZxrKewW6Jq8N51AIToK9GKe7BmWbNa5WsLbsRvvus7L7K7a29QdI
	 GZ0VEiAYCeb2zeJVlub5B8rRPvQd8D/CzOxzxrCUseVhA8uHeO4QxQsrNW49NgEk+c
	 qrDp1pbT49b783Fq8bvAUzkBMueFrOhQWe14H3XQ+qIMlhRY9Ugo08WBpGOreJwZpK
	 qMY1JT22opwWw==
Date: Thu, 6 Jun 2024 17:56:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Sujai Buvaneswaran
 <sujai.buvaneswaran@intel.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH v2 3/7] ice: move devlink locking outside the port
 creation
Message-ID: <20240606175634.2e42fca8@kernel.org>
In-Reply-To: <20240605-next-2024-06-03-intel-next-batch-v2-3-39c23963fa78@intel.com>
References: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
	<20240605-next-2024-06-03-intel-next-batch-v2-3-39c23963fa78@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Jun 2024 13:40:43 -0700 Jacob Keller wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> In case of subfunction lock will be taken for whole port creation. Do
> the same in VF case.

No interactions with other locks worth mentioning?

> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 704e9ad5144e..f774781ab514 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -794,10 +794,8 @@ int ice_devlink_rate_init_tx_topology(struct devlink *devlink, struct ice_vsi *v
>  
>  	tc_node = pi->root->children[0];
>  	mutex_lock(&pi->sched_lock);
> -	devl_lock(devlink);
>  	for (i = 0; i < tc_node->num_children; i++)
>  		ice_traverse_tx_tree(devlink, tc_node->children[i], tc_node, pf);
> -	devl_unlock(devlink);
>  	mutex_unlock(&pi->sched_lock);

Like this didn't use to cause a deadlock?

Seems ice_devlink_rate_node_del() takes this lock and it's already
holding the devlink instance lock.

