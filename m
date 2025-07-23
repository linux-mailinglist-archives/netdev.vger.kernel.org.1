Return-Path: <netdev+bounces-209379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980B2B0F6A2
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7631A1C21A3C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D1B2FE313;
	Wed, 23 Jul 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmY9ziMa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD54302069
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282874; cv=none; b=fWi2IiHnXw53SqONdjIVkzK3JKuFjCUicG66a7pBdzF8oA1q/myRIR2Na3/XU7OAqGRuaOHK0JOEC10VRgOJXzcLY6fGvMiyATPMIiKQvi3CyfmO2w2tTs7JdY0JSWSuvM8GC5qR2jkxfzaQfMhEppDc3XnQ0MvMPKoeovKfKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282874; c=relaxed/simple;
	bh=TGfdalYy4ue50omhezCWB4IDyiNPAoA4lAbjAaGUHKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuaEYxRI8N9DnV27Z9SrdsEmUl8GjtyTNOAZznNzR9+tZ2wX+gbNXYATrbx1t4UucsTaZeLRi5pbtDtGpxoYvDlSZDK7zjqabsh7kaiacqvDkZibkeZsg7cuqbGQsuBhIORKrsZeyz5gbxWGyISuV0YISp5phLhrfov2FZUDJA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmY9ziMa; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso6367551f8f.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753282821; x=1753887621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqAexkHLEIgB4n4jdSEhslJux4o/XWUggGYOPhpZ/k8=;
        b=fmY9ziMaGdbqD6z4OsHpQZGM1V0Wdw5Ap0mSxqoeZBgZVid6VbHD9iR3ntdrjEDFJN
         6MP0GRpJIy1nEO7F+1NwBeh8mTQuSfV1PWc4AMasuhkYL3DKpkqL3Bik6bD7bFv0JQcM
         S/5E6f5V/vfL7GoR2CLUWacEfLMurukQHkMGHkBGoM/+9uHr1Bs2/E/WhhKilc197S+p
         LM2KUeBF8yGzrWW+5sSRU2r2HQgZRUcfnGKawnOUJi/KtGx5dbivrFOQ1niuRJbaPTJX
         kov00d2PyYlKyxVO9HOLaJniDvWY9JgGGGF6/K6gluowLTnQ5qHI58gfE2IfgTmaoRAi
         rpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282821; x=1753887621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqAexkHLEIgB4n4jdSEhslJux4o/XWUggGYOPhpZ/k8=;
        b=FGjWiy6Moi4kX9WIIQ0+zBWy+8OmhwQjeNlBJOA6Hyp56ZcvxAK+dB7AoUN6oJo/0j
         Hwfy2uvP9AH3WX6gJspN+ov+mRUxMu9aIBVeOMUHMyQMVTybwN7tymRI7/0hJasjWQlL
         a+u9SSZbfyPTil4mgKnhjfhuLl9iHHIu8R7u3HBzVil39kZ5Bk1NN3GcoLv83tayhRaa
         KIdCgsZbxqNkJ+T91f29mf/lmbYjPNU2TWJiHTboKpN/5+64HM7kIy/ke1u5gSjyzLOh
         vvLx+cEVSLkKf9oo4mzidJ8zmLQeT9w+3FfTLa+UlMsG3cGQaTflcBMN2iuXl6bQraB+
         0oBg==
X-Gm-Message-State: AOJu0YzKRBcNbXptx0jkB7DX0Cf6wgS76JptB+AGeyILcDQnz/ZDubqD
	UGBbyYIpuFuEO9ld1KWv2NRZMcB5Sw8k3gYvFodfaLQp+7TzTop9EE5bwQtzGNfL
X-Gm-Gg: ASbGncsgPwEIDniLS5yRueJcwI1utsbSdDCOADzUNODVwqo/zJBsdObkvF6YPDpAIrC
	6FZKD6dFmqkvaOTnY7a7V1KOZ+yYuWqEPoDTWfE0/Lu4EwhRbOjvfXwQvrjNl45e84Q65LhwtIL
	0j1FbgN34RgxCD5tV4ubnXP+hVB4ry9/rZy1Z41Acaqv5u4v8j3IW75QUrITq0zAZnDEBcjFjqD
	23hiGcr7P5EjmOf1e/WP0LAdp0T4Dq25+tmJuu/CqxO1T/yfzZ/Lxka/mAg+C3NYXDFts1e5nhS
	TXw4SuoVAnlsQ0zSJd8twH2IMRoOxrqLgSOd9OCv10rt0n57genZxm/Wc5oLQc8na5gfT+TWOg7
	izngcEtvBQojjC+7pyj1X
X-Google-Smtp-Source: AGHT+IEUjodkpGo1GJeSaMDV7dEpYbdXUaakUkNB7/f1h0ObyPx2lWbbkLZwi1dkdBegHw7LlE2/5w==
X-Received: by 2002:a05:6000:4304:b0:3b6:a799:4809 with SMTP id ffacd0b85a97d-3b768f1e504mr3211593f8f.31.1753282820912;
        Wed, 23 Jul 2025 08:00:20 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:40::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76773a29csm3580382f8f.1.2025.07.23.08.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:00:20 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jdamato@fastly.com,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH net-next 9/9] eth: fbnic: Report XDP stats via ethtool
Date: Wed, 23 Jul 2025 07:59:26 -0700
Message-ID: <20250723145926.4120434-10-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to collect XDP stats via ethtool API. We record
packets and bytes sent, and packets dropped on the XDP_TX path.

ethtool -S eth0 | grep xdp | grep -v "0"
     xdp_tx_queue_13_packets: 2
     xdp_tx_queue_13_bytes: 16126

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 50 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index d7b9eb267ead..3744fa173f8b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -112,6 +112,20 @@ static const struct fbnic_stat fbnic_gstrings_hw_q_stats[] = {
 	 FBNIC_HW_RXB_DEQUEUE_STATS_LEN * FBNIC_RXB_DEQUEUE_INDICES + \
 	 FBNIC_HW_Q_STATS_LEN * FBNIC_MAX_QUEUES)
 
+#define FBNIC_QUEUE_STAT(name, stat) \
+	FBNIC_STAT_FIELDS(fbnic_ring, name, stat)
+
+static const struct fbnic_stat fbnic_gstrings_xdp_stats[] = {
+	FBNIC_QUEUE_STAT("xdp_tx_queue_%u_packets", stats.packets),
+	FBNIC_QUEUE_STAT("xdp_tx_queue_%u_bytes", stats.bytes),
+	FBNIC_QUEUE_STAT("xdp_tx_queue_%u_dropped", stats.dropped),
+};
+
+#define FBNIC_XDP_STATS_LEN ARRAY_SIZE(fbnic_gstrings_xdp_stats)
+
+#define FBNIC_STATS_LEN \
+	(FBNIC_HW_STATS_LEN + FBNIC_XDP_STATS_LEN * FBNIC_MAX_XDPQS)
+
 static void
 fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 {
@@ -422,6 +436,16 @@ static void fbnic_get_rxb_dequeue_strings(u8 **data, unsigned int idx)
 		ethtool_sprintf(data, stat->string, idx);
 }
 
+static void fbnic_get_xdp_queue_strings(u8 **data, unsigned int idx)
+{
+	const struct fbnic_stat *stat;
+	int i;
+
+	stat = fbnic_gstrings_xdp_stats;
+	for (i = 0; i < FBNIC_XDP_STATS_LEN; i++, stat++)
+		ethtool_sprintf(data, stat->string, idx);
+}
+
 static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
 {
 	const struct fbnic_stat *stat;
@@ -447,6 +471,9 @@ static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
 			for (i = 0; i < FBNIC_HW_Q_STATS_LEN; i++, stat++)
 				ethtool_sprintf(&data, stat->string, idx);
 		}
+
+		for (i = 0; i < FBNIC_MAX_XDPQS; i++)
+			fbnic_get_xdp_queue_strings(&data, i);
 		break;
 	}
 }
@@ -464,6 +491,24 @@ static void fbnic_report_hw_stats(const struct fbnic_stat *stat,
 	}
 }
 
+static void fbnic_get_xdp_queue_stats(struct fbnic_ring *ring, u64 **data)
+{
+	const struct fbnic_stat *stat;
+	int i;
+
+	if (!ring) {
+		*data += FBNIC_XDP_STATS_LEN;
+		return;
+	}
+
+	stat = fbnic_gstrings_xdp_stats;
+	for (i = 0; i < FBNIC_XDP_STATS_LEN; i++, stat++, (*data)++) {
+		u8 *p = (u8 *)ring + stat->offset;
+
+		**data = *(u64 *)p;
+	}
+}
+
 static void fbnic_get_ethtool_stats(struct net_device *dev,
 				    struct ethtool_stats *stats, u64 *data)
 {
@@ -511,13 +556,16 @@ static void fbnic_get_ethtool_stats(struct net_device *dev,
 				      FBNIC_HW_Q_STATS_LEN, &data);
 	}
 	spin_unlock(&fbd->hw_stats_lock);
+
+	for (i = 0; i < FBNIC_MAX_XDPQS; i++)
+		fbnic_get_xdp_queue_stats(fbn->tx[i + FBNIC_MAX_TXQS], &data);
 }
 
 static int fbnic_get_sset_count(struct net_device *dev, int sset)
 {
 	switch (sset) {
 	case ETH_SS_STATS:
-		return FBNIC_HW_STATS_LEN;
+		return FBNIC_STATS_LEN;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.47.1


