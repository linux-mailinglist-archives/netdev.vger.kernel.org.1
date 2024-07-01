Return-Path: <netdev+bounces-108261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4207B91E8EF
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655A31C215DB
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2429D16F908;
	Mon,  1 Jul 2024 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="GKYxi27D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93516D4D8
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863734; cv=none; b=MizGWbMUtw69xC1Hj0+ee5zjy11Sb3GWwiVtYdbuby/n6juk63TnDN1d8OWjjTao/q9f/DD0xgk6w4Ct/dlcoM/eoig4Dtfn5rrVD42X+tn/conP33Re0WkTTttt6KuuD6Q7zCvC/6eLeF2X9xPIMWBPTcNHFJwu2oMAXKS5Agw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863734; c=relaxed/simple;
	bh=GdUVcuXJau0XQgUtDn2RnIykZFR/EHRhb4jsKd562OI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FvOUFJ5qjaaaZFrXIsTMUNe+v5xJivfMzOHyN7D5dYtuvo19wMCwKej6i6jEIkerMA2ob3zjU9yf1XBzWTtBiDrj4ywXt2XHK0DBokTqfORdAiACxcobzbbFdYtLsmWy9vbjbPntHKFusj3F4xP0FbjOy2kAZnHGi2xfp37Zg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=GKYxi27D; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9c6e59d34so27533665ad.2
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 12:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719863732; x=1720468532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TR1e5k/QwK38Eecwgw4H4nyeGd2IKxshLYp1nGJ9BIE=;
        b=GKYxi27DiZVoQ5WxoISDmVAo3nTrsuO0yhDHE4S/Tq02FkUlc19YatVMvtCODFFOrr
         CfgBQTGmczMp9KQZcCErnq3S19NF6aDQZUk9v/TVOy2h9CpySEVLpsQ+GXbNGdYm07+I
         SLQUYSPEB6890361jBG6AsDHNgA2e7ddr6Gx6o/LEkUWrLRX+SsfeUI2/IB2qbV2wu2k
         lzrI6B66CviAH3k7Vj69SxH6dLBMZJLttq+z546kjGSg0vK9hlbhBlSU7e0cBMLOK1Sm
         d/67T7QTiD8nDy5mr8tH4HAwxlu2K3L4iE1i6+0KY+/dvFao0ArEONqW8GP4L4lw3uKs
         7EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863732; x=1720468532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TR1e5k/QwK38Eecwgw4H4nyeGd2IKxshLYp1nGJ9BIE=;
        b=PfF4t0QotI+zA2nBIHqyTCqPOsRcznqCpXaB4A508mMXemEMbPRTBh3MZXkoC1ojFh
         bYM0YU47dvUKJb6qOSJf+Ig+gNYqB+kcNr19lSozCBjPs0KNMc0kunzfnp3DJFjD1Bb3
         B6tnmBjqGGZNrKQMa0m34+7+4lQn4b228IUlV3qbuxRBOPPxHS1pmzz1jZKcpc40dpLF
         sz89ijv+AgU90ZDJVT6yDSn9o0PXukV2hj+wZ3KTM193Q2NDRB1C+hudgBJQsr7agm3q
         2KUDSEGl8DK/0u+nOvPRN3hqKKUPRFfg47URKcsN8P44DlhzyiI3k0UfE3kfwgtfyijM
         RBrA==
X-Forwarded-Encrypted: i=1; AJvYcCWmGvMvOdsyXPdE4WUqkFZqJghMth4rOdHg6U++fLTC5eBAAIao5uVQCvUUmG7n5CAxYOCmzLIss/3TWlP9VNU9akx1P7q7
X-Gm-Message-State: AOJu0YzxWeInFE3W9GXGwH1SMbBenoXp/s0D5+uCWvqSyiFD9k1KJxYu
	QQnM6fNg5uKU6yHL+w1xRJDeBCGM+E2j4HO+vSD3N0s/DG71tC2PmD4Q2A8EmQ==
X-Google-Smtp-Source: AGHT+IH62bO4gxOykDwjmVDurxZb6YEN+w6BljGsbMdfFlA9Fw5rlt3NN1HX8JDId68p6NJr/IZC5A==
X-Received: by 2002:a17:902:aa85:b0:1f7:22bf:57f4 with SMTP id d9443c01a7336-1fadbcf338fmr50916305ad.55.1719863731761;
        Mon, 01 Jul 2024 12:55:31 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:56da:44f:4289:b808])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1599c44sm68785155ad.273.2024.07.01.12.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:55:31 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 0/7] drivers: Fix drivers doing TX csum offload with EH
Date: Mon,  1 Jul 2024 12:55:00 -0700
Message-Id: <20240701195507.256374-1-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several NICs would seem to support protocol specific TX checksum offload
and allow for cases where an IPv6 packet contains extension headers.
When deciding whether to offload a packet, ipv6_skip_exthdr is called
to skip extension headers. The problem is that if a packet contains an
IPv6 Routing Header then protocol specific checksum offload can't work,
the destination IP address in the IPv6 header is not the same one that
is used in the pseudo header for TCP or UDP. The correct address is
derived from the last segment in the routing list (which itself might
be obfuscated so that a device could even read it).

This patch set adds a new function ipv6_skip_exthdr_no_rthdr to be
called in lieu of ipv6_skip_exthdr. If a routing header is present in
a packet then ipv6_skip_exthdr_no_rthdr returns a value less than
zero, this is an indication to the driver that TX checksum offload
is not viable and it should call skb_checksum_help instead of
offloading the checksum.

The i40e, iavf, ice, idpf, hinic, and fm10k are updated accordingly
to call ipv6_skip_exthdr_no_rthdr.

Testing: The code compiles, but is otherwise untested due to lack of
NIC hardware. It would be appreciated if someone with access to the
hardware could test.

v2: Fixed uninitialized variable in exthdrs_core.c

Tom Herbert (7):
  ipv6: Add ipv6_skip_exthdr_no_rthdr
  i40e: Don't do TX csum offload with routing header present
  iavf: Don't do TX csum offload with routing header present
  ice: Don't do TX csum offload with routing header present
  idpf: Don't do TX csum offload with routing header present
  hinic: Don't do TX csum offload with routing header present
  fm10k: Don't do TX csum offload with routing header present

 drivers/net/ethernet/huawei/hinic/hinic_tx.c  | 23 +++++++++++----
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |  9 ++++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 22 ++++++---------
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 20 ++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 22 ++++++---------
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 28 +++++++++----------
 include/net/ipv6.h                            | 17 +++++++++--
 net/ipv6/exthdrs_core.c                       | 25 ++++++++++++-----
 8 files changed, 98 insertions(+), 68 deletions(-)

-- 
2.34.1


