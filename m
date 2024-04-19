Return-Path: <netdev+bounces-89495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748438AA6A1
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 03:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139EA1F2145A
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 01:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D8510FF;
	Fri, 19 Apr 2024 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETu8oA44"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A510F9
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713491333; cv=none; b=iRUGp6DFIHXyiP7PKbG1+NL3EQ57Pr2tUfr6mcM4x7AqNeZjEBNs85IYTt12Jx4tSrGlskaPzz3WoQk1dv93x5qDEqeHVMTgw5FdUZBPyaAlccf+wTil5GUAp8pb0j1PTdjm0qdgFXgz2DgtqLv2dv716Ukv8NntgR+B+AyhN80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713491333; c=relaxed/simple;
	bh=uyN2zEzaurCu9qsoa8YFUXhVCYFkGFT1JmntTNiJje8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTb5WFkfkTnk4lGSqRp0+t5HPiC1OfX3XPuJI2K4K9SfMbzm/Ie6ayiriLQIfePdTf8Z3q7t4KF/+ckuRvWd7Jw9WgG4gTWFv3dGM3pAjWwa9BnmkuMq/DyaB6LgH7qgvlSU4zZL0vZIuzVjzq1y/Dvv2w3fqnlzk/L0x6Maemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETu8oA44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEA4C113CC;
	Fri, 19 Apr 2024 01:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713491332;
	bh=uyN2zEzaurCu9qsoa8YFUXhVCYFkGFT1JmntTNiJje8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ETu8oA441r3gOsUIBPr3Fr/TvwbZlqTQVvBzo2Sbdz1RqgyYV1UbSosS0VB/dz0Bn
	 lhR5+0UM6bKlpK/lCbSIjMcD3woQU0sU+FR0O9cbs2Yr98fx3EcdpcAJbCmLNCmvY4
	 blDPwsG6yve8KtrMVI2E/LkcU4lqSRh3exmBobwddEubA1W2gNUqhMO9p0CPOlWCri
	 q39lF4lbwa7+o96fFcyHhIfEqlxZteUpNubE+sguQ6x8MZeS9hB8cOmxmAgLU0spdA
	 ydWV1HfLmS6tpVb/VyfQdyrFGc2RLbVKELlb+UTlz9uo6PfAXxJs+9T7T6Fn8jthP3
	 AE1zSGWtTDg2g==
Date: Thu, 18 Apr 2024 18:48:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shailend Chand <shailend@google.com>
Cc: netdev@vger.kernel.org, almasrymina@google.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, willemb@google.com
Subject: Re: [RFC PATCH net-next 9/9] gve: Implement queue api
Message-ID: <20240418184851.5cc11647@kernel.org>
In-Reply-To: <20240418195159.3461151-10-shailend@google.com>
References: <20240418195159.3461151-1-shailend@google.com>
	<20240418195159.3461151-10-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 19:51:59 +0000 Shailend Chand wrote:
> +static int gve_rx_queue_stop(struct net_device *dev, int idx,
> +			     void **out_per_q_mem)
> +{
> +	struct gve_priv *priv = netdev_priv(dev);
> +	struct gve_rx_ring *rx;
> +	int err;
> +
> +	if (!priv->rx)
> +		return -EAGAIN;
> +	if (idx < 0 || idx >= priv->rx_cfg.max_queues)
> +		return -ERANGE;

A little too defensive? Core should not issue these > current real num
queues.

> +	/* Destroying queue 0 while other queues exist is not supported in DQO */
> +	if (!gve_is_gqi(priv) && idx == 0)
> +		return -ERANGE;
> +
> +	rx = kvzalloc(sizeof(*rx), GFP_KERNEL);

Why allocate in the driver rather than let the core allocate based on
the declared size ?


