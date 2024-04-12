Return-Path: <netdev+bounces-87432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAFE8A31DE
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB891C2162F
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC071487D8;
	Fri, 12 Apr 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SGZA2gkh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8871482E3
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934802; cv=none; b=L0VQJkHFVKRXCMP7u98iGn3LghR8yYwgwj9NED3GIv0Z71fKCaSEEfnKdyx68ATZ7is0IhrO10omfhgcJ8OX2dwgE0GvvYd5xyG91g7Xf5poA1eoP5bp20X5VibMT0Y6U5PhNxNZbWTiIGVeNOwg5QbAXfhfjArQV5mIedHb8aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934802; c=relaxed/simple;
	bh=ESzyqtm+jB6HKG59z9sGdyjp37OdGeh0gFmicuYbHwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4sr6SQ6k7b4d2o5JIXIfZv9fkREdB80MiXhihrOCYMGjQsSPwD/1DiNBzV9hmxiduvlG+ysfGqAviHQJUozZi3gf4x5b56fAOl6e4CD6mu/oWpf37pENLhrJydDDO9kRgIK+iHT6hW3k6JTa10KCKBOAjI3ScterL8NpkNGcaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SGZA2gkh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so1270884e87.2
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712934798; x=1713539598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P5Y3OCl0Ya94dXdukJGYcqnaLSv9gvjSDT/1en8tmJQ=;
        b=SGZA2gkhRc/LVsch8j4hsXD+ev+MzkaJtge1MZd6EFf/aStMG/9Q/UIYUg0QfTXIM2
         cg3QN6AvlibmxKGLZCHS3auR0Hle1cIYid2vBdpohXe4Dwx5AQhv95kJnjvCV1Ct18lg
         uPk/tWKmqXdDsonpd0djzTSwOmTE1T3yA7vNlTrye/Lz/ofIvLvibabKsXapgsO2UYux
         mHVabpE+mQTMqeIyw/DksBU3dlloQp3B0H9Czr2t1dgGwNlrbwGUJbeqsNNVhrbiGofp
         aN3UU/dQd6nIEOMfSKiuhKOn3pICxrK4H/fRNTLzPOm6vLQfLq8gSuT4lFLHCiuOvOzl
         JkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934798; x=1713539598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5Y3OCl0Ya94dXdukJGYcqnaLSv9gvjSDT/1en8tmJQ=;
        b=kWdoIvWoseDzXw69onGGNEyOKNNGUgvycgDR9VInqa+hJ16DwD1Ds9rgoZ06vaXZxt
         fuHbJpS71bLKteV11tFbUAoAOZMFsHIIuPFftR6hCFJIc3jhn2/W/SHiJiLEtpWLxAkN
         ODvApFBEL7Nkh1ePJmMuqQVXtkpOME3EKFYVsZ2iWjxR5YL/rV9U2+tiNPbT/T6z/fFG
         XGEdGgsXnwY5f3GvYoHQmJfyTgnA8sS7j5k2Yg8FX4msZsfR7K3IJ2M4w/nrU2ftnex6
         7S6roR0VnMblvapY+03w+lOUAYv9o+1DYlj7+jkaCZI3ZSHwAvRVulGc+EZEWBRb6DG4
         GaKg==
X-Gm-Message-State: AOJu0YwAc2r5CCjL+5wsi8KXKoUy8P6HEPCJ2bBA8wp0fmvtc4oPcgS/
	OnivNwZqINjxxmxlngj2vSizjz78mOUmQcLdalg04u73OwnGweqL4he6DNPJ847B4vndWWZ0EpN
	a
X-Google-Smtp-Source: AGHT+IEnvoqTl0xn9fALHiv7H+KFVt1wiZ94Y1cbktGtRsPcH/xi4CpFt344ob6b4S/CV9mGjJKECA==
X-Received: by 2002:ac2:5e91:0:b0:518:17ad:a6da with SMTP id b17-20020ac25e91000000b0051817ada6damr1733771lfq.44.1712934798255;
        Fri, 12 Apr 2024 08:13:18 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p27-20020ac246db000000b00518948d6910sm88356lfo.205.2024.04.12.08.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:13:17 -0700 (PDT)
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
Subject: [patch net-next 0/6] selftests: virtio_net: introduce initial testing infrastructure
Date: Fri, 12 Apr 2024 17:13:08 +0200
Message-ID: <20240412151314.3365034-1-jiri@resnulli.us>
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

Jiri Pirko (6):
  virtio: add debugfs infrastructure to allow to debug virtio features
  selftests: forwarding: move couple of initial check to the beginning
  selftests: forwarding: add ability to assemble NETIFS array by driver
    name
  selftests: forwarding: add check_driver() helper
  selftests: forwarding: add wait_for_dev() helper
  selftests: virtio_net: add initial tests

 drivers/virtio/Kconfig                        |   9 ++
 drivers/virtio/Makefile                       |   1 +
 drivers/virtio/virtio.c                       |   8 ++
 drivers/virtio/virtio_debug.c                 | 109 +++++++++++++++
 include/linux/virtio.h                        |  34 +++++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/net/virtio_net/Makefile |   5 +
 .../drivers/net/virtio_net/basic_features.sh  | 127 ++++++++++++++++++
 .../net/virtio_net/virtio_net_common.sh       |  99 ++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  88 ++++++++++--
 10 files changed, 472 insertions(+), 9 deletions(-)
 create mode 100644 drivers/virtio/virtio_debug.c
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

-- 
2.44.0


