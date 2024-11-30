Return-Path: <netdev+bounces-147941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E6D9DF37F
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 23:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F78281450
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 22:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C32B13B787;
	Sat, 30 Nov 2024 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ek5bnYSm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC89B17BD3
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 22:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733004933; cv=none; b=A+DHsSWTpYBzneMWvRmZ/37/X7xSgrRadsNSL+3QiNl4j7YSZuQA8144P51yrw/jLkbuvx59DpeJQsumNBm8L83mTs/D7WyUu3/6K5lqYtOCfMiW41ojpAE1YZT7wlSyYIdg/b1zyAEBtw282vA9lWao7TvvP6aJ3fxFYLFOppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733004933; c=relaxed/simple;
	bh=nAVLWsHRg6j4gaW/WrcMJaYgDefuVPz6KLzQGQ/T6P0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVPIJUDMsL84P+eOXZe4kTSQmAO9Oe3mYt2cwWz0qCAAhWkreEM6n3F0frnaOZHyME1/fSAmL9X+Ca1VMOOyPcoIAELSkBmu48jS526UY5UvQko9sPjs7W16BGKvJZNjNRLbDCdH4NodiD6B2glbEedShQQ3tswBzP+fdtBFN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ek5bnYSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2782CC4CECC;
	Sat, 30 Nov 2024 22:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733004932;
	bh=nAVLWsHRg6j4gaW/WrcMJaYgDefuVPz6KLzQGQ/T6P0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ek5bnYSm/deZg+w0lyHKBVpiMYqB0mUriUZ69hqn4u6fqa14YCfgxtoqsiNhp3sY3
	 etLuQXVe0RVWjCj6eSbP6BS1z3v2/wgyElTMTsObV9rjLXgcXXgszGDpCZS5Bl+hm7
	 GbwSdUwNRpI1ZP2tjSKU6h7qFN5KX4sSF3rbTbOwB/GDRECOkQbm+nPy4TALX/VuV+
	 R1JiZj5OWOHEdB8voeU21AfeWXAzV4V6RGpfG6yffnSBlxdDCR4wd0h6Fx3qlE7SFM
	 wSfhTcVizMCgYJ0LkjSv8AVWI77xDET7Njq6gmg6o87DlVNsNpIuw/8KL9q2WrUwUT
	 24fSle+uGkdOg==
Date: Sat, 30 Nov 2024 14:15:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, Andy
 Gospodarek <andrew.gospodarek@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2 3/3] bnxt_en: handle tpa_info in queue API
 implementation
Message-ID: <20241130141531.6fd449e1@kernel.org>
In-Reply-To: <20241127223855.3496785-4-dw@davidwei.uk>
References: <20241127223855.3496785-1-dw@davidwei.uk>
	<20241127223855.3496785-4-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2024 14:38:55 -0800 David Wei wrote:
> +	if (bp->flags & BNXT_FLAG_TPA) {
> +		rc = bnxt_alloc_one_tpa_info(bp, clone);
> +		if (rc)
> +			goto err_free_tpa_info;
> +	}
> +
>  	bnxt_init_one_rx_ring_rxbd(bp, clone);
>  	bnxt_init_one_rx_agg_ring_rxbd(bp, clone);
>  
>  	bnxt_alloc_one_rx_ring_skb(bp, clone, idx);
>  	if (bp->flags & BNXT_FLAG_AGG_RINGS)
>  		bnxt_alloc_one_rx_ring_page(bp, clone, idx);
> +	if (bp->flags & BNXT_FLAG_TPA)
> +		bnxt_alloc_one_tpa_info_data(bp, clone);

Could you explain the TPA related changes in the commit message?
Do we need to realloc the frags now since they don't come from 
system memory?

