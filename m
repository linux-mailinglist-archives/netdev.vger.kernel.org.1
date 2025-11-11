Return-Path: <netdev+bounces-237728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A159C4FC2A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5963A50BB
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 20:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085AB3A9BF6;
	Tue, 11 Nov 2025 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NJIomaC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9633A9BE3
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894742; cv=none; b=DBZSQRL5dtnn2Cw1E/doseqpp1lkalTLqf48NHxVnm8DnpFjcdt1IoYUFryEvCMh38Z+da5uoLPh/mv9n9BySK8p5m6fM7S5WEj5/GAj2gRQTPTaFQ9rOV3ede5+qT5Ek+Oq9n529z2VeAEg7N/P/tO8XHVQOI5O/u/s/aKTNx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894742; c=relaxed/simple;
	bh=zhqpMMHJA43pv/+KdT9F7BoGDi/CIcsiUS1ejxY5CQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GyDytfvb5A0qD7AQajfc9MvXt+CBfClAIWnKPLyspvcerK1JFu6LNbUu6AUj3nnLwM6aMxuok/HA2PfW/Zp/EvV33Jp3jo7kGZC//06fceg6haaDH+V8ETHRlHCTIgOyb0J4zWPCqoiEuwpnnA7td79skLL7mU/HCEvhtGEec0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NJIomaC5; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-33ff5149ae8so103762a91.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:59:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894740; x=1763499540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KrK/OwsZWQEUZ5NhloRbUhuZmbyRGhs65jfLK1FGUw=;
        b=E4voNImdKpOjT8bJsX2YzwjAPYV9aduYkIEyNfMfrH5fU3ndzlBKygDi3azRaEaXtu
         Ttt3YpPG+S40aFiPBIOn/ADkkoOwe5u5M1OMc310daYmOcNTa1YgzL89jwsQMktYiZRS
         WD9YX6SjxQr6xlLQWE8mrDh5KsVEQRljUI3C2kG5i2LJMrmUdVKYOPzOazVFLnyg/o8e
         ixmzLYVQT+EHHljmkUrqfPtttwRVICmjbc3Hyn61dbTQUdA9CPZbpKvwgETrapC98egK
         1qVlDdmtALTf1OanyLu+TtsHrUAn33+xWKn0060d9yVd855k6x3g+znBUPOVy+1BFkz4
         9/iQ==
X-Gm-Message-State: AOJu0YyVCYmCUm04qwv4ht8TMjRK47fP5o4xUhrpWcmXcuFWswlThdvw
	Ck3pIxa0jSgBzt3OThe0QsBQUmHd7PDxyi3agw2B5kZshDgk2F+By4d9MAtJUEO8DXMvQ7GhT17
	1gMY0NTiiZhNNOylnnH6CZnKd45RAdSFgBSttefqRk4cZU8vanbSB1NNan4/jXUr4eKc7X5+9ab
	9JF0sDxZ97PEoFdG+Vn42EY12lCYrMqtESHlnW7hcPT2yXVuhGLAo/E8ybIkLOmJu/C9Jfy9pT6
	4kQ9J1eZIbaLPt2apIN
X-Gm-Gg: ASbGncv/NqxI8BOlWbCIval0ZrQFt7KhZd0Rkqhq7B2C5UfyeiWVsCIvBCw2j23aakn
	5sccHQolYBwOal11ZQZpYKYVS1iNfTKfzf8ZfKSakK6qM8C4DSa60mfrmMjU+yZZRawmb97p+mg
	aASpd8J/ycOH/fFC9qJgkIrzkFmyahcvY4gh3Ej8FNMe4Q5uqFDYqH2odsNX9A3UYyPB9k2XQVt
	cZldasttegEOELqK1Qh8rYa2fYTH/IZSQ/mmh+/O2VzUBRkHeVGF0jCmGg20ftV1uO2Mm+6D+7t
	zBa4eAnlvT6bgSrio6k+XBfGPTNNP+ZzwEbAoIQUGOEKK8o4C6A/1SArZSuoD9L2W7MHCjo14Rd
	5UrGvsi5swrI7BofUz99hHK0jS4XB6k9w1WbWkuldz9QnlTv/qKaUwfaY4gUDApYknxp8ph1pGx
	C01ISmNFtd8WOCERh9F9eefKkEWPpLgKbhEz0cLy9mEYU=
X-Google-Smtp-Source: AGHT+IGSX4jWMmEKVw0n3ZsvgEksuqxQk4W3mS6OpaxxI6kz0/croSLMSGV0kDkoRwac5nDS//GgkqnevucR
X-Received: by 2002:a17:90b:5683:b0:33f:ebdd:9961 with SMTP id 98e67ed59e1d1-343ddebfb74mr641501a91.28.1762894739634;
        Tue, 11 Nov 2025 12:58:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-343e06f9c12sm3460a91.1.2025.11.11.12.58.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:58:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso83801a12.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762894738; x=1763499538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2KrK/OwsZWQEUZ5NhloRbUhuZmbyRGhs65jfLK1FGUw=;
        b=NJIomaC5GKL1a1ywhiL2y12zlZD+BUQdBcZ6CqT5YUTU42HhCGhukodoqFZy0pGcu1
         4pOfW6wzZ7ehLy/sy6htlkcRAjgf8kQCDuq2JvcHur275g8Vpwo0MusG/vh+V6FeBHsd
         OQHMEWaQBax4DGhkzGYpWHJHTSNF4kvxXd5QA=
X-Received: by 2002:a05:6a20:7351:b0:342:f5bc:7cfb with SMTP id adf61e73a8af0-3590b82e3ddmr641133637.56.1762894737964;
        Tue, 11 Nov 2025 12:58:57 -0800 (PST)
X-Received: by 2002:a05:6a20:7351:b0:342:f5bc:7cfb with SMTP id adf61e73a8af0-3590b82e3ddmr641113637.56.1762894737539;
        Tue, 11 Nov 2025 12:58:57 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf18b53574sm497131a12.38.2025.11.11.12.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:58:57 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [net-next 00/12] bng_en: enhancements for link, Rx/Tx, LRO/TPA & stats
Date: Wed, 12 Nov 2025 02:27:50 +0530
Message-ID: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This series enhances the bng_en driver by adding:
1. Link query support
2. Tx support (standard + TSO)
3. Rx support (standard + LRO/TPA)
4. ethtool link set/get functionality
5. Hardware statistics reporting via ethtool ‑S

Bhargava Marreddy (12):
  bng_en: Query PHY and report link status
  bng_en: Extend bnge_set_ring_params() for rx-copybreak
  bng_en: Add RX support
  bng_en: Handle an HWRM completion request
  bng_en: Add TX support
  bng_en: Add support to handle AGG events
  bng_en: Add TPA related functions
  bng_en: Add support for TPA events
  bng_en: Add ethtool link settings and capabilities support
  bng_en: Add initial support for ethtool stats display
  bng_en: Create per-PF workqueue and timer for asynchronous events
  bng_en: Query firmware for statistics and accumulate

 drivers/net/ethernet/broadcom/bnge/Makefile   |    4 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   41 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   35 +-
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  653 +++++++
 .../net/ethernet/broadcom/bnge/bnge_hw_def.h  |  214 +++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  395 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    9 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 1289 +++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  191 ++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  736 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  474 ++++-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 1604 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  118 ++
 13 files changed, 5713 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.h

-- 
2.47.3


