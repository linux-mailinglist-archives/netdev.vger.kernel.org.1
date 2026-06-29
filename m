Return-Path: <netdev+bounces-302439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id flf4DkbOQWqiugkAu9opvQ
	(envelope-from <netdev+bounces-302439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 03:45:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A29306D56F7
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 03:45:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IMJdHDH8;
	dkim=pass header.d=redhat.com header.s=google header.b="d3OF/izX";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302439-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302439-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E271300A100
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 01:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB0E379C47;
	Mon, 29 Jun 2026 01:45:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79307246770
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 01:45:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782697538; cv=none; b=jYBeZn8abnyUNwMIasl8ie+XBmEOgCdxyUdo+bxQWyKo94+BFtuZsQLPpnEoTbSk7sOctPzuEM+tUzMm9UD1LMsfw/7wNSUWBTWj5pFQcyXFyPB+Ecb81Db9a+w1wmSV2EDou6T7RXanEH5rFuSX0F4qtrov1Z3fuW7vOC4xEXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782697538; c=relaxed/simple;
	bh=yntFMUzD/ii2OqD5HS1hjbqyMZks/DiA0fVR83FEiGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=WnzLhbRX018T7XYKSY2rjAuQIELn2LMMHJLcsrX7GT5qH5gSP3GsMyO6vJrQvaMUn7kED1Nkz/3H2cPIlzBY1uT0ARzO4rD+x9NdhJfQ/099DqiGp8rou1QmgAFL57Gmte5Y84DPge8RKgOsi8qAYisswzqqgPBClEOUqiPiBPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMJdHDH8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3OF/izX; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782697536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AehoOCJmWEBUGxUzdNE1sQa+qNVdV0emwrzzm73CHcA=;
	b=IMJdHDH8BhSK7JkRrELOVBja2DlkKb9sli0Rq9+9QLmWGcu77FCOaN8oWje6iKWJNeWzNI
	lPb4qGyWuJwE1SUju0VJASCP601tbyvFmWnODLxC6qNXZM1EQGlqGgOVRHrHmuuTQBhqjd
	1cND8fPteIc6o2NN3C7XSjpefev5CQ4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-4_m0Y2bsN0a_29Zxrc258A-1; Sun, 28 Jun 2026 21:45:35 -0400
X-MC-Unique: 4_m0Y2bsN0a_29Zxrc258A-1
X-Mimecast-MFC-AGG-ID: 4_m0Y2bsN0a_29Zxrc258A_1782697534
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37fd8d36025so586645a91.2
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 18:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782697534; x=1783302334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AehoOCJmWEBUGxUzdNE1sQa+qNVdV0emwrzzm73CHcA=;
        b=d3OF/izX3rU51gbaUdW3k9SQtb4pNVa6/DYQSxvmqYQM/8L3Y60WiKeT7Ol915xwye
         H2JcP1xJygJyQEwigWELDTV7rB681DuHtw5gp+nf7Jb2dBVwb/ms+yqAxnmEylFMeam+
         JdjZ98ncJJc0WItzXkVw5zFr7JSemM2GEL9R23Vtl5ATa4/eddN/8WlIC1ojm4VqQNXu
         JbwPO66mz0ONWlVEZH+XiJTMYmwTzJiw2VS9n08AHd+WbvrUlOAPthdE0HI3PXCLHPcJ
         GRKJWSfyak/DiNxjjMyQJePJdIxnBQs5uWicDuTJcSHHa5u2oDyqcj4hMlSoW08AiG4V
         8zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782697534; x=1783302334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AehoOCJmWEBUGxUzdNE1sQa+qNVdV0emwrzzm73CHcA=;
        b=Mly8doHCAP+cxkqlyD+F3fg/QTZHNWqwLunEDnGHWP7C4kSB0Ml5M9qnAT/ihaeR2W
         p5RqDEKbrXQHzOZqLNvzXOMu7W9DWIgHQ7rL0ej+twfT7DC4narYkRYgO53sglDSm4bj
         OaHjEUANnz+8sHAx1aPTqTOQa+olntjF4NyS/nwnMngaSZkMtNvtkiE3upCqLvTVyrdT
         c9IAe5QgtXbxMmKDwfvznb8hXiEBuHqgMvXo2ca1fcxcaFVBDF/SOrnUq8v75EBZ19rp
         mDee2WYuBOhAz08soHQa6Qug55pJQpIUeWKxY4qnmWSXJlGlnfLJqAtN1C2NDOGaQIEX
         mtuQ==
X-Forwarded-Encrypted: i=1; AHgh+RoyhuYAaDSgCz8uJClztATu/IIhPsjcGZPwPy7v4OaEgp4U8CQEVEKSxY25v0tYv+kMXbeAw44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu0yfPI7lU4Pd8z1RsHOuC4UNDKYjl62+SAsCI0hM4jjSIaanu
	YZsu/o15LeGbnDeXeHxrsiJN21Ng59ff/6zGYCG3dLSNZNO2DYVJe288l0FC2Md3XWdf/jkFMaO
	BGOhNCqdUY1c3mgGU7VK0PnxWdeWy6zvwzkLVKf+SluInQDYalUitCesaeQ==
X-Gm-Gg: AfdE7clVTVXEWrAs6X06ZTPFXkuhN3MjyOzcJVlScG0aWRgDVxxDh+iwetaGrQ2Tr8o
	xiqZZvpWID9TUmckptjuTE8N/U61S97sCNX7cqzggMfLlSO7oGd75hQpBOpmmHWq9RRTu4Gcn1m
	7wMGBiaBjKpLazoWMyxfMySsdO1SoA5++H8fHj7D2mQLNzojK0KiDqHOn/gEdBHiQ6+7jRmZkFo
	t2MOWChKFyeo1R7/M4lHGCuYWEcjTJlDzMfIOYTRWo4LDrtL2OiabUIhjAo9FHUYXxiV1pGgRUj
	c6DudYOKbNE7t4ddm0nBNTMVk6TVQewyOiCgAIagXP4HIZ3VjsrKzyCbwyu8hsZJ0bSDn8ahCFi
	XcAljr9mtMif65mTKST3ykg==
X-Received: by 2002:a17:90b:1fcf:b0:37e:a40:e71a with SMTP id 98e67ed59e1d1-37f81594261mr7017631a91.14.1782697533956;
        Sun, 28 Jun 2026 18:45:33 -0700 (PDT)
X-Received: by 2002:a17:90b:1fcf:b0:37e:a40:e71a with SMTP id 98e67ed59e1d1-37f81594261mr7017618a91.14.1782697533423;
        Sun, 28 Jun 2026 18:45:33 -0700 (PDT)
Received: from localhost.localdomain ([208.115.228.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37f464b5dadsm4464301a91.5.2026.06.28.18.45.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Jun 2026 18:45:32 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2] MAINTAINERS: Update Jason Wang's email address
Date: Mon, 29 Jun 2026 09:45:24 +0800
Message-ID: <20260629014525.16297-1-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302439-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:eperezma@redhat.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jasowang@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A29306D56F7

I will use jasowangio@gmail.com for future review and discussion.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- Add mailmap entry
---
 .mailmap    |  1 +
 MAINTAINERS | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index 23eb9a4b04f4..e7e639aeb23c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -373,6 +373,7 @@ Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@opinsys.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@nvidia.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
+Jason Wang <jasowangio@gmail.com> <jasowang@redhat.com>
 Jason Xing <kerneljasonxing@gmail.com>  <kernelxing@tencent.com>
 <javier@osg.samsung.com> <javier.martinez@collabora.co.uk>
 Javi Merino <javi.merino@kernel.org> <javi.merino@arm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..40d9641cbc7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27520,7 +27520,7 @@ F:	drivers/net/ethernet/dec/tulip/
 
 TUN/TAP DRIVER
 M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 S:	Maintained
 W:	http://vtun.sourceforge.net/tun
 F:	Documentation/networking/tuntap.rst
@@ -28512,7 +28512,7 @@ F:	include/uapi/linux/virtio_balloon.h
 
 VIRTIO BLOCK AND SCSI DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Stefan Hajnoczi <stefanha@redhat.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
@@ -28541,7 +28541,7 @@ F:	include/uapi/linux/virtio_console.h
 
 VIRTIO CORE
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
@@ -28619,7 +28619,7 @@ F:	include/uapi/linux/virtio_gpu.h
 
 VIRTIO HOST (VHOST)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
 L:	kvm@vger.kernel.org
 L:	virtualization@lists.linux.dev
@@ -28634,7 +28634,7 @@ F:	kernel/vhost_task.c
 
 VIRTIO HOST (VHOST-SCSI)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 M:	Mike Christie <michael.christie@oracle.com>
 R:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Stefan Hajnoczi <stefanha@redhat.com>
@@ -28674,7 +28674,7 @@ F:	include/uapi/linux/virtio_mem.h
 
 VIRTIO NET DRIVER
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
 L:	netdev@vger.kernel.org
-- 
2.54.0


