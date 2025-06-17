Return-Path: <netdev+bounces-198733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1346EADD5C1
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D711F402C48
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932B2EF2AF;
	Tue, 17 Jun 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJ+GtD+V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B905E2ED161
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176769; cv=none; b=mLh/kLnAu0Rgz4pgtB8j0yKFFMiHF3R2uImw0heDEj6QiwCNFRGFA7ryGFAySaYvipRtWIkhLy6DIjxpod//4Y0rA1Av1ONg1NlfNV9yqSHcZERSeDwOtPqGa3QvpJu4Z3BDyMSuJdhezDFLFkuWVAhYsR3q6tb2SIQJMIIrj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176769; c=relaxed/simple;
	bh=Q6IU7MahY0AJ7EHn5wDiKte0GfMwA8ixOozEWfqowhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cY6zVtZugYHuJ8J890r9TF+GuYyDQHx6WYJjPUNNpvEqOyl0GFuyJi+7BlHoPY1DzFcNvxyCwGUfdYOc6fJfowKQh8qp4PcBUgL85qYiyGYhEKfQrWWR63uarsIZE1s6IzscksDQxojIhTl1ND1/iE9/FkMWRMWdixcBYlrWBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJ+GtD+V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750176766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zexs8K/QpVyKUlBp9EBZI/iuw73u6oXS3jY4YqwIY10=;
	b=HJ+GtD+V7h4Bb5pTcfFp0EBVtUIruDS03Y31uFEfSCJP0YWWHNiPYQB9r9liqMFp/5C5gp
	oT5PaqWnnDPzH8h6p3QN9sm+D2v4bIUrDCeLL4JLhAXEo8x6DBQ1pE0XVEJdZFR9FAKgXH
	d9bxSg51cQsCLOLz/yUBoHzo8VvtDRg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-VfZ7-ShnM8-j080RnRZLRg-1; Tue,
 17 Jun 2025 12:12:43 -0400
X-MC-Unique: VfZ7-ShnM8-j080RnRZLRg-1
X-Mimecast-MFC-AGG-ID: VfZ7-ShnM8-j080RnRZLRg_1750176759
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 954F418089B5;
	Tue, 17 Jun 2025 16:12:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.2])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6833B195E346;
	Tue, 17 Jun 2025 16:12:33 +0000 (UTC)
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
Subject: [PATCH v4 net-next 0/8] virtio: introduce GSO over UDP tunnel
Date: Tue, 17 Jun 2025 18:12:07 +0200
Message-ID: <cover.1750176076.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
feature support to cope with up to 128 bits. The limit is set by
a define and could be easily raised in future, as needed.

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

---
v3 -> v4:
  - vnet sockopt cleanup
  - fixed offset for UDP-tunnel related field
  - use dev->features instead of flags
v3: https://lore.kernel.org/netdev/cover.1749210083.git.pabeni@redhat.com/

v2 -> v3:
  - uint128_t -> u64[2]
  - dropped related ifdef
  - define and use vnet_hdr with tunnel layouts
v2: https://lore.kernel.org/netdev/cover.1748614223.git.pabeni@redhat.com/

v1 -> v2:
  - fix build failures
  - many comment clarification
  - changed the vhost_net ioctl API
  - fixed some hdr <> skb helper bugs
v1: https://lore.kernel.org/netdev/cover.1747822866.git.pabeni@redhat.com/

Paolo Abeni (8):
  virtio: introduce extended features
  virtio_pci_modern: allow configuring extended features
  vhost-net: allow configuring extended features
  virtio_net: add supports for extended offloads
  net: implement virtio helpers to handle UDP GSO tunneling.
  virtio_net: enable gso over UDP tunnel support.
  tun: enable gso over UDP tunnel support.
  vhost/net: enable gso over UDP tunnel support.

 drivers/net/tun.c                      |  70 +++++++--
 drivers/net/tun_vnet.h                 |  88 +++++++++--
 drivers/net/virtio_net.c               | 109 +++++++++++---
 drivers/vhost/net.c                    |  95 +++++++++---
 drivers/vhost/vhost.c                  |   2 +-
 drivers/vhost/vhost.h                  |   4 +-
 drivers/virtio/virtio.c                |  43 +++---
 drivers/virtio/virtio_debug.c          |  27 ++--
 drivers/virtio/virtio_pci_modern.c     |  10 +-
 drivers/virtio/virtio_pci_modern_dev.c |  69 +++++----
 include/linux/virtio.h                 |   5 +-
 include/linux/virtio_config.h          |  41 +++---
 include/linux/virtio_features.h        |  88 +++++++++++
 include/linux/virtio_net.h             | 196 ++++++++++++++++++++++++-
 include/linux/virtio_pci_modern.h      |  43 +++++-
 include/uapi/linux/if_tun.h            |   9 ++
 include/uapi/linux/vhost.h             |   7 +
 include/uapi/linux/vhost_types.h       |   5 +
 include/uapi/linux/virtio_net.h        |  33 +++++
 19 files changed, 780 insertions(+), 164 deletions(-)
 create mode 100644 include/linux/virtio_features.h

-- 
2.49.0


