Return-Path: <netdev+bounces-66359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B2A83EAD4
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 05:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34B21F254B6
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 04:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B611C80;
	Sat, 27 Jan 2024 04:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Je/PfFTI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C37A13AF9
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 04:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706328247; cv=none; b=JsBVtL5oExKABf+ON3l31bPa8hkSaGZ4Te9YimUqCpNCsPs3sNnN+a0AJIM71qoTOeYisYdtjyWNlTONTy5Dph3kLLnxR0fa4ojkKKwwp7IR1JIppJHAf7hBk8/r8y6AbT9eCO/mL3IpfjqjNYDBPq07qovKmCstezQv7NhCVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706328247; c=relaxed/simple;
	bh=EGkmuQpF0QeB42goN5i6nLX7n9RHwMIQj/WZ9Va4P/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GBMZnD/p3cTWyczFvg0JLojuKncx928E3vLYieRfieccvOp6HtYC0rmk3AROGl2QhWJf+wwbaiNWA0APU+CE2OvL8P6jpZXGGqgwslzRgg4cpaoipGMY13FzawhffBjGaH8/7qGtrhAvKB9sXM1EOBMWVHCFvqHXHiD69GyPUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Je/PfFTI; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-361a1665791so1913765ab.3
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 20:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706328245; x=1706933045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tYg3wFcwjX6wR4PZkjxwRxCDKfa+3EPMZcEwVYYXstM=;
        b=Je/PfFTIMdu+vL47gDfkoRhtKkp2vqzR4HFBpc1UZqy31IxuGbeqj1YLvOWpaCgLxU
         YZ7gVRoaaeRSDGPesHIK3NGNTNfgLy3lETpyp8AngnCT8w+Jst1TcTru54iN9WtE7y1s
         zaFJrLdaFWkvN4N5riLyTMvFRuDjZIo52dRBe9M/Lej2LBjiUKfbM3+ZBh+rweEo+iTn
         AN+YeZU5Xo/cup3kYH4vU/XuFDXpSopDX7Asoe+cM/EgHXg7YdT0rSvmlyBvGrgrSMah
         vnIMn6KLuZHcu8aytlQ4c6CIzE3wAIn7CP9Zs1VwioenqkGJpu4CIPbyWC+eDSzmPrv0
         dong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706328245; x=1706933045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYg3wFcwjX6wR4PZkjxwRxCDKfa+3EPMZcEwVYYXstM=;
        b=va/knoP/08pE1Ph4SWNcLGzH71LodAqgbWA/rojKRME0WlkBQaNanwwPlRCkXw8FND
         PnABVem7ycjhjHRuMBdvNqtNmPCMmU6U624jSiIf+xXq3m/ZIGRB8BSepU3NGgfD10q/
         eOnmao/8Y+/Q0YLsyG2tAy6/4n/JheY5fBVBBb6UrUz1CQJjuWttC5YTNkjS+fBbSxAc
         0k61QUwyDPwORgrfET2emNvl6/h73Atdqmj+2Z5mJUqIiMuT5rrVLKSgIiW2xpTpSxP4
         y9zeY2h5e4MzK1sKjc81CIqoxxXv0cjsH+KqjmW06Z6nRS+7gmYnt8u6vl4GI6goQqr8
         yHmw==
X-Gm-Message-State: AOJu0Yxx4KmDQA9KBVkzTxjmc57UcJSEITFlD/357nVPV+UHGcHHjfCc
	95A/m6MzRMXLj9ySUaIW44EK1g2c0qXNDy3oiCMsUVtER8OPDLF26STlyB2eG8A=
X-Google-Smtp-Source: AGHT+IE3mMqFzUhP5f/CD3LfJYc3Ypp9ycSGvk45/EE8G4AJn83nPl3ss3+fO5lfocI87D3GMn0hVg==
X-Received: by 2002:a92:c9c9:0:b0:362:aa52:2d35 with SMTP id k9-20020a92c9c9000000b00362aa522d35mr1086034ilq.16.1706328245115;
        Fri, 26 Jan 2024 20:04:05 -0800 (PST)
Received: from localhost (fwdproxy-prn-119.fbsv.net. [2a03:2880:ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id j71-20020a63804a000000b005d7c02994c4sm1906557pgd.60.2024.01.26.20.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 20:04:04 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v7 0/4] netdevsim: link and forward skbs between ports
Date: Fri, 26 Jan 2024 20:03:50 -0800
Message-Id: <20240127040354.944744-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds the ability to link two netdevsim ports together and
forward skbs between them, similar to veth. The goal is to use netdevsim
for testing features e.g. zero copy Rx using io_uring.

This feature was tested locally on QEMU, and a selftest is included.

---
v6->v7:
- change link syntax to netnsid:ifidx
- replace dev_get_by_index() with __dev_get_by_index()
- check for NULL peer when linking
- add a sysfs attribute for unlinking
- only update Tx stats if not dropped
- update selftest

v5->v6:
- reworked to link two netdevsims using sysfs attribute on the bus
  device instead of debugfs due to deadlock possibility if a netdevsim
  is removed during linking
- removed unnecessary patch maintaining a list of probed nsim_devs
- updated selftest

v4->v5:
- reduce nsim_dev_list_lock critical section
- fixed missing mutex unlock during unwind ladder
- rework nsim_dev_peer_write synchronization to take devlink lock as
  well as rtnl_lock
- return err msgs to user during linking if port doesn't exist or
  linking to self
- update tx stats outside of RCU lock

v3->v4:
- maintain a mutex protected list of probed nsim_devs instead of using
  nsim_bus_dev
- fixed synchronization issues by taking rtnl_lock
- track tx_dropped skbs

v2->v3:
- take lock when traversing nsim_bus_dev_list
- take device ref when getting a nsim_bus_dev
- return 0 if nsim_dev_peer_read cannot find the port
- address code formatting
- do not hard code values in selftests
- add Makefile for selftests

v1->v2:
- renamed debugfs file from "link" to "peer"
- replaced strstep() with sscanf() for consistency
- increased char[] buf sz to 22 for copying id + port from user
- added err msg w/ expected fmt when linking as a hint to user
- prevent linking port to itself
- protect peer ptr using RCU


David Wei (4):
  netdevsim: allow two netdevsim ports to be connected
  netdevsim: forward skbs from one connected port to another
  netdevsim: add selftest for forwarding skb between connected ports
  netdevsim: add Makefile for selftests

 MAINTAINERS                                   |   1 +
 drivers/net/netdevsim/bus.c                   | 132 ++++++++++++++++++
 drivers/net/netdevsim/netdev.c                |  39 +++++-
 drivers/net/netdevsim/netdevsim.h             |   3 +
 .../selftests/drivers/net/netdevsim/Makefile  |  18 +++
 .../selftests/drivers/net/netdevsim/peer.sh   | 127 +++++++++++++++++
 6 files changed, 315 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

-- 
2.39.3


