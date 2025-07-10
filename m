Return-Path: <netdev+bounces-205795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C0AB003C4
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 15:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E2057BB45B
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE803258CE8;
	Thu, 10 Jul 2025 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIpbXhyo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC485C5E
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154652; cv=none; b=pO576uvY+61GuFn9HA1FoggBgxw79HfLMtW0fyw08aef/RtgZcyG+UIr/AQdspxczu2W1YNSWYmCdlRhbRbfBvC5I60cHNQAw2vt7MOjL5teNhpPQGO1VXGl0heS6TKzHA/tzYh+5Kpe3mCCXTsX6i77Q7LLrFrwhHj4v09qJks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154652; c=relaxed/simple;
	bh=j2oF2RFxt4YmkWdA42eRvchV1VC0A8dG8i4sKHl9xpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1/dj3QoZYsQqbu0hMDSxLI9ZDXvd3cUtRXLBvBbkteJkDnfvllR4YL4M9ild7em8MREtCw2tpHdoOc8xpTW6W+elFA1lwa5lTJ6jv/KNYN+Tbp87I9WyhRGRfpvix1ESMo1fYrXgS+sYCz99Jb3hS19nQZ84LwuSTHRny1RqoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIpbXhyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B467DC4CEE3;
	Thu, 10 Jul 2025 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752154652;
	bh=j2oF2RFxt4YmkWdA42eRvchV1VC0A8dG8i4sKHl9xpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iIpbXhyoVER6qfDViEbzx9xeOXQzc4vgZQmGfc8+Wei0rAW9jn9mCw9GiBhjivOte
	 u/61dZ/lfZFboRIq2ydgGl3I5V+YtfOOcBuDysKU+43BEsG9brk8HGsyfczk424qKu
	 eh0d3Idws3bSHbdhGCexXmfa3bD2cBrmeavzZj6egeRRQMWVaCKPq4H8N99KDxvQ+/
	 wZObaKnR28biEJQRZyCRskgwvCEfQtQJbcv72b3PeHXMn1gmwNeB9ZIZ55mORadMbn
	 A6triAlT7RiMZgFXns5Ll5TShBF7aI7W3Jj+PGtzWqi+pqQz2OtJksuNe4Ei4JhE9i
	 akJTB3EpeHCdA==
Date: Thu, 10 Jul 2025 06:37:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next] ethtool: Fix set RXFH for drivers without RXFH
 fields support
Message-ID: <20250710063729.08ae71e6@kernel.org>
In-Reply-To: <a6341aa1-dd8b-4449-ba95-38bb067d6483@nvidia.com>
References: <20250709153251.360291-1-gal@nvidia.com>
	<20250709172508.5df4e5c9@kernel.org>
	<a6341aa1-dd8b-4449-ba95-38bb067d6483@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 14:17:11 +0300 Gal Pressman wrote:
> > We could add a:
> > 
> > 	if (WARN_ON(ops->supported_input_xfrm && !ops->get_rxfh_fields))
> > 		return -EINVAL;
> > 
> > into ethtool_check_ops() and we'd be both safe and slightly faster.  
> 
> This is a step further.
> 
> There could be a driver that allows setting of input xfrm but not rxfh
> fields. Failing the netdevice registration is different than skipping
> ethtool_check_flow_types().
> 
> Maybe there are no such devices and we shouldn't care?

Note that we're talking about the get. It's still perfectly fine for
the hypothetical driver to not support _changing_ the fields, the fields
be hardwired. But we need to know what fields the device is using to
validate the xfrm is correct.

