Return-Path: <netdev+bounces-69805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0902084CA80
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663AF1F23B20
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7085C5FF;
	Wed,  7 Feb 2024 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MPgOiRSk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607455BAC8
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307678; cv=none; b=cGPhUk2p59fXsYEa25kHAhopYnElPdV4NJJYBOD3Fl9nJNNHooyuWU19xEmr2ICuiAdJH6cjivI8AyhgAQL81LohA2mC4ARcfHuiBEe2hPq2STlyBEqy5PAATIFwQxvqHLnxAnCrDGm6okDv5K3ECAXVVs9jjLa3uY5Yu6DVWp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307678; c=relaxed/simple;
	bh=NYw9l+bXoPskg73dqQ5BlVMt8LzWUzBTvky6tqXSly0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mB5epX75AD4bQt2w8/FQ2hvkaqpBY/WK4MgUL3Kez0O8BM1Ct0IbjwuNCOpBBafh7fFQDeGDchBvENlZmMpS9zOLKK00XSozswwMleJUkYeSVwuHJZpCXrOojG628O7CytAgChY8rxdjOGQoChvh9PU7+6+OtnB+7xG0N0fvYHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MPgOiRSk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33929364bdaso367067f8f.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 04:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707307673; x=1707912473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8pXU065R8j0WF5WsKAZv+XgZqzc/5yTJ5Xq8oCQ9So=;
        b=MPgOiRSkTxmMLIeoko5HPtqgXpR5EcuKIVNP4+5uTIioZRbFY06ZxbTL2FDv+XuKK/
         50HY8Gy7PIHLPAbJA277y1yOgczGQiM/bkVVu9sXkwUqHHATu/FYuXfxE3A2OlDxxDcJ
         +HuQemuEgfoKapU0eP7KXuIGrzUb6az75MOfkk1Fm8fVTPc/y+iUMTremd04WLE5gBO/
         w3/y+wkKx1n8HNw91esOFVPGaVmMb/hLQU9Hy/W8JrQ+4995Y0+CYwwA0Dt8cFVE1uNi
         Sh9Ct5JPv6L+kQ2MrR0l7vxJFQsHC9bjuh4sXjv2URkviN1jQfps5u/zBoBeuShwoO95
         t8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307673; x=1707912473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8pXU065R8j0WF5WsKAZv+XgZqzc/5yTJ5Xq8oCQ9So=;
        b=vEJ8W1GfIPMVJF512X4516SKjP5m55UyzhNAZ12jK8jgpXeCfEockCO1NjcKjl+V5S
         Uwjgk72QcK+JR8fHQXG/98rHcPAP4BpUcvED3ltU3LYBq0uyG6vcAPRHo01tHR+cDG9a
         1MdDJbTNhW3zgRo0bQpzz5DYcrFcxUo8CNQAVEn2DYxGFO6HTrW9s92hV4p7Upj0KpI7
         R89UotcFFVpUszFqBsNWUjNyhsXFp6nQypUJTcJgB8jP/Q7iRQk2cEMJHmBAi4SP01gQ
         22MdcMNAYgLz0eSbZD/I4uVG7FbFIjxjRG2vdMGzrwvH+ZdeuBl5tjGtv61ukVFNRjTg
         u/pw==
X-Gm-Message-State: AOJu0YyBbzmLy4x0dlqR5o8M5lUixnme4neswD90THkQrw7McdOWjcgW
	r4i0GinG/nUjKt0s7hDDJqSIqBKcaESZ/kGvSCXzUIYNYjzcHBa7yreeyvjeiCk=
X-Google-Smtp-Source: AGHT+IHxhsBj13/V9713emnkJKi2bOGNaaDEBPlWNWQmdBgqtYS9PzrOzm9JfR48AlCgTsbNpdXxiw==
X-Received: by 2002:adf:dd8b:0:b0:33b:305c:9de7 with SMTP id x11-20020adfdd8b000000b0033b305c9de7mr3456728wrl.50.1707307673633;
        Wed, 07 Feb 2024 04:07:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTTQoQujoKD98K5RDcZ0QGCdCrcWsry8yyFZx96BpOOKCmgr5/QWLzRYTIE723RDA3tCxQaXoLt9BPkzheSBP7xK6rU5eUntOlOnuw+zm5cOsuL5pDJJqal4IooyFN/COmqcwuVOEwtk8a9vbqBuIIiUSa/KdURaKXvDGg8xLB7ABVyNXtADifd0qLXzrP00HdYyEwfIOFL6OX+Rw3JHzcLci1oOoDnxC1GzGO5Qc0TeuLH0aijoNFP3P5LoBdtMnBUhreNJqaafIuOUmR1acQmeD2uYNqZPLXD6y/7pfuiIKifjZtiIkuYBI+d72OYInUGNa95xb6V7U=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b0033b4db744e5sm1363957wrt.12.2024.02.07.04.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:07:53 -0800 (PST)
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
Subject: [PATCH net-next 2/5] net: ravb: Keep the reverse order of operations in ravb_close()
Date: Wed,  7 Feb 2024 14:07:30 +0200
Message-Id: <20240207120733.1746920-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207120733.1746920-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240207120733.1746920-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Keep the reverse order of operations in ravb_close() when compared with
ravb_open(). This is the recommended configuration sequence.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes since [2]:
- none

Changes in v3 of [2]:
- fixed typos in patch description
- collected tags

Changes in v2 of [2]:
- none; this patch is new

[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/


 drivers/net/ethernet/renesas/ravb_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e235342e0827..0f38e127ad45 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2228,6 +2228,14 @@ static int ravb_close(struct net_device *ndev)
 	ravb_write(ndev, 0, RIC2);
 	ravb_write(ndev, 0, TIC);
 
+	/* PHY disconnect */
+	if (ndev->phydev) {
+		phy_stop(ndev->phydev);
+		phy_disconnect(ndev->phydev);
+		if (of_phy_is_fixed_link(np))
+			of_phy_deregister_fixed_link(np);
+	}
+
 	/* Stop PTP Clock driver */
 	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
@@ -2246,14 +2254,6 @@ static int ravb_close(struct net_device *ndev)
 		}
 	}
 
-	/* PHY disconnect */
-	if (ndev->phydev) {
-		phy_stop(ndev->phydev);
-		phy_disconnect(ndev->phydev);
-		if (of_phy_is_fixed_link(np))
-			of_phy_deregister_fixed_link(np);
-	}
-
 	cancel_work_sync(&priv->work);
 
 	if (info->nc_queues)
-- 
2.39.2


