Return-Path: <netdev+bounces-188871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C45DAAF1BE
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 05:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD371C2007D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3107D1C3F0C;
	Thu,  8 May 2025 03:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOixN/Uw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE8B3C17
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 03:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746675246; cv=none; b=uM/sZnAyJ17EqT8tDA5llruiZS/6rx2l3WuVAsaR9arNlijlZTwbAAa5FxEpVvckdSuQckDCJwCzpB50wFY5xQwdGFYK5rye2/CDsdv9XRjr6OY5yFNZtDk5wJIhYUElkXNndXMbh77pGkU9nhxymm5ldDZtr2VvC6kn8r6V50k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746675246; c=relaxed/simple;
	bh=kCJqAjIU0ry9eLlNXVWaaxQq8TtxTBp1ZQecwukQn4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KNPzU06YEhxAILeiSMp5bgZzQ7p/zsmnWbIAuL50IU04be/2hg5Gb3hr5sWyTZQEwMU+yE9My7IXsnb8nLIVdcQYmX55T4XRb3WIzSMe6+dyf8+mYyOmoNdTf4gxZMmn4scnpbwpyktk8SLTg4B8r/oWYtzu3SUmSdRY1bAU9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOixN/Uw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22e730c05ddso5549595ad.2
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 20:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746675244; x=1747280044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnqWMDDLX0zek73pfxqndK/i6Uy2ZObuxOwIQcQSRF8=;
        b=XOixN/Uwi+paH526P5QGnK3puTDMLhWOg1FTEPSczgQtXqV3YLX3OgnfailpYMu+FG
         mNI7IsH/TtWFkHcvQE/1jAWWQJoFHyWvulZh25PGay6p3JevKWx1lXdiX+hZh8tAx1GZ
         oXPbiXmT5Q4FT0vKHptRiPl+mcPl0pxj3LQ0iFRJZiap8IdA65saiioqwc2rpPNggaSA
         d5OCsAhU1sDU0EJCWniig6HztDxluT+qRKRXkR97dqHcBmpzFPz02hL+94dP2KJGBudk
         9KM0zwuGk2z/lQpCTHw1NxCyThPgs2ut6XoZOrtbLX1ZmoNlgjD1ig2LomFe7LhYyyuC
         UcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746675244; x=1747280044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnqWMDDLX0zek73pfxqndK/i6Uy2ZObuxOwIQcQSRF8=;
        b=BKKjGoN7Z8h0KW8unZTDTzp9kXTi59qLIYGkgIq9lae61wCzm8G6V5cuoqaEJ7AsGc
         uubJnOL2dYcUsvhxkJUcfAQJvJ23jrQUP3IPQKIUBl3wloweByXwfj4S1jZCUx00K4UQ
         fc09002bwgX3/rWouexEk12EBXAFthjZ0ZiE4cY4NVg/EcYgn3zXmMnjsMwUM9p/cCKj
         Yegy6Hr+8O4U1xfgNFTCZIsMMTsyYG2Uj4fmpUIRHoDD3DSVItgtXATNtwGu9REWw+d0
         nTtnf/blNjTwPzJp2IKge2gKczL2b/rRCmOcK1uWz/w24OlPTLzP2n0VADiJoSnlVySP
         TdWA==
X-Forwarded-Encrypted: i=1; AJvYcCW/leFIodzCbA7yNeDmkOQtUbhT2AQ6z6fPrJZq18zhc6acUl32KOZqW7PC+1gKIGSroATfLxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIo0RsO5oPHG6gSDnMETN0bR6KrRnCdrUv43TJh9mp3PY7TkYN
	0vb05NHC8Iwhl0RJ72Kv0mBPk7NRsi4ejgzwxuy5r6xuUePDnlpC
X-Gm-Gg: ASbGncsIIKpYA+mZ1SydoAHDqicxm17oFawJ42dXvSgwX4CQgwpmvan7cH8kL7celXV
	/3Vf9ajyqmXL8WUeBlzlXtP15xUgPHM+le0aFwvnZxfFPtI87lKw8TgGwVrLEtcJA9vTtom5ldt
	Hg0S/Y4m1ZNdnoyF00QBH6IJnQ3hvhs2eJCCruU4psNsYPYfHx+D6dW4q9RKgS+oELSacaIeGto
	AePtaxfEDh3HWB0SIfFZRyRcl18MMrsO7TuJH7xc+UG8MXw6GjnbGJPZP7JjaegaAsCX8Szw5tY
	SAq4QgsDGUkUpfBsAWc+XeHVkuHok2O2iMlmWLq8CFrz9QyfFMutgRgD4Kk29KEiLrdtAhn6f2A
	8alLoVoVxf9AO
X-Google-Smtp-Source: AGHT+IHYy+mhyOHuKt40kiRvSHcNeUMG5kIZxit9o8bCQPyY6xTpD5PZVHoUSN9mxt07Kxvd/al06g==
X-Received: by 2002:a17:903:252:b0:224:1001:6787 with SMTP id d9443c01a7336-22e8560cf2bmr29009925ad.4.1746675243855;
        Wed, 07 May 2025 20:34:03 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ffdsm101685265ad.179.2025.05.07.20.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 20:34:03 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: irusskikh@marvell.com,
	andrew+netdev@lunn.ch,
	bharat@chelsio.com,
	ayush.sawal@chelsio.com,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sgoutham@marvell.com,
	willemb@google.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v1 4/4] net: lan966x: generate software timestamp just before the doorbell
Date: Thu,  8 May 2025 11:33:28 +0800
Message-Id: <20250508033328.12507-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250508033328.12507-1-kerneljasonxing@gmail.com>
References: <20250508033328.12507-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Make sure the call of skb_tx_timestamp as close to the doorbell.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 502670718104..e030f23e5145 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -730,7 +730,6 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev)
 		}
 	}
 
-	skb_tx_timestamp(skb);
 	skb_push(skb, IFH_LEN_BYTES);
 	memcpy(skb->data, ifh, IFH_LEN_BYTES);
 	skb_put(skb, 4);
@@ -768,6 +767,7 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev)
 		next_dcb_buf->ptp = true;
 
 	/* Start the transmission */
+	skb_tx_timestamp(skb);
 	lan966x_fdma_tx_start(tx);
 
 	return NETDEV_TX_OK;
-- 
2.43.5


