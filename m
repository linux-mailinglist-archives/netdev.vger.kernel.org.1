Return-Path: <netdev+bounces-218729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376FCB3E1C8
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84A93B5282
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC48231B10F;
	Mon,  1 Sep 2025 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlI2V31G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041B7305E27;
	Mon,  1 Sep 2025 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726729; cv=none; b=o9kBMSUuvqUlKqrj3il1vrmD3RoJESzacPeDy2rsRAlJoO8bQGBFmnu3N+ColvttbWX6kAgRaqzIaDH8hmX0FSRBAgWMOvADQsUJTACXcfDbu15Yp5F/p6tqCo8br6PHwlhMTBjM6TswIE7qJuGmJMeQ9SXhOVNEUR0Bc6hHCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726729; c=relaxed/simple;
	bh=8fxbNDoTQaCp/ZjVodY45oB0/hj2vDiL/ePu7IRIUbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YINL/1A0FNtbxA4k9vpRom2mTfbygr01r1W49QTjxwS4ZoDuuudiM3KGBsmIOYi6xk8CPoL2cpT7Usp5AlNeKWXQrLjzoF+nyQ4bK7V8gjJjredfUpnVlZeJEdwCVYyA+pWIshT7oqUFA5IGzTWjCqqsHh6208VIMg+n56vYMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlI2V31G; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3d87cea889dso266053f8f.1;
        Mon, 01 Sep 2025 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756726726; x=1757331526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lwKVMNa4xxT1GMCVlO+8KMGhzj/ldA3uou/L45smr28=;
        b=GlI2V31GkZzLScl41fHqARwKtWCMUU9LklRRIrdinSjHz2dc3RXLcgzadrPgdg/GmL
         sCGMXGu0ojyb8MYBubp0hj1/gWt3OCi7m7RdcAoanCRzqze2JxPhMH6v7pkti4M2MIFt
         eNYuxAJY3MmdRvmP4PQEUd8+c7cF6M/cOkf/Z6vSITbKTsvpe+z+/+8qL+rV1VB3kb8n
         WB/GZSo2yYPbM6XZSamSYHqnK7IRRkcsjAu6lqmN+IuGOuFJxhNXA8h6Rlp3q3Ff10oB
         27dqYmaevyMTDPQ7slUpWbwNQwceAhqJMlZ89Uv7T0fOpQYoQXA5f66O1w0MjIyuzZjK
         lfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726726; x=1757331526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwKVMNa4xxT1GMCVlO+8KMGhzj/ldA3uou/L45smr28=;
        b=jEZMJgOZIBZaaEwiY66ZCz1JJtmbmBOQNzSlXEAsCIK45yuXlC4WWM4JKESxn0Ayn7
         4iqpGmRoW/eTflVEN0IZRSDBLQgWbAEy5pBQhVbQAC9ayva3T5QVXoCmZTX7zirIABR8
         enMuN4fVKYP30OyjkxvpKHS+xPLc2nwqXxG6ZOr8ytUAJ8S/o9PJzhuPe1yHKWV9GBQX
         8maTrBlPf5J05nM8oEoSyZaAD/sivQKkjLG79T0wkZwwuHQTaQvNLMIksZ+q9hqGeLgw
         MyRiGmqoAZ3m2bSDA4rS5QA1yfb4DP8bDjWBRS6UCp9RF9ez+y+rdMKcDBz6nbHN9GB+
         QC9g==
X-Forwarded-Encrypted: i=1; AJvYcCUfL5bw3E8dNKlOdHx1Ebytx3BN1w/3lEV6Wn1KWVDvNg8LXrSGtcairEPCs1gxZHSZbJW32HhUCJZAYAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr5/ASkBREoU13AH2hhZFJaoGT1PrV2nin80ghgXXGrydWMG2b
	SuakRqoZNu3kYcfBjI9JOIRdfyp9yEYHPv4Q+CNNYiEtcWlbPGqyi/r74QiZ5LQJk8E=
X-Gm-Gg: ASbGncs5Gb9eKkNqJART8G6dv1RD+LoMbEu55f+CFERlI1Yne9PNuZfKrL3DRxdz04r
	HSbSMhzQZCLb94YA5l/rNDg7ED0Dn1f5eyyo/7/1IJwj7DdHffu/RFMGvSrbSo4umj/LKd+4LKR
	QL7GHq3X5Z1GDOC6fgtyu0MPQjWb0yFvuOS/b+Krlh5to+8jm28Dc9mnCgVJ0St6kCqD8ORjJAq
	SFtUIm2zM92mwIyUviWGdepDsuoUn2AxLpwh9yYix5CenbhpFvnLEJhWYrKsN7fMYfqAbl9OeJp
	cja7+vX/zEfGcNySzreEqkrBwb9bIdyjoFRUgfXXfT14fy8Sg7f0yqyeKlypiSEzd6WaS4PyHj5
	sivgPs/2uae+Agfdz3xaTI06Sp3L72WV549cRMEO5Kfuxg7ec
X-Google-Smtp-Source: AGHT+IHhVl/mrkWMRm8XTL3ndPvrEBpc5FLF+TzeHV6ufPs1veC2JztRvsLbgP54Zr1Fa0BiKM91jg==
X-Received: by 2002:a05:6000:2c0f:b0:3d1:d24:ba4e with SMTP id ffacd0b85a97d-3d1def62c8amr5492973f8f.51.1756726725806;
        Mon, 01 Sep 2025 04:38:45 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b69b7529asm143048445e9.0.2025.09.01.04.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:38:45 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	ecree.xilinx@gmail.com,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v4 0/5] net: gso: restore outer ip ids correctly
Date: Mon,  1 Sep 2025 13:38:21 +0200
Message-Id: <20250901113826.6508-1-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GRO currently ignores outer IPv4 header IDs for encapsulated packets
that have their don't-fragment flag set. GSO, however, always assumes
that outer IP IDs are incrementing. This results in GSO mangling the
outer IDs when they aren't incrementing. For example, GSO mangles the
outer IDs of IPv6 packets that were converted to IPv4, which must
have an ID of 0 according to RFC 6145, sect. 5.1.

GRO+GSO is supposed to be entirely transparent by default. GSO already
correctly restores inner IDs and IDs of non-encapsulated packets. The
tx-tcp-mangleid-segmentation feature can be enabled to allow the
mangling of such IDs so that TSO can be used.

This series fixes outer ID restoration for encapsulated packets when
tx-tcp-mangleid-segmentation is disabled. It also allows GRO to merge
packets with fixed IDs that don't have their don't-fragment flag set.

v3 -> v4:
  - Specify that mangleid for outer ids cannot turn incrementing ids to fixed if DF is unset
  - Update segmentation-offload documentation
  - Fix setting fixed ids in ef100 TSO
  - Reformat gro_receive_network_flush again

v2 -> v3:
 - Make argument const in fou_gro_ops helper
 - Rename SKB_GSO_TCP_FIXEDID_OUTER to SKB_GSO_TCP_FIXEDID
 - Fix formatting in selftest, gro_receive_network_flush and tcp4_gro_complete

v1 -> v2:
 - Add fou_gro_ops helper
 - Clarify why sk_family check works
 - Fix ipip packet generation in selftest

Links:
 - v1: https://lore.kernel.org/netdev/20250814114030.7683-1-richardbgobert@gmail.com/
 - v2: https://lore.kernel.org/netdev/20250819063223.5239-1-richardbgobert@gmail.com/
 - v3: https://lore.kernel.org/netdev/20250821073047.2091-1-richardbgobert@gmail.com/

Richard Gobert (5):
  net: gro: remove is_ipv6 from napi_gro_cb
  net: gro: only merge packets with incrementing or fixed outer ids
  net: gso: restore ids of outer ip headers correctly
  net: gro: remove unnecessary df checks
  selftests/net: test ipip packets in gro.sh

 .../networking/segmentation-offloads.rst      |  9 ++-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 ++-
 drivers/net/ethernet/sfc/ef100_tx.c           | 17 ++++--
 include/linux/netdevice.h                     |  9 ++-
 include/linux/skbuff.h                        |  6 +-
 include/net/gro.h                             | 36 +++++-------
 net/core/dev.c                                |  4 +-
 net/ipv4/af_inet.c                            | 10 +---
 net/ipv4/fou_core.c                           | 32 +++++-----
 net/ipv4/udp_offload.c                        |  2 -
 net/ipv6/udp_offload.c                        |  2 -
 tools/testing/selftests/net/gro.c             | 58 ++++++++++++++-----
 tools/testing/selftests/net/gro.sh            |  5 +-
 13 files changed, 117 insertions(+), 81 deletions(-)

-- 
2.36.1


