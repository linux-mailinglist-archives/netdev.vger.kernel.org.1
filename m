Return-Path: <netdev+bounces-71678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FC0854AE5
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D221C27392
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0755820D;
	Wed, 14 Feb 2024 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ktj9XpNg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6554BFD
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919132; cv=none; b=B+GiCVOUtnW5FhQy9h8tEjybKX5QOyPLCi8ZQ2FmiAAtKw4vZ0VJztK7x34+E/gkLkqIELCQjqKRuAmHFV0eHmjlineJKYbnn0WcRaxk22SWyWH6QhbYJprrgwwDUc0GlplNj2CPWAixRSbUhQqeUQPYMRn/lzdBPOq2iLLQTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919132; c=relaxed/simple;
	bh=wnlg4QGrQEl2lf/wneDFeuxaosgd0VZwoBy1W/C0T20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iz4GxYr0YS7KtBOD2h097lViR9x6OEUSspNlsaKA9Ncmn1fhaqv5PaPTzbPGseeBgLcwqFCqBxjLSVajh2e33dEOX1YrXr9Urj+BYw0pyR150tnoxzbOk4Urdo0BKU84PQtekKHwnv2h7GqlcAOPqphurquDLl8C+r1hx1o/Zck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ktj9XpNg; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ce8cbf465so336084f8f.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 05:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707919129; x=1708523929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+KL3xYD2KV9ccdF0IlWQQ5cKlAvwz63tr09eDb/NXs=;
        b=ktj9XpNgG+zKVFPa8riZq10PEJvNdN1lEQrPYoU9t7274+Jz1UUKoPb5+wsby+qdOD
         uFD5HB+znGeDjKFbC1HCaxoB+TdFyvUC8e9ugDnuGs4UbShxRtoxE5lpmeyGB0qSc+Us
         CeGBKLMOApFyMpaWipp9nDzKeYiN5WNjJgkc0sL9/mZEdUxK5bYMSJdkzgksUnkyDCrR
         weJYEFbCAjvOUp/1CpRsPyy3xlnEOpRi1FQ83a3gD6htSnlrRDdp0PWduA2PNfhyTW0c
         pZnal7acnVbVO1HoMR9UZyEW7mnSBrUf5rq8b6TFro0EO0XHlu12/iTiVkERHANVgR73
         jSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707919129; x=1708523929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+KL3xYD2KV9ccdF0IlWQQ5cKlAvwz63tr09eDb/NXs=;
        b=Q2DNhUQORMmt+RuFcQ9gxfJ5fWG2sQLGUFHgp8F/NgfMuZRYdF9T5LmZfd+YQJZUTa
         1z+pcR5xdMrVDL08QnlxyS4TVkEoSCvyovtBSu8BM/zyCi2pXWVUW0JuaykH6XF8MOzd
         TwaKJTfusufJjJjaczsg4PKSOjS3Xk19i0XPp9RukfYEDQJZ5WMj/t33fz89L7BC6UNH
         lZJVlr7nXjkFrARwDeFXcG7E9jWNZF/IiS+lB3ADnwCYAQ36EagDMYFywNyDzwoIeJLt
         8JAPDG1sL0o+SIqpWUD4m1lmBglhppd65daZSwM7vb+YeucM+9Zy82Xi495CGYp5JvWa
         FPkA==
X-Gm-Message-State: AOJu0YxfBDIb7Hub971VViauxz1YRmr21ABJurG9ZV2dhtU4VIk8wUiD
	JcMyPHujvqhsJAeMS6WYu4I0rV5lvs79/lCKYQFI8ul6o9/4zlz+tWAB4wwpJ/c=
X-Google-Smtp-Source: AGHT+IHELOpjxVGsf+kNIAsbMq609PyNVWHE454M79HMOU3+X2yiHoSCv/2AvMySS6E5mv1CU7UwTw==
X-Received: by 2002:a5d:610e:0:b0:33c:da61:471b with SMTP id v14-20020a5d610e000000b0033cda61471bmr1890825wrt.31.1707919128948;
        Wed, 14 Feb 2024 05:58:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX727mqEx6He4qTbpcq0xxT1vuZAEHgkwTppk6XPYjW7HRb1gDNX5gfhjdDk6TqkFNRVnU1AyNW1PmaWFnYYRED0m0VVdiOfHnZ2eiYW6oIFomHh4Rbq0zWuR6bw1+RXgpyPNwy54tuc3aKmMgOBu+b+kEiL+bSMYjkLqG78jXtd7xV7rLYBkOOZtDGzkKIG6QxJmZihhCne4fCN+2Ad3Vqm4PlGDjV2hidri5mXzj9FPhJ5rwKy9ch+KeNAtFPbKj9H3FVgiRytJX778Bxi3d9d3uuyVCKhDWNdGGVTRDFuj1vSBii/lPMfgAlM3+hS+vdpUMof0bpbGM00Vc5NntwSIJ8KRsiY/zZmFK8DnzLwUD4XaSy
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id f15-20020adff58f000000b0033cdbebfda7sm4282140wro.14.2024.02.14.05.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 05:58:48 -0800 (PST)
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
Subject: [PATCH net-next v4 4/6] net: ravb: Move the update of ndev->features to ravb_set_features()
Date: Wed, 14 Feb 2024 15:57:58 +0200
Message-Id: <20240214135800.2674435-5-claudiu.beznea.uj@bp.renesas.com>
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

Commit c2da9408579d ("ravb: Add Rx checksum offload support for GbEth")
introduced support for setting GbEth features. With this the IP-specific
features update functions update the ndev->features individually.

Next commits add runtime PM support for the ravb driver. The runtime PM
implementation will enable/disable the IP clocks on
the ravb_open()/ravb_close() functions. Accessing the IP registers with
clocks disabled blocks the system.

The ravb_set_features() function could be executed when the Ethernet
interface is closed so we need to ensure we don't access IP registers while
the interface is down when runtime PM support will be in place.

For these, move the update of ndev->features to ravb_set_features(). In
this way we update the ndev->features only when the IP-specific features
set function returns success and we can avoid code duplication when
introducing runtime PM registers protection.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- remove unnecessary code
- updated the patch description

Changes in v3:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 7a7f743a1fef..ac23779d1cc5 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2542,7 +2542,6 @@ static int ravb_set_features_gbeth(struct net_device *ndev,
 			goto done;
 	}
 
-	ndev->features = features;
 done:
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -2557,8 +2556,6 @@ static int ravb_set_features_rcar(struct net_device *ndev,
 	if (changed & NETIF_F_RXCSUM)
 		ravb_set_rx_csum(ndev, features & NETIF_F_RXCSUM);
 
-	ndev->features = features;
-
 	return 0;
 }
 
@@ -2567,8 +2564,15 @@ static int ravb_set_features(struct net_device *ndev,
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int ret;
+
+	ret = info->set_feature(ndev, features);
+	if (ret)
+		return ret;
 
-	return info->set_feature(ndev, features);
+	ndev->features = features;
+
+	return 0;
 }
 
 static const struct net_device_ops ravb_netdev_ops = {
-- 
2.39.2


