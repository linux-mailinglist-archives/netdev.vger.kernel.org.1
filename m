Return-Path: <netdev+bounces-16700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DF374E71E
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 08:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5FF1C209B8
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 06:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01CB1642C;
	Tue, 11 Jul 2023 06:21:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E196663E
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:21:14 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F4AE51
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 23:21:11 -0700 (PDT)
X-QQ-mid: bizesmtp80t1689056462t4af5kjv
Received: from wxdbg.localdomain.com ( [183.128.130.21])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Jul 2023 14:20:53 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: 2w1wQVt6itRRsVjPsoB2x9VyBbcFwPj573st57rYlUm9HuyJKsZatvz37kCkT
	xtULD4OlS/g/oDphKjojEo2ZBZmWf3UbLMp8l6fWSfmQI0+bSyogBY8TwSUPI/JtN3BQvJp
	EWH5erKcUjZjKqt9CavI0oTR2mHGqlWoBiSGYKr7bQ/RjJlh3c8/eLlU1crBER/RvUAytSJ
	PhcH9fyFI49+6RMTNksdXT/ESGacRHY/ilgiu3YFaXuZEpHAVZjVvQJB5NYh0Phum2A4jWp
	dQft4dlAJehryCu+EsgPvSft9xulp2J9lMjg3IpgNCVbi/tpPBjWdSqI2rZju22K9rG7PGI
	Hn8nWI+6G8thrJLplfKZ1NOBzIHkkxAvhzIJ2AmK5W3mc3SZYcHe45qeSedtQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16778761747529231806
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: txgbe: fix eeprom calculation error
Date: Tue, 11 Jul 2023 14:34:14 +0800
Message-Id: <20230711063414.3311-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For some device types like TXGBE_ID_XAUI, *checksum computed in
txgbe_calc_eeprom_checksum() is larger than TXGBE_EEPROM_SUM. Remove the
limit on the size of *checksum.

Fixes: 049fe5365324 ("net: txgbe: Add operations to interact with firmware")
Fixes: 5e2ea7801fac ("net: txgbe: Fix unsigned comparison to zero in txgbe_calc_eeprom_checksum()")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
index 12405d71c5ee..0772eb14eabf 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
@@ -186,9 +186,6 @@ static int txgbe_calc_eeprom_checksum(struct wx *wx, u16 *checksum)
 	if (eeprom_ptrs)
 		kvfree(eeprom_ptrs);
 
-	if (*checksum > TXGBE_EEPROM_SUM)
-		return -EINVAL;
-
 	*checksum = TXGBE_EEPROM_SUM - *checksum;
 
 	return 0;
-- 
2.27.0


