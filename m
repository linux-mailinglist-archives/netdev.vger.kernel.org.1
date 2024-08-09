Return-Path: <netdev+bounces-117081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B8E94C965
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 06:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A09280F4A
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 04:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FC413FD83;
	Fri,  9 Aug 2024 04:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDIm4SHO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804028E7;
	Fri,  9 Aug 2024 04:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723179001; cv=none; b=r3RSRRTiaa+nBcOAKRV6c8JNNMbSB49gqI3y0UubUDtMvsgy9k3DhqQvOS+IA+PzcecX7ux4kkeELnFrq2sBtgUplaKl793MkgqDRFs2hz9lwiZvpVNkzE3GUXLPfP/Ym7Te/EWdziUOLcYK2SEYDrT9tXJ6p7cyg2qHTFaYIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723179001; c=relaxed/simple;
	bh=plwmUpl8bbS91vzk20FYUxmwUFHawlLmqhzKX1LyIBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7R0kD8j2L/tUd14jRG6w1IMJfn+Yf20VMQ3m/x76pxgVV+d/CfUcdsXG5THjdbMj2+rtYIx/RJFXBqIVxGLtgLpCQEHFudF4L73Am9l2lNSkJy32xxzhz3KYTs0I9z3zniUy2KiiD/3nygebukkSHZswXxPN1hSfz4h9csEGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDIm4SHO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc66fc35f2so19796275ad.0;
        Thu, 08 Aug 2024 21:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723178999; x=1723783799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3bewvnTyD59cSSKz2S43f2fBbzIQwjQdp89CE4Jnh0U=;
        b=nDIm4SHOl6z0sQIOBaxZx37BC4Owsc38V7ZTvj8htF/rW04wG6BOzY3YcPQEFqEPYJ
         LT871jlMy1MNQklVcBk4z9ZzLtw86YT/ipEmmJzwDpZ/sBGjAMN9oRkCeRvlYrP3KGFe
         tEAwq+6DvvDO4tF2I7NhdQgEg4VomzZnRUXl3zVlEb1jSCnyyXYxoweExbwnbqmad3fj
         JvF6jNxCn0ATPBCieCkugwbw5Z7cmewzF62i4iFrju+U2WtlLQ+anGUZ1N34T/YJe/QI
         vRDUwViHEH43bv3ZmHDeV49Ja8l23yWP3SSpGOzn1R7Ok5g58rg1zvG5l5Q9kPmYMRfX
         W5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723178999; x=1723783799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bewvnTyD59cSSKz2S43f2fBbzIQwjQdp89CE4Jnh0U=;
        b=YGQ41+iRDi+2BO9ZRSK4h4nduoSYXih+Cil6M8VakWQP21Cxqm8k4Tk/gDquzGPoQD
         9OZMuKZqSfjYkYi4htwgO8mJGuFy9b6Y0AmXTVOEI4AMIOb4ZDx1bAGYgZP/5bED9dYM
         pqfUGESRt7ZR0loDvIGLgo/D/XxueqqHYMvIaTVwgqmi6iH6l5Lkc1LTyxckr82Tm6w4
         IsTOcBL2AKP/LDhkTvLHna6gh+O+2UGqS6RtOsidZr1h608vgypvINOOcNY7pxffz/7j
         dig21yY0XKY6dTCpDOrQr3peaRGlpxTZjatfVv6dhKiJMCsh0hCKvMLUmpeSNi1MkivV
         4Feg==
X-Forwarded-Encrypted: i=1; AJvYcCWhpxwGdvWv6q2EevDFJmm32GGqz7Bk7K6I01hK+n/HgL09jQxx1Z0MdXHy8VXypa44kkveJ1KBhNKvD4w3Ww0esG4V3Vq2dhvfbfrh
X-Gm-Message-State: AOJu0Yxfs8Ex5SWM8hE5Kl2MKQlHt4u81eTBg7EGC80NJrK5Ip1SsJam
	F82RCYTJ7bWcIwdQ7OtV0/lJJ6AmHxSAI9iJMFdNoM5zcqeSAw2suzUkmNPF
X-Google-Smtp-Source: AGHT+IGJvie0hk3CWW8qAkoiIY+htMJZpmdHHAIPLpg/0gRuX8tasDufdC3ShDyQSVHNI0zs2VDcZA==
X-Received: by 2002:a17:903:1c7:b0:200:869c:960d with SMTP id d9443c01a7336-200967f6570mr56021335ad.3.1723178999508;
        Thu, 08 Aug 2024 21:49:59 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f29e0dsm133139285ad.38.2024.08.08.21.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 21:49:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: cai.huoqing@linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: hinic: use ethtool_sprintf/puts
Date: Thu,  8 Aug 2024 21:49:51 -0700
Message-ID: <20240809044957.4534-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simpler and avoids manual pointer addition.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../net/ethernet/huawei/hinic/hinic_ethtool.c | 33 ++++++-------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
index 0304f03d4093..c559dd4291d3 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
@@ -1471,7 +1471,6 @@ static void hinic_get_strings(struct net_device *netdev,
 			      u32 stringset, u8 *data)
 {
 	struct hinic_dev *nic_dev = netdev_priv(netdev);
-	char *p = (char *)data;
 	u16 i, j;
 
 	switch (stringset) {
@@ -1479,31 +1478,19 @@ static void hinic_get_strings(struct net_device *netdev,
 		memcpy(data, *hinic_test_strings, sizeof(hinic_test_strings));
 		return;
 	case ETH_SS_STATS:
-		for (i = 0; i < ARRAY_SIZE(hinic_function_stats); i++) {
-			memcpy(p, hinic_function_stats[i].name,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
+		for (i = 0; i < ARRAY_SIZE(hinic_function_stats); i++)
+			ethtool_puts(&data, hinic_function_stats[i].name);
 
-		for (i = 0; i < ARRAY_SIZE(hinic_port_stats); i++) {
-			memcpy(p, hinic_port_stats[i].name,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
+		for (i = 0; i < ARRAY_SIZE(hinic_port_stats); i++)
+			ethtool_puts(&data, hinic_port_stats[i].name);
 
-		for (i = 0; i < nic_dev->num_qps; i++) {
-			for (j = 0; j < ARRAY_SIZE(hinic_tx_queue_stats); j++) {
-				sprintf(p, hinic_tx_queue_stats[j].name, i);
-				p += ETH_GSTRING_LEN;
-			}
-		}
+		for (i = 0; i < nic_dev->num_qps; i++)
+			for (j = 0; j < ARRAY_SIZE(hinic_tx_queue_stats); j++)
+				ethtool_sprintf(&data, hinic_tx_queue_stats[j].name, i);
 
-		for (i = 0; i < nic_dev->num_qps; i++) {
-			for (j = 0; j < ARRAY_SIZE(hinic_rx_queue_stats); j++) {
-				sprintf(p, hinic_rx_queue_stats[j].name, i);
-				p += ETH_GSTRING_LEN;
-			}
-		}
+		for (i = 0; i < nic_dev->num_qps; i++)
+			for (j = 0; j < ARRAY_SIZE(hinic_rx_queue_stats); j++)
+				ethtool_sprintf(&data, hinic_rx_queue_stats[j].name, i);
 
 		return;
 	default:
-- 
2.46.0


