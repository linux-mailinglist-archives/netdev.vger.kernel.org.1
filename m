Return-Path: <netdev+bounces-190738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C337AB88F3
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F2E174C9A
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E901C3C14;
	Thu, 15 May 2025 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng+giE9Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709481BC9F4;
	Thu, 15 May 2025 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318245; cv=none; b=AfXPsJK40cNC+rmXJMJrpde9xh9AWyd2PpQyM34eFV0lesKOba34O0bE/SwmcwkrWaFYyVSXsF+4R02TgxJfSj/a7CH62imgAkxQTHl82HGsPdGV5ddi211wny70g/vUMKbga0PoLKMK1I447npVvvE6doRHS9O2n0TFUinFhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318245; c=relaxed/simple;
	bh=gscMF9fKg71CimMwFFr2f/OqsDrXvF6hN+Br5igsxTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fuzix0S4ddJEnIJOX9s72R+eF0oahywaDX7z5841Xjiw6pVEXVgPD1bxg1M2idx+NC7ktQZAX7NfI+VeCZw/ZtbmJbe9RqbugDgFXs19uJa5G+Zc1YYvh/R4/x4T7sSnsxsVTXPr8JC0XUSVi2wNxMjl17FBoshcfPMMyubTBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng+giE9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CECCC4CEE7;
	Thu, 15 May 2025 14:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747318243;
	bh=gscMF9fKg71CimMwFFr2f/OqsDrXvF6hN+Br5igsxTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ng+giE9YXCJ5Gs/6E5Rr1L+69lHHBRBRcWUJBzV9q3KQl3gdER0kxNl+Kgw2cSvhN
	 GKg75JE6cIALoPGWVFvEqUGgbz+SAn0kakqvPksXh+/ntrUL8iSod1ufZMDltKkLUN
	 NexDehEIYgSMsgrz8gjtxhiMIsXTEWoJ/a2XAUV9HRcxS3l+nUKFW1M3rj0A8HBTMr
	 GDO3+bovxvQy2Kth1Q6SQySovdMPy5vMbjtbSCWgW5hq+eUqIv0LtsASRRxManBgWg
	 LwCBcUZtj/gMNnk232qMV24AR8N+/PfWQIQp2wO3VecUiEtxKaphPUdyYU/kDw0Sll
	 lp1i2vMfmkMKQ==
Date: Thu, 15 May 2025 07:10:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tang Longjun <lange_tang@163.com>
Cc: xuanzhuo@linux.alibaba.com, jasowang@redhat.com, mst@redhat.com,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, Tang Longjun <tanglongjun@kylinos.cn>
Subject: Re: [PATCH] virtio_net: Fix duplicated return values in
 virtnet_get_hw_stats
Message-ID: <20250515071042.5f668345@kernel.org>
In-Reply-To: <20250514054433.29709-1-lange_tang@163.com>
References: <20250514054433.29709-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 13:44:33 +0800 Tang Longjun wrote:
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..c9a86f325619 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4897,7 +4897,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
>  					&sgs_out, &sgs_in);
>  
>  	if (!ok)
> -		return ok;
> +		return 1;

This makes sense, looks like a typo in the original code.
But we are now returning the reverse polarity of "ok", so we should
probably rename the variable in virtnet_get_hw_stats() ok -> failed
Or invert the polarity here and in virtnet_get_hw_stats()

>  	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
>  		hdr = p;
> @@ -4937,7 +4937,7 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
>  	int ok;
>  
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
> -		return 0;
> +		return -EOPNOTSUPP;

IDK about this part. We should not spam the logs if the device does not
support a feature. We should instead skip reporting the relevant stats.
User can tell that those stats are not supported from the fact they are
not present.
-- 
pw-bot: cr

