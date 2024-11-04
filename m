Return-Path: <netdev+bounces-141524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E639BB3E2
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC46B26FE4
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5DB1B3942;
	Mon,  4 Nov 2024 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBTxvycZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974481B3937
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720782; cv=none; b=JuDjIv7jjYIVeHY/K/rJa6Kb+VuMtBBpc/gkC9ApTJKJJpVIkXNyVQV9OWBwUZH/EsjVERRyjONPRsfp1nk+zuw7hswiOFjfp5gddBjwm/y1dcvINQ+SsEeNdNjJGnI6yVDVRv4xUnsAlSVA25dQqMm7Cr/oShQZxYSGCjkNik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720782; c=relaxed/simple;
	bh=6fyI+TJeacaVlmMYQ3fai+EmFug2NS3CEbFwoFVH6TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ig492xen7XNiXvqDy3jMNs0nk1nNHPPsJKX29kcG3f+HayIn+U7a1zciESITpl1/26EGwF4NE6INF7Sa+uNKjaYhqhoUFcfHk1Z6iPyvoJOEMnYkTtb/XSlqiMAtAVKsJWhinWJSYmQxlAmGWlpDUZE1x2msFwFUsnkChH+oWQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBTxvycZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EE9C4CECE;
	Mon,  4 Nov 2024 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730720782;
	bh=6fyI+TJeacaVlmMYQ3fai+EmFug2NS3CEbFwoFVH6TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBTxvycZy7eAxoKgZqgCUjhTNk8sMbRO0QReK3SIv5C5MZrWeBYxfvYQTBlHYYIyH
	 LNPcmzuqYYJCS3/wOFi3SyrFAyUptyX7vSpNBMHGG+lpWxxqC/3VdekDVtZN/bWyg0
	 CwQoKEyW/tTvBzz8U1cqjWGMw6omcepJ+imb9u4QLd3081/h4Qnq5jwAEdHXvbsu63
	 7+sBRVhZSa831KRVJhCQe4UNOnKkt6B05S21tWYqEwe8HOB3ErfFtEvCsKtM49OrM+
	 a4CYyb+XiZDvbzpLOcPmJvmdF7S0VDQaPv9sZ9WucuMI1KUtG4Dq55CXbHey5fObra
	 rlfiLAYm7pwqg==
Date: Mon, 4 Nov 2024 11:46:19 +0000
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ice: Fix NULL pointer dereference in switchdev
Message-ID: <20241104114619.GB2118587@kernel.org>
References: <20241029094259.77738-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029094259.77738-1-wojciech.drewek@intel.com>

On Tue, Oct 29, 2024 at 10:42:59AM +0100, Wojciech Drewek wrote:
> Commit ("virtchnl: support queue rate limit and quanta size

It would be nice to include 12 characters of sha1 hash immediately
after "Commit".

> configuration") introduced new virtchnl ops:
> - get_qos_caps
> - cfg_q_bw
> - cfg_q_quanta
> 
> New ops were added to ice_virtchnl_dflt_ops but not to the
> ice_virtchnl_repr_ops. Because of that, if we get one of those
> messages in switchdev mode we end up with NULL pointer dereference:
> 
> [ 1199.794701] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [ 1199.794804] Workqueue: ice ice_service_task [ice]
> [ 1199.794878] RIP: 0010:0x0
> [ 1199.795027] Call Trace:
> [ 1199.795033]  <TASK>
> [ 1199.795039]  ? __die+0x20/0x70
> [ 1199.795051]  ? page_fault_oops+0x140/0x520
> [ 1199.795064]  ? exc_page_fault+0x7e/0x270
> [ 1199.795074]  ? asm_exc_page_fault+0x22/0x30
> [ 1199.795086]  ice_vc_process_vf_msg+0x6e5/0xd30 [ice]
> [ 1199.795165]  __ice_clean_ctrlq+0x734/0x9d0 [ice]
> [ 1199.795207]  ice_service_task+0xccf/0x12b0 [ice]
> [ 1199.795248]  process_one_work+0x21a/0x620
> [ 1199.795260]  worker_thread+0x18d/0x330
> [ 1199.795269]  ? __pfx_worker_thread+0x10/0x10
> [ 1199.795279]  kthread+0xec/0x120
> [ 1199.795288]  ? __pfx_kthread+0x10/0x10
> [ 1199.795296]  ret_from_fork+0x2d/0x50
> [ 1199.795305]  ? __pfx_kthread+0x10/0x10
> [ 1199.795312]  ret_from_fork_asm+0x1a/0x30
> [ 1199.795323]  </TASK>

It seems that the cited commit is present in net-next but not Linus's tree.
But, regardless, I think a Fixes tag is warranted.

> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

The fix itself looks good to me, thanks.

Reviewed-by: Simon Horman <horms@kernel.org>

...

