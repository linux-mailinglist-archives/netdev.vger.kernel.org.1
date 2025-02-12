Return-Path: <netdev+bounces-165364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A9CA31BE8
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E798A1882920
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F70B3D3B8;
	Wed, 12 Feb 2025 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDMgyKzM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70B8F77
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326920; cv=none; b=YoW9X5I40wijefrPguZx0TvNAyNCTr2BunDZ6/gaIC2AkRqvk2AEsMndpUiX66b6axJEaj+ZzsBFa6PZnJ3XGBn7V01ayqHGT3wkC3sbAvTLd4w7i7KfrvkM7tFJSOtnBIWY5sT4raQZ2f2x7lXsBUbrcFGdamqNCgMGdtoX2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326920; c=relaxed/simple;
	bh=5BdmdfOWSSc5G3LFwfsE08iC8NAYesuF4nu0LAmseaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRZUf0ZWXomq8v3eOYCUXE5cKB9aq+lQ/9w9+QYZA7+pW5rOm8zvLSbn0w1OZ5qR/9vkzQGjMfZosZWknzJBjL53D+KmouK42KSVlQ9//QBNOQRtku6Wg6vbBmmUq9T0VHplUZykZ8Ez3zFP8DxHh0MuRXq747agKHechlWOKuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDMgyKzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DA5C4CEDD;
	Wed, 12 Feb 2025 02:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739326920;
	bh=5BdmdfOWSSc5G3LFwfsE08iC8NAYesuF4nu0LAmseaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hDMgyKzMkux8xGCp4D+w2ToH1FXxL+Rp+mZYVGYxdkQljd7QyMRk8TfkQDBi9OVkY
	 K5XXs4EVC/ETtRni0vnMM2FJTGQgkpJR4CzzkMUt0RXR1QJQvSpr2q8TKaHNGA07zl
	 LbZ9ldkHcflaxdL3GXegwRWR8jfOL2tAJ79zLhKohEYUzYGD2Cx3fNW8BJm+yQo3wL
	 PeowASp9/tmygBruTSRYiCL/MJ+NdSpzT+ECfqjmX2ZXCBygZ+6NJCUQsXBmgPbwzf
	 QeTzw0Pny+pCZ3ZcP2D9HhQRA95rSnM5872AttKEzEBLnfUY6pD5qGcSfsrVA3ZD23
	 8cfYI+Kbhj9hw==
Date: Tue, 11 Feb 2025 18:21:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next 03/11] net: hold netdev instance lock during
 queue operations
Message-ID: <20250211182158.1fe9c554@kernel.org>
In-Reply-To: <20250210192043.439074-4-sdf@fomichev.me>
References: <20250210192043.439074-1-sdf@fomichev.me>
	<20250210192043.439074-4-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:20:35 -0800 Stanislav Fomichev wrote:
> -	netif_napi_add(priv->dev, &block->napi, gve_poll);
> -	netif_napi_set_irq(&block->napi, block->irq);
> +	netdev_assert_locked(priv->dev);
> +	netif_napi_add_locked(priv->dev, &block->napi, gve_poll);
> +	netif_napi_set_irq_locked(&block->napi, block->irq);
>  }
>  
>  void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
>  {
>  	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
>  
> -	netif_napi_del(&block->napi);
> +	netdev_assert_locked(priv->dev);
> +	netif_napi_del_locked(&block->napi);

nit: probably don't need the asserts right above _locked() calls
I think the _locked() calls already assert

