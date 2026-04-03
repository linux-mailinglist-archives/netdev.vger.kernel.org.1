Return-Path: <netdev+bounces-275269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPakOFpI0Glu5gYAu9opvQ
	(envelope-from <netdev+bounces-275269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:08:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 995E9398EF4
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42A90301B4CE
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D01638B139;
	Fri,  3 Apr 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln3CJhCC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F856389E06
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257646; cv=none; b=T7bWW+PqsbcqHIAiP19pVieQJoX9fN9yRQ7/swShzf8kAI5NlqU6VHC0rvwAY1TNZcDX2aQQSPhkgu+Wv+U5JUMNQL0A+W/xR9jeTWm/MvbZaOX5OfKo02Cz2OAd3a0q0yeKGlLRE6mZVe2fBklrepvAmlk0TYFMC/gvN7dNy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257646; c=relaxed/simple;
	bh=kO50n60u5cKMLMq7RE6Byr6qxzOcZmTtOgxcHMgoYbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jo2M2crHdqPlEL4VVCHC6tvmKY/Y3EngThrw8d1+hhQ+7U2VuFvCGYacWE2vZYKumrB6COIei/tGffkBrxLEM/PEp8/akuGFD4VcJ6ULMImpOw3Ychp22hHw+KvvTl6JF7RKmXbkCm3e8HySDO/g6+QMORZZH3yqdaEfPw0MqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln3CJhCC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so14755395e9.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 16:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775257642; x=1775862442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW4zLdxlBcXiJ8+qk/5YoKQ6P7XuOl6e7flfCk5XlwM=;
        b=ln3CJhCCKgk9pqt20DmevWCsSeNLu1Zy6CrgB855d0og+kmbm3JYEMOQDUPczGl3fR
         JR4oHIQ+zyE17zYEdQkCq6Ub8vFWUXCh6Kox64rGDMduNjorbdGZv2Obynv3gibmzJjO
         Wjyv2wHO9le0BG139R9RewEO8LE9DX1QuIIQSt3jexUL7vY+1OnCyCcxuyZeehV2KKpT
         o1kvk9z1NDQc9YUAheNTD3sAA99UEnet8h/NJZu5v/qFXz87TKBh+pbXecLrC0xWAPZ8
         xu+wON8SQG0mlh00Ql377COha1yv1kkydnVlQ2pKAXtCeGrH6+0nYkxlOoDrNOR4PnGu
         kpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257642; x=1775862442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LW4zLdxlBcXiJ8+qk/5YoKQ6P7XuOl6e7flfCk5XlwM=;
        b=RpI9pKIqKe0OFAEDZBdLG0vGDBtNdZ0cs+i2LUGRmbUiNxNVsUZGDGGius5P8B2pxC
         vbLeeKUcQlBHtuMfjpApF+dtoOj9qR2iYrQDncgbjqUF53OPXVZ3VpqrJA54e+Pb2Qk9
         H6UH/d41tPFkxeH4dM2QeAOfjoetIUrbgHsiWQHHR2/nddNcuJ6EjVTJJYFRjmUEeTve
         MfVwIY5k9P8T3sQfbbQZggsiZCZ2qNqvKU7Sx15TMiwdEiD7MGIvFrDVcD+VnqLH/ycB
         IXpUfoEcaISTajmKSq/mlhhoAPuWxPdFMBWJbusXopSBMk/Nwb9k2XgxjP8+x7KTKysU
         GDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfKJeRvy2dmz7NaPWNI7wxRwM8xSNSiyMTyfrK8o9AHjUAmUExXwunQr5xIHv/ixLVk1WugCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNNXZOUaQOH0wNLaun0x2B5NKIafuDgWqySspnrKhmIQzdbX/k
	dafual+B9l3+hmXaSpS/FJiSv8VqKBmSCO/9bCF02NeqzvkWyd2n1kq/
X-Gm-Gg: ATEYQzxXa/ZCz6L9xmtiqRZM06juzrDeObSfS0WwFtV4VMDxDSr4Gq3NJG312mRYNId
	Lo9+h9ykcatJ05zeYcY1PkhDhv4zeiiGYYFAy1m6u7zTss+105k1PTVph/nux8By1HGxvudOkoA
	oP9LAvgkqenemtGCYR7fUKvrCAy6YjNFDvmXGdjN5TyJ5OPuLQ+u0oh2FNYfDMJU8Z7I7gZLvTT
	tGDOpLzN4SuIgpaKI0y5y77R8XBTJwj/qM3dUFO7uuPiZeZ1czbqcU6R67+fxIY2kUieskl9Wlr
	TSKHzt05Xt3Je27jgtztQ+z/6KAGdGcp7qt0PgCimn3eJ4TZs+uhUu/4MeXboIguIenXZSfhvxI
	KXUFpG9lgxoSZxDDCUsVaaIOWj97PqYCy+EXNFrk0SlnkfUwjfNm4SwtS+gRa5Jnn/udgTzyE65
	n34BtptNGYjywu8bOo9a1vq1k7aNy2UrwCM+/hczR5WpOxc0gpkTbSGFRtq69ReZmtNvTaNXSHq
	BUkvipmYr+0
X-Received: by 2002:a05:600c:1c11:b0:487:e2d:f649 with SMTP id 5b1f17b1804b1-488997c1c46mr62311855e9.26.1775257642481;
        Fri, 03 Apr 2026 16:07:22 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c60a2sm18830924f8f.10.2026.04.03.16.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:07:22 -0700 (PDT)
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
Subject: [PATCH v2 3/3] net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()
Date: Sat,  4 Apr 2026 00:07:14 +0100
Message-ID: <20260403230714.10667-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403230714.10667-1-devnexen@gmail.com>
References: <20260403230714.10667-1-devnexen@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275269-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 995E9398EF4
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
 .../ethernet/microchip/lan966x/lan966x_fdma.c | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index b985ce64bb50..fd6718a23676 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -814,9 +814,16 @@ static int lan966x_qsys_sw_status(struct lan966x *lan966x)
 
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
+
+	if (!old_pages)
+		return -ENOMEM;
 
 	/* Store these for later to free them */
 	memcpy(&fdma_rx_old, &lan966x->rx.fdma, sizeof(struct fdma));
@@ -827,7 +834,6 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 	lan966x_fdma_stop_netdev(lan966x);
 
 	lan966x_fdma_rx_disable(&lan966x->rx);
-	lan966x_fdma_rx_free_pages(&lan966x->rx);
 	lan966x->rx.page_order = round_up(new_mtu, PAGE_SIZE) / PAGE_SIZE - 1;
 	lan966x->rx.max_mtu = new_mtu;
 	err = lan966x_fdma_rx_alloc(&lan966x->rx);
@@ -835,6 +841,11 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 		goto restore;
 	lan966x_fdma_rx_start(&lan966x->rx);
 
+	for (i = 0; i < fdma_rx_old.n_dcbs; ++i)
+		for (j = 0; j < fdma_rx_old.n_dbs; ++j)
+			page_pool_put_full_page(page_pool,
+						old_pages[i][j], false);
+
 	fdma_free_coherent(lan966x->dev, &fdma_rx_old);
 
 	page_pool_destroy(page_pool);
@@ -842,12 +853,17 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
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


