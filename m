Return-Path: <netdev+bounces-79868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA9587BCC2
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 13:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633751C213C9
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 12:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2A36F507;
	Thu, 14 Mar 2024 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8o1Xs5T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582C23B18C
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419275; cv=none; b=mAoJyWh9u+O+bsIyMwznDOygE3VRAwfzO1cLntKQxE9FtUrHZU47gFuiFcrpFgUg97v5ffSEdyUxDayRqmfpxBUoIWe7nV9Kg7PBRY2G3NTAUQwXq53+5Mm0LDFaV6bvcXuyDVbT0R9+w4XZxsNbRi8kS5DC9z76mdlfcPX4r/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419275; c=relaxed/simple;
	bh=jZoaD1fLil6yadqfgqV6V8IN087RNnBZUXgZR3qXrUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djJRY5IS1KRMjrzWeuphpIJa7/xUQIYpNiwExEqyI2j+Kl231F78lwdnLeOkZjDW5jrF2V/sN5DOzO7Garr3FqNh1mQpagco/giWH5zISMMVxzYvzg5IfVugJztg+Q4Pfg38MImO/vhZ7WQodydGGgdR6N1dHcC654K9kKJjy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8o1Xs5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201A3C433F1;
	Thu, 14 Mar 2024 12:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710419274;
	bh=jZoaD1fLil6yadqfgqV6V8IN087RNnBZUXgZR3qXrUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8o1Xs5TQ6mBXVMOWqLZw4HEWsw2zxnt88DgEGu/nyEBib+IfPLPd+Gw2r+0++b2W
	 Y1yHVkDNq8t1F1Fx3smFnyVnnH4MFtV6V46ben2UJnQc/v8eJw8exE4KaOI3LhuhY5
	 eC00zDwptRai6uyWzyXB2ISXAmcCuokNDyRe7B+2HSAaRYwByIh8F5enih2p+b2Gpf
	 Ss2i+6HGVps53wTFUPc5ZmXVel4BhzvYcAZ0+wIcy6UHke8ZbWnZN6KKMCp4YvUP5M
	 u6hJlCqc0JEdoadIU1rf7t/P9IZ7/FPwXK+k/D0Ar602iweKHhhwXjl6/tvyozYvyJ
	 D4DdS9PgYGA0A==
Date: Thu, 14 Mar 2024 14:27:50 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v4] xfrm: Add Direction to the SA in or out
Message-ID: <20240314122750.GD12921@unreal>
References: <515e7c749459afdd61af95bd40ce0d5f2173fc30.1710363570.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <515e7c749459afdd61af95bd40ce0d5f2173fc30.1710363570.git.antony.antony@secunet.com>

On Wed, Mar 13, 2024 at 10:04:51PM +0100, Antony Antony wrote:
> This patch introduces the 'dir' attribute, 'in' or 'out', to the
> xfrm_state, SA, enhancing usability by delineating the scope of values
> based on direction. An input SA will now exclusively encompass values
> pertinent to input, effectively segregating them from output-related
> values. This change aims to streamline the configuration process and
> improve the overall clarity of SA attributes.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
> v3->v4:
>  - improve HW OFFLOAD DIR check check other direction
> 
> v2->v3:
>  - delete redundant XFRM_SA_DIR_USET
>  - use u8 for "dir"
>  - fix HW OFFLOAD DIR check
> 
> v1->v2:
>  - use .strict_start_type in struct nla_policy xfrma_policy
>  - delete redundant XFRM_SA_DIR_MAX enum
> ---
>  include/net/xfrm.h        |  1 +
>  include/uapi/linux/xfrm.h |  6 +++++
>  net/xfrm/xfrm_compat.c    |  7 ++++--
>  net/xfrm/xfrm_device.c    |  6 +++++
>  net/xfrm/xfrm_state.c     |  1 +
>  net/xfrm/xfrm_user.c      | 46 +++++++++++++++++++++++++++++++++++----
>  6 files changed, 61 insertions(+), 6 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

