Return-Path: <netdev+bounces-105821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D18913121
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 02:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6970D28521F
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 00:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434F97E1;
	Sat, 22 Jun 2024 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Syak/uAc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC76385
	for <netdev@vger.kernel.org>; Sat, 22 Jun 2024 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719015655; cv=none; b=eiXNOztNY5kMdjLpRIPVLHEiHONwmCDPbe+SC4AT3nf9UiCo60L0Ue8QeW+rhT7fPCeqCDgCoZyHdh04MTviggmMvu3oDEpIjBUt/dO9FIZwRjKd1KUUCxAjvdc4qPT998Nh7DyFZWUAoK2XuBTuE4PKOFX8TcJRDEvJAnHoGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719015655; c=relaxed/simple;
	bh=sLXI2LSA5tFtlAavmsdVVJLaBS1XBPLpZldW1UA9B0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRichT5fxud6ifLE5rKq1fGNZieOR63TplSxz+oM3ZPjHRbwDzt58O8KCueMd/s7DQ9fWfjXSHp7pdoUgIBxGCTEhaIIBEStQzdQF+0Q/TWztSOVoc1kcBgfDY9RKrUamm6KUtlAOoPx/+NFyRcNm+g1sQpaWgMw9ZP5O5XXaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Syak/uAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C83BC2BBFC;
	Sat, 22 Jun 2024 00:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719015654;
	bh=sLXI2LSA5tFtlAavmsdVVJLaBS1XBPLpZldW1UA9B0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Syak/uAcFZomT/48NL/JQwzyJpYit595Kv5rcPjG4b7VKcob58VQI40bJoqCIHXPy
	 w169cApLz1Lu9SRfWGfVL7KCIufhpV3E2LAubpSBzrgye2wITbE0/LHOFPMBBEUtET
	 fICl+kesxSZ7JSzDo/rhX7kletx0bQ2v16xYTne3jAYeu7424a8eUy5eZVwCroVIh7
	 WVonRTxycGvAZvGOGHLmwb0dnvfKXqB6kG2Kk7sVjMysm89NwFAMgPQyd7IdEmSkZh
	 E2Cgd17xMP/T6WBggyK5eEIYeJ8topSE0+8nNbHlDRbJzW/HcTXXYWJwLcpML/g5j0
	 xImlTDuPVsE2g==
Date: Fri, 21 Jun 2024 17:20:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Michael Chan <michael.chan@broadcom.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>, Adrian Alvarado
 <adrian.alvarado@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
 netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, David
 Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 2/2] bnxt_en: implement
 netdev_queue_mgmt_ops
Message-ID: <20240621172053.258074e7@kernel.org>
In-Reply-To: <20240619062931.19435-3-dw@davidwei.uk>
References: <20240619062931.19435-1-dw@davidwei.uk>
	<20240619062931.19435-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 23:29:31 -0700 David Wei wrote:
> +	/* At this point, this NAPI instance has another page pool associated
> +	 * with it. Disconnect here before freeing the old page pool to avoid
> +	 * warnings.
> +	 */
> +	rxr->page_pool->p.napi = NULL;
> +	page_pool_destroy(rxr->page_pool);
> +	rxr->page_pool = NULL;

What's the warning you hit?
We should probably bring back page_pool_unlink_napi(), 
if this is really needed.

