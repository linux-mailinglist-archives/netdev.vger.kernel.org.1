Return-Path: <netdev+bounces-159222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD63A14D80
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C96F18850EF
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01971F8EF1;
	Fri, 17 Jan 2025 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBWCT7Q8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C48C1F791B
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109577; cv=none; b=pUANuFkuZFi+JynzVrJP/iQEkGp3YSGZtdR/Na7T2qGKtMhC5ev9ulh7oVGGygrdYMXTJ80hKWw2+IPBUZ3DyacHJHcxDSR3uPchnJLfpKLIiCaEpvyfzy3N9c4p6He8NC9y9MaesoFvBWncpnhXpKqa8RAfEkTzi2kF8uu8A9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109577; c=relaxed/simple;
	bh=HGvXvmkvyHOu2XLTQomVTWtQJ1mwoeFwHhqV5kp31+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uzdBT0O1F/g/RS35RBCu4ZoULTPjRS7TeS+yqXfgGWs0KUXAtbaOhxc55lgG3pL71uinO5kSvqFQJje99pr9IAV/ZN5d8d0vEUCmXRpAkWQBVJpVno6wOzmcaJq98bTvKXaCe+Cog2TNJmyMnmYvmjsVa7iKZIvqPcestY2HvF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBWCT7Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12855C4CEDD;
	Fri, 17 Jan 2025 10:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737109576;
	bh=HGvXvmkvyHOu2XLTQomVTWtQJ1mwoeFwHhqV5kp31+E=;
	h=From:To:Cc:Subject:Date:From;
	b=DBWCT7Q8V03BdX9n1A/pw6xpEP0GgxeUMC6AHiiGCPQkCpOPJRXDnFZxz+RWa+z+T
	 cHiEMigfwc5oEDb0+YdM/Iftq2Vkq+LynhiTTTRFCmp4SltmJNsRfWju8oFzqTc6Wr
	 frwMTsncnUI9MRdatZhqizqm2T139eL1okDQM7iHPPmcsAh17E+URnQaqzi1p+X+v6
	 YfVQ2QAfRoKLsO3C8weawn5mi1nL6rQZdRYWaapAfWBiUw5FbBA0ogiuKPg/WveYet
	 QVBqPDhp6+nuZ1nm2MClf9+ZyB/NeFsNLvhVtM4awqwCbURv80Xny+JLCsUcTpOgxm
	 tBbiFjfNp7U4Q==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	stephen@networkplumber.org,
	gregkh@linuxfoundation.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/4] net-sysfs: remove the rtnl_trylock/restart_syscall construction
Date: Fri, 17 Jan 2025 11:26:07 +0100
Message-ID: <20250117102612.132644-1-atenart@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

The series initially aimed at improving spins (and thus delays) while
accessing net sysfs under rtnl lock contention[1]. The culprit was the
trylock/restart_syscall constructions. There wasn't much interest at the
time but it got traction recently for other reasons (lowering the rtnl
lock pressure).

Since the RFC[1]:

- Limit the breaking of the sysfs protection to sysfs_rtnl_lock() only
  as this is not needed in the whole rtnl locking section thanks to the
  additional check on dev_isalive(). This simplifies error handling as
  well as the unlocking path.
- Used an interruptible version of rtnl_lock, as done by Jakub in
  his experiments.
- Removed a WARN_ONCE_ONCE call [Greg].
- Removed explicit inline markers [Stephen].

Most of the reasoning is explained in comments added in patch 1. This
was tested by stress-testing net sysfs attributes (read/write ops) while
adding/removing queues and adding/removing veths, all in parallel. I
also used an OCP single node cluster, spawning lots of pods.

Thanks,
Antoine

[1] https://lore.kernel.org/all/20231018154804.420823-1-atenart@kernel.org/T/

---

Not sending this as an RFC as I believe this is ready for proper review,
but also note rc7 is there already and we might want this to live for a
bit in net-next before getting to Linus' tree.

Antoine Tenart (4):
  net-sysfs: remove rtnl_trylock from device attributes
  net-sysfs: move queue attribute groups outside the default groups
  net-sysfs: prevent uncleared queues from being re-added
  net-sysfs: remove rtnl_trylock from queue attributes

 include/linux/netdevice.h     |   1 +
 include/linux/rtnetlink.h     |   1 +
 include/net/netdev_rx_queue.h |   1 +
 net/core/net-sysfs.c          | 388 ++++++++++++++++++++++++----------
 net/core/rtnetlink.c          |   6 +
 5 files changed, 280 insertions(+), 117 deletions(-)

-- 
2.48.0


