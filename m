Return-Path: <netdev+bounces-174393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCD9A5E781
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3961899B73
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6C21EE7C6;
	Wed, 12 Mar 2025 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVk8RmGA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1421DFD95
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818918; cv=none; b=GEjMcVq6S7BWvYk6t8izOSiX8uk39UMfupTnCHuaNxUHELCPFinzIxMGtfdQTul7Z7UHB5hsfFUNd5BHVd1B5uF/HX6liqLckgWvNd7wRT7vhNjcNYXAFLZeIYkdfP+wazmNm2LEvY7HvDG4twRFhQ4r6EDqYxPu16TJy7BrS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818918; c=relaxed/simple;
	bh=hkziFKxEmzByKuwZL0dI/8nYjlnG4sTlXiSGFdRFXtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m23isWGb/vlJEDXhYQ7sGWlYfVCJoIA3WFDuPbSqcOVH2i4dElyu32OkPso5PDt6f16rvxW4l/lSRMxG8XjYgU2H5lFFoIPPoWu8F5Q9gjB1vMjKaxEaMKwd+fjpKrDSIgYSV2va+UAoL4XmbIUQ9kLoQo4UWhdfLvyA1AwmDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVk8RmGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875B2C4CEDD;
	Wed, 12 Mar 2025 22:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741818917;
	bh=hkziFKxEmzByKuwZL0dI/8nYjlnG4sTlXiSGFdRFXtI=;
	h=From:To:Cc:Subject:Date:From;
	b=lVk8RmGA3YK8bZ0tXcoRgllBEC8DR28nr4niEJ3xEtJZn/qnAaTI2Mh4VqivEAXfy
	 cbKxg4mmU91e+NK8HmcHX53xi9jtf3AMnamoh2d0Ab+0s8WAzZtcZXm0x/ONiu4pqK
	 Ynb2Rtazt/v7AWLMGFLeqOBMJuWLrn2OZRRpazHPGq0/5mHTuZn8Iijk9eCFPDhzer
	 sKvPfCRLvpj0mbaAagj0+pOR+ht0f5McaUyxWA6Z4yfQXSdZL8/+HhL4qXLpjkgtoE
	 +w4Plm96TXEQ4QK9hkWGe0NG/5YFJGZxWmEkmFJev4EcLpbcQFyvjzTImx1KLu2t1J
	 DLL8Kar1mhBsg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/11] net: skip taking rtnl_lock for queue GET
Date: Wed, 12 Mar 2025 23:34:56 +0100
Message-ID: <20250312223507.805719-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip taking rtnl_lock for queue GET ops on devices which opt
into running all ops under the instance lock.

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
 net/xdp/xsk_buff_pool.c       |  3 ++
 11 files changed, 162 insertions(+), 49 deletions(-)

-- 
2.48.1


