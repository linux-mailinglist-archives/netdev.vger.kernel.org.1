Return-Path: <netdev+bounces-71677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54367854AE7
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BE41F21EB1
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 13:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329CA54FA9;
	Wed, 14 Feb 2024 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZI2P9KWM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7EC55E4A
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919132; cv=none; b=eNafmQH0YLQiszy8Sv7wLLq7oySIKtbPwk4KqPCq+YuDigeEWLbs/6gN7vQkhnGgyAjATTUT+n8SAJCgV0J0SHQYIAxwkfyOb/CxAtmBXZk4Y4DT5xJc7sHL9fQ/riz3DUs1AfvlmUmAf+rkpZlVpwXNJT3mmxnNUuw9FI1Ws+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919132; c=relaxed/simple;
	bh=FjpT7HYwfIhvnqp4YHdZLJltiMOVfPS1cPTRRdMvPpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+zie0ynm17GD0RU/6OQlVNtoDFur6h6F3GhCnIq3AUXi/0BeM1xuF09itMq9huD0U95o0ZHcpLkss/0Lgrn2W3CM7WhS5u76FzI78avdsg6P3RsoPtaetBfXvMKI3smC62JT+AtFkxc5kslO6XhJscJH7LUazOau+rjWyvWv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZI2P9KWM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3394bec856fso486810f8f.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 05:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707919128; x=1708523928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNOxk7ObMlNCb9z7bNPG/kiAHGWviZsSjwr9QNQkzTs=;
        b=ZI2P9KWM/nrONJ9toyahqSKqaKH3K3EHbiCBTl14drdBlIcdCbzfcZBs4l7LNcMp3L
         +0TZKoWidLpJaT1BBYgjgyXbFMVIVpzQLOjf5X+miC8z/TCOUGZyyAHF+zQFMjC5bgS6
         khbCpdNTWKy/gstAPW6AakaV3/1tCRcZU1LzJgN0S+ljPYSFzMjixoJnKLH6EXAN0MsB
         3B87yBQ1+5Uzq+CzjLkXcChqv4/sOHR711p9w0eboKMTVqkuA6i2pAbA1HcOk9Vs46oK
         Wbq6qaS295u9tOKL1cAfL7MFlgMqDnj7gvE6p6G+XAozNbeLcUAgthtojYUk6qk0c/Aw
         uksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707919128; x=1708523928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNOxk7ObMlNCb9z7bNPG/kiAHGWviZsSjwr9QNQkzTs=;
        b=YdXs3upWKlSYT5L1UF6RAFsZToJAf55o3XOq25AFUmLQXPSs4SoAV3qFcjNpADjPn2
         9e7oHTsgg3lWJcs8ekQrIEUkwXx70RIk5DkCI3oDaOXmRg+0gnroCu0QGVIyK0UHqgPt
         8F8WcC+5a6rskHmzcKkAi0t4f1gkoEfCdwFUc1OVpRBnJ+dcvAUwfeZRL+XYpLeRvcUj
         AQqjTybPU4c05nQQHBfnBE5AXaivN0D3VUyhLXwL66mPdnFLVSOdLyuFxoidBCf18uFf
         F+ja5Pc5GbM60oDtlzNP5YIGW5fL7QzU8r8bgn+U2TILOJrA1LZmWLrdIbjXOnw+s2RF
         hhzQ==
X-Gm-Message-State: AOJu0Yx9xqGXUjzLJzTIn/QjWgi29r/W/D33EORXaaXngJNj3F6mgsFY
	IcxxtOtI26b36tMNGjEDFAUYEyWH2hZmmDrbFY7gcYtsRHfeHEDX/HmtyW+u8lo=
X-Google-Smtp-Source: AGHT+IHK7iuy1qy6aGSYk+qSKN6o73sTYMtUh76iYC0dJvzAJbqMyr2Rgb+brY7G3+I0wM1w/gzVVA==
X-Received: by 2002:adf:ea8d:0:b0:33c:f29a:30ec with SMTP id s13-20020adfea8d000000b0033cf29a30ecmr911894wrm.25.1707919127685;
        Wed, 14 Feb 2024 05:58:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyOQ5GbcNIQ6rfjuLwMp8PqwHzicVvuuJ7S+f4wLP/0H/l8QubsaFrXRCoDnuP/8vwZAHZe0RD1Kvqm7bMILuvkso5XDDEL5Qf8B+OIYFuVakb3Yc426JUGj+ikTFZsmspp7WJKyZAnzdg5TmkXXxGkuctdedr6boDsaTxQAonlq6iUZNBs4ZCjnTuCz4kCsrXVXW3S56HM4aomL1329GtwZSwjLEx+8ICsAFIFpJXNNHb1vl60HT2EPRIL0s0GhzL2pt57YXzDXGBNECHF0pejcS45H46VUNocpeplHT65HrnXnvCbjjN2xljnuo5LfaYh7AuT5RaFsCcdkc5W+nXomvM5ljeD1U4tHAYPa/6xmVCSjhS
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id f15-20020adff58f000000b0033cdbebfda7sm4282140wro.14.2024.02.14.05.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 05:58:47 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	biju.das.jz@bp.renesas.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v4 3/6] net: ravb: Return cached statistics if the interface is down
Date: Wed, 14 Feb 2024 15:57:57 +0200
Message-Id: <20240214135800.2674435-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214135800.2674435-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240214135800.2674435-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v4:
- none

Changes in v3:
- none

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


