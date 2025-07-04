Return-Path: <netdev+bounces-204207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C1EAF9841
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9383AD83E
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4DA2F8C3D;
	Fri,  4 Jul 2025 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyK7uWSh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DEF2F8C24;
	Fri,  4 Jul 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646716; cv=none; b=Nqd4UPptG8UhWC08mDfa55demvRwLaXuJm7v8znJpF2m9q5H/hcHNNhMUbJyM2MUOcVr99bwmyohXZwpiH5UyVZ19xLdhIEvCSEeFUD6/3ILiCodW9ii6CCyZLN8gpi7bmPCGE/HgWwzP6sT4gdpKTvwOXCsY2BNzXfkm/BgKzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646716; c=relaxed/simple;
	bh=1R4xG2oK+WCRMwUL8j3oGu49pH/1VqFl2FThwyl2SZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fv9in4C7Cl022JH8NnTdRE5CPL8ycv5Lnnd6yDYM/43EnyfV5AWzx2cCmA1E6UaG1pIdwvbBFcec22CKx2n2i9WOenDYRRH1cgcFtgjUnP1yAuk7fMHN7e38k52KBHij8AHlhlnlvMvXwemUBZYFb+3oHs89QVgZcgy5dpqU1K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyK7uWSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5827AC4CEE3;
	Fri,  4 Jul 2025 16:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751646715;
	bh=1R4xG2oK+WCRMwUL8j3oGu49pH/1VqFl2FThwyl2SZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyK7uWShwT3cvtMHYruB0D/9t31xvzvQlatxlGe9AGLe/09vqHjtg2ZMKwbjwdNxF
	 m0slEPAGnF8t7BYjdHPJ/IOIB8K4mR6TbF1i3jkFxer7FJMlP8eGYkJkM5xyqUzEwD
	 +fZrqjjKKbtSuofCY0PUmVo66NoO1Bhbn4EAneavjq6ymMPwiM0qEdZ3RjpkppZM/L
	 qisN+dGNUIQYMQgQjQzMvMUYgAOx5zPewpOFO6HiwIMXa8m7oRKeRdkDSjXePi7Py+
	 bvk0mkxmhn+pjO0/vlQoz1+5Cl6VPL7yxbuXIJEJAYfcsH9D/+AxxeoATpqylSLcvf
	 Jv5cnQ++BP1Xg==
Date: Fri, 4 Jul 2025 17:31:49 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 4/4] net: hns3: default enable tx bounce buffer when
 smmu enabled
Message-ID: <20250704163149.GJ41770@horms.kernel.org>
References: <20250702130901.2879031-1-shaojijie@huawei.com>
 <20250702130901.2879031-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702130901.2879031-5-shaojijie@huawei.com>

On Wed, Jul 02, 2025 at 09:09:01PM +0800, Jijie Shao wrote:
> The SMMU engine on HIP09 chip has a hardware issue.
> SMMU pagetable prefetch features may prefetch and use a invalid PTE
> even the PTE is valid at that time. This will cause the device trigger
> fake pagefaults. The solution is to avoid prefetching by adding a
> SYNC command when smmu mapping a iova. But the performance of nic has a
> sharp drop. Then we do this workaround, always enable tx bounce buffer,
> avoid mapping/unmapping on TX path.
> 
> This issue only affects HNS3, so we always enable
> tx bounce buffer when smmu enabled to improve performance.
> 
> Fixes: 295ba232a8c3 ("net: hns3: add device version to replace pci revision")

The cited commit may be a pre-requisite for this patch
to check HNAE3_DEVICE_VERSION_V3. But it seems to me that the problem
being addressed existed before the cited commit. If so, I think a different
Fixes tag is appropriate.

> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 31 +++++++++++++++++
>  .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 ++
>  .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 33 +++++++++++++++++++

It seems to me that the hns3_ethtool.c changes a) are not a requirement
for the work-around introduced by this patch and b) may introduce
complex behaviour between the effect of ethtool copybreak settings
and the enablement/non-enablement of the work-around.

Would it be possible to make a more minimal fix for net, that
omits the ethtool changes. And then follow-up with them for net-next
once the fix is present there?

-- 
pw-bot: cr

