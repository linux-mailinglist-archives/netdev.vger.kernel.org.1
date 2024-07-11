Return-Path: <netdev+bounces-110705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A8A92DD67
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 02:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9597282D44
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 00:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FE281F;
	Thu, 11 Jul 2024 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MudpCDjQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED5383
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720658643; cv=none; b=rRp+m075kzSdvVFu4nbWL2PMLcUWceAcOAWnfWL1DeBJEfTqymcaLSoUmIqR1P7pT8Z7UBN/PCx4toXSYcBui9urSxIJSxzz/7Y+iLbfZaTKGxxIZe+UIILwhLAdnPKsYs6+O0jWzLggSqrExI5xK1r/z9GBUPPkvhBPKW5HOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720658643; c=relaxed/simple;
	bh=g4b0RW1r4pwSbko8s9KoZ6V6Ks73HRaJzXBaBbKVgcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIFUZHd4m/e8imhInhwRlGP2hK0S6st0QAEwUKkCSgpOwgqXt0PS6rRv3WO6tAq1jKa97Da8NwPFa2GqV+gl0jnxVGa3tx03ytJWO47UajDquJSlE1wR6r41vxm0VV33E5VNcfbokix1ZigWKFxaUghmyPYRTD8/8iBAFqn26iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MudpCDjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1DFC32781;
	Thu, 11 Jul 2024 00:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720658642;
	bh=g4b0RW1r4pwSbko8s9KoZ6V6Ks73HRaJzXBaBbKVgcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MudpCDjQ/SJ3LEWQYYSn+Q4cctg9UGiUeGf+0oKLwAeJKM88jJSiKHlmrTAjcPxo2
	 4CrAi0gP7HibQ/mjUmj43AmTDqLKmrUxkLxZrN6WBJ/Y/WdCbzpi1NDJ5Xv1c72FPg
	 PAThSRxS5LowwJqwCvwABvG0tGZCQ9XZuPsZKZ46eKmg04P6yrdIZnV9jtXRxPCe3x
	 uBn92bBetYScb/hrtvK+bjgwvmTX4XrJR9EzToLOjM83CDfvv3+4d3FwPXq0Jkf7tl
	 wTQgvUvL76fd0DCrmoDj63bUZ5D730IQ84g1vCjolYvmKu9QuJ9W75rrseIafwTsv8
	 cQZ8NuXS9N3sw==
Date: Wed, 10 Jul 2024 17:44:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Jurgens <danielj@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>
Subject: Re: [PATCH net-next V2 01/10] net/mlx5: IFC updates for SF max IO
 EQs
Message-ID: <20240710174401.70e8f956@kernel.org>
In-Reply-To: <CH0PR12MB858029A605D7AF3849C54F6AC9A42@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
	<20240708080025.1593555-2-tariqt@nvidia.com>
	<20240709185444.6ac9f178@kernel.org>
	<CH0PR12MB858029A605D7AF3849C54F6AC9A42@CH0PR12MB8580.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 13:08:31 +0000 Dan Jurgens wrote:
> > > Expose a new cap sf_eq_usage. The vhca_resource_manager can write this
> > > cap, indicating the SF driver should use max_num_eqs_24b to determine
> > > how many EQs to use.  
> > 
> > How does vhca_resource_manager write this cap?  
> 
> In most literal sense, MLX5_SET(cmd_hca_cap_2, hca_caps, sf_eq_usage, 1);. 
> 
> But getting there flows through:
> devlink port function set pci/0000:08:00.0/32768 max_io_eqs 32

Makes sense, include in the commit message, please?

