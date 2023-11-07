Return-Path: <netdev+bounces-46396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 933D17E3B22
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 12:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4345F280F1E
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2206B2D795;
	Tue,  7 Nov 2023 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="jeevOxww"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D652D05E
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 11:30:44 +0000 (UTC)
X-Greylist: delayed 369 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Nov 2023 03:30:42 PST
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEECDED
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 03:30:41 -0800 (PST)
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id C19EA1C0E4B
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 14:24:29 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1699356269; x=
	1700220270; bh=x6jysyZ5oZimszC/+KWYqfqt9dmO+sPqmSEiLu28WpI=; b=j
	eevOxwwE+o124s2+4JWdvCdCGwW1zD5b4AUpIuf/A5S3BF+fCeFPdsbUJYEkbqR/
	9sVdVVTCDdCHlEPbGk3x+1h5lELxBy1b7YorfDabMDgMBZ6mzKRjU3FuN4aARsWJ
	64tr3HTurdGnEqwNSr3Arf8LUhw6y3upkk62+7jl5Q=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SdSNP73M8cae for <netdev@vger.kernel.org>;
	Tue,  7 Nov 2023 14:24:29 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
	by mail.nppct.ru (Postfix) with ESMTPSA id C3F401C0859;
	Tue,  7 Nov 2023 14:24:27 +0300 (MSK)
From: Andrey Shumilin <shum.sdl@nppct.ru>
To: 3chas3@gmail.com
Cc: Andrey Shumilin <shum.sdl@nppct.ru>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] iphase: Adding a null pointer check
Date: Tue,  7 Nov 2023 14:24:19 +0300
Message-Id: <20231107112419.14404-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pointer <dev->desc_tbl[i].iavcc> is dereferenced on line 195.
Further in the code, it is checked for null on line 204.
It is proposed to add a check before dereferencing the pointer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
---
 drivers/atm/iphase.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index 324148686953..596422fbfacc 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -192,6 +192,11 @@ static u16 get_desc (IADEV *dev, struct ia_vcc *iavcc) {
            i++;
            continue;
         }
+       if (!(iavcc_r = dev->desc_tbl[i].iavcc)) {
+	   printk("Fatal err, desc table vcc or skb is NULL\n");
+	   i++;
+	   continue;
+	}
         ltimeout = dev->desc_tbl[i].iavcc->ltimeout; 
         delta = jiffies - dev->desc_tbl[i].timestamp;
         if (delta >= ltimeout) {
-- 
2.30.2


