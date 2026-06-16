Return-Path: <netdev+bounces-299809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g3imM4AsMWredAUAu9opvQ
	(envelope-from <netdev+bounces-299809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:59:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7199668E900
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:59:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PTOP2D1R;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299809-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299809-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C9E23046EEE
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6EF43900E;
	Tue, 16 Jun 2026 10:57:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3079436352
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:57:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607472; cv=none; b=QysEOFoLqEBTC+uyOU16WPIVXgSDxpGXnxaLbIuDh6cLIw+qDC5UP0l3hnpXyykcRK3vEx7bS4R/3Wp8tBmYnHa33dGSqqLYHVb6mfaDHpWIvv6HWQzP5zrUzbfNU9DP/I/v7BwmXUnJAOOjx1v7Jo84H9ea2md2rORLasRpUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607472; c=relaxed/simple;
	bh=sWtKVClCY5iKzZTBaPkfQKlxWqZyIMSXA04t8hixGEo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GKVgnGIv0zi67/Y7c8H8XjVRRroC61stnnSfh+xMGY0lPIM905doQAWaYagV+uOFLXJz4s3oDl1dKlEkY+ZkbhXCevi/UvY3eHAQVzhiW5ePojS07Kpv6Rm0GOlC3VNMZuFPPMveDyVA3eXM59aSPRj/2baWDA+A8OgzM8/S4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTOP2D1R; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36bdb11bf8bso2332714a91.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607470; x=1782212270; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gAm1lQ7yhd4gX3+khTjc4usVeRGoKvzZrc6QCVuO7II=;
        b=PTOP2D1R5lDemjDJ4OH7vk4UuzDPcPMzfLhdeHhu59eB3j21+TSY43iFr2TUCeBbxM
         pMre4DuetZDzIhbnKXVSKpDrL3mBPgnVfQe7d1bkMAvqqimwbFkbt4pK/lRaRXfiOljF
         +cd8smYK74VG3dm4kkxQ0KFOCwUNdKZlEOLRPLqrpa288uaBTMnp7QvNjIcfVAfLTps1
         XtN+fb2dcQr1L/M/DXDch9zk/rpoLlvFyv/pvnOiWeDQlYX3iTDMiwVU8iVH4PmmPcD0
         z3K2D+yq+b/1JL49yeml8yN5HfO84nHGsjnQK/qvT8ziO5W9Nk9yatDF9oGVPYXBtKE4
         Dbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607470; x=1782212270;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAm1lQ7yhd4gX3+khTjc4usVeRGoKvzZrc6QCVuO7II=;
        b=O9Ot/AbHHc4ZpYqi3gQuILNO+ii9rIP8CXAhLejqDItqiL8zZg762G8lhVSemvFHKf
         huGZw+MqTiyegM5rDtHDA+zr1jhoxXWG6+fDy02y1pmMcdbR8zBd1fYiCdFOeBuwBqGC
         oPiGwg3r5B/ZWsfNVvLPnhlhMAQk6RghB0qQQbxuXr5wSevAwRk5j+tKj2icF93Qxq8p
         CxkYcf+618pwbLJ3hPgBJ/JHBmZlecCntNrRrIv5pF6DLFYeydDZc+ITfC8O87qDRZG7
         rPyQ7MHIcdBAXbGZXTDCk+5sYCG0EUEmy4tz6oa4Qi/2EOXg7vWBQVB8p4Rsbc1Vwcda
         FlLA==
X-Gm-Message-State: AOJu0Yxi/KTygu6SmevPwV2h0BrDExOkFAFG7MQrKvOunVJc6e/kVggT
	o39SN2nznWkd+GpRMxMJxu9GSdLPy9BhAkl2Fvy2iLFLrnUHLEbVm/M8kyN8K/AS+J9fhA==
X-Gm-Gg: Acq92OHzFXHgU13qARXY6byIRbVBOC1n+fRqUi/VVfWc5S21gTSeqh8Yco3GqGO3A8s
	1gUM+reJWmlwgAZlv/aLpsgCDc9Hh3DaMEIE2zQFlxJ1HcBkWrKYxJwcKnxkIcqYixCVvjUuuqz
	Bfda7Ihlz2mhATc0kxXcyr2i0qCiY2MmmuWgc7zh8gLwlzJ6HzM9oV79rfPPaWlgF3NOwi+xn2z
	DhWmtJiyaew4rPGFostQxXcDL6pTlbBN+iP/ROkSMdzPaTvn2qYw83SNUg9qNYOEuj3q12xDhIU
	86EVr5OP2P4tezbxGgo1vsFMy5OyBoapsCj+w4Fkg5P+KI9weBBWzChto/+nWSKfJtkyUQkW1mb
	bOMS6cSfSWIRWDQrstFlZG6N+xdTo26nw4fasaVwWerlnJWfEZaLT7/y1PZvEzBk2BWT6IBqAwj
	Bk8msofeMoZckBB3Wo1MFGu2rDx8g=
X-Received: by 2002:a17:90b:1fc7:b0:36d:633a:e8aa with SMTP id 98e67ed59e1d1-37c528e0095mr3107649a91.13.1781607470166;
        Tue, 16 Jun 2026 03:57:50 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e79396d7sm9849057a91.1.2026.06.16.03.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:57:49 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] net: airoha: Clean up RX queues in airoha_dev_stop
Date: Tue, 16 Jun 2026 18:50:48 +0800
Message-ID: <178160746585.2156302.190868309474762875@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299809-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7199668E900

When the last port is stopped, airoha_dev_stop() clears TX queues
but neglects to clean up RX queues. This can lead to:
- RX ring buffer descriptors remaining valid after device close
- Potential DMA synchronization issues on device reopen
- Risk of use-after-free if pages are freed while DMA is still active

Add cleanup loop for RX queues to mirror the TX queue cleanup,
ensuring symmetric resource management.

Fixes: 20bf7d07c956 ("net: airoha: add QDMA support for Airoha EN7581 Ethernet")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11cd7..9ca5bbf64d 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1771,6 +1771,13 @@ static int airoha_dev_stop(struct net_device *dev)
 
 			airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
 		}
+
+		for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+			if (!qdma->q_rx[i].ndesc)
+				continue;
+
+			airoha_qdma_cleanup_rx_queue(&qdma->q_rx[i]);
+		}
 	}
 
 	return 0;
-- 
2.51.0



