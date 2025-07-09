Return-Path: <netdev+bounces-205315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB06FAFE2D7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B542177147
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC1927AC4C;
	Wed,  9 Jul 2025 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edNcDO2V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D4F26E71D
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050281; cv=none; b=fbaRa3gDGg5ATi+66oQUBPzEk4cOXr9dcFiGNiHCT7mL6TRTNRN/v6v3ywTjWqs3HoIYvMWGd+bliMHaL5ep87piq3/oI9UjCAxOoKhF085drLRvokEcQAHukRayhoetudATnYz0pRbyHHYT2O0jA3PceA44JjONcm41qmS8UxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050281; c=relaxed/simple;
	bh=0ZaAyneRgfq2wmbLWwwFwPh1QuNS+AnFleyQ2oqLD80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sg3AovvZIsADcj047GfumHd7ZfTx5rn6P36aIrgrz5dpFWpZLC6gBbyGF+D7YKvP7gmRu4QaNon6eUMLm5A0v5MX01KXzF8uzboSqpHxpBNnaqBCmT4c5VEHSvIaaBznK3P5JbXlabsSRnofOuimrDlq+sb6nEtHWsKia+/KTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edNcDO2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA99C4CEEF;
	Wed,  9 Jul 2025 08:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050281;
	bh=0ZaAyneRgfq2wmbLWwwFwPh1QuNS+AnFleyQ2oqLD80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edNcDO2V6R2hzsMMgSAkpXFzw70yQIw6l/H7B6F9BftHmr2OtMujqrCOLfs6HtcAT
	 JewLX4FaFHBFxng8LDhlMpciwi1W/E9QmHIUrOr7BWi4c2sWF523xTSh1Bv8Dn2i9A
	 FYwRBkeurzeJpuU3XmiW4THcGLCCsLYgAAw27EZoEIhL+n1f76aCZhiVPNu2ksMJg8
	 R9/97kaylQyUp0bHlpo8kCrBwYQibFi+IT1fOumzBo/rCgxQgSZFskHWl8ceP989fk
	 vp7FxzOFJgKJuXQfSO3k+wwVe5hP/jDA9X63+ZmUSeyFq28JVTovZBU/Oqxu+kc6AV
	 oOn/RePIageDQ==
Date: Wed, 9 Jul 2025 09:37:56 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Kamal Heib <kheib@redhat.com>
Subject: Re: [PATCH net-next V6 04/13] net/mlx5: Implement devlink total_vfs
 parameter
Message-ID: <20250709083756.GF452973@horms.kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-5-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709030456.1290841-5-saeed@kernel.org>

On Tue, Jul 08, 2025 at 08:04:46PM -0700, Saeed Mahameed wrote:
> From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> 
> Some devices support both symmetric (same value for all PFs) and
> asymmetric, while others only support symmetric configuration. This
> implementation prefers asymmetric, since it is closer to the devlink
> model (per function settings), but falls back to symmetric when needed.
> 
> Example usage:
>   devlink dev param set pci/0000:01:00.0 name total_vfs value <u16> cmode permanent
>   devlink dev reload pci/0000:01:00.0 action fw_activate
>   echo 1 >/sys/bus/pci/devices/0000:01:00.0/remove
>   echo 1 >/sys/bus/pci/rescan
>   cat /sys/bus/pci/devices/0000:01:00.0/sriov_totalvfs
> 
> Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Kamal Heib <kheib@redhat.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


