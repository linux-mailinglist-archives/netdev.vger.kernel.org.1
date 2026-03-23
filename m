Return-Path: <netdev+bounces-270666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD91F+GRwWnFTwQAu9opvQ
	(envelope-from <netdev+bounces-270666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:17:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B45C12FC0FE
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 638833176A93
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E26E2F5A06;
	Mon, 23 Mar 2026 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="wfabozJx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F42F39AB
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291144; cv=none; b=nSK+EPwss6knDLpU2o6dMf7aOhcubnsDupcTG66emSG5iHLJatn6t2riiCzBfYCqBi2SCjJR/hrxXIWA4M5MyUgxrnGOU5DGE3Qs2YF9dCeZ106zv5RI7tyLV2mSWqnsDFms/OW3fKE/1ZTZynxo4btxE8zr6y7seDjJq0Wa6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291144; c=relaxed/simple;
	bh=qR7Uft60JMgsysDf281TbxSdYhPMKO0eqAP9iezQfT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7Caa3chZD6bch225SAtN+TmP0LGfbi4SWExatC7avHfWW1EGhXtpUL1sGrKp4ZK4jyLWEg1gzVbewb1uAFWv0TY8XW4NwpyuLqtS+3uUMggixqPqrZlzuJ0TL1uVaPiUZ53cOUfEC1rteHWf+LLnUnK+35zA3V9x51HR/yY3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=wfabozJx; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35b90d6fe14so3132327a91.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774291139; x=1774895939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+oJvBzI5sxf9DCIXv0lOshwDkEZYx6mQn08TRGTj5M=;
        b=wfabozJxwbTjrbTDl3c2fUOwKO/rR3AyerYfZhx+y/+uMuc3g1FX9hbzZM2P0lEw4Q
         vzVQFkTgxuMm3lwTHK3Vj9XF+U3o/U0xJM0dEwmPBYd8yIfEdoR4TPoDE/+XOBB+kRau
         DSoYNXfaq36gKT+oCp8qy49yrRzqhEssadi6DvKKCcQMjAfScmNjSbq53Zxq85VUogVe
         Yr7IhB0b9G8Y2Il+Ak2bS4U5MNrTe/LUbwLXzw5KdUa62YYH7OGYxpAiQzegOc4MwStl
         ND6qPPz8tLAw5HhxqzhlYsseS+rGYHASKt7c1T5sKRqADXQzpTEuHVuPuMCYz0kliUbd
         uJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291139; x=1774895939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+oJvBzI5sxf9DCIXv0lOshwDkEZYx6mQn08TRGTj5M=;
        b=MB1/q9l1fCpdscwtSb5qhJIAAmzh00bpmqMf7JTuFgGuINxDNLZcV+4s/KE4g6v8lG
         l6EKqjUjpiaoPIbYdlW5BmsXyemLoFfABt39QgTvqj4EzxVhLKDzoHcQ7oslSDpVY3O6
         gOO9GuLwQXWmLFkW7pMLrLgrT88zrC4AALj6PQAkJzhyU0TtJZJG6gkxWb6+9zgBqBTM
         vRDOnwY2u4cX2BrTHvwmttt5zjeYMXjVHjf5J1zztwYT4H1UuIdoPgfWUIUhEjdK7Ga2
         YOz9HhJUH4OdYn5AYMK3jMXiXk9fPH6Qz2twkuLvYDWHHjFuWIdQ0w04D25ZiXDsrCOh
         WjQw==
X-Gm-Message-State: AOJu0Yy1iNJk1Pgob0XcbmIJNF7Apn7wudRdMFNIbLdJC39OgkLErEOf
	3OULEm2rcSIAC6uMRnIoKNg20Q/Huez25COfrj0PDtVJsoQ7+UDyAjwp4fqYALmqCM82gl/Okel
	mwVVIKi8=
X-Gm-Gg: ATEYQzyRKkXNC4/TYZkYtTHz0NdoQjJEEUq6+IydIdzNx2OBfTJNz3VZWTwL/vIm2/m
	izYQpxo5vNmRalnGF46Wt/EqdC+EZ/efkSVydsATWW8gG7qWdpWZwV97QtYycbIoltviIbmGC9W
	0f4watRzVriaSRwIg1rLEajl2T1US1Gdp9qIpeyHM0Jn2v0ddahw90advPmRbcvsyqwxr6gqihn
	bw1YFW+4qNRnvS5zn+4pR+kG78CmeToUMjgYkwQ1WXiIbDfFLtWpGnPi307PFmygPF2K53zjnKd
	RROsCdTZKBnC3e4p193kmPKeoRC5c9La/voBCIPiNTwu8M8kOUlQvND4W8K/gyyJeSAvLFcOcNW
	QRz/i2JE6iVMS3fwc5XB9eeL6wKgecXk1MyQoDPB0oVK0xydkqxwv2cYJFk2S84wV9KS+GQQKVb
	zEJyE=
X-Received: by 2002:a17:90b:2886:b0:35b:ea35:c3ce with SMTP id 98e67ed59e1d1-35bea35c476mr4959475a91.27.1774291139155;
        Mon, 23 Mar 2026 11:38:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c01836cbasm19077a91.11.2026.03.23.11.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:38:58 -0700 (PDT)
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
Subject: [net-next v5 00/12] Add TSO map-once DMA helpers and bnxt SW USO support
Date: Mon, 23 Mar 2026 11:38:25 -0700
Message-ID: <20260323183844.3146982-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-270666-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:mid,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B45C12FC0FE
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

The v4 made minor updates to the python test (see below), so I re-ran the test
with both netdevsim and real bnxt hardware and the test passed.

This v5 is cosmetic only to make the kernel test robot happy.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20260316194419.GH61385@unreal/

v5:
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


base-commit: fb78a629b4f0eb399b413f6c093a3da177b3a4eb
-- 
2.52.0


