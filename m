Return-Path: <netdev+bounces-246899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD819CF2312
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 374F330022C2
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0615278E63;
	Mon,  5 Jan 2026 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MYj98tsE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBE8265CA2
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597750; cv=none; b=LGicc+ZFpza3SoedGhXYGKPU0syUNpDCW//cmIDXdH8talkEoefiza+WawITkAdDOW9+hE4v/6Qu6rd7bcYIxHKpuo0pAYqRVC6RjXY7sAXIPJn4pXKYYnhlvA90Q7g5r7pDMqczKSBD8ipyCKZ36ztt1ODrlHfAUawG73xvnvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597750; c=relaxed/simple;
	bh=L5fI+z8Y8WTRwiGdbkMYEv2hD9xv7aVIU8+QBZCEkSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTJhh2ynzyc+lY+/u0EpTfGEH6+AdnIJvNLFsTswgDsYlzcSMOSJc/2vqpcARnDpvq6Uk081/oQWX+b50xrj0y/z2sTG0atOt0ctZbx3/uYlLjdAcOth5VeTfUb+24eqcr7QSQg0YFDpJuiRfpkx5iwnAdT25pBUACopPW6AoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MYj98tsE; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-29f2676bb21so192251575ad.0
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 23:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597749; x=1768202549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clHRXoDCZ+pyaZMCf9nHtFK1paT2n03NN42x8N6TXTU=;
        b=kBfagWqCcFSh0V4RLq70pjsjHc6bY0SOy3PbVZAVVVxU4kWpWD65yJenewypa3NcRx
         eqUuwhW4d+GZyf+NJGl5EgKPp4JN+y1kcSgB0vqz9oKoqZ3YoEG/nY8E7SxG9jSi8CqV
         rAAexe8si7uL2iBX4m0eUdYRz9xueJrHdurzKAchcGJTEJy4hiaQGZoxVuXusD6yb9Po
         Ahg53A5ujxdM0ngFrDD30x/Wa2GO6v78a1Fci3igTP1Ao93jZTQMraz5uU/fysNXsgvh
         HTz+P3qbFrdf/aqRp9dPsJ/4EV4wxy2oDNgD8k6nWB2Fn9YTdIKNdlnJcEVXzFlaaLSV
         TBVQ==
X-Gm-Message-State: AOJu0Yw0IAuVnnqYqiGpkJXy8vyJl1oRtyEE2+6JsF4yh7ye+zHSErHK
	Q5NxxSBLh7FIQ81FRKhJsLhQnfGR/v0cLVH6LoXIvUvjO9bGYRz1QJRN5ub6D7RGxDRK1sTmn0q
	5p6h4JlpT+Nqju+uD7xNwPt1HMwYVlQKDWaAU4590Opw82m355VZ5ebTw4m1orNY8+yQQXjVnBg
	mT5vbxSzoOb5POfJ/3XGkRjX8+yJjH3cQRAF0iAQ1L7SBV3RXzXLdqC/idT6/9T+Ktu3IgJef1T
	KXr0VI7ADGkLv0zaRhc
X-Gm-Gg: AY/fxX7gkAOukTuP2RGVvohH0PRe+zgOyq8vzgtmurJhSeAAoQJNJ9nCH1MgIEBcHzL
	GFdAYf90Q7KNN31Jdb3SZuhIyDUKvSwUZPp3hx8AquBcJ+afa+exAzehxsfoAuKkmDi/BGvBM7L
	d5vfyyNWj1Z3hx54K8WbJSU5PC4d1aqOj8YOLwG+yU1Q2wlx6R2Vw7zueiiEfkqCUXt0jBTyJzR
	BeLT3Pt8EZtmAfOrdg1604ZN0kuRKK5Il2KiAPGb/Ab7rHOo7A3VquRswftZN4JBMkwoSm0WhUg
	4YDridbLJpFwzwSZ0Fu9guh9mcFyPrOlTyBCrj9v0fZgS+/4LuNY+eHfQM6P+66C9+DMGBqJw6D
	936F7AMSwtJ3caOycQmRl4UGiAlXp/kSeH50p53WLSBcyZ9iU2/s1FjR/V3mJK7xtNDuGmZLRsi
	jAuZQuiHSxUZnzgOQMA4bfofeWvUrrdkCdvNQyNZDl9Kp6f8gQMWuJNg==
X-Google-Smtp-Source: AGHT+IGhjCpHlpTg4LGm3s58aPrE/WKYqFHTBwrrXKa+WwXi7NozISiLD1/e4xWlWOPk3FtKnxdvEnAnKUq/
X-Received: by 2002:a05:701b:2615:b0:119:e569:f615 with SMTP id a92af1059eb24-121722abf62mr30767931c88.14.1767597748545;
        Sun, 04 Jan 2026 23:22:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1217252ca1esm10832142c88.3.2026.01.04.23.22.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jan 2026 23:22:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b9321b9312so30262821b3a.1
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 23:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767597746; x=1768202546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=clHRXoDCZ+pyaZMCf9nHtFK1paT2n03NN42x8N6TXTU=;
        b=MYj98tsEAbQgEDVABGapXPMFaF80/WHQbo5cMvO/fUCTI1d8/+WWEZfo4qkt7lWJdo
         B0xfifOnfqHHsSN+MzNBWoMMpi9zbkXk4h9mocX4cnkhhZq1j5d7Bch7LuX645ol8NVK
         4mjmUyGAAGy+cmU72RrDi00uRCwZi52BrZOL4=
X-Received: by 2002:a05:6a00:1f07:b0:7f0:ead9:578 with SMTP id d2e1a72fcca58-7ff650c7e98mr40069613b3a.2.1767597746632;
        Sun, 04 Jan 2026 23:22:26 -0800 (PST)
X-Received: by 2002:a05:6a00:1f07:b0:7f0:ead9:578 with SMTP id d2e1a72fcca58-7ff650c7e98mr40069597b3a.2.1767597746275;
        Sun, 04 Jan 2026 23:22:26 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfab836sm47293293b3a.36.2026.01.04.23.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:22:25 -0800 (PST)
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
Subject: [v4, net-next 0/7] bng_en: enhancements for RX and TX datapath
Date: Mon,  5 Jan 2026 12:51:36 +0530
Message-ID: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
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
1. Tx support (standard + TSO)
2. Rx support (standard + LRO/TPA)

Changes from:
v3->v4
 - Scoped the series to RX and TX datapath per Jakub Kicinski's comments.
 - Dropped IS_ERR() per Alok Tiwari's comments.

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

Bhargava Marreddy (7):
  bng_en: Extend bnge_set_ring_params() for rx-copybreak
  bng_en: Add RX support
  bng_en: Handle an HWRM completion request
  bng_en: Add TX support
  bng_en: Add support to handle AGG events
  bng_en: Add TPA related functions
  bng_en: Add support for TPA events

 drivers/net/ethernet/broadcom/bnge/Makefile   |    3 +-
 .../net/ethernet/broadcom/bnge/bnge_hw_def.h  |  459 +++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |   65 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    2 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  402 +++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  120 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 1631 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  125 ++
 8 files changed, 2766 insertions(+), 41 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.h

-- 
2.47.3


