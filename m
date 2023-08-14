Return-Path: <netdev+bounces-27399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD0877BD25
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1E11C209ED
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3036C2DC;
	Mon, 14 Aug 2023 15:35:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43049C2C9
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558D8C433C9;
	Mon, 14 Aug 2023 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692027329;
	bh=sH4rINd0cTqIAhn3TtM/4TmeL4tguqZHMlefGVik+tE=;
	h=From:To:Cc:Subject:Date:From;
	b=ZbsCsY4kKkchgSWzIl9OgiHJvOwAFiVPYVr6EhBPCnguzUElLWHJ5bgwx+WGtQyHt
	 sqrWktWqXNIVwPgOviLRZ8Z/UwkTs3rzK/8ckhIkQ6NbUCFVPxrozy+OApJMPdo2W4
	 SNIPf0PoIr4t0LZI+YFFcAG83yJ8Yg9yXI1B8HnYb3mJM5eoBbVTkfzKBXonsHduKo
	 0iKMvFpt70H3s+N0PVffefq1lsuTQ6tj8F2li+YALXrvCh5/MZHPzeXus1TqttKJqc
	 DM2aJcNVVVF1YkHRRtvGS9ae5lb94OwSyUTulwiKHRQ3t5KO0w1+jxN5COLxmHQo+x
	 lMmzGAvD1M26g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	hayeswang@realtek.com,
	bjorn@mork.no,
	linux-usb@vger.kernel.org
Subject: [PATCH net-next] eth: r8152: try to use a normal budget
Date: Mon, 14 Aug 2023 08:35:21 -0700
Message-ID: <20230814153521.2697982-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mario reports that loading r8152 on his system leads to a:

  netif_napi_add_weight() called with weight 256

warning getting printed. We don't have any solid data
on why such high budget was chosen, and it may cause
stalls in processing other softirqs and rt threads.
So try to switch back to the default (64) weight.

If this slows down someone's system we should investigate
which part of stopping starting the NAPI poll in this
driver are expensive.

Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/all/0bfd445a-81f7-f702-08b0-bd5a72095e49@amd.com/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hayeswang@realtek.com
CC: bjorn@mork.no
CC: linux-usb@vger.kernel.org
---
 drivers/net/usb/r8152.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index db9897e825b4..bb234cf0cea0 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9760,8 +9760,7 @@ static int rtl8152_probe(struct usb_interface *intf,
 
 	usb_set_intfdata(intf, tp);
 
-	netif_napi_add_weight(netdev, &tp->napi, r8152_poll,
-			      tp->support_2500full ? 256 : 64);
+	netif_napi_add(netdev, &tp->napi, r8152_poll);
 
 	ret = register_netdev(netdev);
 	if (ret != 0) {
-- 
2.41.0


