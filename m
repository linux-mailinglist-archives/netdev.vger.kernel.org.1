Return-Path: <netdev+bounces-157416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64349A0A430
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22442188A703
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2ED42069;
	Sat, 11 Jan 2025 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt4U0NuB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987D374F1;
	Sat, 11 Jan 2025 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736606743; cv=none; b=KInqpDa/16/uJxH4rodtd2vW5OjtkQsCYqo/XLTdsS4EhF63o6KnRlxZPNiF7HfCcJjdWCs32Uy0rQWc/IzZ7m1tlvXhAr3ewCg8RWF3xi62xXLb/KGIwe5QZK6tOI6zkTUMrhCpPcVMO5FQo/cLOAA8HD/TuTzv7eROrwIkXjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736606743; c=relaxed/simple;
	bh=8dmJFmr+CNvyUQEr4ZoqT27wOuDxLgNiqk6AYBeHMwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qD7E+vUArhI2JT82z/7rYux9sjbI8rxKiXejjD6mNRhxJDEMl5s98mj1xGEWVeV761lF0xypXysoAIYv/PoKCmbdhfxT2BB9CZJj4KfFow9/IW5Ox7a90MXewPLbeNkYPbgGxdaUx2BaWoxHJZWwFaj9Tc7Mhu6mYkwZ/94Ji3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vt4U0NuB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21680814d42so41635285ad.2;
        Sat, 11 Jan 2025 06:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736606741; x=1737211541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M8NYr85s0MeTvI7T818H2Knfld038HA1epUX/qDFS68=;
        b=Vt4U0NuBqAFYcUqXTtemTzHQXeCUjN9ZOZh9mOPPOiETBQSAmBT8OQML0oXXilsY0G
         tqBgZ1dwRgRdL8LTn9UtnM+BTswyWQe8htTVZ+Ty1eoIR1uyLcAieebJQmrQRY3uWEZA
         wE8tnOwkthLk+rq/ctFdi77N7zN8A1SRdbyDezN2tenka4OGlW0bnk/pihonHmPIPxaG
         yRPJTno56bhJJp5tHr9oSGeeeSRkDR+l24oSYzcEljrlywwoQn3j3Z6mqL+v6F/GMZcj
         aU+Ez360g6qa8MTevqjfgcv7vQXbF+8/kj6otwAU8qdSjht+ntW/Fd8FQ3dParQyNdju
         SPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736606741; x=1737211541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8NYr85s0MeTvI7T818H2Knfld038HA1epUX/qDFS68=;
        b=fX16EKWWxvCddVm6kNaXPvFzACWEhbiEsiO946w8YmCOrUgtNs6RLf9TWXhQkWpqDz
         7dHHF9mLHSP0b3vfKb8lBHaULHawq+Ti+Fa3OpHWnjGLMP5pp8zjXKGcucGm78x54Nzn
         e24V1Ua3lbhGynARwrXpBT6ky4Tc9H9mMHqzgNd1LLjKt9D4qh3bc4IFalLZXv3uKEg3
         wadBzSbGPVB0mjQ/xAXkeGRcJmhLYTYmoSc0sk7Zn0rog5PxfO3//uGjaLnOnCFECESa
         C1IKZaRSRtqjkydvxWv5XgYrdsPLbZbPEWZXgzJGUD8rdrXIlKeolnn6Ih52exl1LiG7
         eBWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLgNZAStQulOqn26KQTajSN26+eudjUr7woIhR3ebXnQD2WSiOp7ItHqzo+6m0cBHuyrFmvwYV6do=@vger.kernel.org, AJvYcCXvM+6xCMlUXzU19Pw+Oaxpzi/cOHBZtvymP2gpgLN1clLplwqBlg9Q8MbuO/See5V8C/Nfz+Qa@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhH7tnAI5OcAsuLFWZRVdcXQHCYaGngLnn2acNyGFhmJT7jU1
	Ljvi10AhkL407qTG5IvAgaJWEQ1EL/dREiicbuQwEWIwWpHo+zog
X-Gm-Gg: ASbGncs6VBOlJnBwtCj5rBfdNtUh1QdpL68wa6qiaTU4oGa6DaE9Osx2fjUyhslNDts
	sGz4vQZZ3DPD+KzquAq7GNVwXuyrq3LSM5UHldx659tNE7gfnxWfGMwzg81og9M/f7FnPbJ00eN
	VxYb5tuPB/L48xJuTPeg7H3GXN8+G08jyUs8xEJfQPK62IdL1Sjg1N3bFodk012gkaphLYk7/6t
	QjQ4uOrqub4fLlo6Zw/Ffm2O6royVIjEZv86qdndtRGrA==
X-Google-Smtp-Source: AGHT+IGJjwq0E5eZIaWDs+9HtGJKmrZ/9LFg9jp0LJ/icyv4o/tbign9VwOFn6pGSqiHBKxGK+sdFQ==
X-Received: by 2002:a05:6a20:7491:b0:1e1:9f57:eacb with SMTP id adf61e73a8af0-1e88d0e0f11mr25323700637.14.1736606740780;
        Sat, 11 Jan 2025 06:45:40 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40594a06sm3097466b3a.80.2025.01.11.06.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 06:45:40 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v8 0/10] bnxt_en: implement tcp-data-split and thresh option
Date: Sat, 11 Jan 2025 14:45:03 +0000
Message-Id: <20250111144513.1289403-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements hds-thresh ethtool command.
This series also implements backend of tcp-data-split and
hds-thresh ethtool command for bnxt_en driver.
These ethtool commands are mandatory options for device memory TCP.

NICs that use the bnxt_en driver support tcp-data-split feature named
HDS(header-data-split).
But there is no implementation for the HDS to enable by ethtool.
Only getting the current HDS status is implemented and the HDS is just
automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled.
The hds_threshold follows the rx-copybreak value but it wasn't
changeable.

Currently, bnxt_en driver enables tcp-data-split by default but not
always work.
There is hds_threshold value, which indicates that a packet size is
larger than this value, a packet will be split into header and data.
hds_threshold value has been 256, which is a default value of
rx-copybreak value too.
The rx-copybreak value hasn't been allowed to change so the
hds_threshold too.

This patchset decouples hds_threshold and rx-copybreak first.
and make tcp-data-split, rx-copybreak, and
hds-thresh configurable independently.

But the default configuration is the same.
The default value of rx-copybreak is 256 and default
hds-thresh is also 256.

The behavior of rx-copybreak will probably be changed in almost all
drivers. If HDS is not enabled, rx-copybreak copies both header and
payload from a page.
But if HDS is enabled, rx-copybreak copies only header from the first
page.
Due to this change, it may need to disable(set to 0) rx-copybreak when
the HDS is required.

There are several related options.
TPA(HW-GRO, LRO), JUMBO, jumbo_thresh(firmware command), and Aggregation
Ring.

The aggregation ring is fundamental to these all features.
When gro/lro/jumbo packets are received, NIC receives the first packet
from the normal ring.
follow packets come from the aggregation ring.

These features are working regardless of HDS.
If HDS is enabled, the first packet contains the header only, and the
following packets contain only payload.
So, HW-GRO/LRO is working regardless of HDS.

There is another threshold value, which is jumbo_thresh.
This is very similar to hds_thresh, but jumbo thresh doesn't split
header and data.
It just split the first and following data based on length.
When NIC receives 1500 sized packet, and jumbo_thresh is 256(default, but
follows rx-copybreak),
the first data is 256 and the following packet size is 1500-256.

Before this patch, at least if one of GRO, LRO, and JUMBO flags is
enabled, the Aggregation ring will be enabled.
If the Aggregation ring is enabled, both hds_threshold and
jumbo_thresh are set to the default value of rx-copybreak.

So, GRO, LRO, JUMBO frames, they larger than 256 bytes, they will
be split into header and data if the protocol is TCP or UDP.
for the other protocol, jumbo_thresh works instead of hds_thresh.

This means that tcp-data-split relies on the GRO, LRO, and JUMBO flags.
But by this patch, tcp-data-split no longer relies on these flags.
If the tcp-data-split is enabled, the Aggregation ring will be
enabled.
Also, hds_threshold no longer follows rx-copybreak value, it will
be set to the hds-thresh value by user-space, but the
default value is still 256.

If the protocol is TCP or UDP and the HDS is disabled and Aggregation
ring is enabled, a packet will be split into several pieces due to
jumbo_thresh.

When single buffer XDP is attached, tcp-data-split is automatically
disabled.

LRO, GRO, and JUMBO are tested with BCM57414, BCM57504 and the firmware
version is 230.0.157.0.
I couldn't find any specification about minimum and maximum value
of hds_threshold, but from my test result, it was about 0 ~ 1023.
It means, over 1023 sized packets will be split into header and data if
tcp-data-split is enabled regardless of hds_treshold value.
When hds_threshold is 1500 and received packet size is 1400, HDS should
not be activated, but it is activated.
The maximum value of hds-thresh value is 256 because it
has been working. It was decided very conservatively.

I checked out the tcp-data-split(HDS) works independently of GRO, LRO,
JUMBO.
Also, I checked out tcp-data-split should be disabled automatically
when XDP is attached and disallowed to enable it again while XDP is
attached. I tested ranged values from min to max for
hds-thresh and rx-copybreak, and it works.
hds-thresh from 0 to 256, and rx-copybreak 0 to 256.
When testing this patchset, I checked skb->data, skb->data_len, and
nr_frags values.

By this patchset, bnxt_en driver supports a force enable tcp-data-split,
but it doesn't support for disable tcp-data-split.
When tcp-data-split is explicitly enabled, HDS works always.
When tcp-data-split is unknown, it depends on the current
configuration of LRO/GRO/JUMBO.

1/10 patch adds a new hds_config member in the ethtool_netdev_state.
It indicates that what tcp-data-split value is really updated from
userspace.
So the driver can distinguish a passed tcp-data-split value is
came from user or driver itself.

2/10 patch adds hds-thresh command in the ethtool.
This threshold value indicates if a received packet size is larger
than this threshold, the packet's header and payload will be split.
Example:
   # ethtool -G <interface name> hds-thresh <value>
This option can not be used when tcp-data-split is disabled or not
supported.
   # ethtool -G enp14s0f0np0 tcp-data-split on hds-thresh 256
   # ethtool -g enp14s0f0np0
   Ring parameters for enp14s0f0np0:
   Pre-set maximums:
   ...
   Current hardware settings:
   ...
   TCP data split:         on
   HDS thresh:  256

3/10, 4/10 add condition checks for devmem and ethtool.
If tcp-data-split is disabled or threshold value is not zero, setup of
devmem will be failed.
Also, tcp-data-split and hds-thresh will not be changed
while devmem is running.

5/10 add condition checks for netdev core.
It disallows setup single buffer XDP program when tcp-data-split is
enabled.

6/10 patch implements .{set, get}_tunable() in the bnxt_en.
The bnxt_en driver has been supporting the rx-copybreak feature but is
not configurable, Only the default rx-copybreak value has been working.
So, it changes the bnxt_en driver to be able to configure
the rx-copybreak value.

7/10 patch adds an implementation of tcp-data-split ethtool
command.
The HDS relies on the Aggregation ring, which is automatically enabled
when either LRO, GRO, or large mtu is configured.
So, if the Aggregation ring is enabled, HDS is automatically enabled by
it.

8/10 patch adds the implementation of hds-thresh logic
in the bnxt_en driver.
The default value is 256, which used to be the default rx-copybreak
value.

9/10 add HDS feature implementation for netdevsim.
HDS feature is not common so far. Only a few NICs support this feature.
There is no way to test HDS core-API unless we have proper hw NIC.
In order to test HDS core-API without  hw NIC, netdevsim can be used.
It implements HDS control and data plane for netdevsim.

10/10 add selftest for HDS(tcp-data-split and HDS-thresh).
The tcp-data-split tests are the same with
`ethtool -G tcp-data-split <on | auto>`
HDS-thresh tests are same with `ethtool -G eth0 hds-thresh <0 - MAX>`

This series is tested with BCM57504 and netdevsim.

v8:
 - Make the handling of hds_thresh similar to hds_config. 2/10
 - Update comments of hds_thresh and hds_thresh_max. 2/10
 - Remove unnecessary setting hds value in the drivers. 8,9/10
 - Use ksft_raises. 10/10
 - Add Review and Ack tags from Jakub.

v7:
 - Reorder patches.
 - Add review tag from Jakub. 1/10
 - Do not export dev_xdp_sb_prog_count(). 1/10
 - Use dev->ethtool->hds members instead of calling
   ->get_ring_param(). 2/10
 - Do not check XDP_SETUP_PROG_HW. 5/10
 - return -EBUSY when interface is not running. 6/10.
 - Use dev->ethtool->hds_thresh instead of bp->hds_thresh 8/10
 - Add datapath implementation. 9/10
 - Remove kernel_ethtool_ringparam in the struct nsim_ethtool. 9/10
 - Add selftest patch 10/10

v6:
 - use hds_config instead of tcp_data_split_mod.
 - Disallow to attach XDP when HDS is in use.
 - Update ethtool_netlink_generated.h
 - Use "HDS" instead of "HEADER_DATA_SPLIT"
 - HDS_MAX is changed to 1023.
 - Implement netdevsim HDS feature.
 - Add Test tags from Andy.

v5:
 - Remove netdev_devmem_enabled() and use dev_get_min_mp_channel_count()
   instead.
 - change extack messages
 - Drop implementation of device memory TCP for bnxt_en.
 - Add Review tags from Mina.

v4:
 - Remove min rx-copybreak value.
 - Do not support a disable of tcp-data-split by bnxt_en driver.
 - Rename from tcp-data-split-thresh to hds-thresh.
 - Add ETHTOOL_RING_USE_HDS_THRS flag.
 - Add dev_xdp_sb_prog_count() helper.
 - Reduce hole in struct bnxt.
 - Use ETHTOOL_RING_USE_HDS_THRS in bnxt_en driver.
 - Improve condition check.
 - Add netdev_devmem_enabled() helper.
 - Add netmem_is_pfmemalloc() helper.
 - Do not select NET_DEVMEM in Kconfig for bnxt_en driver.
 - Pass PP_FLAG_ALLOW_UNREADABLE_NETMEM flag unconditionally.
 - Use gfp flag in __bnxt_alloc_rx_netmem() in the last patch.
 - Do not add *offset in the __bnxt_alloc_rx_netmem() in the last patch.
 - Do not pass queue_idx to bnxt_alloc_rx_page_pool() in the last patch.
 - Add Test tag from Stanislav.
 - Add Review tag from Brett.
 - Add page_pool_recycle_direct_netmem() helper

v3:
 - Change headline
 - Add condition checks for ethtool and devmem
 - Fix documentation
 - Move validation of tcp-data-split and thresh from dirver to core API
 - Add implementation of device memory TCP for bnxt_en driver

v2:
 - Add tcp-data-split-thresh ethtool command
 - Implement tcp-data-split-threh in the bnxt_en driver
 - Define min/max rx-copybreak value
 - Update commit message

Taehee Yoo (10):
  net: ethtool: add hds_config member in ethtool_netdev_state
  net: ethtool: add support for configuring hds-thresh
  net: devmem: add ring parameter filtering
  net: ethtool: add ring parameter filtering
  net: disallow setup single buffer XDP when tcp-data-split is enabled.
  bnxt_en: add support for rx-copybreak ethtool command
  bnxt_en: add support for tcp-data-split ethtool command
  bnxt_en: add support for hds-thresh ethtool command
  netdevsim: add HDS feature
  selftest: net-drv: hds: add test for HDS feature

 Documentation/netlink/specs/ethtool.yaml      |   8 ++
 Documentation/networking/ethtool-netlink.rst  |  10 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  32 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  12 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  68 +++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   4 +
 drivers/net/netdevsim/ethtool.c               |  12 +-
 drivers/net/netdevsim/netdev.c                |   9 ++
 drivers/net/netdevsim/netdevsim.h             |   3 +
 include/linux/ethtool.h                       |  11 ++
 include/linux/netdevice.h                     |   1 +
 .../uapi/linux/ethtool_netlink_generated.h    |   2 +
 net/core/dev.c                                |  27 ++++
 net/core/devmem.c                             |  11 ++
 net/ethtool/netlink.h                         |   2 +-
 net/ethtool/rings.c                           |  51 +++++++-
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/hds.py    | 120 ++++++++++++++++++
 18 files changed, 363 insertions(+), 21 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hds.py

-- 
2.34.1


