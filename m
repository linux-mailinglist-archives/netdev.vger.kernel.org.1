Return-Path: <netdev+bounces-162650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01F7A277BC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1211885BB4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105A22147F4;
	Tue,  4 Feb 2025 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7GLw0r7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0256175A5
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688599; cv=none; b=B5gjZNUIJlUtAgxM7b2JshOLQO4+pMdhNaIx059K33b8OcqeL1Z0cq/DQqr2e7dpECietlL5LALPITQLZTnbfO7CQjTj4bST/sQlYzPqebOzZuFUsjZtoufDToUwJLqF4IfBlEdGP6WpVQag+hqD+9+XdT7nTq5M2sRYCDsQKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688599; c=relaxed/simple;
	bh=JvZVwmNVj0UtDLhYcie9BCC8yX1XXKJzLE3bLp06+BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kz9UbGA4prF+WyNdBByNWDd2K0bUT7LBGKWMr5XS0vABqsYJwcepx+LqQmBpC/REMeK5YVpeUy+AhWwqTWvjDD+Smqy2kL28UEgHj04Agh07OGEDissnI3Q8bL0U1mfEW13OrqVQGb6oJO9QzPjN/U/DBCXyWWmfMli+INj+abQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7GLw0r7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A304CC4CEDF;
	Tue,  4 Feb 2025 17:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738688598;
	bh=JvZVwmNVj0UtDLhYcie9BCC8yX1XXKJzLE3bLp06+BQ=;
	h=From:To:Cc:Subject:Date:From;
	b=S7GLw0r7gUDIVoV0vu12ZCMTMjRw0j7zcPfAWlz96B5nLOt1mdYgOmH4odMIv2Gn8
	 SOMf4yqsUcMnPHWF2CYQshipOvwA1DIDNTjU8mT3imnTPWYg5Oh0ynq3x7bgZW+XS3
	 gmsYUs4EjLqu+AhQg0+qTq3YMMQuixfrJnBM2vKhuV338g99m3+42iq+xLglhWhy0B
	 nVQVWYCmvuYjredJeZb7b8o/4K9udwTHWiQ1BTJ0jHabp2IlYi9H649JIw+a85xi2p
	 eOxZtQ24kFVM0kiGFZHYID25D9sF7K1XGOO1AZ+AWLX7zbK4Irgt0LC0Uuuetg2stR
	 he5XeX8B4vEMg==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	stephen@networkplumber.org,
	gregkh@linuxfoundation.org,
	maxime.chevallier@bootlin.com,
	christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/4] net-sysfs: remove the rtnl_trylock/restart_syscall construction
Date: Tue,  4 Feb 2025 18:03:09 +0100
Message-ID: <20250204170314.146022-1-atenart@kernel.org>
X-Mailer: git-send-email 2.48.1
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

Since v1[2]:

- Do not export rtnl_lock_interruptible [Stephen].
- Add netdev_warn_once messages in rx_queue_add_kobject [Jakub].

Since the RFC[1]:

- Limit the breaking of the sysfs protection to sysfs_rtnl_lock() only
  as this is not needed in the whole rtnl locking section thanks to the
  additional check on dev_isalive(). This simplifies error handling as
  well as the unlocking path.
- Used an interruptible version of rtnl_lock, as done by Jakub in
  his experiments.
- Removed a WARN_ONCE_ONCE [Greg].
- Removed explicit inline markers [Stephen].

Most of the reasoning is explained in comments added in patch 1. This
was tested by stress-testing net sysfs attributes (read/write ops) while
adding/removing queues and adding/removing veths, all in parallel. I
also used an OCP single node cluster, spawning lots of pods.

Thanks,
Antoine

[1] https://lore.kernel.org/all/20231018154804.420823-1-atenart@kernel.org/T/
[2] https://lore.kernel.org/all/20250117102612.132644-1-atenart@kernel.org/T/

Antoine Tenart (4):
  net-sysfs: remove rtnl_trylock from device attributes
  net-sysfs: move queue attribute groups outside the default groups
  net-sysfs: prevent uncleared queues from being re-added
  net-sysfs: remove rtnl_trylock from queue attributes

 include/linux/netdevice.h     |   1 +
 include/linux/rtnetlink.h     |   1 +
 include/net/netdev_rx_queue.h |   1 +
 net/core/net-sysfs.c          | 392 ++++++++++++++++++++++++----------
 net/core/rtnetlink.c          |   5 +
 5 files changed, 283 insertions(+), 117 deletions(-)

-- 
2.48.1


