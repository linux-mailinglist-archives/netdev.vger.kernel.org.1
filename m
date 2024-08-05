Return-Path: <netdev+bounces-115610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81767947399
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 05:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296E51F21537
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 03:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7502813D601;
	Mon,  5 Aug 2024 03:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpVbTwpO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0957B182B9
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 03:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826979; cv=none; b=jvLgnjTeYloxS68ATRVPVA5Ufyv/JfRm8B4RS9hwPZ6/7J+txfcwCpYX9Yd/msIL1jCQEIHI3fNUvZBOdv6jRW3IjEA/LGgHOJd0YR4YW4O6aUEFin4hLQdy8rZnzsrRAR4uCWc6PI1/9vwKric45g64cdBzzRX+3QE5aOZLuUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826979; c=relaxed/simple;
	bh=5dr/8qs5h7pdy8IfUnP/ccKUbDAJxoGnXgTuvngNu3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABcMWUIkMwZvjqzwWTy3GfMbbwUKGwj0paAQgJr3UrIiSoAClV/1POrrXoCUN0IkDqdaArUxJpTLc9Lfp4zKPaTmrBKsE2ImO2sjO4h9pptbxwTrCXGtwA+0xLYXqs/d91uIWd63zjahRw03xzPaa4+jZRw7xl2kE+uOubpvmyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpVbTwpO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722826975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vRSJbvt9Xno4HQ+FF7Ox7Cv6zCHsE4rFrOSu4uzrS/k=;
	b=fpVbTwpOQRBaq6+mr4j+GPJMPSJalddYyVBQ44/SurPQfKPchoJIPBO/esphjCOEO4CkDk
	27Yw4/PPv3xrQu4e4LpFEKxI/sWXPE7zTR0fSNmxCcaQfPeJ7UmkQxotRAkCjtvEo25SoQ
	xrA7pJyV3vK1GoS8/gZlT6auNR+3V2g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-8YqSn8GoME2eKyYOWe_PjQ-1; Sun,
 04 Aug 2024 23:02:54 -0400
X-MC-Unique: 8YqSn8GoME2eKyYOWe_PjQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CA7719560AD;
	Mon,  5 Aug 2024 03:02:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.218])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 588E21955F40;
	Mon,  5 Aug 2024 03:02:45 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 net-next 0/3] virtio-net: synchronize op/admin state
Date: Mon,  5 Aug 2024 11:02:39 +0800
Message-ID: <20240805030242.62390-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi All:

This series tries to synchronize the operstate with the admin state
which allows the lower virtio-net to propagate the link status to the
upper devices like macvlan.

This is done by toggling carrier during ndo_open/stop while doing
other necessary serialization about the carrier settings during probe.

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

Jason Wang (3):
  virtio: rename virtio_config_enabled to virtio_config_core_enabled
  virtio: allow driver to disable the configure change notification
  virtio-net: synchronize operstate with admin state on up/down

 drivers/net/virtio_net.c | 78 +++++++++++++++++++++++++---------------
 drivers/virtio/virtio.c  | 59 +++++++++++++++++++++++-------
 include/linux/virtio.h   | 11 ++++--
 3 files changed, 105 insertions(+), 43 deletions(-)

-- 
2.31.1


