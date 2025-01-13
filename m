Return-Path: <netdev+bounces-157859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F45AA0C14C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762ED1882522
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6421C5F34;
	Mon, 13 Jan 2025 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksxdOSbK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47931C5F28
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796206; cv=none; b=gdizVpfz5oq++6RryLZyoc4Xp8ARo+WvBEUsdwAi4bsoSZ/CLPaFIXqq6wUSJXXysLtqxmwWIJOMvikXRVgMcexVYIeQImbbmli8RdNaSyJ7UMzmpGkU2c9b29BZsLRB0Ua9k3SPibbma2C+/fwe7LIP+/9oaggPtoEttSVdu38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796206; c=relaxed/simple;
	bh=M6+3Zv2rAUcdEmrCAP+TTUGN7Z/NQgWmmdwcNx9WP10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwErIUMJZ1Y34Lj7X3trpReebISLz0qUxpP0G3UdYNCYw3RZ+R+e9UVWdg+JTEd81b2yVRCjH8PXNsVekpTOooFbqQtZPzJN/NBQa9b4Qj1/Prq3jAzXtJPBgLqqtjhnP4kSjpftM2yzRa6uPodBeY3agNJiQ1x5b8uoI1NMRA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksxdOSbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B180C4CED6;
	Mon, 13 Jan 2025 19:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736796206;
	bh=M6+3Zv2rAUcdEmrCAP+TTUGN7Z/NQgWmmdwcNx9WP10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksxdOSbKvzwukfi3ysDxfe/H5ejy6bQQ3oGlEl60p69zRJRePIc3gFVys1sGyr0Sb
	 2inAXKXArnXdptV0jDrD0GI4OVq6uEkeKanvBawdKNDR4j3nEgjJ2RK/ok6apfXegw
	 xpupf8YflNqZT7tmviiZjNpgTUagrc1Wq9FdtdWM6IW7S+HeZaC2Bbnm+GUSZfaOr7
	 sRRs+hifoSPOprK289reCad8gc1KMirhd4m2GX91S7FXeWsiWUwpl9dzu+yuUgBXaP
	 YFsHN4V28dx2hOu24EdNwSKA7a26t9R4FzaFqVAS0Z1yiYwXGau1nbegesBC6L2Kwf
	 Etf/t9Y8VUl7w==
Date: Mon, 13 Jan 2025 21:23:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net 6/8] net/mlx5e: Properly match IPsec subnet addresses
Message-ID: <20250113192321.GC3146852@unreal>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
 <20250113154055.1927008-7-tariqt@nvidia.com>
 <ee18ca51-fe6a-456b-9466-39e81d484e66@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee18ca51-fe6a-456b-9466-39e81d484e66@intel.com>

On Mon, Jan 13, 2025 at 11:07:03AM -0800, Jacob Keller wrote:
> 
> 
> On 1/13/2025 7:40 AM, Tariq Toukan wrote:
> > +static void addr4_to_mask(__be32 *addr, __be32 *mask)
> > +{
> > +	int i;
> > +
> > +	*mask = 0;
> > +	for (i = 0; i < 4; i++)
> > +		*mask |= ((*addr >> 8 * i) & 0xFF) ? (0xFF << 8 * i) : 0;
> > +}
> > +
> 
> I'm surprised this isn't already a common helper function.

I failed to find.

Thanks

