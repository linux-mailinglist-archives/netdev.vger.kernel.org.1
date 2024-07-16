Return-Path: <netdev+bounces-111635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F01931E55
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 03:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC74A283616
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055CA17C2;
	Tue, 16 Jul 2024 01:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vv5nPbQY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE4EAD24
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092444; cv=none; b=eGWnOXR0eqh8wLY69mP2Rl0px86p8Yr1PO4ZCU9a+1bnh7Es0cC75LF7dEq/hMbftczSvAOCGsRJqehkgfQmuc4rR9XXyZMOgSJLgY4TgatxT5qRmrPhm1lOjl9QNkIrQus1/yurGr1QFTUU+BevL/6ZJMQuMn6+Hfv9Db0Fl4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092444; c=relaxed/simple;
	bh=XAhDF83vqJsPZMASvYCb/PJ0ckPj92m1HBGXftr3NW0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HN5GLFWC0Jc09jE5mw4QhFx0duaVQ2NWkuTOLVBqu4plvlNvr1Z+Erw9AbMuww+E2+Fgk0CniRwD11N6GEMuFh9CZc0CEmjhv1kG5jM4UU1P18Oq8U7wskAFiEXMeU6l0baIednFOpQKqagq4DLkvlwYV3Zx4mXtcga+Sy7O0kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vv5nPbQY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721092441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SHlgMgT9UBt4PrV/SgTuYZQey7Svi/OASjw1leV6MUM=;
	b=Vv5nPbQYKZQrvCMCWHprzlqZVza37ArdFOj1GA3Ib3NdzJCIFLCLqzJ0n+XTMMahVYjBla
	RQLnYoHTwHZa5zjClP5D1ZMCqIIZlzOoCMTJoGJxMwV8tqIwDkHoKjKzd1LfxGU7nLKV5g
	tb8NWdiP9Q4ZRtVC1auoGH//XvrjjZ8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-iVi_21hKO0ersLd0W02VyA-1; Mon,
 15 Jul 2024 21:13:59 -0400
X-MC-Unique: iVi_21hKO0ersLd0W02VyA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 343171955D42;
	Tue, 16 Jul 2024 01:13:58 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E45219560B2;
	Tue, 16 Jul 2024 01:13:53 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	netdev@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [RFC v2] virtio-net: check the mac address for vdpa device
Date: Tue, 16 Jul 2024 09:13:49 +0800
Message-ID: <20240716011349.821777-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When using a VDPA device, it is important to ensure that the MAC address
in the hardware matches the MAC address from the QEMU command line.

There are only two acceptable situations:
1. The hardware MAC address is the same as the MAC address specified in the QEMU
command line, and both MAC addresses are not 0.
2. The hardware MAC address is not 0, and the MAC address in the QEMU command line is 0.
In this situation, the hardware MAC address will overwrite the QEMU command line address.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9c7e85caea..8f79785f59 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -178,8 +178,8 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
          * correctly elsewhere - just not reported by the device.
          */
         if (memcmp(&netcfg.mac, &zero, sizeof(zero)) == 0) {
-            info_report("Zero hardware mac address detected. Ignoring.");
-            memcpy(netcfg.mac, n->mac, ETH_ALEN);
+          error_report("Zero hardware mac address detected in vdpa device. "
+                       "please check the vdpa device!");
         }
 
         netcfg.status |= virtio_tswap16(vdev,
@@ -3579,12 +3579,42 @@ static bool failover_hide_primary_device(DeviceListener *listener,
     /* failover_primary_hidden is set during feature negotiation */
     return qatomic_read(&n->failover_primary_hidden);
 }
+static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
+                                      MACAddr *cmdline_mac, Error **errp) {
+  struct virtio_net_config hwcfg = {};
+  static const MACAddr zero = {.a = {0, 0, 0, 0, 0, 0}};
 
+  vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg, ETH_ALEN);
+
+  /* For VDPA device: Only two situations are acceptable:
+   * 1.The hardware MAC address is the same as the QEMU command line MAC
+   *   address, and both of them are not 0.
+   * 2.The hardware MAC address is NOT 0, and the QEMU command line MAC address
+   *   is 0. In this situation, the hardware MAC address will overwrite the QEMU
+   *   command line address.
+   */
+
+  if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) != 0) {
+    if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) == 0) ||
+        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) == 0)) {
+      /* overwrite the mac address with hardware address*/
+      memcpy(&n->mac[0], &hwcfg.mac, sizeof(n->mac));
+      memcpy(&n->nic_conf.macaddr, &hwcfg.mac, sizeof(n->mac));
+
+      return true;
+    }
+  }
+  error_setg(errp, "vdpa hardware mac != the mac address from "
+                   "qemu cmdline, please check the the vdpa device's setting.");
+
+  return false;
+}
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIONet *n = VIRTIO_NET(dev);
     NetClientState *nc;
+    MACAddr macaddr_cmdline;
     int i;
 
     if (n->net_conf.mtu) {
@@ -3692,6 +3722,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     virtio_net_add_queue(n, 0);
 
     n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
+    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
     qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
     memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
     n->status = VIRTIO_NET_S_LINK_UP;
@@ -3739,10 +3770,10 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     nc->rxfilter_notify_enabled = 1;
 
    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
-        struct virtio_net_config netcfg = {};
-        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
-        vhost_net_set_config(get_vhost_net(nc->peer),
-            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
+     if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline, errp)) {
+       virtio_cleanup(vdev);
+       return;
+     }
     }
     QTAILQ_INIT(&n->rsc_chains);
     n->qdev = dev;
-- 
2.45.0


