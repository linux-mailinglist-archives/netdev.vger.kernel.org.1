Return-Path: <netdev+bounces-179874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73A4A7ECF1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FDD16D716
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58F5222594;
	Mon,  7 Apr 2025 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4GOZ7EX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15DF1FF5F7
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052478; cv=none; b=I+htq92lb1kGwa8m6LSgaJqj5+Jml06gHS7+31bZ8nuvK7l45C2wRJk3fXHHmRdJVRsyK7bqHwsyNkvkEoUHIBMb+WDwNjuvtyYzYgpQM4kQrsd1U0ynUj5h2hxCwHJyzYUqJXX4aNx+Nh44aehzYlUoRg2igjkMoyRjCpogE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052478; c=relaxed/simple;
	bh=H7RO+tBlbH/rY9ZVTsrsvfbmIr3dWDkrkv5REdmbfCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pP12xD/SvG4w1mUfM5w6xNzec9aOv1PzS4WXcBU4g0Q2i1xLT7I6cjU048KaF01MtDTOM35WtQJH6TgasJHsEXJeCRj9aPOlb6Qk+t+1F8yEa03LBKWlWpU40EjDzZLUiQ/R8CkG3I7GTS+H3skTWlxaFTPLgBqA5Lab6Ajpyug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4GOZ7EX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF1BC4CEDD;
	Mon,  7 Apr 2025 19:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052478;
	bh=H7RO+tBlbH/rY9ZVTsrsvfbmIr3dWDkrkv5REdmbfCA=;
	h=From:To:Cc:Subject:Date:From;
	b=H4GOZ7EX5GsFEyN7Y1X06BMOiq+6kPsf7bmhAp4IUcBOMAh24MMPVRbJIBzbm+C3p
	 1LClcXWn6M1qt259BQc5oxd6teqosVWtKCk8gucoo5Tt/gebvc2KltCRCyOSSm4AyQ
	 6sAD71/2ajC1+1s6c8pq9cZ6k5ejRAbB8/AqYfWSiaexSDNG6NKtDu4CwMfPmEik4j
	 G8hEPyDwrAlqFAyMC0Ik1E8u26e6/ULk02cN3FW3AyKR50Sr/+u1bs41KfRCkZ9KRb
	 LWhKhVoGtbkbANYcyFNQXCTKOO1BIDhVMJJ0BFGs1gBq5Gmh1CqPBRCKVx47Ht4cIC
	 MPmIFesbU/nUQ==
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
	jdamato@fastly.com
Subject: [PATCH net-next 0/8] net: depend on instance lock for queue related netlink ops
Date: Mon,  7 Apr 2025 12:01:09 -0700
Message-ID: <20250407190117.16528-1-kuba@kernel.org>
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
 net/xdp/xsk.c                              |  2 +
 net/xdp/xsk_buff_pool.c                    |  7 +-
 14 files changed, 220 insertions(+), 66 deletions(-)

-- 
2.49.0


