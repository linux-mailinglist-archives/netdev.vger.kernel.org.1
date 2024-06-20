Return-Path: <netdev+bounces-105153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD5E90FDF8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACAF1F254DE
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6DF5101A;
	Thu, 20 Jun 2024 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azluMy3i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7B4D8BA
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869504; cv=none; b=F2y5vknVnSNiAJTmDSjJP/NbHEmQh1u4p7EfDS0qxTReqYLLrzsgzJNW9d3IpXvF/01u0/NKeoLGQoRHSyONNVV0zclaQ/wchuQfPuRH321kODttMH9mX6mWVJ2v4T8eCZrt4JB4RCFgozL4Ekhko+Xs0hH38YXosIuGGxX5Fck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869504; c=relaxed/simple;
	bh=jriSfG3yE8FF/6EIGZsE4m9KeLD7WIHU7POZs2Y87aM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RT0kS4VHwMGQ0Zl9iudgLQLIkezz+W5efNadgspCe3vTToaM0TSlTWlJhKDre++Q8cnj0bpRqHz/MOWkHb+63eGGYnQ2ppMeyaeAzBYWiQ+FnV001At08ob8xiq55LFPx+M0sKo0vBQqjjUp3kmG517TN2hv4pbqAJx57vAxDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azluMy3i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718869501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=FLGfD3eNgl/6ZqS6Hg5LlUxNxxeA+GusPPmU/ACDKiU=;
	b=azluMy3ibVS44ghDQrrEvRlKvKrikLzf/M6soZZb/pxettcmioxqEMFNXnCfxeAdgM9/ZK
	UktWIMAWGUD/WClsGwTbgMiNxly9eab10ILbmDIBzoFq9dHgwz+g5jM1WTpdfGkh8jcaI5
	Cq+/ibL3tuJyBWT1tSZAC+FMJZ3U5UU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-k-_HPqnWPpm_NKbw6TWHUw-1; Thu, 20 Jun 2024 03:44:59 -0400
X-MC-Unique: k-_HPqnWPpm_NKbw6TWHUw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6fb670da30so20619866b.2
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 00:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869498; x=1719474298;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLGfD3eNgl/6ZqS6Hg5LlUxNxxeA+GusPPmU/ACDKiU=;
        b=RzISZBGxOpH4u/OSLoEBt/TiQ01VjG7W37h6n9v0dG3lGxQPy6IG1Z6IFyA2WwqRnh
         CFVwcLRi0xqN80xhCwkasQlmBdS0c04PKVNvu8QbLK1vu8yatHO3FvWKIX+7ioZZm+Kp
         9WLMEKlIZQLflKFa/8ASVJ201hcCI7d9nD4YktmXGJgugUrsXzh2XZRtKGE0KSK+BKb3
         xb84V87D3oOmQvo0z0ZOmAE5irxh5iha5sz6U3WT2x6XEblhwcIMZ1wngziHWHWmmmsR
         7zxM+F84SXHBcFxtZXffaxZQaynuOnWzFgquwwkrQxr3zb/z6anBzWU3DFR3+dhL3alN
         XxVA==
X-Forwarded-Encrypted: i=1; AJvYcCVDgMEhcfEnhmB3Ww4s9OqhpABKZuReT0FS1GMyYaeEJxX8cLjV+RRjXyiO9+0X1RmOPmdDXRJB/4fgIC/tndODA5nv/gbi
X-Gm-Message-State: AOJu0Yx335Z2WEC6h64WXVLdUWX9ka6puqInzp/TYHNL5yMUoU+Hqj8+
	xN5fIs6gR0H4AEzSvy2pIkrPwTBBNVw0xuuUx4CVsBA4Vz6aeLpiDMe6EXB2pmMV01SviZ1Mq7U
	O80JbyFIKYiMp401Uht5Qi4HDpGOIMbSzrd2zl97EIhFtvSvLpX/hmg==
X-Received: by 2002:a17:906:3944:b0:a6f:4a42:1976 with SMTP id a640c23a62f3a-a6fab648b2amr244125366b.37.1718869498246;
        Thu, 20 Jun 2024 00:44:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7rXUumkKpuJQU4WxiFQxdfftMFik/0/wxkymNN3g+4BHNw8Xis8UnHK3Oq+VbGL1wV+yXGQ==
X-Received: by 2002:a17:906:3944:b0:a6f:4a42:1976 with SMTP id a640c23a62f3a-a6fab648b2amr244123466b.37.1718869497562;
        Thu, 20 Jun 2024 00:44:57 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f9b3feb7esm181368366b.172.2024.06.20.00.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:44:56 -0700 (PDT)
Date: Thu, 20 Jun 2024 03:44:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next] net: virtio: unify code to init stats
Message-ID: <fb91a4ec2224c36adda854314940304d708d59ef.1718869408.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Moving initialization of stats structure into
__free_old_xmit reduces the code size slightly.
It also makes it clearer that this function shouldn't
be called multiple times on the same stats struct.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Especially important now that Jiri's patch for BQL has been merged.
Lightly tested.

 drivers/net/virtio_net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 283b34d50296..c2ce8de340f7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -383,6 +383,8 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 	unsigned int len;
 	void *ptr;
 
+	stats->bytes = stats->packets = 0;
+
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
 		++stats->packets;
 
@@ -828,7 +830,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 static void free_old_xmit(struct send_queue *sq, bool in_napi)
 {
-	struct virtnet_sq_free_stats stats = {0};
+	struct virtnet_sq_free_stats stats;
 
 	__free_old_xmit(sq, in_napi, &stats);
 
@@ -979,7 +981,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 			    int n, struct xdp_frame **frames, u32 flags)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	struct virtnet_sq_free_stats stats = {0};
+	struct virtnet_sq_free_stats stats;
 	struct receive_queue *rq = vi->rq;
 	struct bpf_prog *xdp_prog;
 	struct send_queue *sq;
-- 
MST


