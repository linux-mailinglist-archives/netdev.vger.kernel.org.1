Return-Path: <netdev+bounces-18781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5619758A6A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3BB1C20F0C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 00:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F354418;
	Wed, 19 Jul 2023 00:50:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AFF440D
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:50:18 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728DF1715
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:50:15 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76571dae5feso589564585a.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689727814; x=1692319814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5UDtnqRbXOwSk4kv7KpsqiuRSfPeujQxTt7caqoeag=;
        b=Bzc5QYphkJxBJAAVGcKxoftfnIy9ixoapstjfZaDHt+8ignmoEtHuP1QMFfV/NgdZv
         3sj5ZjysfQgDx4p0HKOtFfmPSLhf8q9ZrgG0m5jUcvca0sYjsElAG49iWpsKB4o7xNlw
         uAQ40QIRMt+3ilnWtx70o1O4HaBVrlCrik+wNvo96xyR4+3Q4cUVkFT5sX2tg+JhlBe+
         hSQ//wu9r44PASXmqG6/Xmmv+nIq7JhrBez2ZRRnULIsZkr3/pE+EpOBNqOpyyWWX28B
         g5owX/BThJ1OiSg+ZKlYhgtlbmLJZLHH8juDYc38OwYMTHaeoKsA4gvu2ohtJ4f634Uk
         w1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689727814; x=1692319814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5UDtnqRbXOwSk4kv7KpsqiuRSfPeujQxTt7caqoeag=;
        b=XkbGxGjNi9FbMDcxJFP0/NhoONugTOSwV3uc6Px+O5U8xy2jv0Tj5dF7qxIokfeP81
         5/X/ACrKA0g1Xfwtd4+kpJYjzq/FSs+r6nXtiNynDJS9A7J65ErhJ+zEbSJQTZby0af/
         UPA6bIU3mwP9WY+SzDYPiZnb46kcMxHsldQVV1r/B/IHFo8GW8y3ALn4JKllrSaau6Uv
         L69wxOgmQNQCBaPdhC8R/zJGVJMhejU/tPmCRikb28aUtuCYQaH16TSBNLt329ZNKff7
         Cc/L7rmgbHaivl2QdIjG6UIurznhkkJ0UykXQ9pQ3CiwSnqUvZpc+QgTY+IcQgY/d9rr
         G6SQ==
X-Gm-Message-State: ABy/qLZtayN7cE9adKWaoM7pUHQWNhXMM9iq6YS6YYrXNPIyf82CNFO8
	19WN1LTSvgfNk3ue/6vejo2mFw==
X-Google-Smtp-Source: APBJJlFOmR0fNEyLgJ+viEMpPBQC9+mqSkp+cSt9WdE1XdGyudW5tKRhGwKsNcl1PUOy43fop5oI/w==
X-Received: by 2002:a05:620a:400b:b0:767:2a7e:1dbc with SMTP id h11-20020a05620a400b00b007672a7e1dbcmr1924213qko.17.1689727814453;
        Tue, 18 Jul 2023 17:50:14 -0700 (PDT)
Received: from [172.17.0.7] ([130.44.212.112])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b0076738337cd1sm968696qkk.1.2023.07.18.17.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 17:50:14 -0700 (PDT)
From: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Wed, 19 Jul 2023 00:50:10 +0000
Subject: [PATCH RFC net-next v5 06/14] virtio/vsock: add
 VIRTIO_VSOCK_TYPE_DGRAM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v5-6-581bd37fdb26@bytedance.com>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
In-Reply-To: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>, 
 Vishnu Dasa <vdasa@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Simon Horman <simon.horman@corigine.com>, 
 Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 bpf@vger.kernel.org, Bobby Eshleman <bobby.eshleman@bytedance.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit adds the datagram packet type for inclusion in virtio vsock
packet headers. It is included here as a standalone commit because
multiple future but distinct commits depend on it.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 include/uapi/linux/virtio_vsock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
index 64738838bee5..331be28b1d30 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -69,6 +69,7 @@ struct virtio_vsock_hdr {
 enum virtio_vsock_type {
 	VIRTIO_VSOCK_TYPE_STREAM = 1,
 	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
+	VIRTIO_VSOCK_TYPE_DGRAM = 3,
 };
 
 enum virtio_vsock_op {

-- 
2.30.2


