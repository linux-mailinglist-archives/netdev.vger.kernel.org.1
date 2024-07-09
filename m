Return-Path: <netdev+bounces-110142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8772C92B1B8
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F4C1C2101C
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B03D1514F8;
	Tue,  9 Jul 2024 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhmWjem1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA81D556
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512163; cv=none; b=plXpGpYprSSidmEpkb1Z7/tz1vNdlENBGFmT0e3zYNjFnOPsVaxRQQsTo5rpIxA1tj1Ns8YpBGUOcG+VlljvF3gh/hL5+uaMXYAnHsqF2PszaVT50ph6+bNPg3DVj9asOmaxF8NQYAj1CN/1HWvU1vt5qts3cUiPw192/0yDTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512163; c=relaxed/simple;
	bh=8bjvqhIUHv06pwEVOdLngXv4a3q5jy3kMHzCrcTRqSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DNNCtOrEhkUg2stOv/84y+oCsjo8tR9jQNCdAxQt/AHwMG7OsXpGpiN27hliNT3goJ414tEF23Tl/IMpGrHMwom4l7b10MxND8OMxZpxs1U1eGuYzLSDW66l4VYQX9r/g32Dybp6LhmfVScAyxZ610Xj3F9u2OfLGA5aut+OwBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EhmWjem1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720512160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z2XY86t79jfijXCYuzeepS/qeKvZxJClxQpdTwloLiQ=;
	b=EhmWjem14uhigufXG7VHs0R/j59pFVnDb4P8GdQnPUHUHUbGoGhqr+140pM7w2DgTo3J58
	wYYg9Ft4vuhWN0wCNpfrcu2W2n7lXZ1MxgMSkskpGMhmS0AGxrJeJVewqZpU+wKFVihHun
	EuFpLRRcJaTmMqWOWeoIRcIdaYMfC7U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-qB1dxj1HP-SbrUjy8u08Zw-1; Tue,
 09 Jul 2024 04:02:34 -0400
X-MC-Unique: qB1dxj1HP-SbrUjy8u08Zw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4142A1936185;
	Tue,  9 Jul 2024 08:02:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.184])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64E9E3000184;
	Tue,  9 Jul 2024 08:02:25 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 0/3] virtio-net: synchronize op/admin state
Date: Tue,  9 Jul 2024 16:02:11 +0800
Message-ID: <20240709080214.9790-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi All:

This series tries to synchronize the operstate with the admin state
which allows the lower virtio-net to propagate the link status to the
upper devices like macvlan.

This is done by toggling carrier during ndo_open/stop.

Changes since V2:

- introduce config_driver_disabled and helpers
- schedule config change work unconditionally

Jason Wang (3):
  virtio: rename virtio_config_enabled to virtio_config_core_enabled
  virtio: allow driver to disable the configure change notification
  virtio-net: synchronize operstate with admin state on up/down

 drivers/net/virtio_net.c | 64 ++++++++++++++++++++++++----------------
 drivers/virtio/virtio.c  | 59 ++++++++++++++++++++++++++++--------
 include/linux/virtio.h   | 11 +++++--
 3 files changed, 93 insertions(+), 41 deletions(-)

-- 
2.31.1


