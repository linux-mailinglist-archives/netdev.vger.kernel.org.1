Return-Path: <netdev+bounces-142265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D76699BE171
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF2B28461E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0141D5AB5;
	Wed,  6 Nov 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DvqXowYl"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970471D0DF7;
	Wed,  6 Nov 2024 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883596; cv=none; b=SvIGDnt+7Ea+B1SFNno+L+3EGsHGexL+6kNlRxb4uqzYEl0SWbsVs39OaHAFuxv9L0bzXuoPUSHcIEhJTfuasGNfPVSn2aZ2Es+jmfSLVCakTsUm7TbkF5/do2wx5pFuscmsnmi3NoCX43RB5BW+Uorh92umyHnPU4NVOpxnO6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883596; c=relaxed/simple;
	bh=Eu+9GLCUs+ZL9T5JhqY4naszVNfrhG7aUHNrkoZ5HJc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=fBs+MxBftCfzUId4cBpi/QvtMFs5m8EFaxQS28MlaWj0IlYvhPSXxZJsFKzk/034+EGfhdr6IALEvOVErnj3T8SL4cws8NdmHsRXBEKYwMsVhRITRvej+atMwxjHDv4KM/IOkOl+mP+sI4EXIwGqIQJbYRbP2S1cxtt8J6pxTrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DvqXowYl; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730883584; h=Message-ID:Subject:Date:From:To;
	bh=U/vSd1bKneBHb9JmFxdGvWQlHRxiwwioW2TGCsju+hY=;
	b=DvqXowYlqmXDXf8L9WGd+dTJl6+SdIXxJyKkdRV8qGWXZINiSfsGTqECh0P9fVeMmOIuQ3ug00rC+rNT2Ju1NhcOo+KJd8CN8YQSvKKytG0jUwFo/VPD66gDuTFbNaYuCd7Tt0E/s5mMx8Y8F0jmxjiVnqBWfcYHcl07dPNbTQM=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIqiKNA_1730883583 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 16:59:44 +0800
Message-ID: <1730883538.0293355-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 0/4] virtio_net: Make RSS interact properly with queue number
Date: Wed, 6 Nov 2024 16:58:58 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 andrew@daynix.com,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
In-Reply-To: <20241104085706.13872-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Hi Jason, could you review this firstly?

Thanks.

On Mon,  4 Nov 2024 16:57:02 +0800, Philo Lu <lulie@linux.alibaba.com> wrote:
> With this patch set, RSS updates with queue_pairs changing:
> - When virtnet_probe, init default rss and commit
> - When queue_pairs changes _without_ user rss configuration, update rss
>   with the new queue number
> - When queue_pairs changes _with_ user rss configuration, keep rss as user
>   configured
>
> Patch 1 and 2 fix possible out of bound errors for indir_table and key.
> Patch 3 and 4 add RSS update in probe() and set_queues().
>
> Please review, thanks.
>
> Philo Lu (4):
>   virtio_net: Support dynamic rss indirection table size
>   virtio_net: Add hash_key_length check
>   virtio_net: Sync rss config to device when virtnet_probe
>   virtio_net: Update rss when set queue
>
>  drivers/net/virtio_net.c | 119 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 100 insertions(+), 19 deletions(-)
>
> --
> 2.32.0.3.g01195cf9f
>

