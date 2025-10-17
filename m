Return-Path: <netdev+bounces-230523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 583F4BE9B17
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0551035D879
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5587933507D;
	Fri, 17 Oct 2025 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtE7O4cg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D73328E9
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714367; cv=none; b=bJQcWw+CpMQX+LY2VVqQ4LX40yM793oQOyTtEBaDnkgGzibCZoX43KOLlgnUkYPMIt9Fpj306uI/7cp76SRcw0qL01W7lf4TRGEHiov4pvv4irFVWKT+EN1nE2DWoSSRae14jJP3/yMaN3iduPDeBUrUG2trzS3s0U3NHKMpcwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714367; c=relaxed/simple;
	bh=/osEKnWe3mbTF3iLxYWox4eoxzoJvmAFu4soCr3U8BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1VBWsFhSS23NCSzMY1tXSzxfO2g6p54bqYDLIa7EhY0pgNBhrXGqTf4SdggHLmbvs9UwxSLHyOjYRE6zErLBEKwyLNg1o0VsfZEWikqOEGC8gQ3b3RpqJgWu/+DvASlQZsNUtteK2RW17Pzx6WBLimcdnbTGDPpHTpqIv4fOC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtE7O4cg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290c2b6a6c2so16215405ad.1
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760714365; x=1761319165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypV8vCzrTsVuGY3EOGhG77XH5/MdfxUEKyYPHv8FMv8=;
        b=GtE7O4cgk1KAhOF09i2N5n8DnUFLJoRKD7T1kxKNi59WhwqByApft12o5zVwuuCLwp
         3kUo6+APvf0pK963jxw/wfuyA/AJZ47c7DZGLCwLuiEtb5JQRp7hBOAz/7wvLExV+sv8
         zeBXlDoj+tOQZzKpo3dzRMNim9mAgMaVFimswuOtSfrzJ7TK8sHITFgIBOHBWaYiS4aX
         NQupAOpPBLKQazh4cTtNFK0L2qyo+zIoB35kMJn+ugsFWkwlr7SEXKKe+kTRln7snsBI
         Keysawvk+Su+tiuvEt2ZplRwCJPl6XZ14nfniq6uHF6JHHoDIQXsO7e1OJXbTeO0/0oD
         lNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760714365; x=1761319165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypV8vCzrTsVuGY3EOGhG77XH5/MdfxUEKyYPHv8FMv8=;
        b=bEY6VqpUyx68r0tE3uU8swK2sJysnI0jtaxMzX13iuPqjVeATcER7B9T8KP91dTwKO
         s3Yg5B6YDiK+zhMURwDlYtKeEudEhdGVIyooyr1fZfz2bjo8nYTWzM3t7vxp5bZJ8mqj
         mQXOm5NcZqBw4ZoxRS35mPjIoz7wZIvg9//HhqL6kroAubVO6E+0mzqR2XJMCfWNRviz
         +RNO8uu3fikM6YMH3/TyFACWbVERyXmxkcSiROGKzMkPK0Gtlo/g7KiQwIohLrE0rRnY
         9WAZA8Uvt109RQzD/YfG4WeX55XPG0g9EZ2KufcBWhLsHD2eLHZXz9GSOI04/E/TU9Yd
         e8wQ==
X-Gm-Message-State: AOJu0YyQ2Q/0x93ReP7NpNVIh9AqvRewNrOQ03iwYbHIY4h5EUBqJSiF
	LNkOm9yKU9J8G1XYWzSNcAFyKVi4xNIUYpfaYeMwKaSegBtLgLg3ao8i
X-Gm-Gg: ASbGncvohoQ64jekMMOn+oa5VDPGKqvr0tTbyXM+6+WqlrLPGZaTveuS1CWmctGR3QB
	QekF6kAqoLYB6zuvl9EdR/BjaxKMWn6jIeLxcTZ5h5q80YjD72mT+0l/H8vpKRglzEWeiOCOpPd
	Z8M1ME7GqqnYIu/d9Y/G9tKGz2hinI18+o9oTRJMgqGkB4ojtIAaTkYHTNH64DtDEt/5aNERi1j
	YGII9jojTkgYm/2eZ9mKtPM94u9qPmmt8C+yvg42Kd4v6atFpxWAHs9qdhTlkZxUmVQEoAclT3F
	mNYLs9QDXZp04v2rnaGgJTL/+XOXgm5XMjXBz2vETu6a/IvTv31ziGuSjyMiDqZFDh7vLEedYAz
	QYh7m/fGyahHyk2R9WPtlmabN0r1TDy+loGosnV/XsDcQ2BltHF/9SeUarWv1L3Wky76GRgwx6B
	Z2jyAO/kHo1dOoyd3rWG/gww==
X-Google-Smtp-Source: AGHT+IE1hfFHdVPrDeSlhIdBoaTiwvbReDsJmEBsFsJOoLMNH4uCgErVwW/AKE1pXjv0R63O/gY3eg==
X-Received: by 2002:a17:903:b0e:b0:25c:d4b6:f111 with SMTP id d9443c01a7336-290cb65b633mr50748765ad.47.1760714364884;
        Fri, 17 Oct 2025 08:19:24 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:fdc9:5e8f:28db:7f80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a756sm67193955ad.14.2025.10.17.08.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:19:24 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 2/4] net: ravb: Allocate correct number of queues based on SoC support
Date: Fri, 17 Oct 2025 16:18:28 +0100
Message-ID: <20251017151830.171062-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On SoCs that only support the best-effort queue and not the network
control queue, calling alloc_etherdev_mqs() with fixed values for
TX/RX queues is not appropriate. Use the nc_queues flag from the
per-SoC match data to determine whether the network control queue
is available, and fall back to a single TX/RX queue when it is not.
This ensures correct queue allocation across all supported SoCs.

Fixes: a92f4f0662bf ("ravb: Add nc_queue to struct ravb_hw_info")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
v1->v2:
- Added Reviewed-by tag from Niklas.
---
 drivers/net/ethernet/renesas/ravb_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 69d382e8757d..a200e205825a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2926,13 +2926,14 @@ static int ravb_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 				     "failed to get cpg reset\n");
 
+	info = of_device_get_match_data(&pdev->dev);
+
 	ndev = alloc_etherdev_mqs(sizeof(struct ravb_private),
-				  NUM_TX_QUEUE, NUM_RX_QUEUE);
+				  info->nc_queues ? NUM_TX_QUEUE : 1,
+				  info->nc_queues ? NUM_RX_QUEUE : 1);
 	if (!ndev)
 		return -ENOMEM;
 
-	info = of_device_get_match_data(&pdev->dev);
-
 	ndev->features = info->net_features;
 	ndev->hw_features = info->net_hw_features;
 	ndev->vlan_features = info->vlan_features;
-- 
2.43.0


