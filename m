Return-Path: <netdev+bounces-217789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F508B39D7A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84121C814B6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F09430F818;
	Thu, 28 Aug 2025 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKXxsZie"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B630EF61
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384803; cv=none; b=ZptdBTedxv99SWJ4t4Di41zEkh/RA9a+pmTb3nta12LDRVqZkt4JAju+kFAuhefaNsJQLilNz1xpo3jCDTSw5YrA3zYDOUE/skeddsFIwerw4I9I7xITaVedXUMqpt/XOaNx6l40AmPqk7Yz62u0R6Dyngm4qISw9LDadRuiRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384803; c=relaxed/simple;
	bh=4ij/DFOV6/VBnU6IONXhMlIRwCWNK2qY25k2L03f3wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvGWndbVzxjhvaCDsu4mZ8XiKJ47aEVdAs6im4U6GKuxgwJYpVx1n067jRG5L7PbnDw5960F+dmzi2HvnjionXRzozu21sJazpG7zIENInP7fEY7ED/hZ+6lqY5QW25NcbZ2oRBrOjiHo4Q90t7WYZaOzGQJHw15zZkO1ha06qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKXxsZie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5B5C4CEEB;
	Thu, 28 Aug 2025 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756384803;
	bh=4ij/DFOV6/VBnU6IONXhMlIRwCWNK2qY25k2L03f3wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKXxsZiecLeJKN1MGzYFkrLTdFib78dgWww7G50hn1Jh3rfTtbEaRBRvzeXELTzKD
	 q3VP0peoNTn8ZWTJsED7qaM+ooV6Rsw4Q1RROtmtZKa+DXPncJXMwfQl4YBwe1xaLz
	 LFNB4dnTKSMPzeOzXLL+TSygeeYI6FwwAt9Ol0/RSSLeCmDHTw70H2ZDR4ZlKFGwji
	 TAnqVHVzP6rvGA1tVSiNMy4xhTw0+Oz+ayasuQ6mavnKwyP/MoyPTwqzVVj8ACYQNn
	 ht2NXt2t+ya9elNneXkSlQ28kMIdOAL5TPotGf02Xmc6b7iGUBeYGGdj1sx45duamB
	 Utm0TkPChHiUw==
Date: Thu, 28 Aug 2025 13:39:58 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, mbloch@nvidia.com
Subject: Re: [PATCH net-next V2 1/7] net/mlx5: FS, Convert vport acls root
 namespaces to xarray
Message-ID: <20250828123958.GC10519@horms.kernel.org>
References: <20250827044516.275267-1-saeed@kernel.org>
 <20250827044516.275267-2-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827044516.275267-2-saeed@kernel.org>

On Tue, Aug 26, 2025 at 09:45:10PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Before this patch it was a linear array and could only support a certain
> number of vports, in the next patches, vport numbers are not bound to a
> well known limit, thus convert acl root name space storage to xarray.
> 
> In addition create fs_core public API to add/remove vport acl namespaces
> as it is the eswitch responsibility to create the vports and their
> root name spaces for acls, in the next patch we will move
> mlx5_fs_ingress_acls_{init,cleanup} to eswitch and will use
> the individual mlx5_fs_vport_{egress,ingresS}_acl_ns_{add,remove}
> APIs for dynamically create vports.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


