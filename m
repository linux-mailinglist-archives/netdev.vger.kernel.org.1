Return-Path: <netdev+bounces-159897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5417A1755B
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 02:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A665A7A3384
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 01:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA72BC13D;
	Tue, 21 Jan 2025 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEMcPYGw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C938831
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737421394; cv=none; b=Yo8vS3xofxvmlF5yG/1zO/ppOIklXlCIDfYJo/HZgO9jLQW9BoErdUAbz0Z4tqxH+FyDNEZAWgKdb/F74TzGAFrHqU0M1Q8cdHJ18HxOq8U649qWay0lkUZw3riRyG29iM9UiuTCJ2ha94yXM5QpvJswbigVXjFzGF1JuCXZexk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737421394; c=relaxed/simple;
	bh=HIln73N/dQ2ILuF1idi0OzbqxA6tjCry3FqLwVF1xw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlnSt4SQ7vbsxqCu3/uqZclhF7LdS22DiVeXb8HB8yDSSvmGH4vWgc4uSGshLWlB9YlP1/BiOszgDseJSxrca8f72fDSNMY8d+uS21V8JUWejxMKhKVZyi0dzYSpSq/rDkPs8ub8O+H8KeP9S5ZSoJhJ8/MLLirN9J9WpUJYtgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEMcPYGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D804C4CEDD;
	Tue, 21 Jan 2025 01:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737421394;
	bh=HIln73N/dQ2ILuF1idi0OzbqxA6tjCry3FqLwVF1xw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DEMcPYGwE428CyHvjSlw0gUAw63W4xUihW2zm4MousoVWF8udWFwonIm5fGlWfkks
	 Vqf7X7drFUToeF79ZW8SJZcyVE6wKqRVUop/wdmckXbiPjMiTu0/oCkO+EUExrzUG4
	 6/Huh5gqyqniTPUSSeWJ3zfliQ8gnjq2wNT8VHcrfbFa2C94iq4SQRegZSw9L6oE9A
	 S8DKYtTe5WnZP1hEaq2iQQOgG9Sh/pjKGP8Q6po04VBVkU8AzraGl3wYQHxfxV8fUL
	 yzHbEqd+2ZZXBJ0TTXz6kRlPTjneQfr/iSU1kVnBCI7TQPlFc82iBCcHJtU372AyyZ
	 x4hD1Cg9Ulkng==
Date: Mon, 20 Jan 2025 17:03:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
 tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
 akpm@linux-foundation.org, shayagr@amazon.com,
 kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v6 2/5] net: napi: add CPU affinity to
 napi_config
Message-ID: <20250120170312.1af6b7e7@kernel.org>
In-Reply-To: <20250118003335.155379-3-ahmed.zaki@intel.com>
References: <20250118003335.155379-1-ahmed.zaki@intel.com>
	<20250118003335.155379-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 17:33:32 -0700 Ahmed Zaki wrote:
> A common task for most drivers is to remember the user-set CPU affinity
> to its IRQs. On each netdev reset, the driver should re-assign the
> user's settings to the IRQs.

> @@ -393,8 +394,8 @@ struct napi_struct {
>  	struct list_head	dev_list;
>  	struct hlist_node	napi_hash_node;
>  	int			irq;
> -#ifdef CONFIG_RFS_ACCEL
>  	struct irq_affinity_notify notify;
> +#ifdef CONFIG_RFS_ACCEL

Let's remove the #ifdef completely, one int won't make much difference,
it's ~1% of the whole struct..

> @@ -11585,7 +11606,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  {
>  	struct net_device *dev;
>  	size_t napi_config_sz;
> -	unsigned int maxqs;
> +	unsigned int maxqs, i, numa;

nit: reverse xmas tree

>  	BUG_ON(strlen(name) >= sizeof(dev->name));
>  
> @@ -11681,6 +11702,10 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
>  	if (!dev->napi_config)
>  		goto free_all;

nit: empty line here

> +	numa = dev_to_node(&dev->dev);
> +	for (i = 0; i < maxqs; i++)
> +		cpumask_set_cpu(cpumask_local_spread(i, numa),
> +				&dev->napi_config[i].affinity_mask);
>  
>  	strscpy(dev->name, name);
>  	dev->name_assign_type = name_assign_type;


