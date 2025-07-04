Return-Path: <netdev+bounces-204199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA1AF978C
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BFC3AD100
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DFA309DCA;
	Fri,  4 Jul 2025 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOPBJy5G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC513EFF3;
	Fri,  4 Jul 2025 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645143; cv=none; b=OqvqGX1Dy1Naw5eS2RHLtnlrCKAHjBPKvocLLNRBnhn7kNUCsuL5QQv11LQJPdHuvjl+G+7QJMaEBUx4vHTv3vKupefnkQEJhhJfBsUT5xAMXoupSvDmGjdxgaMvJW3PP2UDq5qUQj+v76giixT3bqyuPNbza7NVKs3VKjGjp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645143; c=relaxed/simple;
	bh=OJ+RzGJ+CERD51pCc/zN5s79eIMpDwAyPHK/JUDP4hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udVxgAziRdzBeBxD2xL2gtffxhMRwbaP4B2zfHtslgsiCdHgJcQ4U31TPFutsQ0tCUnKNt2W3mSkPNpuduEgnZP5rT1pRoD6AHsNty++fnhwEEHXUoKfLkjehQyxKRPMRSPCF65161hwUb2gpOzo5mpBxredXPkIMD2G8PKWcqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOPBJy5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E54C4CEE3;
	Fri,  4 Jul 2025 16:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751645143;
	bh=OJ+RzGJ+CERD51pCc/zN5s79eIMpDwAyPHK/JUDP4hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uOPBJy5GPf4qLPD/rnd5HMinWmIwUzoVV1K4TGUFuyq+/Q0W/BlsM8lop7hhL6QPo
	 hFsHgsHGRWoD7zl6TdAwyJJD4/AsqNmUW4RsOtz/374NsLTcOHYR9WNAIwJagq7uiB
	 3beyeR6Q11BkRQJubku0Li1ZlXKXw4PepHmr+vYN4l4g/XwOUWNkHxHTskmaR0A/Nh
	 TsL9i3HOov6ReKxKVOw73CL/3VvwjheDJgYw/l8iE8K5nQ63kbPVv+jICKvCkvQUAU
	 Gea7/229PlsRWLrmBp0eURrk55sNzGjuqsU8lVhVmLbAGDKtwopeA1G3nb2/l2ijCo
	 eWXXBplfMlzcg==
Date: Fri, 4 Jul 2025 17:05:37 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net 3/4] net: hns3: fixed vf get max channels bug
Message-ID: <20250704160537.GH41770@horms.kernel.org>
References: <20250702130901.2879031-1-shaojijie@huawei.com>
 <20250702130901.2879031-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702130901.2879031-4-shaojijie@huawei.com>

+ David Laight

On Wed, Jul 02, 2025 at 09:09:00PM +0800, Jijie Shao wrote:
> From: Hao Lan <lanhao@huawei.com>
> 
> Currently, the queried maximum of vf channels is the maximum of channels
> supported by each TC. However, the actual maximum of channels is
> the maximum of channels supported by the device.
> 
> Fixes: 849e46077689 ("net: hns3: add ethtool_ops.get_channels support for VF")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Hao Lan <lanhao@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> index 33136a1e02cf..626f5419fd7d 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> @@ -3094,11 +3094,7 @@ static void hclgevf_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
>  
>  static u32 hclgevf_get_max_channels(struct hclgevf_dev *hdev)
>  {
> -	struct hnae3_handle *nic = &hdev->nic;
> -	struct hnae3_knic_private_info *kinfo = &nic->kinfo;
> -
> -	return min_t(u32, hdev->rss_size_max,
> -		     hdev->num_tqps / kinfo->tc_info.num_tc);
> +	return min_t(u32, hdev->rss_size_max, hdev->num_tqps);

min_t() wasn't needed before and it certainly doesn't seem to be needed
now, as both .rss_size_max, and .num_tqps are u16.

As a follow-up, once this change hits net-next, please update to use min()
instead. Likely elsewhere too.

