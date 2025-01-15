Return-Path: <netdev+bounces-158350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C7DA1175C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EE2C7A1865
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EC36FB9;
	Wed, 15 Jan 2025 02:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYTQ4cz0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238CA232441
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736908657; cv=none; b=AXvcrUmpte91xab5WX9QWQCVcmb+h2jSXx8vGDstOw5HAI4ZhCn6WtOpBb3b/P/L8nGs1Nw6Gq2gXSDjc3kfprWohJvxGsmJWtHgDIJm3Qhs1unqgMtREj12drli77ZSFiPeAjHCb3jKgf7NQEyop/OIGlAks9vN79ocWzKCVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736908657; c=relaxed/simple;
	bh=f4rmOMPDU9GH6K0cuHkto7n+i0Viiy/KN/5BTtrmvNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFDfx6EgTiguqZDTyiafUzwp3xdnliRA/0tZUHkbICJKMXPn4vpUEKu5QhsGS8vxj7b/U9xq5JJYZqdkIbhx5DqG6uh1WEzs1I0Ru3sBZ6wkeJV/UPTOYtVna38nIf/vmwBJTlik/HcOawYYWDhfd59ANf/0BjoRrPa9i45DO1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYTQ4cz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CE8C4CEDD;
	Wed, 15 Jan 2025 02:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736908656;
	bh=f4rmOMPDU9GH6K0cuHkto7n+i0Viiy/KN/5BTtrmvNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pYTQ4cz0uGEx+S6dp0MzH6u8GLnWUybX/Y3ZPEGWpI0/TWuQrbO0adACui2zNY3fY
	 IV28k+O54A8mPwFZqQ+xmfkQjUgEDXC/VO9UccSmBoinuduY/PH/ABmSUDk6NnHn2J
	 lbmpiJkFT31E70H2tZVFlFm8o7rt7sbAbd08B+vik2GgJcVXFINDpd99A4FqRe71hp
	 diQV4hwMfhsJVH115WiaNt8ty+in6w06t+JLb4N3q2fqB7+FHXFv4zzqOxPkUCsh5F
	 dUFtdDCmaM/vKYBW0cdsX9Ny6VHWyJ54dD4Pk04ClpLtAvyBon2nhfHcfor//5NMIG
	 po4aIG6yV6wFA==
Date: Tue, 14 Jan 2025 18:37:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>
Subject: Re: [PATCH net 6/8] net/mlx5e: Properly match IPsec subnet
 addresses
Message-ID: <20250114183735.15aea391@kernel.org>
In-Reply-To: <20250113154055.1927008-7-tariqt@nvidia.com>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
	<20250113154055.1927008-7-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 17:40:52 +0200 Tariq Toukan wrote:
> +static void addr4_to_mask(__be32 *addr, __be32 *mask)
> +{
> +	int i;
> +
> +	*mask = 0;
> +	for (i = 0; i < 4; i++)
> +		*mask |= ((*addr >> 8 * i) & 0xFF) ? (0xFF << 8 * i) : 0;

sparse is unimpressed with the lack of byteswaps here.

drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c:1159:28: warning: restricted __be32 degrades to integer
drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c:1159:23: warning: invalid assignment: |=
drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c:1159:23:    left side has type restricted __be32
drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c:1159:23:    right side has type int


Maybe just force cast to u32 inside the helper, and add a comment why?
Or just byte swap.

Also from the word mask and subnet in the commit message it sounds like
you are shooting for a prefix. But this does "byte enable" kind of
thing :S Think 10.0.55.0/24. Maybe mention if this is intentional in
a comment, too.

