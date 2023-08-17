Return-Path: <netdev+bounces-28395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6194077F52F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9810B281E0D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B161112B9E;
	Thu, 17 Aug 2023 11:27:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7357BEACF
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6B7C433C8;
	Thu, 17 Aug 2023 11:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692271662;
	bh=cAdGANd11zt0nBXjUykfWHU18ZtC3PJJD2FfMXVQ9+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=occHl412prdo7j262UsCI+EjY4F+rOVumNKnYFF8YvfS4cWdQI+ibwUjyeOGNY4MO
	 TEV1SxL1+QT3P8t8fqIXFX0ZScWYA7AdinMhxI0atxC/3/gvaQXRujplteR3uGrPf2
	 DYQU60bPxgVsbLTu7SU7NxMsp6QZaWnu8LRtDCk661fG4DZy7U3T6jTonyMdBN/x9Z
	 qikcdeiXELmu/WTFTZ6uhzbHxkdIhOFSAvQMw9Ftyp6x6Sweob4hGL6OUgUkZGC4e6
	 M4e1MEfqqmEamnzeytqAaYQxkpk/jBecvVbiJ09C7BOFOVbl38Odg/CvqpMhykjCmk
	 emL3jBEhpkzMQ==
Date: Thu, 17 Aug 2023 14:27:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Piotr Gardocki <piotrx.gardocki@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net 1/2] iavf: fix FDIR rule fields masks validation
Message-ID: <20230817112738.GH22185@unreal>
References: <20230816193308.1307535-1-anthony.l.nguyen@intel.com>
 <20230816193308.1307535-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816193308.1307535-2-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 12:33:07PM -0700, Tony Nguyen wrote:
> From: Piotr Gardocki <piotrx.gardocki@intel.com>
> 
> Return an error if a field's mask is neither full nor empty. When a mask
> is only partial the field is not being used for rule programming but it
> gives a wrong impression it is used. Fix by returning an error on any
> partial mask to make it clear they are not supported.
> The ip_ver assignment is moved earlier in code to allow using it in
> iavf_validate_fdir_fltr_masks.
> 
> Fixes: 527691bf0682 ("iavf: Support IPv4 Flow Director filters")
> Fixes: e90cbc257a6f ("iavf: Support IPv6 Flow Director filters")
> Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 10 +++
>  drivers/net/ethernet/intel/iavf/iavf_fdir.c   | 77 ++++++++++++++++++-
>  drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  2 +
>  3 files changed, 85 insertions(+), 4 deletions(-)

<...>

> +static const struct in6_addr ipv6_addr_zero_mask = {
> +	.in6_u = {
> +		.u6_addr8 = {
> +			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +		}
> +	}
> +};
> +

Static variables are zeroed by default, there is no need in direct assignment of 0s.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

