Return-Path: <netdev+bounces-30761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8313A788F19
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DBF28145E
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 19:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74B118B0E;
	Fri, 25 Aug 2023 19:04:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC87EEC1
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 19:04:40 +0000 (UTC)
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9413F2137;
	Fri, 25 Aug 2023 12:04:23 -0700 (PDT)
Received: from tundra.lovozera (unknown [83.149.199.65])
	by mail.ispras.ru (Postfix) with ESMTPSA id 19AE640F1DD2;
	Fri, 25 Aug 2023 19:04:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 19AE640F1DD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1692990260;
	bh=HOjQG4CO6mnS8bovh06OkveWowgxs5Vdjds2wSVYyBo=;
	h=From:To:Cc:Subject:Date:From;
	b=A4pejQaX5waupoG1rPPOAkeLrru+8B/2KDbQ4TvPAAl5gn8u4JLQKgM/2V7rjX+mv
	 e1CgynrK6ktYFtiyRB9eIZu2GzdSZVKYCXJwKkRn6nju4SJRSMr4bjcENOXXyWrsD4
	 LH/2ry9plKHTqwhg1YhWJrD1N32b/Q5G4p2stMaU=
From: Mikhail Kobuk <m.kobuk@ispras.ru>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: Mikhail Kobuk <m.kobuk@ispras.ru>,
	Prashant Sreedharan <prashant@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] ethernet: tg3: remove unreachable code
Date: Fri, 25 Aug 2023 22:04:41 +0300
Message-ID: <20230825190443.48375-1-m.kobuk@ispras.ru>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

'tp->irq_max' value is either 1 [L16336] or 5 [L16354], as indicated in
tg3_get_invariants(). Therefore, 'i' can't exceed 4 in tg3_init_one()
that makes (i <= 4) always true. Moreover, 'intmbx' value set at the
last iteration is not used later in it's scope.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 78f90dcf184b ("tg3: Move napi_add calls below tg3_get_invariants")
Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/net/ethernet/broadcom/tg3.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 5ef073a79ce9..6b6da2484dfe 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17792,10 +17792,7 @@ static int tg3_init_one(struct pci_dev *pdev,
 		tnapi->tx_pending = TG3_DEF_TX_RING_PENDING;
 
 		tnapi->int_mbox = intmbx;
-		if (i <= 4)
-			intmbx += 0x8;
-		else
-			intmbx += 0x4;
+		intmbx += 0x8;
 
 		tnapi->consmbox = rcvmbx;
 		tnapi->prodmbox = sndmbx;
-- 
2.42.0


