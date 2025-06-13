Return-Path: <netdev+bounces-197585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B897BAD9405
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA1A3BA153
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1727A229B1F;
	Fri, 13 Jun 2025 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZF20l5w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670A227E97
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749837370; cv=none; b=LJXtDjaInSm99qctCuTrLklAp++vANsFUbmBqtNZsXdDAT8BNTgDs0+r/pJwVKCEtJQU6wtgzUAQCogYI2qraEJGhW9fSFUzGe/XhaAD16G8zo4bHbdwJR09W2zi7wRiTj9UwjLenYYyQakeFFA+uwywFYLRlGnYCUVOZx4cpIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749837370; c=relaxed/simple;
	bh=sk6BSKokDYyPzIp1GEiEe/wGYX2WQzpn1huqNhxUFfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kARvz0b11ep62dThltLKHeOqEDL/aGE3038KVdOXgDseTS1d/nGAdPCcl0/63Uxm6h3DRdGP+bvoojERR08loPfv04+YDh7PQHcVswUKy0InZm7VVVBSg3cuwN3GQylTX5s1wccKdUMDgxa2rhLBqKiLf2OBfJzrPRYLoMvdTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZF20l5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8A9C4CEF2;
	Fri, 13 Jun 2025 17:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749837369;
	bh=sk6BSKokDYyPzIp1GEiEe/wGYX2WQzpn1huqNhxUFfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GZF20l5wkOawmUViTa+Fv5yYLRw5w46uVEGvFj4rJs4UUN0Dd89gh2kaxTsBDarl2
	 3Z5QJYMi2Ku4soZ6yzuE6AckBW4xrP7cm6nj0ttJ5uEQhYrHQaw4Q2d5mQ39ZY0je8
	 PoGr4X+9ulg19HYRzs6YBGqiRkQDlssSONE7TDdA5xDPK7QDk/vYa7dOGUwdGEpzAr
	 YHYrJHBPnv+R4xO6LpRkcqWYCHWC4XtVQG/hGaTfb/YneUOwGPSHR+RfXTsLJt+1Ug
	 +2sGZwh6xA/tDgdIBzE7SsiCcXZPj1jyM4KdfagtzpQS5HIWbXCEJ1f99c1qsfJWXE
	 lMbBlqx5xgCcg==
Date: Fri, 13 Jun 2025 10:56:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, michal.swiatkowski@linux.intel.com
Subject: Re: [PATCH net-next 3/7] eth: ixgbe: migrate to new RXFH callbacks
Message-ID: <20250613105608.7eed2f13@kernel.org>
In-Reply-To: <20250613010111.3548291-4-kuba@kernel.org>
References: <20250613010111.3548291-1-kuba@kernel.org>
	<20250613010111.3548291-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 18:01:07 -0700 Jakub Kicinski wrote:
> @@ -3797,6 +3795,8 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
>  	.get_rxfh_key_size	= ixgbe_get_rxfh_key_size,
>  	.get_rxfh		= ixgbe_get_rxfh,
>  	.set_rxfh		= ixgbe_set_rxfh,
> +	.get_rxfh_fields	= ixgbe_get_rxfh_fields,
> +	.set_rxfh_fields	= ixgbe_set_rxfh_fields,
>  	.get_eee		= ixgbe_get_eee,
>  	.set_eee		= ixgbe_set_eee,
>  	.get_channels		= ixgbe_get_channels,

same bug here as in enetc -- there is another ops struct that needs to
be updated.
-- 
pw-bot: cr

