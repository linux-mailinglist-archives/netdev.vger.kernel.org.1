Return-Path: <netdev+bounces-125866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8615E96F05A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9811C217C6
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC54A1C8FD9;
	Fri,  6 Sep 2024 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjOE/3GJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF411C8FBB
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616379; cv=none; b=kFY1ATtDfU2eA160U4rQeckIk8SoAD8sqjEi9okIQdx+0zD0tCV8d1yFUFTUlYuRQVxTGZto9IQC+nv7mgaWgJlgREvkA5ivleUzBqGK1odOrV6xtcIq6YSc/khjy/uQKTWMoafM+82B67mf8v0TXbwtunikBU+eqxmrugn0EN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616379; c=relaxed/simple;
	bh=y/2q/oU3B2T/Sj3xYbJ3TRbapgrDhvFRSSna1J7JF/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5BDepHPoFOa2xxgpEq/G2un67GVFa2RqCoYlcpvSH9MdPU9+WnGIQJcw7RwGr7hZfrM/n1eJEHXepU9f4ILaLbNaKDpgzGQY6iXTDT4VRVjxieDT//uUx54c1jdlEeVxGeCHg9Bwe+GefUaTy/TwOO7Tq1DsQu1hGAaQNS93bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjOE/3GJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725616367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pft5+JeYXYrsom9XC/wwmdmDEnhGm2vJUjZuwg+BsyM=;
	b=CjOE/3GJ4IyJBnXsBf/ykYzDPdCAsYwIpxktf0H7ALGACJzD7fxEuKLww18iVhY7To9dyr
	12kmyIrQ1Ac8qGBeLi0OUqINRpFNrZgqMHnmkFTyRBxr5S2AG7prW7Hp9M/1hEk0V14Ioy
	sNO/0gxeDm1sZSnrnqAu+JDmYyZfylI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-lFUZIY2MPTytrb0LIqkhtQ-1; Fri, 06 Sep 2024 05:52:46 -0400
X-MC-Unique: lFUZIY2MPTytrb0LIqkhtQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42c883c8cf7so15070485e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 02:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616365; x=1726221165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pft5+JeYXYrsom9XC/wwmdmDEnhGm2vJUjZuwg+BsyM=;
        b=A57QFkXz3ze4wUWkjaPqVpWeapH1i6C4uO2xjSjOVXeuGTRRQDIKHl1PIx0pNVHpsN
         SQ6wthZzb6yqex2u3Tu+889Nvgy+t90Hzi2njlTtyuQBJtBern9fq8nWCl46UHHyc1zD
         4OsAHEupFA+hfYbtvezxPlE5ikYp0lGZ0GJTKpE/mSaXLArVAJtIoZds+35j3N+whsmZ
         Y6XdvHvaJVsFlrXBUUCGcvSIu8a1d4gukYUwixNPzMvOmZJeCnN62r6mtPGb1LrcXzvm
         mhTwGFmATC48EafyNmYgHjW658r3PnI3WV7JJIyaxOPmO6eZCUiUrCxWHcezDikgRvj7
         OxnA==
X-Forwarded-Encrypted: i=1; AJvYcCXpcSqtnh6bYfZBBDc1FjM0GuZDkWr7ZATieWMe4LOhMKod3Lb4Pe3LYeyNoqAmky6keduY56o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyozflQiffZgyURtQRVXrbhlUjGehKHsIgotvCgtFQAgwr7i4lY
	1imcqrB8MVOGr2fiYRsH2XbHnR8x+BPEeLKFYF2BHuzeJeMOCfbV9Yy/teJ1HV/K6UpfYIZkctk
	lN1IWYJh2ofEHxkSjhFGERpLzxHlNaLUaeeJcsuj/Ch96dOAAgmDRkw==
X-Received: by 2002:a05:600c:1913:b0:426:5d0d:a2c9 with SMTP id 5b1f17b1804b1-42c9f97dbfamr13581685e9.10.1725616365016;
        Fri, 06 Sep 2024 02:52:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF21JiRX7kMArBtpqaDQnryw6ZUluOTmbApXNoVkHLpPhwvwYOfjmZQYcgbTEuY9mkhpcPeag==
X-Received: by 2002:a05:600c:1913:b0:426:5d0d:a2c9 with SMTP id 5b1f17b1804b1-42c9f97dbfamr13581415e9.10.1725616364521;
        Fri, 06 Sep 2024 02:52:44 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05d3171sm14716285e9.28.2024.09.06.02.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:52:43 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:52:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [RFC PATCH v2 6/7] Revert "virtio_net: big mode skip the unmap check"
Message-ID: <3db7fcc631c2f1dd6a62e5d90fecf3e5c32ca4e2.1725616135.git.mst@redhat.com>
References: <cover.1725616135.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725616135.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This reverts commit a377ae542d8d0a20a3173da3bbba72e045bea7a9.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0a2ec9570521..6f3c39dc6f76 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -983,7 +983,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs)
+	if (rq->do_dma)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -2367,7 +2367,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
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


