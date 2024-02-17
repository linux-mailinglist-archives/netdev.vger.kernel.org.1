Return-Path: <netdev+bounces-72614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218AD858D45
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 06:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871211F22AE2
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 05:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6581BF38;
	Sat, 17 Feb 2024 05:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="SQFnabyr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55FB1C15
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 05:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708146262; cv=none; b=GSFBh0Rt081rlNjrcQBEH4daXhI23BiNIxjzci314T23gi4/bWsVa+mas/HjTgwp9NlEznYd/5NcTyEd0r9aWiut7tHBZPDIi2dSI4wjk155E2b40Sfc9EbVRDDklwKBjrqY23WnieiAxB2+WzC68wuQEzeRDuoxK+BRXBUR4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708146262; c=relaxed/simple;
	bh=vCvtkNPcYL0YPnwTSxwx0gnXHtV/Qq9oIAagAnUSIns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hCg5lscICYhCLapZ+OkcD/1HMmplcXs4mM+NbG0e0TJCCruI5z3BlhhExEc/ZBqj3p8sKCkGZz2rPj3OY9wEv7kqTu/MVyv2/S7LBYNDg+VP0BfGvxFSi0JBpTfhEI5rEmYPPe3h/G/pG1EWT1nMbI0E7RqeW7l801hwBg7oe4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=SQFnabyr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d7858a469aso23521515ad.2
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708146260; x=1708751060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8T7c1dI8SmTbfOv7d0ngewm9NG8LTnP16EytPe3RriI=;
        b=SQFnabyrIYCw3WSl8Akg5O65SJX2020yLbLSUMkocfEkL8c90vkSShtkPVrsjCG+GK
         /jZ2zMI3InAAOxbu0tlEAFFpbt0TgO07xUTU1M6JKQcJJsQw9FLkC8dHpOMPDtj7jBBM
         yY2nU0A48/wuqO3HirHiCR92EBi96TEp9F7qyQJ8UirwyI980qk2PAqLPD7aNk65Tpjx
         jHEqVzSUTyj2uOPRKrmhqw5U32JjXY6ZZ9OhTccIIx8XSawLlWYUaAwGP7zE2vOkhTA4
         Aus/pGTkFYgnP5duLiCh4TJaML9rmxA6/XULJqR5ydOTTLENCmXTN2ZC/mWYo3f3yhKo
         Hs+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708146260; x=1708751060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8T7c1dI8SmTbfOv7d0ngewm9NG8LTnP16EytPe3RriI=;
        b=ZgB9Ps6WaJlItLP999PLpBYAMxZH7t008/GezIgAbMRsvNOUKIj6XW/+pbxjRxxsei
         u6zPtAnpYsQbA+XmQTBc1PEN1cr9HtVpi71NOZEm9tHGET4blvR3dJB/GmOxl8ExCfpM
         BVOI1XoPZSjg0wsbVIbN6yDapKfr1OhPqM8ho9dMv8Ib7rDmj9jFtJZweRCQaGfwZwxV
         mNnIhGYjAgWnTENmQxKTcoU6GT1Y0IdqkDAxTMxFqFDXaQLQwlx45JJXMRpGjHhCebn8
         qbsLFy0q0m3hwLmERHC1RelOkSGBO+bLz5cQN/BhidEPieojwGp3E7gsTa0AhB2i7d73
         P0gA==
X-Forwarded-Encrypted: i=1; AJvYcCU+PA5Q4k5C3l8oNvKhFtGlamBRZ1tMXGFNRY2eWBj5JmQhR2lcbsdxYcZunDqrLvbX0Ygt9VYoQBucNp1cppm726G4+H6k
X-Gm-Message-State: AOJu0YyYOPSRLLAkZ014LdTeHx5tdNZb2M8SnhOS/tBekQhm+ZX9t9QX
	zswUBc3hWzWpMpOA4PYkYKvx0862dAXXuX+D+4j4X59tC5d2GgDKXyZnwVP3mU2iaKgY3G/bI70
	Pln8=
X-Google-Smtp-Source: AGHT+IHoiTsZ3Jd2HqDkiO+DJOt+eQgXyPMG4evRXrEefHkOfxwuwI3aGIMLbqnpu1rxKEhreFAzyQ==
X-Received: by 2002:a17:90a:8b0c:b0:299:489f:fd2d with SMTP id y12-20020a17090a8b0c00b00299489ffd2dmr1820485pjn.20.1708146260110;
        Fri, 16 Feb 2024 21:04:20 -0800 (PST)
Received: from localhost (fwdproxy-prn-019.fbsv.net. [2a03:2880:ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id fv12-20020a17090b0e8c00b00296aa266ffesm862479pjb.31.2024.02.16.21.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 21:04:19 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v12 0/4] netdevsim: link and forward skbs between ports
Date: Fri, 16 Feb 2024 21:04:14 -0800
Message-Id: <20240217050418.3125504-1-dw@davidwei.uk>
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
v11->v12:
- fix leaked netns refs
- fix rtnetlink.sh kci_test_ipsec_offload() selftest

v10->v11:
- add udevadm settle after creating netdevsims in selftest

v9->v10:
- fix not freeing skb when not there is no peer
- prevent possible id clashes in selftest
- cleanup selftest on error paths

v8->v9:
- switch to getting netns using fd rather than id
- prevent linking a netdevsim to itself
- update tests

v7->v8:
- fix not dereferencing RCU ptr using rcu_dereference()
- remove unused variables in selftest

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
  netdevsim: fix rtnetlink.sh selftest

 drivers/net/netdevsim/bus.c                   | 135 +++++++++++++++++
 drivers/net/netdevsim/netdev.c                |  40 ++++-
 drivers/net/netdevsim/netdevsim.h             |   3 +
 .../selftests/drivers/net/netdevsim/Makefile  |   1 +
 .../selftests/drivers/net/netdevsim/peer.sh   | 139 ++++++++++++++++++
 tools/testing/selftests/net/rtnetlink.sh      |   2 +
 6 files changed, 315 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

-- 
2.39.3


