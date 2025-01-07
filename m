Return-Path: <netdev+bounces-155914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F683A04595
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3710E16585D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBA71F3D4F;
	Tue,  7 Jan 2025 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTbTGN4w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578B71F3D2D
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266134; cv=none; b=a8UmMTfRrnZ0KKHQwDUlpjDLY2I//W+Wq+qDRhPzo70zbHGCpjh6r3AAwEC59Gzi0+oODhXaLLAKGmV5CO9kvUQ+mdcof22US6qD64x3L4e2CEl/UGs6/PRrn9B8TH5ADDhu47ks7DaI5ya9n9KlpC/+Y881Y//feLkc4mkUVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266134; c=relaxed/simple;
	bh=HRri+NudJf8dDW15sQlv84v7pk7YnwTq1Bl1KZ5p2vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NNHKzdt+GC9GYgrtx0gvE+1rEiudvyDK0fZcn1JGD1aDVxSHCxJ8sLFEqfDMsW787dWrp+QT4zqXGA0z/05wQlLiHhgezy1+h66Z3hD3gL0CE19zpbKbH5T8S3K08KWttzFOYHUtI814h0rcmDZIkv75wzAAkBkqd17hecH5aWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTbTGN4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79757C4CED6;
	Tue,  7 Jan 2025 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736266133;
	bh=HRri+NudJf8dDW15sQlv84v7pk7YnwTq1Bl1KZ5p2vg=;
	h=From:To:Cc:Subject:Date:From;
	b=MTbTGN4wH8TAEu1I2rw3uT7y330/Yybttj3dj5Wdp3+cr5RJ2Gbs/i7YOnm8yTJ94
	 hD7KdAam/b/UCONM3Hm+ff7AWqckIptUGMI7x+tEJr/r/JvsAGvy8wCA/v6rriAyij
	 gWyRb+sVxFpE33h6EcS5TedOzoIp4XlIlvx4wFhTSN+2V0HOiaURYOU5esJjijKf+l
	 da+zHpdAiUrKIFB4EcJOzlkOCrG5+KnmnbAJeHABs/CDKOKy4aVS+w1Sln/RelL/fu
	 RGLf+GeJo9ZfqcSkC/KnGKLpxrLYgVqTnAhM84Waarc4gcqrXg77Svdur5ozcAxncc
	 tvJtYPpr/G19A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/8] net: make sure we retain NAPI ordering on netdev->napi_list
Date: Tue,  7 Jan 2025 08:08:38 -0800
Message-ID: <20250107160846.2223263-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I promised Eric to remove the rtnl protection of the NAPI list,
when I sat down to implement it over the break I realized that
the recently added NAPI ID retention will break the list ordering
assumption we have in netlink dump. The ordering used to happen
"naturally", because we'd always add NAPIs that the head of the
list, and assign a new monotonically increasing ID.

Before the first patch of this series we'd still only add at
the head of the list but now the newly added NAPI may inherit
from its config an ID lower than something else already on the list.

The fix is in the first patch, the rest is netdevsim churn to test it.
I'm posting this for net-next, because AFAICT the problem can't
be triggered in net, given the very limited queue API adoption.

v2:
 - [patch 2] allocate the array with kcalloc() instead of kvcalloc()
 - [patch 2] set GFP_KERNEL_ACCOUNT when allocating queues
 - [patch 6] don't null-check page pool before page_pool_destroy()
 - [patch 6] controled -> controlled
 - [patch 7] change mode to 0200
 - [patch 7] reorder removal to be inverse of add
 - [patch 7] fix the spaces vs tabs
v1: https://lore.kernel.org/20250103185954.1236510-1-kuba@kernel.org

Jakub Kicinski (8):
  net: make sure we retain NAPI ordering on netdev->napi_list
  netdev: define NETDEV_INTERNAL
  netdevsim: support NAPI config
  netdevsim: allocate rqs individually
  netdevsim: add queue alloc/free helpers
  netdevsim: add queue management API support
  netdevsim: add debugfs-triggered queue reset
  selftests: net: test listing NAPI vs queue resets

 Documentation/networking/netdevices.rst  |  10 +
 drivers/net/netdevsim/netdev.c           | 259 ++++++++++++++++++++---
 drivers/net/netdevsim/netdevsim.h        |   5 +-
 net/core/dev.c                           |  42 +++-
 net/core/netdev_rx_queue.c               |   1 +
 tools/testing/selftests/net/nl_netdev.py |  19 +-
 6 files changed, 294 insertions(+), 42 deletions(-)

-- 
2.47.1


