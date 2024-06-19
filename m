Return-Path: <netdev+bounces-104714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAB390E16A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 03:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68772B21D26
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F01B812;
	Wed, 19 Jun 2024 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT5s3vZH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD4137B
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718761969; cv=none; b=C5PvFXVYi5PzcV3UuGO2/FycbE0MQn0nYupwrbxpQGE9JhZsDdUVIz251js2Q9BzIVYzfnt6eTJb7JyZ0H7ltPPuLMOkJpyJKUbAuZ5ltAHTpsudwARPTmGWAgm81+9Xa0ReM59UUCluUdIlOW2N8umoLH9Ga4iWeamz+zS7Xd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718761969; c=relaxed/simple;
	bh=YVj8359yZrtwS8PDPZzxPqn0eQytzhnccLIXWZ67cVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/CB7d3SkT5u27byyXi8AX2WYFZM2Zz6QcfKPz0sJcTsMYHMIEQCKjuQE+WvLlc8ZClbSiB/IZ/wC4mJ2koExl8B9lXRwlqMarc34i8cQnad+L0vc04oCyOdr5vnBUnkfOPnIyFaS0tvCBZ2Lvkhu1wCK3d1O84yxCL/SRsnNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT5s3vZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32061C3277B;
	Wed, 19 Jun 2024 01:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718761968;
	bh=YVj8359yZrtwS8PDPZzxPqn0eQytzhnccLIXWZ67cVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MT5s3vZHCPBmqGU9bNmOP4Pu1M0FL4fN4awfJl/rqGRgFjcfeYV8JCrI8lmTS84LS
	 RgAxsTeOc3YWojN8PahHYwfFAWV6w6e3rgnSXrywkhtDqDvrjPbmCkJRBqpFCCEHON
	 Xz8pRmuuvg9nrW0bZf3wE7enmgyxXCf0ljbQdkGKlP18nKPBIVNrJfWMFCCDbktNhV
	 SB2JnPtBhwdPDvnNmOEHAeL4aTp9BzhwCkk9XQ1JIpFiQJYHQaZzEbMB9UgfS+tvbP
	 cqPeL980t4TkaHNM7l5sjBmi7i08qj7HUighA2o7xYJIw3HBXPOz1L4/Iog3nX3SdN
	 SQOrMhtbHb0oA==
Date: Tue, 18 Jun 2024 18:52:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com, linux@armlinux.org.uk,
 hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v11 5/7] net: tn40xx: add basic Rx handling
Message-ID: <20240618185247.060c183a@kernel.org>
In-Reply-To: <20240618051608.95208-6-fujita.tomonori@gmail.com>
References: <20240618051608.95208-1-fujita.tomonori@gmail.com>
	<20240618051608.95208-6-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 14:16:06 +0900 FUJITA Tomonori wrote:
> +	netif_tx_lock(priv->ndev);
> +	while (f->m.wptr != f->m.rptr) {
> +		f->m.rptr += TN40_TXF_DESC_SZ;
> +		f->m.rptr &= f->m.size_mask;
> +		/* Unmap all fragments */
> +		/* First has to come tx_maps containing DMA */
> +		do {
> +			dma_unmap_page(&priv->pdev->dev, db->rptr->addr.dma,
> +				       db->rptr->len, DMA_TO_DEVICE);
> +			tn40_tx_db_inc_rptr(db);
> +		} while (db->rptr->len > 0);
> +		tx_level -= db->rptr->len; /* '-' Because the len is negative */
> +
> +		/* Now should come skb pointer - free it */
> +		dev_kfree_skb_any(db->rptr->addr.skb);
> +		netdev_dbg(priv->ndev, "dev_kfree_skb_any %p %d\n",
> +			   db->rptr->addr.skb, -db->rptr->len);
> +		tn40_tx_db_inc_rptr(db);
> +	}

Do you have to hold the Tx lock while unmapping the previous skbs?
That's the most expensive part of the function, would be good to let
other CPUs queue new packets at the same time.

