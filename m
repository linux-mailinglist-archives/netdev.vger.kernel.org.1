Return-Path: <netdev+bounces-42928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ADF7D0B06
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081A128115E
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFF910A14;
	Fri, 20 Oct 2023 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E32010955
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:00:33 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 04C4EAB;
	Fri, 20 Oct 2023 02:00:29 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 5758960494CD8;
	Fri, 20 Oct 2023 17:00:17 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: Su Hui <suhui@nfschina.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] net: dsa: mv88e6xxx: add an error code check in mv88e6352_tai_event_work
Date: Fri, 20 Oct 2023 17:00:04 +0800
Message-Id: <20231020090003.200092-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mv88e6xxx_tai_write() can return error code (-EOPNOTSUPP ...) if failed.
So check the value of 'ret' after calling mv88e6xxx_tai_write().

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/dsa/mv88e6xxx/ptp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index ea17231dc34e..56391e09b325 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -182,6 +182,10 @@ static void mv88e6352_tai_event_work(struct work_struct *ugly)
 	mv88e6xxx_reg_lock(chip);
 	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_EVENT_STATUS, status[0]);
 	mv88e6xxx_reg_unlock(chip);
+	if (err) {
+		dev_err(chip->dev, "failed to write TAI status register\n");
+		return;
+	}
 
 	/* This is an external timestamp */
 	ev.type = PTP_CLOCK_EXTTS;
-- 
2.30.2


