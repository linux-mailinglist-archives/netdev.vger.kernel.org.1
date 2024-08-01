Return-Path: <netdev+bounces-115063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1217C945045
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D2A1F2263E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72AE1B373D;
	Thu,  1 Aug 2024 16:13:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40801B372C;
	Thu,  1 Aug 2024 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528830; cv=none; b=rYvsjPnXzd9ZhJu051CfusUd+ynU9uDluBamT1E4Wh/NwvcHEB85qAKMqbWsNazbC0Zoprbn08IFghVSq5sWKoRKIApsChePf89XrkzV+ddMJTS/ZaAvnRUSOasRCdpSHQHgqXdiaM4XP4ZnMbUL1RE5xzv4uCHa1lUNxN4IToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528830; c=relaxed/simple;
	bh=rp1XF079j59Pvp2I+zsF6SPApZ+0DOBUXimiuHMIiVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMpsgaZRtaNEDGVOyNtsXwQkAKuibXtf403xjNJNAgteOvJctJ2mpDi8A3xfvC4nV5GzulDzYNQDFW/sXrmyJdUKF5Ne0+kp/qO1fbcQAaDuwTlM3FMSZOp1HFavtNxpz+2EfmoriIsVsXCLgfuWZqPIe5/M9eHdTpWSMvDbBQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f01afa11cso10671554e87.0;
        Thu, 01 Aug 2024 09:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528827; x=1723133627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWOti2pAjmzmrX8teelKvariOh2+tjTYxkWgskx2MOI=;
        b=dtMtEf3irW32Y21L/sK8qcyc72/8E95kSjCMnfBNwJRIjvcdv15EIV63XluiHvXYm2
         1xlz0iOgtvp+AH+VEqy6bJ2W1hzKW0eCJ0rdtY+wY7vboCP4BrQLyM5xOUdXbEQbAXNx
         +aGTO6PDQ0ndUPQalK9QhZhXIcw9yxR/3+XFHFdvXDvf6vrmxJYw1H7aDVMSIGZCeVuf
         AeRiBFwIKDhHCj8QrOMUAc1vYSRNxE30iUjStqVGf4ryqvfJmeS5VVmMSX1mGg9z19Gk
         Vly2driW1511RXCZPoeEn9VfWAqnvmegdWj4Oic//SHe6hILwRHf3huTykVYHM/JoZPL
         gdCg==
X-Forwarded-Encrypted: i=1; AJvYcCUg5tOTeCyd+QdUWb2gpZRQr32DNMf2nqxt3gnwDTp4friqgLrjLlBZVv+tMMvDFQQdb8sHUdByMaL4OdTYtq/A0GoF5ir6gZRc3VcC7kCKzERPZM0SdzkF4MsPQSpv2zmaQFpU
X-Gm-Message-State: AOJu0YzLWMsh0Xd+YhNuFg9bDYJXVkJunyN+txhteqSEjWQxDFjhV5Ig
	Ib2qXd3LdnrQ4bNyYi1bvcI9kU3skcAQKQPluoUYDVgkrpnMcM3Z
X-Google-Smtp-Source: AGHT+IHaoIYR6SwK/7sBsQHR3t7/M6bGSFp3+wmCN8rHuq5ezyXa0Q+o/CqwOL6Awin8iFOFndHMnw==
X-Received: by 2002:a05:6512:31c1:b0:52c:cd4f:b95b with SMTP id 2adb3069b0e04-530bb37053amr347181e87.22.1722528826414;
        Thu, 01 Aug 2024 09:13:46 -0700 (PDT)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5afa605d81bsm8791792a12.74.2024.08.01.09.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:13:46 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thevlad@fb.com,
	thepacketgeek@gmail.com,
	riel@surriel.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	davej@codemonkey.org.uk
Subject: [PATCH net-next 0/6] net: netconsole: Fix netconsole unsafe locking
Date: Thu,  1 Aug 2024 09:11:57 -0700
Message-ID: <20240801161213.2707132-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem:
=======

The current locking mechanism in netconsole is unsafe and suboptimal due
to the following issues:

1) Lock Release and Reacquisition Mid-Loop:

In netconsole_netdev_event(), the target_list_lock is released and
reacquired within a loop, potentially causing collisions and cleaning up
targets that are being enabled.

	int netconsole_netdev_event()
	{
	...
		spin_lock_irqsave(&target_list_lock, flags);
		list_for_each_entry(nt, &target_list, list) {
			spin_unlock_irqrestore(&target_list_lock, flags);
			__netpoll_cleanup(&nt->np);
			spin_lock_irqsave(&target_list_lock, flags);
		}
		spin_lock_irqsave(&target_list_lock, flags);
	...
	}

2) Non-Atomic Cleanup Operations:

In enabled_store(), the cleanup of structures is not atomic, risking
cleanup of structures that are in the process of being enabled.

	size_t enabled_store()
	{
	...
		spin_lock_irqsave(&target_list_lock, flags);
		nt->enabled = false;
		spin_unlock_irqrestore(&target_list_lock, flags);
		netpoll_cleanup(&nt->np);
	...
	}


These issues stem from the following limitations in netconsole's locking
design:

1) write_{ext_}msg() functions:

	a) Cannot sleep
	b) Must iterate through targets and send messages to all enabled entries.
	c) List iteration is protected by target_list_lock spinlock.

2) Network event handling in netconsole_netdev_event():

	a) Needs to sleep
	b) Requires iteration over the target list (holding
	   target_list_lock spinlock).
	c) Some events necessitate netpoll struct cleanup, which *needs*
	   to sleep.

The target_list_lock needs to be used by non-sleepable functions while
also protecting operations that may sleep, leading to the current unsafe
design.


Solution:
========

1) Dual Locking Mechanism:
	- Retain current target_list_lock for non-sleepable use cases.
	- Introduce target_cleanup_list_lock (mutex) for sleepable
	  operations.

2) Deferred Cleanup:
	- Implement atomic, deferred cleanup of structures using the new
	  mutex (target_cleanup_list_lock).
	- Avoid the `goto` in the middle of the list_for_each_entry

3) Separate Cleanup List:
	- Create target_cleanup_list for deferred cleanup, protected by
	  target_cleanup_list_lock.
	- This allows cleanup() to sleep without affecting message
	  transmission.
	- When iterating over targets, move devices needing cleanup to
	  target_cleanup_list.
	- Handle cleanup under the target_cleanup_list_lock mutex.

4) Make a clear locking hierarchy

	- The target_cleanup_list_lock takes precedence over target_list_lock.

	- Major Workflow Locking Sequences:
		a) Network Event Affecting Netpoll (netconsole_netdev_event):
			rtnl -> target_cleanup_list_lock -> target_list_lock

		b) Message Writing (write_msg()):
			console_lock -> target_list_lock

		c) Configfs Target Enable/Disable (enabled_store()):
			dynamic_netconsole_mutex -> target_cleanup_list_lock -> target_list_lock


This hierarchy ensures consistent lock acquisition order across
different operations, preventing deadlocks and maintaining proper
synchronization. The target_cleanup_list_lock's higher priority allows
for safe deferred cleanup operations without interfering with regular
message transmission protected by target_list_lock.  Each workflow
follows a specific locking sequence, ensuring that operations like
network event handling, message writing, and target management are
properly synchronized and do not conflict with each other.


Testing:
=======

This patchset contains a basic version of the test I am using to test
netconsole. I hope to include it into NIPA also.

I've also tested with some parallel dynamic removal/add, and network
events, and I haven't seen any issue. Tested with KASAN and LOCKDEP.


Breno Leitao (6):
  net: netconsole: selftests: Create a new netconsole selftest
  net: netpoll: extract core of netpoll_cleanup
  net: netconsole: Correct mismatched return types
  net: netconsole: Standardize variable naming
  net: netconsole: Unify Function Return Paths
  net: netconsole: Defer netpoll cleanup to avoid lock release during
    list traversal

 MAINTAINERS                                   |   1 +
 drivers/net/netconsole.c                      | 173 +++++++++++-------
 include/linux/netpoll.h                       |   1 +
 net/core/netpoll.c                            |  12 +-
 .../net/netconsole/basic_integration_test.sh  | 153 ++++++++++++++++
 5 files changed, 272 insertions(+), 68 deletions(-)
 create mode 100755 tools/testing/selftests/net/netconsole/basic_integration_test.sh

-- 
2.43.0


