Return-Path: <netdev+bounces-184131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8680AA9367E
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8771B60AED
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C4A2741CC;
	Fri, 18 Apr 2025 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPM05IST"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960131FC0ED;
	Fri, 18 Apr 2025 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744975497; cv=none; b=kEHuebHiu/fNVXIHAlkyMQf4ues7J3tx92ZNKq/LI/jI6OhglfXYDXrenHzA7KUZ/SPBwuTAgN53ALmynM4r2lpGROee7sb8GnfIC4JUGwsPmyEezy6lTycGZzcKY3ATyPvywUHggnQKzazdadkBbBolbRwEQpbA3C7Onr65YR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744975497; c=relaxed/simple;
	bh=QdJJGvEiz5pjNXqTtarXbU7YwPu1LSLqeT8h32rut74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OSqUHsVgMDYcv6L6HC95IQiinoJ2YZnKxy3EbZEQVW4U9cHEUW8ACPA7CnxaGC5mYlohHz7fABX0FzB5xgemc4odyESfuZiT9UkKZ5MDV534WS/el6R8I9rUadsZOO25kRaAPN4xPJwHPDwJLZJRrf9QmSoS8uPUJT+tTvac9oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPM05IST; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so17079575e9.3;
        Fri, 18 Apr 2025 04:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744975494; x=1745580294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W//o/Ys/rBW7MLdSpGEG/ep49Nq5wGldQX5Bh4Q01DA=;
        b=TPM05IST9GkwrNSB4SWmZZUru0S3vd4JyrfJr4sRO6IxX22sHmlu4Xn1KQRD3gM7BT
         PCeq5+jfDRG4zszpX/a8s3g+a7CwkBA/HFUBroYTcoNOa6Qz8MI5NJiR/cw2hu4BALTA
         6rqIxdIlbsYhkwIlmicHgiagrkqetZSVNf84LTipNTKXuIf6R4taEc9OCByV3Ul+Bocu
         tPSgNtnFpOBAEmoaxv2vCTm+MwDbLtqcGY0RjlsIOqiHIVauPMy+GhWtLRaho37l0uhV
         I4dqL0k0KB4Q80rSBakoscleBH7SF0Yx0mATySUPMTAwR3D0i8kxqt97K+z76pqhxKpU
         7W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744975494; x=1745580294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W//o/Ys/rBW7MLdSpGEG/ep49Nq5wGldQX5Bh4Q01DA=;
        b=Og+GX70drqsdUoDk4iqg0ReGkSGRqYe/j9FYFNR2hhcue/xNu2d1y01EMz0zBnZlkE
         JcXN0ahCxlGuDZZfYtBWT1R8WSJ5gIzs6kBvS9M3ibaMeuVsU0F0JtRsoxTuZNLOAn8m
         f+Qh9HM73ZSwWtQU7vL7ZLnryADKKJvA2tHGUO9UZS315FLY07wMK1l3aEjArrecVf2P
         xyqsDldx5qSiyyT46xT6vONWMg3IYNZJ+yq2eciOiriZSSKiOq9jHzp8W2rCRQ4vMylY
         G2N/MKBCx5f83rvSXZuj26eKuLI+OAlyWfGq7geyXJbZUkE6aDp0QuTgZ+2reuF4N+Oq
         V0FA==
X-Forwarded-Encrypted: i=1; AJvYcCVd9E99TJS3XXmnCwyNw8U0d4h9/vJ/02FT39CGtBLViGmZAufYOBeDBrnFjFg5SpcF8nVUKdSfyQl/zgY=@vger.kernel.org, AJvYcCXDC0I9sgUR0yY2WcHHKYPLyyBpOv1AhSaoV4XHuYSDQ7Z/vHfoxyt4RQbmKOmcgMhR81tQ8MgR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+qjidytCW4eBsxTgVFIvxV9R444ntPzYHDNByaxhsilQ719s
	mBAWNolpkEeUJD+lLZsuf4dZPiRgNQdpPED4kzZYiCbuF/tro8AtSx4swRwl1Ed1uQ==
X-Gm-Gg: ASbGncuYYT9KI3prqzOVzRBkFICtMsHWay8XPQAUYYh1gUFd0EA3f3S6ecRArhZCWDZ
	Qh/aRn2vI+HsNOa3LkGUCSj7SMXeHjr9I/KftGmcR5yH7EQvaJjQh9sJo++pmvXTIS6Yn5cAV5w
	tZ6cEHj/nAHSbPH2JrT+bwndRkwLJgFL4ytxKfx4d/+r24WQGRDG8nfNAZxIZLNTAFLyU+g/iOE
	y203kf2voWg31csFshKDRJg+/vUzX/uT/1pyesm/3bWLqbtgUKM2EVEknn5qHzie4bYbwZ/toGV
	RPIq3gkRY214wWEZ/nuAXsrUbYxYy6VnrtrCxsRVQg==
X-Google-Smtp-Source: AGHT+IG30iTqc/o70q9K2Hbdi1h5RZUfJobP4PRf5VUTOWgsiua+PVOrKWb3LlV6dsQiTSdoLK3P/g==
X-Received: by 2002:a05:600c:c0f:b0:43d:7588:6688 with SMTP id 5b1f17b1804b1-4406ab93badmr21238555e9.12.1744975493673;
        Fri, 18 Apr 2025 04:24:53 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4406d5a9e0esm19272115e9.5.2025.04.18.04.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 04:24:53 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: axienet: Fix spelling mistake "archecture" -> "architecture"
Date: Fri, 18 Apr 2025 12:24:47 +0100
Message-ID: <20250418112447.533746-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 054abf283ab3..1b7a653c1f4e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2980,7 +2980,7 @@ static int axienet_probe(struct platform_device *pdev)
 			}
 		}
 		if (!IS_ENABLED(CONFIG_64BIT) && lp->features & XAE_FEATURE_DMA_64BIT) {
-			dev_err(&pdev->dev, "64-bit addressable DMA is not compatible with 32-bit archecture\n");
+			dev_err(&pdev->dev, "64-bit addressable DMA is not compatible with 32-bit architecture\n");
 			ret = -EINVAL;
 			goto cleanup_clk;
 		}
-- 
2.49.0


