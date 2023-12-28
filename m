Return-Path: <netdev+bounces-60493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE6681F8EF
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 14:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6181C2107C
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 13:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0814849C;
	Thu, 28 Dec 2023 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXwNl9nn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E948881E
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e7aed09adso3469347e87.0
        for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 05:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703771806; x=1704376606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ7gH1YG9dGqvfdMHAwbrq+C0munsf0LDekh90PyWhc=;
        b=RXwNl9nnUY0h0T4P0lHTBa8Desn7hibkzQx5hRCX0uSc4DPmBbeOTn05Pnnc/M46es
         UdP9/YFCyZiek4qHP3GWIzatSLucAfQy3y64SVFuFkYZLZVlNolsIJVv1KNQ1fa3HHLX
         mJUaS4sDUV6ytkdGjIrUUhC1dFXzVaShWCn8ixjwSgB+WYpSvISVsfW2RKX8u5tyqfsT
         WiOZReRO4H5+cPjU+gbV8pgLF4pSumIMIKGvKJvv/81uXlGzA8VrmLC148wB/zoW88dS
         JCAKGsXpt7GLWITER92zObT5cao/1QttAFIf1OtoPFQloTBm2Den+JbIMVbXr0O8CWWe
         dQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703771806; x=1704376606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJ7gH1YG9dGqvfdMHAwbrq+C0munsf0LDekh90PyWhc=;
        b=jx9CHzavtEvA7j6OY6jp30Z24WD/zg88kmUWEe2BF7rDe5RInvwEJgJvKjx5D8WCHA
         /ogiccM0eV9s5iFNgR6d7re7A6Tl3o2xGy1fIlIVv95MCfjhtecnNBB4MVHkBIAnxXhy
         GtVg3tON18CFfdqrBax2JIuXkHIvEIdVs5DmcL7Ku8zoZjTkVabAgbFB7cMDoXQ8Tye6
         BswuXwoXf582be7008Ms94OGTyAAARfEln8f4jaF1dM+sCq7m5RihHcuz0uGO6J4WWz2
         8h9itscpQouyL4NmnTTm13RuROJBvPNbHppkR7bNnE6YgBAiOmH2CML+cBq1sLRvsB0D
         XFRg==
X-Gm-Message-State: AOJu0YzTlf0Vj6VjcOND3wTx5ub/9bo8QF7JXQwrBQ1BuumPMEBxQ+2L
	GP4ECffLTkhH4f6o3eZYDjrwOUdaam7zIA==
X-Google-Smtp-Source: AGHT+IEgfZyr/A1YUxVn3NqQd8GtM7AxF5nqOmvkJs+q8N+G9iKMkyTB89A5OsGfVm+62gs673eJBA==
X-Received: by 2002:a05:6512:3ca9:b0:50e:7410:d293 with SMTP id h41-20020a0565123ca900b0050e7410d293mr4030842lfv.135.1703771806092;
        Thu, 28 Dec 2023 05:56:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:a317:e44b:d780:613:a70:2e46:83ae])
        by smtp.gmail.com with ESMTPSA id dx7-20020a0565122c0700b0050e85872784sm562507lfb.24.2023.12.28.05.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 05:56:45 -0800 (PST)
From: Adrian Cinal <adriancinal1@gmail.com>
To: netdev@vger.kernel.org
Cc: opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Adrian Cinal <adriancinal@gmail.com>,
	Adrian Cinal <adriancinal1@gmail.com>
Subject: [PATCH v3] net: bcmgenet: Fix FCS generation for fragmented skbuffs
Date: Thu, 28 Dec 2023 14:56:38 +0100
Message-ID: <20231228135638.1339245-1-adriancinal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPxJ3Bdo9jO_UuA2V1p7sTTdcObGC8VtufDu_ce3ecSF47JpHw@mail.gmail.com>
References: <CAPxJ3Bdo9jO_UuA2V1p7sTTdcObGC8VtufDu_ce3ecSF47JpHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Cinal <adriancinal@gmail.com>

The flag DMA_TX_APPEND_CRC was only written to the first DMA descriptor
in the TX path, where each descriptor corresponds to a single skbuff
fragment (or the skbuff head). This led to packets with no FCS appearing
on the wire if the kernel allocated the packet in fragments, which would
always happen when using PACKET_MMAP/TPACKET (cf. tpacket_fill_skb() in
net/af_packet.c).

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Signed-off-by: Adrian Cinal <adriancinal1@gmail.com>
---
Differs from v2 in that now the flag DMA_TX_APPEND_CRC is set for all
fragments (so as to be in line with the specification requiring the flag
be set alongside DMA_SOP).

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 1174684a7f23..d86e5da6e157 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2140,8 +2140,10 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		/* Note: if we ever change from DMA_TX_APPEND_CRC below we
 		 * will need to restore software padding of "runt" packets
 		 */
+		len_stat |= DMA_TX_APPEND_CRC;
+
 		if (!i) {
-			len_stat |= DMA_TX_APPEND_CRC | DMA_SOP;
+			len_stat |= DMA_SOP;
 			if (skb->ip_summed == CHECKSUM_PARTIAL)
 				len_stat |= DMA_TX_DO_CSUM;
 		}
-- 
2.43.0


