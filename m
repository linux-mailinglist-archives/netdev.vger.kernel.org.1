Return-Path: <netdev+bounces-143586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FEE9C3227
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 14:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6070E1C203F5
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FC2E57D;
	Sun, 10 Nov 2024 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fxp97AWE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268FA923
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731245493; cv=none; b=AWsOcXb7cF9afOEyB7XzfChqLvZUf3Za7rUcdMmkUgbBlt97pPaIOrtNpNLkd2rlmz9MTSyHdah0KsPm/VviBPr8jqSsjc2/11KMJW7RKPKzM7ad3PleUxBNx5ZVbAtYU1rd1oCMx1gx4PYplHHbBUpQni0c3kJJD+2+pMvuJW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731245493; c=relaxed/simple;
	bh=FSCxufNudrh5zvvWlyq8abL6PtbPvmEcrE8gDPLYNCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SseZPt6bKmJPmVPwx11pDFdFA+7Tmsnqk87IHLEfuqra+Yj1pYtRZJffLE/t4Vvmmk/90tdvOTVAsyeXDVNl7ZLUfY4cqFzpkaXjfBtlgVeHjP9K3L4yFlEarxrnLAgsZLFosUQHo6F0u0wWjTiKhNx8W95K746JDU5zox5z7CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fxp97AWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B053DC4CECD;
	Sun, 10 Nov 2024 13:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731245492;
	bh=FSCxufNudrh5zvvWlyq8abL6PtbPvmEcrE8gDPLYNCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fxp97AWEZCop7n8Hvcnp3ty1Rd8yty+jXVCVzH18z86IKFyig/Q7xWtCgLu8hi3KU
	 j31122NmTj2l86eNIz/7QEPKwxjKm1CucNAMRv+p8xK4h4Z0ZygvwBGRF9XhDHYOW+
	 1D8I40RQY8hGnKVO3kr6RnXWWfmDRjRjeCo77chLdirsb/TbFUHWidFGeFf7pxggyT
	 xqVK4Ib1gI0BVq1gG+idGuZTOFdNFn8biKxT3M14KQtgE2RCUN33R6j71hfwMMcLw8
	 n6bHZZy+LSQSGGFiP4+KTL0R58btGTgaboc5HOnNLW5Azn0li1fewX9CR2GsURKnYD
	 XqqDGnmxg9nOw==
Date: Sun, 10 Nov 2024 13:31:28 +0000
From: Simon Horman <horms@kernel.org>
To: Mohammad Heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, oss-drivers@corigine.com,
	louis.peens@corigine.com
Subject: Re: [PATCH net] nfp: use irq_update_affinity_hint()
Message-ID: <20241110133128.GM4507@kernel.org>
References: <20241107115002.413358-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107115002.413358-1-mheib@redhat.com>

On Thu, Nov 07, 2024 at 01:50:02PM +0200, Mohammad Heib wrote:
> irq_set_affinity_hint() is deprecated, Use irq_update_affinity_hint()
> instead. This removes the side-effect of actually applying the affinity.
> 
> The driver does not really need to worry about spreading its IRQs across
> CPUs. The core code already takes care of that. when the driver applies the
> affinities by itself, it breaks the users' expectations:
> 
> 1. The user configures irqbalance with IRQBALANCE_BANNED_CPULIST in
>    order to prevent IRQs from being moved to certain CPUs that run a
>    real-time workload.
> 
> 2. nfp device reopening will resets the affinity
>    in nfp_net_netdev_open().
> 
> 3. nfp has no idea about irqbalance's config, so it may move an IRQ to
>    a banned CPU. The real-time workload suffers unacceptable latency.
> 
> Signed-off-by: Mohammad Heib <mheib@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


