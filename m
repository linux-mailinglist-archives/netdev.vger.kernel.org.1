Return-Path: <netdev+bounces-274270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEQ4GViszWlRfwYAu9opvQ
	(envelope-from <netdev+bounces-274270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:38:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A271381B5D
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42289302AF14
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 23:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A1239D6D1;
	Wed,  1 Apr 2026 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="x/U9D/ql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7C2F25F5
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086676; cv=none; b=Tut0Ndd5s1HhUGtv9txoRD1l0OBaKy9h3p2GfZ/oFmR04UTQWGgqJkoD4/QW1MjmWkzclspshy6faOCLkqgjrxOLG2k5wQ6GrgL99SKUnxMkIWoQVWLtpCkqzzRMF/ZmAe1YgPpm9F8S4cvqIP/avBIuaaJuWg+ERkizL9mK4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086676; c=relaxed/simple;
	bh=xEnHjLwgdWwIsEFlip45v8+B0o+PMY2NcQKIg+qSizg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1ysN38a2EAYrzVbDqD/jEA7RUteD0zcGs31Ko3mUnvHyLYTT39sXIcr6c3uDkDKJrFvOmZDPDA8qv+xu1BDinm1wwiB2+bSLqtzoK1TOI84c/fN1jNrw/zLM2+Wd8vOCGskSyZhxbnRml/OR63swC+aIxNCQ0YZb+/FGF6zuUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=x/U9D/ql; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so199444a91.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1775086674; x=1775691474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+7Ok0pVkBBdH5cQm5a2hPtpU0u6tnSaNtrVrEGRjrg=;
        b=x/U9D/qlfY9Dw72fN4C4N0dB/FjUDxcwWAxtVGfdBNaS+uojO6g2ughSEii1QHDsob
         vdfL1fWkIL2SrW6BM805mgQgJjGSMUAwBCbW6jC/UeYGszag0qiWxMY/BbtniFEmJvaR
         IZEAIXWf+eUtSosnAohVfODNuO45mxKUzxNAdEX3r/O9C61r+/brvUF9ygpVaZN9cIbc
         YTqIfVd0Z77Qwebs184jC8qjxiux576bLog8BTTP7Iz6X1nKGAGPoeIdRNU0Kup6MTqO
         Jz1Z/x1RgoMk/k2zZdQSh/95zwrkCFcw573DFNkMBfc+6qRvlCEV1kdpiame8jTkl8Fo
         hKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775086674; x=1775691474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+7Ok0pVkBBdH5cQm5a2hPtpU0u6tnSaNtrVrEGRjrg=;
        b=k3hMhlNOtaz08tiX/ZQE7CgKzfv07zMamLfMWF3sZ63hQGCm/jIkYypSPvCsG3X9uP
         9rDW0pUlQeSDid3ghX9ffJxFMtq/4qbV2Bf8EoGInn5ZdnRTYoXWmE2zR2f9HegNIb7/
         zzBSYrVbkl5KuCW+aszdx/Wdwj9p4awSxjEidihCdaLIkB+RwJQe1SaS1HNPIkSGXdXr
         LpzrXch9poiILMcs27FT7Gj65uj0plY+Ek6z/lx6bJxaT8XPM3q1Zh34EEWYrymauCWE
         n3VbsUY1mm+VGkHVKJQT3i0z4iYi6bH6IgyLNhM2Lz3wFgv+TknoM4DJEZZLpYCHeqEc
         Y4pw==
X-Gm-Message-State: AOJu0YwoCK/OzY7vlLToBiDtlnaHBoIcTl69DMzCZ9n6Yk/+/knXISBS
	5kFITYZmyLQQEVfKzWUkGub5icTV50DitRNZ+v7fmotGzkvl+mQDjQpTrZhJxuGH5gzuPJB6R3j
	ZHk2PcHo=
X-Gm-Gg: ATEYQzwSdWSv3/M9J0mLZNzKG8h+lwo+WHZReOwh5cfmeqTTbtaeCm99ISnls0JFlZO
	6v2yqoqBA9FWZ501axx4EsNwdtfNUMc8qPYzp8kIwuSqL9zOu6EAYlIbgTk7ic3E0w7WYsoNu5z
	BKC1OGbdk420QVgFCOHqAbiNQfsLHFPwV6Da6pBbf6lVuSlA9KUFJ6H/QbJ7Xs8mYo6VHAo74KR
	s8diKFocDufLOU2u7Pcte+yodkkuFL1SUdtX89dx4wvXhqtFXgawTCXaSBY53M8wHHtv9frh0k3
	2XUIAzp14+RHttVH1JwltaJhIMsh9TDF1s8oSGB++vdv2FmAcRCqiGoqhYE8FMnfTCRVnDQvWS3
	iFwRIDLD5VpS2lCsSG5RD7q+FbDcMSiCTbcCaEZBsGur4BwiYc17TKgg935f1G8lHd5zs0QeT+7
	IAUGc=
X-Received: by 2002:a17:902:e54a:b0:2b0:cb96:9815 with SMTP id d9443c01a7336-2b275da7802mr10104905ad.43.1775086673742;
        Wed, 01 Apr 2026 16:37:53 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477736dsm8171565ad.24.2026.04.01.16.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 16:37:53 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v7 00/10] Add TSO map-once DMA helpers and bnxt SW USO support
Date: Wed,  1 Apr 2026 16:37:28 -0700
Message-ID: <20260401233745.2333858-1-joe@dama.to>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274270-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:mid]
X-Rspamd-Queue-Id: 7A271381B5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Greetings:

This series extends net/tso to add a data structure and some helpers allowing
drivers to DMA map headers and packet payloads a single time. The helpers can
then be used to reference slices of shared mapping for each segment. This
helps to avoid the cost of repeated DMA mappings, especially on systems which
use an IOMMU. N per-packet DMA maps are replaced with a single map for the
entire GSO skb. As of v3, the series uses the DMA IOVA API (as suggested by
Leon [1]) and provides a fallback path when an IOMMU is not in use. The DMA
IOVA API provides even better efficiency than the v2; see below.

The added helpers are then used in bnxt to add support for software UDP
Segmentation Offloading (SW USO) for older bnxt devices which do not have
support for USO in hardware. Since the helpers are generic, other drivers
can be extended similarly.

The v2 showed a ~4x reduction in DMA mapping calls at the same wire packet
rate on production traffic with a bnxt device. The v3, however, shows a larger
reduction of about ~6x at the same wire packet rate. This is thanks to Leon's
suggestion of using the DMA IOVA API [1].

Special care is taken to make bnxt ethtool operations work correctly: the ring
size cannot be reduced below a minimum threshold while USO is enabled and
growing the ring automatically re-enables USO if it was previously blocked.

The v7 includes a few changes suggested by Jakub Kicinski detailed below and
in the per-patch changelog.

I re-ran the python test and the test passed on my bnxt system.

Running this v7 on a production system with real traffic and toggling USO off
and on shows an ~84% reduction in DMA maps per second when USO is enabled.

Note: I've dropped Pavan's Reviewed-by from patch 7, 8, and 10 because there
were some changes to each and it felt like the right thing to do.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20260316194419.GH61385@unreal/
[2]: https://lore.kernel.org/netdev/ab1f764b-de03-48f5-a781-356495257d25@redhat.com/

v7:
  - Squashed patches 1 and 2 of the v6 into patch 1 of this series, as
    requested by Jakub.
  - Added tso_dma_map_completion_state and helpers so that drivers don't call
    any of the DMA IOVA API directly. See the changelog in patch 1 for
    details.
  - Changed the placement of the is_sw_gso field in struct bnxt_sw_tx_bd in
    patch 6, as request by Jakub.
  - Updated struct bnxt_sw_tx_bd to embed a tso_dma_map_completion_state for
    tracking completion state and dropped an unnecessary slot check from patch
    7.
  - Added bnxt_min_tx_desc_cnt helper to factor out descriptor counting and
    use the newly added tso_dma_map_complete from bnxt instead of calling the
    DMA IOVA API directly in patch 8.
  - Various fixes to the python test in patch 10: use ksft_variants, socat on
    the receiving side, and cfg.wait_hw_stats_settle instead of sleep.

v6: https://lore.kernel.org/netdev/20260326235238.2940471-1-joe@dama.to/
  - Addressed Paolo's request [2] to avoid possible stale iova_state if the
    IOVA API starts to fail transiently. See patch 8.

v5: https://lore.kernel.org/netdev/20260323183844.3146982-1-joe@dama.to/
  - Adjusted patch 8 to address the kernel test robot. See patch changelog, no
    functional change.
  - Added Pavan's Reviewed-by to patches 6-12.

v4: https://lore.kernel.org/all/20260320144141.260246-1-joe@dama.to/
  - Fixed kdoc issues in patch 2. No functional change.
  - Added Pavan's Reviewed-by to patches 3, 4, and 5.
  - Fixed the issue Pavan (and the AI review) pointed out in patch 8. See
    patch changelog.
  - Added parentheses around gso_type check in patch 11 for clarity. No
    functional change.
  - Fixed python linter issues in patch 12. No functional change.

v3: https://lore.kernel.org/netdev/20260318191325.1819881-1-joe@dama.to/
  - Converted from RFC to an actual submission.
  - Updated based on Leon's feedback to use the DMA IOVA API. See individual
    patches for update information.

RFCv2: https://lore.kernel.org/netdev/20260312223457.1999489-1-joe@dama.to/
  - Some bugs were discovered shortly after sending: incorrect handling of the
    shared header space and a bug in the unmap path in the TX completion.
    Sorry about that; I was more careful this time.
  - On that note: this rfc includes a test.

RFCv1: https://lore.kernel.org/netdev/20260310212209.2263939-1-joe@dama.to/

Joe Damato (10):
  net: tso: Introduce tso_dma_map and helpers
  net: bnxt: Export bnxt_xmit_get_cfa_action
  net: bnxt: Add a helper for tx_bd_ext
  net: bnxt: Use dma_unmap_len for TX completion unmapping
  net: bnxt: Add TX inline buffer infrastructure
  net: bnxt: Add boilerplate GSO code
  net: bnxt: Implement software USO
  net: bnxt: Add SW GSO completion and teardown support
  net: bnxt: Dispatch to SW USO
  selftests: drv-net: Add USO test

 drivers/net/ethernet/broadcom/bnxt/Makefile   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 176 +++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  32 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  19 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 227 +++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |  39 +++
 include/linux/skbuff.h                        |  11 +
 include/net/tso.h                             | 100 +++++++
 net/core/tso.c                                | 269 ++++++++++++++++++
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/uso.py    | 103 +++++++
 11 files changed, 939 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
 create mode 100755 tools/testing/selftests/drivers/net/uso.py


base-commit: f1359c240191e686614847905fc861cbda480b47
-- 
2.52.0


