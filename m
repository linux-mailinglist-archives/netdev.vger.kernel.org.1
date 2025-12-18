Return-Path: <netdev+bounces-245268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73590CCA066
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 02:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 395B6301E599
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 01:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB13271470;
	Thu, 18 Dec 2025 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqI3vwE8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331CF26F2B8
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 01:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766023083; cv=none; b=HA+wNOlAKkQSR09VDeEZppo9gnakpjTPPPTaWdH8Fdv7tFMu6bT0RK5kviWelOjufLd1GchonSodPHx2VJt7zpeNfOhUnmlkOCuWPYL5sUCFNlLe2Bt22nOt9nA29ZXv5asL1SEGM83jhYUO9ho1Ill1NqAg2tQ58d0Q4ECsZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766023083; c=relaxed/simple;
	bh=m5Qk89Nat20MUzAln1BuVH2Y8Xvr1iPdN2DmGMoekxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMLwBsgq5RdPmd7EOO7yoGaq8xw3Uz11Xv86jVrdlptbGbuuGiLhJJ08V/8zZE02U/cHgc1YD8e3D17+21xxeZH+2igqlHGgmJrlCkUAdpuDtDDtUB2eqXGHcu61xmnF/SGMGeTdbIBbJBnMbI8HL2QOWrxggofWyBp1Kl0nNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqI3vwE8; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6446c1a7a1cso98175d50.3
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 17:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766023080; x=1766627880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bQOfmftLH8KAfTXHZBw4TB9dKu3rPCHujQ+Dm7h606A=;
        b=dqI3vwE8hzP9pjO43J98QNeZ81Py47Lo9X/O6ynZBnOUlIqp6ppvcV2HS8WQC3SH9X
         bXpEzYZ8stg3kwd5FNcM9Q11uHdzQaJZzbbQi71/JCRa46HMAByYGp6rko8OslE6PCqu
         GzsAR0wFptlDIwYyh5Exom85+wgrS7bWH0f8xlPPA4LK9GSjRBWvmzOjMtXUxVhBmGnh
         D619rva1Z6FnfRMkwh/0mYX0rSv+xlpnaGVpme3rgQkRhVKLHsAV2muI2yDI/+QKjn1j
         EtC8AXemEAHlGHizMH/XFteOtGbjBETmOE60Jc1RNZQQDct++PZUDSqq3bGYE1neiJbr
         QWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766023080; x=1766627880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQOfmftLH8KAfTXHZBw4TB9dKu3rPCHujQ+Dm7h606A=;
        b=vSUAPoQ56fjsGfN5K04gjoQpmUXNUbW9aZRTJamEFhQeifSbRUPLbUCGNykDz4DiAh
         Fd0cEhpd2685LSkOstqAcC+u+KygddL3wXxfQln2S4INI7D2PL022mw0pQhU3UzuTwEa
         546bjf9WdupIPQOSd5B3K9DOH1jYOgr6RUP/Me0swASTLZs9oM3caj0/r8qr14uXWkgz
         j3YNy+daFdVXk9GpkbkhhE16sdHuyqhj3VAze1dHv/D/fUE5uIRa4q7UY/usDGDvJ+KH
         /5LQxxPqebdcZh/94WgGP98ZFVi4SAmC6x9fXk6vzflBcKsRi3wJRSqQkeexYUlHtnBD
         1mwg==
X-Forwarded-Encrypted: i=1; AJvYcCXV0vAkQzRePnOGgLFU58RGHT0PDsKGBuhqAt0Qv/2HiD7sj2LnuC/gq4CliAqK+jLnHHEiaCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlEi9+LfHcWKjGF3WcMwL+pdheE2m1u3+ix+FqKC4HxtCyAzRG
	qUkmaiG+2+pO7IdXvou2sfreNzXmNR3J2Zm5GAcp4KxfMXau4aoIZbzR
X-Gm-Gg: AY/fxX58WbMfWrcf8bKFy3HKV8A56G35kCiAdX6cWV8C6yn8H1D7UJGiiezx8IK9qsE
	xf/k3ZUFJv9sw90pG5t9HxmcNetWXxCZ5jRbFqIMHurz5+8p1ZvLc9q6a1OlHLXewcshRa+jKjh
	v62b86jdKxmSk5hzDMGlr6IZOC0XHudjb8nWXsAKjYIYJ6mK9a962cfnilzphYEr40yBmUowUSd
	/XHSz9CQH3RfTmnwhyWJ+E22UcV2AG86+GqLug0CkmL83v1PXlUBUQr/5c7A/4jbGCsMerrcobg
	QmqnQiofqCk2G1BAzoEN5p2botHYDW8Z4tVV9d8gSxSXVVdIh8dFYF2kYexl9Bji19ENSjaRdLM
	5tRtLJhoU9Qs9V1TkweYAhbtJVDWzI2igbviEeYkA3MHsrusT4zQTZhV+aAVOegNzESWz+T1TjM
	F2CAdG84w=
X-Google-Smtp-Source: AGHT+IF7Lkwj0sSdZaNQ3dsB15WX1orUqF+lFaxr1wSODVAJtotITBD0kMje1L4hZ+gr1DxEnLMwlw==
X-Received: by 2002:a05:690e:1407:b0:644:60d9:865a with SMTP id 956f58d0204a3-6455567d629mr14606696d50.93.1766023080117;
        Wed, 17 Dec 2025 17:58:00 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:52c0:aec0:bf15:a891])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-646636e86ccsm472527d50.5.2025.12.17.17.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:57:59 -0800 (PST)
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
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: [PATCH v2] i40e: drop useless bitmap_weight() call in i40e_set_rxfh_fields()
Date: Wed, 17 Dec 2025 20:57:57 -0500
Message-ID: <20251218015758.682498-1-yury.norov@gmail.com>
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
v1: https://lore.kernel.org/all/20251216002852.334561-1-yury.norov@gmail.com/
v2: don't drop flow_id (Aleksandr).

 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f2c2646ea298..e64880b6b047 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3637,6 +3637,7 @@ static int i40e_set_rxfh_fields(struct net_device *netdev,
 		   ((u64)i40e_read_rx_ctl(hw, I40E_PFQF_HENA(1)) << 32);
 	DECLARE_BITMAP(flow_pctypes, FLOW_PCTYPES_SIZE);
 	u64 i_set, i_setc;
+	u8 flow_id;
 
 	bitmap_zero(flow_pctypes, FLOW_PCTYPES_SIZE);
 
@@ -3720,20 +3721,14 @@ static int i40e_set_rxfh_fields(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	if (bitmap_weight(flow_pctypes, FLOW_PCTYPES_SIZE)) {
-		u8 flow_id;
+	for_each_set_bit(flow_id, flow_pctypes, FLOW_PCTYPES_SIZE) {
+		i_setc = (u64)i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(0, flow_id)) |
+			 ((u64)i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(1, flow_id)) << 32);
+		i_set = i40e_get_rss_hash_bits(&pf->hw, nfc, i_setc);
 
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
+		i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(0, flow_id), (u32)i_set);
+		i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(1, flow_id), (u32)(i_set >> 32));
+		hena |= BIT_ULL(flow_id);
 	}
 
 	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), (u32)hena);
-- 
2.43.0


