Return-Path: <netdev+bounces-67460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D7A843960
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DF8BB275F1
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 08:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A4C6027F;
	Wed, 31 Jan 2024 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="T13fc2CK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FB16350B
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690514; cv=none; b=D90MEYI4MQ4qoHnpbpt0uAPiIcEDCHHzAPRmLkVRYtWVWgTvIqIBB1ubbgwsrBAcXFnd7Fz9MDYfAtOytj9E0q0kYPRgZXdJpz84XYhFKvmaTfMxFeIEwU4l7RFxpBAlX/3YydvRJY8JGIS1DCAAZwEu/P/MFYbjtkfWJfSQvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690514; c=relaxed/simple;
	bh=DYWljhVkT6KFyv0smmpo8+LSYn9vUohjIj0Lmz3vjh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QttkZAtCzxUcKZJVEbB2ZBIhDIK3hammbRsa7SLlPheK63E6NkO354EdF+GpWbv2mpbKXVtxTfHUfcNFrSksu2Cj29A/XMhr8/3fIrqUqWGQ7iPVFmnkDVFIbJC0LPBQy9sgliuCsBhVCkmMABN06oxymHx5heIAFabT68Rt2LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=T13fc2CK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so5907817a12.0
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 00:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706690510; x=1707295310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaQ1tM25xxhSkLymulSrQ/sxhsU4Dz/iC9pZh2/7m5Y=;
        b=T13fc2CKmbKiLV8ntMXOuzMWiM9L3y+2eMYv1/FLeNzzWbbeFI3nFFeAypeFWngDzw
         /xHLmfPdbjANmPnXOp3YdwO0I63JgFxIq8O2MqVAe6fiyrdeB+YQ0FXv6+DY/e1NJ2lw
         8kLhQ1v/Huhvu8faQm6YojoB1hzq1s8rPSP60dF6IF0BRVUjfNdtF3mf+x+m0IjFt6gn
         rk87Bj1GCNrtGns4Cdxr0Q+oRocuRpBrahh/FB2yCa7UFXUdvEKcs96527LY1DgBk6U+
         YBw5iA0qQbebfA5B6uAIWiFo1vSONRrnsz/gQ9BFYojdAKMT3bvkoNO3iXAu0P+SzxJZ
         h9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706690510; x=1707295310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaQ1tM25xxhSkLymulSrQ/sxhsU4Dz/iC9pZh2/7m5Y=;
        b=kI0w11GgcNPNXAYTEe0p60i4UUJLqv1cFxd7wAo+SK9OXxePXMp5kA2xq+y1MUZHVK
         ren7Vz40qKbpxkgDGyueU74zNm3C9xjPF7xs3t+RRkhcSLAisrkR8K42fbefVUAPSPCZ
         va7NOVnlI/yQPEka9NGMXllizMPrGzN2PuCsLt/+lC8s8bH3d/eS4NyN91Ce7R0ubxBu
         zJjygRgvMdfvS5vzMlG1/ATKMdrzLYUAeZjPENj/siZ/We8MwaLXaBTAnQPWQJZSsrWB
         KtdFQqg+aGOAVEg7InYJF8EG14l0xEgnHcfTGjbCVkdWNlatrnvt2ngYTGlnfLy9gRGk
         MHIw==
X-Gm-Message-State: AOJu0YySlHd41zOfZVysSq7pEkaV6FYenlN/nqr9UXa1lGI5MwL6OgCm
	To9c9ZSE5t+/0wsvApN9XHNF+rPuC7+LRjUwKPQNxPsEJUIPJ3Aa+7kwf0R2hbY=
X-Google-Smtp-Source: AGHT+IF5BkGFz/B9L2bagBNqDLFe2bl641/IcLpz4A4txk1UEazfadsTjRphU/mfT3oGj/T96KNrlA==
X-Received: by 2002:a50:9f89:0:b0:55e:fdf3:d440 with SMTP id c9-20020a509f89000000b0055efdf3d440mr558641edf.39.1706690510118;
        Wed, 31 Jan 2024 00:41:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVILS4ofhnJK2GcMawFhlhzzqgG8pnSa60pPFIYUZoW3krIL0pxFlmGRFwyR8iEW5S079Dwnn/bWZdRqsDKI+8GvRuMC5EqTkagEnozBI9FsMSbGifRxz+Iqv553HiNp1XRnWZPSm5uiaWphDAjJDOVFQSP6awKxlX274xeUJKl+pwXuebiC18yjRxtWvdyYe2VWTs0Bf/zTFTWXdSzbCmDvmh2nUyko/y5knR1VeSTV4y183DNEc3+3gkIfwcoDBCtqGQe7emxO9/RH1vw3PXZ2D58TReRsiFAGCcp5NtObp9/Q8je6HKXD2CgOMOh5mqo7IR4RQ3YqA0U550qH0qdoYfD4wKuttguCN90vmuaXnbG4fUIxbINhP/bxx2m/T/gbTwgM82F/4ENbLvQhWXCOZORtSivIi9aJh1OLsNDlTB8jeg=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b0055f02661ae2sm2863630edb.78.2024.01.31.00.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:41:49 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v5 03/15] net: ravb: Make reset controller support mandatory
Date: Wed, 31 Jan 2024 10:41:21 +0200
Message-Id: <20240131084133.1671440-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On the RZ/G3S SoC the reset controller is mandatory for the IP to work.
The device tree binding documentation for the ravb driver specifies that
the resets are mandatory. Based on this, make the resets mandatory also in
driver for all ravb devices.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Change in v5:
- none

Changes in v4:
- select RESET_CONTROLLER
- dropped Geert Rb as I changed the patch again according to his
  indication
  
Changes in v3:
- none

Changes in v2:
- collected tags

 drivers/net/ethernet/renesas/Kconfig     | 1 +
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/Kconfig b/drivers/net/ethernet/renesas/Kconfig
index d6136fe5c206..b03fae7a0f72 100644
--- a/drivers/net/ethernet/renesas/Kconfig
+++ b/drivers/net/ethernet/renesas/Kconfig
@@ -34,6 +34,7 @@ config RAVB
 	select MII
 	select MDIO_BITBANG
 	select PHYLIB
+	select RESET_CONTROLLER
 	help
 	  Renesas Ethernet AVB device driver.
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 3181fa73aa32..fd431f1a0b98 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2645,7 +2645,7 @@ static int ravb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 				     "failed to get cpg reset\n");
-- 
2.39.2


