Return-Path: <netdev+bounces-178745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1CFA78AB5
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 11:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EAF3B1E63
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B604235BEB;
	Wed,  2 Apr 2025 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ew1tussH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798D23314A;
	Wed,  2 Apr 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584875; cv=none; b=Cw/2uNYKH0EZsbq2gcXREHfaTf+aXoJhp97nXNv/hPtfpmrvGsnonP2jOj0c3bVkHDhr9LCckdSr3pxNdEZP9VSX6X35Ux0+LoqvgkOOAqRP5Zl6dJxfuRT+T3TUngHpLeJH+HVMzgACHsp0vY5UY7odsd78svT7ICU7cL6ve88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584875; c=relaxed/simple;
	bh=1cuYLAqzLjV85JwVKIDfGh+KXKmUSux5/54YPn9Pizk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOZgvaREvpIdGW5P+ZWQvhXNn9z5xhLx9csaIyeQPCi1SEHKhrcvaFQ6kIHpFX4IE/Fxok7H8UDiMihNnnT0HetVsHQg7o7FcYrvh+yY3aAUO9tOQhrWz+6+hH9IEqbuvvcgAPCXttLQAFBPN9ySTpKXwZqyyKL9Dt9dh11BG2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ew1tussH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F539C4CEDD;
	Wed,  2 Apr 2025 09:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743584875;
	bh=1cuYLAqzLjV85JwVKIDfGh+KXKmUSux5/54YPn9Pizk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ew1tussHkSV0vQc81A9nAjqYsr3ZRw1B8U2Gnv+qxLSrfU7JBrUc/rdt8ncp8lh1M
	 JZhQu7RWFimASJER7twTzCt3oOng7HlNHrNsc8MQmDmN/NkuavCAW7OE/nBcei/mDZ
	 RcROFaK+Hs63eKZZhDOpZhBBrE4HDrm5pGMflKzyzApqfb6m2NUYk3IwDByq9Mh5xu
	 AaP1+jdPjBghwzRzXLMJw3m1Y3XZDxR+fYe1bjca4WwWDLrTNn55UloQCPCDrjYgjS
	 G8KVDR9yrx9C51r+OdBo9Bygc+7nebfCIS/5192wCdWhaClhstFbqZR88s6mjbijqP
	 tZC7EU7zb4bVA==
Date: Wed, 2 Apr 2025 10:07:51 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Henry Martin <bsdhenrymartin@gmail.com>, netdev@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] arcnet: Add NULL check in com20020pci_probe()
Message-ID: <20250402090751.GH214849@horms.kernel.org>
References: <20250401145330.31817-1-bsdhenrymartin@gmail.com>
 <f85c219e-2463-4d59-84d4-5807bbcb1a41@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f85c219e-2463-4d59-84d4-5807bbcb1a41@web.de>

On Tue, Apr 01, 2025 at 05:37:18PM +0200, Markus Elfring wrote:
> > devm_kasprintf() return NULL if memory allocation fails. Currently,
> …
>                 call?                               failed?
> 
> 
> > Add NULL check after devm_kasprintf() to prevent this issue.
> 
> Please complete also the corresponding exception handling.
> 
> Source code example for further inspiration:
> https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/net/arcnet/com20020-pci.c#L239-L244
> 
> Thus I suggest to use another label like “e_nomem” for this purpose.

Ok, but surely the err_free_arcdev label can be reused for this purpose.

