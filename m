Return-Path: <netdev+bounces-70586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3E084FA91
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 18:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4138AB2504E
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2530780C18;
	Fri,  9 Feb 2024 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="h/8yt6CT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481B87EEFC
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498314; cv=none; b=JMJwsmGbZEf9u5l6HWCFobL8hG4rERhSifHu8z6tk1MTlEk+chLehtn7Jp+FCFskWCbkZwQjA9nQfDWYLV8A4QjRDvQ+Yc9PbJQZwEk3yD/7DL9a9FsQr5NjhrPV4okjNLTSLl/WqfyZYvqGPs96pbRKMYiO8//bLzH+b0M3OE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498314; c=relaxed/simple;
	bh=0k9AgMjARUIYC1OSbrO7Ph+A4RU8GHcyx7gpzf3ruuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=da11zmERAMHF4dTeCOJRidjXNbDg5hzk20fqckw5oGT983bnRwk+1vYi+8pWWsOGHbYQVAM26cdTZvbT6N2V/i7kvjldEOW8CzgwXAhmIqa93GsgnQr+BGezkGri5rEsZ/aPzCsLcVsc7v3KiIrJ19Cr5yCFOnka7oWk2Q+W/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=h/8yt6CT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3392b12dd21so623039f8f.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 09:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707498310; x=1708103110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KkuLN6apk9lso3kBDkDTwanpyfUBVaMZ5g7KLUGpOM=;
        b=h/8yt6CTFuQecB37V333sxPPPQj5BEfX2FLSRW7N3LpmZxIkJBPC2nzZURRRGnwqO3
         gZHYQ5awLJQ3/oMLVA262AeKPo5ZcrA5iJnGRI2D529wmXyRgPqRIZorWIDRlmWozWVk
         ASo7NYsETuJ5zciZbw+TqltkC0JtdpNMncs+V9VeGczQWmyrPu6To8lkCEvFBACaOre2
         /YkW5Qd+1Qw+mZC4/z0OoIANAVW5L8ITfMzX7fvN4+FjlzpcAZZVBKBhd9/yGUgCMdLN
         qqBWu6+T465WzvhvpPyU2XXhsoy4+/OFLJHru04TQFcqpOtUdj4Z2Tj+OHMZvqt1aMBB
         dnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498310; x=1708103110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KkuLN6apk9lso3kBDkDTwanpyfUBVaMZ5g7KLUGpOM=;
        b=YVzX5mmHyUN6ZDuLzHvPpiLVfYHqBfalBOVfpZVvm6OEOfslvBmRgv/7NicWpZT6Xg
         kmtKEb10nbbRuXWJnjEMGFv2ua0BPAimqzRnDJQt0hv3wj9xc1cQV82vMyUJwYzAveLS
         OVi/364kv0URD/zMYzVZ25Xa6dHuB95sCellpYoSaFuEEayVe/QvuS+KwtFzweKtStS+
         1Nj0JkyWYXH3rmz8sL7Ne7FNlS6m/ZFqR+lgMw7NBgj1SUOAoT2CxJ+VRiN+eIRh7aih
         be4eeOnTcGDD3vDFhtQrRzw0kDrcCJDBLM0RNv54Ad0UQt4dyRmBKn3WAJFxfXHPmGCU
         5uqQ==
X-Gm-Message-State: AOJu0Yw6bKarbC768jodry4nenAYQ7DtuNS6sJCpNW/y9pu0N0I+Qc2J
	iIZD4+4KxW4qrvH0vIUbon6BQmHyKfCO3/3dPSekO9sYy8L/7eATX8td2TviFr8=
X-Google-Smtp-Source: AGHT+IEHFA2QmKLEtJ+f6WaxXW8lfydJwtDHHCs8XQbyAyizuZQCoobujaap/5pdkcat3gNgKsvyKA==
X-Received: by 2002:a5d:58c2:0:b0:33b:46a3:74b4 with SMTP id o2-20020a5d58c2000000b0033b46a374b4mr1419938wrf.57.1707498310640;
        Fri, 09 Feb 2024 09:05:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOAx1Il1mk4uhbcMD6WKURsESBtKR78AcuLJ573yPkN8Z6QuuLgxze4clamqcyRVfxMF+NVSDmisiuDcPSqZlgXMtsbx2BxanlHueBmaD2IEwM6ewQibEYjZydF8QbbKkAOWDD8vJfeVlKXyfG7Ma+nTushTzP/F5rCXfmXVt6GxR9/YJcaCft6Qgv0CT2jbj9CGTXMOlyeubeHUwCaDm2+1KAis1Xx7DPd4KEiF2naRE3h9Q0Wd5CiCOf4Aoh+nHwSRd81WF6G6VUrrkYLg9XhK73kDyhbprGSFtN5HCvhp1VMsFyq0+LTwnLjNusDoTQ/infYJsAJ04=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id j18-20020a056000125200b0033afe816977sm2254998wrx.66.2024.02.09.09.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:05:10 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 3/5] net: ravb: Return cached statistics if the interface is down
Date: Fri,  9 Feb 2024 19:04:57 +0200
Message-Id: <20240209170459.4143861-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209170459.4143861-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240209170459.4143861-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Return the cached statistics in case the interface is down. There should be
no drawback to this, as cached statistics are updated in ravb_close().

In order to avoid accessing the IP registers while the IP is runtime
suspended pm_runtime_active() check was introduced. The device runtime
PM usage counter has been incremented to avoid disabling the device clocks
while the check is in progress (if any).

The commit prepares the code for the addition of runtime PM support.

Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v2:
- collected tag

Changes since [2]:
- use pm_runtime_get_noresume() and pm_runtime_active()

Changes in v3 of [2]:
- this was patch 18/21 in v2
- use ndev->flags & IFF_UP instead of netif_running checks

Changes in v2 of [2]:
- none; this patch is new

[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c81cbd81826e..7a7f743a1fef 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2248,8 +2248,15 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 	struct net_device_stats *nstats, *stats0, *stats1;
+	struct device *dev = &priv->pdev->dev;
 
 	nstats = &ndev->stats;
+
+	pm_runtime_get_noresume(dev);
+
+	if (!pm_runtime_active(dev))
+		goto out_rpm_put;
+
 	stats0 = &priv->stats[RAVB_BE];
 
 	if (info->tx_counters) {
@@ -2291,6 +2298,8 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 		nstats->rx_over_errors += stats1->rx_over_errors;
 	}
 
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 	return nstats;
 }
 
@@ -2358,6 +2367,9 @@ static int ravb_close(struct net_device *ndev)
 	if (info->nc_queues)
 		ravb_ring_free(ndev, RAVB_NC);
 
+	/* Update statistics. */
+	ravb_get_stats(ndev);
+
 	/* Set reset mode. */
 	return ravb_set_opmode(ndev, CCC_OPC_RESET);
 }
-- 
2.39.2


