Return-Path: <netdev+bounces-221373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C19BBB5058B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5323A7115
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AE13019AA;
	Tue,  9 Sep 2025 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vLvGv6Ci"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942CF21FF24
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443804; cv=none; b=ONrMfrVpTFhnSO4qoJ5UoUpulORLqDGSj0JHdaCkkRwK7F1UEN5JPIlMFcEKz8KZYo41P2fu72Yfi08ePgRNDgWxPEOfwb+gzp2t+RUa+Anwu4HzKrFmkOMRZdcAfjmpLbvKGtE5HgmET83SBInLyfUFQ0388ImWx0t7tpFLHKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443804; c=relaxed/simple;
	bh=hs+vTxlvqaP4OntvBMuRkUyx59fMRUY4b11Fd8LMUZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LjVP9KTbrV8HJnY4Mv7+4TuOOiQrukM1O///qldE6AQQh3TY+88ZR+NuAxfQDSpPasjEtI673wIMgUC1WJTD9JIiDYlf/wrMUuS/uJgomI7RVSoihAcJxVlSEW76HDJWMiSp4vLgtD87oqHd7BnRLp+nHeb+AU3G9WgX1FgC+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vLvGv6Ci; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757443800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0PhEydbqvZSD9qE/hHd66/uSw17dpUJWZH8Y6pHdx/w=;
	b=vLvGv6Ci2qDiKyMfGJLjM/llWzfhjyuc5q0zAM3kq2qW9rPNzQIlApUapbX8YnLf/Dbuf2
	0aXSi85zb7f1M+vhqc5MiZsoBVl4lA+7oEVES40fhc+v4w2czuLt64uuJVa8fOzytUt2IY
	4Phc37DJjLhBqcSso51EAW1Pq5FdaMA=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	intel-wired-lan@lists.osuosl.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/4] add FEC bins histogramm report via ethtool
Date: Tue,  9 Sep 2025 18:42:12 +0000
Message-ID: <20250909184216.1524669-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

IEEE 802.3ck-2022 defines counters for FEC bins and 802.3df-2024
clarifies it a bit further. Implement reporting interface through as
addition to FEC stats available in ethtool. NetDevSim driver has simple
implementation as an example while mlx5 has much more complex solution.

The example query is the same as usual FEC statistics while the answer
is a bit more verbose:

[vmuser@archvm9 linux]$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/ethtool.yaml --do fec-get --json '{"header":{"dev-index": 10, "flags": 4}}'
{'auto': 0,
 'header': {'dev-index': 10, 'dev-name': 'eni10np1'},
 'modes': {'bits': {}, 'nomask': True, 'size': 121},
 'stats': {'corr-bits': [],
           'corrected': [123],
           'hist': [{'bin-high': 0,
                     'bin-low': 0,
                     'bin-val': 445,
                     'bin-val-per-lane': [125, 120, 100, 100]},
                    {'bin-high': 3, 'bin-low': 1, 'bin-val': 12},
                    {'bin-high': 7, 'bin-low': 4, 'bin-val': 2}],
           'uncorr': [4]}}

Links to RFC discussions:
v1 - https://lore.kernel.org/netdev/20250729102354.771859-1-vadfed@meta.com/
v2 - https://lore.kernel.org/netdev/20250731231019.1809172-1-vadfed@meta.com/
v3 - https://lore.kernel.org/netdev/20250802063024.2423022-1-vadfed@meta.com/
v4 - https://lore.kernel.org/netdev/20250807155924.2272507-1-vadfed@meta.com/
v5 - https://lore.kernel.org/netdev/20250815132729.2251597-1-vadfed@meta.com/

Carolina Jubran (3):
  net/mlx5e: Don't query FEC statistics when FEC is disabled
  net/mlx5e: Add logic to read RS-FEC histogram bin ranges from PPHCR
  net/mlx5e: Report RS-FEC histogram statistics via ethtool

Vadim Fedorenko (1):
  ethtool: add FEC bins histogramm report

 Documentation/netlink/specs/ethtool.yaml      |  22 ++++
 Documentation/networking/ethtool-netlink.rst  |   5 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   3 +-
 .../ethernet/fungible/funeth/funeth_ethtool.c |   3 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |   3 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   4 +-
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  10 ++
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 101 ++++++++++++++++--
 .../ethernet/mellanox/mlx5/core/en_stats.h    |   4 +-
 drivers/net/ethernet/sfc/ethtool.c            |   3 +-
 drivers/net/ethernet/sfc/siena/ethtool.c      |   3 +-
 drivers/net/netdevsim/ethtool.c               |  22 +++-
 include/linux/ethtool.h                       |  25 ++++-
 .../uapi/linux/ethtool_netlink_generated.h    |  11 ++
 net/ethtool/fec.c                             |  69 +++++++++++-
 18 files changed, 275 insertions(+), 22 deletions(-)

-- 
2.47.3


