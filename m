Return-Path: <netdev+bounces-204664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0B0AFBA8D
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A47C425D53
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7513F2641F9;
	Mon,  7 Jul 2025 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETHT4fNt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E421ABAA
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912378; cv=none; b=h18FX2/1dudOIAfsiiFHsEUQl2K14LJ+iXDQQE1Xdr7AVWQ+9DxhU641unla6TxAKQMEEQb1LlA9sITbkj8uDbktzJKlgNC25SAuaK7flmXBO2tJZItQ1bllwkkUJb+v3rQooqSe0FvO6JLYif44ZqrdCdQqooczVq/ZhoxTbNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912378; c=relaxed/simple;
	bh=vsuadS+81njsSR7eQpyiTHDB5AKne8b1Pu+zrjpf2ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8E6PNwaId7zOB5kdSuErmXnb/D6T556eZnwrxY85xYeBLIkD7KL23ZN9wEJOz/h9mttqG+AHlLDovnzHYVXXjndcCh0Yc1NMe2o2hrK6hX5MdjtMSrBF2q5bFwIJwpZgwj0DY36GUJClMdIF7alZHCyw+jeDKDksMlR8vCmURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETHT4fNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5233EC4CEE3;
	Mon,  7 Jul 2025 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751912377;
	bh=vsuadS+81njsSR7eQpyiTHDB5AKne8b1Pu+zrjpf2ZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ETHT4fNt/aHh1sdqiDOXWeF7V1GRVuam6sipyCTO+cCy7NNOvexADlVg5vdzgCbI7
	 0xdv2yXWcXRhboH5ghn1m9uj3pnq5gyCD9ItMJbs+dSPUyEBUpExo+WxDEE84bIX4V
	 BFokvRBpatp9im6noReyNZ2G5lw7fLnvPXtmIcEMGx+uHgxh6xMj8DIldJ5bnPKp+s
	 YM0g5m3rgE8kwr0oE6ZGB11L0ni87BJ9ctx8kOTBywkbYVH/wwv8N/BVX8aZArLOHd
	 TxvCkE7AEUt7bsdLqx2rGeROSXNY+nbNtHCFlRAXEobdspjdWZN0+ynHOmWMJO2UVq
	 JXVKUglDM5MWA==
Date: Mon, 7 Jul 2025 11:19:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com,
 leon@kernel.org, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v2 3/5] eth: mlx5: migrate to the
 *_rxfh_context ops
Message-ID: <20250707111936.05b858b6@kernel.org>
In-Reply-To: <b5f66ba0-7d1c-4228-b0ec-f62aca289b23@nvidia.com>
References: <20250702030606.1776293-1-kuba@kernel.org>
	<20250702030606.1776293-4-kuba@kernel.org>
	<b5f66ba0-7d1c-4228-b0ec-f62aca289b23@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 15:22:41 +0300 Gal Pressman wrote:
> > -int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
> > +void mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc,
> > +			bool *symmetric)  
> 
> I assume this doesn't compile, you didn't remove the return statement at
> the end of the function.

My bad. I was build testing drivers/net/ethernet/mellanox/mlx5/ which
doesn't have a Makefile..

