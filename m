Return-Path: <netdev+bounces-231446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CCABF94CF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 052EF4F1875
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2612D73B1;
	Tue, 21 Oct 2025 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfqXNf4K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAC52BEFE7
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090427; cv=none; b=XioGIFfKHJL2c5HHLib1dZtnWMdRbBPVW2uC+ZBAWbMZSx00NtxWMz+Zee/OC26PWZDrmNcVFwmV2NbxN4pgn4j4trn7YWerCHxMwAFiRYKRFdA5nU1gqGZ6ebyJm1uFRTA77uZFHv1mPHP3SMo1wOEpVZ9ITCmIF+wirCQtl04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090427; c=relaxed/simple;
	bh=K7K94rKvWTIzHY+qdRUWp611m4kTE9R26xFksOdXz/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISrgDnWOjhRVBhbMd8tTOjSIhoTxEisOHQxddwEBRHHSMHxM779/Mgv19LgRf4rKpDOsBaNeJtuj1cC4NhZ7lewzU4M8dZs9Hxob2ANdEbUj3NsTcB1e6kIdU3E4ZY11w06ME1kPahu7aZ7glolFZi/AdBzcK69d2GF2YRkczao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfqXNf4K; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-292322d10feso3706865ad.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090424; x=1761695224; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KJsmAxJEMJpeWSL0BwDVZk3RWnsnJFLrlQXVYpzX98=;
        b=XfqXNf4K6DI686KK23iYiyX0kIJtKB4wvPJ/TIN9rBi9ya9PkONLtXxdQAPVEDEsrz
         mLqwkp6H9Q1AcV/YWj8NL3c3NZkAZ6jyP1hj0jF82O+l+z4RX7msKgI/hEdlWC1fry7B
         LBMiU8gw+xVMzXR7OY7oGYxCUGL0EulWjdi8RQnRtC/Mf+M/7yAYX4BFtLM23T5TazdY
         eFDrmx8I4aXYByoH8zYM4bvffGuCVwPhCO7acsW+BcM34oGiTOtPWxdTSDkMjfNOMrK9
         HdJOfoUxg5eX10adH5C3BLQSXd+viu2da8zHG9vqn3r7WExhOgIEnDyN/DsIa11DDa9J
         5V1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090424; x=1761695224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KJsmAxJEMJpeWSL0BwDVZk3RWnsnJFLrlQXVYpzX98=;
        b=xEi0to++nl46Z+KsYYTxQbKmZjTbTLns1/QNgzikTRZcPZHa/x2q8y/cqWCMEJQv+i
         14RfFTc22s4uaBMvmwmLufcpiBI3nDRdc4+SWGROLsLX8Df6j4L7bVvBkg1JbH6+GaVt
         D070fLVdDa8SOTUw/I5Rrn/W5wVkRXwRhEpjaiSqibQ5gL0nA+0MYj1zRzEGxOz8QXMN
         PsPtjODq5419ZvbEz1LN1bn7V0lkJE4kaKXUVCitsxPwqqB7JZLoasjBOQ4Xago97ocH
         Tct5lDGoZv1EcoyK5gmQYHBvmTWKXENFxZO9PsxQ4BXsrmpQsmELO/SKgpEyd+wdR5xZ
         oziw==
X-Forwarded-Encrypted: i=1; AJvYcCWas4SW1DRZuSBBfMbwVeKr+i2XwsVGDsxhns+dPV1G/xbUKkdPYghb1lfSkITqJ03k02XtUTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFNlv6mt0FU8aPcHAvhy7UPgukTCvFg5jGxOA8PFKrNpsAJnU
	w0nYOlHUEFpwFm/+j1KzMBsKtHGjtv9NopDi8bvalGBtD0G6Zh01IaJD
X-Gm-Gg: ASbGnctdinAhXM2XSKDk6OopOb2HDmE/LgQ0bLSVVOYUNlggsZrT0Pv1qIiU/uHTss8
	+85LOY/KghIj5Vz5eLSM6S0YFS6FswuH6J4RxuCKVE0b1ipMzPwAmfX1o/zfizTMUw3vJSaZWZb
	PZejweQzOxtjqw4/onFhjHA7CjncggbScsTtl+kidkQOjKpVJicwrxCtJ37/apNc8rkpEdkf85q
	OMN0qu8TLLILRkfowZ41kF/Lm/4+Q5z6EHC7Sx6kbDGFwPFlom5ceMP+r1uD1CBIm0g67RsLQSM
	IY8jiEdetSyE7MHjivTIvm9I8ZV59O9PKul5jYGcjUCdZGVgGIDXAfcnhW7RNlvlvBcUOY9fvqq
	zPU+pCcJQZVsR3IQ1ejtKYBclfV0IHw+ffcX0sWiMyYU7IXMTgdlkhgofb1zJPVbhGZw6XUN1Aw
	==
X-Google-Smtp-Source: AGHT+IFCrufQGCbNqmEJ7tzIn5lW6dCh+SlfvQIPR+toK95JiZPUcURBDL/+GeryRebw/OetDSF4kg==
X-Received: by 2002:a17:903:249:b0:267:44e6:11d6 with SMTP id d9443c01a7336-292ffba4632mr17882415ad.6.1761090423876;
        Tue, 21 Oct 2025 16:47:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcf06sm121037085ad.24.2025.10.21.16.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:03 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:48 -0700
Subject: [PATCH net-next v7 05/26] vsock/loopback: add netns support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-5-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add NS support to vsock loopback. Sockets in a global mode netns
communicate with each other, regardless of namespace. Sockets in a local
mode netns may only communicate with other sockets within the same
namespace.

Use pernet_ops to install a vsock_loopback for every namespace that is
created (to be used if local mode is enabled).

Retroactively call init/exit on every namespace when the vsock_loopback
module is loaded in order to initialize the per-ns device.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v7:
- drop for_each_net() init/exit, drop net_rwsem, the pernet registration
  handles this automatically and race-free
- flush workqueue before destruction, purge pkt list
- remember net_mode instead of current net mode
- keep space after INIT_WORK()
- change vsock_loopback in netns_vsock to ->priv void ptr
- rename `orig_net_mode` to `net_mode`
- remove useless comment
- protect `register_pernet_subsys()` with `net_rwsem`
- do cleanup before releasing `net_rwsem` when failure happens
- call `unregister_pernet_subsys()` in `vsock_loopback_exit()`
- call `vsock_loopback_deinit_vsock()` in `vsock_loopback_exit()`

Changes in v6:
- init pernet ops for vsock_loopback module
- vsock_loopback: add space in struct to clarify lock protection
- do proper cleanup/unregister on vsock_loopback_exit()
- vsock_loopback: use virtio_vsock_skb_net()

Changes in v5:
- add callbacks code to avoid reverse dependency
- add logic for handling vsock_loopback setup for already existing
  namespaces
---
 include/net/netns/vsock.h      |  2 +
 net/vmw_vsock/vsock_loopback.c | 85 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
index c9a438ad52f2..9d0d8e2fbc37 100644
--- a/include/net/netns/vsock.h
+++ b/include/net/netns/vsock.h
@@ -16,5 +16,7 @@ struct netns_vsock {
 	/* protected by lock */
 	enum vsock_net_mode mode;
 	bool mode_locked;
+
+	void *priv;
 };
 #endif /* __NET_NET_NAMESPACE_VSOCK_H */
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index a8f218f0c5a3..474083d4cfcb 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -28,8 +28,16 @@ static u32 vsock_loopback_get_local_cid(void)
 
 static int vsock_loopback_send_pkt(struct sk_buff *skb)
 {
-	struct vsock_loopback *vsock = &the_vsock_loopback;
+	struct vsock_loopback *vsock;
 	int len = skb->len;
+	struct net *net;
+
+	net = virtio_vsock_skb_net(skb);
+
+	if (virtio_vsock_skb_net_mode(skb) == VSOCK_NET_MODE_LOCAL)
+		vsock = (struct vsock_loopback *)net->vsock.priv;
+	else
+		vsock = &the_vsock_loopback;
 
 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
 	queue_work(vsock->workqueue, &vsock->pkt_work);
@@ -134,11 +142,8 @@ static void vsock_loopback_work(struct work_struct *work)
 	}
 }
 
-static int __init vsock_loopback_init(void)
+static int vsock_loopback_init_vsock(struct vsock_loopback *vsock)
 {
-	struct vsock_loopback *vsock = &the_vsock_loopback;
-	int ret;
-
 	vsock->workqueue = alloc_workqueue("vsock-loopback", WQ_PERCPU, 0);
 	if (!vsock->workqueue)
 		return -ENOMEM;
@@ -146,15 +151,73 @@ static int __init vsock_loopback_init(void)
 	skb_queue_head_init(&vsock->pkt_queue);
 	INIT_WORK(&vsock->pkt_work, vsock_loopback_work);
 
+	return 0;
+}
+
+static void vsock_loopback_deinit_vsock(struct vsock_loopback *vsock)
+{
+	if (vsock->workqueue) {
+		flush_work(&vsock->pkt_work);
+		virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
+		destroy_workqueue(vsock->workqueue);
+		vsock->workqueue = NULL;
+	}
+}
+
+static int vsock_loopback_init_net(struct net *net)
+{
+	int ret;
+
+	net->vsock.priv = kzalloc(sizeof(struct vsock_loopback), GFP_KERNEL);
+	if (!net->vsock.priv)
+		return -ENOMEM;
+
+	ret = vsock_loopback_init_vsock((struct vsock_loopback *)net->vsock.priv);
+	if (ret < 0) {
+		kfree(net->vsock.priv);
+		net->vsock.priv = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static void vsock_loopback_exit_net(struct net *net)
+{
+	vsock_loopback_deinit_vsock(net->vsock.priv);
+	kfree(net->vsock.priv);
+	net->vsock.priv = NULL;
+}
+
+static struct pernet_operations vsock_loopback_net_ops = {
+	.init = vsock_loopback_init_net,
+	.exit = vsock_loopback_exit_net,
+};
+
+static int __init vsock_loopback_init(void)
+{
+	struct vsock_loopback *vsock = &the_vsock_loopback;
+	int ret;
+
+	ret = vsock_loopback_init_vsock(vsock);
+	if (ret < 0)
+		return ret;
+
+	ret = register_pernet_subsys(&vsock_loopback_net_ops);
+	if (ret < 0)
+		goto out_deinit_vsock;
+
 	ret = vsock_core_register(&loopback_transport.transport,
 				  VSOCK_TRANSPORT_F_LOCAL);
 	if (ret)
-		goto out_wq;
+		goto out_unregister_pernet_subsys;
 
 	return 0;
 
-out_wq:
-	destroy_workqueue(vsock->workqueue);
+out_unregister_pernet_subsys:
+	unregister_pernet_subsys(&vsock_loopback_net_ops);
+out_deinit_vsock:
+	vsock_loopback_deinit_vsock(vsock);
 	return ret;
 }
 
@@ -164,11 +227,9 @@ static void __exit vsock_loopback_exit(void)
 
 	vsock_core_unregister(&loopback_transport.transport);
 
-	flush_work(&vsock->pkt_work);
-
-	virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
+	unregister_pernet_subsys(&vsock_loopback_net_ops);
 
-	destroy_workqueue(vsock->workqueue);
+	vsock_loopback_deinit_vsock(vsock);
 }
 
 module_init(vsock_loopback_init);

-- 
2.47.3


