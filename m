Return-Path: <netdev+bounces-269932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOyFIepcvWl09QIAu9opvQ
	(envelope-from <netdev+bounces-269932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:42:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 037522DBF4B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7A613021D0C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671133C4554;
	Fri, 20 Mar 2026 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="NOwRaz+F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBF53C3437
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017713; cv=none; b=m7VvHMCBGvd9w7rpBVgvStf3uAVoaI2x7kUq8mxmrgb8mVHAC+X4x94db5rj5bUYa5CZs+E/PDTFzMyURs+eUgdNWwfL5dTddjFwbFO0ZTSDeqKv4i3Yt/dPWzsJFpL289qBHRFoGfITXdMStoLXx2vf2Qi+6VFybIkHlNjTsuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017713; c=relaxed/simple;
	bh=N9KuTauRl5qNVr4yvJZ1TiXBDN4Jgm2DFykOJ5aGoVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J55g3UbaEvuj0KxqosyWVkSPvQXiMKbrkhjup9h+lSsbNVSHvW3j0RZvQU/EDf1ZmLrLGxb/SteNd6U3jAZaq8uL3dUnx9lXyNiKtowENvbRIYuJm9qQWo43Mpp+xTkGuEAggRA1ie1zbG9x3iST7zClkpI6ACqt238pyCJ5Ryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=NOwRaz+F; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2adff872068so3236455ad.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774017711; x=1774622511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RkY/6UUkz6LekGqRy3yelUEgJVbUVkXO2hFvF544f0c=;
        b=NOwRaz+FiK8JHscvFfCCL2qMaTExvCEVYqXe7zgJcjriTc7q1p+BEA+F1XC3vit1Y4
         Ti3/kJNb9bZu0b3KRB2aWgWbC1+6hlV86pRCRk8jfABZpY/1OCmkT+c8cwjq8dDKuWm7
         RT1VSal1i0DyvAZllNHaSb1KuvMHq11afoCR0Q1frT/+ZtcXM1fL6G/mUEsQuKR4FvCu
         9jSTqFyZUtN88gixNjg5oSVa+zFVzGPuM4XPeVmbPZ/tCCUM9QsI103zJQb5/NqMHhaf
         NV87BJhfyc5svUUcIT2Dc11+iArD4t5rBZspjA53qpYPFVH1l+cxwH6HBKWgG2MgCgpt
         lTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774017711; x=1774622511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkY/6UUkz6LekGqRy3yelUEgJVbUVkXO2hFvF544f0c=;
        b=ShlTu3T6TPJVJicM1jnUW+pRNEjNk4nO8/ehdgHD3svgvBiUtD4OCfbyU5mXZ+Qt2f
         HeolaJAeTx0KOIvhaBu5fSRxeiHaG1AuGdDHiqDLTuA4fkzqJEa8vMHsoxyGnQ5daY4Q
         Cz+WveipWSYsYuTMOXP8Nn85t+XYfMvRYVgRC2M1QeV5tHrUVFFLV0uYNC4CIVXHzDtd
         pulnxrjNM/gjvqRiQGEBI0QHGbefaaZu1/KWwmhb3CwjTnALVBTK8aaM/rn6dtNW8qPe
         9ba01rebhX+ugzdwQoAVNRvP3Eu4XTJIwG0tqn9zIc23uUADzX98WxTy1oSGncQe88AB
         l3IQ==
X-Gm-Message-State: AOJu0Yx1SY7hMXPKBV27cKjc5eQXiZ/3vTMhVG8BuKqazu/Mnygh4jLo
	sHrA6DMYY8f1Ud0PaZN9PnoRNwchiy3KhhWNxmUkZRGJglyNZekGw7KxGYPDwuEZHcVentrkgJk
	eWRnoXwI=
X-Gm-Gg: ATEYQzxZa5qj0K3gHndCAeQ2Hpzh+9x95tzJWFYt7jw5s3ElKR0RBMkNM00sX6dqgOm
	FDeMgWFeXQincZ9uI8BlUUqUJTjccPm8LMUrowP8bbyBjiFn7wXfHerPS9OxgIugBT1CWm8k2ti
	Wt4ZCYKIHIpMTI9fiy4uGU6T34fdWxeg0IjCn0sP5nkIy6ICRbPAccs2bWufwucLdhxg3qdgbCs
	YmWyV4Y5/Lb61zmCXGpSd8DY3wQoGuP+ih/zYwFSlWJsQ6cxDTg7YhO/zvmfWQq2woJz4Kk1PSp
	+6B5l6T+kc5FREUB7gXySWXjKZxuheNF9PRKDcTAkWeOdOvo8Z1o/mmwUDvYZ1yXcBjXV3gxIA9
	C1Q24QBoJJUgTxX/vus1zafcvE76CQ73orE6zvKa7aVJAzVy4wN32rVf4PvLWlB8fpDFFVsmJaR
	OvpKg=
X-Received: by 2002:a17:903:94e:b0:2ae:aafa:ec95 with SMTP id d9443c01a7336-2b0826d7dc5mr28671905ad.11.1774017710494;
        Fri, 20 Mar 2026 07:41:50 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083655474sm32919915ad.48.2026.03.20.07.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:41:50 -0700 (PDT)
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
Subject: [net-next v4 00/12] Add TSO map-once DMA helpers and bnxt SW USO support
Date: Fri, 20 Mar 2026 07:41:21 -0700
Message-ID: <20260320144141.260246-1-joe@dama.to>
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
	TAGGED_FROM(0.00)[bounces-269932-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
	NEURAL_HAM(-0.00)[-0.979];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 037522DBF4B
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

Since this v4 made minor updates to the python test (see below and patch 12
changelog), I re-ran the test with both netdevsim and real bnxt hardware and
the test passed.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20260316194419.GH61385@unreal/

v4:
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
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 236 +++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |  31 ++
 drivers/net/netdevsim/netdev.c                | 100 ++++++-
 include/linux/skbuff.h                        |  11 +
 include/net/tso.h                             |  61 ++++
 net/core/tso.c                                | 273 ++++++++++++++++++
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/uso.py    |  96 ++++++
 12 files changed, 1013 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
 create mode 100755 tools/testing/selftests/drivers/net/uso.py


base-commit: 9f4960b94f1a044f76da98a765d6cbd294c22c92
-- 
2.52.0


