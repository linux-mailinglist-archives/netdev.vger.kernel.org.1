Return-Path: <netdev+bounces-43260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB1E7D1EDC
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 20:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8E8B20E7F
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73F1E536;
	Sat, 21 Oct 2023 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="az72N/+V"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208EEDF4F
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 18:04:02 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECB2E0
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 11:04:00 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id uGKJqVjkbvhM3uGKKqJsb4; Sat, 21 Oct 2023 20:03:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1697911439;
	bh=WGG4h3fjFFGpf7YbjWTDEm1O70pn20++HFr6LfKdydw=;
	h=From:To:Cc:Subject:Date;
	b=az72N/+VVqLJjQfVTcgZ4ikmpD61YAW5vF1x8FXwB4ztn4zLiyLT8trgH+bnLdIIl
	 Kj1fX7IhGKpLllE/jz9ugHU7aeEtzbsC/qLpem930KKhixLtBl1s+96flijMwKy8hm
	 JGH6RpVsS9NGSv6SANu0DfjDyD6a/riJs5AkiPSvD9UPehB6FBBOm9oNxIIvHtU4WU
	 pvzQDqQYtm0+MqsPrTGPxA06EGnG5nvU3FRIEeRirCWBenTNqxDqwt9sBsicrzJLq6
	 HKAj/kO4BiNCT2eDRw55nOzwdhFi8R02vudrIFBFn4YBB5MBvT2CMyK2r6L7O10/kP
	 /mw23XndOpY0g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Oct 2023 20:03:59 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: keescook@chromium.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stefan Schmidt <stefan@osg.samsung.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net] net: ieee802154: adf7242: Fix some potential buffer overflow in adf7242_stats_show()
Date: Sat, 21 Oct 2023 20:03:53 +0200
Message-Id: <7ba06db8987298f082f83a425769fe6fa6715fe7.1697911385.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strncat() usage in adf7242_debugfs_init() is wrong.
The size given to strncat() is the maximum number of bytes that can be
written, excluding the trailing NULL.

Here, the size that is passed, DNAME_INLINE_LEN, does not take into account
the size of "adf7242-" that is already in the array.

In order to fix it, use snprintf() instead.

Fixes: 7302b9d90117 ("ieee802154/adf7242: Driver for ADF7242 MAC IEEE802154")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ieee802154/adf7242.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index a03490ba2e5b..cc7ddc40020f 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1162,9 +1162,10 @@ static int adf7242_stats_show(struct seq_file *file, void *offset)
 
 static void adf7242_debugfs_init(struct adf7242_local *lp)
 {
-	char debugfs_dir_name[DNAME_INLINE_LEN + 1] = "adf7242-";
+	char debugfs_dir_name[DNAME_INLINE_LEN + 1];
 
-	strncat(debugfs_dir_name, dev_name(&lp->spi->dev), DNAME_INLINE_LEN);
+	snprintf(debugfs_dir_name, sizeof(debugfs_dir_name),
+		 "adf7242-%s", dev_name(&lp->spi->dev));
 
 	lp->debugfs_root = debugfs_create_dir(debugfs_dir_name, NULL);
 
-- 
2.34.1


