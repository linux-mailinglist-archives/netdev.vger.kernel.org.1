Return-Path: <netdev+bounces-112629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F6B93A400
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A26283DC8
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC79D156C5E;
	Tue, 23 Jul 2024 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="diGmkaDD"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13731534FB
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749839; cv=none; b=OQiUzx5nVKm1QvUiMesY+IG28SDEY1OD1au8H1lkbR0dIXI4b/VDnbOJSUhGcd2khO12wj+51Tazc27+l2ZPbDvbkYbhdPp9EAlI1L/sTIX0hH4I4vQMaGum3anKQa08Gx1o8imczi9opeKHgV9ar4EFH2yRuztHOkWNxAxYNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749839; c=relaxed/simple;
	bh=fVM0q96yPwKiugt9bZ0ocOR8bh3bpbumZ2q6JFvn7fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFjDfwuB3gMWt07HDek5CVrtVVdSAG45Rz8AjxefGzWWbD1Ls1eLSpDB1IoQkZm20YFIKXyZa6YIqaw7Oy93+qibcS3DYV8BoV1a9G5E44fRrvUlrc1Sg9eS8ahMVie+1t/LRvzgZa24tYdxviwPgyQNSxVyBb0MWGlZgNs+LWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=diGmkaDD; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2FDC1BF204;
	Tue, 23 Jul 2024 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721749829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qW4zkwGdwDYDktpri7pWekVPN6py5ctB8Xz2qiAJLKI=;
	b=diGmkaDDhbbwGnVqM5n+brku5HpTbCKSvZABMWHjNUcdhSnnk6qDKbKoZ7f64Rw5NAi9r2
	RHJ7mvjwVFc5RENCp/g29cR4Q1fauVps0WvzuWblz96EymuolIR5gT5ROgyPjdYrGysSTd
	93xtVkLz5XQyRpv+YD8hQJ3l7TmaawX15Y9Lb7w38Q/JeGJTxICvX702Yp71MAFDMYnH99
	Qmfdo9D+iFlpiBH0PlfwLDXWQEZSJ4xRqKk3JHpBCec6T8ibL7ZglixTlZ7xLoxzMZ6akJ
	L6demDM9v/YZMZYgKHrMfKAOyz9nyCdhZpMY7Secu/DUnQCyGO7t/OgMGuzi3Q==
Date: Tue, 23 Jul 2024 17:50:27 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose
 Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: Correct byte order of perfect_match
Message-ID: <20240723175027.081423a1@fedora.home>
In-Reply-To: <20240723-stmmac-perfect-match-v1-1-678a800343b2@kernel.org>
References: <20240723-stmmac-perfect-match-v1-1-678a800343b2@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Simon,

On Tue, 23 Jul 2024 14:29:27 +0100
Simon Horman <horms@kernel.org> wrote:

> The perfect_match parameter of the update_vlan_hash operation is __le16,
> and is correctly converted from host byte-order in the lone caller,
> stmmac_vlan_update().
> 
> However, the implementations of this caller, dwxgmac2_update_vlan_hash()
> and dwxgmac2_update_vlan_hash(), both treat this parameter as host byte
> order, using the following pattern:
> 
> 	u32 value = ...
> 	...
> 	writel(value | perfect_match, ...);
> 
> This is not correct because both:
> 1) value is host byte order; and
> 2) writel expects a host byte order value as it's first argument
> 
> I believe that this will break on big endian systems. And I expect it
> has gone unnoticed by only being exercised on little endian systems.
> 
> The approach taken by this patch is to update the callback, and it's
> caller to simply use a host byte order value.
> 
> Flagged by Sparse.
> Compile tested only.
> 
> Fixes: c7ab0b8088d7 ("net: stmmac: Fallback to VLAN Perfect filtering if HASH is not available")
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

