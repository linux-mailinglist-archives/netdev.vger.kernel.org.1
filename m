Return-Path: <netdev+bounces-276731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9Xl8EWrf1mmsJQgAu9opvQ
	(envelope-from <netdev+bounces-276731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:06:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6C03C4A27
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D02F2300B466
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A12537B40A;
	Wed,  8 Apr 2026 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="IEj7qZz4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B2351C05
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689575; cv=none; b=EidMucvwCaUYGOw3ojk5/DM1eIhZ4+0jqbTORXnnoa+x4G50DDR4sweSA6pFNin4qzWa+kr5WPsGYVqB1+w8sKlcvkWXVzKq4tfTBcTQGMssCMAfPtwv4qUnOImm4ZyeGS7KPtMYlRlt92UWuszcddOEcyqKhL6O2JMbXB18g8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689575; c=relaxed/simple;
	bh=qDTHnC3SQ2hc/2PnvPHnS49C4bBPtYLYjhmwwdnFR2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upAszVT+fr8hM2ob/LEN9/HSzB0x6gAz8ayZRx5qYHeYlj3y71Ac/MCRCZvc22LeR/Wh7KVoLjLUsdqmc1R1KnSZdU5ZgRDzu5/asgcbvYQYjgD/7VHO1P0dOGw046d1JRDkg8gden+6wqRS49bj00mOjz5Tvf57rnu/bUHtyKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=IEj7qZz4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so202234a91.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775689573; x=1776294373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gwm/QItU9Ek9K7SmGNImmxQeXr7Zs6/bWtbpAkVQGNk=;
        b=IEj7qZz4kCZZKRztMQSOYgXPMXK5y4zMJMX/6kbaaf9+GG4fUak5Xczf48+619ZTR5
         NDEhCFnET1aJ7eim57e2A+FnR1qwZQUBqb+lohxYi/+F6WS7F0XCK/VRp5NVOqvJQPhy
         6P1tQXooz2iOtreZK3pGHAsiw/AE/nDVO0NqbpLHRi5fnvipBP/m3iAUItqFwY3NGpPv
         MP7EcygNumtfwxGMD6lTuTAIfXOo7Kfmeri26QXoloVNuV+qgNfDd7Zw9IP7+18CuMyf
         sGVL8szQAUUsSH1AgeB5bv0taJCMOi0z17fONSMBZnc+JiPBATCY5q6+fCE/5xdyX63N
         jToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689573; x=1776294373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gwm/QItU9Ek9K7SmGNImmxQeXr7Zs6/bWtbpAkVQGNk=;
        b=YKz0qjEl69LZtm49HXC7+1FkuxwBiThJKOrJo3k9BvzwcAq2dI3lKp0azohw+gq54E
         K2IBfyQLkzkschLBfSCVw8KlgaYfZbyaMSJIcWO7sBGl53tjFgBmjB4eOD+hwqdgw8F+
         joZPz44rtar2FAN9K43rSSLrvNRp1oEEkvKN+zUWKJUX6jBLSEIDplGSmAJMKFhRElGk
         iP8hkH/NLnEkwGmkp/QzUpNXar71JkMtSsr5uso8TtD52K724GO9lwzWkbut+VM8fE5F
         YEPKajQve7clUFt/EznaGn8mEjyFVBmSEl2mR5p2eAmHHZU2KhVVtUySDlKGoXymcL8v
         rwZQ==
X-Gm-Message-State: AOJu0YxGNapWF7jPXE56Uj5JjRuhT7PFtSfDvtWvTyOoKuBpCX2rAz5F
	Ug/+ZRfRjYBnX6ncHJGv8rVW7rIRYsOaD4/OCWZSjLLUgzGr0a0g1l+L1WtImoceGI9ipema3iC
	SDcPD9Q4=
X-Gm-Gg: AeBDieutRH3H/7gkvn0lkWd4Xu3A/wlN2/kWAK12gS7GU+U94fGlfs60LPBAeDBfnoM
	Scis6kYSd+YzTguOMOaJl4hzq/fkTb5ji3mmIjh3gBB/KkeXfF7tQFpTiIlfRASj1MEECq5vo1j
	GZG4oPMUY2qpNsMe4mi65hsDYkZOEfxXFaRP+JJo3UhXBU9U8e/MPOS61tjplU4uDakv6/UQ4rj
	3XMXdYX5uI9oJYsnoyOvf888OiuximODaSFRjBSoO2KgYKpuCqlqDgYMfo3sd2q0d05Iop19mY3
	cg6mnjduFlmkzxGj7LmqL9gKNL4bdtdwPC++FF2cC4VFjuNinbIeIADUAQL9ozQx+SaI1fZAenT
	l1tj5yoX43J5h0JwYHPr8eaf3GMkunWNu/3DknIEk1gsjNuHiZmnwX/Jqmcju4INBPAfQDuQr38
	iiJJr/
X-Received: by 2002:a17:90b:38c5:b0:35c:b02:b5c1 with SMTP id 98e67ed59e1d1-35de6840775mr22070698a91.2.1775689572695;
        Wed, 08 Apr 2026 16:06:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34fbda3asm259742a91.14.2026.04.08.16.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:06:12 -0700 (PDT)
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
Subject: [net-next v10 00/10] Add TSO map-once DMA helpers and bnxt SW USO support
Date: Wed,  8 Apr 2026 16:05:49 -0700
Message-ID: <20260408230607.2019402-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276731-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: BD6C03C4A27
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

This v10 contains some cosmetic changes (wrapping long lines), moves the test
to the correct directory, and attempts to fix the slot availability check
added in the v9.

I re-ran the python test and the test passed on my bnxt system. I also ran
this on a production system.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20260316194419.GH61385@unreal/
[2]: https://lore.kernel.org/netdev/ab1f764b-de03-48f5-a781-356495257d25@redhat.com/

v10:
  - Patch 1: Wrapped a few long lines. No functional changes.
  - Patch 4: Wrapper a few long lines. No functional changes.
  - Patch 7: Fix the slot check added in v9 to use netif_txq_maybe_stop and an inline
             helper function.
  - Patch 8: Wrap tx_inline_cons in WRITE_ONCE to pair with READ_ONCE in
             bnxt_inline_avail.
  - Patch 10: Moved test from drivers/net/ to drivers/net/hw/ since it
              requires real hardware.

v9: https://lore.kernel.org/netdev/20260407220313.3990909-1-joe@dama.to/
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 183 +++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  32 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  19 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 240 ++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |  46 +++
 include/linux/skbuff.h                        |  11 +
 include/net/tso.h                             | 100 +++++++
 net/core/tso.c                                | 269 ++++++++++++++++++
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/uso.py | 103 +++++++
 11 files changed, 967 insertions(+), 39 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
 create mode 100755 tools/testing/selftests/drivers/net/hw/uso.py


base-commit: 2ce8a41113eda1adddc1e6dc43cf89383ec6dc22
-- 
2.52.0


