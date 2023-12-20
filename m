Return-Path: <netdev+bounces-59122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E30581967E
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 02:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275B92884FF
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 01:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5A7488;
	Wed, 20 Dec 2023 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="qyYwjq/n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3265A79D8
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 01:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d728c75240so2717535b3a.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 17:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703036869; x=1703641669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ROxVQkx9l0kjEx3MjfcjpHmcSftmEdNIq+Od9JRmTkc=;
        b=qyYwjq/nOUhj8tvhW+wDjOXXZb0QVPnMU+ojzh8AUcO4r0N0JHvrRQDxSLFHp+/U/G
         sJQXsDf9qEWxUUu4sfiKL8G3jlVjL8ghWQoPR1rpqD9HAWHWuQd9OHzkfRQJjimVn3RD
         nYPMDHS0STBBwBK1cfMQ/fAgMiNahPWCVqlwQE93FY/ggUgqmgke4KpE2XPUsF0tVzFn
         n0xGxtass6khY9ONYCA9sMez5M0LVRyFtpb6s7o369RGP/34FpN4SCs+TgbgOyJZBdWP
         FsHYYX5b/9vBe5k6kykM+KVUvQM/0CSV16VZXftjiDw1wm4PXvVsPgNH/ygMBNfKJoIB
         W6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703036869; x=1703641669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROxVQkx9l0kjEx3MjfcjpHmcSftmEdNIq+Od9JRmTkc=;
        b=rxvUQQE+1mD0IGLZF0HSE0QV41c6fDwexxhutU2Kdh2jSVgEHDCst2tVGAXIscCOBo
         7SWTij5K0eIyw9qxjEjVNhZ3KsJPSfHwslRG5Oy4Bms/r8uO4sCe5JHcPHXHbXLqdktg
         bwylqVf5zh22Kpy5AHujoce33oRAMZFuz7WHUwODP3FSPfBVU2u7CG51jOT0NJAnULSa
         Fekt9Z1DF7bR2NIVki5jhhba8C/jkmk3BUWNCMOULWzMT7wcrYwPo2G1MwLUhOAFAgbN
         Z46zZHc4FVu40D3Z3Q842ErcALJ9G9peNk5hp2eOTU18fpJVC0HFJBZoN1go0ixDggu/
         lDJw==
X-Gm-Message-State: AOJu0YxxR30Z74rcWEfYF3rn8EOvFEIrTbK+3ySSgw/GYySIS0mqI7Lk
	QHCM3Mfgv7aCkpUB4u/EDZBv/BCeuFktzUbEpRI=
X-Google-Smtp-Source: AGHT+IHv81pUXy77Vls8NrmxKAC/tiUHrWtxyujKGrqLNPPXtzNTVBtMmGO0eHLs3oal58EauyKNUg==
X-Received: by 2002:a17:902:d581:b0:1d3:7f26:b3b0 with SMTP id k1-20020a170902d58100b001d37f26b3b0mr13192906plh.104.1703036869425;
        Tue, 19 Dec 2023 17:47:49 -0800 (PST)
Received: from localhost (fwdproxy-prn-005.fbsv.net. [2a03:2880:ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902b70400b001cfb971edfasm21689929pls.205.2023.12.19.17.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 17:47:49 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 0/5] netdevsim: link and forward skbs between ports
Date: Tue, 19 Dec 2023 17:47:42 -0800
Message-Id: <20231220014747.1508581-1-dw@davidwei.uk>
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
  netdevsim: maintain a list of probed netdevsims
  netdevsim: allow two netdevsim ports to be connected
  netdevsim: forward skbs from one connected port to another
  netdevsim: add selftest for forwarding skb between connected ports
  netdevsim: add Makefile for selftests

 MAINTAINERS                                   |   1 +
 drivers/net/netdevsim/dev.c                   | 144 ++++++++++++++++--
 drivers/net/netdevsim/netdev.c                |  31 +++-
 drivers/net/netdevsim/netdevsim.h             |   3 +
 .../selftests/drivers/net/netdevsim/Makefile  |  18 +++
 .../selftests/drivers/net/netdevsim/peer.sh   | 123 +++++++++++++++
 6 files changed, 304 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

-- 
2.39.3


