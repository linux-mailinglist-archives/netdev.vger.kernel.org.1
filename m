Return-Path: <netdev+bounces-90852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D188B0784
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 12:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE831F23A3A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA00159570;
	Wed, 24 Apr 2024 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="o0XU3tGv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0B158D79
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955260; cv=none; b=RZon9TFhHZeAZqb2eUsuASuVOIahVpoMnvYI4VMnwrTgu2pCe2Wewcmy0DpPG+qcqWDXbe06UuUPxDh6hWHTVVD/gZfBKMOQeJkbDarlfKECYVNQxDGZwfKRGKQSEmS14D8xbv8rEofyJGSQiKkwO+f7pmdCQPfYgjYp2b3yxJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955260; c=relaxed/simple;
	bh=9JcMIim2AxGlmts+KkFUqqLwHcgOQ7OvJ2AwErYMn/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uha6Z6vEdlV348xdOGTt0aEDxIVEKFQDH/BSj1Smnh8Retw65Ds2VqJIt5WO1qMzoX/jMUOczgLG57ln6clCocUIpGCl77dQZHURjZ3i7GKxubO8Hn+ljs1ntUXr/9YLYamuqD4JNpISnT/mBP/07XtcaHNnlxBY2RbLv6GFvJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=o0XU3tGv; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5193363d255so8871952e87.3
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 03:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713955255; x=1714560055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4+OySXqohdnDZrtl87O33OEWoDiUo7Nu55zUTWNpdQ=;
        b=o0XU3tGvrHNKIQAXoJKzA1yNuz2WSua2wyv4XxwX8EwJz0UWFC+f5KekXBXd0KvY5u
         zXD8ij6DF+5txXF4r1vogmy4LBIzWTBRFQHQos/YCAdJw3lnHyz8J63n+0sLDiIDapTa
         iUiPDlv3b/vETtF5nuF5T+cbA6WtK9jk10fIVdWQSDzI2etNcFELYcBMGUUEu6faM2TC
         AbWe5KWwXvOB/xQDCaH/JtS+hChSV4oSmDxpOGOllsj1STBzACoBx2b4gGRwEtA7Pk8O
         vQPimcJ9ZppKuMzFD1oThOVzdk3JwIJD5fo4zYvmt2ocvD6oFuC9b2oK6lhjOsLcDjra
         pHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713955255; x=1714560055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4+OySXqohdnDZrtl87O33OEWoDiUo7Nu55zUTWNpdQ=;
        b=VlRUsF/ky5gPkeMRPYZ9StPGkHcyK3npn1q+FDnLOZ2bs6f09wBsu+w2C/XKtuywkC
         du5Cnh6Osnd2rR2BnwMYBZfYs2hLlF+NH/8TVWgrGNcNtFEtrkcZkvHgrW2SO3bE8VX9
         +JUFJGEzcPQUqCQhYvOsI0SiZw4QzZdnbsUcDHeqq5I+AvK9VUAxSQ8RihJQKT+uyigR
         OSJX0nrzkQ3ETnzdi8LcsZgFxrxTcSjy1lyvLy3seCPYdPqSiStpirNayJiS793Nix01
         9hJIt1fRjU5+y5/76VHNWb1syNlYZ3DS0Auy6WQesYRJATFvGAucGbEsZ5ulvdZxElyr
         +4QQ==
X-Gm-Message-State: AOJu0YxK0rOwyhPFo3CXtYQivgdIzMlNlEvH5PFussH4/KGaafR2uIuc
	Xp2jNoiscl6BorP3NGkAZzcNQgUSCWdfA/YJJfmJg0udY7iIKXRYNK40sDfva/fFmWMXSXR3d0B
	8xsQ=
X-Google-Smtp-Source: AGHT+IEVnEntDH1vJfp87AhxZXLdAyKx0mTX7w/yogKylLbcds/KRI+5bBmfwFbUvWc2d5luW9bLrQ==
X-Received: by 2002:ac2:5e2b:0:b0:516:a6ff:2467 with SMTP id o11-20020ac25e2b000000b00516a6ff2467mr1413194lfg.0.1713955254731;
        Wed, 24 Apr 2024 03:40:54 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id kx18-20020a170907775200b00a57e2d39d56sm2730454ejc.223.2024.04.24.03.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:40:54 -0700 (PDT)
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
Subject: [patch net-next v6 0/5] selftests: virtio_net: introduce initial testing infrastructure
Date: Wed, 24 Apr 2024 12:40:44 +0200
Message-ID: <20240424104049.3935572-1-jiri@resnulli.us>
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
v5->v6:
- fixed a rebase mistake in patch #3
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
 tools/testing/selftests/net/forwarding/lib.sh |  62 +++++++++
 12 files changed, 479 insertions(+)
 create mode 100644 drivers/virtio/virtio_debug.c
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/config
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

-- 
2.44.0


