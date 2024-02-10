Return-Path: <netdev+bounces-70699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56A2850136
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6AFC2845F0
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D99437A;
	Sat, 10 Feb 2024 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="LNHePTzX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70141FC8
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707525180; cv=none; b=tPXxoXTT8NYCN8o7B9x1FElSdRiZW+rqPUzli3KTYpqWiE7cXYXeh2Lf9FWkqG82Abnrrw2LtaWKWvn68boAOEfXv2Ibi+opUSu9kO/sUgyS5Pl6slITMGcMgZcmDGoSLQdJzLeHlFHuRKNxMJPGnrR+CmXpTNZ2srndWVmxNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707525180; c=relaxed/simple;
	bh=EaKPiI+nivfhl4fiTk5c8pkyDdRUGth787HTYFrVUAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qmAKSu2NRdU+tBlpVemeQ7sQIHG4jaOF8SDqABYSIj7dIgSEQP8xnBhqVOAOZbWsAU6rUV1PE056ydPbslV4wjHg1KxmDNrXEDTKxFE4vgGhNq1BSUa7JFKOjIoVZPFcyAZgKMG6KAtIcRkfVQ0P1YzOicdbI+E7g1xc72goSIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=LNHePTzX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e06c06c0f6so1658808b3a.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 16:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1707525178; x=1708129978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jdO+Hg5YatEPTMAW6xaPa/sAkfgO0h6Tg240SVkOfMc=;
        b=LNHePTzXFcrazNMUh9oIoCrmqSqQGwPAAsXdMm5UxPbsmjbgkru8M+cOSAJQdDrf+b
         Nsx9iiJscUksdQVCfJ6b8yZ2nhEMsgQI68MTgxkSJ7YCp74vPUlWI/JTsoUXMmZZunzI
         PuW6sD0YNoCdlaqS35kdFmPVm00ZyEbHPf/zpqgu9VBFXen2moqDRsebdXZu6pMcpweQ
         8ukjC4CR6FzcBfqeIYbX94ykEUfg2Axm4hO5CfcS/8hrFvDfCDSixUt+qYfvuaaj3nnD
         dHDZX7tXaglJqxbNXry8PgnZEtlaFyitPPzDGvmQQOM7BH0Jg8V7qkkj8sr9d45v6Jb7
         u92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707525178; x=1708129978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdO+Hg5YatEPTMAW6xaPa/sAkfgO0h6Tg240SVkOfMc=;
        b=vj5upa3wT85B5ipvjTknIQ2y1fqPrkAmOp9XYNdQqMMRHw6Ux5pnftKCzbBATEU3by
         HBAphJhJ8C44Y3FXqZk0vNHm+NOxQ/A9GuuCg3l2ftEv6yicKlLjPSZg4zOn4jl9jfWx
         hQKyxeEcouBgPyUpkjI46sq/0zpHZkv58EPlKpQLZeCvV5vahnckETAelb9kKuHNw2LX
         ocyPv/qVzJZzy2m9I8zXkJ9PC4dgWrXXC2HeilAMirOWgl+biKM8JQUhj+qgUoi++EUx
         3pgZAXk9XKjAMHFrGlEajDoTyD/W5ZsB00U+thsqrtt2SRlMFvvUbL9EcCTitc4H61VW
         EpWA==
X-Forwarded-Encrypted: i=1; AJvYcCWuGL8dVZeYdryb+ntK1bJiJal2gAdJvWlJbtVva/b56I0q8T9eYCeS/qVZacSxHAu6wH02PPF1dvabzDw5TA+DIc4Vz3Ku
X-Gm-Message-State: AOJu0Yw4JMinf+ivN6Y0NN+tcApUWEfudEaKLIP5IOwAK2EyKRLaM1VI
	qSzxrgojqUNhNIF04rXMfT/IrOxFXFRYzGNfss1Bt2lfGgcUybePVByUJFSXAcg+I6uDYOcDPNk
	R
X-Google-Smtp-Source: AGHT+IHqXROh0Ojtc5v4yzuYHkN0JjynXWgYOmlwQ0iJyApFcJKq2eGmBarYl81oTC8p51vY6YJzFQ==
X-Received: by 2002:a05:6a20:9f04:b0:19e:a873:9252 with SMTP id mk4-20020a056a209f0400b0019ea8739252mr1072100pzb.6.1707525178056;
        Fri, 09 Feb 2024 16:32:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5Y5d7CeyupZ5nURDx+8fLiNjKQa4BcchzyNgAg0seJK2XiciT/5VN9YQ5Kc9HqJ6zh3JDgbPGYfbdbNMEKPU8pVyHaKHlQ+9cPB52zS/03T8LT/LHStqZeJ0lXLij+C5bKsfhqtOV+6M8oBrcM1pxtl2qf1N5U24tUAslvkBhLTu0UUYiGfj0zFqWZv9VumEQlXNe
Received: from localhost (fwdproxy-prn-009.fbsv.net. [2a03:2880:ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id ey7-20020a056a0038c700b006e0322f072asm1152956pfb.35.2024.02.09.16.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:32:57 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v9 0/3] netdevsim: link and forward skbs between ports
Date: Fri,  9 Feb 2024 16:32:37 -0800
Message-Id: <20240210003240.847392-1-dw@davidwei.uk>
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

 drivers/net/netdevsim/bus.c                   | 135 ++++++++++++++++++
 drivers/net/netdevsim/netdev.c                |  38 ++++-
 drivers/net/netdevsim/netdevsim.h             |   3 +
 .../selftests/drivers/net/netdevsim/Makefile  |   1 +
 .../selftests/drivers/net/netdevsim/peer.sh   | 133 +++++++++++++++++
 5 files changed, 305 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

-- 
2.39.3


