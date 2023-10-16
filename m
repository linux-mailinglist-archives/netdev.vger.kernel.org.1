Return-Path: <netdev+bounces-41236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9BA7CA45D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40ED21C20C95
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32051CFB4;
	Mon, 16 Oct 2023 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E4415ADD
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:37:35 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887CCAD
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:37:33 -0700 (PDT)
X-QQ-mid: bizesmtp69t1697448984tm373wo9
Received: from wxdbg.localdomain.com ( [125.119.254.108])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Oct 2023 17:36:09 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: ewYKOXkC48FaQJQgRa5nvstxiAZBbN8MnvSmUX3KY6jySUSbG2al4XQekOdpZ
	/NVqZJqDqUoJtph4ncbaDKHg8IQtgjT+fOU6SQwkUjAb0JfGEBsFSjD9PcGQ+5z9fxoYIA3
	4vDmO3vhaIbBv1PuY0hKFzJScU9jINzYjsUreomZIuXsaxFVqKl4KXXga+YeQmL2JrGnTtJ
	BS9Tg+uhSka+AchkvRonHELOZrcelM4izpE1NC3o97DifBpekr+ZVir/ZQYIcHj5utaRKmV
	CJOiePRac6SOiGJ7LeQOo3AYEeOIhK/Ao4s8e+InShhB7uU+eoROQXc6/lHDTevHo97so4f
	NzzDneG1nTKQayGjzmEHhtugBmr6Rdx7oLslXdtDD7i9ZDGTYfqpvcqv1EtGykV4Au0dZuc
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15737550013515372085
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH] net: txgbe: clean up PBA string
Date: Mon, 16 Oct 2023 17:48:31 +0800
Message-Id: <20231016094831.139939-1-jiawenwu@trustnetic.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Replace deprecated strncpy with strscpy, and add the missing PBA prints.

This issue is reported by: Justin Stitt <justinstitt@google.com>
Link: https://lore.kernel.org/netdev/002101d9ffdd$9ea59f90$dbf0deb0$@trustnetic.com/T/#t

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 394f699c51da..123e3ca78ef0 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -741,8 +741,9 @@ static int txgbe_probe(struct pci_dev *pdev,
 	/* First try to read PBA as a string */
 	err = txgbe_read_pba_string(wx, part_str, TXGBE_PBANUM_LENGTH);
 	if (err)
-		strncpy(part_str, "Unknown", TXGBE_PBANUM_LENGTH);
+		strscpy(part_str, "Unknown", sizeof(part_str));
 
+	netif_info(wx, probe, netdev, "PBA No: %s\n", part_str);
 	netif_info(wx, probe, netdev, "%pM\n", netdev->dev_addr);
 
 	return 0;
-- 
2.27.0


