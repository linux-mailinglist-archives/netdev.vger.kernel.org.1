Return-Path: <netdev+bounces-274863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFgDBDMtz2k3tgYAu9opvQ
	(envelope-from <netdev+bounces-274863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 05:00:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D9A3908A3
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 05:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E83F9304117E
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 02:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03A7352FA5;
	Fri,  3 Apr 2026 02:59:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6695831328B;
	Fri,  3 Apr 2026 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775185174; cv=none; b=b+ia/OcNq5rZ/RlOTTzOkLfrmj+h+VEPpysgz7PX2h7v2Q/t0UOBMNeq5QI9qURSLYMOlvS+Nmj9okmf3N9PBNjxQWQm/6KcHm9FFi5QQG27XSmW4LjKqlZnIxmpUuLxTxDyI+r19Goe5FXvDOYovIy7/kD0vkbo2ll96MVFKsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775185174; c=relaxed/simple;
	bh=b+H2sM+i75uJgaGJMXA8Z0Spx2z0KIJd0E2RXQ/Q+3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FsP1FeVV5uZ9YVP+T1q1dScoKYXCBvqXQJql1wzaexbTx4DwAwIsBaeTg7E6FjqXz90qEABQ4lTYCxLlrBOLzszazlCTi47ihapm5ew3k0qcnDAaL9WEy/ZPZU1rX4ASw9/+kyRD3WFOmphfxHtoEo0kAalBUiPVYrSukYGzu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz19t1775185085tadd8bbfe
X-QQ-Originating-IP: GwQ6LYzB69ikvOoEWS1coK+4uQlnN39GcgI58ugC/Pc=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 03 Apr 2026 10:58:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16356315790693021572
EX-QQ-RecipientCnt: 11
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v2 0/4] net: rnpgbe: Add TX/RX and link status support
Date: Fri,  3 Apr 2026 10:57:09 +0800
Message-Id: <20260403025713.527841-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NvGGTAUhB2iW0uX0VfEP8oLLn0BpcT5oatqdXLF9f/PU1o+i257itWoQ
	Z6KEk8m7dpHK0UDm6MgT/l3Umi5p04vSXab+1DvFjOkX+KHKHv83fMp2u55RgZ0Pec5/1U+
	fGnrCN2Qb+x5UHmmzIZsEtW5PRldZaJmbVrAaV0cvYh1+yP+ApF+8RXlkJdNWsE1A7Af2s4
	RmreAunSugH3moSPD50UnvfI2KRzaV1yDflX6VAf7xFZWbruWfuH08t+EBQiIe6lSF15Zxo
	fVJUHGdLMZyPxQIu6/liwbysy4fKAqjlsZXQUyHNIHu44uzy9tzraE5zIRLEBnMG5S7d7qz
	toodBp3+sQmc32u9TNUly+RXOKMMKkh8Zss9Z8R9kC8xmsKqNJ+zCbgL2nQTy1sBThFY9iL
	YhjPLtXA5XQwo12JGTgpDqvg1OnCUul360jkTcPCf2v/0ypvhyVmXlX2BULK4UJ9eifx/4O
	tici9UhUDO6X9K9lq7tW95XeNmq5j46ZvNhxlQ4y9tiEBTt29OfOfcqPl4iYPaQtVFWFtQ7
	Y8+RGT3jGGddOPv71j9dGsJQ/MU0TuD6wJqLXtm3Z8hsjiWjLdyUoyo09mwR+ykya9+FycH
	xfA7uKBfsva38Zv46HFwsPYLl4qS3sDDgdgyY4sYZ/YamRvGhjFmUXbNKO4+VJ0/0ojafq9
	Ssq1UW38fvvoTShed7LYmvIh0aEr9D0nyIKd5ll+tfRg8JsvO6+ntMk1YUEv4zY5aPeeUWG
	D9v/8y+f26bvb/nyqt9DYRItXuM3wWiDjSx4XYOvltdoBne5ayJxBkTKmUN8uD0pIdt1y2V
	TujSIWu2jgQOKsvMaL1Fm6Ncz43bOsDToEnjYNL+VIngZpSOqeF063SCPDSMZD4tnuzAVwK
	7Cf40KY4FgHB1Gt1Zf/yZTOl5mFK1qgUYCj1r3SHBs6jYR+HKAU6RPzYXsWEqGtOgqzvnEM
	VOBN/wlltyPzom+jgQsToBLuXjoqCHFjmjFCU+FDHwcUk9JXxoVOMmMl51tU1j7tfwGg7ms
	PcZAmC8ZioIgCXr+oJ/l1CvMoq2IE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274863-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mucse.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.919];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89D9A3908A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi maintainers,

This patch series adds the packet transmission, reception, and link status
management features to the RNPGBE driver, building upon the previously
introduced mailbox communication and basic driver infrastructure.

The series introduces:
- Msix/msi interrupt handling with NAPI support
- TX path with scatter-gather DMA and completion handling
- RX path with page pool buffer management
- Link status monitoring and carrier management

These changes enable the RNPGBE driver to support basic tx/rx network operations.

Changelog:
v1 -> v2:
[patch 1/4]:
1. Format exceeds 80 columns.
2. Move napi_complete_done from patch3 to patch1. (AI review)
3. Fix off-by-one issue in rnpgbe_request_irq. (AI review)
4. Update kdoc commit for rnpgbe_open. (AI review)
5. Remove legacy-irq mode support. (Sashiko)
6. Move register_mbx_irq after register_netdev. (Sashiko)

[patch 2/4]:
1. Format exceeds 80 columns.
2. Call rnpgbe_clean_tx_irq after rnpgbe_napi_disable_all. (AI review)
3. Fix return in rnpgbe_clean_tx_irq. (Sashiko)
4. Consider non-linear SKBs in tx_map. (Sashiko)

[patch 3/4]:
1. Fix error recycle page in rnpgbe_clean_rx_irq (AI review).
2. Fix truesize in rnpgbe_add_rx_frag and rnpgbe_build_skb. (Sashiko)
3. Consider MAX_SKB_FRAGS in rnpgbe_is_non_eop. (Sashiko)
4. Remove redundant dma_sync_single_range_for_device in
   rnpgbe_alloc_rx_buffers. (Sashiko)
5. Fix miss u64_stats_init in rnpgbe_alloc_q_vector. (Sashiko)

[patch 4/4]:
1. Fix 'warning for is_report not described'
   in mucse_mbx_link_report. (kernel test robot)
2. Fix 'warning for hw not described' in
   mucse_mbx_fw_req_handler. (kernel test robot)
3. Fix 'prototype warning for rnpgbe_watchdog_subtask'
   in rnpgbe_watchdog_subtask. (kernel test robot)
4. Format exceeds 80 columns.
5. Remove mucse->serv_wq, just use system_wq. (Sashiko)
6. Remove bitfields in 'struct st_status', use mask. (Sashiko) 

links:
v1: https://lore.kernel.org/netdev/20260325091204.94015-1-dong100@mucse.com/

Dong Yibo (4):
  net: rnpgbe: Add interrupt handling
  net: rnpgbe: Add basic TX packet transmission support
  net: rnpgbe: Add RX packet reception support
  net: rnpgbe: Add link status handling support

 drivers/net/ethernet/mucse/Kconfig            |    1 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |    3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  184 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   39 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   18 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 1929 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   90 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   93 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |   20 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |    1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  166 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   38 +
 12 files changed, 2571 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

-- 
2.25.1


