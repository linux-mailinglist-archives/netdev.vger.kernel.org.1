Return-Path: <netdev+bounces-39787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23107C47B2
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 04:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37EE281B6D
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FDE2115;
	Wed, 11 Oct 2023 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoNpiXMS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63393551B
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 02:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B299C433C8;
	Wed, 11 Oct 2023 02:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696990630;
	bh=PXEeWC38yNFQr1+Diuh31TOqjrbub/acINDAQ6HO72g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aoNpiXMSwkcBGnV4XJRym3uAyNV7Kas5VXuqUrsobVDTJ4n7hUFQI17oI/stIVNbz
	 EOckcFKtNiZM8GIrDxfFbiN5m3fDXEaxR4oX2nk7zZtecTAJ32dHpLMJqPqpdR8Swy
	 TBo+AC4uNvJTap5OjmvnNIdGkQraLDc1R6FIquQAqt0ZHxmPTgqIjzW5E/bN1aCgZr
	 TupHb8WZdHcrOFbYk7QA62ToLLI1P3ojKim8USOeEaQIJpJ/62hAIu4JPCpyYD0jvo
	 DYD/PgLHyQQzpXe3TEpmfUqRB+H1i4f0owU0p01CyY1Xo/buurpd0UtvrF3WJGyUbZ
	 Ga8JPC4j1QKzg==
Date: Tue, 10 Oct 2023 19:17:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v4 02/10] net: Add queue and napi association
Message-ID: <20231010191709.1cc0fbe6@kernel.org>
In-Reply-To: <169658368866.3683.5936758786055991674.stgit@anambiarhost.jf.intel.com>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
	<169658368866.3683.5936758786055991674.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Oct 2023 02:14:48 -0700 Amritha Nambiar wrote:
>  #endif
> +	/* NAPI instance for the queue */
> +	struct napi_struct		*napi;

What's the protection on this field?
Writers and readers must be under rtnl_lock?

>  } ____cacheline_aligned_in_smp;
>  
>  /*
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 606a366cc209..9b63a7b76c01 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6394,6 +6394,40 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
>  }
>  EXPORT_SYMBOL(dev_set_threaded);
>  
> +/**
> + * netif_queue_set_napi - Associate queue with the napi
> + * @queue_index: Index of queue
> + * @type: queue type as RX or TX
> + * @napi: NAPI context
> + *
> + * Set queue with its corresponding napi context

Let's add more relevant info, like the fact that NAPI must already be
added before calling, calling context, etc.

> + */
> +int netif_queue_set_napi(unsigned int queue_index, enum netdev_queue_type type,
> +			 struct napi_struct *napi)

Let's make this helper void.
It will be a PITA for callers to handle any error this may return.

> +{
> +	struct net_device *dev = napi->dev;
> +	struct netdev_rx_queue *rxq;
> +	struct netdev_queue *txq;
> +
> +	if (!dev)
> +		return -EINVAL;

	if (WARN_ON_ONCE(...))
		return;

> +	default:
> +		return -EINVAL;
> +	}

same here

