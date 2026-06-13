Return-Path: <netdev+bounces-298843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YCKfB1KnLGrzUQQAu9opvQ
	(envelope-from <netdev+bounces-298843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:41:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1143B67D56C
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:41:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="qcSdbut/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298843-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298843-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E1B8300533D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEEC20C461;
	Sat, 13 Jun 2026 00:41:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E417DFE7
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:41:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781311309; cv=none; b=jRYnNwOkFODUC4rkcaVuA3kprjKCrUN28JwOSmGpiI7XC0mKVqy84/6CvmFekgkg0yQ5GXTTFcHVi9hiAa8aqm5L/n9flVsSeclHs+YKuU3khUT2TEUo4GnYPcK1rfnskrpFjxy/IOUT0xkqCthztUMny3IG/K8rAcYrs5pK3KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781311309; c=relaxed/simple;
	bh=u/TXwiM6yRiTyvvhx6Chxo0/Y1DqB3EY0gda2188wV4=;
	h=Message-ID:From:Date:Subject:To:Cc; b=MadYmdMxtd7Q0nboNKJZPU/cs06Oqjuyf4bwrAamSYaaq8mDS5piK+zwMqa31cBuRd6U9ZPg8Bhv8OgEgU6pZXBnFkf6UxXw/9UyI/Y4MhMIsMQLC/3arYhC/hFUp7rmHwFqs/dKFv3eYzLfVZtzmJE5fWlhigM/fWKXJdN5kUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qcSdbut/; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf1f074a12so16037435ad.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781311307; x=1781916107; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VFoN2y8Bp3v5MjyaOS1eaWX0HBlVaXH4Oqqk7xrVWo=;
        b=qcSdbut/zjN46w3wLOv/CZDVERZaCiJ+Ou7L1m7xFQ3DolQb/axymNvslHB6L3nI0X
         LDXzzahW5ATvPTm2TNR60Ly+HfPPYfl2sNvUaerbYx4GU3BXupXbh79ySDvAVOKAbAla
         r8ke6Gb7smLXlaal3536NfP0TySDYwNknTQ/JSxh7FvY2PTUBskunAgMS48e8q9OaP35
         qWQkDPpcutAV49L7FZD2HCyPyreWS8bY8pzwaZTbe5hQYVs+8KJ7eYBNffKxBlnJxvS4
         JrNqHAbh4y5Ww/r8uxcBgm5MxM+W17fwHTzYyLxTHioeUkr6hF8rOxpQwA1SmD82oxPc
         4DPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781311307; x=1781916107;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0VFoN2y8Bp3v5MjyaOS1eaWX0HBlVaXH4Oqqk7xrVWo=;
        b=lYYU/dKSLOok3bQmxA1XxlNp/sRirsgQvuNbMd3f+V01FnWFfgVkom2FnhuHikAMqZ
         lr25teHWfp9KeEn25GxHpPzxa8PYG6M8oXBSFU+nQriWCSFgMF6EGgDmRb5jaZGOql5V
         spRIKBEABytYXazE+j6/3icYUUTK3kCKndjgYJdS6G5w8+Yu4j3Wz9EiTw/nFZR0sxWL
         7nmM1g2mSvMtqZfuvbyf4GvHAoY0vDJa/xXpM2tPhisAEgQwKZQsxH0SN1G5i0itSinv
         WlRTIGnA8nqhL8ODvP9vo/y7u/7Y26EyAaop0kH0woalR4mVWafqcA6LbBO+SKH6WNd+
         fa1g==
X-Gm-Message-State: AOJu0Yyovl8ehDT3Bp6mBVzNOoxZHXRrynb/zAiYGaEY8Ae4o0RcSz9S
	69ymhdJT7kpLV0VN3vbE07/4s8eZ5V1/LIeYDakeM34qovJUHR1wwwI89vfN1IpPVZ0=
X-Gm-Gg: Acq92OHgvy7+zSKbkciL47rRfVWoyxi9OpiQSjHU4QJ9ngSmWkEdSFrbhnTpbVlSxO/
	dnPMhDdFVRAKHbxKZNdOyTZ6E6mf5FCSDFDPu2rGCZVGg+x5L+crdAevENE3tAZRfW4dA6ASxJV
	dgWHFQBYCnX+h6F9418IYWF46dfHVMXRQdFQWaDb5gfmlOt/VAsYACWfuutAHRYU3aLd+7y+WW9
	QlaBKGa8aTTIGRgZHncDRvliRa/5UISx+gmiVNDFbns+xxQIrpogDinfERXnB246SLjtmI6dfvL
	TA4hE1aoSFWs9YOHtgMhIWjkCN7Bs8+1uP413skww+F5hm+/kUfs35O0r2WeQfiNm4Kqxi0Iuxe
	1kS41u+tzx7AHDos9X6W+IfdjnrTWRueW7UD+YFM84uQSTM2bH3BRsGhbZv5i3q3xr6bYUsBLDC
	MoaJo1RPk/t1gE8eys
X-Received: by 2002:a17:902:cf0b:b0:2c0:c262:b917 with SMTP id d9443c01a7336-2c4109ed1b4mr60346495ad.5.1781311307363;
        Fri, 12 Jun 2026 17:41:47 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm35515515ad.38.2026.06.12.17.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 17:41:46 -0700 (PDT)
Message-ID: <6a2ca74a.c5b1db4e.21a698.01e7@mx.google.com>
From: "Wayen.Yan" <win847@gmail.com>
Date: Sat, 13 Jun 2026 08:41:16 +0800
Subject: [PATCH] net: airoha: Fix typos in comments and Kconfig
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-298843-lists,netdev=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,mx.google.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1143B67D56C

Fix several typos found during code review:
- Kconfig: "Aiorha" -> "Airoha" in NET_AIROHA_FLOW_STATS help text
- Comment: "CMD1" -> "CDM1" (Central DMA, not Command)
- Comments: "GMD1/2/3/4" -> "GDM1/2/3/4" (Gigabit DMA, not GMD)

These are pure comment and documentation fixes with no functional impact.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Wayen.Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/Kconfig      |  2 +-
 drivers/net/ethernet/airoha/airoha_eth.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
index ad3ce50..1f6640a 100644
--- a/drivers/net/ethernet/airoha/Kconfig
+++ b/drivers/net/ethernet/airoha/Kconfig
@@ -29,6 +29,6 @@ config NET_AIROHA_FLOW_STATS
 	bool "Airoha flow stats"
 	depends on NET_AIROHA && NET_AIROHA_NPU
 	help
-	  Enable Aiorha flowtable statistic counters.
+	  Enable Airoha flowtable statistic counters.
 
 endif #NET_VENDOR_AIROHA
diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11..9d9d34a 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -294,18 +294,18 @@ static void airoha_fe_pse_ports_init(struct airoha_eth *eth)
 			      FIELD_PREP(PSE_ALLRSV_MASK, all_rsv));
 	}
 
-	/* CMD1 */
+	/* CDM1 */
 	for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_CDM1]; q++)
 		airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_CDM1, q,
 					 PSE_QUEUE_RSV_PAGES);
-	/* GMD1 */
+	/* GDM1 */
 	for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_GDM1]; q++)
 		airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_GDM1, q,
 					 PSE_QUEUE_RSV_PAGES);
-	/* GMD2 */
+	/* GDM2 */
 	for (q = 6; q < pse_port_num_queues[FE_PSE_PORT_GDM2]; q++)
 		airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_GDM2, q, 0);
-	/* GMD3 */
+	/* GDM3 */
 	for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_GDM3]; q++)
 		airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_GDM3, q,
 					 PSE_QUEUE_RSV_PAGES);
@@ -340,7 +340,7 @@ static void airoha_fe_pse_ports_init(struct airoha_eth *eth)
 							 q, 0);
 		}
 	}
-	/* GMD4 */
+	/* GDM4 */
 	for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_GDM4]; q++)
 		airoha_fe_set_pse_oq_rsv(eth, FE_PSE_PORT_GDM4, q,
 					 PSE_QUEUE_RSV_PAGES);
-- 
2.51.0



