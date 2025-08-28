Return-Path: <netdev+bounces-217793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF8AB39D87
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65828985EC6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D70630F937;
	Thu, 28 Aug 2025 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a85YRoex"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AC830EF61
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384868; cv=none; b=K85WerFJEsTEx2pg5QO9PhqQlS7mqZ82ZEr+kWOufwYyCsHSx3rKk7UkjbuOODZsNzo4VB3mO2zSS3FhrmOUK9HgWzaQ7qY0uk4BBrMJ7+5NgT9zj4M27hvfg4U6htsUndGiokyxCReboB5hqsoO4uNEcCzfemdhjiQXri7vDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384868; c=relaxed/simple;
	bh=HhpWUf2/JIcXUEaQbrh4Z+AC8CaOO2eSqSs2OqJmLJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcwWht4yMamoN9NgEg9e41T5f5bwVxQJcb6b2OMINGYUM77Q2AXAv9f9ook/ZOUawQUC4xTvondX0RP0fRgcT/TpiDGagyWXOGkB1jyK2CjIXQPiIILGwBxo8H5yKbc/J38SN382SzF3rMRJrU31GvngNcGoS8mJmnoxZKT0bwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a85YRoex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC53C4CEEB;
	Thu, 28 Aug 2025 12:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756384868;
	bh=HhpWUf2/JIcXUEaQbrh4Z+AC8CaOO2eSqSs2OqJmLJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a85YRoexEpt6Z06clpnflJLsSmqmAT0ht4ipVDj9PSos6hEqNSDA6sVCeyzr9l1PH
	 sPqTYHv/f7OHIbDoTVQRKUgL3RG0xPkowsGjmU4htwebNMHBP6LSYLnSfQVcVmnBHm
	 6XLyhyhYLdR+Ur7CiAvJ6bgXZFgjD1QjAr21P/1+tbLLU53PnHB5h5DFI+PZhUDVWn
	 A+np+P5jr6JZv0MaPPt7HasFnpwTYOrwk9L10X7/2yeuwuJ+aX4O1SEICNB10ifSma
	 1fb3h8uKf7TANKv7ykV+tl0PnIYiCihQAyvX7UMNO7TCKb8x7ZnOVmVcb+YXa6B5Ma
	 5USh7w0Pz99pw==
Date: Thu, 28 Aug 2025 13:41:03 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, mbloch@nvidia.com,
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next V2 6/7] net/mlx5: E-switch, Set representor
 attributes for adjacent VFs
Message-ID: <20250828124103.GG10519@horms.kernel.org>
References: <20250827044516.275267-1-saeed@kernel.org>
 <20250827044516.275267-7-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827044516.275267-7-saeed@kernel.org>

On Tue, Aug 26, 2025 at 09:45:15PM -0700, Saeed Mahameed wrote:
> From: Adithya Jayachandran <ajayachandra@nvidia.com>
> 
> Adjacent vfs get their devlink port information from firmware,
> use the information (pfnum, function id) from FW when populating the
> devlink port attributes.
> 
> Before:
> $ devlink port show
> pci/0000:00:03.0/180225: type eth netdev eth0 flavour pcivf controller 0 pfnum 0 vfnum 49152 external false splittable false
>   function:
>     hw_addr 00:00:00:00:00:00
> 
> After:
> $ devlink port show
> pci/0000:00:03.0/180225: type eth netdev enp0s3npf0vf2 flavour pcivf controller 0 pfnum 0 vfnum 2 external false splittable false
>   function:
>     hw_addr 00:00:00:00:00:00
> 
> Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


