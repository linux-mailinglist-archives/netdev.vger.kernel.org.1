Return-Path: <netdev+bounces-180462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA42A81631
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB98189C42C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68162253F19;
	Tue,  8 Apr 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQBLpOff"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE7253B76
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142407; cv=none; b=eaP20xtdbbu9avVlYfrf+L1mKE9e4nErwzF9HhYwuoJ4Lrncj5odKKlZ58HZczLMNkJhox0PihmtbgrQQLoRz6WSDWecHtR5+2JCqpNb/dT3kK7oNH/dtvBlyRj4mrgluURvgXkUkG3nHW62BDr5j0H9ZE4JTRN/XVLmjUlli/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142407; c=relaxed/simple;
	bh=+5jUilXdp5cilnQHDjleeadflLuJ3z6sujLObpIUc5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GlQuBStcFV1sbUhSn+yeHeqzXDD/zz6mR/hpHACDkKQ9QJIGwkrkxhyPOZbK3PLCOMlUiOFelo835jzRfS0J9HEo8DO7E5ap08ti+3IvVyu2UPuQlgPaxUb5+JbQXIm+WWcdbH4j35fGlAqZ22VHfYixmKMPcgKoBKhJciikDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQBLpOff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9EFC4CEE5;
	Tue,  8 Apr 2025 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744142406;
	bh=+5jUilXdp5cilnQHDjleeadflLuJ3z6sujLObpIUc5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=vQBLpOffghxKxh/a29gS+EuIglCNOKgNf0kOBy3FlKgMaeenuUKlWpvpBL3uWaMnO
	 e1153z31KSES6/v2rc1MyI+WLvnDT2KwKDG2ffsor3/m/drRpxe6C5ooJrovpc2nvM
	 x5aZTKqa5TfgbGcOz6e0gCfzuViXTALOVP12SkP+Z51Jr6fJQ+iYWdKzbkm+jWOg6H
	 Ia36XMl7DEnshbVkgFIYcn/gZZWVSLHf8TeeJfLgLZfV+jjyGMzb08KjCxDkqLiAX0
	 pveXCEpwH8YudQrUD/J1+SM5nMYLZEFE/Lb/4ApRJpYuXPA4i5FXncGxs5v2YPvg6I
	 QU1s17YD4gvuA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	hramamurthy@google.com,
	kuniyu@amazon.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/8] net: depend on instance lock for queue related netlink ops
Date: Tue,  8 Apr 2025 12:59:47 -0700
Message-ID: <20250408195956.412733-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev-genl used to be protected by rtnl_lock. In previous release
we already switched the queue management ops (for Rx zero-copy) to
the instance lock. This series converts other ops to depend on the
instance lock when possible.

Unfortunately queue related state is hard to lock (unlike NAPI)
as the process of switching the number of queues usually involves
a large reconfiguration of the driver. The reconfig process has
historically been under rtnl_lock, but for drivers which opt into
ops locking it is also under the instance lock. Leverage that
and conditionally take rtnl_lock or instance lock depending
on the device capabilities.

v2:
 - fix a bug in patch 2
 - reword the doc a tiny bit (patch 7)
v1: https://lore.kernel.org/20250407190117.16528-1-kuba@kernel.org

Jakub Kicinski (8):
  net: avoid potential race between netdev_get_by_index_lock() and netns
    switch
  net: designate XSK pool pointers in queues as "ops protected"
  netdev: add "ops compat locking" helpers
  netdev: don't hold rtnl_lock over nl queue info get when possible
  xdp: double protect netdev->xdp_flags with netdev->lock
  netdev: depend on netdev->lock for xdp features
  docs: netdev: break down the instance locking info per ops struct
  netdev: depend on netdev->lock for qstats in ops locked drivers

 Documentation/networking/netdevices.rst    | 61 +++++++++++++----
 include/linux/netdevice.h                  |  7 +-
 include/net/netdev_lock.h                  | 16 +++++
 include/net/netdev_queues.h                |  4 +-
 include/net/netdev_rx_queue.h              |  6 +-
 include/net/xdp.h                          |  1 +
 net/core/dev.h                             | 17 ++++-
 drivers/net/ethernet/google/gve/gve_main.c |  2 +-
 net/core/dev.c                             | 76 ++++++++++++++++++++--
 net/core/lock_debug.c                      |  2 +-
 net/core/netdev-genl.c                     | 73 ++++++++++-----------
 net/core/xdp.c                             | 12 +++-
 net/xdp/xsk_buff_pool.c                    |  6 +-
 13 files changed, 217 insertions(+), 66 deletions(-)

-- 
2.49.0


