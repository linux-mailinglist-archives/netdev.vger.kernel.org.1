Return-Path: <netdev+bounces-276186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HIDFzJ/1Wn36wcAu9opvQ
	(envelope-from <netdev+bounces-276186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:03:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A753B52F6
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88AEC3020ED5
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 22:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB73783B1;
	Tue,  7 Apr 2026 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="LIixkSy3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2354033ADB5
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599405; cv=none; b=RNwxykSAt2QC6y5YEXLopgQ9ATmxMN+rECPmz+6jgli1c0pnxrXeH9PQaTL5EqKizFmh2pDSjjEvWDFqrtucAA+lqljXT2liLWt2cjxQFJoF6H4PNgKeoSZGVqFuo/5tWHfWOHNOlYNwFb5Rz6qTvWAmvZ7rrJJgpFxzQGXrTmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599405; c=relaxed/simple;
	bh=R9Ev0zogTiHjsyuljx2Sdso62krPgL8PxDPBCqZZAOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDR/BEZwqkMRpMaWkPeFxtNr/9lXRKO3p8AwVvq8xJQ5x1wWMPGDhfQgKKP2BVG9MdUzqLtRrtMSZbmt7mrgO47goJ0hzcmlDY+QFxAQFAqSw5aq6rjdqAV4zhevsPPs6F5StxNSHC0Z0PDdJySH8z5WvG4bH+pGIoPawQQThEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=LIixkSy3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82cef263bedso2564042b3a.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 15:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775599403; x=1776204203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+NkNuo1dL61M4TOsxnAKY45kzJHNMyPYM8/9T5ERZ4=;
        b=LIixkSy39Qe+BIqRQp2NhgqmCh2NDDW4K5iSDckfkOS2otMA7JAcNG6VP9bplNzW2m
         PXA/dqOae5cwURsiiHMuHgZ/es8EhrNcG8rEMBZxZEKnc56f/vZGALQIV+tRFpVi4cLs
         yEYyr1GVaOx9anToOl5d3Nh3p/miXwHmRHldu0t7wL+YZCCBQlfjVHp19L3zOzY3gz/7
         87Qml7wdDTWslG0W++090EqPBWd14zZNq8voXLcqCOhxg6e+jLKierNjoq7y86g0scQv
         AU6/FvZDlhq8/+5LzHygU36mAY6I/6o+iLBEmSwhdYoweo4xcEDu2JCaYl3jAiPM70gx
         qjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599403; x=1776204203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+NkNuo1dL61M4TOsxnAKY45kzJHNMyPYM8/9T5ERZ4=;
        b=Z9xmoUbClXJgziwJgXA+eamEh+FOYwzPOyRmMRJZpipCz37jX7dbvgLA3J6V6ilYJt
         8f9QDkmBdwa62QqF/Z+lLlK5eU7TUy0ymMSsnLzC3hqDfZjmfveWxggR5EZg6qpACU5r
         3JNMsrsuT2kz+EMgSD4wI/TxKrKZfiv2hpuMXkDgJApfSS26SPtS+Hti+sgha4oEi3ty
         mkAqn04q2kGVgpn+HkZaggExYwRnCFN+26U6g0LAtdxXIspQj/y6nYfafsAr6x+uinha
         GMVQFRTvxA/sqiqZpg+KAF3ZSYItzqZJwVvKhaWTdKAd1VIf10MCUKtrRfaWGWtL4VW3
         wDNg==
X-Gm-Message-State: AOJu0Yy3EqgVjXReTTtefVVDwRwlBavJHIHSbHDy0lOFUv0HAn2sA+4y
	OsVCtZdXNmwdITT8bdIZGT/d4WZdh90JE7dQD2a6yhBWPXtWTyy7n3aCvmViTSSVsqdhKCx1jlt
	WzT2r
X-Gm-Gg: AeBDietR3dwcWN9CvKcib751um9oqkBcvOB07EVRmkkR5W/WxsOBudw9IjOVFFs2zOF
	Szd7zMnjKFK4el8P/OooiI5+frw9WPWJNUbFgn98CanE6EsMY2KUYQgkTMe29shKyc4uDtbNyR8
	m39IfVA8L6E1csSb1PpV0kM8gSgyL5F+WVq9jWU322PZbFYSSL7+jyjVOQ9+wAjCCHv8L1jaIcV
	3xDCMkxOnRRGzH5QDfogJ7cHMnZIlwNyAC9/p+zJGFP9bdAKmgk4dOori0vlTlUNgJvfOBkTPti
	rvtYed4FlF4YMifR/qb+fX7j/vuh6KP4Pu2STMelHdxZSDoI79gak2eVWhQqo8hsvb2y4NngF68
	hf0aQZPrY/pg0/ybN+Cw+9zgKWJ4DQZGAfh8iX0RUIpORGkLX5pFy/4WvEn6fSZuzOQzpKDhABd
	q0rhba
X-Received: by 2002:a05:6a00:808:b0:824:b181:f492 with SMTP id d2e1a72fcca58-82d0dbb0808mr17349262b3a.45.1775599402978;
        Tue, 07 Apr 2026 15:03:22 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3d439sm19610946b3a.35.2026.04.07.15.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:03:22 -0700 (PDT)
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
Subject: [net-next v9 00/10] Add TSO map-once DMA helpers and bnxt SW USO support
Date: Tue,  7 Apr 2026 15:02:56 -0700
Message-ID: <20260407220313.3990909-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-276186-lists,netdev=lfdr.de];
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
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C9A753B52F6
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

This v9 contains several changes, mostly stuff AI found. Changes are listed
below and in the per-patch changelog.

I re-ran the python test and the test passed on my bnxt system. I also ran
this on a production system.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20260316194419.GH61385@unreal/
[2]: https://lore.kernel.org/netdev/ab1f764b-de03-48f5-a781-356495257d25@redhat.com/

v9:
  - Patch 1:
    - Fix typo in commit message.
    - Fix kdoc.
    - Initialize tso_dma_map before early return in tso_dma_map_init
      (suggested by AI).

  - Patch 7 (both suggested by AI):
    - Added inline slot check to prevent possible overwriting of in-flight
      headers in the buffer.
    - Made TX_BD_FLAGS_IP_CKSUM conditional on !tso.ipv6

  - Patch 8 (suggested by AI):
    - Always allocate header buffer for non-HW-USO NICs. Avoids a possible
      NULL deref if USO is toggled off, the device is brought down, brought
      up, and USO is re-enabled.
    - Adjust bnxt_min_tx_desc_cnt to take a feature parameter, which is needed to
      prevent stale features from being examined.

  - Patch 10:
    - Use UDP-LISTEN instead of UDP-RECV in socat receiver (suggested by AI).
    - Fixed docstring.
    - Removed unused return value.

v8: https://lore.kernel.org/netdev/20260403003524.2564973-1-joe@dama.to/
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 178 +++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  32 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  19 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 244 ++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |  40 +++
 include/linux/skbuff.h                        |  11 +
 include/net/tso.h                             | 100 +++++++
 net/core/tso.c                                | 269 ++++++++++++++++++
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/uso.py    | 103 +++++++
 11 files changed, 959 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
 create mode 100755 tools/testing/selftests/drivers/net/uso.py


base-commit: 2ce8a41113eda1adddc1e6dc43cf89383ec6dc22
-- 
2.52.0


