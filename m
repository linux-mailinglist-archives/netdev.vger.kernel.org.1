Return-Path: <netdev+bounces-217791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A062B39D83
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B5D3B7C3B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6D530FC05;
	Thu, 28 Aug 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcVxRCzl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A9930F818
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384840; cv=none; b=KD/ARmsaTxnQtAi50pVGeZ0Psem7L/Phk9emqMq8vlKJsOVT7ME1WKSHNvZRWrkn8ALeA5p2wkzVdFj0GgGIIpQOO6WOVffOCUwiw7Zx3b8YP/1+5KeB4s157Xs+YYjgUjp+1EaRzOoxGUEMDKdoS4y2EBdH91aSGI9sY7MTt4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384840; c=relaxed/simple;
	bh=V4gJEmf2AgDklxLibaib4qHwFCkuwexJbXLWzHaNibQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+yRAfd9LKsQoCG5VLy6mzP1VeXisWy2sOunl7d536y0AApKst55D/L98cNTmqnIR0IhjQ0+5/z5Pk7jtwGbx5T9Fh71dD6DUhoFIUhOEvIDYa8+fc2krjkK6Yd1jZH35nGNS+JtTmSYjkA9jbVvrk7WqRRUGBCWG/MGfLohnF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcVxRCzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9CAC4CEEB;
	Thu, 28 Aug 2025 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756384840;
	bh=V4gJEmf2AgDklxLibaib4qHwFCkuwexJbXLWzHaNibQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LcVxRCzlyI46JgfObQXitb+ooxDS0rLEWT7WH4OZPRDiWk8r20TH6+n/OdQAaQd7r
	 IxV4Zyq1Z8M6W7JqvcTXxS9ajjXwFXWSx88OlS/EniMi5udYCRfXzp2HDY+ZaLcWAW
	 6nTGxbImdIqJrNBeaX7uHHfdw7LPY3KecTm5c0e0ytyr7lUssbOlqR8dO/6fNZdsFI
	 GjQAXPBIjEiB1DnwEty6uhd14KwaEvB5xCmRkrtE8egVW3QokKciTkjb6E4dO/REef
	 as0/ZwQIzcSsjmENncgI2LBrYVCh4rO0pRMosM8uCQP904hLoe3qNFpRJezpPAzZDG
	 64fQDp2Tde23Q==
Date: Thu, 28 Aug 2025 13:40:35 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, mbloch@nvidia.com
Subject: Re: [PATCH net-next V2 4/7] net/mlx5: E-Switch, Create acls root
 namespace for adjacent vports
Message-ID: <20250828124035.GE10519@horms.kernel.org>
References: <20250827044516.275267-1-saeed@kernel.org>
 <20250827044516.275267-5-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827044516.275267-5-saeed@kernel.org>

On Tue, Aug 26, 2025 at 09:45:13PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Use the new vport acl root namespace add/remove API to create the
> missing acl root name spaces per each new adjacent function vport.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


