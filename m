Return-Path: <netdev+bounces-82822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE88388FDED
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8339E1F2510C
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FA67D3F8;
	Thu, 28 Mar 2024 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIB7r7/5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64167D071
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624817; cv=none; b=OhZNpveNNIkUhIyb7T29w76bRWgiLvuUThELnDx6uUWvJIdDKEVibhRaF8tGTeFGYgGe+HqFnb8nKQ5YymR5ygCsSt6/jPxA3qMMK+z3hJOELRtGzduMY3fUOucc3SQ7GtjMgpRjC/q7z9EjB+qKOTLpjeTVn1nvITDYitYkE+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624817; c=relaxed/simple;
	bh=Lv3cp2LppPq2NOJ0YjPuq3snJAFqNfEiO5dPrY6uEYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg/DsNoACJJvK1CfFN927M053xmsq7MiBGEcNUToWY/6gTXv+bVaNKZ1Va0W5m/Jcq6WRH2lce14Iq55PCcsjHAFocRhzAHKdn4Cz5DPgNpYS3KPISaw1uKbTTFiJUhoSppEOkb3nxp+d3IDzhN586/F/lr5IJuyy7qcbr0vrFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIB7r7/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A41C433C7;
	Thu, 28 Mar 2024 11:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711624817;
	bh=Lv3cp2LppPq2NOJ0YjPuq3snJAFqNfEiO5dPrY6uEYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gIB7r7/55fU76qR8fy6c8lL5Z8GCx/zFwZmbxOa9JqfzGl4TsOcILiD4NAx7P25TO
	 vmiGMgdoNzaZKy67i9R+CaFXASdMCnNv3s/VDxkA2/c37D2lcQ8Hg6xzgKIl6hGT79
	 MrfNimsMxFnzs+uwKN4gWmf3fq1ayzdQHn2CkEiUUls2AiVqCxaTcDthUqrsU3uowr
	 lTLWghjZMLVIAcI5QqE9x4B6H6OzGilYCic0u0SfPckndK+MODk1ygh25Y0Zq6Iuag
	 2av7NQvVJrQNEIWXueHbmMAiN0h4fJ1NDhPdc1IHv+jcZkjo2ljYvhXMZge+bi0hUw
	 ujENtHj7P30fw==
Date: Thu, 28 Mar 2024 11:20:13 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 4/8] net/mlx5e: Make stats group fill_stats
 callbacks consistent with the API
Message-ID: <20240328112013.GE403975@kernel.org>
References: <20240326222022.27926-1-tariqt@nvidia.com>
 <20240326222022.27926-5-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326222022.27926-5-tariqt@nvidia.com>

On Wed, Mar 27, 2024 at 12:20:18AM +0200, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> The fill_strings() callbacks were changed to accept a **data pointer,
> and not rely on propagating the index value.
> Make a similar change to fill_stats() callbacks to keep the API
> consistent.
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


