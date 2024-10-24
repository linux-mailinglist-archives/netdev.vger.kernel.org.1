Return-Path: <netdev+bounces-138741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D139AEB5C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 18:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA77428589B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3B1F7083;
	Thu, 24 Oct 2024 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEu7Igyh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22BF1F7084;
	Thu, 24 Oct 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785849; cv=none; b=YOL3UJ3Ow/++4ZlzPcsfyF0HeYZh/CdvSCIhPXjX4vhMAwtsM4Hp3g+RY5npcsyIuhzH7ZtkeLzr759Ley1cuc9Tx4UTYNImbEUg1GjhHa/M4fO2Vi2/KyagJcq7ojKjG5B9KlSGmi+ZDJvSLPKAOnlK5maJR2ZK532s5J0v1Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785849; c=relaxed/simple;
	bh=Myjz9JYsX77B7JYfT/JXdIOgce90SWSzlxORYDjC8oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaylMTbmXbH0AuBk9vixVcbEZTq70umKGoSZjr9yYvDTuMsf1rXJEvFLID4EEYJBnDWjWelAox6WZhD+TpPafBnE93vsmC0o6MjYZx6K0t6Pl7Z5Up9B8pzD1/gbh76V1HjxYQ7Fyrgz9ivWa65NR5r/hkXH1pYnbhiHCaU+QU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEu7Igyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16525C4CEC7;
	Thu, 24 Oct 2024 16:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729785848;
	bh=Myjz9JYsX77B7JYfT/JXdIOgce90SWSzlxORYDjC8oA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HEu7Igyh7nj3naMU5ewRp2bwWjflOn8o/POIpUa6Oe75xASEzF8dGSuvc9eWQZGUV
	 TOk4L6DZZzpz2gDhvEGhev8TEsz7Nw3kQIglKNgLuMkVFHstd+K5JcTvK8qjthcQ0R
	 FC80nS1GtXxZi5KcmRo2iVv8loA/2lSy8PMhxh0NDWfzuo3cz0D3xT7sAiqN30knWo
	 UjcCScpsimQjYig5mMr4oEtp4aTnNK+ANCn0f6A7iiOLnxcP/GcOFvqSVPMXSONXL5
	 1l8Vli5eqfO7nloEi7YtxL2eBC8mF+oVBe/JInQVkAAf08KmLrD2BoH+mCAiBrKlfC
	 B4zl8KA9Wmv0g==
Date: Thu, 24 Oct 2024 17:04:04 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, shenjian15@huawei.com,
	salil.mehta@huawei.com, liuyonglong@huawei.com,
	wangpeiyang1@huawei.com, lanhao@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 1/9] net: hns3: default enable tx bounce buffer
 when smmu enabled
Message-ID: <20241024160404.GC1202098@kernel.org>
References: <20241018101059.1718375-1-shaojijie@huawei.com>
 <20241018101059.1718375-2-shaojijie@huawei.com>
 <50874428-b4ef-4e65-b60b-1bd917f1933c@redhat.com>
 <d68ad0c3-3d53-406b-ad98-5686512fa48e@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d68ad0c3-3d53-406b-ad98-5686512fa48e@huawei.com>

On Thu, Oct 24, 2024 at 04:31:46PM +0800, Jijie Shao wrote:
> 
> on 2024/10/24 16:26, Paolo Abeni wrote:
> > On 10/18/24 12:10, Jijie Shao wrote:
> > > From: Peiyang Wang <wangpeiyang1@huawei.com>
> > > 
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
> > > Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> > > Signed-off-by: Jian Shen <shenjian15@huawei.com>
> > > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> > I'm sorry to nick pick on somewhat small details, but we really need a
> > fixes tag here to make 110% clear is a bugfix. I guess it could be the
> > commit introducing the support for the buggy H/W.
> > 
> > Thanks,
> > 
> > Paolo
> 
> I have a little doubt that this patch is about H/W problem,
> so how can we write the the fixes tag?

Hi Jijie,

That is a good point. But the much point of the Fixes tag is to indicate how
far back the fix should be backported. So I would say the ID of the patch
where the user would have first seen this problem - possibly the patch that
added the driver.

