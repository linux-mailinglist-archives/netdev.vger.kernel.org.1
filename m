Return-Path: <netdev+bounces-88051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D398A57A6
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D86728289E
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6957F7C1;
	Mon, 15 Apr 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jnJwYqzz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8201E535
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198338; cv=none; b=SaZEQ0uDVy5JoD9+kjaWzafK9Wb4Zj05j4cV5O6GqjInhnBzPRuted+rVRRc1iNgU1CSZD4EyGatUkqEQWJsqIYXdcu+D2t9qJB/wDuiRwbFwADz+enY4W3HDM1445mX3Pcumv52jGp644WyTsVaqTZkJFdhUeAA95XquwPgnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198338; c=relaxed/simple;
	bh=HrY+6R14sldOiILXyUI6rqVVYTPxkUH6QtJC9oVISG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GEklve+YK2EH9X4yB1B5IApJtB23sZ2li/1/qD7/Y/nEnPxtts5Q3l/a3U8+pN4IEY3Xs5Iw6mfbZCP/gGTTEx4y1mmVBYDVeZ325Z9sSWmymXaMkQScT+VxbswhnUFRDFIFWWSlFpsQrcH5KomMKpuPwtbWS4AlYZryRVUXueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jnJwYqzz; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5176f217b7bso5899834e87.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713198334; x=1713803134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+w5L6fXt4Mw80dA9l9dnOlWTsYVxq476KcvcT8ApIw8=;
        b=jnJwYqzzcrcpYnLoYaZeIPftDarnJz/OoNiLU0XK/8Hn1n7yK86oIXOIAM8fo5owze
         H0l3rcgeMYoX3rnlk7rLjYhnjAVmpCksVaOmJeYpqH6RcbrpYRuxcc58JqUC2uR5Nf5R
         6HZQegV9/cDD8WybnPJSKNOWykGyCqwbAWPQA2mCeYKnnXn9h+skoNMMJSY5Y8BAEifh
         zRav4v5lqGMnjE0dbgb5jzB0FOiCADyPImYMyVulMsva5ggzsZvnTDKh3a2MRGT2pPXo
         qNb1bs2qitAj5D2xOI9Pbvaqe2lZIAqaks2a8xE3hhJzDI49u+sqHhcd5mq9dQZjZivp
         bG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198334; x=1713803134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+w5L6fXt4Mw80dA9l9dnOlWTsYVxq476KcvcT8ApIw8=;
        b=dNcqKSz4RfrVZjIhve6G/MqK3DjIlb3OrgvIBufYssXCfDDdHCOwTtue1qQfwpPaQl
         GyD4dppVC4pOJhaZGk9iOnCt6jEvOEvVb6FQtvyWeu7O1NTJc/Grhs4BtzEDH/mDGXTl
         huayXxoe3NjCLvNW3jBi022rDSRbnY73pKDzeOy/AErOnjKNjEtzObyTmwWkJ1AsK+2u
         D1k6YTl4QSgzvrUxuNxV1Gbw0uYBajAzitQrrJ81x7Z4d16l8/MXbE+jnDUqRLX6cOMT
         XypSFU8Zt7K6kwvKA4yP/B1miGfZud4eO1JFYWf2pbAjt6MgS8pxXCQj6sscCWTLZOds
         dQiw==
X-Gm-Message-State: AOJu0YwVnW0kdeN1TTlHeOb+m6mfVGrrPIil1zBrRqc/TXofbpwSBhue
	G521CnBD0xWORCVHVbUQt9ZBTqmWT6MmaHlzlcupkdWpjHCovHeoQerOUiL+EiWjk/XPa3/ceU5
	D
X-Google-Smtp-Source: AGHT+IGQILVfb1rNV8SkbAhFTmCq5jbu6EYEDdqL0R6Ojgrbn/4ssrIeL5JM/wj71/IB5duAnmy/nQ==
X-Received: by 2002:a05:6512:10c7:b0:518:c82a:bdf9 with SMTP id k7-20020a05651210c700b00518c82abdf9mr5635913lfg.44.1713198333772;
        Mon, 15 Apr 2024 09:25:33 -0700 (PDT)
Received: from localhost (37-48-2-146.nat.epc.tmcz.cz. [37.48.2.146])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063f9200b00a523cf3293fsm4181949ejj.59.2024.04.15.09.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:25:33 -0700 (PDT)
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
Subject: [patch net-next v2 0/6] selftests: virtio_net: introduce initial testing infrastructure
Date: Mon, 15 Apr 2024 18:25:24 +0200
Message-ID: <20240415162530.3594670-1-jiri@resnulli.us>
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
 include/linux/virtio.h                        |  34 +++++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/net/virtio_net/Makefile |  15 +++
 .../drivers/net/virtio_net/basic_features.sh  | 127 ++++++++++++++++++
 .../selftests/drivers/net/virtio_net/config   |   2 +
 .../net/virtio_net/virtio_net_common.sh       |  99 ++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  82 +++++++++--
 12 files changed, 479 insertions(+), 9 deletions(-)
 create mode 100644 drivers/virtio/virtio_debug.c
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/config
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

-- 
2.44.0


