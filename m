Return-Path: <netdev+bounces-193810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C7EAC5F1A
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 04:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8403A3BE9
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 02:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01EE1B0F1E;
	Wed, 28 May 2025 02:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5ZakYgH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6D1E4AB;
	Wed, 28 May 2025 02:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748398362; cv=none; b=kv1u75Ne6yuStp7m2xsLjAxVy1qUSadlIoHp+O32hggnvq0heDR9d/Irg2BVvrBTbD60QGW98ro2RJ+6RznpIglaTsPGcTaY4dtDwLk4xtK1cn07nh2/FVxWMDA7LgHiF6fvihOvA6QttM06zT292oAjsBGZ6zzWhSr5lT1HM9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748398362; c=relaxed/simple;
	bh=/DgyCXDm/zjEkdZ0UTFXz24tKe/bEPo/EjDQtTDjDg8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhHj788nKmL1ZKoD4MOm50HKjsEZk35InUkm0SAck7EFXRmPxXSjMpKZ2+9fhUY+7F7eNXohVRMx11/p8evrxmmjtvr1OhgFqiZERRGdMQNomGkHcn69oZ7xUFypEEDAXzMfhz+I4GJRDIWxviNF1f8D2NNgIi49Lm1upoAsjhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5ZakYgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A883C4CEE9;
	Wed, 28 May 2025 02:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748398362;
	bh=/DgyCXDm/zjEkdZ0UTFXz24tKe/bEPo/EjDQtTDjDg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z5ZakYgHUC0+ERKgG1JC/pAaxs+Fm1QkpIYa4yCHh4FpCtsiWQxRMT5dCmzvQJu2X
	 AtkFh6580uW2oP/KajcC9EPJQAOJ4+gEwAYE+6EahI5hEhoQBBoeKemq2aSXuvCWAD
	 Bef08rXkFn01aII0mGztS8L6Liu1yDgp6sIl9XyvqEmROU+8F+vlm/ZPcn9pXEgFxr
	 U7cYFQUtaqW7J4bhmJn7gsNIydTD+//9veG3t4w9TJqowg4viwVfH1hwXZlCzofpoJ
	 mUDdZ/scxHoY/TPwLVi/x4GaPhQY4e0Nlx0U7MCYSfC47rFet8NNmFDErWKoCm0KoD
	 XDiLo8sHRQzcw==
Date: Tue, 27 May 2025 19:12:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jeroendb@google.com, andrew+netdev@lunn.ch,
 willemb@google.com, ziweixiao@google.com, pkaligineedi@google.com,
 yyd@google.com, joshwash@google.com, shailend@google.com,
 linux@treblig.org, thostet@google.com, jfraker@google.com,
 richardcochran@gmail.com, jdamato@fastly.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/8] gve: Add support to query the nic clock
Message-ID: <20250527191240.455b6752@kernel.org>
In-Reply-To: <20250522235737.1925605-6-hramamurthy@google.com>
References: <20250522235737.1925605-1-hramamurthy@google.com>
	<20250522235737.1925605-6-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 May 2025 23:57:34 +0000 Harshitha Ramamurthy wrote:
> +	err = gve_ptp_init(priv);
> +	if (err)
> +		return err;
> +
> +	priv->nic_ts_report =
> +		dma_alloc_coherent(&priv->pdev->dev,
> +				   sizeof(struct gve_nic_ts_report),
> +				   &priv->nic_ts_report_bus,
> +				   GFP_KERNEL);
> +	if (!priv->nic_ts_report) {
> +		dev_err(&priv->pdev->dev, "%s dma alloc error\n", __func__);

missing a call to gve_ptp_release() on this error path?

> +		return -ENOMEM;
> +	}
-- 
pw-bot: cr

