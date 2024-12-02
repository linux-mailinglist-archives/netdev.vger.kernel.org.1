Return-Path: <netdev+bounces-148061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A17929E03FF
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2290167483
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45BA204099;
	Mon,  2 Dec 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="F8/07/rg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078FD201025
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147373; cv=none; b=ukh8ouUkHesoVZrUum5MISekGXQ1KeJzr80fdU2jzyifYcf/JCr2pQX3I58YuBRfO3gLYzurXISnP8Y8ScNViEDQonqTS91Vnkog+lalKAVdoJALjZjscWokTRbMlrjjh7kzI8PournUjjJ8WHSkKThn2geaYZ1f3A5g13dGdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147373; c=relaxed/simple;
	bh=CiFizkoZC96MbaXexVr7inWPwfe5IbT1lj8DVa6YGI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XJXqMG/RLyuRGZHkHmjjLGovqcsMFirDkC6bHxuzZqh/AMIF2AXD11pes4S7LugDgsV8ZHAAioaTWWw/q4kz7h2ORaa9DVxGolOyOYHnSQcmMev3w7mwh2DSnQLB2/JEhDF16WiaKihrp8Y/6WOY9uZKFeYqE4ojUcT7EfQ28zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=F8/07/rg; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffbf4580cbso43228601fa.2
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 05:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733147370; x=1733752170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CpslHNkV2YabLsAqY6bUT0+pw/mS+82i2gGXOOdRhQ=;
        b=F8/07/rgvh5Yl/27rrroF8u/2iOYFCZMyru4a3SKjcp1W1fxnVUvuXZv8nlmFawmKc
         3PV45IGE9CLf7FNXbmJkE5RU1gapus+p6u118pS2ff9cCx+wH213UUP6Ffjy+k/AVAFh
         nY6aX+Ite08eSMNj2quAobcza8eVZcOAP+tEduBb/2KBZnwNQq5RIsCQC9kwEbneo2Gy
         lyBIvFExwk+h6rGqrLWxTEDwnlaSMfB/vy/GQGG4QMgNe/1h3EnGnaTbmyrckHoyfbFx
         XCQUij99dAUkujTg9O8M2Ku0pK5CytyOy8TAc9NkIxYKm4s6lzdclyfCRdkfctGBDksH
         dglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733147370; x=1733752170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CpslHNkV2YabLsAqY6bUT0+pw/mS+82i2gGXOOdRhQ=;
        b=b932970lBoR6pqVcXJnx3FCMAj30PoXv0eUP8Q0DcKYRffvYCQH1d8uC7vsQhSPADl
         sXm7BCv1qEyFK5F3ax3yj+wXSz3XTAehc1cgphdpQkj5wh7mxrujbGO8K6fKq2bNAxhT
         2btvHsh6Q7AUOsVYmgVBJ3opvXY9hiLgPpwnpNLKiHleW6DQktgQXsqE8XJsQGsy9mlT
         ul9Q6DUH4KuKUAb+65QsOs6osYPSoHx1Rp6Q2olLGOoubGNGl8pfXwGKDSuerkbaWU3J
         qr8vsc/weNswN3w2gE40BIO5HcRq+Jo6FQ09tqcfsQnhQwUJ2U2Xb0v8Ju5fbrmGXb8X
         vfcw==
X-Gm-Message-State: AOJu0Yypu54GOQp3hV+LxO86NZm3h78eN0SYcG9YPVrPgreSvspEsn8n
	gHETRE8P0Mzj7ESxKDO1nCN1i+65RAmJYLZsmU1zS8VeA2OREZUmMWinTzzo51o=
X-Gm-Gg: ASbGncsynicYNljL5E/2MpfHOfiSKh/FzrI+ZWvt3ytg/QzGYxdE8bhGRmU2DiNNht3
	ybUxXlLQq5PgvSg/K+LS4yJHXAaVVHV0f1u45lm3uWTqJkt4Zv3DLnnG/SdSDFwRiqtW7Hl6uIf
	MBuTnV3B8Rq1uA6qYSCESrppcjhgt15DpeRe2sMQaDz1co8G8jNn/n13Scorwlw1us5QwFvsGWT
	Du/QjNufjVQYVkjRVv2zr73FkrPyEoZbFfX3lSq0iVE7Y51DU+XnIIKoQYwFqbk
X-Google-Smtp-Source: AGHT+IGOSgW0kQ/hZQdxpAEuxf3UJ+J6ThcTY+XhOdDP1TnARSGU6yBkX5H1G3ekAl2LQYW/fupQTQ==
X-Received: by 2002:a05:651c:2225:b0:2fb:45cf:5eef with SMTP id 38308e7fff4ca-2ffd6120fa0mr125832051fa.30.1733147370261;
        Mon, 02 Dec 2024 05:49:30 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb8f2csm12972661fa.15.2024.12.02.05.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:49:30 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 3/5] net: renesas: rswitch: avoid use-after-put for a device tree node
Date: Mon,  2 Dec 2024 18:49:02 +0500
Message-Id: <20241202134904.3882317-4-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
References: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device tree node saved in the rswitch_device structure is used at
several driver locations. So passing this node to of_node_put() after
the first use is wrong.

Move of_node_put() for this node to exit paths.

Fixes: b46f1e579329 ("net: renesas: rswitch: Simplify struct phy * handling")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 3ad5858d3cdd..779c05b8e05f 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1891,7 +1891,6 @@ static int rswitch_device_alloc(struct rswitch_private *priv, unsigned int index
 	rdev->np_port = rswitch_get_port_node(rdev);
 	rdev->disabled = !rdev->np_port;
 	err = of_get_ethdev_address(rdev->np_port, ndev);
-	of_node_put(rdev->np_port);
 	if (err) {
 		if (is_valid_ether_addr(rdev->etha->mac_addr))
 			eth_hw_addr_set(ndev, rdev->etha->mac_addr);
@@ -1921,6 +1920,7 @@ static int rswitch_device_alloc(struct rswitch_private *priv, unsigned int index
 
 out_rxdmac:
 out_get_params:
+	of_node_put(rdev->np_port);
 	netif_napi_del(&rdev->napi);
 	free_netdev(ndev);
 
@@ -1934,6 +1934,7 @@ static void rswitch_device_free(struct rswitch_private *priv, unsigned int index
 
 	rswitch_txdmac_free(ndev);
 	rswitch_rxdmac_free(ndev);
+	of_node_put(rdev->np_port);
 	netif_napi_del(&rdev->napi);
 	free_netdev(ndev);
 }
-- 
2.39.5


