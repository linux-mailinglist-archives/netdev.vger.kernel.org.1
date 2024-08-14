Return-Path: <netdev+bounces-118316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE499513CD
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A041C23C71
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 05:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC886026A;
	Wed, 14 Aug 2024 05:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtQI7Pmi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8594D8BA
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 05:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723612969; cv=none; b=L7fWWwVe0uG56KqRaMvheGvR4JoiohdFMcKkfc3PZDVepRhmPkc4fBah70gWQ/rQ3a81v3OdwVpoVVH2mwOajy+GyM2f1C2+Dq0OC3skMSJzRdfuwNb2tQA4k9WL0laU/UGnEUIIR05x/SGh1P87U/x0kuez+yXfMFYSj4+lqS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723612969; c=relaxed/simple;
	bh=IOCRvGR8JTbHqufXojjCfbAeFcEmkXITGBm9jIc66Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FAczWGRVwm2mxlbNM+TnvMuN9E8DAIYUXj85F8VBAHVVmzDxYQH+7nZd3e9gisqbzkJ7Pk2UQmgX4jy0INcOcA4+Wk3lDfM3IvvZqJZQxCtB6a+jtHInEUZMZvzyPCvtulz/gk+bm2N5MLsA9k+b3G2VLEACmf3htgL0BVwrcWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BtQI7Pmi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723612965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iLnxfC0hbO2g1lDT29unWn+v2IZLR7S+7ro5YQTLaS8=;
	b=BtQI7PmicKnM3chtQeBgeSditttNX0IbgwgICK9BgpCFwtaR9mlyMtGVG1MX0R2DZTv5Xt
	Vr3QV2OEJUlY5pN4bHVWyQ2Bq1AYGgtZB0QCCLqt/HyCEufSlZYNoV0PFGc5LZAiN3jadi
	UV/RiX9xft3qPq14VzGxpVsh8OBDPZo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-iJ2CRsz3MQ6S2iZsqyXiig-1; Wed,
 14 Aug 2024 01:22:41 -0400
X-MC-Unique: iJ2CRsz3MQ6S2iZsqyXiig-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 331401955F40;
	Wed, 14 Aug 2024 05:22:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.38])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AC3B1944A95;
	Wed, 14 Aug 2024 05:22:31 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: [PATCH net-next v7 0/4] virtio-net: synchronize op/admin state
Date: Wed, 14 Aug 2024 13:22:24 +0800
Message-ID: <20240814052228.4654-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi All:

This series tries to synchronize the operstate with the admin state
which allows the lower virtio-net to propagate the link status to the
upper devices like macvlan.

This is done by toggling carrier during ndo_open/stop while doing
other necessary serialization about the carrier settings during probe.

While at it, also fix a race between probe and ndo_set_features as we
didn't initalize the guest offload setting under rtnl lock.

Changes since V6:

- Add fix tag

Changes since V5:

- Fix sevreal typos
- Include a new patch to synchronize probe with ndo_set_features

Changes since V4:

- do not update settings during ndo_open()
- do not try to canel config noticiation during probe() as core make
  sure the config notificaiton won't be triggered before probe is
  done.
- Tweak sevreal comments.

Changes since V3:

- when driver tries to enable config interrupt, check pending
  interrupt and execute the nofitication change callback if necessary
- do not unconditonally trigger the config space read
- do not set LINK_UP flag in ndo_open/close but depends on the
  notification change
- disable config change notification until ndo_open()
- read the link status under the rtnl_lock() to prevent a race with
  ndo_open()

Changes since V2:

- introduce config_driver_disabled and helpers
- schedule config change work unconditionally

Thanks


Jason Wang (4):
  virtio: rename virtio_config_enabled to virtio_config_core_enabled
  virtio: allow driver to disable the configure change notification
  virtio-net: synchronize operstate with admin state on up/down
  virtio-net: synchronize probe with ndo_set_features

 drivers/net/virtio_net.c | 78 +++++++++++++++++++++++++---------------
 drivers/virtio/virtio.c  | 59 +++++++++++++++++++++++-------
 include/linux/virtio.h   | 11 ++++--
 3 files changed, 105 insertions(+), 43 deletions(-)

-- 
2.31.1


