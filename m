Return-Path: <netdev+bounces-144499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F869C79F9
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC392282C78
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307542003DF;
	Wed, 13 Nov 2024 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOwVKYap"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9517E111;
	Wed, 13 Nov 2024 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519162; cv=none; b=E1p/M+I/rlGj7uWIYUDyoc59VlSKAQ9RnfonSX5bZSZwxvMJ2tFDBQdpMTMVHgzCAlUREQwiXDqazQ6C0nqLFvyXcLMNkiOTHgBQBLpKNNX9SOWiyl4zuTlHv9c+Ae8J0rABCcnkoZDaWwAMMZsfcVEhjsGTX52O/50PJtiTcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519162; c=relaxed/simple;
	bh=LJOoh0akR7dZvsn6ubEAlYMjKdE6P0y1XcgHzdvQxnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HkTqceK01UD3IV3PpiVz5D/xoE2EzzA6zzZwHbESN+Cm9ehKbpaeBgfA2xMi3LeYHPswR6dW7A4U3TrhL86EkfJF1eiHLDLKGp+FvtkP/Pq6cnOAt63VCq1Z9sw0m3eGXGNTkEkuQtoGfbdWGFr7piaYr8dFqmK/K88snfF/I1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOwVKYap; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cd76c513cso62153245ad.3;
        Wed, 13 Nov 2024 09:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519160; x=1732123960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VNQaXfCvVKUj7hCjUz96JWeNItMKqfsjZZQ6p2eJDVo=;
        b=IOwVKYapauUJDPIO16+hgyrFLrzoMcZzPp+CzA9FH28eBbX7jtSNknCvoiXIOfmuNS
         8YHyi0mz2RS93iUc5dDqUNkEzemtOy1kbnnPjXRfcwhNkWnyI87o98p8n1MgqACVzJgg
         mcGx/kG1OA0bLMMk+/bgCOslNiteQhsOgz0TlRIaCY920ROHEnnZjiWuiBj7XtvFj+vc
         rUNd0zBL4lU99oEqhbCxuoHMABKjHpHl8qYu1QYAaJ0VZSQIrOPuZPE6d5JbzQJE6xaS
         nIkLFednToK7ZRsSjhaBxBa0uVtlFq/69JTkLmKNaBXC53PbFJVXEhBhM3Sp3oYoCoMu
         XUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519160; x=1732123960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNQaXfCvVKUj7hCjUz96JWeNItMKqfsjZZQ6p2eJDVo=;
        b=jjKWLRDpN0cVI+SdiF2bRf327Hu8ONpUCUaBq2UiprZxLk1VHS3wiwBCoXYl51RCMa
         kCN0XO1ukKiO3OZUyCKFRkAu1YC9OBCT/OxxqwbY/5XGu87DoH4y+KS9v2GOr24X4sBt
         1mp2Dwbd5mwQYogEzuugOOiIOCJmZjvljF/4D0stUtrJCVTkzbgd3sXzVMFeRW5KWE9K
         7ujDqOk9uxkVU0Y70ixEusGXV6ttVENcC4/QFUy95HH5vBxH+H4xRvVh75KKk+I9vDn5
         fOgwxuh5Gu6CauRrpnfttLsBBFda6gNg3zYp8W/lQUE9wYeRKL1VLqdo+vI284OJiqPy
         szDA==
X-Forwarded-Encrypted: i=1; AJvYcCU2W3iUE4VCmA4gQKOUd3e6k3vZTuOWO6cRUYTveX3vpYmxpn7mysWJVFot9NUJuGSKLUice4bv@vger.kernel.org, AJvYcCXyGQB5QLwdt+W+c7X4DAyQy9qFLSRafLZD4BTGZoZkc6dWfU0Gqo4zS/3zoIONe0ZAoH4vBpqES8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5beETejADqfiuqLTHRSUDP0SRLM2GkeV4d8Ps2RLgo2tfDli
	9VQchOiqsPcjRG0Gzz8AT4vpt8C9I1dumT2s3rzKulVjyLUIEJaq
X-Google-Smtp-Source: AGHT+IHv1Kr6wbPj8hCiO/yTluOnXxS+hN4bXVhdUlzIlwqZ9gUKzYrOnSbwEKDglCEY74X7o9FnBg==
X-Received: by 2002:a17:902:f711:b0:206:8acc:8871 with SMTP id d9443c01a7336-211ab9875e4mr100485155ad.31.1731519159527;
        Wed, 13 Nov 2024 09:32:39 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7df5sm113140765ad.19.2024.11.13.09.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:32:38 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
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
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
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
Subject: [PATCH net-next v5 0/7] bnxt_en: implement tcp-data-split and thresh option
Date: Wed, 13 Nov 2024 17:32:14 +0000
Message-Id: <20241113173222.372128-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements header-data-split-thresh ethtool command.
This series also implements backend of tcp-data-split and
header-data-split-thresh ethtool command for bnxt_en driver.
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
header-data-split-thresh configurable independently.

But the default configuration is the same.
The default value of rx-copybreak is 256 and default
header-data-split-thresh is also 256.

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
be set to the header-data-split-thresh value by user-space, but the
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
The maximum value of header-data-split-thresh value is 256 because it
has been working. It was decided very conservatively.

I checked out the tcp-data-split(HDS) works independently of GRO, LRO,
JUMBO.
Also, I checked out tcp-data-split should be disabled automatically
when XDP is attached and disallowed to enable it again while XDP is
attached. I tested ranged values from min to max for
header-data-split-thresh and rx-copybreak, and it works.
header-data-split-thresh from 0 to 256, and rx-copybreak 0 to 256.
When testing this patchset, I checked skb->data, skb->data_len, and
nr_frags values.

By this patchset, bnxt_en driver supports a force enable tcp-data-split,
but it doesn't support for disable tcp-data-split.
When tcp-data-split is explicitly enabled, HDS works always.
When tcp-data-split is unknown, it depends on the current
configuration of LRO/GRO/JUMBO.

1/7 patch implements .{set, get}_tunable() in the bnxt_en.
The bnxt_en driver has been supporting the rx-copybreak feature but is
not configurable, Only the default rx-copybreak value has been working.
So, it changes the bnxt_en driver to be able to configure
the rx-copybreak value.

2/7 patch adds a new tcp_data_split_mod member in the
kernel_ethtool_ringparam
It indicates that user is explicitly set the tcp-data-split.
So the driver can distinguish a passed tcp-data-split value is
came from user or driver itself.

3/7 patch adds an implementation of tcp-data-split ethtool
command.
The HDS relies on the Aggregation ring, which is automatically enabled
when either LRO, GRO, or large mtu is configured.
So, if the Aggregation ring is enabled, HDS is automatically enabled by
it.

4/7 patch adds header-data-split-thresh command in the ethtool.
This threshold value indicates if a received packet size is larger
than this threshold, the packet's header and payload will be split.
Example:
   # ethtool -G <interface name> header-data-split-thresh <value>
This option can not be used when tcp-data-split is disabled or not
supported.
   # ethtool -G enp14s0f0np0 tcp-data-split on header-data-split-thresh 256
   # ethtool -g enp14s0f0np0
   Ring parameters for enp14s0f0np0:
   Pre-set maximums:
   ...
   Current hardware settings:
   ...
   TCP data split:         on
   Header data split thresh:  256

5/7 patch adds the implementation of header-data-split-thresh logic
in the bnxt_en driver.
The default value is 256, which used to be the default rx-copybreak
value.

6/7, 7/7 add condition checks for devmem and ethtool.
If tcp-data-split is disabled or threshold value is not zero, setup of
devmem will be failed.
Also, tcp-data-split and header-data-split-thresh will not be changed
while devmem is running.

This series is tested with BCM57504.

All necessary configuration validations exist at the core API level.

v5:
 - Drop implementation of device memory TCP for bnxt_en.
 - Remove netdev_devmem_enabled() and use dev_get_min_mp_channel_count()
   instead.
 - change extack messages
 - Add Review tags from Mina.

v4:
 - Remove min rx-copybreak value.
 - Do not support a disable of tcp-data-split by bnxt_en driver.
 - Rename from tcp-data-split-thresh to header-data-split-thresh.
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

Taehee Yoo (7):
  bnxt_en: add support for rx-copybreak ethtool command
  net: ethtool: add tcp_data_split_mod member in
    kernel_ethtool_ringparam
  bnxt_en: add support for tcp-data-split ethtool command
  net: ethtool: add support for configuring header-data-split-thresh
  bnxt_en: add support for header-data-split-thresh ethtool command
  net: devmem: add ring parameter filtering
  net: ethtool: add ring parameter filtering

 Documentation/netlink/specs/ethtool.yaml      |  8 ++
 Documentation/networking/ethtool-netlink.rst  | 79 ++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 31 +++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 12 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 73 ++++++++++++++++-
 include/linux/ethtool.h                       |  8 ++
 include/linux/netdevice.h                     |  1 +
 include/uapi/linux/ethtool_netlink.h          |  2 +
 net/core/dev.c                                | 13 +++
 net/core/devmem.c                             | 18 +++++
 net/ethtool/netlink.h                         |  2 +-
 net/ethtool/rings.c                           | 53 ++++++++++++-
 12 files changed, 250 insertions(+), 50 deletions(-)

-- 
2.34.1


