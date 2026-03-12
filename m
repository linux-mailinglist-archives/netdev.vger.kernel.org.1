Return-Path: <netdev+bounces-267217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH7THqA/s2l6TgAAu9opvQ
	(envelope-from <netdev+bounces-267217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:35:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E7527AF08
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 864C73146618
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9943AB27D;
	Thu, 12 Mar 2026 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="OYg1Y+cK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63438D687
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354908; cv=none; b=MBXT45PsHxEiYSTck6kBcX4C38jFpN3hstgiGpiN09u58R/b6xjP0wqpGX0ryjye9YNfhemG4mDCe26lAsYDrdjSqo4NE4/z/4nWQGGO93Yg2GivLQrTTGo822GZST8rTcUOEvEsu0p+giGJ/1z6+G2Z7Vph2rpqyzln5mWldjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354908; c=relaxed/simple;
	bh=JdxBtLe1skEr+lkBm4BLYYO+cnif1zFCiJ304cr7LCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+6bfaMmEtEd5Mjngs7j3IIdSa5CtDZ/EtHfHG9ESylQ9dPgJICXBfNP37kKMquFejpC7miuxerj/vAb9H7YZGg/3Qiqpgyuw3s6wsXOWd9wSvhUH77B12s5QutEsHOD04fPtNP9c5cM79IbBAAP/CES6ju/COBw2MOQcQXm5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=OYg1Y+cK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829759ca646so943538b3a.2
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773354907; x=1773959707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D74ccSKcWRfdVq6Tl/hNyC4BUkGRUL5LAr4+bhXTzSg=;
        b=OYg1Y+cKgo5fmRlP2IzzlG4T+wz3XD6S9RzTzadY0YiwBJzQb4YEw7Bl5+VE0izkdi
         1EzENETwSmaQQb7OLJQ2ut75Pcq69HTmcx+jC/UDmSHO7lTAHIMNQFx+hygpT0PvcYAp
         47wR5fufGPtPtSF5Pu5JsAuO5rG/PuDoktVvelylVOZ8IdFe34Wsq0Nspsdv4VIRkoom
         YR+7l0Su6Kzj0TE3VhoQ80ZqE5P5sjJwxjJ/6lGRYAX3c0eu4T3Nk/itluoMhtqUcjE9
         tB6EziRA5IOmYq4MBT38QTNBK36t/YgK04+fGvjECHx80Bu8nbscULg0ckC91pglDsdX
         rE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354907; x=1773959707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D74ccSKcWRfdVq6Tl/hNyC4BUkGRUL5LAr4+bhXTzSg=;
        b=rBGNNxmEXRC84fR56QnDn7DlHxupQewGv6yhK9E/n7dN4d8hoNYhahGGFi4WZP8G6G
         +lnoC48BRU0+jhYBRpU0maiGCTe++E4aURyzEq4EaQwwdWKU0Nd4oPOgT/0tGQwjP4cy
         +guMnKAcAbbKWuAj1ek4HXhYZqb7TINEWv4VvzRwhdCvknIaRMZ0UNZ6axwbGCCkKdUT
         HhP+rtzZ4yIr3fVjaz6zruZzBiMKqo2sSei1zTYF0IVkqVVPqERnseEK9I8+NyG4UzW9
         wlB21ZzPynAIsr2lN0Bs6cjf1uZmLjVBpIYLDfHbCZy6y4AU31LicB0vbL9qJN0uZ8YU
         7rqg==
X-Gm-Message-State: AOJu0Yw5k+RgAVPMOUgj4Kl8qlVATpw+eg9lemohCpUyhNtaXq/FvfWm
	2M76yrwof9VjCoDL/uGCzQVH/83gO8l/2C7l69Ou2nBRXrKZkm9ThR9SAEdRxMvymwHnk5IdkOu
	FRhIX
X-Gm-Gg: ATEYQzzNac224jm4nSdaswX0kqPKgCgvMBznV7R1nbSEAG+3uuy4a9vmTKnDkxBAk69
	1tcOU3pgBFuKM6KN/CsJakYOOWFgWhbQqmP/3i1w8F7tD5ZwlKh/UmOcGBP47LrNZhlQvyT+yH3
	GoQzXH2sqZ4l0CR0UrqqPC5B7JyDHgmVYSeEX/JkbHhDOjC812EZyPl5MO52WK+Qk1Ezn+jlCBS
	4M0c4pUH1e6fSnESZwCGAk2eMW13bOFwVqMaQEW7LTIitrscinOEsBtDh/ISGBdOOL4sGtvfuAN
	pK92r8BOO85cDp7UEKiRCvyzjNq4H7zl5O865ikIyvqRp1vQL/auM9R045uxEl06Tzv8ItzFBgJ
	gUOpIVbjTx/ZacQTO9rGToOPF4VzityynbxrhK9zAVjQeMlMyufLCIEfBBF2Xd2OLc8z1gs76f/
	0p40I=
X-Received: by 2002:a05:6a00:f92:b0:829:8015:1637 with SMTP id d2e1a72fcca58-82a196d2ee6mr753591b3a.12.1773354906561;
        Thu, 12 Mar 2026 15:35:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072419efsm4219975b3a.11.2026.03.12.15.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:35:06 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next v2 00/12] Add TSO map-once DMA helpers and bnxt SW USO support
Date: Thu, 12 Mar 2026 15:34:37 -0700
Message-ID: <20260312223457.1999489-1-joe@dama.to>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267217-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D2E7527AF08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Greetings:

This series extends net/tso to add a data structure and some helpers allowing
drivers to DMA map headers and packet payloads a single time. The helpers can
then be used to reference slices of shared mapping for each segment. This
helps to avoid the cost of repeated DMA mappings, especially on systems which
use an IOMMU. N per-packet DMA maps are replaced with a single map for the
entire GSO skb.

The added helpers are then used in bnxt to add support for software UDP
Segmentation Offloading (SW USO) for older bnxt devices which do not have
support for USO in hardware. Since the helpers are generic, other drivers
can be extended similarly.

Testing on a production UDP workload shows a ~4x reduction in DMA mapping
calls at the same wire packet rate.

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

RFCv2:
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 177 +++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  29 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  19 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 230 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |  31 +++
 drivers/net/netdevsim/netdev.c                | 100 +++++++-
 include/net/tso.h                             |  42 ++++
 net/core/tso.c                                | 165 +++++++++++++
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/uso.py    |  87 +++++++
 11 files changed, 843 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
 create mode 100755 tools/testing/selftests/drivers/net/uso.py


base-commit: 8e7adcf81564a3fe886a6270eea7558f063e5538
-- 
2.52.0


