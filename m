Return-Path: <netdev+bounces-97744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7338CCF9F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408EC1C209CE
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69C413D2BF;
	Thu, 23 May 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugSeFmT1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5013D2A8
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457706; cv=none; b=UPxzUOJ7C7jJCV7/6JKLM17F2yfJX7CYSsCD36D9uhsKoBDtRuqzTp6kl+xWoWfrakDHvL6Du6otEmUW67Iw7tzoyedRsFFgw7g2rPCh5Usi2tSePAMIWNPbXAq13OzCQyXxIgl8SOdjQgKIUNIDXj8ieisYj6DY8TtXcgj0DTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457706; c=relaxed/simple;
	bh=VH5N8s6e+hfPhxKoMON3DrGga/V7jC8ck/h3vn21m6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5thgaJtRP3KI8IkAxethuUCYfrDuu3uhzsQ/SVqJZI9oaVb9zIRDG7Rz4crU2FOFu7+Bysg3iB9CVg0U7hurombsL5hGQhQlKQSJjtneYyuPVl4KkCT8xTTj+cnBJIfL7hYBp1T5MqTHsEjb8DDBvVrfHqCLBUz9kVMgzW35cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugSeFmT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D3FC2BD10;
	Thu, 23 May 2024 09:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716457705;
	bh=VH5N8s6e+hfPhxKoMON3DrGga/V7jC8ck/h3vn21m6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugSeFmT1t6wQd/eQJISBywRJIGO03VEUZYE28hxFAMBQ8YrsQAlnHO+a2e9yPMV1N
	 cL4hSu8laehBxTW1ku1AP4pMPxqZqXazUVYUe1Gq8zJ78K3UGlaMIEKn9SN35FcYGE
	 Q0NFt4nKCTHk1VivixLznGC9vfhNtv3PnrHNQu8gTR0pV18PYdMuC2wth0KS6J30ct
	 LWMzgoTDIaOvL3OizyY0K5Qg1uIsADnSpsU1JF6Sl64DDMC9X2GuglaAdIdhBFmpki
	 YvzzJ4q5r1KiCwRsACkJzwvvQlQfIJ+GHg8t9RHd87/QGNaprAQi7SUahXMC6NO7kb
	 cIVC0HmQhJ/gQ==
Date: Thu, 23 May 2024 10:48:20 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net 5/8] net/mlx5e: Fix IPsec tunnel mode offload feature
 check
Message-ID: <20240523094820.GI883722@kernel.org>
References: <20240522192659.840796-1-tariqt@nvidia.com>
 <20240522192659.840796-6-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522192659.840796-6-tariqt@nvidia.com>

On Wed, May 22, 2024 at 10:26:56PM +0300, Tariq Toukan wrote:
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> 
> Remove faulty check disabling checksum offload and GSO for offload of
> simple IPsec tunnel L4 traffic. Comment previously describing the deleted
> code incorrectly claimed the check prevented double tunnel (or three layers
> of ip headers).
> 
> Fixes: f1267798c980 ("net/mlx5: Fix checksum issue of VXLAN and IPsec crypto offload")
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


