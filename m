Return-Path: <netdev+bounces-88803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3C88A8943
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7731C230B8
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929E517106C;
	Wed, 17 Apr 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="3AjlSqqT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497B14885E
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372360; cv=none; b=NLibVyEqBYqxYHqZ4iesyzkPIlfTw5P5Nctbms/LvBSqKkoGcZOMipKvquTu59QvQ3xsBjpKiLtpSBJq9NGlgXj/zCYsqFm3sdQFDsgcoVrFdfOGtVt7IXgLJGMiH3CVINMYh/BrdE4ILb5MP3/bxWTNYn/mt4gliSBDXrs9AYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372360; c=relaxed/simple;
	bh=Kaak7gu3fcnDB6M+R04jt8aBqli+cY8tvRZ14TKFYbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXS24utAyCgfPl7gwgulx167Pha0smKVcy/qUYE3eRc1nEhwIzZaTH/uGwI9ENa0gR3SaQWXZKaYcDrvvqe7xTkFKEX1k0osPUw43P3VtSLMCa6f8alwzQwi+W7xJSHZ+q4PAy9XmIQ7wdNrbTNs2bUFdW9LovbmUNfoU8KFQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=3AjlSqqT; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5200202c1bso774442066b.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713372356; x=1713977156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2On83QUGJlRF1XkVFp7hMz1f3aFCzDXCcNes5I53Wcc=;
        b=3AjlSqqTB3hzFtQ5Fpy8VSXJ2nYCCcr9lf3vExf62nqG29wznlfFqtzk7nNeAc82Mo
         hoQFR6l8rxGfy2xayqU2kIrPNDXaNxI/6xE9NnaCaoxXZHgKlF4J7KWZoDcR9ehciNAD
         mQFyulft4C2GOjPh8JlVwxJGUTD3k9sVSF+1o3A9h20vN5d4CkDJ+ICkUhJdpg5uZ0e0
         RK2oob1k/CMQtojsae9UhyRK090uxjcr+iFWBPPO2lkPlr7AYw8FfsylTisQqBhFHRWQ
         x250zDTM+z8oefONUBzfQUQqSqX+rwCOQa/RFBaYy3IKYhNpKykLPfmNw74urM4AQ/kw
         8iLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372356; x=1713977156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2On83QUGJlRF1XkVFp7hMz1f3aFCzDXCcNes5I53Wcc=;
        b=wwFnzDtMyTjNMeuX6Wk4MbX/RKc9BqNcyB5oC29paEE8Wvt5oZgva7JNqd6xJrxCf0
         irB8seUrKO1wo2iju0+G2zlx92HiXveRzuUKsR3WIzgU4k+n1TKvtvPP2VIUG1b2cuIl
         uJEaL0J4egRmxjpG1knIfvwFvgbXlI5OLXy9ZldapKQivmIHO2MRwRgRa5i6QgWv4ikF
         6WLEBHn24sQ5Eh7L/L9Am7LgMXUfBodvjAJCeiKopJW1HcR1Ew/g8WvGVKsMwacL2bFi
         P29nZh6YPeuwMsb5OtCVySBVEs3bud2veRsIBdgs4UMSd+F7hexObdmYlcsBgIDfrO7K
         BaMg==
X-Gm-Message-State: AOJu0YxDOF9udyEG/55ESJNUrppOJOimqYtR8GlCssnqsV3djNTsKspV
	dh1GIdEh2w9y++oNvBg8QRABuOwnugpS1omyRaPl39u3RMBr9KUwLH/JGx61/aI+zcH5zP1Efov
	N
X-Google-Smtp-Source: AGHT+IGPz1iUONHNxGqyZENzcyphI2D6dmYmARBbsyyMaiEn1s59CyxQOgOVJdVozIW7fs2g88i3SA==
X-Received: by 2002:a17:906:46ca:b0:a55:6534:8035 with SMTP id k10-20020a17090646ca00b00a5565348035mr58491ejs.11.1713372356110;
        Wed, 17 Apr 2024 09:45:56 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id y9-20020a170906470900b00a51a74409dcsm8397278ejq.221.2024.04.17.09.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:45:55 -0700 (PDT)
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
Subject: [patch net-next v3 0/6] selftests: virtio_net: introduce initial testing infrastructure
Date: Wed, 17 Apr 2024 18:45:48 +0200
Message-ID: <20240417164554.3651321-1-jiri@resnulli.us>
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
$cat /sys/bus/virtio/devices/virtio0/features
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
make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests

It is assumed, as with lot of other selftests in the net group,
that there are netdevices connected back-to-back. In this case,
two virtio_net devices connected back to back. To configure this loop
on a hypervisor, one may use this script:
#!/bin/bash

DEV1="$1"
DEV2="$2"

sudo tc qdisc add dev $DEV1 clsact
sudo tc qdisc add dev $DEV2 clsact
sudo tc filter add dev $DEV1 ingress protocol all pref 1 matchall action mirred egress redirect dev $DEV2
sudo tc filter add dev $DEV2 ingress protocol all pref 1 matchall action mirred egress redirect dev $DEV1
sudo ip link set $DEV1 up
sudo ip link set $DEV2 up

---
v2->v3:
- added forgotten kdoc entry in patch #1
v1->v2:
- addressed comments from Jakub and Benjamin, see individual
  patches #3, #5 and #6 for details.

Jiri Pirko (6):
  virtio: add debugfs infrastructure to allow to debug virtio features
  selftests: forwarding: move couple of initial check to the beginning
  selftests: forwarding: add ability to assemble NETIFS array by driver
    name
  selftests: forwarding: add check_driver() helper
  selftests: forwarding: add wait_for_dev() helper
  selftests: virtio_net: add initial tests

 MAINTAINERS                                   |   1 +
 drivers/virtio/Kconfig                        |   9 ++
 drivers/virtio/Makefile                       |   1 +
 drivers/virtio/virtio.c                       |   8 ++
 drivers/virtio/virtio_debug.c                 | 109 +++++++++++++++
 include/linux/virtio.h                        |  35 +++++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/net/virtio_net/Makefile |  15 +++
 .../drivers/net/virtio_net/basic_features.sh  | 127 ++++++++++++++++++
 .../selftests/drivers/net/virtio_net/config   |   2 +
 .../net/virtio_net/virtio_net_common.sh       |  99 ++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  77 ++++++++++-
 12 files changed, 480 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virtio/virtio_debug.c
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/config
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

-- 
2.44.0


