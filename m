Return-Path: <netdev+bounces-115032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B25D944EA7
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26BF1F22710
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A094913790F;
	Thu,  1 Aug 2024 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuCJ30Jr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAA426ACB
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524414; cv=none; b=I8coFyiGo589lBwYT5YNfcDBC9qWn214+nq/tkabrUmbgoEWCsc9SRrr9agkBLieKNggLaS9bdMPmusaLUsf7ZZiKBta9MjvNtZnqa/KaLCpqjH4rLX8AQtFf9L9Uo6i5SjetlQFFMFECSssCNs28b4zfx05J5aKjvqD343JqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524414; c=relaxed/simple;
	bh=UZae2xXPl6/zCB479yoSN8QqSbgm6aknA+nmW84gPP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mg40bPcCfN3mKBeMdC/ZTbke+N8GMCh0gpw0M6LACB3cfJ5tqpG9wigs428G/vJVWuQtua+0MR5HCj6zqY/A10zzzRRdtshb0pU/3q+dvkQ7pKPMeiWUnUC1hgYb42E9ybnruddu4gp8vjmupA+Hp3IMZRlspAE9WqhHZlyFkGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuCJ30Jr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F995C32786;
	Thu,  1 Aug 2024 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722524414;
	bh=UZae2xXPl6/zCB479yoSN8QqSbgm6aknA+nmW84gPP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nuCJ30Jrv4J8RyYpM1VDPlfEW1dLCGRRjnxIcPcWyvS+WNtkV8Gl6DQIhFwSMywXl
	 QjD3cJwexvVM6xZBI7g+XsxBH//Mpei2Kvh5w6E6Hw8DOqkO51KeqzAl3hWMOnYmx6
	 ZgB6rGdpHUckusG4EI27ap30WjJOMjgeossDtUnNT3qYvlVi8LOpHbeLzqP6ddpEFG
	 H8A0341jbKNOsFDf8L24EFi4eBrZ91FO9UHFliXLBruSOwDR5ykl2UNB0kKdNmyttX
	 0ZiT9jNVQZOvvwT+toOIkK5NDvRBEQQQCIAiuAG05/3jfmq50r6B9IVOj88ulh8o6T
	 vVjPe/9LLWcug==
Date: Thu, 1 Aug 2024 08:00:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 04/12] net-shapers: implement NL set and delete
 operations
Message-ID: <20240801080012.3bf4a71c@kernel.org>
In-Reply-To: <e79b8d955a854772b11b84997c4627794ad160ee.1722357745.git.pabeni@redhat.com>
References: <cover.1722357745.git.pabeni@redhat.com>
	<e79b8d955a854772b11b84997c4627794ad160ee.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 22:39:47 +0200 Paolo Abeni wrote:
> +static int net_shaper_delete(struct net_device *dev, u32 handle,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct net_shaper_info *parent, *shaper = sc_lookup(dev, handle);
> +	struct xarray *xa = __sc_container(dev);
> +	enum net_shaper_scope pscope;
> +	u32 parent_handle;
> +	int ret;
> +
> +	if (!xa || !shaper) {
> +		NL_SET_ERR_MSG_FMT(extack, "Shaper %x not found", handle);

below the print format for shaper id is %d

also just point at the attribute with NL_SET_BAD_ATTR(),
we shouldn't bloat the kernel with strings for trivial errors

> +		return -EINVAL;

ENOENT

> +	}
> +
> +	if (is_detached(handle) && shaper->children > 0) {
> +		NL_SET_ERR_MSG_FMT(extack, "Can't delete detached shaper %d with %d child nodes",
> +				   handle, shaper->children);
> +		return -EINVAL;

I'd say EBUSY

> +	}
> +
> +	while (shaper) {
> +		parent_handle = shaper->parent;
> +		pscope = net_shaper_handle_scope(parent_handle);
> +
> +		ret = dev->netdev_ops->net_shaper_ops->delete(dev, handle,
> +							      extack);
> +		if (ret < 0)
> +			return ret;
> +
> +		xa_lock(xa);
> +		__xa_erase(xa, handle);
> +		if (is_detached(handle))
> +			idr_remove(&dev->net_shaper_data->detached_ids,
> +				   net_shaper_handle_id(handle));
> +		xa_unlock(xa);
> +		kfree(shaper);
> +		shaper = NULL;

IIUC child is the input / ingress node? (The parentage terminology 
is a bit ambiguous in this case, although I must admit I keep catching
myself trying to use it, too).
Does "deleting a queue" return it to the "implicit mux" at the 
global level? If we look at the delegation use case - when queue
is "deleted" from a container-controlled mux it should go back to
the group created by the orchestrator, not "escpate" to global scope,
right?

> +		if (pscope == NET_SHAPER_SCOPE_DETACHED) {
> +			parent = sc_lookup(dev, parent_handle);
> +			if (parent && !--parent->children) {
> +				shaper = parent;
> +				handle = parent_handle;
> +			}
> +		}
> +	}
> +	return 0;
>  }
>  
>  int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -EOPNOTSUPP;
> +	struct net_device *dev;
> +	u32 handle;
> +	int ret;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_HANDLE))
> +		return -EINVAL;
> +
> +	ret = fetch_dev(info, &dev);
> +	if (ret)
> +		return ret;

Possibly a candidate for a "pre" handler, since multiple ops call it?

