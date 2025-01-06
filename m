Return-Path: <netdev+bounces-155329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07824A01F31
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 07:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7344118834D1
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 06:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74924194A64;
	Mon,  6 Jan 2025 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+Ke7KRr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0784B18A93E;
	Mon,  6 Jan 2025 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736144938; cv=none; b=NDWM4OVa9R4kuZ1rTWzfOzGqNMssvFznVAUZKfm2TtewhClHQofZWLc9svXdQ8VkPNTGbQKD/eEQeJTng2BQ8H2mRrI04s4PzlJwhyoiYyYF8EWD0X2qYCqT+aCn49PA9eXQpL2Q6O8AtCv5jpSe+2pZOvMK1PxC6xhvFq9E8mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736144938; c=relaxed/simple;
	bh=jzlZ1hAj0MMDjK6pOpGAVHfUJNi+ZkSM3YceAp8tZkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hadg/7OJTQ6+p+6aZcStdBZ45M4EU+UqTOOXpm2g04dcSR0/ekiqDLk9CQ7TmWWodY5+6/+p+IeMOdV/0TVI/2oJJtJakyo8V2MCBAkdHjQGuJnl9z2GQzVJMC2xsFqg40qBGlPJnk4idP/oRf0ogw4BAawqUH2r94ytdLpLrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+Ke7KRr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so20233342a91.2;
        Sun, 05 Jan 2025 22:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736144936; x=1736749736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tYngp+0tGgTHKQ6I1Sn7h1pVz+z67CiGfUZ8/I0y7MY=;
        b=L+Ke7KRrP06Gap9bGHHeabFdYCMvYMPyIZNAcD/n4TIWJQXIhdLhzTJPHipO66VvWo
         BxMv3tHCeNHPKSaWd7at2VYnqjnqB9WRYRNB5AfWjECD+T0D4lnM3QJ9xrJlyzmUPjkQ
         xpSgrRKgKhVB41yXPMNvVlEu8PGhsqmRAQxASNzxcJEXllZsX3RrLKPwsN0E/tphjGWC
         O5S3d/ZDBjbOXnSI24SdQRBo689pHxSlzJoZueezvVyDIB2kyPEW0dLrmBEvc1K+43tJ
         ENuCBc9vKIzzMl95cDl/42nVbUQ8IpG3IkfZixR8OKfkw/VFTNWpnKbNaObTCyjNW3eB
         K4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736144936; x=1736749736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYngp+0tGgTHKQ6I1Sn7h1pVz+z67CiGfUZ8/I0y7MY=;
        b=v+ujOznF+8sR7NzvAeUPeDTknlSjR/I2/bRwNaHERg50F5PilzyZpjlwxjocl7/ZF3
         Dv2KqAjLesL+/BYIoUdj/1PEqpdMYAlXC6f4SVXalMx0GTKQ0bLOMbgYBC6XVt3ZauY8
         m1++C7htg4eitMoy2bjaBYBxcqp/Cu4gXapU5PnXgLmr4zVGj2b+jCTL65VvYY54fGlq
         kX/0iFFXy9cL/yr1R9JNPXgmWchWDf29etb6FGyNIMQWZ4sLzvf6yNAL8ZpZBIH8S99n
         rmByOvFPU2Jri1DFZ/FFEJ0Pqus2Vc54YyMXito/ZYhyLIFqJHOC9OBa732J4yFkxfp6
         wcsA==
X-Forwarded-Encrypted: i=1; AJvYcCUOGS4oTi/ZHQmhUBcc4q4KNvtos4XTnPuMEQ4HZ4Pc/8JSSG3ZPNVCxEtjMkunPDV4klE7/152ppUlv8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3OilWF454PAwg/PLDbQAj7jCk1ssj4gwh/l0zQQAQjEeK+E1V
	W/oq9RZ8dGKeeU3VypeFBavZvqr76IWrRgSkh5h29Vj5QMaMtZGwdn47rA==
X-Gm-Gg: ASbGncuzhFJn3CjXQEUrNG6LsFW9LRtQSY9lmQkTGg01skZU5rBm63zdVTFgwjVZuqQ
	tEaQXKRliuyMGdFVRfbOH/TWN6Mum3GHZ0Vbt8cXIyG1P5iiSdHiNStqYHhAfAhzVt4YU7zIY5b
	iK06y4aQoab4rZcnQg9P9Vukax0m8BeuX7tMPNQ60fQfbElT+Er6yrCaHObBksXv1BDMwXfE0oa
	URsmgSLE9hg68udlCj1lyIUkg00RhCWGwfsBUU8Y0/RqWhXfcJ7+Q4HuWsV4bBImcBX5A==
X-Google-Smtp-Source: AGHT+IGuTNnabIlYRQUcGvQBWWJUxIneQ+plJz0/THIdtZNbQlkm7E3w2PkIyku4BmKuXXI3eBVv5g==
X-Received: by 2002:a17:90a:f950:b0:2ea:5054:6c49 with SMTP id 98e67ed59e1d1-2f452d258bfmr101856874a91.0.1736144935767;
        Sun, 05 Jan 2025 22:28:55 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62cddbsm38807091a91.15.2025.01.05.22.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 22:28:55 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1] net: stmmac: Unexport stmmac_rx_offset() from stmmac.h
Date: Mon,  6 Jan 2025 14:28:45 +0800
Message-Id: <20250106062845.3943846-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stmmac_rx_offset() is referenced in stmmac_main.c only,
let's move it to stmmac_main.c.

Compile tested only.
No functional change intended.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 8 --------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b8d631e559c0..548b28fed9b6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -416,14 +416,6 @@ static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 	return !!priv->xdp_prog;
 }
 
-static inline unsigned int stmmac_rx_offset(struct stmmac_priv *priv)
-{
-	if (stmmac_xdp_is_enabled(priv))
-		return XDP_PACKET_HEADROOM;
-
-	return 0;
-}
-
 void stmmac_disable_rx_queue(struct stmmac_priv *priv, u32 queue);
 void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue);
 void stmmac_disable_tx_queue(struct stmmac_priv *priv, u32 queue);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 99eaec8bac4a..37b21d2d6f4b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1308,6 +1308,14 @@ static void stmmac_display_rings(struct stmmac_priv *priv,
 	stmmac_display_tx_rings(priv, dma_conf);
 }
 
+static inline unsigned int stmmac_rx_offset(struct stmmac_priv *priv)
+{
+	if (stmmac_xdp_is_enabled(priv))
+		return XDP_PACKET_HEADROOM;
+
+	return 0;
+}
+
 static int stmmac_set_bfsize(int mtu, int bufsize)
 {
 	int ret = bufsize;
-- 
2.34.1


