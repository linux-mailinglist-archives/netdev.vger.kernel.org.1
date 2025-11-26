Return-Path: <netdev+bounces-242016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4DAC8BB48
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A063A56D3
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A113161AA;
	Wed, 26 Nov 2025 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gjt/i/76"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E230E834
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186604; cv=none; b=N3c6k2iwxyJsLdw1+8Syiu1oTzDBBoMnEx8QQXl7SUlnuMVR6W9S0oU1A1/uBhbwKRAdDhDtKrhYa5WKsu3M7qVTzaKcojaBv1EkIDSn2uEte1QuaDVkbgQBaKWWD7yO6dID0yMPDWazxEz912TcURk3TpgB4ItVB4Y9zavJuqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186604; c=relaxed/simple;
	bh=vZyLqF9s1KdxYlK6BHnfI4+YPQs3yMIMctFHrWUFKNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9TEIJCDUUQhtlI1JcQNkSMM2KjIsfkIdcsO9mfsHLKfCq8MKbuu4ml3BT8+P+j+RrlLNWRfN9aoYHAlycvbh8SWn/AH2pF7Yvkcn68VFBfq3kto9TE739BwooVczhyyKDxyVqm7fx4pMLPTZMz4r++KR8YNodU1/TD/F5zVfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Gjt/i/76; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so92185b3a.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186603; x=1764791403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esE9XDL59DVVADMKJBxTkQQhxV/cW9yMFxZqft8IcUw=;
        b=wBbxrWmf45/+oW4l2mQ4oprPyh//+hYoyOv0kh55wXeDpfH3ddM6SD8DACYRnTQg/4
         D1TgOUtsx5EW86oLCS9ESVMZlFksd43nj21ZNbKvM6U+bYCBQJxNVFqIRi+2HWDTWnD5
         K/ARx96FJlE1qmy0pY1gAJg2f8JUKidnVpy+oKlCCfSVs38Rd8e9xdFTZmK3FdYV9sqd
         CYl7hZzah9MH/d8RaJWsh1d3Hvr0HOh0/sGxJ9GBQQE0WxyjL5fKF5mQXnqg0TOM9Cmo
         kghM2+MimtU8Exj2rQHjqRM3MK2dNOAf1KJj/HVLS0O3DpSYziqWitEs15rX/dqPkpNI
         xQug==
X-Gm-Message-State: AOJu0Yw32vBWCRpfomfiX4rlGLndG8o8s6ay3wtgBN1dF7Qw57x3dvpj
	FhMIPuM3OdShjlR2nlPJIvWPgWnPacZK7TLLGJpC8pm6zlfm12hJSQU7MFojHHGsdDQqX/jhifY
	c+zruxZI7055VS9kJGCu6l1slDNO44XklZC3h9+Rk2f3xJ9yNuxsdtcNEX+C0CAqOYFHcvmrG7l
	fdvRXuZb7WkwbB25xE2+YgWAzI6Hdr72GN0G5lGfwvrNpW5JYVIXv19YOE7Tmi8ckrubNiEb/DV
	3jKhdAswbZIiFNihPiD
X-Gm-Gg: ASbGncvR1p0/HCYKxcUws4V7E3TYixTa66kBqxcge0mHc7RLS2M+5juB480I8qM3+l7
	dx8yHhvGdQS7zqYFFTtUJOblWq5QKMh+2gU3g+DH1eA5YHSfXxsvKUFC3v47c1kEN4ObLLyJya9
	XwBg39F0dowCqoykFgO/REOqA9K8nNBF/UsfHTsc4VcoRFL4svh4vU+D5exCeP5PHLOBfJn4VE1
	K0+ylJllSGmiERMHQoXHyQoWS6iK+bvxAjBOITjCkzmcu7+bWwYYCMdVoPSKoVqJ75YRa/9pQtd
	g/oeuF2pk9a+zzEXeKzC2N1XK+WR7RvqDdK/+BVLyVxW1gGuVPXa+pN8e5T8Gxt4pLbwKvJIJ6X
	Tp2NDOwj1RTiut2CYve2WI9Ioga2IhvRcwmolomcZ4L+zW4IWgrlnXq86n2zAc5qdnp9TKFNaaj
	oHcTfjqCrLGD/F47pcbK2IATQ0jZujVw+wqe12bNVSpNl2YJU8AngYyw==
X-Google-Smtp-Source: AGHT+IEuqV64m0OtW1Wp3dSLfkW7MowjliGZeYHlZW02mT2NNQD7n19EdQMD2N3NGTZLjOmANMw5EHzH8bWF
X-Received: by 2002:a05:6a20:12c5:b0:352:3695:fa64 with SMTP id adf61e73a8af0-3637de9f8b7mr9522984637.37.1764186602752;
        Wed, 26 Nov 2025 11:50:02 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7c3ef56a5bfsm2052887b3a.8.2025.11.26.11.50.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:50:02 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2956a694b47so1432135ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764186601; x=1764791401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=esE9XDL59DVVADMKJBxTkQQhxV/cW9yMFxZqft8IcUw=;
        b=Gjt/i/76eCmWVC8PIXNQ5emfP+QjHtrk2fGdbWARcslka9rQ4gzpkFbZbvlCOT345t
         wX3q9d+lbpYALbGuQlli0I3pt4du7J4gMzGw4NwZbAU+Pfo1k4w6aJFiVL2vhmPT5SFp
         FZLJn3fTezoTKpP1mUH8xbaOVLiK/5pQUvvwA=
X-Received: by 2002:a17:902:d4d1:b0:298:4ef0:5e98 with SMTP id d9443c01a7336-29bab2f3cc6mr92446045ad.56.1764186601049;
        Wed, 26 Nov 2025 11:50:01 -0800 (PST)
X-Received: by 2002:a17:902:d4d1:b0:298:4ef0:5e98 with SMTP id d9443c01a7336-29bab2f3cc6mr92445825ad.56.1764186600684;
        Wed, 26 Nov 2025 11:50:00 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e638sm206782375ad.58.2025.11.26.11.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:50:00 -0800 (PST)
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
Subject: [v3, net-next 00/12] bng_en: enhancements for link, Rx/Tx, LRO/TPA & stats
Date: Thu, 27 Nov 2025 01:19:19 +0530
Message-ID: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This series enhances the bng_en driver by adding:
1. Link query support
2. Tx support (standard + TSO)
3. Rx support (standard + LRO/TPA)
4. ethtool link set/get functionality
5. Hardware statistics reporting via ethtool S

Changes from:
v2->v3
 Addressed comments from Andrew Lunn
   - Apply Rev-xmas fix in several places.
   - Correct ethtool-speed comment to reflect accurate behavior.

 Addressed comments from ALOK TIWARI
   - Remove duplicate definition of RX_CMP_L2_ERRORS.
   - Fix macro by adding the required arguments.
   - Add newline for clarity/formatting.

 Addressed kernel test robot warning
   - Fix compilation error: removed unused variable gro

 Moved hw specific structs to appropriate header file

v1->v2
 Removed unused function bnge_alloc_rx_page()
 Removed inline keywords from couple of functions
 Removed some stats related code that doesn't applicable (missed_irqs)
 Addressed kernel test robot warning
    - Fixed compilation issue with CONFIG_INET is not set

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
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  637 +++++++
 .../net/ethernet/broadcom/bnge/bnge_hw_def.h  |  459 +++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  398 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    9 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 1325 ++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  191 ++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  734 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  216 ++-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 1612 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  118 ++
 13 files changed, 5729 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.h

-- 
2.47.3


