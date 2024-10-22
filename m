Return-Path: <netdev+bounces-137948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4E49AB3C8
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D7D1C20D4C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9451AF4E9;
	Tue, 22 Oct 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye1O32DP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B851A0BF3;
	Tue, 22 Oct 2024 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614258; cv=none; b=jXIQ5FgdPLhyoHmnosjylrUL61cdFWaevLBuzKBXkYE3JQQ5v6w1NYx/PFF3ksEzxTdJnLE5q3IkR5KmoAY+LpueYGdjSBMZJcyUbRE9VajeHbIHq3Q0pN11spI1aeEd2xVaRddUCXdbZUWlhXyHn6JC3sM2KGcBVK1JMJ0aF/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614258; c=relaxed/simple;
	bh=501b3LVbL2FXMhL78aQmvarPQsQnuHqZmJ76xqT+2fs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P4cbLKkYG7OBo3rh/oVLQX0zKGQntEBDYZrDMfMI6xnS9QTttzo0af+DPQlQIg4aU63ccA2xE975S+PUTWNvqXp4ZkiGC8V1f/cEYpx/PCZbs3mt2NEXHrEPYTdkmZjQssoTZjJrwgoJzZp3QsNysozXc8tIOn7zfzklR9guWb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye1O32DP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cd76c513cso49085525ad.3;
        Tue, 22 Oct 2024 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729614256; x=1730219056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=65YVVgdSIGqvCqgaz3dUKTc4mf0+vNRHTbD04BfZv80=;
        b=Ye1O32DP+xq7QV7BRjhRrXgXui/NhyCUJ9TMaKj7RXtlCU4aKOZo90c+lG8XNh8S/n
         YedjwICgWECJX4J1cG412HjOOG9fVLn4WJMJiScYtTtZMNt9MLIiA89m+RGoJ/gq2a4K
         cqPjlCv50xVzTxYIzGfH26nRw43nyZc6PwFM7k+ifBekzZ6ra5w3BaN5kdKeKzvNJLyZ
         UIhi+hr1z+KHg19z1ULGk8oWK26VfzKbhTyvIYnivFF+ch5Ys6kAowkUmaMGXn9WJPIP
         JSHc8iMr9ySr9g2GYyHkWgR1iIm4PyPJ5ptC0d6Jgi4lH2CyizurIjC25vDc7HqCW5tc
         SYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614256; x=1730219056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65YVVgdSIGqvCqgaz3dUKTc4mf0+vNRHTbD04BfZv80=;
        b=usF97NUJAzo2WFj/BXUO+S0BgqMtz5zZy94HBKczhbvG4TRVWfvqLTSS86vxWx/Qk/
         TVN7jCgfJzCEZHScR0lagEKRQkgbW4NvGbr59jw4fa14a1YZzBmz53pui/xPnaFO2NNJ
         uW3ckKAU9+fvoDNu/q9ZFR7C2xdhv4UsSa7JyHjZI8vtj4oszJl+TSMySXgmLheYPGVI
         b++FH2cekoDLBDjQf+agpZH8TW29g4XklCICi6Dns1DBhhlkA+HVzXDouNCegJ9TSt4o
         VKCcQ/hvueygv7PqpIqyas0tHVp8yzixeXxdcRPyn+HSH/PdF1JM1dPa4gOr0gUMyaey
         osag==
X-Forwarded-Encrypted: i=1; AJvYcCW98CtPDB7ndghifsvIho8AxqKtUlQgjZpHYw9a1RfwuSa8GalAfgdkP7VpWYWVgwJ+YORE+THy3o8=@vger.kernel.org, AJvYcCWdaq+xrWoosOMoBrU8i2y1Gr8zZNJHjI3meWzCMymMRg8kbXFAbpiUMzvEMBpRI81mFsGSZtTQ@vger.kernel.org
X-Gm-Message-State: AOJu0YymWFqQU95tPnzFDqYylNM1ZpntvUk6NKNF5z7YIsiFETqDorGy
	De/zExbn6+LKbwedbbfLL0S8C0hEXsKLyWrV4wr+OQCzcc5bmQDG
X-Google-Smtp-Source: AGHT+IFNav1yg5gDru0tPYNH8Mt9fV3h/GWKQTcXmqaLZC8LL+qm96LqMEWMOqqstfMC0SCLWrxv9g==
X-Received: by 2002:a17:903:184:b0:20e:94ba:4e27 with SMTP id d9443c01a7336-20e94ba4e70mr39340795ad.27.1729614255848;
        Tue, 22 Oct 2024 09:24:15 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee6602sm44755205ad.1.2024.10.22.09.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:24:14 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/7] bnxt_en: implement device memory TCP for bnxt
Date: Tue, 22 Oct 2024 16:23:51 +0000
Message-Id: <20241022162359.2713094-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements device memory TCP for bnxt_en driver and
necessary ethtool command implementations.

NICs that use the bnxt_en driver support tcp-data-split feature named
HDS(header-data-split).
But there is no implementation for the HDS to enable/disable by ethtool.
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
When TPA is enabled and HDS is disabled, the first packet contains
header and payload too.
and the following packets contain payload only.
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
JUMBO. Tested GRO/LRO, JUMBO with enabled HDS and disabled HDS.
Also, I checked out tcp-data-split should be disabled automatically
when XDP is attached and disallowed to enable it again while XDP is
attached. I tested ranged values from min to max for
header-data-split-thresh and rx-copybreak, and it works.
header-data-split-thresh from 0 to 256, and rx-copybreak 65 to 256.
When testing this patchset, I checked skb->data, skb->data_len, and
nr_frags values.

By this patchset, bnxt_en driver supports a force enable tcp-data-split,
but it doesn't support for disable tcp-data-split.
When tcp-data-split is explicitly enabled, HDS works always.
When tcp-data-split is unknown, it depends on the current
configuration of LRO/GRO/JUMBO.

The first patch implements .{set, get}_tunable() in the bnxt_en.
The bnxt_en driver has been supporting the rx-copybreak feature but is
not configurable, Only the default rx-copybreak value has been working.
So, it changes the bnxt_en driver to be able to configure
the rx-copybreak value.

The second patch adds an implementation of tcp-data-split ethtool
command.
The HDS relies on the Aggregation ring, which is automatically enabled
when either LRO, GRO, or large mtu is configured.
So, if the Aggregation ring is enabled, HDS is automatically enabled by
it.

The third patch adds header-data-split-thresh command in the ethtool.
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

The fourth patch adds the implementation of header-data-split-thresh logic
in the bnxt_en driver.
The default value is 256, which used to be the default rx-copybreak
value.

The fifth and sixth add condition checks for devmem and ethtool.
If tcp-data-split is disabled or threshold value is not zero, setup of
devmem will be failed.
Also, tcp-data-split and header-data-split-thresh will not be changed
while devmem is running.

The sixth patch adds netmem_is_pfmemalloc() helper function.

The last patch implements device memory TCP for bnxt_en driver.
It usually converts generic page_pool api to netmem page_pool api.

No dependencies exist between device memory TCP and GRO/LRO/MTU.
Only tcp-data-split and header-data-split-thresh should be enabled when the
device memory TCP.
While devmem TCP is set, tcp-data-split and header-data-split-thresh can't
be updated because core API disallows change.

I tested the interface up/down while devmem TCP running. It works well.
Also, channel count change, and rx/tx ringsize change tests work well too.

The devmem TCP test NIC is BCM57504

All necessary configuration validations exist at the core API level.

Current page_pool fails if drivers pass PP_FLAG_ALLOW_UNREADABLE_NETMEM |
PP_FLAG_DMA_SYNC_DEV.
This is going to be fixed by Mina.

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

Taehee Yoo (8):
  bnxt_en: add support for rx-copybreak ethtool command
  bnxt_en: add support for tcp-data-split ethtool command
  net: ethtool: add support for configuring header-data-split-thresh
  bnxt_en: add support for header-data-split-thresh ethtool command
  net: devmem: add ring parameter filtering
  net: ethtool: add ring parameter filtering
  net: netmem: add netmem_is_pfmemalloc() helper function
  bnxt_en: add support for device memory tcp

 Documentation/netlink/specs/ethtool.yaml      |   8 +
 Documentation/networking/ethtool-netlink.rst  |  79 ++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 212 +++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  14 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  66 +++++-
 include/linux/ethtool.h                       |   6 +
 include/linux/netdevice.h                     |   1 +
 include/net/netdev_rx_queue.h                 |  14 ++
 include/net/netmem.h                          |   8 +
 include/net/page_pool/helpers.h               |   6 +
 include/uapi/linux/ethtool_netlink.h          |   2 +
 net/core/dev.c                                |  13 ++
 net/core/devmem.c                             |  18 ++
 net/ethtool/common.h                          |   1 +
 net/ethtool/netlink.h                         |   2 +-
 net/ethtool/rings.c                           |  50 ++++-
 16 files changed, 402 insertions(+), 98 deletions(-)

-- 
2.34.1


