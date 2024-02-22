Return-Path: <netdev+bounces-73880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C4A85F0B6
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 06:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2C8B23B2F
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 05:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0861C63AE;
	Thu, 22 Feb 2024 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="JbEQVDAw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E95244
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578524; cv=none; b=IJd43u0zjaN87Xaqwe97faOxNZX0Upo3BaZq4xWBbkmk+Z+3CwwQ6Dqn8ovse3qYm8WEr4srA2/5wqhdM9dqKQ+V8mwaIDrGbtlc5CYn6CLYNiAuhaqpKUv9Qx3UihfnTOEXwIcejkIvidqY771DOm5vT6iA5eJMSGt6Cx16D5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578524; c=relaxed/simple;
	bh=od21S8LcwTeFEF2bc3CaQF0Vx562Uy/4QnJETSuolss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ihvP2Rpnol+lpcvCQO7LfBb4Rnkr/UIOkeWjrqAGX/qgRahy8U6WrGocAaGxoMaMwKTE06XTAovUFdSyYNV5fCP9YWAp6WutCRBd6ZYgA38z6IDbQmFvX8VYqgbBsG8QPRHb0/phy361DRrRyCPgsC98IIvgQYr9nZrKoe+1eHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=JbEQVDAw; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a0073ae310so1130484eaf.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 21:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708578522; x=1709183322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Qr3nlRkqcY2g+gwQ5N3bOwJ9F5ygZx7n7GWqMZgDKQ=;
        b=JbEQVDAwuJGO7aSNdZoW+8xfITHh9gy13xDuXz0wPq6pmXh7pZknWrs0O7f7ti+pX1
         0UIlAD7XAJRQpxcXWx01u1SidtlNznfjk4LwobXfH0hO6Eh2eGSXJP5ggRsN5Fw+NXJ9
         W8u0xoQCIrpeXHH9jVeTDOF531V+U5XRxUWIVrk3bkK/iMONMkmsL5DG3TX7a0fKyARn
         lo9sxdKSBeJCt1P7WBal7JJl/FAbOhwRyB1FxCAV9JWgM4TiLELpCHgly0SFWzruWQvP
         PMFVE/GO5aqnFap+9SEU1Eu/i49ZRzjRQyjLC+6zvzKPFvQYYZHRX6oPl1f9JdoB+5jp
         fRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708578522; x=1709183322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Qr3nlRkqcY2g+gwQ5N3bOwJ9F5ygZx7n7GWqMZgDKQ=;
        b=XJsZQXNEuLGT6Nd5IdOJBSsAwh0nInmPBfPy9tGWq08y0hMyBKr6amRReK0BY38MiU
         Ygj2n3DenxzhtH9Ixm70c1SaEgS7EeMBkfg+yMLDsfDYpj7dQzpI2SEqaILLb8fSFt1w
         lK8oeTqzuim3bYxSYQgbHO+I1tCyhZ7Au0lDctpBL5u+URBfyH2LecZrgZ3s+Lavxm50
         vMYm5p4sXwzGrnWZ4ypZtQxlbKKXteo07EFno5WyGWLjuSa10OeATfAskG2eyzD/Q6wi
         kmS7CNNn7HxAlJBcv9HJqDF3ulC2nflXojSf/Wmdgq82pQl77xdGTTefVc+SIAgDsM1u
         jqrA==
X-Forwarded-Encrypted: i=1; AJvYcCVeksvLgcnKZvRWNKI7PHBByyIpKKuggP6iGVTEgCovC9EgZrqV36MMOovB6aBLlvvj3cG5DCl8XaiYnC8vEI/AKsldkb5V
X-Gm-Message-State: AOJu0YwWVjEXUsLIHyUNNcJp6nrcOou50ZB83aofz3Erf2d1lmc+AoS+
	eSt3u3FQ9xLjtqnajPcEyaC9rInwqOe5qfqB6+/Ytrl3E4xinWXU0E+wKC9lsQE=
X-Google-Smtp-Source: AGHT+IH4NCoJ7J/u22fhE9szbWxzFACT/1wRCOyrUci1MHnDbURKkabROHiF9f3WGcxBazj6e+ARkg==
X-Received: by 2002:a05:6358:5695:b0:17b:5cba:c1e3 with SMTP id o21-20020a056358569500b0017b5cbac1e3mr4402006rwf.3.1708578522304;
        Wed, 21 Feb 2024 21:08:42 -0800 (PST)
Received: from localhost (fwdproxy-prn-007.fbsv.net. [2a03:2880:ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id p4-20020aa79e84000000b006e13e202914sm9816837pfq.56.2024.02.21.21.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:08:41 -0800 (PST)
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
Subject: [PATCH net-next v13 0/4] netdevsim: link and forward skbs between ports
Date: Wed, 21 Feb 2024 21:08:36 -0800
Message-Id: <20240222050840.362799-1-dw@davidwei.uk>
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

I ran netdev selftests CI style and all tests but the following passed:
- gro.sh
- l2tp.sh
- ip_local_port_range.sh

gro.sh fails because virtme-ng mounts as read-only and it tries to write
to log.txt. This issue was reported to virtme-ng upstream.

l2tp.sh and ip_local_port_range.sh both fail for me on net-next/main as
well.

---
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

David Wei (4):
  netdevsim: allow two netdevsim ports to be connected
  netdevsim: forward skbs from one connected port to another
  netdevsim: add selftest for forwarding skb between connected ports
  netdevsim: fix rtnetlink.sh selftest

 drivers/net/netdevsim/bus.c                   | 135 +++++++++++++++++
 drivers/net/netdevsim/netdev.c                |  40 ++++-
 drivers/net/netdevsim/netdevsim.h             |   3 +
 .../selftests/drivers/net/netdevsim/Makefile  |   1 +
 .../selftests/drivers/net/netdevsim/peer.sh   | 143 ++++++++++++++++++
 tools/testing/selftests/net/rtnetlink.sh      |   2 +
 6 files changed, 319 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

-- 
2.39.3


