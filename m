Return-Path: <netdev+bounces-275439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IjTN8L40Wm9RwcAu9opvQ
	(envelope-from <netdev+bounces-275439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 07:53:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9AC39D731
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 07:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B864300530D
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 05:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E371336B07D;
	Sun,  5 Apr 2026 05:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIJ6u8AF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5836A000
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775368373; cv=none; b=peQ1PgFaEXmwwUdyIm3xdUEz7UaUxGcG0zbmynRe90A2mM/Qc2JekmH0BhA7hwwK8HwReQ6YR0xri0/8ZkifY+MwJ5FPvuLilev3CWMgG83is7/VIQsDSPkzbIVxG/Nkcstgl+e1pBIdGfAmxUjFqiMz/IIry2KPaaKrEB0bUJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775368373; c=relaxed/simple;
	bh=rjyhxTLjD4oM7GV53cCusNScFU3+tGRuTXJymOhoLO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcGUSKVeUvqMkFHQbFxL641lMePZkqCU5nY0mDXQIEK706cD5vNb3C6ttlW3OWrtoukN80hhdfsqKK1YkLD3E76cio35ijiwlL2xuySCGlb8rib//lj1nwC3OjYCZBEabHFGhlS3I+iCyyOt6AXtTNdRxw8Iy8bCFJI9XJS1AAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIJ6u8AF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b0046078so2515e9.1
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 22:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775368371; x=1775973171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiLiRH4idOnGI7FfnG4m23MwzysNfORwXalUz3M3yBI=;
        b=mIJ6u8AFGN1tBEGIiMWaOKLOlUOiK35cXSqT4YoLzfugh9j7iCJs+MD8So4l3T2nTh
         xniZ1Fi2ufpVZPNzOiiBgoDGlk/S5RL4SjVKbfUXGu1ZmHMhTfm3zdoJdSRcqeL+QYjf
         iATzwgKiDIBbzBVe5/1BErZsyu78zAcoD9lQybUK6963hOKM0IHidQSDmi/Dd0esXNIX
         YYppJYJdAZb+knhKXa+BL0kWzDGfhViMrn3zqs1Vna0fp9N4eGZfZ0D9KS1ffpMobkFI
         A9EXAlBbvii2lsDUoo/6hf++nwpdax3VPwFUQVxnaqx+yXWY1shB9KXI+PRxw7tfyOJo
         NZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775368371; x=1775973171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eiLiRH4idOnGI7FfnG4m23MwzysNfORwXalUz3M3yBI=;
        b=TTgWNSqjUqSaGsMiJ4/YetZVSNWQNK430n+TauWUdAP6kj0HQg70teNaztpRs+kf1e
         pyDSg2jxMP0EBqitMh2NV45FelQf5I35aQbksA3rB11EK5Q5Eb2w57mG0wAdwDQnXUjn
         9gpNlGaKHQFcCRC4X0SKD67pLPvwJ1qpCzS/wHGlE7AtXj1E5HPMw7kOOTMkYKjXoE0s
         ZjTJ1I/HUAN6iKCLpZB0sjAz6Hb7X7IfCNfMMpYGTUutsr5EEuXemLE89XgKBUCFhVZM
         tTNrnZGvt7fBF+3/b8Vw/981h5K9uE1gqZlpgwUKkCR/p7YUm648Ji+RQJIAYDwd/WRP
         K/cw==
X-Forwarded-Encrypted: i=1; AJvYcCV9iI3GZ9m5sWf2nxSwnS2NECGjkKluINdjKLh/4Hu3LdkexJgeU/0JvSXrUJvYR5q/8Tf7bE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH23N4idSIZdNXMLpaqok4ygKVKSsndep4dXHUltCItZYkdjHF
	eFXNX8cS/mmcIK6suUCHKBKQvh0MTyFFWw3bLuUWGV+pZyx+b5U9LP/+
X-Gm-Gg: AeBDievd0t/qTrtaSiJugvzyEbqyGgKunRfZWoqMShhW+CDHGM6KPGknE4EVUa4jmOT
	j3gTFPyt3F3rsq/3d4L79bfzw8WV8s1193+oEfdtfHC9kX949+iWfEYo7eKfj8gmV6I+tHajLqU
	x0gKY6BBA9yi8SGQaQoSt4wTUx/kpheY3+tVcrCIJTbn7eIqHIT7uql4F6S9r9NhED3RGb7/evS
	XBXL6Ul5loIhiNGIJcBoOORwUgI1eSRW3XCDIWRps/se/bNQ5kRmoawLgTGjOYPJGHBDqM7zBV7
	ZaBiOnQ7aNxONjmmPISET/MJP4aEMwT3VHfr70jMKp43HF+KJkhVc3GqHp9J4U1ePgkZRgrQUm4
	+6vtOGQLdkOlgEj+M5mfv0NaMa0rxXfNl4wVb/ifr95c4EpIfqWlSds+0GJDidp2mdRhGsDSeHT
	46CnE+kENIWud2xCRnX7PSQxRfGowGoJraXB5xjle07mggAe47eO/6jAEPqLE6lyN4xRsvFnU9m
	00l30AQS1tm
X-Received: by 2002:a05:600c:4e86:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-488997c9b69mr114746685e9.29.1775368370586;
        Sat, 04 Apr 2026 22:52:50 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899e960a7sm55847465e9.27.2026.04.04.22.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 22:52:50 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net v3 v3 3/3] net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()
Date: Sun,  5 Apr 2026 06:52:41 +0100
Message-ID: <20260405055241.35767-4-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405055241.35767-1-devnexen@gmail.com>
References: <20260405055241.35767-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275439-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB9AC39D731
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When lan966x_fdma_reload() fails to allocate new RX buffers, the restore
path restarts DMA using old descriptors whose pages were already freed
via lan966x_fdma_rx_free_pages(). Since page_pool_put_full_page() can
release pages back to the buddy allocator, the hardware may DMA into
memory now owned by other kernel subsystems.

Additionally, on the restore path, the newly created page pool (if
allocation partially succeeded) is overwritten without being destroyed,
leaking it.

Fix both issues by deferring the release of old pages until after the
new allocation succeeds. Save the old page array before the allocation
so old pages can be freed on the success path. On the failure path, the
old descriptors, pages and page pool are all still valid, making the
restore safe. Also ensure the restore path re-enables NAPI and wakes
the netdev, matching the success path.

Fixes: 89ba464fcf54 ("net: lan966x: refactor buffer reload function")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../ethernet/microchip/lan966x/lan966x_fdma.c | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 10773fe93d4d..f8ce735a7fc0 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -812,9 +812,15 @@ static int lan966x_qsys_sw_status(struct lan966x *lan966x)
 
 static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 {
+	struct page *(*old_pages)[FDMA_RX_DCB_MAX_DBS];
 	struct page_pool *page_pool;
 	struct fdma fdma_rx_old;
-	int err;
+	int err, i, j;
+
+	old_pages = kmemdup(lan966x->rx.page, sizeof(lan966x->rx.page),
+			   GFP_KERNEL);
+	if (!old_pages)
+		return -ENOMEM;
 
 	/* Store these for later to free them */
 	memcpy(&fdma_rx_old, &lan966x->rx.fdma, sizeof(struct fdma));
@@ -825,7 +831,6 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 	lan966x_fdma_stop_netdev(lan966x);
 
 	lan966x_fdma_rx_disable(&lan966x->rx);
-	lan966x_fdma_rx_free_pages(&lan966x->rx);
 	lan966x->rx.page_order = round_up(new_mtu, PAGE_SIZE) / PAGE_SIZE - 1;
 	lan966x->rx.max_mtu = new_mtu;
 	err = lan966x_fdma_rx_alloc(&lan966x->rx);
@@ -833,6 +838,11 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 		goto restore;
 	lan966x_fdma_rx_start(&lan966x->rx);
 
+	for (i = 0; i < fdma_rx_old.n_dcbs; ++i)
+		for (j = 0; j < fdma_rx_old.n_dbs; ++j)
+			page_pool_put_full_page(page_pool,
+						old_pages[i][j], false);
+
 	fdma_free_coherent(lan966x->dev, &fdma_rx_old);
 
 	page_pool_destroy(page_pool);
@@ -840,12 +850,17 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 	lan966x_fdma_wakeup_netdev(lan966x);
 	napi_enable(&lan966x->napi);
 
-	return err;
+	kfree(old_pages);
+	return 0;
 restore:
 	lan966x->rx.page_pool = page_pool;
 	memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
 	lan966x_fdma_rx_start(&lan966x->rx);
 
+	lan966x_fdma_wakeup_netdev(lan966x);
+	napi_enable(&lan966x->napi);
+
+	kfree(old_pages);
 	return err;
 }
 
-- 
2.53.0


