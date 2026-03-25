Return-Path: <netdev+bounces-271723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHenEq1BxGlHxwQAu9opvQ
	(envelope-from <netdev+bounces-271723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:12:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BE032BAAE
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB8C2301778E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF90367F5C;
	Wed, 25 Mar 2026 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WVHuBdjd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EDC1D798E
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469511; cv=none; b=C75RdDzp1okvvPYeZ9XInNxejWIlSUnV7fRrGm/cWAFpQo8m8BieL0tuLrjhu6D2nKLqJq8gRIChg4YU1PWqWexoZfd+bYZSfCXNsULHHkF/o3y69+ml5aflolEkNMpI71Xmn8eM2QnmFKdwjUByqwugPufnl6GMW4px1MFcjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469511; c=relaxed/simple;
	bh=W1rk8b1TxvRXUjyaOv5Nn3VlDflyKDjP5xegWKvAqM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nGAPDOhFzl9AhDofNFteKMxOSZyURgjZKeXsHgHfUUk98ngKIHDTDuR5I2sXv/6ewzCtnefXR5isTUMgZOHB7ACQ1wmktQKAy5QkkuvdE0rT42w7S788LxBlg3dhxRwuczQy5vcVS1wUyhU/5UD+drx3puUaWS570jBTIL3JfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WVHuBdjd; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40974bf7781so1073435fac.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1774469509; x=1775074309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yOK0NjVYr78bPbpIye+WMvOgHZn0ILapKUb+9KhRM08=;
        b=WVHuBdjdfVmicGdQJoUmiH7gqWJidWcLezU6B1e9VX8l567K81UK4rnVDj9wBI22yI
         b+AM1D3Ow6xYt54D4V46t5hLsaIO882cpRG3Xqy3gIa/9nHCiT6cSAbO3zeDO4+hoaPx
         8isFrwVBqc8f1AA/JQRiBUyh9aedCw2+0zvo+/jGfcBd4DP145NE8a5amohouelaDUR4
         WSt1Szetgha9HmA0n/te0FB1SzDBCRuPFtxcwafl/1/1r3j5zCmzXG00Np6xice+3t3e
         ZDhqukzWvUSL2KtJf15Q0HZHQXpuUc0Tl+GIvKQOVFQEPLnCJx9gGZ0RT2bpHyQNEfih
         QsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469509; x=1775074309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOK0NjVYr78bPbpIye+WMvOgHZn0ILapKUb+9KhRM08=;
        b=UtaOEsitS+DhMXuf6ZEEParulmDb/Aj+zd1+hLMBEynBjwpYL5VFrWnjESYiXKyuh4
         KJNCTgNRK2mtGZ6w8WSW303LkXHhCqUoBVw88e7g9vCICn5LKzUypz2W9TkXyFUvdgG7
         eUTAWgOP1nUkVJgS8RSMx+qFLCmtAGw9n4ZQo14SUWdkr3R6VHqwV5wzTvwNWTdiDJ38
         Fonu/I405LLMi1tf3gm/sn54saI2YRRywpX3RFN+4aO2UjUyyaxEnzYJBKvBJsCSiU7o
         c3y/Ci0Yo0gOMPYcy/scCNKMiDYZt2CDUFSn3h6EbP8kCem5JhIaPM/QmHjSNxW+4BOs
         iYbg==
X-Gm-Message-State: AOJu0YzlKNA+/N2WJdnmzUBnjax+1pPdhwbF8I59xTZ6lDkWrdc2iW/0
	dytX3ski41yQSqsCsKa1ABBC79LXR9Z6OYBeJUW/GrTpJ7c53yjQ+2gJxDDRXLqMLkAVwRzfTo0
	Y9J3Fp8lPLA==
X-Gm-Gg: ATEYQzy2auHDkhGwp76RQplWvpWFhk6GjBsuzqDPcDoZ7JlbOr5AVzNKjU8jHSc0E3m
	eDx//5LH6PY0Mq/AiDOQYDFjrZLj+gSXGw2iV/qpBRZO1WiTuljtAwrnShPOm4uAAvRK49kPeZi
	FZ4igelQsGnGYU290N5c974TlmRogS4DB5xpSDo9kGXG2ay03mLOyvFANf6ljOuPoL+sofFk75i
	WsNa4vA36MeGWTAQ/Z/F/l4h+SE64WWMEquMxN9tSdYWDXpzt3RNrpg2OXgtitWDvkc10VqI/ge
	U1BB18olHO917o+EYoZ5SvVIlc8vgQjHa5rG/BTvjdas8WFSQ5OHW6bOTJdToRQMSSOmrIqWNvn
	nMbHCPJLPUvm+LnMfp44a/xJe1QBtNQzRnBMymwvT89JAO1TdZaZH25rJOQ7uYuuRKWio5/Hoj3
	oaDHAUZSjrrwyS4bVIS/iB1H0=
X-Received: by 2002:a05:6820:1c8a:b0:67d:e8b6:fb4d with SMTP id 006d021491bc7-67dff4b41c6mr2208620eaf.13.1774469509007;
        Wed, 25 Mar 2026 13:11:49 -0700 (PDT)
Received: from 20HS2G4.aus01.local ([2a09:bac6:bf21:2632::3ce:1a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e0ab274c7sm549764eaf.13.2026.03.25.13.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:11:48 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: netdev@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	davem@davemloft.net,
	joe@dama.to,
	gospo@broadcom.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>
Subject: [PATCH net-next v5 0/6] bnxt_en: Add XDP RSS hash metadata support
Date: Wed, 25 Mar 2026 15:09:46 -0500
Message-ID: <20260325201139.2501937-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271723-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:dkim,cloudflare.com:mid]
X-Rspamd-Queue-Id: E0BE032BAAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds XDP RSS hash metadata extraction support for the bnxt_en
driver and includes selftests to validate the functionality. I was able
to test this on a BCM57414 NIC.

Patches 1-4 implement the driver support:
  - Patch 1 adds bnxt_xdp_buff to wrap xdp_buff with
    pointers to the hardware RX completion descriptors and the
    completion type. This is similar to other driver implementations.
  - Patch 2 adds xmo_rx_hash callback for CMP_TYPE_RX_L2_CMP completions.
  - Patch 3 moves bnxt_rss_ext_op to bnxt.h
  - Patch 4 adds handling for CMP_TYPE_RX_L2_V3_CMP completions

Patches 5-6 add selftest coverage:
  - Patch 5 refactors common BPF map helper functions out of the
    existing xdp.py selftest into a shared net/lib/py/bpf.py module.
  - Patch 6 adds an XDP metadata selftest that loads an XDP program
    calling bpf_xdp_metadata_rx_hash. The test skips on devices without
    xdp-rx-metadata-features.

Changes from v4: https://lore.kernel.org/all/20260313223029.454755-1-carges@cloudflare.com/
  - address RCT again
  - make _format_hex_bytes private
  - remove redundant bpf_map_set
  - rebased on net-next

Changes from v3: https://lore.kernel.org/netdev/20260306230600.1628196-1-carges@cloudflare.com/
  - split out bnxt_rss_ext_op into header
  - address RCT issue
  - rebased on net-next

Changes from v2: https://lore.kernel.org/netdev/20260303024510.644962-1-carges@cloudflare.com/
  - bnxt xdp: actually fixed RCT issues
  - bnxt xdp: Added patch 3 to handle CMP_TYPE_RX_L2_V3_CMP completions.

Changes from v1: https://lore.kernel.org/netdev/cover.1772211065.git.carges@cloudflare.com/
  - selftests: moved tests into net/hw
  - selftests: fix pylinter errors
  - selftests: add check for no error count
  - bnxt_xdp: followed RCT for variable declaration
  - rebased on net-next

Chris J Arges (6):
  bnxt_en: use bnxt_xdp_buff for xdp context
  bnxt_en: Implement XDP RSS hash metadata extraction
  bnxt_en: Move bnxt_rss_ext_op into header
  bnxt_en: Implement XDP RSS hash metadata extraction for V3_CMP
  selftests: net: move common xdp.py functions into lib
  selftests: drv-net: xdp: Add rss_hash metadata tests

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  51 +++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  19 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  57 ++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  10 ++
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   2 +
 .../selftests/drivers/net/hw/xdp_metadata.py  | 146 ++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/drivers/net/xdp.py    |  96 +++--------
 .../testing/selftests/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/net/lib/py/bpf.py     |  68 ++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 163 ++++++++++++++++++
 12 files changed, 516 insertions(+), 101 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/xdp_metadata.py
 create mode 100644 tools/testing/selftests/net/lib/py/bpf.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_metadata.bpf.c

-- 
2.43.0


