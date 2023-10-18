Return-Path: <netdev+bounces-42296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF297CE19C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E19FB20F59
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390D63B2B3;
	Wed, 18 Oct 2023 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtNL1Ewa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C2BE62
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40418C433C8;
	Wed, 18 Oct 2023 15:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697644087;
	bh=Egqlg9xBTMJHR4Nv7LHijBYhi8uJAuXWXJWSSu6ozjY=;
	h=From:To:Cc:Subject:Date:From;
	b=dtNL1Ewab6vVyulHraOeGTErx2DNJDYzjGviFhrwoX6urOYfbeOk+nmh/6yL/bc00
	 VEsimCgkhVlqIoV4hoBLBR6t7z4veJV3ZZZ7aLC7KMPjoXfF32lSXAU0erM++9Wd16
	 h0Bhoa8PHxb2MZQ1uWR9qPkAGKxkqCajzzs6+l+dO1rbFTksL/BkGWBLsTuGjhivsI
	 nTw6l/qPeDDZYKm+acXZOErQacOHEpIe407FYTRYwxwT96IvjxqQrrHUpLzHwt/Ujn
	 2vpWMAvQ7LOVByQuWIZZV1+vaHTk1G8q08b/lvZIobQfN5qiw5xVnUWJsuOAW03mUc
	 hILYKQL192xsg==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	gregkh@linuxfoundation.org,
	mhocko@suse.com,
	stephen@networkplumber.org
Subject: [RFC PATCH net-next 0/4] net-sysfs: remove rtnl_trylock/restart_syscall use
Date: Wed, 18 Oct 2023 17:47:42 +0200
Message-ID: <20231018154804.420823-1-atenart@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is sent as an RFC because I believe this should be discussed (and
some might want to do additional testing), but the code itself is ready.

Some time ago we tried to improve the rtnl_trylock/restart_syscall
situation[1]. What happens is when there is rtnl contention, userspace
accessing net sysfs attributes will spin and experience delays. This can
happen in different situations, when sysfs attributes are accessed
(networking daemon, configuration, monitoring) while operations under
rtnl are performed (veth creation, driver configuration, etc). A few
improvements can be done in userspace to ease things, like using the
netlink interface instead, or polling less (or more selectively) the
attributes; but in the end the root cause is always there and this keeps
happening from time to time.

That initial effort however wasn't successful, although I think there
was an interest, mostly because we found technical flaws and didn't find
a working solution at the time. Some time later, we gave it a new try
and found something more promising, but the patches fell off my radar. I
recently had another look at this series, made more tests and cleaned it
up.

The technical aspect is described in patch 1 directly in the code
comments, with an additional important comment in patch 3. This was
mostly tested by stress-testing net sysfs attributes (read/write ops)
while adding/removing queues and adding/removing veths, all in parallel.

All comments are welcomed.

Thanks,
Antoine

[1] https://lore.kernel.org/all/20210928125500.167943-1-atenart@kernel.org/T/

Antoine Tenart (4):
  net-sysfs: remove rtnl_trylock from device attributes
  net-sysfs: move queue attribute groups outside the default groups
  net-sysfs: prevent uncleared queues from being re-added
  net-sysfs: remove rtnl_trylock from queue attributes

 include/linux/netdevice.h     |   1 +
 include/net/netdev_rx_queue.h |   1 +
 net/core/net-sysfs.c          | 329 ++++++++++++++++++++++++----------
 3 files changed, 237 insertions(+), 94 deletions(-)

-- 
2.41.0


