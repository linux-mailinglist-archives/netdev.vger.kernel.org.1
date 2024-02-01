Return-Path: <netdev+bounces-67764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689DE844E39
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 01:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1373D28451E
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 00:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0702139F;
	Thu,  1 Feb 2024 00:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mytJnG19"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD571FDA
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 00:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749063; cv=none; b=jhnTPpe5Rv6mzdgDwSwNe5Yz3aRbVmBC7CvC3uGhPiiHflmYoFRozI/pDwzlmvv067+0S+iN2XuR6K4h0yatZmGLB/GUjPP941O21SNhmsDt0mxRwwtITxFnK3Sud+xX8PO/q+wbSlvRL40H/joVuUIVFdsxUzEaIa7l0u4E6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749063; c=relaxed/simple;
	bh=Us8iUsTZAhojw4VZYSlIDgUU7CG/AuJNCzdiAjVcUog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBSW6TOYOopsjceLxmb4AdSAwBaQeF/Gz7DIbiLq7G+1dv42ynDKEJXJ8VjnKEY9K8ozB2oFd3wkgfTIYhsKUA7oXxRPehGRIKMSxkj+ZsIHF3aoIs2HR3FTW41SEf1/FvnCKv9VbWGAZErIWAeLgvuhp/qvDnyI6kUnYzfGwUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mytJnG19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F93FC433C7;
	Thu,  1 Feb 2024 00:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706749063;
	bh=Us8iUsTZAhojw4VZYSlIDgUU7CG/AuJNCzdiAjVcUog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mytJnG19qvp8qyTSzOMTksgfCqkXvTYzdMfWOsVupWUJ+wEPmm0npbNenZnyAv/IT
	 Ev2aXSszz8hURmTOLB7SuvuguLfeLds329SmSXl0yl7MhCNOii2bVgNoRqkLQyHV9x
	 2tnH5Us560kJBd0x5dYavuR8urWDvXdv4qvQlbxdGBCrcKrd2uRe7kDjp3HgpskxPT
	 9VdEW/7zZREMWV/+QTjLMiwbCjeTCB5Rp63o7bV6TZV2DeOy5Efm45V4SpFPWnpYx2
	 JAX4EP66zFztXLkvc7CFHVjciHQMw5BQte/YXz821nRVjYgh77sU4u5s7i68PbB4dK
	 2GIOrCY3fR1gw==
Date: Wed, 31 Jan 2024 16:57:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v8 1/4] netdevsim: allow two netdevsim ports to
 be connected
Message-ID: <20240131165739.53cf301e@kernel.org>
In-Reply-To: <20240130214620.3722189-2-dw@davidwei.uk>
References: <20240130214620.3722189-1-dw@davidwei.uk>
	<20240130214620.3722189-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 13:46:17 -0800 David Wei wrote:
> +	err = -EINVAL;
> +	rtnl_lock();
> +	ns_a = get_net_ns_by_id(current->nsproxy->net_ns, netnsid_a);

I think we should support local netns, i.e. the one which we are
currently in. But by definition it has no id. How about we make the
netns id signed and make -1 mean "use current->nsproxy->net_ns
directly"?

Also you can look up the netns before taking rtnl_lock, they are 
not protected by rtnl_lock.

> +	if (!ns_a) {
> +		pr_err("Could not find netns with id: %u\n", netnsid_a);
> +		goto out_unlock_rtnl;
> +	}
> +
> +	dev_a = __dev_get_by_index(ns_a, ifidx_a);
> +	if (!dev_a) {
> +		pr_err("Could not find device with ifindex %u in netnsid %u\n", ifidx_a, netnsid_a);
> +		goto out_put_netns_a;
> +	}
> +
> +	if (!netdev_is_nsim(dev_a)) {
> +		pr_err("Device with ifindex %u in netnsid %u is not a netdevsim\n", ifidx_a, netnsid_a);
> +		goto out_put_netns_a;
> +	}
> +
> +	ns_b = get_net_ns_by_id(current->nsproxy->net_ns, netnsid_b);
> +	if (!ns_b) {
> +		pr_err("Could not find netns with id: %u\n", netnsid_b);
> +		goto out_put_netns_a;
> +	}
> +
> +	dev_b = __dev_get_by_index(ns_b, ifidx_b);
> +	if (!dev_b) {
> +		pr_err("Could not find device with ifindex %u in netnsid %u\n", ifidx_b, netnsid_b);
> +		goto out_put_netns_b;
> +	}
> +
> +	if (!netdev_is_nsim(dev_b)) {
> +		pr_err("Device with ifindex %u in netnsid %u is not a netdevsim\n", ifidx_b, netnsid_b);
> +		goto out_put_netns_b;
> +	}

You're missing if dev_a == dev_b return goto out..; ?
Actually I can't think of a reason why looping would explode.
Could you test it and if it indeed doesn't splat add a comment
here that loops are okay?

> +	err = 0;
> +	nsim_a = netdev_priv(dev_a);
> +	peer = rtnl_dereference(nsim_a->peer);
> +	if (peer) {
> +		pr_err("Netdevsim %u:%u is already linked\n", netnsid_a, ifidx_a);
> +		goto out_put_netns_b;
> +	}
> +
> +	nsim_b = netdev_priv(dev_b);
> +	peer = rtnl_dereference(nsim_b->peer);
> +	if (peer) {
> +		pr_err("Netdevsim %u:%u is already linked\n", netnsid_b, ifidx_b);
> +		goto out_put_netns_b;
> +	}
> +
> +	rcu_assign_pointer(nsim_a->peer, nsim_b);
> +	rcu_assign_pointer(nsim_b->peer, nsim_a);

> @@ -333,6 +333,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
>  		goto err_phc_destroy;
>  
>  	rtnl_lock();
> +	RCU_INIT_POINTER(ns->peer, NULL);

since you have to repost - pretty sure ns is zalloc'ed so you don't
have to do this?

>  	err = nsim_bpf_init(ns);
>  	if (err)
>  		goto err_utn_destroy;

