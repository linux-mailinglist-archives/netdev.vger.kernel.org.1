Return-Path: <netdev+bounces-269158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFF2M3X5umlwdwIAu9opvQ
	(envelope-from <netdev+bounces-269158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:13:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF4F2C1DDC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40A0B301225B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAF93F0741;
	Wed, 18 Mar 2026 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="YWOC/CGg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A791836AB77
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861219; cv=none; b=IIoz2g8df6NjUMCo1pvH7RV/vKZB/ITPFivsgbY4Ybr22aF/7kcXaOfY3dBX92OG4SG7Kz54w8fZZx27bPatjlLmgNQTsqEgwJ9jS1XkgdgUM3cz4MC5/l6db1V5r8Z4cC3lrSBn6LtDCLTL8J1oIZHN4q3dKSdivtZOUl0fQkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861219; c=relaxed/simple;
	bh=zq6SIIe6VBNnq2RLu2Ekgp/vfo9WjPGja2rAagsa9+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LbcU7xPhv5IeFCeBCSgrIOY+HH6iz46HLmeoCDvmbvY8BXIVGJ82V9Jgxax4jZz7ITMBrHvVqbMDOfWU5wR2hkCAwyNzorDcP+C6n2xk7U1ijPBIIrFdLRt2SuOa5ORHwXdf1O9MSh6oqVNYYMjDJ73+eiL4cknELRgPLHsMDH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=YWOC/CGg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b05fd1d147so704645ad.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773861214; x=1774466014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OLaI6cDBCSLOI+7sce9oAExFHAqYivA42p2ESlxNWPY=;
        b=YWOC/CGgIA8ZH8k5Dd15WlvrUcQ2evS4iMWQcOqXW6+JMhmtJKqZpPSVIx5ek1tprq
         MYIAeISicgLtairgLecCXvoM8vEuk5QVy7cte0pQoCzIKZfxs7TfS//LkTs/CH6uQtvl
         DV9JSR0Md0XBU0rRDBGfe0iSit7VgSvTK12x2PYFyrvKWy19GqYzteUG0X6ni3FRgUXz
         ucLShJ/+uaZCU61sEBmimzQj/WdfoOEtmYjHUQz5U+Tk9PydXL2d31sh19Bc1DokDwz8
         Y1P47ScoysHymYgef9+OPW/+irri3Pl10ReotQ2/r9FDxXaibYgmtqlZBUYmyQEyh20G
         S8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861214; x=1774466014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLaI6cDBCSLOI+7sce9oAExFHAqYivA42p2ESlxNWPY=;
        b=ARxPtLgD3OnPfdQFHeQ2cJ2Ss4o4BeAaH9QQBvOxGAj4RDG91OSAc614HoxoiXv2oA
         7e+W0d02dKUFkz4ROaTDTMDNsiY7JGHm6nH7oZavkmDx8ccCc+ttBufHj2a6oAp5IVdB
         TOkgQYiSQarzsVtkDlbef1uV4ghTuRypFKg2CuBHDnqNXK5IjTwSY+l5h50hao2XSPv7
         SvK0+Tj4UpA07Kax0HDqmwWzOcdGKxL6BtpECEcpCPbogxVZv6W2JNHaNMoTjZlTcIYA
         nr9q47E5ISAuGHDecvDYSzerPwT0pqzkYhNJcDWHfRNAluohNrtjDEqNu80219R8/Y7D
         FHDA==
X-Gm-Message-State: AOJu0Ywu/OlF7O5stiMgd4Dj/2o+RCtseEEj0gxVN6j8fiFITtA0e7P1
	IFXb2eMfm3h3V+/TRD0VVqxqoZYzHAa2GI8YRnzy65fUy4cdJVv0PjKpip59KLwgm6jJIaMACNO
	dZfGRj8Y=
X-Gm-Gg: ATEYQzx1nKFaAZ/2V7Bm1NBnjbED7qnIddfeWB4gQ4rIIDJd87BTb9DKffnzC9E5/Kf
	sQ+G6zBBbrZkpwmvubuFLcrUOwKjdZikrOJZgCwyjw/F2X87vNFRCsCk9xy6flSvHexLVRHUZ2G
	fBfpNsRRu+fCuI7je9KtqVK3Q7HOdycnTh9mihWYgogOJP5IbYeINwC1D3aK3nf/Gm5YQkSLsPw
	hYJzmWZnI3cCrGf0lyYuIIVwG5Wao8y00TC+pfwICjblly2UmATTWzRGyy8OvpkI46ErjsHdqPX
	bpZ0GeGm2Msdna6LCKbCPXU/BkJ9ION1V/QiU6UjkA9qO3A18hWxV4WSGoXUFOIamRFQrmh76Zn
	VrxKME4uSJeG9+8djlFv4yzx3a0YRY398oDBlwmL58ZHOpGQhNRJw71PmJUT3OuQfYxbyA1ZCX1
	sXY0A=
X-Received: by 2002:a17:903:b85:b0:2b0:5661:e10f with SMTP id d9443c01a7336-2b06e43f61dmr39625155ad.53.1773861214465;
        Wed, 18 Mar 2026 12:13:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e454a8fsm33325395ad.37.2026.03.18.12.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:13:34 -0700 (PDT)
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
Subject: [net-next v3 00/12] Add TSO map-once DMA helpers and bnxt SW USO support
Date: Wed, 18 Mar 2026 12:13:05 -0700
Message-ID: <20260318191325.1819881-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269158-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6DF4F2C1DDC
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

I ran the added uso.py test on both netdevsim and a real bnxt and the test
passed. I've also let this run in a production environment for ~24 hours.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20260316194419.GH61385@unreal/

v3:
  - Converted from RFC to an actul submission.
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
 net/core/tso.c                                | 274 ++++++++++++++++++
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/uso.py    |  87 ++++++
 12 files changed, 1005 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
 create mode 100755 tools/testing/selftests/drivers/net/uso.py


base-commit: 8737d7194d6d5947c3d7d8813895b44a25b84477
-- 
2.52.0


