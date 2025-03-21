Return-Path: <netdev+bounces-176683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B0FA6B4C8
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 08:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229403B38BB
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 07:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7A61EBFE3;
	Fri, 21 Mar 2025 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tLL7xxjV"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC141E8336;
	Fri, 21 Mar 2025 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742541485; cv=none; b=OYtz/sXo1htdzYB7kv/4ygSLJVCjPDUbwk0hCZeq299XY13EZ6bBf1uaSbYU8ueOyiyXkjbinSb8KWhWXXZwAyBsM9INvC1GYQQ/Lzwa9t57rO/Qk4UY40jZIyjUPxWc1kx8UtD7Mtmv127mB0xRTdIVzRcnPC4a3AOuyUmmMt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742541485; c=relaxed/simple;
	bh=Az2iaCs6AjpNK8WuURbopULbdHBFksgSv8kK2V+xfCc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=gF1okmylwDK6o5WLCZdTP5JiYH1fsZjvCiXHYkRB7e4EzpaqIdmBf+FfHlSKLIiJbqcS0qpwsuI4dT3PQo5wYUqViCLX8npkL0qgzqhTLeRdpy6Zjls+gMXFtWLfSNpdZMFo2pyoIxEHDeJ323xQmAYX311LKYiHNUz1h+lHzqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tLL7xxjV; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742541472; h=Message-ID:Subject:Date:From:To;
	bh=QpT6TAhfiuDwI7Ss07pa7dcarLeE0EOAXbWNZWyjt7s=;
	b=tLL7xxjVUbxaM7JE4KEZ5IltykrscCzkNp9MNES2W3CdeYEgs79qDXIbpUfeKsC3fd6Qp3H5XMDOSnL4ugGUcbmRP7UVX4p3MGpQpU7iUtYoHqLSiL3aWgqelzyaA+GriEJa/50UME8hPFd9Muvufy97wN2Ye3/1K+tAigVSwZU=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WSGdsj9_1742541471 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Mar 2025 15:17:52 +0800
Message-ID: <1742541465.8308454-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 0/4] virtio_net: Fixes and improvements
Date: Fri, 21 Mar 2025 15:17:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 devel@daynix.com,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Lei Yang <leiyang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Joe Damato <jdamato@fastly.com>,
 Philo Lu <lulie@linux.alibaba.com>
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
In-Reply-To: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 21 Mar 2025 15:48:31 +0900, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> Jason Wang recently proposed an improvement to struct
> virtio_net_rss_config:
> https://lore.kernel.org/r/CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com
>
> This patch series implements it and also fixes a few minor bugs I found
> when writing patches.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> Changes in v2:
> - Replaced kmalloc() with kzalloc() to initialize the reserved fields.
> - Link to v1: https://lore.kernel.org/r/20250318-virtio-v1-0-344caf336ddd@daynix.com
>
> ---
> Akihiko Odaki (4):
>       virtio_net: Split struct virtio_net_rss_config
>       virtio_net: Fix endian with virtio_net_ctrl_rss
>       virtio_net: Use new RSS config structs
>       virtio_net: Allocate rss_hdr with devres
>
>  drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------------
>  include/uapi/linux/virtio_net.h |  13 +++++
>  2 files changed, 56 insertions(+), 76 deletions(-)
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250318-virtio-6559d69187db
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>

