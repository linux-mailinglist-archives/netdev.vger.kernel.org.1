Return-Path: <netdev+bounces-191154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10226ABA48B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3078A2630D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AD422B8A6;
	Fri, 16 May 2025 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="se3wgxqy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D7218E8B;
	Fri, 16 May 2025 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426571; cv=none; b=cvfAQGRbVnHpUEZJ/DIscyPIdRfHIESSrGWB6ovm2cSU5WnYo9lLwK0/R0FdJ0vreUVhnKuJvYHUH4a0VKkLAgowO238S7kyTQY4q5oolFy3r3YBpjzO8P2t6G6tx4CVIlqKoOQvBdkqp6WoKOgZQGVPIzgk/qeL7kMHJgGS0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426571; c=relaxed/simple;
	bh=agvIOpStuatXOhRFdkohKJn/j4d5AlIvVVKNhBZDkLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4wUWhVvMPEeX0RBYhkXopV65jXIbgbhzxGapkUBRaC4CJvG27FKbkAy+szjO9PJkq+YouWXU5ViPTErTPZsk9o7loC8Fnobyuv4Km6NG5nNRBk+eLTAvlTgjI2NDn+EOK/vFGlsnfhlaqtOCIVAH5jWi4YhI3mVuVO2wprBOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=se3wgxqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E59C4CEE4;
	Fri, 16 May 2025 20:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747426571;
	bh=agvIOpStuatXOhRFdkohKJn/j4d5AlIvVVKNhBZDkLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=se3wgxqydYjU1HXlHmCGblCL6ZONY2SLkIwqJFb4yr/MPpLV4SFXYL/3e85VC9nWR
	 ouCVgP9G1Bg/2z7RbjXcKWLaC2bp41Dekg6W9+NlDj8wH4ped54cJWKc1oseieexnk
	 umy+IEA7Xk3uzAjTogVMifhv+cImkh7g0czf+ZzEGCrRoNAwuRtUexvDjXsTnUmSZC
	 F1PdAx9SuHwIA5X7wQe/YxA2HEgA9Vvkk+EV+o5pRsm0MMmdeCEFFpJS6SYfTyJn6V
	 vu7sMBoebC2GZaqYPPe8X4CmxowTFwTm8yudTBl9QusxKItUgogFxOSdVwopzWVKG3
	 rVIC4GTCdUmFA==
Date: Fri, 16 May 2025 21:16:06 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/4] net: airoha: Fix an error handling path in
 airoha_alloc_gdm_port()
Message-ID: <20250516201606.GH3339421@horms.kernel.org>
References: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>

On Thu, May 15, 2025 at 09:59:35PM +0200, Christophe JAILLET wrote:
> If register_netdev() fails, the error handling path of the probe will not
> free the memory allocated by the previous airoha_metadata_dst_alloc() call
> because port->dev->reg_state will not be NETREG_REGISTERED.
> 
> So, an explicit airoha_metadata_dst_free() call is needed in this case to
> avoid a memory leak.
> 
> Fixes: af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Changes in v3:
>   - None
> 
> Changes in v2:
>   - New patch
> v2: https://lore.kernel.org/all/5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr/
> 
> Compile tested only.

Reviewed-by: Simon Horman <horms@kernel.org>


