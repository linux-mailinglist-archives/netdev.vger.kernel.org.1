Return-Path: <netdev+bounces-212795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C26D2B21FFE
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3EB14E4B09
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 07:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6BC2E03EF;
	Tue, 12 Aug 2025 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTQu6/Ww"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE592E0902
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985318; cv=none; b=q7yDfHFj3rA1SE8p6m43ElNp+raykrJP9sDlMugc5aDzXLGs0Nw+7Hsp7GWvqfzhgJNCTC98nZixMzhtHmWREmzxjDvSK1gTklMrw73Y68XwgnDgsUwmfoXyYozmxARNMXlWBQilWc21I/7nA2UnYCrZhew3MG0d/21mccpSQWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985318; c=relaxed/simple;
	bh=xWp66r0AeFV5/6WhSWJkL29H2mScThRCyaasqwDW8As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PFPvsGFJ0fjJJppR6x7j/FxYvCkcUssouh8Na/ve/sCwnyNRrGg6NqSFNdjBgRGLqedYZ8Z+tvB5X6wHb6RjqBAXHkBqz+0F7SPL++J/BytEsQGFMa26AefgXWVYn8UTnS6FUYNZeqADtrMMT2g0S7zuU/Cnws581L3DS0rRfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTQu6/Ww; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76bdea88e12so4406572b3a.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754985315; x=1755590115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vv13BsS5RrQhyQhp1gGWIeio/fMq103HLxAjrsDIysY=;
        b=TTQu6/Wwzhl2lAT32WVtFL5/e+IQ4dCijIJqz6z8bgwLchwczjglvOAZE1EGGWiXCm
         L8kIg8w8CgOUj4PGazawJd9/Mp3FJTUmwT2pnd5Zrym3JgtQxGkJyczyNBf09RPRgdgT
         6/3Y4X1etU/zbpJVDiHDs+XMlP25qgceYcyG2yW1bsH2MKkOE78T2IUDAOHxz/Q1PcWk
         6GfHEf7vh3bfCOc6n0p4lRSQ8aQsUn22bDaM3iNEZ4aHys1QcLEjeCNqgnzezEAzSRSn
         19jX2E9UI94AavPtqpRG8838w7JOk0nXh3FTliEvm/heKJ7+CYpz6rMXGrvExX8+Togt
         x6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754985315; x=1755590115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vv13BsS5RrQhyQhp1gGWIeio/fMq103HLxAjrsDIysY=;
        b=AQEJHBUz9EJMRmOdAixHKGyVZvWAeTcBDy8pHXf8pE2Hke91aM6zBYKVwbzz6QIsJQ
         Ca/le2vNSiI5FdmiX3GZusXMkqD8cKfL6bo8hiBzjusQMSYg4bqigTeNoyITmCymzpqh
         M1zPSRkvPRbJS8SS/BT8NJg1bhB0VBLfXeYQUCePCvv0Wt/smqrRkGvqWm3QMW7MRJMm
         1d8vbSBf8XNTSX11BA5HSEh7MRCLDYHmaFcM3Or+A4qYsD+xF5L5KeRP2Alkb0HIyjRQ
         y8QYTGLfAjejLMHlWhAEhNv7t/FN/PWwqsUo9ZcOa9tFoUDyvrdmVZ86Kf3oENVabgLl
         RbVA==
X-Forwarded-Encrypted: i=1; AJvYcCWzPL+uoVrz+aJnhjIzpsK1x7z4G/W/Dsc2MExClOuh+3kzCs5nhlFeWQ6oxe7omqe1wphUz5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gKTynn1DzT4nAOwwqq9zlxM0I0vfHwqNkQ/9xwEcnwW44jdX
	/cpgcE/5v9NZoqbu15Rugm4cUQM0mUX8lRJHcNRXi7KkacZrXdOWPFOy
X-Gm-Gg: ASbGncsKo9D4JpyDqk5rkknrKlwdoTNMIULOBimXlZ1yhrlmS77j1bOMYnD5bTEZqbc
	FuO6jFWleZWgxD65yRKwGmatZVI8bepwIJHme37+B2HzOs6tU/Xn7AOpqiJvtWvwiRw2RhmbHhZ
	Zy+fHuWPZi7hUYEAGgpkMFWGvPNrAmoWpn2FItGqdRuR/LZhjjlKLj5N1zGJOdEWrshVDrGQyFO
	0jiEmjY5s/XoZFpyd1egBgwjk9iiXoxJhKs4QnuxAvVQr6lpe4qc42o5WA4H1q31BV0/czSPGKL
	/J6UtyJ0D1BFlpObtoNQHlyYvdRKXPe+qQ4b8YZwCCNX5CCulVWPGr0G2iRN7xsXeAA1MuCxY3r
	LR4UMiex6nbg4vZc2PvqByZzgwZ9PUN/I1JUFH1WyhHKQCa8bYWVsi4YJGN/mt29p0ne1spI+dJ
	MBOyyA
X-Google-Smtp-Source: AGHT+IGfk586rwrxxfRmXHZhdzavFsh3ULsuydpMTWKN8QvYxg+vnRc9uQYVUrTpTJPECIJQNk4K+w==
X-Received: by 2002:a05:6300:218f:b0:240:2320:abb8 with SMTP id adf61e73a8af0-2409aa02ca0mr3376601637.41.1754985314846;
        Tue, 12 Aug 2025 00:55:14 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac12d4sm24651320a12.32.2025.08.12.00.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 00:55:14 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	sdf@fomichev.me,
	larysa.zaremba@intel.com,
	maciej.fijalkowski@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH iwl-net v2 1/3] ixgbe: xsk: remove budget from ixgbe_clean_xdp_tx_irq
Date: Tue, 12 Aug 2025 15:55:02 +0800
Message-Id: <20250812075504.60498-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250812075504.60498-1-kerneljasonxing@gmail.com>
References: <20250812075504.60498-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since 'budget' parameter in ixgbe_clean_xdp_tx_irq() takes no effect,
the patch removes it. No functional change here.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c        | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9a6a67a6d644..7a9508e1c05a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3585,7 +3585,7 @@ int ixgbe_poll(struct napi_struct *napi, int budget)
 
 	ixgbe_for_each_ring(ring, q_vector->tx) {
 		bool wd = ring->xsk_pool ?
-			  ixgbe_clean_xdp_tx_irq(q_vector, ring, budget) :
+			  ixgbe_clean_xdp_tx_irq(q_vector, ring) :
 			  ixgbe_clean_tx_irq(q_vector, ring, budget);
 
 		if (!wd)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
index 78deea5ec536..788722fe527a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
@@ -42,7 +42,7 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 			  const int budget);
 void ixgbe_xsk_clean_rx_ring(struct ixgbe_ring *rx_ring);
 bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
-			    struct ixgbe_ring *tx_ring, int napi_budget);
+			    struct ixgbe_ring *tx_ring);
 int ixgbe_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags);
 void ixgbe_xsk_clean_tx_ring(struct ixgbe_ring *tx_ring);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 7b941505a9d0..a463c5ac9c7c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -456,7 +456,7 @@ static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
 }
 
 bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
-			    struct ixgbe_ring *tx_ring, int napi_budget)
+			    struct ixgbe_ring *tx_ring)
 {
 	u16 ntc = tx_ring->next_to_clean, ntu = tx_ring->next_to_use;
 	unsigned int total_packets = 0, total_bytes = 0;
-- 
2.41.3


