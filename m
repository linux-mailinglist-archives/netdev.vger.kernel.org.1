Return-Path: <netdev+bounces-205083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AC6AFD193
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1035400BF
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2462E5414;
	Tue,  8 Jul 2025 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNXxiNse"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D821548C;
	Tue,  8 Jul 2025 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992517; cv=none; b=HwfelQH4xWxCduzzhkP+OvBuVwhhzHiLrZ6UD1811Fbrcn1UJGxL6JE3s7R1A3LPE5/eWc2nduqrQE9IXSk1JYQTARMznXAHm/9VVBh5hCCxul9T75gbOk6eKNw1hAQ0KkvVvlhLLA70XQVDIKjQP1w3NnfgjEZXmIsIgF7J2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992517; c=relaxed/simple;
	bh=QgiX4LUkcXMzN6rpOD+08TVWpZ+gacpnKCZNO3I829w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVY+IItF7WsadZavqif1MmEO4Iuq/4x+iQLIOmMiGJAf2PFsBtQcEZSZlPwZvfi8UaB0mtYDRZI5CYPDK+n2wkFnPEMMeo/JMWIO3womKW/2M7Ueb+wRMQ442DYX+laPmOwtEDenPPgyoxeSoFNeGe0cdvABI0DzUODcIhuOyIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNXxiNse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6A8C4CEED;
	Tue,  8 Jul 2025 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751992517;
	bh=QgiX4LUkcXMzN6rpOD+08TVWpZ+gacpnKCZNO3I829w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sNXxiNsexHWJGNnadhbOUTRArl/25p0Y99/VmZIzcnB5yq3TpgI0au4to5/GlRdGD
	 aILwoSQz4OT0hV9YYML5LbeBAAPp4/4XKxs+5YFpRWmME3tm1NHt1KynMdrJL+EKgm
	 0mkdGiVMYRnV3E/xVhTaJ7DR1VriyWtcGRRTVoAvxPjyXLD+6Nvnf9lri4kz5YtJ5y
	 fN7/t4+XKl3kzhyG2ow4eDqVweczmhfNJdHZvYLcS1WB6v6o6p1q/fm2cihAehaV6G
	 tbkBcg9LxOzDl1jEdhXzp7Egn0JRwjrlQXHkBYVNrgE8N0/LR4W8FP/Z/DPFB68Hc1
	 MGnh6W9iTW67Q==
Date: Tue, 8 Jul 2025 17:35:12 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: David Laight <david.laight.linux@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/4] net: hns3: fixed vf get max channels bug
Message-ID: <20250708163512.GT452973@horms.kernel.org>
References: <20250702130901.2879031-1-shaojijie@huawei.com>
 <20250702130901.2879031-4-shaojijie@huawei.com>
 <20250704160537.GH41770@horms.kernel.org>
 <20250705082403.0ba474f4@pumpkin>
 <9f4b5409-79a5-481b-9ce1-8ca3ef37b65d@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f4b5409-79a5-481b-9ce1-8ca3ef37b65d@huawei.com>

On Tue, Jul 08, 2025 at 05:37:11PM +0800, Jijie Shao wrote:
> 
> on 2025/7/5 15:24, David Laight wrote:
> > On Fri, 4 Jul 2025 17:05:37 +0100
> > Simon Horman <horms@kernel.org> wrote:
> > 
> > > + David Laight
> > > 
> > > On Wed, Jul 02, 2025 at 09:09:00PM +0800, Jijie Shao wrote:
> > > > From: Hao Lan <lanhao@huawei.com>
> > > > 
> > > > Currently, the queried maximum of vf channels is the maximum of channels
> > > > supported by each TC. However, the actual maximum of channels is
> > > > the maximum of channels supported by the device.
> > > > 
> > > > Fixes: 849e46077689 ("net: hns3: add ethtool_ops.get_channels support for VF")
> > > > Signed-off-by: Jian Shen <shenjian15@huawei.com>
> > > > Signed-off-by: Hao Lan <lanhao@huawei.com>
> > > > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > > 
> > > > ---
> > > >   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 6 +-----
> > > >   1 file changed, 1 insertion(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> > > > index 33136a1e02cf..626f5419fd7d 100644
> > > > --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> > > > +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> > > > @@ -3094,11 +3094,7 @@ static void hclgevf_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
> > > >   static u32 hclgevf_get_max_channels(struct hclgevf_dev *hdev)
> > > >   {
> > > > -	struct hnae3_handle *nic = &hdev->nic;
> > > > -	struct hnae3_knic_private_info *kinfo = &nic->kinfo;
> > > > -
> > > > -	return min_t(u32, hdev->rss_size_max,
> > > > -		     hdev->num_tqps / kinfo->tc_info.num_tc);
> > > > +	return min_t(u32, hdev->rss_size_max, hdev->num_tqps);
> > > min_t() wasn't needed before and it certainly doesn't seem to be needed
> > > now, as both .rss_size_max, and .num_tqps are u16.
> > It (well something) would have been needed before the min_t() changes.
> > The u16 values get promoted to 'signed int' prior to the division.
> > 
> > > As a follow-up, once this change hits net-next, please update to use min()
> > > instead. Likely elsewhere too.
> > Especially any min_t(u16, ...) or u8 ones.
> > They are just so wrong and have caused bugs.
> > 
> > 	David
> 
> 
> Does this mean that min_t() will be deprecated?
> If so, I will replace all instances of min_t() with min() in the hns3 driver.

No, it means that min_t() should only be used when it is needed.
AFAIK, basically when the operands need to be cast.

