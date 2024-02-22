Return-Path: <netdev+bounces-73854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC8C85EE49
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 01:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7381C21ECE
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 00:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45AD101EC;
	Thu, 22 Feb 2024 00:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAa/jKBR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D2EEC0
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 00:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562983; cv=none; b=eHbNsn6o5HkGo/nsh0/WOt/DEV5R7uilyKmcxqhtq2/UuKCaGjSfG92nC/H2SNLWRnFXy4/L02vEeKHTuLB8opJtDTFXuLc9V6IlBu3ftqSBtnycSeZ5uvP6f0mDlHLeaj1cwci12l+aCg+7mdLvKIXqu1NofoEkknIsNwRF8aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562983; c=relaxed/simple;
	bh=7ygo0fzBsBYT/ClAQNw+tLqxmJ3P8FobnvgWKks2i1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+UakFTl32k23JuqcYRgBsjg5RgLvDHXoca3Z5kMIW+2pnHPcOdrjdg/+sxKoe6Z+forW1c9autIFk93uHZLjDuJY59qQyVNZVSEf/3i/Pwfy6kkJEzClO8Lgsj1Dad9F5dz287d0XGPr6mRDjYZXy5ulUs4/qwODvmySjvQoGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAa/jKBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2062BC433C7;
	Thu, 22 Feb 2024 00:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708562983;
	bh=7ygo0fzBsBYT/ClAQNw+tLqxmJ3P8FobnvgWKks2i1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GAa/jKBRwAPVB6GN16cFJcdOHC6bKSg/bbaom1XpoYk5nG0o1sNnWcdCNR+DTJZKg
	 IuUtDstvQ/+o/eeAsjKYwuOx2lQfnZM+5Nt6251Szyp0zA3V/Sglom4dw9UO919eqA
	 bwUamU9PcRCIU6QbPQr+yi6FEo3GyH5+GsTZrwUgrglxsBe/yQnZO4nLRzzCpvJjKi
	 J4+PRQuNeRHW4XyqBPqYvn8jbRxt3Dm/Wer6Sh4XzjPVo7QNXVwklhERG8oSJnKtIX
	 HKtVmEiZDCXlagXnbGIOzBuc9Czh0GWPZ3EjxuL85NcTGBqU7+M+CrmHAMYf7jrXex
	 WjxZhi/dFcrFw==
Date: Wed, 21 Feb 2024 16:49:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, "David S. Miller"
 <davem@davemloft.net>
Subject: Re: [Bug report] veth cannot be created, reporting page allocation
 failure
Message-ID: <20240221164942.5af086c5@kernel.org>
In-Reply-To: <5F52CAE2-2FB7-4712-95F1-3312FBBFA8DD@gmail.com>
References: <5F52CAE2-2FB7-4712-95F1-3312FBBFA8DD@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 22:38:52 +0800 Miao Wang wrote:
> I tried to bisect the kernel to find the commit that introduced the problem, but
> it would take too long to carry out the tests. However, after 4 rounds of
> bisecting, by examining the remaining commits, I'm convinced that the problem is
> caused by the following commit:
> 
>   9d3684c24a5232 ("veth: create by default nr_possible_cpus queues")
> 
> where changes are made to the veth module to create queues for all possbile
> cpus when not providing expected number of queues by the userland. The previous
> behavior was to create only one queue in the same condition. The memory in need
> will be large when the number of cpus is large, which is 96 * 768 = 72KB or 18
> continuous 4K pages in total, no wonder causing the allocation failure. I guess
> on certain platforms, the number of possbile cpus might be even larger, and
> larger than actual cpu cores physically installed, for several people in the
> above discussion mentioned that manually specifing nr_cpus in the boot command
> line can work around the problem.
> 
> I've carried out a cross check by applying the commit on the working 5.10
> kernel, and the problem occurs. Then I reverted the commit on the 6.1 kernel, 
> the problem has not occured for 27 hours.

Thank you for the very detailed report! Would you be willing to give
this patch a try and report back if it fixes the problem for you?

It won't help with the memory waste but should make the allocation
failures less likely:

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a786be805709..cd4a6fe458f9 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1461,7 +1461,8 @@ static int veth_alloc_queues(struct net_device *dev)
 	struct veth_priv *priv = netdev_priv(dev);
 	int i;
 
-	priv->rq = kcalloc(dev->num_rx_queues, sizeof(*priv->rq), GFP_KERNEL_ACCOUNT);
+	priv->rq = kvcalloc(dev->num_rx_queues, sizeof(*priv->rq),
+			    GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	if (!priv->rq)
 		return -ENOMEM;
 
@@ -1477,7 +1478,7 @@ static void veth_free_queues(struct net_device *dev)
 {
 	struct veth_priv *priv = netdev_priv(dev);
 
-	kfree(priv->rq);
+	kvfree(priv->rq);
 }
 
 static int veth_dev_init(struct net_device *dev)

