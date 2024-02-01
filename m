Return-Path: <netdev+bounces-68010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C6D84595E
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82EF1C27E38
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE345CDE4;
	Thu,  1 Feb 2024 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neo4lntG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF85B669
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795619; cv=none; b=tSd86+dBBvOB2vqRcst+PFOCCggO4U7cv+3aPE4kQiYT1tA8uM39mfiGxaT9+HvtjjOMdf9RGYaDnQJnrAjS+/f8Qu3fmRzX+XZPN82hr8jGsSIxpU76T/m8mzM47BEkNKiNYKsET7LLWFS1E8cZslIWaJcO1sqPgaE7wERLLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795619; c=relaxed/simple;
	bh=hRf6knhptwKVRnr0kxJwmE3JRsjwA6Rl3X4xJJiymys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHAKkXG2IlgbvJTe1rV3JmTsb1AojnhxvhX9izov9TTkhW4jDxu+uQMVBqQPDGmv5t1I4hML9zJ+Zj2yieuMqVS5xpl7wqMN4taDS0VZXrHKNxgMeYa8UBD+psJcVnBVZKLvOFLJc9+WWxLkc+kYdV1x2ZgetukEKoxoU7pguvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neo4lntG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77119C433C7;
	Thu,  1 Feb 2024 13:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706795619;
	bh=hRf6knhptwKVRnr0kxJwmE3JRsjwA6Rl3X4xJJiymys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neo4lntGqIxyky2sTSVaI5zzJClozUPOjHE+lreq65bpEnGqCWbRhamk7K5OrE+YI
	 FN7tMyn1cYj12olZUWaXIOFd1zm3QQeE/WteimZA/SfR7wEWEorTvEHeDrgjp8iWHk
	 FiG3Wktv7sQEtUFXTPbFJBmANN5XkUjYep2qIJA6RxZcKbeHeoVDtMVYFgjqiIrOlY
	 XdJ8MY0wPz9qhKVJ0biefU18mBknoJiMVbkSwDTN9xWbMXoE+aw2AwThUT+pQEczFj
	 hNQnLVZTSZ65Ani08FF3fpfeKoGs0Ix4LZxdah4c2ZwW0i7OLhN8OpYXGBe/RhOgNZ
	 zayWCUkJXr6NA==
Date: Thu, 1 Feb 2024 14:53:34 +0100
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	rrameshbabu@nvidia.com
Subject: Re: [patch net-next v2 2/3] dpll: extend lock_status_get() op by
 status error and expose to user
Message-ID: <20240201135334.GF530335@kernel.org>
References: <20240130120831.261085-1-jiri@resnulli.us>
 <20240130120831.261085-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130120831.261085-3-jiri@resnulli.us>

On Tue, Jan 30, 2024 at 01:08:30PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Pass additional argunent status_error over lock_status_get()
> so drivers can fill it up. In case they do, expose the value over
> previously introduced attribute to user. Do it only in case the
> current lock_status is either "unlocked" or "holdover".
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>




