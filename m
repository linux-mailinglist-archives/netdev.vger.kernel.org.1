Return-Path: <netdev+bounces-72603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B44A858CE6
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 02:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B6E1F253DA
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 01:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C75411CB8;
	Sat, 17 Feb 2024 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngUVX5m7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385C01DA37
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708134408; cv=none; b=i/fvzdY3eWQvX+633F+0BpOkjikfumMs9IebRCc0myqr2m6Pn89usauo+ThN1RupFF309hzYKe+9WhTFybOsFdp98ATeYYqXljNsxTMQXnhiKMJL15Gtfc/8D7voUBsyT0NM49DfLQ3frF3dPoXlmICHRRbEAbJTB/cLWiYIggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708134408; c=relaxed/simple;
	bh=4KASNn0u5onuDgAAEStPyy5IE4wE2un21u34VU1SgOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtLHcN559oZg92dNOSVhNhFD/L7hjgnXAY5rQPUY4RM9jbfJrjWylwlDDtqXBJSZmsFCSeH2RWiwLDe4ukeUtHe5fEdoXgc4J+7J4F4xOD436BTtxhcQBlL6RYX90xGjp8PLsaNd3gTwTspG/tCekn54DLG+cGv9m8ejgeXFTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngUVX5m7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1B1C433F1;
	Sat, 17 Feb 2024 01:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708134407;
	bh=4KASNn0u5onuDgAAEStPyy5IE4wE2un21u34VU1SgOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ngUVX5m7ibck7NhE7gbv0NQgCbtEYnARhOV5Kcu4GAGt0ZFTWZkLgmaK1zVAXP3WY
	 LsMZoyclVS0+kM0RUX29LU/TqE3yT5NduQp+T0QEEzXm0EJMGOaUT1vJLXvpu19eLj
	 opaFgC6Tz47JsQjrPzfrh3aJqC2I+11j7KowEnwGY5rvnTH5l/u4tVxdMoJ7urjdAA
	 vj1T3kTxla8UI25Gt6y2/kNCr/YL8b3P2FHUhQIVkg+HkG8ierQpjV5SgtMtaohrZb
	 Bornj8TkR/tY1Pw60EJ5vx7hJT2JUya0Db4hWc+mPyCFhMZb65oiG6q+VucdYL8Bbx
	 EtJHwgbx7aM8A==
Date: Fri, 16 Feb 2024 17:46:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v11 1/3] netdevsim: allow two netdevsim ports
 to be connected
Message-ID: <20240216174646.6a0dd168@kernel.org>
In-Reply-To: <20240215194325.1364466-2-dw@davidwei.uk>
References: <20240215194325.1364466-1-dw@davidwei.uk>
	<20240215194325.1364466-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 11:43:23 -0800 David Wei wrote:
> +	ns_a = get_net_ns_by_fd(netnsfd_a);
> +	if (IS_ERR(ns_a)) {
> +		pr_err("Could not find netns with fd: %d\n", netnsfd_a);
> +		return -EINVAL;
> +	}
> +
> +	ns_b = get_net_ns_by_fd(netnsfd_b);
> +	if (IS_ERR(ns_b)) {
> +		pr_err("Could not find netns with fd: %d\n", netnsfd_b);
> +		return -EINVAL;
> +	}
> +
> +	err = -EINVAL;
> +	rtnl_lock();
> +	dev_a = __dev_get_by_index(ns_a, ifidx_a);
> +	if (!dev_a) {
> +		pr_err("Could not find device with ifindex %u in netnsfd %d\n", ifidx_a, netnsfd_a);
> +		goto out_put_netns_a;
> +	}
> +
> +	if (!netdev_is_nsim(dev_a)) {
> +		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n", ifidx_a, netnsfd_a);
> +		goto out_put_netns_a;
> +	}
> +
> +	dev_b = __dev_get_by_index(ns_b, ifidx_b);
> +	if (!dev_b) {
> +		pr_err("Could not find device with ifindex %u in netnsfd %d\n", ifidx_b, netnsfd_b);
> +		goto out_put_netns_b;
> +	}
> +
> +	if (!netdev_is_nsim(dev_b)) {
> +		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n", ifidx_b, netnsfd_b);
> +		goto out_put_netns_b;
> +	}
> +
> +	if (dev_a == dev_b) {
> +		pr_err("Cannot link a netdevsim to itself\n");
> +		goto out_put_netns_b;

You need to fix the gotos here :( You're leaking the references 
to the namespaces on error paths :(
-- 
pw-bot: cr

