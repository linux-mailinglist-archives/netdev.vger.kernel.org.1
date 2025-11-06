Return-Path: <netdev+bounces-236103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D3C387AE
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 01:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B28974F8FD9
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 00:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E0F20DD72;
	Thu,  6 Nov 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqJ7nCpw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA21DE3C0
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388779; cv=none; b=XTpEh2GMpAFYgLJyjLqevA58LMCtDlJb+GuB14t/UjtjFhn8gZ9xm//c1nPexTumPWG0F7jiXxvFrJv6iILHjS4QzXQuPz/bGzjm/Hlx2tNevOsLxOBRxqI2qrEOrQQJBjWaJWMiVWTJEDH/pca8/SnUo0iKtq/wFn3qWHx7SbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388779; c=relaxed/simple;
	bh=wGvVM7e8xZCbRb4uflWfr7nVVAQ6uh8PxX4m7dh8VMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERwc6OM+7RcojAT8MviR7rAIYqIt3iXoCaujqhiW2AhRYUz5OFSXoSwysHByYGFDzD7t42JgkjIJ/moWi4GVi5ALDBbSve1rGcdE7MrYzjuYHbQTjEOftqZJaKbaHlIDJmewRPDSst75DLithQf1urx0LXoi7nEpC1VQk6Eugns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqJ7nCpw; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7866aca9ff4so4507507b3.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 16:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762388775; x=1762993575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGlD8g27EXt4mLiXT/5plrbsHpmSwLaKSFuPthIm2Z8=;
        b=DqJ7nCpwpP6G851RirENXTgAFErtvnG9OOA/hzbsZcCkh4i9khLOqF3IsGnx/c/Ck1
         cqZ2psqTdLw5hma8Vj/Yfg1CDd03qTFxzKhG0FyZYmwVW44TTxHOJhFai7P5YDWgQZ44
         X6Gq9LQd8spsWZUXPMjRdXAv6aI5ZDmcMl7zILarTjb29ZS0/1gJPdPqI71GpC1LZYvv
         TzaJmm/2b4TKQgJsdiqDSCXN8ipBIiSmtgegQaKKVVy7KxHogIR8hIBk0W5b3/GA0GMv
         uIet0WA2EweJuvjZEz/kvr+glBG1adMBV8TwBUui+503LMQNm9BshdHR/+AiI+BMXL0k
         XZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762388775; x=1762993575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGlD8g27EXt4mLiXT/5plrbsHpmSwLaKSFuPthIm2Z8=;
        b=egO+6TRwfyShS9uTBZJtOngll7zk8rcnGoDekEiKO+bWSjAIFnbCS/vc/UeDYV4F+a
         Dpw7Ix9xqsE13ogM9R4wK3+HcFpAADuWn2VyfTAPc8a8GNSqcJKncoKr7IqJ4sxlYx/L
         WzJn9bTcknolY+HryF77VZGGnkSzqHiXKQtY0HWYpTc6/mYdenL6qgVVFKXbLao+TFJw
         Jpz3qbemwgbMhThVIjnqD/l3qJebrxaaY5ov+bckDquylsKlC6QMCjgzDvEzis0pZKfG
         8VshIXpwX9l9AJCExXy8jd2MVQ3Ftq3ojRk1bSsFr7e8X8Y2+DUA42iByC1SCjjnOHfN
         AybQ==
X-Gm-Message-State: AOJu0YwMoaUP/UTG3Zk/8/BiTmj3cyffNM0dquuzjlebW9yqDKXaI+uS
	xQIdQkn7tk98rEJfKuDafbsdnAwbTNKIJzl4sDfKjG8v4t12yXu5ja8K
X-Gm-Gg: ASbGncv1lTHtkfbitXqJS/AjfWM/Rv7dZrvaknyl8AGMgAfWbegI11f+fTNOjavXNi2
	dBr7k3F5n7mxhmcw63SQbQskDSArsn5Jy7+skdWJjDmds4Pa77/yXJ1RaZxZXKB1wfQe4NB02o/
	+73GSldDr3RmGaR3mN4xp1fKZPa2EwMe8X+mk2bAvqpgwfGAZtRWPj8M15NYwXQAQrg2sXa6EaE
	SLOc7cq07NDnxy6zxCo5H/VT5kBiD3Prk4yzNV/8s+bpGVVGl4kvaQpLcNhXD+blLgLIuAEOt/S
	mCreGX2Tfyue92v+TbKjt7jk75gdRrbAHXAHpXbEFRIk3u99uBcQbbz4XZrVjAMqvP7xr0AMrNt
	ptp0hHCyDUJL1tkzvMHrN2HvFFaUcTTX5z8rpHrFMo6bgweYrkMgn4Iv7KCxpXJdd1Gm8lsR9Yg
	bQSQHwTXJe
X-Google-Smtp-Source: AGHT+IHetxRpnG9cF/Gppc13q63FAvtOFyrYEQ3XG9Moiw5OSk5gaWti/6paiCCz38YCOkTOfMqnKg==
X-Received: by 2002:a05:690c:4a04:b0:787:a126:562e with SMTP id 00721157ae682-787a126679dmr29411267b3.34.1762388774969;
        Wed, 05 Nov 2025 16:26:14 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b159c58dsm3439457b3.38.2025.11.05.16.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:26:14 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 5/5] netdevsim: implement psp device stats
Date: Wed,  5 Nov 2025 16:26:06 -0800
Message-ID: <20251106002608.1578518-6-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106002608.1578518-1-daniel.zahka@gmail.com>
References: <20251106002608.1578518-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now only tx/rx packets/bytes are reported. This is not compliant
with the PSP Architecture Specification.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/netdevsim.h |  5 +++++
 drivers/net/netdevsim/psp.c       | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 02c1c97b7008..af6fcfcda8ba 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -109,6 +109,11 @@ struct netdevsim {
 	int rq_reset_mode;
 
 	struct {
+		u64 rx_packets;
+		u64 rx_bytes;
+		u64 tx_packets;
+		u64 tx_bytes;
+		struct u64_stats_sync syncp;
 		struct psp_dev *dev;
 		u32 spi;
 		u32 assoc_cnt;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 332b5b744f01..727da06101ca 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -70,6 +70,13 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		*psp_ext = skb->extensions;
 		refcount_inc(&(*psp_ext)->refcnt);
 		skb->decrypted = 1;
+
+		u64_stats_update_begin(&ns->psp.syncp);
+		ns->psp.tx_packets++;
+		ns->psp.rx_packets++;
+		ns->psp.tx_bytes += skb->len - skb_inner_transport_offset(skb);
+		ns->psp.rx_bytes += skb->len - skb_inner_transport_offset(skb);
+		u64_stats_update_end(&ns->psp.syncp);
 	} else {
 		struct ipv6hdr *ip6h __maybe_unused;
 		struct iphdr *iph;
@@ -164,12 +171,32 @@ static void nsim_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
 	ns->psp.assoc_cnt--;
 }
 
+static void nsim_get_stats(struct psp_dev *psd, struct psp_dev_stats *stats)
+{
+	struct netdevsim *ns = psd->drv_priv;
+	unsigned int start;
+
+	/* WARNING: do *not* blindly zero stats in real drivers!
+	 * All required stats must be reported by the device!
+	 */
+	memset(stats, 0, sizeof(struct psp_dev_stats));
+
+	do {
+		start = u64_stats_fetch_begin(&ns->psp.syncp);
+		stats->rx_bytes = ns->psp.rx_bytes;
+		stats->rx_packets = ns->psp.rx_packets;
+		stats->tx_bytes = ns->psp.tx_bytes;
+		stats->tx_packets = ns->psp.tx_packets;
+	} while (u64_stats_fetch_retry(&ns->psp.syncp, start));
+}
+
 static struct psp_dev_ops nsim_psp_ops = {
 	.set_config	= nsim_psp_set_config,
 	.rx_spi_alloc	= nsim_rx_spi_alloc,
 	.tx_key_add	= nsim_assoc_add,
 	.tx_key_del	= nsim_assoc_del,
 	.key_rotate	= nsim_key_rotate,
+	.get_stats	= nsim_get_stats,
 };
 
 static struct psp_dev_caps nsim_psp_caps = {
-- 
2.47.3


