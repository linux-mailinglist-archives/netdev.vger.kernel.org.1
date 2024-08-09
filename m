Return-Path: <netdev+bounces-117080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D9594C963
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 06:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8891F2464F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 04:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1A116631C;
	Fri,  9 Aug 2024 04:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8GGgX91"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2818637;
	Fri,  9 Aug 2024 04:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723178862; cv=none; b=UApSNR7TO3yvH/WDvFRKCKry1LuETathm5dFiLl6zsgE7LyyeBaGIHTgu3otgHbkkhJnusz/+7yEHiCewELYvQNqViHtdgd0clowVl/KUWy1ciALz2HWo76s3N6Hz4Qd4ohBL38D/hrNrjtWY/xezz2gGHopJkhce+QpK/dyiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723178862; c=relaxed/simple;
	bh=QZqx7jnO/j2Brla3C0G0OwtVVD9v/F0kNxvCDHyxdlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Po2rXOKdX5WnLXako/8qnbeK8z4OMU/vrk8jqI1whWyzd90Vm/Jq8lo6WRgLJImqGQDTN3Sh/vfHMTc1ivzc24+KmjKcTgb00+qqhXIXHmL1tHDiYrjSl7RAH395BgOwDcoNyyMKbWensDxq2tuTxkJLf9ZHcSr6vUIuSfeG7LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8GGgX91; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7a0e8b76813so1188487a12.3;
        Thu, 08 Aug 2024 21:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723178860; x=1723783660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YxhE5h3o21xiOn7q4kgcK3Sq9QhA0IYvVT7eBt21Wc=;
        b=l8GGgX91/i68CPvhG1fio0GAO7K8fqpGVlm5pp4xw7ftQ214UczJ3ob/Ujm1P9Tue5
         PPMB2Qw5zO2edcy2BGPu4di1gGwRrBbbDr3u1Pc6DnDs6QkZ1zSRPUrC4qCgvr8zGWFO
         MvuVwhh00QpTVaWot3wLQEOl5g3LdJ0KqfvIcFHywFcCbykZqmm76U2qfuP+ba5/aedi
         BmXGx9JKQVPDjVKNGUMzBSoZ9WXNBoYZon7Pd+yUU9UEtFrvrK9gNE8ijfnQhy0fCbB+
         VzajJYlrpaeyRU4K60M9V+dBwER39csLk1MBMTDvIXOX3fhSsGHoMuTgWHHI/4ZyxyiD
         Yj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723178860; x=1723783660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YxhE5h3o21xiOn7q4kgcK3Sq9QhA0IYvVT7eBt21Wc=;
        b=H2dqiw1Db1d/0wcZD33FCVjL/nQZZbHsu++w7X94onFbDrXjWpoOkgbWOIqDbVKi+j
         v0EI5PiUV+Mn6JANrR6X/MibbpzBVyi9EN9rNKug8ZUUr9vaJumBUgI1DZZyMwMs1uJm
         my+Ylu2zeutuSWcm8CPEczEag9/8WDuH46wRK8a/g9bINlE0J70/IxjxnZGEqJ19RwYo
         DexXflWz5sfcA+Cu6UwvQYqK1ttw91rosjZh13q7tc0PyURW4QQZdEOhcScjer6tXfjc
         gnUpnvmRE57qe03CVRQ40ZDEoESe01OkWWmwyvrt5U4oWHuZNbUhwMVFPq1z8fTWuV6s
         wwAw==
X-Forwarded-Encrypted: i=1; AJvYcCXu0pZYLEIvkeLjLcX8nQVitVhl8sxCSbiSvHY/NcyU+n7245dPXhXMic9aDKAgx3YT5NgndqHdid+G/hOzvMl6v7l443dMJdMsIuxz
X-Gm-Message-State: AOJu0Yxcq75QDzwmHu8zIX1g1ufeA3jA2yTXxKj/KqQ656OedKxHQDtG
	MYXLO24BQRP57tMLEGVIzd/ox1VNtaL5SO+8aQ1K85laeG4Ns71OVr/v4yb2
X-Google-Smtp-Source: AGHT+IEIh2ijCVDOvX+wdgdtfqwl9YwLLI6DYt91J5DGDRkAMcLG0a7TvXVCU4Y7wBPfRYE7aVYSyQ==
X-Received: by 2002:a05:6a20:c892:b0:1c0:e329:5c51 with SMTP id adf61e73a8af0-1c89fce0119mr686835637.13.1723178860363;
        Thu, 08 Aug 2024 21:47:40 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f5ebc4sm134341305ad.107.2024.08.08.21.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 21:47:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: vburru@marvell.com,
	sedara@marvell.com,
	srasheed@marvell.com,
	sburla@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: octeon_ep_vf: use ethtool_sprintf/puts
Date: Thu,  8 Aug 2024 21:47:27 -0700
Message-ID: <20240809044738.4347-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the function and avoids manual pointer manipulation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../marvell/octeon_ep_vf/octep_vf_ethtool.c   | 36 ++++++++-----------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
index a1979b45e355..c7622159d195 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
@@ -58,32 +58,24 @@ static void octep_vf_get_strings(struct net_device *netdev,
 {
 	struct octep_vf_device *oct = netdev_priv(netdev);
 	u16 num_queues = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
-	char *strings = (char *)data;
 	int i, j;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < OCTEP_VF_GLOBAL_STATS_CNT; i++) {
-			snprintf(strings, ETH_GSTRING_LEN,
-				 octep_vf_gstrings_global_stats[i]);
-			strings += ETH_GSTRING_LEN;
-		}
-
-		for (i = 0; i < num_queues; i++) {
-			for (j = 0; j < OCTEP_VF_TX_Q_STATS_CNT; j++) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 octep_vf_gstrings_tx_q_stats[j], i);
-				strings += ETH_GSTRING_LEN;
-			}
-		}
-
-		for (i = 0; i < num_queues; i++) {
-			for (j = 0; j < OCTEP_VF_RX_Q_STATS_CNT; j++) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 octep_vf_gstrings_rx_q_stats[j], i);
-				strings += ETH_GSTRING_LEN;
-			}
-		}
+		for (i = 0; i < OCTEP_VF_GLOBAL_STATS_CNT; i++)
+			ethtool_puts(&data, octep_vf_gstrings_global_stats[i]);
+
+		for (i = 0; i < num_queues; i++)
+			for (j = 0; j < OCTEP_VF_TX_Q_STATS_CNT; j++)
+				ethtool_sprintf(&data,
+						octep_vf_gstrings_tx_q_stats[j],
+						i);
+
+		for (i = 0; i < num_queues; i++)
+			for (j = 0; j < OCTEP_VF_RX_Q_STATS_CNT; j++)
+				ethtool_sprintf(&data,
+						octep_vf_gstrings_rx_q_stats[j],
+						i);
 		break;
 	default:
 		break;
-- 
2.46.0


