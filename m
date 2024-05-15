Return-Path: <netdev+bounces-96592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EC08C6936
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 17:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14458B22A6A
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04798155750;
	Wed, 15 May 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSmYjFm0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D618C13F422
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785553; cv=none; b=ZkRHLP325HI8p8P5FehxsV9LEJMO56s8GcwtZQwAB3GQ6iGLf+bAYezB+HB6J+c7ZTvpaVKAvK7ZhvTGoXx76I//wQl7RM4Equp55VEB8BJU/CJ/cYpITr8Rfih774Y7TiDwXCnNv3x6QHHdOzdHbcejpxbZj2ENnKUj27BcTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785553; c=relaxed/simple;
	bh=Eqhliyv/rLaqDzkaLcjCJEDibkGNoMMtCnsez51KbII=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jYNJIt6DDFw+ViUNxH1zH1LaTaq/Bg5I5habx0/LLaM5Pe4WVXhgN7LDVX6DH2RmgBVKuNK8qIMFPsIweNVSkm73VnWCR24jWBogdLSq9/3sx+XgjuxrEInxokGFPrluPqEhlDFuvE51pmQ4qjHc1ZP3jp+IC+fKp1/3F1qxXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSmYjFm0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715785549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5HsQnBBLUP3Pazt+byzwwgyn37KXCpOuxjPpikdkNik=;
	b=ZSmYjFm0MHQMDWa0aiKkvIRrfjy+0cdAKxXhhqZ4bo/nOAsROJf6n8lYKmzR7SF1J6oKoV
	GnvTFX25TFNvbBXbUWlPS832iC6Kbu3JWfJ1rIgz9FzRTubx8rZili01BFKmYdPJ9KnxUX
	aMv8jnKV8RYJvf+0kZs/QLjayC9/o2o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-qdDbHy75Mhq_JmUBmk-oaw-1; Wed, 15 May 2024 11:05:48 -0400
X-MC-Unique: qdDbHy75Mhq_JmUBmk-oaw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4200efb9ac6so24648405e9.2
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 08:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785547; x=1716390347;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5HsQnBBLUP3Pazt+byzwwgyn37KXCpOuxjPpikdkNik=;
        b=cWe7BewpD3WZzqM5uo/UcNbdrsL4cK/aO0QsI0TK07bNYYJx8NDi1Gf1SZPkUAIIHE
         4JG/CVUhCnEy63Djtap6V9h79o9lorww3icx4jFUqhVh0A1h8v59QEn/I/UyBa/JVgRt
         Do6HQq2jNSLN3r3mmBZ2z7mpsJGC3gETjr80mSmc8DRdTntWRBJWok2Zzw9U6I+wEvgA
         s+lTflqr1uFKQec/3diO4SppRwX0hWP6uJrsfaKJwpT4XfjirW4clSuXNm2gcwm8BCNl
         u/fKY/6Ce5F59yWtsdzoc2H3exvJPBS1bDWp4Nl/9ESXSyhyFLq4by17Yc/Wi1PEGd5A
         r4uA==
X-Forwarded-Encrypted: i=1; AJvYcCWFHh3fbdX+rHuFl3UWgfHNprZPHrmwji68pErYj9twIYWJ5DRv/RUh8U6ixOILvimpAwPv7sRCiOP58O9Sm4H2GCseMecy
X-Gm-Message-State: AOJu0YxA0er4OKsc0Z9VcClr+xcQJVLlbedHwN8f7FF9Lf7PTO+uUUA5
	dtuZhyiW11O2ZrLl6Otc3KMTvSSufhL8kl7/x4nPwXyLvkYzz33OSXqcNc1mBxLCKIjpqO9cnBk
	CdlcAP2gLAyNpV3ie2MhLquIjD8za2e5dpSaVX6dnlWDHX9DQBpg4YQ==
X-Received: by 2002:a05:600c:a44:b0:41a:34c3:2297 with SMTP id 5b1f17b1804b1-41fea93a34cmr139867965e9.5.1715785547154;
        Wed, 15 May 2024 08:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwcKYJU04KRN+C9m9RrjwdUumM+NzjuDj85eoasrKYaMbDWv5ZX8CZUBelGxUEWCXHzSMp8A==
X-Received: by 2002:a05:600c:a44:b0:41a:34c3:2297 with SMTP id 5b1f17b1804b1-41fea93a34cmr139867595e9.5.1715785546575;
        Wed, 15 May 2024 08:05:46 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c01e:6df5:7e14:ad03:85bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff7a840d2sm197154985e9.39.2024.05.15.08.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:05:45 -0700 (PDT)
Date: Wed, 15 May 2024 11:05:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>,
	Arseny Krasnov <arseny.krasnov@kaspersky.com>,
	"David S . Miller" <davem@davemloft.net>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] vhost/vsock: always initialize seqpacket_allow
Message-ID: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
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

There are two issues around seqpacket_allow:
1. seqpacket_allow is not initialized when socket is
   created. Thus if features are never set, it will be
   read uninitialized.
2. if VIRTIO_VSOCK_F_SEQPACKET is set and then cleared,
   then seqpacket_allow will not be cleared appropriately
   (existing apps I know about don't usually do this but
    it's legal and there's no way to be sure no one relies
    on this).

To fix:
	- initialize seqpacket_allow after allocation
	- set it unconditionally in set_features

Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
Reported-by: Jeongjun Park <aha310510@gmail.com>
Fixes: ced7b713711f ("vhost/vsock: support SEQPACKET for transport").
Cc: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Tested-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

---


Reposting now it's been tested.

 drivers/vhost/vsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ec20ecff85c7..bf664ec9341b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -667,6 +667,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	}
 
 	vsock->guest_cid = 0; /* no CID assigned yet */
+	vsock->seqpacket_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -810,8 +811,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 			goto err;
 	}
 
-	if (features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))
-		vsock->seqpacket_allow = true;
+	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];
-- 
MST


