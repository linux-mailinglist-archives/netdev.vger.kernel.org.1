Return-Path: <netdev+bounces-55769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A15D780C3F0
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B981C209F0
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96912210F5;
	Mon, 11 Dec 2023 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="oSAvyIRY"
X-Original-To: netdev@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E18C3
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 01:07:28 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5c92:0:640:faf9:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTP id 22D0260AD9;
	Mon, 11 Dec 2023 12:07:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id L7dWYnovPGk0-zgZpDRyg;
	Mon, 11 Dec 2023 12:07:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1702285642; bh=XWXGeZYe0yESybDeufd++21hVDjaQ8mr2ZhNd6BJVZQ=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=oSAvyIRYX+MA1jyd2NH3WhyccPF07w9XM764PNmztb8+c17dunL97yv/sw7vjl++r
	 UZFXn+lQRnji+iMgfq9nM5yJToY4MZSGVadCEbJ70HFwN5Q8OX/ulAo9fpcK4RNtj4
	 LphBcEENlIEs4KaEq3QAPuHr0DXvc0ZCEkp/Bm3c=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
	netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] net: asix: fix fortify warning
Date: Mon, 11 Dec 2023 12:05:32 +0300
Message-ID: <20231211090535.9730-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208160755.4271a283@kernel.org>
References: <20231208160755.4271a283@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with gcc version 14.0.0 20231129 (experimental) and
CONFIG_FORTIFY_SOURCE=y, I've noticed the following warning:

...
In function 'fortify_memcpy_chk',
    inlined from 'ax88796c_tx_fixup' at drivers/net/ethernet/asix/ax88796c_main.c:287:2:
./include/linux/fortify-string.h:588:25: warning: call to '__read_overflow2_field'
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  588 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
...

This call to 'memcpy()' is interpreted as an attempt to copy TX_OVERHEAD
(which is 8) bytes from 4-byte 'sop' field of 'struct tx_pkt_info' and
thus overread warning is issued. Since we actually want to copy both
'sop' and 'seg' fields at once, use the convenient 'struct_group()' here.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: prefer 'sizeof_field(struct tx_pkt_info, tx_overhead)' over the
hardcoded constant (Jakub Kicinski)
---
 drivers/net/ethernet/asix/ax88796c_main.c | 2 +-
 drivers/net/ethernet/asix/ax88796c_main.h | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/asix/ax88796c_main.c b/drivers/net/ethernet/asix/ax88796c_main.c
index e551ffaed20d..11e8996b33d7 100644
--- a/drivers/net/ethernet/asix/ax88796c_main.c
+++ b/drivers/net/ethernet/asix/ax88796c_main.c
@@ -284,7 +284,7 @@ ax88796c_tx_fixup(struct net_device *ndev, struct sk_buff_head *q)
 	ax88796c_proc_tx_hdr(&info, skb->ip_summed);
 
 	/* SOP and SEG header */
-	memcpy(skb_push(skb, TX_OVERHEAD), &info.sop, TX_OVERHEAD);
+	memcpy(skb_push(skb, TX_OVERHEAD), &info.tx_overhead, TX_OVERHEAD);
 
 	/* Write SPI TXQ header */
 	memcpy(skb_push(skb, spi_len), ax88796c_tx_cmd_buf, spi_len);
diff --git a/drivers/net/ethernet/asix/ax88796c_main.h b/drivers/net/ethernet/asix/ax88796c_main.h
index 4a83c991dcbe..68a09edecab8 100644
--- a/drivers/net/ethernet/asix/ax88796c_main.h
+++ b/drivers/net/ethernet/asix/ax88796c_main.h
@@ -25,7 +25,7 @@
 #define AX88796C_PHY_REGDUMP_LEN	14
 #define AX88796C_PHY_ID			0x10
 
-#define TX_OVERHEAD			8
+#define TX_OVERHEAD     sizeof_field(struct tx_pkt_info, tx_overhead)
 #define TX_EOP_SIZE			4
 
 #define AX_MCAST_FILTER_SIZE		8
@@ -549,8 +549,10 @@ struct tx_eop_header {
 };
 
 struct tx_pkt_info {
-	struct tx_sop_header sop;
-	struct tx_segment_header seg;
+	struct_group(tx_overhead,
+		struct tx_sop_header sop;
+		struct tx_segment_header seg;
+	);
 	struct tx_eop_header eop;
 	u16 pkt_len;
 	u16 seq_num;
-- 
2.43.0


