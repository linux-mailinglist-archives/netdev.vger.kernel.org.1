Return-Path: <netdev+bounces-205326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EAFAFE2F4
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C183B640B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203F2275862;
	Wed,  9 Jul 2025 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRXCbDIb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E423C4F4
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050482; cv=none; b=QfPIt2g9Px29a9TqrfRlHR6P8Rmx9jgbTLrLQkUL4C1ntbaGjCFxofeN9eigdhIob7Ge342l34iY580eyU5Oti5YxznsGkHXqn5gzAF7Nmf2kLlC0Bjy65exS/Cb3FuY206v88gQW6IczLn1+cWQtbXUevKJGzxtchqpGUhZE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050482; c=relaxed/simple;
	bh=HiYwhHyUdMmJJ5jQnYd6p3IWcJr8W/qZPvHvEF/yNG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSHhvBW8bLA5XbTi0dBuUHHcUy+cXOkPK4kQeCtI73KwA+XH83Qb4C9DQI4JxtPmMjzcDzdsEMaPx3BuJlqG3iAFzUsOQNAXzy5/5vcBDqk2nFUA0lGkU0jg70K9NNxELCFSuJf54bpSBkUJuL1zqycweoDvUjLqY1Y5IGsO7EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRXCbDIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF94C4CEEF;
	Wed,  9 Jul 2025 08:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050481;
	bh=HiYwhHyUdMmJJ5jQnYd6p3IWcJr8W/qZPvHvEF/yNG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRXCbDIbgGr+3OUsyMsfTdTr8YAT+ubWQnMyP73rv4QOPToFGF66OW/HtyEUInLxV
	 gH7kC8lc1JiuWWE7zW/cBMtuwSvrx+a/bgVhrRBf4UJg+neKLo9yR23ewvrhZbWGTF
	 xxCdDGlaFoFBkrEvFPwXDFUwBqus0ilKupxy51sIqw3VMs5F7mUV2/MadC4aJJVBKG
	 92HnLqzH2TPgWBhxDXbq5Y/S6XUdJ1lyejNVvlef6jgosT2tuus9gk/F240SmThYvE
	 lQQhinkXbHEbaSJ1Bf1f6jbNKjrGJzrVlTUvAVfRgPIdVP97rL1UNaZIBSZiBJjAkX
	 7jGX4jug6XkpA==
Date: Wed, 9 Jul 2025 09:41:17 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V6 13/13] net/mlx5: Implement eSwitch hairpin
 per prio buffers devlink params
Message-ID: <20250709084117.GO452973@horms.kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-14-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709030456.1290841-14-saeed@kernel.org>

On Tue, Jul 08, 2025 at 08:04:55PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> E-Switch hairpin per prio buffers are controlled and configurable by the
> device, add two devlink params to control them.
> 
> esw_haripin_per_prio_log_queue_size: p0,p1,....,p7
>   Log(base 2) of the number of packets descriptors allocated
>   internally for hairpin for IEEE802.1p priorities.
>   0 means that no descriptors are allocated for this priority
>   and traffic with this priority will be dropped.
> 
> esw_hairpin_per_prio_log_buf_size: p0,p1,...,p7
>   Log(base 2) of the buffer size (in bytes) allocated internally
>   for hairpin for IEEE802.1p priorities.
>   0 means no buffer for this priority and traffic with this
>   priority will be dropped.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


