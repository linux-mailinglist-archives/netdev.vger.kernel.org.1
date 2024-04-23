Return-Path: <netdev+bounces-90445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC12E8AE271
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A591F22BE8
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D0C67A0D;
	Tue, 23 Apr 2024 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="r3cS/qd8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D60E65191
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868877; cv=none; b=uO19j7/PkWUNTgMKR035bAdah6T3wtpYDNpCtdOIc01e0OaSaPzLioOYGle6ZNPiStt9Qs7SCP+LBCMqPavMM4MoDZtssF+/nU2fdrVT3JV/8pLH/6+Ir01pdJZdGCJHeHoC0mJQTkzrqGyaoHLg0320DeUHqJcUKHfAQa6MbU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868877; c=relaxed/simple;
	bh=9q6ouA56yQo0k0bb4TWu0djK4ncNb5Fdytp5WSkJTYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LU6U19JIUqy+2W1qPk62rZvumJ4oWa9KffE02yrpiisFv1eZrTXUMHxYhZl8MrshBifdelBWMoEBVdRV4fzkrpHtEaS0QhtXVdYSQZVzV5qmP1y25AK3iFGLZ5oKqGhc8i7GOGUi7rgdkygX+ZJn18QRIFIHZB6HhFEVvZLsQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=r3cS/qd8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so6638491a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713868873; x=1714473673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMOlDHcF7Ts4yl1h3F9FfhqEWMlZGrfkCOKfoDXKBRk=;
        b=r3cS/qd8EOgEUA4fPxkAHc2cABlFrZbNBhEZcEqfKrVYIhsPPzIIJ9+IZEDiy7TV8r
         +tHisdQptR9XA1YuSHbNtwjiALcAe7LNhPackSQmvPhTLBpXX5S78CtdgtHp8PIDJ6I7
         aZ1Xib5iZH/Gh8VlxWZ2JWwZ5Rm13e21W/Ny8Brh/yLphwGPnMA2tOwsrWQkuSgS0aG0
         5CBpvhTddKl9EOFWu+uP2ob5Q4wCDuKa6oWr9LdEWA8jb+W/cIZDHtdUsmBoq8VQGprq
         CZjILXjuyWbdAkcXmqy4zRRrDocvDg5eikBmrOuCtL64Nud04D6sOdxB9GnnLJmj7S7t
         K8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713868873; x=1714473673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMOlDHcF7Ts4yl1h3F9FfhqEWMlZGrfkCOKfoDXKBRk=;
        b=q1TVbZLMJHScESsFOqEjnjlfuZX+Ev6HUaxRgZED788ReDAeVTi9LOhZZRoq0+rjJh
         p2xP3Knw9iZJrbhHpxdx1nLVjOgiM2VE4dXGte1nhqyo15UyQya6m+zUdBvN6NhayFIU
         i1mMwn5gmrIjqMH/U+l4WsZwC/5/ThdWcgIduzQu7JCQM+7UyTAdc7Vwt+QmBDED3nOX
         N4QioYmhRcP0QgHUVWLFeq6FV9P/+8TZKNSmPq7XU0TLTxQpy9XJViy7atPVCUYh0Bw/
         JdkHWoB6nj9LVqrHBvevDyNPKMfwBVY46HIu2hR080G7fM4wMUIHRSGI33R4N0twXYoB
         51hA==
X-Gm-Message-State: AOJu0YzjTHFmFAqD77u0JGeHT6/Gf8WCy/StkKYDStVkqtzI1+vTCFHg
	7HJI/iYa5UoV1FIrHz6vmZ/3yfDgFIxQONF+rKjfY4r+V69jl8RszEUHDzkKKLn6n3bKfm2r7NS
	E
X-Google-Smtp-Source: AGHT+IF5yOlbCc3XuxtrjYBUXSuLIg6HpzDJP0wTP9amMXONrnEggK9yId+H/FpOrFLl6HvVzkVi7A==
X-Received: by 2002:a17:906:5592:b0:a58:7c50:84e4 with SMTP id y18-20020a170906559200b00a587c5084e4mr1734096ejp.2.1713868873364;
        Tue, 23 Apr 2024 03:41:13 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id qy1-20020a170907688100b00a558be8bc03sm5203755ejc.150.2024.04.23.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:41:12 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	parav@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	vladimir.oltean@nxp.com,
	bpoirier@nvidia.com,
	idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: [patch net-next v5 repost 0/5] selftests: virtio_net: introduce initial testing infrastructure
Date: Tue, 23 Apr 2024 12:41:04 +0200
Message-ID: <20240423104109.3880713-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

This patchset aims at introducing very basic initial infrastructure
for virtio_net testing, namely it focuses on virtio feature testing.

The first patch adds support for debugfs for virtio devices, allowing
user to filter features to pretend to be driver that is not capable
of the filtered feature.

Example:
$ cat /sys/bus/virtio/devices/virtio0/features
1110010111111111111101010000110010000000100000000000000000000000
$ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
$ cat /sys/kernel/debug/virtio/virtio0/filter_features
5
$ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
$ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
$ cat /sys/bus/virtio/devices/virtio0/features
1110000111111111111101010000110010000000100000000000000000000000

Leverage that in the last patch that lays ground for virtio_net
selftests testing, including very basic F_MAC feature test.

To run this, do:
$ make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests

It is assumed, as with lot of other selftests in the net group,
that there are netdevices connected back-to-back. In this case,
two virtio_net devices connected back to back. If you use "tap" qemu
netdevice type, to configure this loop on a hypervisor, one may use
this script:
#!/bin/bash

DEV1="$1"
DEV2="$2"

sudo tc qdisc add dev $DEV1 clsact
sudo tc qdisc add dev $DEV2 clsact
sudo tc filter add dev $DEV1 ingress protocol all pref 1 matchall action mirred egress redirect dev $DEV2
sudo tc filter add dev $DEV2 ingress protocol all pref 1 matchall action mirred egress redirect dev $DEV1
sudo ip link set $DEV1 up
sudo ip link set $DEV2 up

Another possibility is to use virtme-ng like this:
$ vng --network=loop
or directly:
$ vng --network=loop -- make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests

"loop" network type will take care of creating two "hubport" qemu netdevs
putting them into a single hub.

To do it manually with qemu, pass following command line options:
-nic hubport,hubid=1,id=nd0,model=virtio-net-pci
-nic hubport,hubid=1,id=nd1,model=virtio-net-pci

---
v4->v5:
- added exported symbols into patch #1
- remove original patch #2
v3->v4:
- addressed comments from Petr and Benjamin, more or less cosmetical
  issues. See individual patches changelog for details.
- extended cover letter by vng usage
v2->v3:
- added forgotten kdoc entry in patch #1.
v1->v2:
- addressed comments from Jakub and Benjamin, see individual
  patches #3, #5 and #6 for details.


Jiri Pirko (5):
  virtio: add debugfs infrastructure to allow to debug virtio features
  selftests: forwarding: add ability to assemble NETIFS array by driver
    name
  selftests: forwarding: add check_driver() helper
  selftests: forwarding: add wait_for_dev() helper
  selftests: virtio_net: add initial tests

 MAINTAINERS                                   |   1 +
 drivers/virtio/Kconfig                        |  10 ++
 drivers/virtio/Makefile                       |   1 +
 drivers/virtio/virtio.c                       |   8 ++
 drivers/virtio/virtio_debug.c                 | 114 +++++++++++++++
 include/linux/virtio.h                        |  35 +++++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/net/virtio_net/Makefile |  15 ++
 .../drivers/net/virtio_net/basic_features.sh  | 131 ++++++++++++++++++
 .../selftests/drivers/net/virtio_net/config   |   2 +
 .../net/virtio_net/virtio_net_common.sh       |  99 +++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  65 ++++++++-
 12 files changed, 478 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virtio/virtio_debug.c
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/config
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

-- 
2.44.0


