Return-Path: <netdev+bounces-31896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14912791417
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 10:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8821C20849
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534C71384;
	Mon,  4 Sep 2023 08:56:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482697E
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 08:56:18 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8C5CC7
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 01:56:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B243F1BF20D;
	Mon,  4 Sep 2023 08:56:08 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Scott Dial <scott@scottdial.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] Revert "net: macsec: preserve ingress frame ordering"
Date: Mon,  4 Sep 2023 10:56:04 +0200
Message-Id: <11c952469d114db6fb29242e1d9545e61f52f512.1693757159.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This reverts commit ab046a5d4be4c90a3952a0eae75617b49c0cb01b.

It was trying to work around an issue at the crypto layer by excluding
ASYNC implementations of gcm(aes), because a bug in the AESNI version
caused reordering when some requests bypassed the cryptd queue while
older requests were still pending on the queue.

This was fixed by commit 38b2f68b4264 ("crypto: aesni - Fix cryptd
reordering problem on gcm"), which pre-dates ab046a5d4be4.

Herbert Xu confirmed that all ASYNC implementations are expected to
maintain the ordering of completions wrt requests, so we can use them
in MACsec.

On my test machine, this restores the performance of a single netperf
instance, from 1.4Gbps to 4.4Gbps.

Link: https://lore.kernel.org/netdev/9328d206c5d9f9239cae27e62e74de40b258471d.1692279161.git.sd@queasysnail.net/T/
Link: https://lore.kernel.org/netdev/1b0cec71-d084-8153-2ba4-72ce71abeb65@byu.edu/
Link: https://lore.kernel.org/netdev/d335ddaa-18dc-f9f0-17ee-9783d3b2ca29@mailbox.tu-dresden.de/
Fixes: ab046a5d4be4 ("net: macsec: preserve ingress frame ordering")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index c3f30663070f..b7e151439c48 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1330,8 +1330,7 @@ static struct crypto_aead *macsec_alloc_tfm(char *key, int key_len, int icv_len)
 	struct crypto_aead *tfm;
 	int ret;
 
-	/* Pick a sync gcm(aes) cipher to ensure order is preserved. */
-	tfm = crypto_alloc_aead("gcm(aes)", 0, CRYPTO_ALG_ASYNC);
+	tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
 
 	if (IS_ERR(tfm))
 		return tfm;
-- 
2.40.1


