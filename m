Return-Path: <netdev+bounces-302946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 45p+A31DQ2r4WAoAu9opvQ
	(envelope-from <netdev+bounces-302946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:18:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1386E0370
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:18:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dCxFALE+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302946-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302946-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1802300AB11
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BAE3E316E;
	Tue, 30 Jun 2026 04:16:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDD33E274C
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:16:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793007; cv=none; b=XnOfN3raR3NPrB/erYYRTRJQLjYVC4NRpLyX6OyK41Q8Rqu3p0MXHTTGBZ+Lv76a/jd+/0fssIPNYVIOBo7abf3ZQCBTkdlwO3Ksf6d93AnT/gSx1V4NtCymgxKALbLDCmLWFdWF40xnVp1s/ceQS/WGAlLlKz8YZHxi1wpDKiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793007; c=relaxed/simple;
	bh=ZbnG49kMtnonjZd1Bl6WZb9BoqWESC66Yb/s2HrfTKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHH9yd5UEWBa4Hoih3ZlCSbeubfj4zzFdpriUIjbQ96Dq/euztGfAJMZj1iyXKdHqj0R8W8+OT0lpN/szXtUZrJ0KWMZjsffSXBcv/TdKU0F6aLMXdjvuSqn9tP/I/UOKTDUmCO1svwcZ3IwGq3yhOOzscUA145xuLMvcZ9W/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCxFALE+; arc=none smtp.client-ip=209.85.215.170
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9672e02e05so730030a12.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782793005; x=1783397805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z4ic3/d06KRCdVhV625ALQxc1LARsSY9ERoc+3rd7w=;
        b=dCxFALE+m8Vq+KiG7qT2iv39VCERr3GfdNP+Xe3pDey2pUt0+M2xzLm+Kw1HHU2O+N
         aZ9JqrGIMcs6VN/rIERIVAoPdjFijtMK1fG/AlneVax6ZG/dD31VGw74TyCc3hSK3Lya
         QEM+R0SIbuIbotMLe61t/omdjx9YnGAHsyQhaHkIuSLLYnDbc8EyoazQfmVMoJMPofRW
         7M2pzZVSpZQ1nvKo7SxYWRnSTTtwFf5TTvu3LRI2fsci9lhgfnZdMHNyXjsQBH1iSwMR
         eVJ3M4Fz0tdbe/TuDXk7ktNNnJYA96IRwWOSZz4D+cpbYmxw/REf4D7xuEkFwYX82FA0
         F2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782793005; x=1783397805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Z4ic3/d06KRCdVhV625ALQxc1LARsSY9ERoc+3rd7w=;
        b=ocf0JY6QG1vI8vPtQ3iTgJivXzhS0Ug+by+xDZOxQkgVL6dRPiVed3X3MpXq0iQe8V
         TkbjI6OpjTPqBi4teWF1d20bQSDbrc2ewWY4yIliTQCl/3/RdfyKH+g+S8XLmS6T1Buj
         D5S9k/BIIFusxGlnpFRj/kC+e0PH36lFgBJqULpKawA8w5Iyw5NNBxS1WWxXqquNj9x0
         8TTiM2XF0AxOA1NU6fE0csejY7A7SAtexlATFKtY+Zk18pYlz03ajaf2DQFVJ4mXpSOb
         IKx0qMXJe5EL3a24JsVKEco1mGaxN6lJ/CuR378ffwZyW6bYNfUm+CzMH8ZK7JL6ZVXR
         BxUA==
X-Gm-Message-State: AOJu0Yz/kuPjsIvo/6F9XJmnGv0tEfo463NqcYqEIxKqjGJfTX0kHVcU
	HOStcG8uGeBH6rGsXqD+JuKYVfk0Vh0q9Ww+bvU5wkPL4j3LxQEssepvT6+w2W6d
X-Gm-Gg: AfdE7ckIzPymW5dJv0HFRkh2SuLCkK7/8/R7jKSE+JnzHbhhn5F02ShnAahYrUDVXnb
	KqznU6vgi0KV3SVUoB5Axo6+6IjOqCDB6gU1lM2nrwr7QvwqxhgaaxluLkkP4D1QukfiGP5nGP3
	CYLXv6DUqYdaMUjVoxm6zGdRXm63IlwXEJk9f5H1woMtyMDIk/4LxjsXo1AAfVfJrw+MWMv/mMS
	PBUftF450r8rv0KRdCTiR1bBI7TgGAVXqBI+TdRx/AWnz0xWni5mpg3aOy+dMgYA6i0ZCiWr1zl
	M7etiAEhUXQ91ZkeCva3WDZsHbEkWPq67ywF9tASuXjKZpxqPueVnmtS2JmSLIp51YTnJxyipwi
	UFStnxmKKYul8AOt1QX1CKLNm6Le2HKXoRgfsUqaViwuqDZBs+Mn0OWkclBR1dEHjoNcWYcDSpy
	9C5i0TrmzT+8XMXMT+uV1G9aCfqBmopw8YTfzn+R6otFL/C33U0b3/MtP4jXxfVjw00uDMQk2ka
	H2O8CnoEA==
X-Received: by 2002:a05:6a21:a49:b0:3bf:bfe6:ab6e with SMTP id adf61e73a8af0-3bfc50680f1mr1949323637.6.1782793004858;
        Mon, 29 Jun 2026 21:16:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95a3e7sm702659a12.19.2026.06.29.21.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:16:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/10] net: emac: batch stats, eliminate modulo, tighten barrier in RX poll
Date: Mon, 29 Jun 2026 21:16:30 -0700
Message-ID: <20260630041634.284127-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630041634.284127-1-rosenp@gmail.com>
References: <20260630041634.284127-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302946-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E1386E0370

Three small hot-path changes in emac_poll_rx():

- Batch per-packet 64-bit stat updates into local accumulators and
  write dev->stats once after the poll loop, avoiding expensive
  load-linked/store-conditional sequences on 32-bit PPC for every
  received packet.

- Replace slot = (slot + 1) % NUM_RX_BUFF with a simple
  if (++slot == NUM_RX_BUFF) branch, avoiding a div/mul by a
  non-power-of-2 constant.

- Use dma_rmb() instead of mb() when ordering the ctrl vs. data_len
  read of the coherent RX descriptor.  The device writes the
  descriptor fields in-order and clears MAL_RX_CTRL_EMPTY last;
  a read barrier is sufficient.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 5e7b85d28bde..ced9690cddc3 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -1741,6 +1741,7 @@ static int emac_poll_rx(void *param, int budget)
 {
 	struct emac_instance *dev = param;
 	int slot = dev->rx_slot, received = 0;
+	u64 packets = 0, bytes = 0;
 
 	DBG2(dev, "poll_rx(%d)" NL, budget);
 
@@ -1797,10 +1798,11 @@ static int emac_poll_rx(void *param, int budget)
 
 		napi_gro_receive(&dev->mal->napi, skb);
 	next:
-		++dev->stats.rx_packets;
+		++packets;
 	skip:
-		dev->stats.rx_bytes += len;
-		slot = (slot + 1) % NUM_RX_BUFF;
+		bytes += len;
+		if (++slot == NUM_RX_BUFF)
+			slot = 0;
 		--budget;
 		++received;
 		continue;
@@ -1864,6 +1866,9 @@ static int emac_poll_rx(void *param, int budget)
 		emac_rx_enable(dev);
 		dev->rx_slot = 0;
 	}
+
+	dev->stats.rx_packets += packets;
+	dev->stats.rx_bytes += bytes;
 	return received;
 }
 
-- 
2.54.0


