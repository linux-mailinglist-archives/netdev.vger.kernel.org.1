Return-Path: <netdev+bounces-274794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK7sKSEMz2kNsgYAu9opvQ
	(envelope-from <netdev+bounces-274794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:38:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAA438F8FC
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA7D83057C7C
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD3B23BD05;
	Fri,  3 Apr 2026 00:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Mu+oi+s3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1045BE3
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176550; cv=none; b=C4Yqe26LTfwyQznQmnkda8libsscKBhNwHXLtqZoT8FZJlkZnHuLGqTB5OuOdc7CMWTtxU6Yvj0xVpCtSqXtUfdkmgYYUiaWnQsvjRU+U3x9gscA8ki0GU/DcebnOOc+DokkjW52r7j24RTlPM5nrkUYtN+j6j13eOlKAMO3i6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176550; c=relaxed/simple;
	bh=GJOSz4HKixoo1Cb5OaACSUHZw8IGIdz2whTgQvq2fUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VClXWWiXStnFhDbZYmlqltgXy3VQFVvXQ8PVHRvZBmuaLmhwC1Ix1eSLRC1QeaprY2lkga2J5mFCR1Z82vDmlqCdXSmfafJG6cnfGsvRYsppwFiW079p5Wxwa+3P1TsMSaptIaPyyqb/RVCHunG5t1sS77hHLhRTQj3C12+ogp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Mu+oi+s3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d90833cacso880200a91.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 17:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775176547; x=1775781347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MO07hvK4b04lTgujdhZrKlC7UxEyCUQbTf0fJ0M4m9A=;
        b=Mu+oi+s3xQKvsyn1UON4jvXGWmk9xqwczQBCvYX+Ga8fL+ILF1PphbdIgK6c1JIi6T
         MbfzpgCi8cZ7gj8e1/LP8Zd5/CCewhwk7elFA1RSqC7LcY9GiTZY8Kjk4UXx1aD9v8mj
         52CgQys5VdCBBL6ETQRB8I90JIYo5zpy3QE4gD1e0Ex3g6J67jIlJ6O9oIPK3j8/gCaR
         YkpY577j34cB05KxaxQRVaGL4XAZGZaRd5C0WyNYat4jm3hIljoXbGC0J17yo4s6joV0
         /2IhztRq3r27by+IO+NfcHdTUtm0ruvz+W9v2GWxy4eP3+ueLVD/ZviirYZBEvLJqRFF
         EGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775176547; x=1775781347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO07hvK4b04lTgujdhZrKlC7UxEyCUQbTf0fJ0M4m9A=;
        b=XNCFyGmAFopaCX9X0o5dmpBMR4LbX8+nNt2Gth9J7lVyuqO1mwVrMKQp69W2Eq0qCc
         fruYjzcahCgMhvTr3frd+voaLt2uktmX6QJDxaoUFlnJ09Bxf9fHd3Zd3nEvxUoEpkrk
         nX0TM9fd3Xwr3E0sGhHaWjhTG84G2q42pyhXRhwPkxe5ZfSZe+71FduUvXd/CIsPGI9L
         TkaWVDswyFB5/5BjsyFhI2hKeSZrPqbubNKyRMo2ECfZNE5+MVgLfrcz4qZ0KKKmzdTj
         jeV5xid7CdNE5Qt4dfQX1kFcx4d6MaA/X2eMCFK+BWf9vIFKiCGG0s6m9DHtZ+lw5WNZ
         MVOg==
X-Gm-Message-State: AOJu0YwusjYmqmi7RCKc8hfE02d0qPoMRI0IKNZkMQYFEpRem/yk6jnR
	OospLLR4UacXF5ZQJ/yK1lz0sowvPrvbMvbv3e+NcYA2QuOTnx2+lW9lWFKoLzHBcrZ769FIqIE
	k/2uEeY4=
X-Gm-Gg: AeBDievaFUPTspKC2HbLucpoqM9jB1W/zm7WEZyYSMnuQrCq6y8ptgpJiaIHyFzhK4B
	9Z51p8hqDJERoLexyDLYqs3LwhWztN0ma4SOSxVVXpokfVVa4EQ4rIYGDim7nZ/D7zYc8TsNTGw
	bEXLF62ezIbjNcJ/PdfiYyEtl/UMSSa/v6JqCwubbw2LhsjwtH8hJIwSTJ+GOHKFkhkuQI6cz+J
	C8vx9eNCvnvjKc/3X6z0fUwnzO8PWFWRkfavgHGu+/N0DHhrmJOIuNshh0/9B9pStkMmuuwgXgy
	uG2O8oIXI7/KAy6W4ezOdMT/nEoS/N0y7gjrgjK85daF/lRZFM4fmOfNk8bxIWtJkJyNWQGaqk9
	OpO9Fk1QKcWevoTpRtPG/sOLXeiBJtWlmaxy5QEqQtDk033v28jZVaEA2EGhMO0pPUGIIpqB96b
	sFvBbn
X-Received: by 2002:a17:90b:3f4d:b0:35d:93ff:2859 with SMTP id 98e67ed59e1d1-35de69a6469mr812447a91.22.1775176546864;
        Thu, 02 Apr 2026 17:35:46 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9709b8sm8663348a91.16.2026.04.02.17.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:35:46 -0700 (PDT)
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
Subject: [net-next v8 00/10] Add TSO map-once DMA helpers and bnxt SW USO support
Date: Thu,  2 Apr 2026 17:35:07 -0700
Message-ID: <20260403003524.2564973-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274794-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim,dama.to:mid]
X-Rspamd-Queue-Id: 2DAA438F8FC
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

The v8 includes a change suggested by Eric Dumazet in patch 7.

I re-ran the python test and the test passed on my bnxt system.

Running this v8 on a production system with real traffic and toggling USO off
and on shows an ~84% reduction in DMA maps per second when USO is enabled.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20260316194419.GH61385@unreal/
[2]: https://lore.kernel.org/netdev/ab1f764b-de03-48f5-a781-356495257d25@redhat.com/

v8:
  - Zero csum fields on per-segment header copy after tso_build_hdr()
    instead of on the original skb, avoiding the need for skb_cow_head, as
    suggested by Eric Dumazet.

v7: https://lore.kernel.org/netdev/20260401233745.2333858-1-joe@dama.to/
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
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 232 +++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |  39 +++
 include/linux/skbuff.h                        |  11 +
 include/net/tso.h                             | 100 +++++++
 net/core/tso.c                                | 269 ++++++++++++++++++
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/uso.py    | 103 +++++++
 11 files changed, 944 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
 create mode 100755 tools/testing/selftests/drivers/net/uso.py


base-commit: f35340f2d653f1003602878403c901396ab03c17
-- 
2.52.0


