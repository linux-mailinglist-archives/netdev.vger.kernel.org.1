Return-Path: <netdev+bounces-48744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9697EF675
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08929281133
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04AA19BAC;
	Fri, 17 Nov 2023 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="yc59Asu5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80875A4
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:44:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32f78dcf036so2076488f8f.0
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700239494; x=1700844294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViJzBZRjaGwQoSegbb0M2YrA8tvFsmfs+BtclsFM6Iw=;
        b=yc59Asu5dsxUDXwsCNPO2feuNhlmEkKtQFV3Nkyf/5dAVjlyTb2Y9dIfbHwdRQvQ3B
         6Ei0ynY4CLUt9d5N83otKNQKmyxe8HIVgOI9EHS+tjOikFI0rDCc1vG2e9hlVsOw286b
         48Su5hOIOlVAxMNdyVYrUCRbSUK49vKAfDM5SMdk4EJzdTDNxxEbcltwsTA4RhzJnp2p
         miWF32rG/3wXRmUkNJu9umD9aS3+i7tRchkcjudCixljYMMvgH/hvnRbYD3ktjcQ89tw
         6d6z5xige0DaExYmSwy5djDSUFQr++l3euX3LD/j8e/D2MWIW5O2EMZOV+O6vSh2lYaE
         6vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239494; x=1700844294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViJzBZRjaGwQoSegbb0M2YrA8tvFsmfs+BtclsFM6Iw=;
        b=jwz2EM+XXlccAbG11sclEcNRO4o54KhI4bIH1cO4g49NLTeRXjwtZmwBdjrzWJ2aIq
         so///lZdwRihohLzlzemJ/rEIND3EbcrkcUZL2IYawLVxfdki0etQQbzsuLz6pwgqDJg
         ZmA4wPxnRDOQbaAQZyfluF4SYB5pndXczVPAPxP3fUCW2EEW5D7xr7m+eWa7FUtt97I3
         XrA26qvztxnjsu6OGvHhAfMZrfmo/hwETujveBmbrmluTV9L7XRpYNRzmeEAxNdHuRmT
         ue/POI25BBjlV+Dr2PRTili9wLmZ7BUKwJlJ/8KwAxn+aM3zeL3dTNFjhftIU60aaGaE
         WswQ==
X-Gm-Message-State: AOJu0Yyjk/2jqt1GGq+uF1XVBEcVz9Vmr4f1PzOPNlbLfVtGl/lso82N
	s5PnSEWUaEbDu9OJNsCaCao4fg==
X-Google-Smtp-Source: AGHT+IELqDZJhNF3w4cCSF7Pe3KNy3G2/C2ag2xOQm2boFEouK1cJqrXmqQKscXXkk/+QTrSuuJpjA==
X-Received: by 2002:a5d:47ab:0:b0:31d:caae:982d with SMTP id 11-20020a5d47ab000000b0031dcaae982dmr5929283wrb.12.1700239494093;
        Fri, 17 Nov 2023 08:44:54 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8a96.dip0.t-ipconnect.de. [79.204.138.150])
        by smtp.googlemail.com with ESMTPSA id y10-20020adfee0a000000b0032dcb08bf94sm2791947wrn.60.2023.11.17.08.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 08:44:53 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next 1/5] net: ethernet: renesas: rcar_gen4_ptp: Remove incorrect comment
Date: Fri, 17 Nov 2023 17:43:28 +0100
Message-ID: <20231117164332.354443-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231117164332.354443-1-niklas.soderlund+renesas@ragnatech.se>
References: <20231117164332.354443-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The comments intent was to indicates which function uses the enum. While
upstreaming rcar_gen4_ptp the function was renamed but this comment was
left with the old function name.

Instead of correcting the comment remove it, it adds little value.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/net/ethernet/renesas/rcar_gen4_ptp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rcar_gen4_ptp.h b/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
index b1bbea8d3a52..9f148110df66 100644
--- a/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
+++ b/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
@@ -13,7 +13,6 @@
 #define RCAR_GEN4_PTP_CLOCK_S4		PTPTIVC_INIT
 #define RCAR_GEN4_GPTP_OFFSET_S4	0x00018000
 
-/* for rcar_gen4_ptp_init */
 enum rcar_gen4_ptp_reg_layout {
 	RCAR_GEN4_PTP_REG_LAYOUT_S4
 };
-- 
2.42.1


