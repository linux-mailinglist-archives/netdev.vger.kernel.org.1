Return-Path: <netdev+bounces-242085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D27C8C227
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03F17356D9C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DB533FE34;
	Wed, 26 Nov 2025 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yd4j+KzM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3135D334C34
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194271; cv=none; b=mUZZA4RA4rp/Gd6VyPH0ONipj4cJ3NrRRuL6meros3jz/GH20c4Zcjn8afLvvxrZWiAf1nB64MDu9WTXleiF10TOG8In0ryBvlw+uS6FBYCcUxMp0+1ojr2xtBVF5TK+mxNyzQRGkOZDZmYNkoRFyD113vXysVqGb25+Q1ZLU5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194271; c=relaxed/simple;
	bh=g4kJWCLMKMHWchS7uAAUwUKliHIoKbZjV1y6U+4f+G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzZchbzQAtakHeFAix3cXC3dX4bU9YtVxZ8omwn/6FDANyp2dx+R9AfJMpP5owrQKDeqQlQVwug+nFrRFFtI6wEWPcahRg2Jxy6dnV0FpwH/SRlRgWmCmNZ5sfX4KaT5udULxvt4lkKJ9ZpfqMrUhb1KBhcY4m28etqleOShSN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Yd4j+KzM; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8b2d32b9777so27231785a.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764194269; x=1764799069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gu41YK/IH7Ii7HtIXx9rtdcjuQNf8OJ2RDu+ucLLT6M=;
        b=JxlS9nx5C7WsAUHgSA3FsGgs7drQNSdRY9pQ2J6OqMYPCu7x/LnOYldZKXaqXI1yKL
         QCDY364w0aRROsDxUcTLa4ExNEujH/bWwIFZD/zx3Lu+AE7PH19+b0Aj2Nn4tjmL3exL
         Wvxf95U2j7EdDlHkGQz+bUoxcicSbXY3Q2I+tLgrdXkPCYiXDIsgQB8E2YcyDWDtUEf3
         cgCFvXgQYvWNZqUwtYJ+8xYxzq/o3bDnRWf3IjjeT5Exv8FM7v8zhCccElNw4dcHidem
         Rk6m7DOlnSg9/5yJy/JPp+xeweSYparOs1LjiNlErCW7SWr7uIddCVGsm9cd2jcPLa6V
         AHFg==
X-Gm-Message-State: AOJu0YytQbdD6WbMVLMClbV4cDuCyVUtzyUHAF06On3wAD8sOZUASj5k
	HnQ0VA7xq/1rf5nGaFFYDmSmb57+rlQgpi0O1v2MIBZ8DF930c8hV6Evz0dwtAgXDSHxm+ahYmz
	d0uTLunLLcSMoNR1JWkhH+b2xGLDpWeh2YXou5MtqC2xNUg8lDq+8eJ0eGKYaVyeV4PK6Dcdlgg
	mrU/zRyA4CWshIspDAapd1fl+9oj4edSG72vtAceFHK+IAiyui95IdsYp2RtQChPyEttNBj8dBW
	LgaCDFJP+4=
X-Gm-Gg: ASbGncscMFvoLwmzCAVNMBkthoCzrHvOVGBMjw/mq6XHR2p+NXzo7LiWWIJCGmxk4Qm
	XGExMEg7P5y26IeEqSXEncWAVesLwIwY6eb0lZPR32CZmtYuqIfFv5AqXw1RoCHOTM3GjH7jBjh
	QlEJYITBSD07Czws09oltDO2t78xWb/0ZhPreIgL9jm4ZsaQQLFTbN8te3IvlkBzEUvaGeOZUKi
	DStEuDiQ70wFmppImmA7Vp/adfxViybjJ8aLSl07aBrvCEc3aK248hQtaQ7JPBuJH0BEz7GyM6D
	k2vqn93o+ruEuxXbM/jTzAwp8egTtGOyBiY5Bo4b0Dy4LsNgjfJriczY4v5QHCs4BsSYodE0Xe3
	P5Rg3gnn4dzu/Y2AdvejtTu2c6jB5TzFPjKeiFpqN/G4bXz7kYCiHG8H2KBINSjUC91MYXfWlbJ
	vdbmS2qoYg4mnztcY3tXPl9QactziEOgKwHmr9/RJ2rCbK
X-Google-Smtp-Source: AGHT+IF4KfvQSjOl5kVkoBLK8QrGKfv8vPu8Gf+a/Q7T7bhx1mpTwEaRK4cP7VHox9rNrxqZ3J+qujWzN2/O
X-Received: by 2002:a05:620a:4446:b0:84d:9f49:6898 with SMTP id af79cd13be357-8b33d4cad9amr3048747185a.61.1764194269038;
        Wed, 26 Nov 2025 13:57:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8b32957eac4sm210990385a.3.2025.11.26.13.57.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 13:57:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2e235d4d2so53960785a.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764194267; x=1764799067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu41YK/IH7Ii7HtIXx9rtdcjuQNf8OJ2RDu+ucLLT6M=;
        b=Yd4j+KzMkapKcEBIcGJ2DZWx/BRtGo33PNygBC7Px53WQfL6mBt94S/TBVkm5NJ6P3
         rgKRf1EY7CKqhLtjcd93I8pzebW7XleiYi3wUB2HeY99h4OvMxqnbLfsY+l1qNFMIRaF
         W/U022xyGEfxDkpYqRheoxVwr06pbRaWJOS/k=
X-Received: by 2002:a05:620a:4484:b0:8b2:ff63:d6a6 with SMTP id af79cd13be357-8b33d4a73f0mr2815874285a.56.1764194267650;
        Wed, 26 Nov 2025 13:57:47 -0800 (PST)
X-Received: by 2002:a05:620a:4484:b0:8b2:ff63:d6a6 with SMTP id af79cd13be357-8b33d4a73f0mr2815871585a.56.1764194267199;
        Wed, 26 Nov 2025 13:57:47 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm1473933185a.37.2025.11.26.13.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 13:57:46 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 5/7] bnxt_en: Do not set EOP on RX AGG BDs on 5760X chips
Date: Wed, 26 Nov 2025 13:56:46 -0800
Message-ID: <20251126215648.1885936-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20251126215648.1885936-1-michael.chan@broadcom.com>
References: <20251126215648.1885936-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

With End-of-Packet padding (EOP) set, the chip will disable Relaxed
Ordering (RO) of TPA data packets.  A TPA segment with EOP set will be
padded to the next cache boundary and can potentially overwrite the
beginning bytes of the next TPA segment when RO is enabled on 5760X.
To prevent that, the chip disables RO for TPA when EOP is set.

To take advantge of RO and higher performance, do not set EOP on
5760X chips when TPA is enabled.  Define a proper RX_BD_FLAGS_AGG_EOP
constant to make it clear that we are setting EOP.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 ++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7df30019c5b1..4222e1bd172a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4479,7 +4479,14 @@ static void bnxt_init_one_rx_agg_ring_rxbd(struct bnxt *bp,
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 	if ((bp->flags & BNXT_FLAG_AGG_RINGS)) {
 		type = ((u32)BNXT_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
-			RX_BD_TYPE_RX_AGG_BD | RX_BD_FLAGS_SOP;
+			RX_BD_TYPE_RX_AGG_BD;
+
+		/* On P7, setting EOP will cause the chip to disable
+		 * Relaxed Ordering (RO) for TPA data.  Disable EOP for
+		 * potentially higher performance with RO.
+		 */
+		if (BNXT_CHIP_P5_AND_MINUS(bp) || !(bp->flags & BNXT_FLAG_TPA))
+			type |= RX_BD_FLAGS_AGG_EOP;
 
 		bnxt_init_rxbd_pages(ring, type);
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index aedb059f4ce5..bb12cebd40e1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -131,6 +131,7 @@ struct rx_bd {
 	 #define RX_BD_TYPE_48B_BD_SIZE				 (2 << 4)
 	 #define RX_BD_TYPE_64B_BD_SIZE				 (3 << 4)
 	#define RX_BD_FLAGS_SOP					(1 << 6)
+	#define RX_BD_FLAGS_AGG_EOP				(1 << 6)
 	#define RX_BD_FLAGS_EOP					(1 << 7)
 	#define RX_BD_FLAGS_BUFFERS				(3 << 8)
 	 #define RX_BD_FLAGS_1_BUFFER_PACKET			 (0 << 8)
-- 
2.51.0


