Return-Path: <netdev+bounces-233334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3439FC121F6
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2471A255FA
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207B3288A2;
	Tue, 28 Oct 2025 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3OfTkGF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5BB672
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609624; cv=none; b=YObM/HxzN0gF1AJHqQjY21Yxt6OcG29qmXTYFBqD9/g5M2rThOgPT8srIOcrGYlQJ2Joi2qC7z5yshtRVfmzV5L8AcewPGz/OS8HjGhUNIPRu9LcK4DUht4aYMymVwXTe44R0DWyUpRzymsFuldDlH157QDZCc0A99ZH1FJB+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609624; c=relaxed/simple;
	bh=44j1NMeztM3eKosxbeA0SuymPVYwCbHD5kCp3dOw4H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FwJijRt28FGcmMtOsa+FF07x7xZVgEx9N74O2GxuatKSy/OmjxKB86+tq+pRCUOu4WWxmususcHDYzXfGOvq4otvV2hBIX/x9jLC6PACsn31v1huG0zxqnpxu/0w1veOcAqlLrgVbaQswJNMDnbPOckZSYL+zzWS4mfkLozTIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3OfTkGF; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63bc1aeb427so5544693d50.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761609620; x=1762214420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0jPekmeuStjVGpec/HMLm4gu4TE+ZdPOQZ7xh71HRHU=;
        b=f3OfTkGFr+a3vsvahF5NqWkhzLxXStqnOTYADS+bgza1Gj/rDKIjX+kqOzP75aoOO5
         j9+vqIfgCn3dD1F9OoA/KGTby3fCG3jaCS8P8eO9YzM7Xa1G9chcgJDC94Fg0WWP0m6r
         9LKSfpiicMkjKAxJsJirAxTUKxdBpMJUY/lHP3RNjnqHPPufRdgpaZqmzz/R65sm6Xok
         xBV6Q5DwWzOh5ziugYVTor9xgyMNvQwQB08zf/Xq8gw/3bmhXuCEngoyyixDv0JTUqwX
         qyNIm77LVWc8vBzlOKFG3mvD2wTFH3IJUyZNBpe0Tn79LVAr+OFYNEEFDSKWVN8vhDzm
         mHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609620; x=1762214420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jPekmeuStjVGpec/HMLm4gu4TE+ZdPOQZ7xh71HRHU=;
        b=xODtdaqW6O6zoc6mWbj3K5tQlKd8BhmL318uCQFMG2cnoMPjzhi3rrGmvU9ZyNQZxH
         t0xxBFWrZaqN229Gj3mFtaWu62qAAwtxwMt+ziqSovYojAR+426l/s3GcNpPFXGdLop/
         44rXL6WnutWAnGVE/j/5o1MQsRnS1aVlsjdOQ5HQjBzz8TXsH5gVGnNG7HIsz5Vl40d5
         +HYLMi2PqUQBkXbrfUR2iavdm3GV78mfymIIhZXnTfwE3UEknU/x7Zg/DCq8CAiWNbE1
         mtEywBpRsky73FMUwyJ3FZz286abaPOFPz2YsT4g9P1wL+D9Vy2Hv5z6owPGCWKjJe6D
         zU2Q==
X-Gm-Message-State: AOJu0YyDep3Tom+bsUDSVL4YE2/tsYQq861Nuw8p4ZLIqlIonDFnVRr6
	50HxI9Tc8G7dgjAXdUZZSwNEIWWZl5A6NBF1TRT+zA56/64P5zghvGKd
X-Gm-Gg: ASbGnctoFLiJWaHEX25UJdB54hCioKeMdjTU/zAc1mmTRRpbILNQByHCB/yd2Lcz12B
	NJNowR7klqfSOHR5RC1O6BT6AhuliDFANfL5ZMS2t4Y7CflNw1zzy1SZ2vVoL0+O/ZBf5rgiSfI
	GXmAibYr3bOPE/ExeMrXdLhjCZb3gmktVrG80FmhLBrcSweyem5vBjR14TG2LDiVz+aL1pxb5/D
	ZOVtHBWnUtCO2w8zSlKDtSLd8cIBdaK2t68Kdfuh8MPtqUqT2ubpuueIXK0dsHzIpR7nPVQ087y
	S1LP7Sk8iR+sIeBeqJ3UL8vXj0l/7CrrFQRT2RdSqTIOh/8VnLI5z/p4bAVuNQySG7/FhLeICwF
	qonNhFKZrhiEmG2bSUIyZGTR+CncvCLmulzce9CNsaLhz6maq2eKZerBwJIKBPv9D5c+riCl1Lz
	s0fcJBoI6uoMvsZgj+X3d6
X-Google-Smtp-Source: AGHT+IHEOU6uhY0872obOeCg7UUipndO0NvC1yiY2mqs83o/mIpworn7pUKCrn5T0+gJY9mnhTcEvQ==
X-Received: by 2002:a05:690e:d86:b0:63e:3420:5654 with SMTP id 956f58d0204a3-63f6b9b2f42mr1844475d50.1.1761609620489;
        Mon, 27 Oct 2025 17:00:20 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c441fe2sm2724061d50.15.2025.10.27.17.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:00:19 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 0/5] psp: track stats from core and provide a driver stats api
Date: Mon, 27 Oct 2025 17:00:11 -0700
Message-ID: <20251028000018.3869664-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces stats counters for psp. Device key rotations,
and so called 'stale-events' are common to all drivers and are tracked
by the core.

A driver facing api is provided for reporting stats required by the
"Implementation Requirements" section of the PSP Architecture
Specification. Drivers must implement these stats.

Lastly, implementations of the driver stats api for mlx5 and netdevsim
are included.

Here is the output of running the psp selftest suite and then
printing out stats with the ynl cli on system with a psp-capable CX7:

  $ ./ksft-psp-stats/drivers/net/psp.py
  TAP version 13
  1..28
  ok 1 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 2 psp.data_basic_send_v0_ip6
  ok 3 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 4 psp.data_basic_send_v1_ip6
  ok 5 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 6 psp.data_basic_send_v2_ip6 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-128')
  ok 7 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 8 psp.data_basic_send_v3_ip6 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-256')
  ok 9 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 10 psp.data_mss_adjust_ip6
  ok 11 psp.dev_list_devices
  ok 12 psp.dev_get_device
  ok 13 psp.dev_get_device_bad
  ok 14 psp.dev_rotate
  ok 15 psp.dev_rotate_spi
  ok 16 psp.assoc_basic
  ok 17 psp.assoc_bad_dev
  ok 18 psp.assoc_sk_only_conn
  ok 19 psp.assoc_sk_only_mismatch
  ok 20 psp.assoc_sk_only_mismatch_tx
  ok 21 psp.assoc_sk_only_unconn
  ok 22 psp.assoc_version_mismatch
  ok 23 psp.assoc_twice
  ok 24 psp.data_send_bad_key
  ok 25 psp.data_send_disconnect
  ok 26 psp.data_stale_key
  ok 27 psp.removal_device_rx # XFAIL Test only works on netdevsim
  ok 28 psp.removal_device_bi # XFAIL Test only works on netdevsim
  # Totals: pass:19 fail:0 xfail:2 xpass:0 skip:7 error:0
  #
  # Responder logs (0):
  # STDERR:
  #  Set PSP enable on device 1 to 0x3
  #  Set PSP enable on device 1 to 0x0

  $ cd ynl/
  $ ./pyynl/cli.py  --spec netlink/specs/psp.yaml --dump get-stats
  [{'dev-id': 1,
              'key-rotations': 5,
              'rx-auth-fail': 21,
              'rx-bad': 0,
              'rx-bytes': 11844,
              'rx-error': 0,
              'rx-packets': 94,
              'stale-events': 6,
              'tx-bytes': 1128456,
              'tx-error': 0,
              'tx-packets': 780}]

CHANGES:
v2:
  - don't return skb->len from psp_nl_get_stats_dumpit() on success and
    EMSGSIZE
  - use %pe to print PTR_ERR()
v1: https://lore.kernel.org/netdev/20251022193739.1376320-1-daniel.zahka@gmail.com/

Daniel Zahka (2):
  selftests: drv-net: psp: add assertions on core-tracked psp dev stats
  netdevsim: implement psp device stats

Jakub Kicinski (3):
  psp: report basic stats from the core
  psp: add stats from psp spec to driver facing api
  net/mlx5e: Add PSP stats support for Rx/Tx flows

 Documentation/netlink/specs/psp.yaml          |  95 +++++++
 .../mellanox/mlx5/core/en_accel/psp.c         | 239 ++++++++++++++++--
 .../mellanox/mlx5/core/en_accel/psp.h         |  18 ++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   5 +
 drivers/net/netdevsim/netdevsim.h             |   5 +
 drivers/net/netdevsim/psp.c                   |  27 ++
 include/net/psp/types.h                       |  35 +++
 include/uapi/linux/psp.h                      |  18 ++
 net/psp/psp-nl-gen.c                          |  19 ++
 net/psp/psp-nl-gen.h                          |   2 +
 net/psp/psp_main.c                            |   3 +-
 net/psp/psp_nl.c                              |  94 +++++++
 net/psp/psp_sock.c                            |   4 +-
 tools/testing/selftests/drivers/net/psp.py    |  13 +
 15 files changed, 561 insertions(+), 17 deletions(-)

-- 
2.47.3


