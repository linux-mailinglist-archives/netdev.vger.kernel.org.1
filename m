Return-Path: <netdev+bounces-178890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA68DA7959F
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 21:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AD11886A4E
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9A01BD9D3;
	Wed,  2 Apr 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lG5Mr4cb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D06EB7C;
	Wed,  2 Apr 2025 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743620829; cv=none; b=nHUuAF6GOTjcdGO51KlQa75NQYHzkUc9huT1axwvIBMLc+T3znl7+DniFXpCHzIWYXBdQQf5JV9ENSgspnghYlUq/QXpunYnaKzP9GgzN9medwhXi3ogA1J3JneJ90FYve1d9S3p2iYD6I1ZrpUWbRdqSjHyUQDHqAfmpH+HMLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743620829; c=relaxed/simple;
	bh=8uB8u1O7ZrponzzpehOdoRNb9Kp5KteqIhH4CFV830Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFe8YYogflBYm63XI3Mp8NsYxYyT6JYf26S7gHaHSKm86QnmtM3JZ1CWRd/ND2S8NGIocj12eCzkMQyz9AXBktcd2zIED8Tt+4bJ4RzqkQMiHC5e8fs/CUZEARwB3BAYD62FqmVGuJk0ZxpAHn+EYGUMbKSWyumjKzSV7v1eqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lG5Mr4cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E441BC4CEDD;
	Wed,  2 Apr 2025 19:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743620828;
	bh=8uB8u1O7ZrponzzpehOdoRNb9Kp5KteqIhH4CFV830Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lG5Mr4cbBWNrzfpLyKAPh8nC89XnQ8RLm6oXcIkvPZ/3QJ1FXzFEXmL/3hThYhh5c
	 P+IxDquzV2+AuLEsUNx9yO+PRfNwSg9Vf7pPe6SSY1ry2YT+mRu86h394Rz15gtbt3
	 5oIa6MSR7uKyAwTDj6yYteDKVYfw37CFk0jTWSA5aLmvFpjRYChkCUmUd7PwpYBVxv
	 3xJHO02ShzoqVw/tKzP4N5pj5gD0b9+OTVTAzTWvB8pUXzvs1Ld1PNay1HRbv8eVqe
	 rVD5zXJMdJ/f/VpA0mXvl/z6QT6PGchy5s2AleOSZFHw1Guu+tqtd8GHpS4g/RIrIM
	 VROcqJPRnmZdA==
Date: Wed, 2 Apr 2025 20:07:03 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 6/7] net: hibmcge: fix not restore rx pause mac addr
 after reset issue
Message-ID: <20250402190703.GZ214849@horms.kernel.org>
References: <20250402133905.895421-1-shaojijie@huawei.com>
 <20250402133905.895421-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402133905.895421-7-shaojijie@huawei.com>

On Wed, Apr 02, 2025 at 09:39:04PM +0800, Jijie Shao wrote:
> In normal cases, the driver must ensure that the value
> of rx pause mac addr is the same as the MAC address of
> the network port. This ensures that the driver can
> receive pause frames whose destination address is
> the MAC address of the network port.
> 
> Currently, the rx pause addr does not restored after reset.
> 
> The index of the MAC address of the host is always 0.
> Therefore, this patch sets rx pause addr to
> the MAC address with index 0.
> 
> Fixes: 3f5a61f6d504 ("net: hibmcge: Add reset supported in this module")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


