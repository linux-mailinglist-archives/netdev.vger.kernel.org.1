Return-Path: <netdev+bounces-194373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 379FFAC91CF
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 418337AF7F1
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ED5219A70;
	Fri, 30 May 2025 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M//w8a1y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FA11891A9
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616593; cv=none; b=i5kztI7d10HqAeLGxESdjLRVzXMZWYfxPo2w5cAKKsLo9jqg9Atuc2yg6slFVsNwBZ3d5tUBaxUCqYbTOVoUdo6R3fG7ggnIcrHPtxnqTgT5zVz0RK4WHfqV3JHQfCMbKIphMSrGn4RSnlNhbpEmPZ+mHSqDy5iphWHteIqf0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616593; c=relaxed/simple;
	bh=ehmZ4NH3Obtgkv5iJfkdGxmJL3M4QaLW9QinIbTpn9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oi/tcBlOv6WmeQ9cI/aOIpE/qaV/Fgk32EFZplNXh45zUw3T9aH347vbvAQpicoWIjqvdr4KQ1Hytpm0gpjOGK8awOhcUisQW0Oygn+ry6d+PomMt5nZxCLWmiB/8bmxtWccPiSkimj7KfZiiR//vh5VkWvdS1HYm5pSNl0Qz9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M//w8a1y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748616590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wr0pI3dZAOnu65cCryxOvI1jpWJUhQ3oysWjRfvnZCk=;
	b=M//w8a1yWWpHT6yMAWiGJv6slGyTw3tf0ly2QfR73zD/DDL3sQjnTqZZ0LE7TWrcHkQZgO
	llz2fxFMng+jHHyXkXtXFoW5FL14VBWt2DSHzaMqGVAp0MfhdLV+cIQeQjyVVKE4ftfhMU
	C9dyLsVdxKLM/2l5XCeSr+zZMQ28nvk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-4ycgEWxiPgOsFN69uQRfUw-1; Fri,
 30 May 2025 10:49:48 -0400
X-MC-Unique: 4ycgEWxiPgOsFN69uQRfUw-1
X-Mimecast-MFC-AGG-ID: 4ycgEWxiPgOsFN69uQRfUw_1748616586
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23DCD19560AD;
	Fri, 30 May 2025 14:49:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.184])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE50F1956066;
	Fri, 30 May 2025 14:49:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH v2 0/8] virtio: introduce GSO over UDP tunnel
Date: Fri, 30 May 2025 16:49:16 +0200
Message-ID: <cover.1748614223.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Some virtualized deployments use UDP tunnel pervasively and are impacted
negatively by the lack of GSO support for such kind of traffic in the
virtual NIC driver.

The virtio_net specification recently introduced support for GSO over
UDP tunnel, this series updates the virtio implementation to support
such a feature.

Currently the kernel virtio support limits the feature space to 64,
while the virtio specification allows for a larger number of features.
Specifically the GSO-over-UDP-tunnel-related virtio features use bits
65-69.

The first four patches in this series rework the virtio and vhost
feature support to cope with up to 128 bits. The limit is arch-dependent:
only arches with native 128 integer support allow for the wider feature
space.

This implementation choice is aimed at keeping the code churn as
limited as possible. For the same reason, only the virtio_net driver is
reworked to leverage the extended feature space; all other
virtio/vhost drivers are unaffected, but could be upgraded to support
the extended features space in a later time.

The last four patches bring in the actual GSO over UDP tunnel support.
As per specification, some additional fields are introduced into the
virtio net header to support the new offload. The presence of such
fields depends on the negotiated features.

New helpers are introduced to convert the UDP-tunneled skb metadata to
an extended virtio net header and vice versa. Such helpers are used by
the tun and virtio_net driver to cope with the newly supported offloads.

Tested with basic stream transfer with all the possible permutations of
host kernel/qemu/guest kernel with/without GSO over UDP tunnel support.

--
v1 -> (rfc) v2:
  - fix build failures
  - many comment clarification
  - changed the vhost_net ioctl API
  - fixed some hdr <> skb helper bugs
v1: https://lore.kernel.org/netdev/cover.1747822866.git.pabeni@redhat.com/

Paolo Abeni (8):
  virtio: introduce virtio_features_t
  virtio_pci_modern: allow configuring extended features
  vhost-net: allow configuring extended features
  virtio_net: add supports for extended offloads
  net: implement virtio helpers to handle UDP GSO tunneling.
  virtio_net: enable gso over UDP tunnel support.
  tun: enable gso over UDP tunnel support.
  vhost/net: enable gso over UDP tunnel support.

 drivers/net/tun.c                      |  77 ++++++++--
 drivers/net/tun_vnet.h                 |  74 ++++++++--
 drivers/net/virtio_net.c               | 104 ++++++++++++--
 drivers/vhost/net.c                    |  71 ++++++++-
 drivers/vhost/vhost.h                  |   2 +-
 drivers/virtio/virtio.c                |  14 +-
 drivers/virtio/virtio_debug.c          |   2 +-
 drivers/virtio/virtio_pci_modern.c     |   6 +-
 drivers/virtio/virtio_pci_modern_dev.c |  44 +++---
 include/linux/virtio.h                 |   5 +-
 include/linux/virtio_config.h          |  32 +++--
 include/linux/virtio_features.h        |  27 ++++
 include/linux/virtio_net.h             | 191 +++++++++++++++++++++++--
 include/linux/virtio_pci_modern.h      |  10 +-
 include/uapi/linux/if_tun.h            |   9 ++
 include/uapi/linux/vhost.h             |   7 +
 include/uapi/linux/vhost_types.h       |   5 +
 include/uapi/linux/virtio_net.h        |  33 +++++
 18 files changed, 621 insertions(+), 92 deletions(-)
 create mode 100644 include/linux/virtio_features.h

-- 
2.49.0


