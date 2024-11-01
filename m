Return-Path: <netdev+bounces-140866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A889B883E
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2BC2823BA
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E6E3A1BA;
	Fri,  1 Nov 2024 01:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOpVJusB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94014E1CA;
	Fri,  1 Nov 2024 01:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730423951; cv=none; b=BdyiWgkDdCQa3F6Vik3EwQd4VohOztmbdUztm1hKqfvUIBajx2P5LzK7JuX1uFIKpGRMMphjhHemWsL4qHTj/NZo2+68jCwNcGryrvcpwSCkVfdo9C1djBDoMwxSk5AznFXnmjAVeh6CWS9OklmMZPwK+Xta3ygynpDuobVOG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730423951; c=relaxed/simple;
	bh=a/BTAZOpBWmD64gqQe+NBKQnoP7/lsloauWesLVevVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/6eZKQ35PtV+qYt0+vWIF5tPCJQqPU3kJFQTpjHu27I+UcwNoE9r1lSRUNLcxmnDvEX8SEPHRMaQCxBb05PM5qLhlBFuX3Bpzj1i30rLChL6ipa1Iy+6myOIZ6+/1aTpm+MUIN0mkSljQ/QRUzjReuLgHwFcwFEsnRlrU/kO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOpVJusB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94F5C4CEC3;
	Fri,  1 Nov 2024 01:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730423951;
	bh=a/BTAZOpBWmD64gqQe+NBKQnoP7/lsloauWesLVevVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZOpVJusBDbMkB4pBTukN1gTFj0NvdsWgUwLmCerDPQGVEewMRj1Whb5KxQbdziwb4
	 P9IY/LRsBwN+Ff5B98r0xqYJHfzgGmG8Ec7H2s+DlwBaDIlqciknz0RstOWAlpJpcq
	 tZXgowz911Pq9lOpgSDAV5iL+YEMLbNeufjF8fEfCzAZO0WNkvmD+bvnG7geWOeJ0b
	 BHbg/5hqngHFW8As0m7PiNeELKsN/fLY5JCyW3j6W9wf+UGsl+7fna+uWzd8TsyxZp
	 uaf/h3Kma68z8NWh03r4ynnzGGeO5qKGDR4RoEihVx106YuwoHW1V+iLO/S5FaP3R1
	 9i9HGT1Ek4AfA==
Date: Thu, 31 Oct 2024 18:19:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nelson Escobar via B4 Relay <devnull+neescoba.cisco.com@kernel.org>
Cc: neescoba@cisco.com, John Daley <johndale@cisco.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Christian Benvenuti
 <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v2 5/5] enic: Adjust used MSI-X
 wq/rq/cq/interrupt resources in a more robust way
Message-ID: <20241031181909.4f12b240@kernel.org>
In-Reply-To: <20241024-remove_vic_resource_limits-v2-5-039b8cae5fdd@cisco.com>
References: <20241024-remove_vic_resource_limits-v2-0-039b8cae5fdd@cisco.com>
	<20241024-remove_vic_resource_limits-v2-5-039b8cae5fdd@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 18:19:47 -0700 Nelson Escobar via B4 Relay wrote:
> To accomplish this do the following:
> - Make enic_set_intr_mode() only set up interrupt related stuff.
> - Move resource adjustment out of enic_set_intr_mode() into its own
>   function, and basing the resources used on the most constrained
>   resource.
> - Move the kdump resources limitations into the new function too.

Please try to split the pure code moves / refactors to separate
commits, this change is quite hard to review.

> +	case VNIC_DEV_INTR_MODE_MSIX:
> +		/* Adjust the number of wqs/rqs/cqs/interrupts that will be
> +		 * used based on which resource is the most constrained
> +		 */
> +		wq_avail = min(enic->wq_avail, ENIC_WQ_MAX);
> +		rq_avail = min(enic->rq_avail, ENIC_RQ_MAX);
> +		max_queues = min(enic->cq_avail,
> +				 enic->intr_avail - ENIC_MSIX_RESERVED_INTR);
> +		if (wq_avail + rq_avail <= max_queues) {
> +			/* we have enough cq and interrupt resources to cover
> +			 *  the number of wqs and rqs
> +			 */
> +			enic->rq_count = rq_avail;
> +			enic->wq_count = wq_avail;
> +		} else {
> +			/* recalculate wq/rq count */
> +			if (rq_avail < wq_avail) {
> +				enic->rq_count = min(rq_avail, max_queues / 2);
> +				enic->wq_count = max_queues - enic->rq_count;
> +			} else {
> +				enic->wq_count = min(wq_avail, max_queues / 2);
> +				enic->rq_count = max_queues - enic->wq_count;
> +			}
> +		}

I don't see netif_get_num_default_rss_queues() being used and you're
now moving into the "serious queue count" territory. Please cap the
default number of allocated Rx rings to what the helper returns.
-- 
pw-bot: cr

