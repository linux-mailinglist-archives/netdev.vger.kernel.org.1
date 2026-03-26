Return-Path: <netdev+bounces-272282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMlZEdvGxWmgBgUAu9opvQ
	(envelope-from <netdev+bounces-272282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:52:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A2133D415
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66C91301FB75
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5052C2C0270;
	Thu, 26 Mar 2026 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="wugqppt2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D2423AE87
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774569172; cv=none; b=rUbs5ancvBb4ZpzLmPVwKFZ6Zs9LMMsUuPZB81cGRIIB58EIiYNjOKgRjoAxvyfHgJoDgLWvAltYv3LYryK5J2yQPW23jmUJq0vMB0TH9g4DJ8yNV/fpw6ocDiufMI+q8i06+0rVcKJyWY6E3D+TMVe7V4nBrasl1J4WDy0PWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774569172; c=relaxed/simple;
	bh=lYkCD1KBNDm3zenHRSOw9fLyqmE6hq1/23Gd7WXvsWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JEwUfRE3rDfqFI2PmI7y42jqJd1qQI8cRpUZoZjpELR+cSpdchzlb+BDUBvn0ciyg7EE7WDiVcYY+QK4V0HcCIV3huYl/oodrbmIi8F+Nx8+TbB0B3gR4SVX2b1mw1KfEk3czqRpqYy9T0+kEfw5d1SDj7mDK1NOyyZCKq8QlTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=wugqppt2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35c2fe0d90fso83490a91.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774569170; x=1775173970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fwOYJ8GwJdYom7e1ePKF2No9433JB7kA7TpHYNGBM4A=;
        b=wugqppt27sBlO18FAZmY4vogo6y4N/ml6jaBOg9B00wt9Ocwzmm8pG/J7bbNJ9ei1X
         VnTHz4nqWa2WqfjQyidFAEMn6pNV/lMzPJuwgGPU9N3zo+BM1RZVk2SVCxOOczKYYN+t
         VUNezc/Ifvu9ObfbUhrT8QhwoXCTxajo6e8CJcq/f1IYtzO2nitCr3O4ibZsKaME7xSF
         NJteEDIMJ0ue2R4BCXoOKiah5gj2ZRgE9A+BWXzQ217eNiu7sB90xrpmxCr7CTZ3WW+t
         yqL8AfxE0iTD/RXC888QC3m4yTxZ++lpgba2w8ZlJSg5EmbS14UV9tHvcjeat4AaSkVC
         iurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774569170; x=1775173970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwOYJ8GwJdYom7e1ePKF2No9433JB7kA7TpHYNGBM4A=;
        b=BUD5lIfFaLlGGcN2eS9fFXPhE9qP5Oh8g15HHUC4KfroUQ374Op1gBe+ndhbm6AyGb
         A+B7VfhYs/I/ia4bgWYDiPoqLNcpjzKmqF1fan9BPOcUlNsJGgdvdJWs3uce4TJOIZi/
         KRUWVo9QMt79BK3zyVA9NDuNphEsHXyrUrAtuz8Zyal3oa2Q3J2GbkC8ivzSDqRJwby/
         Wdcq+svV6O4xrbdabN//nV5RX0fdNERkYB73dfYVmWZSRPPC7LoyDx3I0g7b0411aFf/
         j5jl2Wj+VhXHST3GVNMXDNwMimlyfxsEF+hatr3An9Tfqy4xDf/eVi+NbPLwPTjDQxM1
         EJuQ==
X-Gm-Message-State: AOJu0Yw7sRm9Pne4w+IkS7nUS9XSh+YG866fmDH1qv0+FevT7rPWeVg5
	n9kMdT0SOnAf66hrXY15CsoufOmsXV5FlHeVU/2PlnicZRjfhuD9M2BEYfd682Vr10O2sAXqPaA
	1vgZ9
X-Gm-Gg: ATEYQzyYXRGqjJzrMxKNj2+8indyv4PscShTqii4syMTIW0utY0S/U3EFh5ahxZpb3x
	UB0f0ce/3EXqwCLIUVBOGWMXuwCm7+D/1GUhjJun8mGmfr8Yz+WEIX6nBLx00I24o3iS5+Cfl62
	65JK/0y1V0kC8OrZCkrRFhAyvV6a11bH0AcmktuAt46AhHw2PyuReHo6AUNy5dtPSHUHsFQZsoh
	10JR1LWqSk9SqXUrcDK7eYy56FI/qPHVsO8zgAfOI7ZFomNA3FzGOc9JNmRmwYY5UlLA7Qj6dZM
	8GZ4VW8gWUjZVWDofRWfxzjvzR9DdJW+aJjzl/AJbhgjUxfkjVfAIYhz6tXU1BSzvBfAM0R9Syv
	aXUYo/2hbqXpLtW0I1HbJKV8rqpvWm+y6Uqd9fUqnoYgYX7zqlYxl2FLqeW1lnmuSSF3BEmbdTy
	WTv70K
X-Received: by 2002:a17:90b:3f8c:b0:354:a332:1a61 with SMTP id 98e67ed59e1d1-35c2ff4ece6mr414593a91.5.1774569170018;
        Thu, 26 Mar 2026 16:52:50 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a81744sm2866218a91.5.2026.03.26.16.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:52:49 -0700 (PDT)
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
Subject: [net-next v6 00/12] Add TSO map-once DMA helpers and bnxt SW USO support
Date: Thu, 26 Mar 2026 16:52:19 -0700
Message-ID: <20260326235238.2940471-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272282-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 49A2133D415
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

I've extended netdevsim to have support for SW USO, but I used
tso_build_hdr/tso_build_data in netdevsim because I couldn't figure out if
there was a way to test the DMA helpers added by this series. If anyone has
suggestions, let me know. I think to test the DMA helpers you probably need
to use real hardware.

The v6 includes a minor change in the USO implementation, as requested by
Paolo [2], so I've re-run the test with both netdevsim and real bnxt hardware
and the test passed. I also ran the kernel on a production machine with real
traffic.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20260316194419.GH61385@unreal/
[2]: https://lore.kernel.org/netdev/ab1f764b-de03-48f5-a781-356495257d25@redhat.com/

v6:
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


Joe Damato (12):
  net: tso: Introduce tso_dma_map
  net: tso: Add tso_dma_map helpers
  net: bnxt: Export bnxt_xmit_get_cfa_action
  net: bnxt: Add a helper for tx_bd_ext
  net: bnxt: Use dma_unmap_len for TX completion unmapping
  net: bnxt: Add TX inline buffer infrastructure
  net: bnxt: Add boilerplate GSO code
  net: bnxt: Implement software USO
  net: bnxt: Add SW GSO completion and teardown support
  net: bnxt: Dispatch to SW USO
  net: netdevsim: Add support for SW USO
  selftests: drv-net: Add USO test

 drivers/net/ethernet/broadcom/bnxt/Makefile   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 190 +++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  33 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  19 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 240 +++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |  31 ++
 drivers/net/netdevsim/netdev.c                | 100 ++++++-
 include/linux/skbuff.h                        |  11 +
 include/net/tso.h                             |  61 ++++
 net/core/tso.c                                | 273 ++++++++++++++++++
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/uso.py    |  96 ++++++
 12 files changed, 1017 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
 create mode 100755 tools/testing/selftests/drivers/net/uso.py


base-commit: 45b2b84ac6fde39c427018d6cdf7d44258938faa
-- 
2.52.0


