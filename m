Return-Path: <netdev+bounces-131672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6378398F38B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10963282697
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376E61A4F25;
	Thu,  3 Oct 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HejAzmfm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4019C56A;
	Thu,  3 Oct 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971598; cv=none; b=SQ0rPXqrSwbCLEGajBjOivBnpHxajOae2JF7jF5JR5DSHGgTi9sSdhKmwLINZ/yrHQsS5U+WWJ0EeF61qKg5Ko7DqE5NJ7WIXbgUYxqiIaqdoKyimQGd7EKwrUoZYuQaKAZEQ+0FfuQ+d0nG7KeXLSF0L6bxWTRmpDvBGjbCiRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971598; c=relaxed/simple;
	bh=AfMl8/r/X5+PQq14bOniHP11wvtERD1q5v5l7FBRjrc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y6YupH1omFLS68O6SviEr1FtTZ23Sjc3sFYJfRrVPSvygkPMnIVxmlkJYk5B9jzjaUpCkHI+8yeuQ8kOSAx2xy8AKCbbY7GLoD3lu/LuCGUO/tQg79im3nHSumcJuMQ3HqDmbAjbTRevJy1F1SuMCUNuXvRP2ebnViPXrL7JK38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HejAzmfm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b95359440so9996745ad.0;
        Thu, 03 Oct 2024 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727971596; x=1728576396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PWowqp/i7R5+7mk/eRNMQmBv6MNiaHZ+0lhlooGxm2I=;
        b=HejAzmfmwcrwgnWtEFscV2feSIWpSOYKb9JXTL9djXJ2Rmy2UBhG2S2XxtoSw3FQf+
         /mooLbJKX2aKRK0v2pYoKQaBMIx2rxCtTxFlcyNI/2SFWrM5UOU+Uh/8aLL0P+PCFH+R
         d+Ur0k0gb2T4BfTcjyfr+IgvmBLX2O0kUIZTErItoJ8uRlFLaUANcsIQWWo5JLA53Ifn
         LFlJ1mTiC+nJuVzs4NL/VrcMgFiKKnM5rF/P5cxR33E5FMdBRjEPIRHp+md/SWucx1tV
         EYZJfxND7XTkAgCuvhKq+I73fkuvmTBrese4popypeBflglyXo0Y9ANQBFAW5pQ7fTDi
         EQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971596; x=1728576396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWowqp/i7R5+7mk/eRNMQmBv6MNiaHZ+0lhlooGxm2I=;
        b=bHbjkqtJnak0o9Z6DD0AlxRtAQd7cbsNFl6LqGqfF50DVyY2F+5LxA1WPxFJN3mKCP
         BxglzU5pHy2Ews8Yl7a4TX0MyAPBulwdaZcQbnnoQ4WUCrGi41NOBlnH4BbkbyZMw8Jm
         HstPRxvx6vu1OIOsrQxCJW3QUAeYGDCT5VMweOa6lM0+kwpPc2ui75c4uMVDCQxiiXc+
         J7gLwrx1l24/H61OBHjz4X7loe1WOkIM8YxGwtiY/+h4uxIaTujRNAZiXDiUeZrDKlqM
         gp04MnJlUEVm85HNA585LRUPGTGg+mKX3mIaFr7VZaxnd/G5PiKFTJMq4xzCY1qA2vVI
         MSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaPUC0AY+6YnTC9+GKJPBb9V5L3CFxyJnEKymMv8KcTk+vvhqvp6BUCch8yz3xTLTmadexMUct19I=@vger.kernel.org, AJvYcCW8967faeDgN+XuTTWWWSp79JY0dtB2AmvO6otGVcQq/Y3xv8n33bP+lLaf9ZbNu6EtJx1liH3f@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2p1vZnpgzQM7oleiKshFimsZ1Piqj1Oi4b4JoUz7qoP8+uNyb
	5dFW7AJYQCJddgmyRI7W7VQdPyaIZLt4rbO4fNRncaUgKAV9L+Ul
X-Google-Smtp-Source: AGHT+IE9cRzaUx6Eg4w4c/Adk7Blw2bhJT11kWzl9AG1Hqloq1YvMkF+Gr5hFoMinhFirGf/DPeDUw==
X-Received: by 2002:a17:903:22d0:b0:20b:633:46c0 with SMTP id d9443c01a7336-20bc5aa3d64mr98059385ad.54.1727971595451;
        Thu, 03 Oct 2024 09:06:35 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef7071f1sm10425435ad.292.2024.10.03.09.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:06:34 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com
Cc: kory.maincent@bootlin.com,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	paul.greenwalt@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	asml.silence@gmail.com,
	kaiyuanz@google.com,
	willemb@google.com,
	aleksander.lobakin@intel.com,
	dw@davidwei.uk,
	sridhar.samudrala@intel.com,
	bcreeley@amd.com,
	ap420073@gmail.com
Subject: [PATCH net-next v3 0/7] bnxt_en: implement device memory TCP for bnxt
Date: Thu,  3 Oct 2024 16:06:13 +0000
Message-Id: <20241003160620.1521626-1-ap420073@gmail.com>
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
tcp-data-split-thresh(hds_threshold) configurable independently.

But the default configuration is the same.
The default value of rx-copybreak is 256 and default
tcp-data-split-thresh is also 256.

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
be set to the tcp-data-split-thresh value by user-space, but the
default value is still 256.

If the protocol is TCP or UDP and the HDS is disabled and Aggregation
ring is enabled, a packet will be split into several pieces due to
jumbo_thresh.

When XDP is attached, tcp-data-split is automatically disabled.

LRO, GRO, and JUMBO are tested with BCM57414, BCM57504 and the firmware
version is 230.0.157.0.
I couldn't find any specification about minimum and maximum value
of hds_threshold, but from my test result, it was about 0 ~ 1023.
It means, over 1023 sized packets will be split into header and data if
tcp-data-split is enabled regardless of hds_treshold value.
When hds_threshold is 1500 and received packet size is 1400, HDS should
not be activated, but it is activated.
The maximum value of hds_threshold(tcp-data-split-thresh)
value is 256 because it has been working.
It was decided very conservatively.

I checked out the tcp-data-split(HDS) works independently of GRO, LRO,
JUMBO. Tested GRO/LRO, JUMBO with enabled HDS and disabled HDS.
Also, I checked out tcp-data-split should be disabled automatically
when XDP is attached and disallowed to enable it again while XDP is
attached. I tested ranged values from min to max for
tcp-data-split-thresh and rx-copybreak, and it works.
tcp-data-split-thresh from 0 to 256, and rx-copybreak 65 to 256.
When testing this patchset, I checked skb->data, skb->data_len, and
nr_frags values.

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

The third patch adds tcp-data-split-thresh command in the ethtool.
This threshold value indicates if a received packet size is larger
than this threshold, the packet's header and payload will be split.
Example:
   # ethtool -G <interface name> tcp-data-split-thresh <value>
This option can not be used when tcp-data-split is disabled or not
supported.
   # ethtool -G enp14s0f0np0 tcp-data-split on tcp-data-split-thresh 256
   # ethtool -g enp14s0f0np0
   Ring parameters for enp14s0f0np0:
   Pre-set maximums:
   ...
   Current hardware settings:
   ...
   TCP data split:         on
   TCP data split thresh:  256

   # ethtool -G enp14s0f0np0 tcp-data-split off
   # ethtool -g enp14s0f0np0
   Ring parameters for enp14s0f0np0:
   Pre-set maximums:
   ...
   Current hardware settings:
   ...
   TCP data split:         off
   TCP data split thresh:  n/a

The fourth patch adds the implementation of tcp-data-split-thresh logic
in the bnxt_en driver.
The default value is 256, which used to be the default rx-copybreak
value.

The fifth and sixth adds condition check for devmem and ethtool.
If tcp-data-split is disabled or threshold value is not zero, setup of
devmem will be failed.
Also, tcp-data-split and tcp-data-split-thresh will not be changed
while devmem is running.

The last patch implements device memory TCP for bnxt_en driver.
It usually converts generic page_pool api to netmem page_pool api.

No dependencies exist between device memory TCP and GRO/LRO/MTU.
Only tcp-data-split and tcp-data-split-thresh should be enabled when the
device memory TCP.
While devmem TCP is set, tcp-data-split and tcp-data-split-thresh can't
be updated because core API disallows change.

I tested the interface up/down while devmem TCP running. It works well.
Also, channel count change, and rx/tx ringsize change tests work well too.

The devmem TCP test NIC is BCM57504

All necessary configuration validations exist at the core API level.

Note that by this patch, the setup of device memory TCP would fail.
Because tcp-data-split-thresh command is not supported by ethtool yet.
The tcp-data-split-thresh should be 0 for setup device memory TCP and
the default of bnxt is 256.
So, for the bnxt, it always fails until ethtool supports
tcp-data-split-thresh command.

The ncdevmem.c will be updated after ethtool supports
tcp-data-split-thresh option.

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
  bnxt_en: add support for tcp-data-split ethtool command
  net: ethtool: add support for configuring tcp-data-split-thresh
  bnxt_en: add support for tcp-data-split-thresh ethtool command
  net: devmem: add ring parameter filtering
  net: ethtool: add ring parameter filtering
  bnxt_en: add support for device memory tcp

 Documentation/netlink/specs/ethtool.yaml      |   8 ++
 Documentation/networking/ethtool-netlink.rst  |  75 ++++++----
 drivers/net/ethernet/broadcom/Kconfig         |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 130 +++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  15 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  78 ++++++++++-
 include/linux/ethtool.h                       |   4 +
 include/uapi/linux/ethtool_netlink.h          |   2 +
 net/core/devmem.c                             |  18 +++
 net/ethtool/common.h                          |   1 +
 net/ethtool/netlink.h                         |   2 +-
 net/ethtool/rings.c                           |  61 +++++++-
 12 files changed, 305 insertions(+), 90 deletions(-)

-- 
2.34.1


