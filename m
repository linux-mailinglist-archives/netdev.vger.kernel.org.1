Return-Path: <netdev+bounces-205084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AAAAFD19C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6EF582C5E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B002E337A;
	Tue,  8 Jul 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SG5eIH7x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39F21773D;
	Tue,  8 Jul 2025 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992556; cv=none; b=TQpUs2tvHc3og6gDN058I8LvwN34hrOx4aq+YmcbmqcoKUXClSHn8klTp6fTCx+9heAOmlLsXMoDgRUAQ0/YhF3c20WiA5DYjJZG3zuUu0DjrYa4zfTwmoIe+SNOILncX3x1f6UypXGVjqoNIwe6xVFya/3QxB+ffRcix2OS+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992556; c=relaxed/simple;
	bh=XXhGcCIAVWGp27tOe8NewkV4gAQ/wwZo5SRZEFZL/2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFvoqpu43l4JznJvZPdKdvGyA1yL8YKMjaPn0ov+IMSu6lPFvK6w1e8201dBT7qzNNzG3usO2Q+oXY+8zcoXBKiAJNXDPwecmpMuBKIGM+ZfQnOOwD0yML8k5rcP0l+A1bkIOo9PMETt8LuLs5vlRiAO1BBzZAaUGJf08HXUqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SG5eIH7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7282C4CEF0;
	Tue,  8 Jul 2025 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751992556;
	bh=XXhGcCIAVWGp27tOe8NewkV4gAQ/wwZo5SRZEFZL/2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SG5eIH7xnPDpaoTh81X5bxBSEnWxsY3e2vVG6pHOdtzUYXIEFj/O06wLksfxBKfMI
	 WkHPIjjU5ugFt+gKyXhgAcq3sq4c3zw+PDPbvvqB5KiQNsS/qTh18XZnfHDp1Jo/sr
	 FR/RzpTX4GU9xlwylHqH4eo9zKQMiqVvAe9oCxQdKGAs5Wzcm6P/WR9MePszioP/Nm
	 mUufwfee3Jj5Iu1jWo9etWIMzuKyR+EEuG3e+SmOQa9cTan4wzaFEtuDqF7gR07kaf
	 z59cJf5ZQD9I2D/rrq47gBCk5uuQKAbIULTLP3GYqT4vHkUQqsbZTHbn91bziuPvL/
	 Q0xL59BEotS5Q==
Date: Tue, 8 Jul 2025 17:35:51 +0100
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
Message-ID: <20250708163551.GU452973@horms.kernel.org>
References: <20250702130901.2879031-1-shaojijie@huawei.com>
 <20250702130901.2879031-5-shaojijie@huawei.com>
 <20250704163149.GJ41770@horms.kernel.org>
 <21993e23-9ac6-4108-94e6-752fe32a11d2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21993e23-9ac6-4108-94e6-752fe32a11d2@huawei.com>

On Tue, Jul 08, 2025 at 05:41:36PM +0800, Jijie Shao wrote:
> 
> on 2025/7/5 0:31, Simon Horman wrote:
> > On Wed, Jul 02, 2025 at 09:09:01PM +0800, Jijie Shao wrote:
> > > The SMMU engine on HIP09 chip has a hardware issue.
> > > SMMU pagetable prefetch features may prefetch and use a invalid PTE
> > > even the PTE is valid at that time. This will cause the device trigger
> > > fake pagefaults. The solution is to avoid prefetching by adding a
> > > SYNC command when smmu mapping a iova. But the performance of nic has a
> > > sharp drop. Then we do this workaround, always enable tx bounce buffer,
> > > avoid mapping/unmapping on TX path.
> > > 
> > > This issue only affects HNS3, so we always enable
> > > tx bounce buffer when smmu enabled to improve performance.
> > > 
> > > Fixes: 295ba232a8c3 ("net: hns3: add device version to replace pci revision")
> > The cited commit may be a pre-requisite for this patch
> > to check HNAE3_DEVICE_VERSION_V3. But it seems to me that the problem
> > being addressed existed before the cited commit. If so, I think a different
> > Fixes tag is appropriate.
> > 
> > > Signed-off-by: Jian Shen <shenjian15@huawei.com>
> > > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> > > ---
> > >   .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 31 +++++++++++++++++
> > >   .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 ++
> > >   .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 33 +++++++++++++++++++
> > It seems to me that the hns3_ethtool.c changes a) are not a requirement
> > for the work-around introduced by this patch and b) may introduce
> > complex behaviour between the effect of ethtool copybreak settings
> > and the enablement/non-enablement of the work-around.
> > 
> > Would it be possible to make a more minimal fix for net, that
> > omits the ethtool changes. And then follow-up with them for net-next
> > once the fix is present there?
> 
> I will discuss your suggestion with my team.

Thanks, much appreciated.

