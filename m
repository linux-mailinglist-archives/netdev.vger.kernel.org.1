Return-Path: <netdev+bounces-105980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5D19140A2
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 04:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD611C211F4
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 02:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EF91119A;
	Mon, 24 Jun 2024 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEcj56sl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B779E1
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197160; cv=none; b=rakbgwT2HZDUffLYxQPzJJvnqbV6+6coCwZ8xVEFHqE1rxq0oYG4h8RxyiIuQqe/pMfA6PDlN4S3Ad4zE6CqRhV9pTS8q2Au6PBLfJKnzUv0TP8WgInygQAjfxkJSrJZRQsUxbsA9iEChF5j6yjGRqLJyjBxR4Y4qt/VZhR0BLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197160; c=relaxed/simple;
	bh=lHMBMN1aOOtIjA3goGFM8RsDgSslvqlT0CFKvQne9HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/dvqJKRl2S2Le1bLJjtXCWadq3n1w7G+MwAvK865YNOMbzfaEhjuyIPlsP8bikaaH4piuZqSukMtR9TXbY3ZyEckygzdjtM5dS7kahb7oYP9mLYsthIHybcm4EpUbi/9bc+uLi8t2Y1mfqNhW1i7atj+BSOc7UYwBrYkfQDrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEcj56sl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719197158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8ma79Lf12qsH/HRx/hyZ2J2F2i4kk451VRlEuUsJkU=;
	b=BEcj56slDqNr1nCUH8/7JN0dpZEe6TiuL0H5GUSVoRnYgZpWeKinYZj7MK5Okt4TRh9mDL
	mhzcVUBP05JADXCUK55FYyLK+N4byXIUbAckgh4HPc+hTmUl3knQQKGGTop2M5IW5w6eRF
	y2ILYogwQJKGgUz11Lay+RrQSN4NJ8U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-EpZqdHUWMp-q_eNjjqwztA-1; Sun,
 23 Jun 2024 22:45:54 -0400
X-MC-Unique: EpZqdHUWMp-q_eNjjqwztA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5198619560BF;
	Mon, 24 Jun 2024 02:45:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 961B33000218;
	Mon, 24 Jun 2024 02:45:43 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: [PATCH V2 2/3] virtio: export virtio_config_{enable|disable}()
Date: Mon, 24 Jun 2024 10:45:22 +0800
Message-ID: <20240624024523.34272-3-jasowang@redhat.com>
In-Reply-To: <20240624024523.34272-1-jasowang@redhat.com>
References: <20240624024523.34272-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patch exports virtio_config_enable() and virtio_config_disable()
for drivers to disable config callbacks.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c | 6 ++++--
 include/linux/virtio.h  | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index d3aa74b8ae5d..a4622a62aac3 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -143,14 +143,15 @@ void virtio_config_changed(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_config_changed);
 
-static void virtio_config_disable(struct virtio_device *dev)
+void virtio_config_disable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
 	--dev->config_enabled;
 	spin_unlock_irq(&dev->config_lock);
 }
+EXPORT_SYMBOL_GPL(virtio_config_disable);
 
-static void virtio_config_enable(struct virtio_device *dev)
+void virtio_config_enable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
 
@@ -165,6 +166,7 @@ static void virtio_config_enable(struct virtio_device *dev)
 
 	spin_unlock_irq(&dev->config_lock);
 }
+EXPORT_SYMBOL_GPL(virtio_config_enable);
 
 void virtio_add_status(struct virtio_device *dev, unsigned int status)
 {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 4496f9ba5d82..bc5e408582c9 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -163,6 +163,9 @@ void __virtqueue_break(struct virtqueue *_vq);
 void __virtqueue_unbreak(struct virtqueue *_vq);
 
 void virtio_config_changed(struct virtio_device *dev);
+
+void virtio_config_disable(struct virtio_device *dev);
+void virtio_config_enable(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
-- 
2.31.1


