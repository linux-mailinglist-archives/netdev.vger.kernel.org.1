Return-Path: <netdev+bounces-115528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6022F946E53
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 12:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB9C1F213EE
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 10:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAB825740;
	Sun,  4 Aug 2024 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbsRRRXo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B7CFC19;
	Sun,  4 Aug 2024 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722769041; cv=none; b=MiNmxtSUC/w81MOablCYZsQ5663cFaayXEbLY/3nlGp9TGNTeCoNrFTIsMdnIVJaRcardWsLbvcDBGnsGcGdOGzoEIlMJfGco5w3y5L1eDmQstwZbTCMHMmyJgcBa0c22EcG39mS6C1nGLfhJAFzma7sWO8XJa9P/tSSExcCuAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722769041; c=relaxed/simple;
	bh=y0m9oiFenxXdDWtXdFSZr3bbkXE/uGFAQ/hUHfimu3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxmHMdUHgTwcqL0EO02R5FR4EXtklb9qcSxf1GVTXk7LvHwsL+yd6AKe0Td9W62a69Efi98GnGJV0+hFxs71QsAntxVd4oMEbAJg+1HhU3dLWlf+Ej/zXuWV/p2/U56YR3f3t/PiU8PvMdYNZPn74wBRnckMDfkkBi94QhvFJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbsRRRXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A061C32786;
	Sun,  4 Aug 2024 10:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722769040;
	bh=y0m9oiFenxXdDWtXdFSZr3bbkXE/uGFAQ/hUHfimu3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QbsRRRXohFj9NyYKD0s3UBhjorJkG8tKQk9abYFTc8AdBGVob3OfX9p4YhV2FlChw
	 Mw76awDgcQhtpb4TBHArHbepcdbLaUiPI7f2f7OCTLIEA7HKY64nXwclbVnFGiqeEt
	 8k5r8KOX7aKZC4yA98BYwecPrBq4MkWc4HATJ0AGTkUPEnRkAmDPQO+A9uP4IK+YXq
	 NtbeAntv1h1sE9a/jr1WjMcrm31um/nt6kVucjQjPIW2yjsKIeLlb8C6XWy7pUEkGh
	 PV7dYToCi9s7reRR2PPoBAidaKiSfXx8RcK8Zb9TFATmkOb30Dgg9RkxfKL3mFtTgn
	 odhjItB4FfIaw==
Date: Sun, 4 Aug 2024 11:57:16 +0100
From: Simon Horman <horms@kernel.org>
To: zhanghao <zhanghao1@kylinos.cn>
Cc: bongsu.jeon@samsung.com, krzk@kernel.org,
	syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] nfc: nci: Fix uninit-value in nci_rx_work()
Message-ID: <20240804105716.GA2581863@kernel.org>
References: <20240803121817.383567-1-zhanghao1@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803121817.383567-1-zhanghao1@kylinos.cn>

On Sat, Aug 03, 2024 at 08:18:17PM +0800, zhanghao wrote:
> Commit e624e6c3e777 ("nfc: Add a virtual nci device driver")
> calls alloc_skb() with GFP_KERNEL as the argument flags.The
> allocated heap memory was not initialized.This causes KMSAN
> to detect an uninitialized value.
> 
> Reported-by: syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3da70a0abd7f5765b6ea

Hi,

I wonder if the problem reported above is caused by accessing packet
data which is past the end of what is copied in virtual_ncidev_write().
I.e. count is unusually short and this is not being detected.

> Fixes: e624e6c3e777 ("nfc: Add a virtual nci device driver")
> Link: https://lore.kernel.org/all/000000000000747dd6061a974686@google.com/T/
> Signed-off-by: zhanghao <zhanghao1@kylinos.cn>
> ---
>  drivers/nfc/virtual_ncidev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
> index 6b89d596ba9a..ae1592db131e 100644
> --- a/drivers/nfc/virtual_ncidev.c
> +++ b/drivers/nfc/virtual_ncidev.c
> @@ -117,7 +117,7 @@ static ssize_t virtual_ncidev_write(struct file *file,
>  	struct virtual_nci_dev *vdev = file->private_data;
>  	struct sk_buff *skb;
>  
> -	skb = alloc_skb(count, GFP_KERNEL);
> +	skb = alloc_skb(count, GFP_KERNEL|__GFP_ZERO);
>  	if (!skb)
>  		return -ENOMEM;

I'm not sure this helps wrt initialising the memory as immediately below there
is;

	if (copy_from_user(skb_put(skb, count), buf, count)) {
		...

Which I assume will initialise count bytes of skb data.

