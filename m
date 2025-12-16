Return-Path: <netdev+bounces-244862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3B8CC0597
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 01:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B3D33011EF4
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 00:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD98243956;
	Tue, 16 Dec 2025 00:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmLdxQ9+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF223ABA7
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765844937; cv=none; b=bMFsTdUnECiiTe6wJ/R2S62+y5BupovHFYSr2jEmC8YR/nz3qA5Ggf9zh3m+RMvmgIfUOBuxBZn7qPTyEABIPZ8N6No2GfWNeO3ZbSqbg4/Ea0wyqeBA56IEDAwfBqQA4WCdvnvozP/Mvdh54dj+LDnm3HMlqSU9sxM4lbsBTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765844937; c=relaxed/simple;
	bh=CaXeOu0A0skQCU0A5drQ+e25Y9LhKKOLHu4OGKU+HfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EWG5p7usZtH9YkkeHqzdhT40NSLfvX4MYZuK5waPxhFn+/LT3oLZB7DuEhuNVFi+O2Md1OiBZSj2K/66dTXaQChKfBVF8zE7DKrtOwQFWsRL5ZcxtleXtK8mgVWqvb/zI3AZxNIB6sgXUmt1OaxJXddWMl5U44X/kJElboplVq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmLdxQ9+; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78e6dc6d6d7so36301207b3.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 16:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765844934; x=1766449734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vS+iE22pE5yQk0ecXq1w/+qZcaWovgCEPqFWh4+wKk0=;
        b=mmLdxQ9+HNZRg7M75lQfWdeciKLciFnqoHpjql3rdPWtnzlGNd7X4A7QXhIgRu6QZj
         xZivoznSgI9I6aNzeJXRaNJCnNN8rYbDPAsggNIrwF7Z2blpUAGJtFIovoakqdv1yJu0
         nBi8zyMl+6eDHPEzK73Uoew/hnbtvipy8T5x2I9IsXDCwEatmWAWXTIWswyOzKEvz5kn
         uDJThnUtr3WN07a9BBgLYwLPDwNPw4L4T3RN9z55AZSONY/eI6TbuLEu5J/cmkUtj6Dp
         QMIAcJzPoWqHv9wz2PevOhE1kqjJj6dBk/QJWbLsiNBz/J0F+vanOieSQgM+T45TZxWt
         vFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765844934; x=1766449734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vS+iE22pE5yQk0ecXq1w/+qZcaWovgCEPqFWh4+wKk0=;
        b=gqcVNpB8BY3IErkgL3rbj7c68uza+AlcwDs8EqMSY4VgjVtftmnIgGAPeId8xOIByV
         Op12Kj1Lhvw0qChrVVu+8m4UJf6dje9X8J9T34161NZKPR248D/eZtZkDNy35tmV2I5y
         dRD/esx/qxuXwgl0Wk5u1oEkSwf+i8xEkz1lUMGtMu7qVSn59fkYzRAOCrYfNCENmd8F
         ZZYSVoTY/P0u2THW+BQ3TjbKAQcc120Bq/Imdn0fPoEEWvSGt7SCA039gnsnDEysu23O
         1iV2YvPeUE1Z+IMRTSvT5UCZzIWuRvjdVmPy/LBZemhcFNbMxA0RQ1o60byS4jmFiK8i
         YsWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaKnnzSodPmeW51BoipclhXVfU2NoMUWBoDadlL+2LjC7M/rfExynDM4j9NnDGuP3dgM75op0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwG8kEKz0Cp3ep9RrbwSjpA8h7/1VkSjGgxY4rS/ofH7kPcsyv
	cs8XvRTfz508+QDuPcPqBRkwFYfqSS5RzrlSFXf36wMQH9WJC7b9peVk
X-Gm-Gg: AY/fxX6+b6w3r9Ny7i1WP/Xl1pJ0lb8xsUb5LHFX+nOd1YTpqwiJudr6+BsYIZhWmEW
	Bv2V592w3d4DpSSvs2XxYNvzA2XnXyTmdSfgOgc9IItpKkgV7e3afRUwFdA4rH1RwSn58bYjhAv
	zoXu9M035mkWwTvkI8o1HpxSoPM3t8jE6Wu+4joR+70CTkKe8dZ/illUu76qenSCn5cb0F3tXKM
	SuL1yU6lW6Dku3YNHXBj5pP65s/LIzURhPNtTjIKA/ptPMTTdZMCweyIeb8V5QMdk3MzQumuI9X
	gOAppmBIVmA3EmM5x1uK5wUPPe5kPq2NKKO/3O1kQ/a8UgYSWR84RLsqCJppwzXf0tA9XIMEWkW
	imeXo5DmNzrHIQOaC6yoO0cy68m7DmOXouav7Nfk44HQ9hKUhh/Xv6iNEpCvXEEUzgvDtGVAanz
	DNQdj2vA==
X-Google-Smtp-Source: AGHT+IF6G9gSXRla2Tz5bO6Ji7opQVGOgE8yQgrLkp9/eG0gts1hC1CXc9Ec1S8HnYTPHfxxJ7DoYA==
X-Received: by 2002:a05:690e:1a61:b0:644:6c45:4ee9 with SMTP id 956f58d0204a3-645555fa40fmr7908718d50.39.1765844934492;
        Mon, 15 Dec 2025 16:28:54 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:6b0:1f10:bc87:9bd7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e74a42aeasm33437797b3.52.2025.12.15.16.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 16:28:54 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH] i40e: drop useless bitmap_weight() call in i40e_set_rxfh_fields()
Date: Mon, 15 Dec 2025 19:28:52 -0500
Message-ID: <20251216002852.334561-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bitmap_weight() is O(N) and useless here, because the following
for_each_set_bit() returns immediately in case of empty flow_pctypes.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f2c2646ea298..54b0348fdee3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3720,20 +3720,16 @@ static int i40e_set_rxfh_fields(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	if (bitmap_weight(flow_pctypes, FLOW_PCTYPES_SIZE)) {
-		u8 flow_id;
-
-		for_each_set_bit(flow_id, flow_pctypes, FLOW_PCTYPES_SIZE) {
-			i_setc = (u64)i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(0, flow_id)) |
-				 ((u64)i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(1, flow_id)) << 32);
-			i_set = i40e_get_rss_hash_bits(&pf->hw, nfc, i_setc);
-
-			i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(0, flow_id),
-					  (u32)i_set);
-			i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(1, flow_id),
-					  (u32)(i_set >> 32));
-			hena |= BIT_ULL(flow_id);
-		}
+	for_each_set_bit(flow_id, flow_pctypes, FLOW_PCTYPES_SIZE) {
+		i_setc = (u64)i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(0, flow_id)) |
+			 ((u64)i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(1, flow_id)) << 32);
+		i_set = i40e_get_rss_hash_bits(&pf->hw, nfc, i_setc);
+
+		i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(0, flow_id),
+				  (u32)i_set);
+		i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(1, flow_id),
+				  (u32)(i_set >> 32));
+		hena |= BIT_ULL(flow_id);
 	}
 
 	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), (u32)hena);
-- 
2.43.0


