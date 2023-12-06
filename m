Return-Path: <netdev+bounces-54437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1AE807104
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F6EB20DAD
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEC039FE5;
	Wed,  6 Dec 2023 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Mj/5/sf6"
X-Original-To: netdev@vger.kernel.org
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26C0C7
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 05:41:06 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:2a02:0:640:77d9:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTP id 4485560AD6;
	Wed,  6 Dec 2023 16:40:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id qecav2GoImI0-tZ8K6hwd;
	Wed, 06 Dec 2023 16:40:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1701870054; bh=MVPb2ksgSORGzA7X85P+tSHXuAYiBOYhAvN5EBIRAQI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Mj/5/sf66LY/JF61Iq0A8RLFF4ANrk/3RguwBhoSVS5JRTLTzr79w12yhK3XTMmye
	 4pGrZGQnXVgZDJ8sRG2QB0b5eRu+cVskc/ADAwWbQyOm3HeCciHOkQ1mHkjSaf3RIC
	 Y0sMT1ZD3NGkijnMbT8kbpJS1JrrY8Z7mstLyKwI=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Cc: netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] net: asix: fix fortify warning
Date: Wed,  6 Dec 2023 16:38:04 +0300
Message-ID: <20231206133822.620802-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
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
thus overread warning is issued. Since we actually wants to copy both
'sop' and 'seg' fields at once, use the convenient 'struct_group()' here.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/ethernet/asix/ax88796c_main.c | 2 +-
 drivers/net/ethernet/asix/ax88796c_main.h | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

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
index 4a83c991dcbe..678b47b29042 100644
--- a/drivers/net/ethernet/asix/ax88796c_main.h
+++ b/drivers/net/ethernet/asix/ax88796c_main.h
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


