Return-Path: <netdev+bounces-131228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3048098D64B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB956284B63
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CED01D07B1;
	Wed,  2 Oct 2024 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blkM5Pgb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B441D042F;
	Wed,  2 Oct 2024 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876292; cv=none; b=abkYB5XFEEWgvZdGgIbC1MppisLY5Tts46Z2q6YmrGoxhulbDSUpFq1aBQ6O+0YagekcVQyX5ZsUFGAsTufcf2tSPjYO4G3vp+PXfwWIXiw3ooh188m6o9Hu8wmRVaI8MtOjoGsFW8qCFaQ3M8dMPVdSFHrU4XiIFjO19pNy8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876292; c=relaxed/simple;
	bh=LfOBpahb3m1ExgFT9uTRoIBZMIOVdKZ+m2xAGKQYKsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhKbGaZJ+XMIb+Tw4DTezDo68nSGd/rv44uYoIdRKyN7q/os8/w/TcHFdSbcZIJUHxHWIS9u03pVNdXJ5ylpEiPRbOz8L09ZNfkfiJcS5jL37rN1V8kfeToI46KuyCwyfbQY3koWOVXM/8oD9lOEgHO73eZ1MX9CYsDk9B8YDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blkM5Pgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AE9C4CEC5;
	Wed,  2 Oct 2024 13:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876291;
	bh=LfOBpahb3m1ExgFT9uTRoIBZMIOVdKZ+m2xAGKQYKsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=blkM5Pgb8TMcrLfd86QFe/rFrY5olUVupc0lXc7MpFfqqrMXPoYx5EVfjHyeqAEwM
	 vERSSl0qhTG6UaYtsOXWGANzpnFxprCa2wpPr9507hQ1lxwRLACpusDrZLLx+3aKb9
	 ZXN4MA01eGkez6O2EG7rbwV8FXNx3ZW+aQ6L6wO7dhl4W1R7B8KHpMZXoPSfphtGpO
	 hjJJf2gPA+FnkQDKr6GA6O7bykzdZORT7dWnefgxyYaCyL2x5TNrLF+xUjF2vZbgBF
	 aAV9zBeWzLTedG6ev5yp52Y4nPVoWBtAb0F6UBbLT65tsmkd3u+KGvfRSwkRZk5a00
	 WDBjcfT4D3fww==
Date: Wed, 2 Oct 2024 14:38:06 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 05/12] net: vxlan: make vxlan_remcsum()
 return drop reasons
Message-ID: <20241002133806.GB1310185@kernel.org>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-6-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001073225.807419-6-dongml2@chinatelecom.cn>

On Tue, Oct 01, 2024 at 03:32:18PM +0800, Menglong Dong wrote:
> Make vxlan_remcsum() support skb drop reasons by changing the return
> value type of it from bool to enum skb_drop_reason.
> 
> The only drop reason in vxlan_remcsum() comes from pskb_may_pull_reason(),
> so we just return it.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


