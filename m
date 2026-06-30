Return-Path: <netdev+bounces-302949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q8TVCaFDQ2oEWQoAu9opvQ
	(envelope-from <netdev+bounces-302949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:18:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F22846E0396
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:18:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Kazo7o0Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302949-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302949-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EC9830174E8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640B53E5EEA;
	Tue, 30 Jun 2026 04:16:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828613E4C94
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:16:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793011; cv=none; b=Bx3+aJzhvRG1a08KYBesjttVGJKh/Luc8fMLkf0FuFfM/RGNEcnM93X166+0z45E+QARfsnk2VKJ7XvJtqm9YO7/98/w0OyA5G9xOAZHP/MtNmob8azKP1AVluLy5ie9cBpsi/+GLcQCmF6WRuLFW+9/4PwoeGdNlMwtqPXLHHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793011; c=relaxed/simple;
	bh=PmUJ2TEL23pK+Ba1JileIuAUD0GczR5bW4MupBOPEbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i75fg51PSO4KoFxL0WzaGq3pJCEYc84rajAUKMmeGhHScTbu6+5LRx/1V2wcMzpEwL0/FEL65Dexw2mzjiwj59y6D6t0Orx4d1sukbQhi2TcJr2klIEmkQXgLkpQ5TKV+sONIrH1qfx0HUqCqaUjyIoMDqhW5zt0lHo4+eP6RB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kazo7o0Q; arc=none smtp.client-ip=209.85.215.180
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso894628a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782793009; x=1783397809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dRTVAGIBhnXWkB5GTBDl/QpWYWFyOlSCqlOk7N39lQ=;
        b=Kazo7o0QI1gV0hTBf5Ncarns8pBMjsuGhNigTI7MUgrFIMTQYDRFOg+2QE+35VtGHy
         1HIQMRtGvF6pO0tKOA6nfihXD32ToCCIVbsdS/f/0WUC3p+74CiLuiCwvm5nkb2NRasy
         bL11Ru1yit2RgCumTIu638cWYoZxJe/MHODr+LHpQcY7XbiUdhfl+XGkdQOIFZdG/e6c
         4xyIwzFlQgRIZtxM/7+70ZxxqgXoZY6V4C8mtNzWLe7YxhQiyAhA5W7LCt0Cgan9Vgy2
         JhozfuKWu/d4O1eCUdd8tkHK6MVIv84cBN/kQfxwmmM/PclOenq5/M6l33DGgS40wyyA
         isMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782793009; x=1783397809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3dRTVAGIBhnXWkB5GTBDl/QpWYWFyOlSCqlOk7N39lQ=;
        b=fUKk82QapDIy9FOWhE5nic41uwnQeLQS5zWnhbDqMlJGgJ3gcxgCiXehI8Qqh3KQpK
         /b6O/wd+2Wn0TjSgiM32FaJqv2MiqgQCrAjiPy2TrCSLOhedIO4DqEYFdBUHwnrGwfah
         ofDZEao0dwrjmCa6HgPGZ4eBkfEVRGV1Gztj4188s4+wBCYWpo+kNvbDruEZ0ETavcXy
         qM/eb2GJQPhjmQMPwpsaZV92laLkBvxG18wwPOOk64gl9tdEyjVcreUBSmJk4cm5+kn7
         cBsQeoj5GfW7Dvy8wAxD7DGnHnzhGq/iM0gj/UIrIXkay0fZtfSKFjdkTVwgJZP/MfX/
         8OFg==
X-Gm-Message-State: AOJu0YyHbyeZHCKhb4DTdpMP+foU4v6UqGYMmmm8SbCRgnIt7kE68Wpu
	MF8+2FlwshVWDieASMUqoz+tcyDjXf7Dn7Pn4pablxT+NF2kU9WFuMLYzhPYWqz1
X-Gm-Gg: AfdE7cmd/ILe3y59KEaHybLA2bZPx24Y6rg2z92MVAwqkdkWwWgrBcwDbNOG58xSm7J
	GXuWZDiDgAZ4dBGHmxBOztQPRRk38zkd+gFEtFFP8WlLQvR256FO4jFNTsjoV7TZ9KrXi1zm8Y5
	U0gIRQeR9veDSjBFwWfbgsOXjyiYnvRWGpmkP9cGbk5MgiDpwAnScviaPjpNglqsMNIqwrZxN6F
	WJ/QdLRCocLLwGn2MUdVkmWL6BLxfi3v6wzmOQt5vAY1hbieLxRUh5ulNsrSrcCxfyDepTRmtks
	1RNCEMzhqz0OoznEUhF7fRJEbCROw2j2eCZ4eRJlkbyjnJ+iHgNhBPwuuJDUsKHmAPZwMa/Tfbp
	28bEF3F7rtVRcAY8EuVdSwEenXBvjWSoJ9B9WDalWEHSex1Hgx60uQgbOXDIOkaxfnxtPn1P2/Z
	fDlc/tSRzWBF4J3GZL/Amh7i3Tj1uSCAAxd0gfyBvgvngbz/jOBRJRRFoEkGRMxICW7UarNyEy+
	as+a+IXcQ==
X-Received: by 2002:a05:6300:6697:b0:3bf:c126:bb02 with SMTP id adf61e73a8af0-3bfc52de565mr1676365637.47.1782793008765;
        Mon, 29 Jun 2026 21:16:48 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95a3e7sm702659a12.19.2026.06.29.21.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:16:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 09/10] net: emac: add Byte Queue Limits (BQL) support
Date: Mon, 29 Jun 2026 21:16:33 -0700
Message-ID: <20260630041634.284127-10-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302949-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: F22846E0396

Add BQL to the TX path to improve tail latency under high throughput:
  - Call netdev_tx_sent_queue() before ringing the TX doorbell
  - Call netdev_tx_completed_queue() with byte/packet counts after
    TX completions
  - Call netdev_reset_queue() on close and full TX reset

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index dba3cdfea340..da5f3d436aa3 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -751,6 +751,7 @@ static void emac_full_tx_reset(struct emac_instance *dev)
 	mal_disable_tx_channel(dev->mal, dev->mal_tx_chan);
 	emac_clean_tx_ring(dev);
 	dev->tx_cnt = dev->tx_slot = dev->ack_slot = 0;
+	netdev_reset_queue(dev->ndev);
 
 	emac_configure(dev);
 
@@ -1428,6 +1429,7 @@ static int emac_close(struct net_device *ndev)
 	emac_clean_tx_ring(dev);
 	emac_clean_rx_ring(dev);
 
+	netdev_reset_queue(ndev);
 	netif_carrier_off(ndev);
 
 	return 0;
@@ -1448,6 +1450,9 @@ static inline netdev_tx_t emac_xmit_finish(struct emac_instance *dev, int len)
 {
 	struct emac_regs __iomem *p = dev->emacp;
 	struct net_device *ndev = dev->ndev;
+	struct netdev_queue *txq = netdev_get_tx_queue(ndev, 0);
+
+	netdev_tx_sent_queue(txq, len);
 
 	/* Send the packet out. If the if makes a significant perf
 	 * difference, then we can store the TMR0 value in "dev"
@@ -1666,6 +1671,7 @@ static void emac_parse_tx_error(struct emac_instance *dev, u16 ctrl)
 static void emac_poll_tx(void *param)
 {
 	struct emac_instance *dev = param;
+	struct netdev_queue *txq = netdev_get_tx_queue(dev->ndev, 0);
 	u32 bad_mask;
 
 	DBG2(dev, "poll_tx, %d %d" NL, dev->tx_cnt, dev->ack_slot);
@@ -1679,6 +1685,7 @@ static void emac_poll_tx(void *param)
 	if (dev->tx_cnt) {
 		u16 ctrl;
 		int slot = dev->ack_slot, n = 0;
+		unsigned int bytes = 0;
 	again:
 		ctrl = dev->tx_desc[slot].ctrl;
 		if (!(ctrl & MAL_TX_CTRL_READY)) {
@@ -1686,6 +1693,7 @@ static void emac_poll_tx(void *param)
 			++n;
 
 			if (skb) {
+				bytes += skb->len;
 				dev_kfree_skb(skb);
 				dev->tx_skb[slot] = NULL;
 			}
@@ -1699,6 +1707,7 @@ static void emac_poll_tx(void *param)
 		}
 		if (n) {
 			dev->ack_slot = slot;
+			netdev_tx_completed_queue(txq, n, bytes);
 			if (netif_queue_stopped(dev->ndev) &&
 			    dev->tx_cnt < EMAC_TX_WAKEUP_THRESH)
 				netif_wake_queue(dev->ndev);
-- 
2.54.0


