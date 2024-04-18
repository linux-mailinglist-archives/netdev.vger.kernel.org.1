Return-Path: <netdev+bounces-89297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD0E8A9F9A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D2A1F21670
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E0816F84B;
	Thu, 18 Apr 2024 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="td3R2/Hz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3916F859
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456519; cv=none; b=l/gAlpLnc/1n4TKUjsL0WJm11e6s229SK0JHMrCNQ1bP7W+LhjvpJHQDKoiIaVrFalQe/VMsiqqqqjv9YfmHdMMpShk8hjfw+3LFiFeLuGHmsMV3wvHL7bhz4riSjEGWEeTb+Idy/nQFrYoeEBd8SUA9kdB+AhQXSbq1sqKbIFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456519; c=relaxed/simple;
	bh=weDIBLryWoYrugAPESMToLdD2SzxslmL/6FZdua4c/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCXtwUt6CyXGM2RzoynksnWnRgHMsNZoqc5k0fVGU82tHqBpxyst19Ihbmxuj8DYYA/QGxBXWA9gG0Bm9zB9W9uvWCPben4qdwC4MNejdEqbs3Hc4rMUvGLOjAoEpEHLRCDZF56xEw/r6+U+grNfaDq8BnUKxYzmGtUmDZzSPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=td3R2/Hz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso1725101e87.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713456515; x=1714061315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Kt4+AOhTs3GvEKGkYN2+viHumt1Dp25Zh+htyYxrOQ=;
        b=td3R2/Hzj1wDsJfZ/EyQR0us/li1D7CCdSkRn8+DgkpRNDfcwOrfrMDfGsI91Wk6GU
         9YlZvR9B54ljoknxpeL1/9gGdKR2tXtFSRqfGbZFxWwp9HwB/13ETdPN32CjbqDitxeP
         XD9f8o0v2vu8mvZ5Aut50AQBFodv/AxhownBfvn07k0nYHyXZnIpIFkEBR9Ie1PJetIB
         lcwLIgw7jwy9LWMtLHnO7dc636HDJdFXBJxhycnGEQnOSs+KzTF4w0Z9YW50Uk6GwsQH
         D58aImBydTU3ImtZ1n4HADovUXsskZyM9OiAXhY2iuKiCv+tvvBw8kZRV5CnBb+1nnp7
         7KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456515; x=1714061315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Kt4+AOhTs3GvEKGkYN2+viHumt1Dp25Zh+htyYxrOQ=;
        b=OHJ3RalVR+73EOK3yS3eF7OCBk0WlHyEmwIOhx14kyBiT3VR1F5d8iDEMtRMSMZrxW
         OTHucrazycgGqDEA2+tOqO1p7OGa7ExvOVsMQh45J67x+UrgIW9ipvpROHRPHWvOzgM1
         eVnIRp6BB9I19pkb6fGCrOCRSCO3OBTBf9NnoZSfxpRqot56DvY1jJqxOTvoNsD8fzqq
         eblj9CdNFEF+KbOZ05FvxvMeRh842GVe9IYLtFKPS5J17IPezNtkWyXvxdWCaVLHFMNJ
         0rw0q3nopk9A7UhFJI0pJf/Q15p/4CHpcYntAXHfsE2F1L7QyIMhTdNOkcReZf3e2JaM
         3yHQ==
X-Gm-Message-State: AOJu0YxJpacIVcZ6P9V29Qc9MwxHKKV16kKrjWBdcrjicU4MvfY76M+v
	HwOV17SCam7VKE5UTFzMk+St/vZeJaxcuhP5R7gZRNBiu9eB50VkCLiGFS79/HGDm0aQYrceLNt
	Kr40=
X-Google-Smtp-Source: AGHT+IEJN/IoDrgI7OoaFc2HIm5IxA5WD49uH3pqVxyOXjG3BHJEqN0L3W3WRyfSiFEph8w85BdWjw==
X-Received: by 2002:a05:6512:3c9e:b0:51a:36b6:1f5f with SMTP id h30-20020a0565123c9e00b0051a36b61f5fmr1442886lfv.3.1713456515147;
        Thu, 18 Apr 2024 09:08:35 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id l22-20020a1709065a9600b00a51b5282837sm1088437ejq.15.2024.04.18.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:08:34 -0700 (PDT)
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
Subject: [patch net-next v4 0/6] selftests: virtio_net: introduce initial testing infrastructure
Date: Thu, 18 Apr 2024 18:08:24 +0200
Message-ID: <20240418160830.3751846-1-jiri@resnulli.us>
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
v3->v4:
- addressed comments from Petr and Benjamin, more or less cosmetical
  issues. See individual patches changelog for details.
- extended cover letter by vng usage
v2->v3:
- added forgotten kdoc entry in patch #1.
v1->v2:
- addressed comments from Jakub and Benjamin, see individual
  patches #3, #5 and #6 for details.

Jiri Pirko (6):
  virtio: add debugfs infrastructure to allow to debug virtio features
  selftests: forwarding: move initial root check to the beginning
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
 .../selftests/drivers/net/virtio_net/Makefile |  15 ++
 .../drivers/net/virtio_net/basic_features.sh  | 131 ++++++++++++++++++
 .../selftests/drivers/net/virtio_net/config   |   2 +
 .../net/virtio_net/virtio_net_common.sh       |  99 +++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  70 +++++++++-
 12 files changed, 477 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virtio/virtio_debug.c
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/config
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

-- 
2.44.0


