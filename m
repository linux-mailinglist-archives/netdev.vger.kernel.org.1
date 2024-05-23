Return-Path: <netdev+bounces-97740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A573E8CCF96
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BF91F230BA
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F363713CABD;
	Thu, 23 May 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiOXrAXd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83847A7C
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457618; cv=none; b=DL4kbLEj2E1HiLbomBGHEoKB8Yuhnu08Cx6TUrYfPemCDvkiMoVsHpV+ldfeQUn+tp2gN8ixMlGlm5hV2RSishxLa72zusUeo4VnDGItTQy3hta5oUxUCwwiXsazTs1/FF+jnouZXH6Ao2br5JLVWQIKlysodRqUd/B8vSOpI2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457618; c=relaxed/simple;
	bh=46N/YaAS3YslqAKQ8V2ZPOKiJj4peeC4w74Pdpwno8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foRIiG3sIj82gQdbHZcFUvWEXvZLsJM1NamNhRro3gquyC9FLlbSbSaIp41D7XhB5o7X4Y3iFpkpe8YlEcKf0npv4iZ+zqEByFfulBEIm+f35bMSiRGjvwuhDuL3dENUCeuwRS0wYFVHGeR+pv8VlDpZBsDOHzdmYP03yKNum/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiOXrAXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3CEC2BD10;
	Thu, 23 May 2024 09:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716457618;
	bh=46N/YaAS3YslqAKQ8V2ZPOKiJj4peeC4w74Pdpwno8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LiOXrAXdPoGzszTOD/lzuzaxd1dqv+hqSpuqmtVik19eGh53YZJlQEBYF78JbUe+n
	 vMI4RZB0QISONRoIS1maSPaO2jI65x5SdFMPovOcvfKAVjdrdMHt90e+4ME000iKjD
	 3dWGtDm1cFHoW+G791wJTmUpha2xrz9qs/Be0qjYA/VJQdIJh7XPggNXrGCPlOsw89
	 d/Q3fsH4AiY9a1VRZ3WMfeR3WCDHCfmnYlcgfdZIAZniZiTjVjw4XJbiC/D31omT6O
	 vAAJvufU61N15V+eXn0w5E+mbnBdWzAQ+YobedNleR0VCArBiLN5SCLGAn/0AMiTKX
	 S+bKjkox35VYA==
Date: Thu, 23 May 2024 10:46:54 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net 2/8] net/mlx5: Do not query MPIR on embedded CPU
 function
Message-ID: <20240523094654.GE883722@kernel.org>
References: <20240522192659.840796-1-tariqt@nvidia.com>
 <20240522192659.840796-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522192659.840796-3-tariqt@nvidia.com>

On Wed, May 22, 2024 at 10:26:53PM +0300, Tariq Toukan wrote:
> A proper query to MPIR needs to set the correct value in the depth field.
> On embedded CPU this value is not necessarily zero. As there is no real
> use case for multi-PF netdev on the embedded CPU of the smart NIC, block
> this option.
> 
> This fixes the following failure:
> ACCESS_REG(0x805) op_mod(0x1) failed, status bad system state(0x4), syndrome (0x685f19), err(-5)
> 
> Fixes: 678eb448055a ("net/mlx5: SD, Implement basic query and instantiation")
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


