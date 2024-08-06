Return-Path: <netdev+bounces-115935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D47C948788
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 04:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF14B1C22225
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 02:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E393BBEB;
	Tue,  6 Aug 2024 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3M8ygwe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742903BBC1
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910962; cv=none; b=ltQz6mM4UD3Yegf/8P/8rZ+psLUpAXRB4jlVBiM2NR/ZVrM85YgWCfnj9P+nBivjbri5RYDbBfuIfNewirsMy4DORKN5Xd4YQ2NclLZQwveIddJjeWBz3JYa1rhsbqO5ENAhESO0AvsDUwJVwf4pdWGOvSztWaDXjwMBSMCmJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910962; c=relaxed/simple;
	bh=IjcxerJ/w6zcO7CVkbRCQGN7PjVXJe410ca6cXuzOXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsVVBjOdOuSGMMRa13ZxNXAisqkMSChVs+2lbJG6Lq+AD9fJI/RpIqQMEglTHBgLaGvT6NQfBG4BurrAOT1vKuq6v1gXRmG8MIob1Z8hRdD/f8fmvd1Uf9SvggKBmZ4U166j201VOXDHc38sXbhFjb0dkXzlqSFzWuJdHwmwBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3M8ygwe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722910959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TcO4aBso1n53Fet0M+rmhmrd08KI6fj16ZgsqCTvwbk=;
	b=f3M8ygweqonBSgbkiFTGn26W5Xzjs6NKf5nud6FZt7303gBIQ8nz07UgZtK9EEcdo1mygQ
	f5gXQFC8rcl7raMqDcI3WCslFVPSPPVk0pFbEIolkbkuTt+5Fs/fyXiR/Vn7+FbWBxIYqq
	5pOTY1fmYLjw3XaJbpr4tPDDAb22JaQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-3iluJ8VwOOGUfcVqimD1kg-1; Mon,
 05 Aug 2024 22:22:36 -0400
X-MC-Unique: 3iluJ8VwOOGUfcVqimD1kg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93CF31955F3B;
	Tue,  6 Aug 2024 02:22:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B21D1956046;
	Tue,  6 Aug 2024 02:22:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	inux-kernel@vger.kernel.org
Subject: [PATCH net-next V6 0/4] virtio-net: synchronize op/admin state
Date: Tue,  6 Aug 2024 10:22:20 +0800
Message-ID: <20240806022224.71779-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi All:

This series tries to synchronize the operstate with the admin state
which allows the lower virtio-net to propagate the link status to the
upper devices like macvlan.

This is done by toggling carrier during ndo_open/stop while doing
other necessary serialization about the carrier settings during probe.

While at it, also fix a race between probe and ndo_set_features as we
didn't initalize the guest offload setting under rtnl lock.

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


