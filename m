Return-Path: <netdev+bounces-163788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0465A2B916
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D92C165EDB
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338B4154439;
	Fri,  7 Feb 2025 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qO/7Zo3k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3CA2417F5
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738895385; cv=none; b=L+4q+QNXWMYLSHj61TFEIX5Vpp4x0DFGcC6c37tk8r6nboYV7WANBOptkUoYsTKDOkJRG724C+aOxtnyVDFi7pLaHkIXTgEBTIEgs46sDv00u2k8CqwFC+WEZgxQ0LAwBuMrEE8wiqD0ZMSkdHe/XiF8n01Xg+9nuKiEyW2DOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738895385; c=relaxed/simple;
	bh=+xr/KV12J8BWoyGbqrnreOFtNY+URYYHhJAD6BQ+ctM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrcmKVAK4SbgFqvj/n6WqyiCFQDjgPHIUNOva0o4/2uHFoecoUvRNEpU7lds/nwHoj2qxSZU34913CcdWuRwKynUtQZram6t+JBbyjvcN+0aFLkx7VqDZ/UMkQ7hnaK3+z6FfMcb3Bwl7lKibO6f2ejMlOgaCdKNa43h5hQuwgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qO/7Zo3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB0FC4CEDD;
	Fri,  7 Feb 2025 02:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738895383;
	bh=+xr/KV12J8BWoyGbqrnreOFtNY+URYYHhJAD6BQ+ctM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qO/7Zo3kVyfZWSS9e3dF9d1tsP4rXA7qGmSm2rcUbAt7CVvV75fFYNpKR7lb6eSiC
	 iSRxgpoJzJyA8LJpnlk17q44rv0d5dcvgZQfduM+J0M4LDS8N/vLQMck/g43Mrxqrd
	 v1HudVDHrOQma0NPQuO7+pW1BDPBjbFF4s4PVlNpcOsVY6l0hEtH0AuZyCkPyzDZd4
	 ZnPcRdOW8AHMjjRcPgVDW80rEpegyu2oKp8ksWqIy4gt7hYXu9FfRtEgs0Q9M0sUoE
	 K5KOLmHHKkGYAw5fya+FzVHnbm97FSFBzHPm3bGCHZ/KldA7ngoC+TsN6pOY8RTWp0
	 OIjreY6zTeelA==
Date: Thu, 6 Feb 2025 18:29:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
 tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
 akpm@linux-foundation.org, shayagr@amazon.com,
 kalesh-anakkur.purayil@broadcom.com, David Arinzon <darinzon@amazon.com>
Subject: Re: [PATCH net-next v7 1/5] net: move ARFS rmap management to core
Message-ID: <20250206182941.12705a4d@kernel.org>
In-Reply-To: <20250204220622.156061-2-ahmed.zaki@intel.com>
References: <20250204220622.156061-1-ahmed.zaki@intel.com>
	<20250204220622.156061-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Feb 2025 15:06:18 -0700 Ahmed Zaki wrote:
> +void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
> +{
> +	int rc;
> +
> +	/* Remove existing rmap entries */
> +	if (napi->dev->rx_cpu_rmap_auto &&
> +	    napi->irq != irq && napi->irq > 0)

this condition gets a bit hairy by the end of the series.
could you add a napi state bit that indicates that a notifier is
installed? Then here:

	if (napi->irq == irq)
		return;

	if (test_and_clear_bit(NAPI_STATE_HAS_NOTIFIER, &napi->state))
		irq_set_affinity_notifier(napi->irq, NULL);
	if (irq < 0)
		return;

And you can similarly simplify napi_disable_locked().

Speaking of which, why do the auto-removal in napi_disable()
rather than netif_napi_del() ? We don't reinstall on napi_enable()
and doing a disable() + enable() is fairly common during driver
reconfig.

> +		irq_set_affinity_notifier(napi->irq, NULL);
> +
> +	napi->irq = irq;
> +	if (irq > 0) {
> +		rc = napi_irq_cpu_rmap_add(napi, irq);
> +		if (rc)
> +			netdev_warn(napi->dev, "Unable to update ARFS map (%d)\n",

nit: not sure I'd grasp this message as a user, maybe:

	"Unable to install aRFS CPU to Rx queue mapping"

? Not great either, I guess.

