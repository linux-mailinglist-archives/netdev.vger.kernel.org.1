Return-Path: <netdev+bounces-177254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFD4A6E6B9
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F5D1740C4
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA431EF0A5;
	Mon, 24 Mar 2025 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGOQmU5M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EFA1EF08F
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856350; cv=none; b=PNF3i97ZJrcEXTIxOWTLfC00m6gGJVWzIdTmgZF9zBrg4dM+ge6i9uCbkzCR4aVWb94fC2dtEEX8ZKYu9HRbN/qUHo8EvgNUvuVbqwhi8JwuaElPSB1RYWdA69lvHSle3artDK4hzTSepdq0eTUbSwDb9cGqrSismRVORavjeFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856350; c=relaxed/simple;
	bh=5dOIcFMQART/4IyC1iXvXhh8Is6gVWi54rZxR0PWM6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rP8OHkxKfe5Izvz+FmuP/hbpMDck/N5Pz10akSMvjmwc9QNqIzFaVSGAXYYltW68c+ST0IQzq1pjsnFKtDrGYYdg2Z+HcAvlRaogyKETvoN7C+oY4J6BZFYGqgP7wfmxOjYnrG0VQY5c74drejZCPDGyFZTYcIC0JgT3z3bgAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGOQmU5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE22C4CEDD;
	Mon, 24 Mar 2025 22:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742856349;
	bh=5dOIcFMQART/4IyC1iXvXhh8Is6gVWi54rZxR0PWM6I=;
	h=From:To:Cc:Subject:Date:From;
	b=pGOQmU5MOUSLOXDatcYE0LBYpsLnSI5HYABuX87iEmEwU8rE/BlOOzlMRUOEsZFQb
	 YlfhGuBcGp02Ah0grzbLTojtUr0WNu3trttSee3YeH4iMDHbSFRxwdzpJMTozjuLr1
	 gxRmHzTCltR+jcjsLChJnzhyM61FxZJtlHph4Att9LcFfXEVJlg2xh1Ps9/RgpKjXA
	 RTfUiM0B6UU1AJIy4cr8XSsimf0Xnsq8RS61YZ5L+y7KGhlsQ9CQ02ZnYILbUBPzNT
	 MrurCNR0sD7D7CYXsNijbHk2O1z8vJ5ECS9xSR4skCLz0uea6zP9LogPFR1lnNueiu
	 cR7Ti0C9GXMrg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 00/11] net: skip taking rtnl_lock for queue GET
Date: Mon, 24 Mar 2025 15:45:26 -0700
Message-ID: <20250324224537.248800-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip taking rtnl_lock for queue GET ops on devices which opt
into running all ops under the instance lock.

This fixes and completes Stan's ops-locking work, so I think
for sanity / ease of backporting fixes we should merge it for
v6.15.

v2:
 - rebase
 - only clear XSK if netdev still set
v1: https://lore.kernel.org/20250312223507.805719-1-kuba@kernel.org

Jakub Kicinski (11):
  net: bubble up taking netdev instance lock to callers of
    net_devmem_unbind_dmabuf()
  net: remove netif_set_real_num_rx_queues() helper for when SYSFS=n
  net: constify dev pointer in misc instance lock helpers
  net: explain "protection types" for the instance lock
  net: designate queue counts as "double ops protected" by instance lock
  net: designate queue -> napi linking as "ops protected"
  net: protect rxq->mp_params with the instance lock
  net: make NETDEV_UNREGISTER and instance lock more consistent
  net: designate XSK pool pointers in queues as "ops protected"
  netdev: add "ops compat locking" helpers
  netdev: don't hold rtnl_lock over nl queue info get when possible

 include/linux/netdevice.h     | 41 ++++++++++++---------
 include/net/netdev_lock.h     | 36 ++++++++++++++++--
 include/net/netdev_rx_queue.h |  6 +--
 net/core/dev.h                | 15 ++++++++
 net/core/dev.c                | 69 +++++++++++++++++++++++++++++++----
 net/core/devmem.c             |  2 -
 net/core/net-sysfs.c          |  2 +
 net/core/netdev-genl.c        | 27 ++++++++------
 net/core/netdev_rx_queue.c    |  3 ++
 net/core/page_pool.c          |  7 +---
 net/xdp/xsk_buff_pool.c       |  7 +++-
 11 files changed, 165 insertions(+), 50 deletions(-)

-- 
2.49.0


