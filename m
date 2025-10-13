Return-Path: <netdev+bounces-228656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A022BD12A1
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 04:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770BD1890705
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 02:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDC22727F0;
	Mon, 13 Oct 2025 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kaZS73YF"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B3F26F2AE
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760321203; cv=none; b=b16rtF4T3OXingDyy17WsTs7wKHbppONckML0bpC0PZiBN0x9eA/WfgvW06EdAHp9ZhQVq1ACp0Vi/ee8UyAg2WhshFYYUAAodZXsBcV798aaf4KBEyZso7PlQAWto3Sr/BcpnSCxs0OGLxY9qnI3Qg8fx6ZdHfnlYHwvYisf6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760321203; c=relaxed/simple;
	bh=JQeci8kKFhUqNqSiKukDhGQ1oMGj2u2fkEVG4LJqWeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jJQfIimIk30iJAx5jT2L1MOLN+ooZ+uET8z0+RPw2NRYHpaFoBj91ng64liywrc8Gr9U4CwToKdpvPlYZFsvC67kod2XN5DB0/EVvM5NryPM9z5fiQEF4f46xnwS+64NHF/4v1ol1U6D4KR6lLqgE8ovMQ1aUFPT8N941sRkA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kaZS73YF; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760321190; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0KMzj+miCiTqLWcLN1eA5YLqErPlKnWHSP2dVaYTGYY=;
	b=kaZS73YF8v46d70p20GjH17QZTcXE+Ufwl32MutEHFoycV1cPrEqeYl05CKhxvujl3lHuUKwEz8o0HcCdLrzKlT9CzJNXCuIoraSSX7K78EScgMBmYDb1RQFMH91GJf7E+mdJo6nXKmD0gmO64nj4i3aQ/X3ETWvULiiubuL9Dg=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WpzsXhN_1760321189 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Oct 2025 10:06:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v2 0/3] fixes two virtio-net related bugs.
Date: Mon, 13 Oct 2025 10:06:26 +0800
Message-Id: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 06377f1ca66f
Content-Transfer-Encoding: 8bit

As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuanzhuo@linux.alibaba.com
Commit #1 Move the flags into the existing if condition; the issue is that it introduces a
small amount of code duplication.

Commit #3 is new to fix the hdr len in tunnel gso feature.

Hi @Paolo Abenchi,
Could you please test commit #3? I don't have a suitable test environment, as
QEMU doesn't currently support the tunnel GSO feature.

Thanks.

Xuan Zhuo (3):
  virtio-net: fix incorrect flags recording in big mode
  virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
  virtio-net: correct hdr_len handling for tunnel gso

 drivers/net/virtio_net.c   | 16 ++++++++-----
 include/linux/virtio_net.h | 46 ++++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 12 deletions(-)

--
2.32.0.3.g01195cf9f


