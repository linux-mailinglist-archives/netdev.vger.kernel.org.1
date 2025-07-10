Return-Path: <netdev+bounces-205955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC69CB00E9B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB2AA7B6B49
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CFD28C030;
	Thu, 10 Jul 2025 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRYmecJQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD6A274FD0
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185819; cv=none; b=noKX0xA503HNQMF/KZTZn+DWFZ4BCSaqjF9Z6+S4Qi8R6HFGEqtvj0MVDzeLCHIj8J8aFOGesNcf9YYHzJrXZTLqDK+pEv54sUB6RbLNXf8JvaWgaiD/68bC/1yi5q+zsdheEeu68M95sunOSYn78Ypua8V8ssqqxEtkpX01Unw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185819; c=relaxed/simple;
	bh=937w+Y6sSbmngbnnDiLUMgh3hycW/s+i6Qqu+sbDY3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVN7j4lJqVavrSnhk0qtYL1gByB0eZ20GBzG7HfJjscpEiS6/HiCgTOzQz6KDDVghuFPxdHN93ztcoHoB0MpCUxh1XlTZS+5R32aOxOnZn6HcWca71cSuC1dY844GoGg2WCXMJ9sNrlzL6R6BdFWzCNCy7ujgRrQrXM7mVfUffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRYmecJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EE3C4CEE3;
	Thu, 10 Jul 2025 22:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752185818;
	bh=937w+Y6sSbmngbnnDiLUMgh3hycW/s+i6Qqu+sbDY3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lRYmecJQl+ITpxz0aWf/NQy+q+WVqr0DU5tzwuNGcEwdUnmQrZs4VePEhjovU1yhS
	 wCOOW++FkbUqHKSA9cD1gTRmHJ5JpCVj8u4zRxsffvRMxALf0lVrRXnO2vYJMcEEZX
	 IIgub2DcV3OipVIxdgE2ap+Ch8eqUtX06oKgoqH76Dw2orO6ICDp5oHpINos9M4KDG
	 zTwkBXPOCkt4femHDjC7VOJRl5AKTYX47JIAkjp0+7VsB3HAbI4be3LjFwgePqOilT
	 H/4smFKvO8d562j8aoKW+BOLK5vU8DyM95AtKn6cR02asb+pWsjgi8RMVfP1v/4rv/
	 7DSbRDe1xS5cw==
Date: Thu, 10 Jul 2025 15:16:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next V6 02/13] net/mlx5: Implement cqe_compress_type
 via devlink params
Message-ID: <20250710151657.5221ffcb@kernel.org>
In-Reply-To: <aG9TUPziunm1tRgR@x130>
References: <20250709030456.1290841-1-saeed@kernel.org>
	<20250709030456.1290841-3-saeed@kernel.org>
	<20250709195300.6d393e90@kernel.org>
	<aG9TUPziunm1tRgR@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 22:44:48 -0700 Saeed Mahameed wrote:
> >You already have a rx_cqe_compress ethtool priv flag.
> >Why is this needed and how it differs.
> >Is it just the default value for the ethtool setting?  
> 
> cqe compression can be enabled or disabled per queue,
> the priv flag is to enable/disable it on the netdev queues.
> 
> This permanent devlink parameter selects the internal ASIC
> mechanism/algorithm for compression which is global for
> all the queues that enable compression.

makes sense, please extend the docs..

