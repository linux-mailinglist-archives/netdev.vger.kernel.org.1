Return-Path: <netdev+bounces-75943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C74686BC1F
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBC72829F2
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA35413D311;
	Wed, 28 Feb 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="gKwTdidp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4613D304
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162577; cv=none; b=DW8LuXCaMb7WaYbajSN29nSaMkXRROFa3OrxWJh8Oi1Em8tKGeNmCTshEg24RGnkFC0ZFlsUVjnhoH/kGCPBU3deLLW+LTan1LWolQwL+KcKzjJQ16BdveHPiy+CpQ4KuV7vCAFUgSgWqc6FwxC+05pGpSvgY0GRt91Tr06G4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162577; c=relaxed/simple;
	bh=Wg/YWkbVKvOZgoCYzMaE9DijCsLNQIEUjs/SWFe2YTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WI4ApneInpZBkAva1lJRdME2xCiLVK0XrofO8JhWO6mM/ZMv4d8QU/8QTduoikIM7w0tYL/HLWInfGNHLO2XLAdznyIW2Z4jUA33d/+28LITLpldu2acRdWeeFVZP9H7hM/RBSmopB74Z7Qm2tmxq7Go6zELHXrrt+K3PIH7LUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=gKwTdidp; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6095dfcb461so2908447b3.2
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1709162575; x=1709767375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nckZfDK0S69/i5vBndO1rnvQPL2+bpo+E3EUuucu6m8=;
        b=gKwTdidpvHGs1R4X2G2eYgI11hLVE1SEgRijz90BLuoxVcampcJ0o7FRAZKzuH3732
         FRe3PYiLgwUANEEyQ8F6j0xyTTlVuJUVg1OmhEtsL2CG3aBIx+/caB/lhWc1zhUuwvOY
         3kwHOfyh+0hwAwB6tE+mtVcQkRpXu07wNkNCIppB9CE9PZz3FbR8BtRDM1QQDPHHD/AH
         PIvuGwnj0CffW3Qk5jqGc0HCuvNN5oGzf1Mp24EzAWSOfbZhhmcs/KeiBVxrGDJZ9MC0
         f5mj8kPZD0LjrkavNnw7duZp1Fx9nssmW/OUrhOFujjH9nnpc1x66o6QCHQo6kctp2Cb
         qphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162575; x=1709767375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nckZfDK0S69/i5vBndO1rnvQPL2+bpo+E3EUuucu6m8=;
        b=nRyEjRJSRKVV8ymrajY//IF8A9x5etrwed+UMeIuZNp6ADdRrDPBvH8DeCsIQlAabx
         Mr0pdkqSsFBdWEnYdJl1upVZ0cJs9tas3TDTRo5q650Dx8u40sWgJykR7Tgv91V2fxk9
         kMTCE0fuhro/jga8zA/Hfgo6Lo+ZKUgMUUoiHawVo7ZI6vLKZtLY0Q7Uwf2kJIghBFYv
         fHbrzYWsNVJyaSoyIZOAKu09uDHy9eFu7XyNUoT7xB310T1Q2z3EMQJg0PpDgknKAFDb
         mvim7iZs78PUKfhIAgFFBRoq6NF1G0FmsQMqkDPai3S02AFyBJvJPzfMDsWA0vrXvW9E
         D08A==
X-Forwarded-Encrypted: i=1; AJvYcCU5pFTrfvw7EnMgaE/zf5otHLMB1cRLIsZGKGKR6ZsMn2O/5c09916q+XenapoJki2FJQM0LKm/QarGMR3GNtUbyQ+dRmRV
X-Gm-Message-State: AOJu0YyUIXUyePHrzvWz/B6fUW89i9aM/gSJcG0U/wQZGTU+k6K7vKjf
	VQbUkoW8m8tFC+YtcE+MkNOggvjg1IxCA0kFEoVjOA7So0F8g+mhbf5AXaeC764=
X-Google-Smtp-Source: AGHT+IGkPHDu5f12jkTcALkhWm11YCExTUiy/juOV3ymGE+gSgkrSzDP+ICaw5YpJSBLDshBUrJu2w==
X-Received: by 2002:a0d:ca45:0:b0:609:1cc9:a4c1 with SMTP id m66-20020a0dca45000000b006091cc9a4c1mr561582ywd.24.1709162574891;
        Wed, 28 Feb 2024 15:22:54 -0800 (PST)
Received: from localhost (fwdproxy-prn-012.fbsv.net. [2a03:2880:ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id t130-20020a818388000000b006046bd562a5sm26216ywf.128.2024.02.28.15.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 15:22:54 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	maciek@machnikowski.net,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v14 0/5] netdevsim: link and forward skbs between ports
Date: Wed, 28 Feb 2024 15:22:48 -0800
Message-ID: <20240228232253.2875900-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
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

I ran netdev selftests CI style and all tests but the following passed:
- gro.sh
- l2tp.sh
- ip_local_port_range.sh

gro.sh fails because virtme-ng mounts as read-only and it tries to write
to log.txt. This issue was reported to virtme-ng upstream.

l2tp.sh and ip_local_port_range.sh both fail for me on net-next/main as
well.

---
v13->v14:
- implement ndo_get_iflink()
- fix returning 0 if peer is already linked during linking or not linked
  during unlinking
- bump dropped counter if nsim_ipsec_tx() fails and generally reorder
  nsim_start_xmit()
- fix overflowing lines and indentations

v12->v13:
- wait for socat listening port to be ready before sending data in
  selftest

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


David Wei (5):
  netdevsim: allow two netdevsim ports to be connected
  netdevsim: forward skbs from one connected port to another
  netdevsim: add ndo_get_iflink() implementation
  netdevsim: add selftest for forwarding skb between connected ports
  netdevsim: fix rtnetlink.sh selftest

 drivers/net/netdevsim/bus.c                   | 145 ++++++++++++++++++
 drivers/net/netdevsim/netdev.c                |  53 ++++++-
 drivers/net/netdevsim/netdevsim.h             |   3 +
 .../selftests/drivers/net/netdevsim/Makefile  |   1 +
 .../selftests/drivers/net/netdevsim/peer.sh   | 143 +++++++++++++++++
 tools/testing/selftests/net/rtnetlink.sh      |   2 +
 6 files changed, 342 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

-- 
2.43.0


