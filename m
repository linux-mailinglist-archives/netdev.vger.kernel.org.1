Return-Path: <netdev+bounces-118339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB469514E4
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C771C2833AE
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D0E13CABC;
	Wed, 14 Aug 2024 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiKQP6Pd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BFD13C9C4
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618777; cv=none; b=sThZN0U+qE3PtXVPHEWCAxoa1WRp4rgjRrQ1zoCLPXaWCwhrwzZxKvYvVOWAIpVtA5cQFk3ICn0DDmQWTX2nZsqnQaWOVdkVqKzY4jQ0n3Y2kTOYrFoCE/PZ8kkCAtOls/5awwhX2OJotOawzgDkQHiorqB6QTthh3m9f9f4gzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618777; c=relaxed/simple;
	bh=wAxdMfby2D0SF7vG2bXiTceu6vtAkYDeWydXCxbOGjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTsEpNvupdZhtB3GpU2suzhlYj8cTVqrYQKtpI8cKOsEbYEIdutg1gZh1nn6/RxhnJUQhgZ1nyKIFT49m24Kk639Ve1olNvSRMM4ebD3n87ffRwwzgC21921vfSJP0boI3Nu2EQdE52PkSr4LRmNChw6DzqjiemzeOj/e8Rl1oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EiKQP6Pd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723618775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjtZOVWMEdjuvEgST87XVo9JV/srJgiwPjlW1KSOBo8=;
	b=EiKQP6Pd5y8sAHwUfn6KMJ19KbpqphfYnIuQe17JlSTlYHF8o7BjReU6tyOM609CPizu5o
	7WiHivsl4nwkIOlQQNgLM+KZfuFo1LMBUFunjOQb1QhcM2BY/5Qrzyn9PiGrdzgue/Q7yH
	5Ngdq2eDuGrtBZdBGjl6q8O/vnMy5Bw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-8Ur9Z56pPreyl8vR7vU4Dw-1; Wed, 14 Aug 2024 02:59:33 -0400
X-MC-Unique: 8Ur9Z56pPreyl8vR7vU4Dw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5bb90be4d87so4846122a12.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 23:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723618772; x=1724223572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjtZOVWMEdjuvEgST87XVo9JV/srJgiwPjlW1KSOBo8=;
        b=LXUvybq/SANbdVDnMzswbSbabSPW8/siNjSRqyXUOTPYb9k5/2Y33MqMfMOqfhIfJL
         QwbIgL4bVN3oRtCWie9lUUfXhSrMj7GvCKADqrqF4DRgSH38jCz07xtvUtkkZlFHV/+k
         PLMQfSQyXfYSvRYf6CUoXSFD6NGTe9Hzd1i5TP3Xq0M813zTLU67vA3r+n9+C/XPif/K
         SZ1RNw4hWx2MJMQgBr4xzz3SQ9cdRjtSbnAKwvNzROqBqzlQwX7NdGh/Wkv0rKrzr7X1
         0p7yTyY3eyOTz6c4kBSzqZk5d9QEa48u/zoCbMV0p9Y+hwPMehI8i9Jf3AJdeoZzI54l
         Or9A==
X-Forwarded-Encrypted: i=1; AJvYcCWU533k7sa4yj2xsPpeyPHyCdmTUWDLvoSiJ2x5vWSzJZpV+db4c14snFpZiwtjMKyaDAPf3HPrNlKU8HERXT6dNajW72jt
X-Gm-Message-State: AOJu0Yy/m7+27w5/6eivOs9Sg7w/gXxYMpoh6fM4++59ulqjAF4+oMyK
	3cyrP6IY79xQGlGq4+7OrkU85xHwHbH+ScgxVyGUKEfndRHSPBVsjjwTcIey5rg/RWFNsfFIXhU
	Uz5Imu1dbl7mc8kRCyr6pUiJeXUBnDBHz3nOW4frjy1wS2/xbGXvoQA==
X-Received: by 2002:a05:6402:50d0:b0:5a2:1693:1a2f with SMTP id 4fb4d7f45d1cf-5bea1c73b19mr1085395a12.12.1723618772404;
        Tue, 13 Aug 2024 23:59:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS5NxWULN01540o+nnvytUndXUAOiwrbEfd3SI9/UCLbqsnAOKNseZbBkApLr7BKpp8webpQ==
X-Received: by 2002:a05:6402:50d0:b0:5a2:1693:1a2f with SMTP id 4fb4d7f45d1cf-5bea1c73b19mr1085366a12.12.1723618771588;
        Tue, 13 Aug 2024 23:59:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5dfdddsm3576796a12.59.2024.08.13.23.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:59:30 -0700 (PDT)
Date: Wed, 14 Aug 2024 02:59:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC 2/3] Revert "virtio_net: big mode skip the unmap check"
Message-ID: <dde48b251db8b192ee026798e1180476b2183537.1723617902.git.mst@redhat.com>
References: <cover.1723617902.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723617902.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This reverts commit a377ae542d8d0a20a3173da3bbba72e045bea7a9.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Message-ID: <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4f7e686b8bf9..88a57a3fdeff 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -964,7 +964,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs)
+	if (rq->do_dma)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -2296,7 +2296,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		}
 	} else {
 		while (packets < budget &&
-		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
+		       (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
 			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &stats);
 			packets++;
 		}
-- 
MST


