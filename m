Return-Path: <netdev+bounces-127432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E4297561E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11F31F21001
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BE01A305C;
	Wed, 11 Sep 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah3dwKZF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C7518629C;
	Wed, 11 Sep 2024 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066576; cv=none; b=i4ggvqQX8BYX4G/HQpUfUyGaWLYF09KyWXNU2xtOrOIgCNOLMpoLNqcJolyWKpzz1axPGbXSGvhRG4K24tdrHFGMpEBbjNt2iiDBJcEvIxBQH0AIuxiN7y2n5dBahfRDrDy74ekaHVSlr+9ZIO4smrXdkNh7JUpjtxpY9srv3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066576; c=relaxed/simple;
	bh=ZSoKDRmSN3F0cDRg9FliCL/WekuflPRaCXwQ6/Pfw98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J763b4pCvBj5PDZtgdjOuR9wElMvvngCxbqNCN6yQNXbJvZQTufpJQ9rOM/vhaZIN6MuYMqCTnofIw9VHNcINEwnzci5AxajPVbIgFp1Zolr854k5So85+gTyhY+69fwQe9juW0cPATiqOXiG05elgCcurOhC1CfbxkwE15R8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah3dwKZF; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so4739334a12.3;
        Wed, 11 Sep 2024 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726066574; x=1726671374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fZFNsDJOEbUyrCo9EXbTKXOgCIlnOegBZIV7lWbAFx4=;
        b=ah3dwKZFsZPufnDX03f5Trg8b3WdDyXgFuUCEk6j5wS1GB7JeGVBzY+qv7LiWd1OmC
         0ttmKbqdOQtUPmd9mHZpRKWCcTNMKLy2vMa3qS9q4DIhhkG1yfZ7mKjYbLBEK5zUPtH2
         pMKFE6FjA72Ln63/CQODa9LD2T1S2WM/C7Jzy2LwtXYTtC92jJbY37CuEAFgJ66Qx8xP
         NnCtg9aBOQ7Vh+31Zny+qXGmMZTj+TPC1rUe0+RBiOq4xqRN9USUEhVTmg/kmIQjn3UL
         /uljXqnpBqxu3l0F36Suz0ATRYAJjesbqQnGKLcsmKjS+jsMnOkJNOdBe5YfFqbRqz2A
         Dv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066574; x=1726671374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZFNsDJOEbUyrCo9EXbTKXOgCIlnOegBZIV7lWbAFx4=;
        b=L6tRFaRphXE9tjqsHourSxpdx7KhCp309hK+0j5lsGyiLsF/W2JeHojxXBWDDGRE5R
         k6yCbfG/OD036r8kZuS2H53+QkNOWHbe/tDepjw6pLqUrXLlXesKanpcWu21C9jXn/bx
         bUUizUnDSN323i4lPtiqLzH7YwzDGHlguiE9VDJ/uAAXbF31NiDNenEXbV0A4Ncv8ufV
         7M2MpX6dxrBHSI8A7skU5rznuySEal9GRMAGkwFrEWeclPgNo323GzGWe93NEXmt5/EL
         7UJ4XGdlFcKbP3ZSvennEX3yNkIWjoV/SLXailGE/dy1SZVz/ohXea2yaiCdiw4wDZiU
         LGTA==
X-Forwarded-Encrypted: i=1; AJvYcCVcaC7KEy+DXDR1OHhezZ2lHn2mDZykM5aZwN3gkwdPSsP4Dt3e04vyrNaKKprHS9wq4ZatuocS@vger.kernel.org, AJvYcCXQLDckntgEPiJ96Fe59BMVEN9uPRqHGmaRb/BU3buyKnvqOKeajy6zvYEiSjvibJ+EaVYdIxVOSuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzalJE6HQYgI0JJfaUM8Ycc3XVEyrINt2nr7UpuNfnVXNtT3u1I
	Ue4w/wvp0My8r2szjlR//9UJBNvogJAK4z5PS0dXP/TcsiiPNjat
X-Google-Smtp-Source: AGHT+IHotzPCd9TfzXIBEqWQoyPkxGWqfNBXW/E3DdDxtIkMxO79VuW7qeQ1GVhoKCT+OFCqAV5AUQ==
X-Received: by 2002:a17:902:e54f:b0:207:17f6:9efc with SMTP id d9443c01a7336-2074c5f2c2emr62864035ad.25.1726066573554;
        Wed, 11 Sep 2024 07:56:13 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af278aasm664995ad.28.2024.09.11.07.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:56:12 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	kory.maincent@bootlin.com,
	ahmed.zaki@intel.com,
	paul.greenwalt@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	aleksander.lobakin@intel.com,
	ap420073@gmail.com
Subject: [PATCH net-next v2 0/4] bnxt_en: implement tcp-data-split ethtool command
Date: Wed, 11 Sep 2024 14:55:51 +0000
Message-Id: <20240911145555.318605-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

v2:
 - Add tcp-data-split-thresh ethtool command
 - Implement tcp-data-split-threh in the bnxt_en driver
 - Define min/max rx-copybreak value.
 - Update commit message

Taehee Yoo (4):
  bnxt_en: add support for rx-copybreak ethtool command
  bnxt_en: add support for tcp-data-split ethtool command
  ethtool: Add support for configuring tcp-data-split-thresh
  bnxt_en: add support for tcp-data-split-thresh ethtool command

 Documentation/networking/ethtool-netlink.rst  | 31 ++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 32 +++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 13 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 81 ++++++++++++++++++-
 include/linux/ethtool.h                       |  2 +
 include/uapi/linux/ethtool_netlink.h          |  1 +
 net/ethtool/netlink.h                         |  2 +-
 net/ethtool/rings.c                           | 32 +++++++-
 8 files changed, 158 insertions(+), 36 deletions(-)

-- 
2.34.1


