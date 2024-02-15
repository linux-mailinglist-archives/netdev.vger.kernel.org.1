Return-Path: <netdev+bounces-72180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF24856DF8
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 20:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37844B28A1A
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 19:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EB513A25D;
	Thu, 15 Feb 2024 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ARqwbyvH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB541A81
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026209; cv=none; b=d3yLr0m6clvbVsw/rCC4r7FQdWa8zDYVTvRIGiMCnPdmvHAAhusST/zno3aVF4K8WwWHZkLaPcxfm5hLR/BrYSt+tL/aTbuZHuLQk2jy2jy8CI8e3IHPmuVZTWRiFslbqRXQOXXeQVFNbYDTPDdQfXy5si+K+xjX5VrA+rHI+aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026209; c=relaxed/simple;
	bh=Gk6na6wjCbzuwmehOcAac2r07kZqIcsN97JTTxFceF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qXtBCQK5TJQn2jFzhWOfgm3Je8gGiGHt19EZZnOgtV06z5eoa63cRte8q6GREd1zzzzRm0pUJgFT3TEeGxbNY+lEgEY6hXwG34WfNjcBI6hiOid+eSTRxdNuIfXE9e3/evpt4F1pzmzYPQZsYdqMvGyBNdJtcEUqA9YdNAz5Zs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ARqwbyvH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e1040455b5so859141b3a.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 11:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708026207; x=1708631007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHBNG8P/rII2Ya10WXAofd+V62LujSmDiO5Cwc0LWo4=;
        b=ARqwbyvHaUVv3DCVLFd87T/q55dhus5uG1v5mrz4YzAHNDubnzgSmt8f2Vo2pnW53x
         qlbpPjp16CvNFYZgtMyV8265fu/71iZN7/iqUqNGkkVfx9H+mxdnQ8EIEY8aIrn4ejPj
         Ggnx/MhgyCKPG54SKvWInLYWPEF8NPIgcERMWZYM7GfbE42OQ50jg/caiJ+83+UF3GiR
         GhjfVXqxhHMFlQttqHzTK4C+R+xGVF9fTn7oJEx3/t/NAYkSqKp8giEjUzaZq2VRpZGV
         AQ/E3x635+5UmpbEEb8ilXjbwrLNIsgyfehcJlatchD4bRCitgqv+/fwOz5pvHKKtZj7
         Hhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708026207; x=1708631007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHBNG8P/rII2Ya10WXAofd+V62LujSmDiO5Cwc0LWo4=;
        b=EFR/QoctaVVHrBxI2TtsF+/KMu8ZJyiDpzFr6uvebYeq7XZz/zaJQarvpNSVF2T7BA
         MWZDCHJAdJ3WXT8vLm0EAuxv7xE2AXRoxppqYR3YqEAvib2wLyIL5G3H/88I0gX/QEEE
         HpT13VDWGoF6DBb6wO1oo8IgyLumFoqm+FO1kDCecpHFD4ChQEfLusC/bv31WbV7oRtK
         rmXr8CfkimOtTa77k7hY6+P4r+aaFOdYwbatETb/ZoPj9LwO0Z0zXSGvPFoORmoP0IOX
         Y3sVPzChaBrN36bZ+EpfYlzJjteOPpEEsfCHV8Cs7/haZ2+GzKNn1PPvOhrUlscSRL38
         hM8A==
X-Forwarded-Encrypted: i=1; AJvYcCV+AjB78aw+dKhd6iuyLESBeJL+S24IOveaQL7FiEcGC2HwHFIAu1za/IaQ2wt7zE56FYiXR66AE30s+KzWNQ/enDXBsmy+
X-Gm-Message-State: AOJu0YyiUagwmS5x08OjbS6gU2aCc3LGm2N3RmJWGF0SS1P15qxcFw8p
	ngNKYTCbVICz+reqxQzRoV7N1Z+xlcFcI7nO6o33KiDMHlbbsMk8rcv4KZS1jPQ=
X-Google-Smtp-Source: AGHT+IGVHZ2Dp98sHlKZp0ho4ycqHVg+zfXbRKVYwbCULTaN/Q0DPfRdc7w1XptI+h2rDdrzJv4fng==
X-Received: by 2002:a05:6a20:4d9c:b0:19e:bc8c:4810 with SMTP id gj28-20020a056a204d9c00b0019ebc8c4810mr2388346pzb.51.1708026207165;
        Thu, 15 Feb 2024 11:43:27 -0800 (PST)
Received: from localhost (fwdproxy-prn-015.fbsv.net. [2a03:2880:ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id sn15-20020a17090b2e8f00b00297022db05dsm204637pjb.40.2024.02.15.11.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:43:26 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v11 0/3] netdevsim: link and forward skbs between ports
Date: Thu, 15 Feb 2024 11:43:22 -0800
Message-Id: <20240215194325.1364466-1-dw@davidwei.uk>
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

David Wei (3):
  netdevsim: allow two netdevsim ports to be connected
  netdevsim: forward skbs from one connected port to another
  netdevsim: add selftest for forwarding skb between connected ports

 drivers/net/netdevsim/bus.c                   | 135 +++++++++++++++++
 drivers/net/netdevsim/netdev.c                |  40 ++++-
 drivers/net/netdevsim/netdevsim.h             |   3 +
 .../selftests/drivers/net/netdevsim/Makefile  |   1 +
 .../selftests/drivers/net/netdevsim/peer.sh   | 139 ++++++++++++++++++
 5 files changed, 313 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

-- 
2.39.3


