Return-Path: <netdev+bounces-192243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA71ABF1B0
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A428E29E2
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E892405F5;
	Wed, 21 May 2025 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5r8pXKB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EF9238C3A
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823624; cv=none; b=sa8fr4e9vEJCghArtiU4/4ijnoMacvBdGisL3lDfvyAPpy4Dx+EdCt8eXZJyyTSo4HR2qBR553U2lDX3K6WDXrHBsM9VB1PQqxFGXx0TPL6tsH4e9oGK0yhto2qwnNauiC2nnbEt2ZUmSfVNHP/dDKpwiu31lYctCj1RMJN+Gd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823624; c=relaxed/simple;
	bh=2wPxTTukf4tNIuHclPXTgThRMuE/6aouOzoMcxgLgqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNjOWRfGgspirq1LReu5vsjkHWKch055UVXu1xnz/fm5brXcXr8mgHKvtL/8QN02HFgqFFTBtiXmmnGI9RFyDT+TXM5k/yjpNWjvKoAxP7d3mztfIAr434mqWp72orcOFYdE54oYKMUdfwVVWYApJxx9TydbZovj0FfAq58aXJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5r8pXKB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747823621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sfmRmqkxLtoiNMN/JzU9t/DyfeG/mq3+WLIZP+DLS+o=;
	b=Z5r8pXKBX70onYUU7nZ16q9DebGpLCmmgiSu8Q6qaSMn/+5thFYHx6xDUoL68D0r+kSG3a
	tYEGbGj9TwIL5HKCCrKOBG4GtS0S2xd8JqHtjbR5Hu8LC4OOJ5wYI/KJ1CmVB1v9POEUse
	gLw9479vCc458bCtk9ZWQCTGVuYxKNo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-CEtLaI0EMWilwc7FQfQyBw-1; Wed,
 21 May 2025 06:33:38 -0400
X-MC-Unique: CEtLaI0EMWilwc7FQfQyBw-1
X-Mimecast-MFC-AGG-ID: CEtLaI0EMWilwc7FQfQyBw_1747823617
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F8EF1956086;
	Wed, 21 May 2025 10:33:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF02C195608F;
	Wed, 21 May 2025 10:33:32 +0000 (UTC)
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
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net-next 0/8] virtio: introduce GSO over UDP tunnel
Date: Wed, 21 May 2025 12:32:34 +0200
Message-ID: <cover.1747822866.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

A new pair of helpers is introduced to convert the UDP-tunneled skb
metadata to an extended virtio net header and vice versa. Such helpers
are used by the tun and virtio_net driver to cope with the newly
supported offloads.

Tested with basic stream transfer with all the possible permutations of
host kernel/qemu/guest kernel with/without GSO over UDP tunnel support.
Sharing somewhat early to collect feedback, especially on the userland
code.

Paolo Abeni (8):
  virtio: introduce virtio_features_t
  virtio_pci_modern: allow setting configuring extended features
  vhost-net: allow configuring extended features
  virtio_net: add supports for extended offloads
  net: implement virtio helpers to handle UDP GSO tunneling.
  virtio_net: enable gso over UDP tunnel support.
  tun: enable gso over UDP tunnel support.
  vhost/net: enable gso over UDP tunnel support.

 drivers/net/tun.c                      |  77 +++++++++--
 drivers/net/tun_vnet.h                 |  74 +++++++++--
 drivers/net/virtio_net.c               |  99 ++++++++++++--
 drivers/vhost/net.c                    |  32 ++++-
 drivers/vhost/vhost.h                  |   2 +-
 drivers/virtio/virtio.c                |  12 +-
 drivers/virtio/virtio_mmio.c           |   4 +-
 drivers/virtio/virtio_pci_legacy.c     |   2 +-
 drivers/virtio/virtio_pci_modern.c     |   7 +-
 drivers/virtio/virtio_pci_modern_dev.c |  44 +++---
 drivers/virtio/virtio_vdpa.c           |   2 +-
 include/linux/virtio.h                 |   5 +-
 include/linux/virtio_config.h          |  22 +--
 include/linux/virtio_features.h        |  23 ++++
 include/linux/virtio_net.h             | 177 +++++++++++++++++++++++--
 include/linux/virtio_pci_modern.h      |  11 +-
 include/uapi/linux/if_tun.h            |   9 ++
 include/uapi/linux/vhost.h             |   8 ++
 include/uapi/linux/virtio_net.h        |  33 +++++
 19 files changed, 551 insertions(+), 92 deletions(-)
 create mode 100644 include/linux/virtio_features.h

-- 
2.49.0


