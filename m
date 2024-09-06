Return-Path: <netdev+bounces-125922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D3C96F45F
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E427285DE1
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903101CBEBC;
	Fri,  6 Sep 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vBB1SK9q"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB5266AB
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626220; cv=none; b=K545CqGHYhCdTxLr5Q7uiQk0Xx21FbRQ1FVNHIXCLgf9nuCJ+SbEvUxUvAzjdnZzRm71J5d8o+Zdht/uzdPuJ495zm6b1vy157C/iVisshz+EXVViFRtkUJr/n+sd8HTLzYtot2YiJsWNHGj6Q9rd9v0HdifdDbo4UvWmKwyoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626220; c=relaxed/simple;
	bh=FWFSewh1d/KHfNw81JqqBTxAG8A9BX3IRoIrq0QfBnc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VrodRAT11IixYI4uXr4dZNlux1wkdqiMcjMW6VjzZRLHEkAJRYYeI8aqINPfNmlH7LAhkYitZA0ZK5NVfTCTa4MWWNVHg1Pl8z+QTnUqh4BGzXu8PJHFCxuo8hCNR1Zu8IbmSGD8B0vL7K9yAkGmwH5+p5oK8K2u+eQ4EXgHQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vBB1SK9q; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725626215; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=V7Xi84uKBuBdD+mPN+ES0YH/6Sdrpj2J3QNAmdHmkpQ=;
	b=vBB1SK9qCdo0WsCsVwC55urg+wTSqjH18eJ1f0PrfM0353eWY8u4oY8EwRJMXps2oVGMgrHGc29D9u8ofxvURFf5BA78GHP1SQ2QO4rn8afAX2h7Gzd2ElWQK+z/q+H0vn6w+PLfoMs1M4iTgY79ZyfwFLVJQZZjXk0FyxzWiKQ=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEPWJ4v_1725625897)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 20:31:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Darren Kenny <darren.kenny@oracle.com>,
	"Si-Wei Liu" <si-wei.liu@oracle.com>
Subject: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by default"
Date: Fri,  6 Sep 2024 20:31:34 +0800
Message-Id: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: ccfd5e625b8b
Content-Transfer-Encoding: 8bit

Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com

I still think that the patch can fix the problem, I hope Darren can re-test it
or give me more info.

    http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com

If that can not work or Darren can not reply in time, Michael you can try this
patch set.

Thanks.

Xuan Zhuo (3):
  Revert "virtio_net: rx remove premapped failover code"
  Revert "virtio_net: big mode skip the unmap check"
  virtio_net: disable premapped mode by default

 drivers/net/virtio_net.c | 95 +++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 49 deletions(-)

--
2.32.0.3.g01195cf9f


