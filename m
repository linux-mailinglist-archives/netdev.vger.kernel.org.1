Return-Path: <netdev+bounces-105664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B979122F7
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D69A28164E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798A2171E4B;
	Fri, 21 Jun 2024 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVpcLNQR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5554782D72
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967863; cv=none; b=GbAOd5ivKsxaDk4cBFuIOOChX8Gg4gHVMszjQOVX9/4/PEk9ZuTc8o/YIsZ3Yl4MBUjhGKcNrsUFYM/vxbyHu6cKXxyjuPSgHdZ0pR8PfHJZhfxkeuVtyQYqHjYSkIICKaWfAf3cqjKUpYdDQZvjhNB4GeVAE00sy01y0g8nYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967863; c=relaxed/simple;
	bh=S+CGCWOmRP1HnS/TT7MbigFXpa5jS1nfcPciaPTJef8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dogNHI5cobV0khjW/8P/yOTnfKGfl2qbDiByRz8MOweY7WCOZZ6G2uKKvOhX3qGNAytn7N48hBkJ4vN5Nx5zTUgCdSYUCGGWDzXl70AJ5Xo48a6d0Vq9nMFzenIK+jtkuBCoKZgsChA6E6plpqp9pSgcF+CuqbRc6XejCZb85LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVpcLNQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893C6C2BBFC;
	Fri, 21 Jun 2024 11:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718967862;
	bh=S+CGCWOmRP1HnS/TT7MbigFXpa5jS1nfcPciaPTJef8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVpcLNQRUkb+RhW4FFiB9nrTyYW1tluc1GGn4r0WYXwGq+fvTmyd9iVXGRVfiCgNp
	 UtYPi8ecjKl5Cu2jNuxToEKJ5DCHd2LkKz8urwgAstl5c9KdaZG9SJe8KbaKuWi2TH
	 /ZLZVCFExXVBKmuqn7NcsR3Q/C5yzrVNj5cC/kvysjHAiSFRqsOMMtDUncPoXhAyxL
	 1pOdiDuIi3u2FhX0gWfvwzhL9RkPW5hTrNJ7klG5yF7w2hsofr69ZpacXpwPYiPDXa
	 98v6EpSkqcUjUNrFGRfQDgJCdDElR8PgA9Gkpo50Z2okB5x8ROsj8SIq3P7cvkbhKc
	 pouRSb7AhFn1Q==
Date: Fri, 21 Jun 2024 12:04:19 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 iwl-net 3/3] ice: Reject pin requests with unsupported
 flags
Message-ID: <20240621110419.GA1098275@kernel.org>
References: <20240620123141.1582255-1-karol.kolacinski@intel.com>
 <20240620123141.1582255-4-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620123141.1582255-4-karol.kolacinski@intel.com>

On Thu, Jun 20, 2024 at 02:27:10PM +0200, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The driver receives requests for configuring pins via the .enable
> callback of the PTP clock object. These requests come into the driver
> with flags which modify the requested behavior from userspace. Current
> implementation in ice does not reject flags that it doesn't support.
> This causes the driver to incorrectly apply requests with such flags as
> PTP_PEROUT_DUTY_CYCLE, or any future flags added by the kernel which it
> is not yet aware of.
> 
> Fix this by properly validating flags in both ice_ptp_cfg_perout and
> ice_ptp_cfg_extts. Ensure that we check by bit-wise negating supported
> flags rather than just checking and rejecting known un-supported flags.
> This is preferable, as it ensures better compatibility with future
> kernels.
> 
> Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: adjusted indentation and added NULL config pointer check

Thanks for the update, this version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


