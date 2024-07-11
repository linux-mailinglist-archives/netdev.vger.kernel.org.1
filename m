Return-Path: <netdev+bounces-110886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2130092EBF5
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 17:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B6AB22D05
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CE816B72E;
	Thu, 11 Jul 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="EBBzXOdg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6715FCEA
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713050; cv=none; b=GGNzlJhk2hwNCZkCTS0QWEWqv/7wwGnK9nX0mE1H8dE4/4TVjJK+vvJ0R0h0z+btle0Sl4WSUP6L7Y0nSza+VFifk6npg9fT3crggEiEUdzBL+lInlYGFpuiakFWH4E3InCnSLoJqBqLunC+skJ2erh+nO/f8C21/wm9oHosvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713050; c=relaxed/simple;
	bh=3mL/89el+rhRaN9IS1k+z/ke72NIbuHdZIg+R/r1m1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rARGvxpwiFIPzEZPr0AGHop/Ak3/StS5cLw3QoLL86fARsiuMXaoFQcOL3H00SCjE7Y5t66/Xv0BBbnPtTElgP9aECPDi+s1fkVHfht10fkudNILBsS4ib6vhy6dOodwOOannguIjXI+2O+c0ZbDCCMvhPOy8cfS/w3jenZU7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=EBBzXOdg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so6652815e9.1
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720713047; x=1721317847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4Dw4V6THcyE3QUs70oD5S2P8RGVzfg2GK1ldgIuQek=;
        b=EBBzXOdgD/RxkDp/iwcF3cWI4ZOsad1q+KS6rxnGasVG1kgUeegia4JCwW2+Ic1YR5
         3S2vHc6zLLnhp48+fy4vFe6+1VHL5ZnH1NtjcaFxJOBfAaF03Ct9ox1s6KC9NvnHyEV3
         5Tv/zIH5FT5BPZCQyrQ3ZbyOAY0DJSTmWKozI8Zh8tAW+CtzfWawblYmfm6RCTxzlnM3
         QvOgT8oQzVyHfoyz9cUFPCO7C13hC3qiAjKBpObZYoyqWmAZ2j/jYG5RMUXm+pWAUnOz
         3FvJgxlvjxJMFtu2RV+Wvc4CCkZc+RTCY+cy770SAmVxrJ/Th+mbL2VTXWTOaIT44cme
         cxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713047; x=1721317847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4Dw4V6THcyE3QUs70oD5S2P8RGVzfg2GK1ldgIuQek=;
        b=gr5HQCm4pCaP4tC4uNH9b380m4E5MYw8RDVJKrC7RBkjysj9VfiHKlII+5ef+52/12
         mnT5F0HCeA/BdZixsUmjVZEzXcLLEBAl5ILjsQ1y+2OKiGyb3OuBFa1uJkXcAiUX5+5D
         /wUGrSopHiu+6AfanLIwcdI8nF832vgj0Xa61BTtaWG7c1GJiHNf6kgw28wfB8e7C1Jh
         0gXmd0hL5ctZ0PN7Md0IzfIPl28mL4wt3jo1+8yQpvDT094d3ZzMqtJJUqAK2tqqLlRZ
         l8xQHMwxjb4blq/azPBvW9LDs5C8bcaruDeofoH6sd+WTFmnAVs80eMBJwJN3tqPWTAi
         vcbA==
X-Gm-Message-State: AOJu0YyuAuU39C1fnNmc+DtsStydpn5c1Q8MEY4zHAB0f2IFxu1Fw4mD
	LVM+rZs+aqaWYmMCTTZUSS5Kuo9ccwNQuJfn69d1xmJo449TQ3OAqUQr/CyZXA4=
X-Google-Smtp-Source: AGHT+IHsIgeeny9WJLCJr9jiWazzei+4vIWuHW0Vft3mOig7QWwiAJex24Zo4rL/hx2YlJrd8uc/5g==
X-Received: by 2002:a05:600c:4883:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-4279da0240dmr669385e9.6.1720713046609;
        Thu, 11 Jul 2024 08:50:46 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42798b63eb1sm32554555e9.13.2024.07.11.08.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 08:50:46 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH net-next] net: mvpp2: Improve data types and use min()
Date: Thu, 11 Jul 2024 17:47:43 +0200
Message-Id: <20240711154741.174745-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the data type of the variable freq in mvpp2_rx_time_coal_set()
and mvpp2_tx_time_coal_set() to u32 because port->priv->tclk also has
the data type u32.

Change the data type of the function parameter clk_hz in
mvpp2_usec_to_cycles() and mvpp2_cycles_to_usec() to u32 accordingly
and remove the following Coccinelle/coccicheck warning reported by
do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead

Use min() to simplify the code and improve its readability.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 9adf4301c9b1..1e52256a9ea8 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2766,29 +2766,29 @@ static void mvpp2_tx_pkts_coal_set(struct mvpp2_port *port,
 	}
 }
 
-static u32 mvpp2_usec_to_cycles(u32 usec, unsigned long clk_hz)
+static u32 mvpp2_usec_to_cycles(u32 usec, u32 clk_hz)
 {
 	u64 tmp = (u64)clk_hz * usec;
 
 	do_div(tmp, USEC_PER_SEC);
 
-	return tmp > U32_MAX ? U32_MAX : tmp;
+	return min(tmp, U32_MAX);
 }
 
-static u32 mvpp2_cycles_to_usec(u32 cycles, unsigned long clk_hz)
+static u32 mvpp2_cycles_to_usec(u32 cycles, u32 clk_hz)
 {
 	u64 tmp = (u64)cycles * USEC_PER_SEC;
 
 	do_div(tmp, clk_hz);
 
-	return tmp > U32_MAX ? U32_MAX : tmp;
+	return min(tmp, U32_MAX);
 }
 
 /* Set the time delay in usec before Rx interrupt */
 static void mvpp2_rx_time_coal_set(struct mvpp2_port *port,
 				   struct mvpp2_rx_queue *rxq)
 {
-	unsigned long freq = port->priv->tclk;
+	u32 freq = port->priv->tclk;
 	u32 val = mvpp2_usec_to_cycles(rxq->time_coal, freq);
 
 	if (val > MVPP2_MAX_ISR_RX_THRESHOLD) {
@@ -2804,7 +2804,7 @@ static void mvpp2_rx_time_coal_set(struct mvpp2_port *port,
 
 static void mvpp2_tx_time_coal_set(struct mvpp2_port *port)
 {
-	unsigned long freq = port->priv->tclk;
+	u32 freq = port->priv->tclk;
 	u32 val = mvpp2_usec_to_cycles(port->tx_time_coal, freq);
 
 	if (val > MVPP2_MAX_ISR_TX_THRESHOLD) {
-- 
2.39.2


