Return-Path: <netdev+bounces-231870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3FFBFE0EC
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF8219C705D
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FE52F5A39;
	Wed, 22 Oct 2025 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFDjxYtT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CBD23956E
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161862; cv=none; b=idoVFpZQSlYPDCUX+3wT8YBp4heEZjifI5Iz4mIiwm8qLltOF3fdNfOXQk7Jalilcn/GeRJGaHnE3jMSIB6ua76vWb64uADYPMAtf62luR8a5tLDU0qF9TEslUEgdVp1HF39gD1WaJ8PnYfYsvbPrHvdkLLiAbAh6H0dXXyKnrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161862; c=relaxed/simple;
	bh=8MRW3yqAKMYQuQUed72t6yP7Ve4PLYvFlWdPE0tfFM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCQ90sRSW+rKgKJYNPckqaawKFokz18fkBYmozRIEl6xbiSrgNiXJg9PBTGYVjugm9+cLyn49ZIhDDatnhyQ6pFswZLl6gsl9ICs6Y82WAdpcsvqnT5xMRbEnfqelO6gscd7rY8sFjwlDVkXdLrQOwgAfUMf7cI01J2YdfyF3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFDjxYtT; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d71bcac45so78705237b3.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 12:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761161860; x=1761766660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOYCBxEypI+05Fd3SHO/clagx6FGtRLSoRwJEgGRcG0=;
        b=RFDjxYtTN41aLoyLO7yoe6rTLKP4VuhY1oelqIR4VxuY+RaY6OW8/CxRBVRQZWuw75
         hPk78Vc13jAEfRgd0+xDTVMTM+B7pvwp2nHLr+Sh8ptwkDqtX1OemUoXNB1pgxCHGTC3
         21NkSLGFQ2wB1D5qiGWo+HttVqvj3FtzlZlKY5yD3A+DazsoKiuATrqcWDoJbRVRM5Vo
         qtmKPbH9MpK9WcUhxSfDnq4FIv9xZ9lKj1jR5QI2GB3LPafS8AzSsRbkv6H4d5WFca/z
         qZB1J684ju9HCve8bJhfVkF/FZJlj5j+AuREs2nTkfh/KOdiZT2bp+RKmLaUVPJcxGgD
         mVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761161860; x=1761766660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOYCBxEypI+05Fd3SHO/clagx6FGtRLSoRwJEgGRcG0=;
        b=QmTOesfL6YnCZjX0TAXVb6VhtZuJV2mMKPS3CshEL5N8jLN87rsK09hapnegit6ic0
         4r0JzCbhy3T3H87EFFPI9GKgqYAv9bcgOoWeUN3kzzwJMjvZF1MDt6hvLFVSp3WqjK7i
         tU92RhZOb623c82p2cq8/Cyocr1H3iJciIKVDbNoDh4ckMkbLrzTsBuexjl9AuAdVTJ9
         ZAAdS2oGk+6cEcZ0uAnVpy7Q+yPc+FN4wUQtknXrdEeV0uozHp0RCjWohHuKyl3bhBe7
         vipS6gNaG65rQORsGIN8+xXJSJnbcvtz7MuYLW2BR6VobXQCZRc1HPSdsKb7CRl1J2r6
         AsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj7NjKDy2MAaAtaLQaTw3H4yP0vF47IisEWv1P547+d/R+AJt8gHqukAbjuBueUp5/vBuV/rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNvR3OV4bnUTqsUxb/Te++3RZFudkMZbrus/nhkTZl6uXcjDy9
	Iw0asUlZqmKST0Ng5xSVWpOJv2DbiUi1NUIApLu7nGUTAH1Y2+poBLBS
X-Gm-Gg: ASbGncvIUPc+1pj+DvMySUqnVGNXsVyG1dRk9B5wGSALWUAkzvznHnBc7m64EqchA0X
	Zfay8+RNvwej4Ja0ZkiZFhi5MobPbXjehbDiZkjf/bZEAT0j9VdYe/iUyRyyYLzfpDaIQtxEhqS
	9TVfWenE17TsVGS2CZFE5dIT5nW33mecfQHxFPQnae+bhaMWsFLXzRymn+6tF46/UaTvJSi02wr
	SaXpPgQGSML6SgVmkJnXFjQzWtXYnLBsnKmYnn7+eLKcSjWXkKuKTjQ2COFkEuF/y1HY68oxM3f
	w8SaYh2nEQTmjQM2EA3ecjch2BdMNXK5Pqr5RZwGdLHAJLlyP3YZvPfj+iCAPXIf/xxBlLA7e2o
	tCHhb8wDhVCrsnTMEWX0Qvlg0coG56lqWHxOxMydLEwK9rLMY2kqTev+lWHl6MQQi1+tQ9mnxL9
	kN8tSkjr8i
X-Google-Smtp-Source: AGHT+IHaZkspjhYREdwfy6s1DSoZj2lZnE2ffrgRfmqH8s1EmjVlOY1M8Rp5dvU/yDbSsJG4m+8/WA==
X-Received: by 2002:a05:690c:288:b0:784:857a:46be with SMTP id 00721157ae682-784857a5917mr123672537b3.18.1761161859943;
        Wed, 22 Oct 2025 12:37:39 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd607f60sm354947b3.27.2025.10.22.12.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 12:37:39 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Willem de Bruijn <willemb@google.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 0/5] psp: track stats from core and provide a driver stats api
Date: Wed, 22 Oct 2025 12:37:32 -0700
Message-ID: <20251022193739.1376320-1-daniel.zahka@gmail.com>
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
 net/psp/psp_nl.c                              |  99 ++++++++
 net/psp/psp_sock.c                            |   4 +-
 tools/testing/selftests/drivers/net/psp.py    |  13 +
 15 files changed, 566 insertions(+), 17 deletions(-)

-- 
2.47.3


