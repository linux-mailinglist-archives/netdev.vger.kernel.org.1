Return-Path: <netdev+bounces-126623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC039972178
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5181F23638
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E1B17A586;
	Mon,  9 Sep 2024 17:59:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0C1741EF;
	Mon,  9 Sep 2024 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904785; cv=none; b=WuEplDWu41rfB7LmgFOlkEnDOJTRYKxJ0R/zpC4UMNeVGJqVxjbW2hN4Pg5EkYiMg1QNxmhE9z20+JcrFeD4l/SOdtHCCHR5nGXJLzGgW0bKkIgu+CL5c0PXN/8CqLk5hWn26fHMLzY8utTj+6M0edTA5uyn1qhdhhKOHQn4Ukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904785; c=relaxed/simple;
	bh=rd+i4Pqei55ymZw8X+adJNCn8070PELYWke/SFK+VYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oQlBb6p+JP2XMhcJc8iDrYI6FCxVjILtKrOobkoHPlR1lxzcU+GMQfDM9r0znWrwQYf4ChvEK8goqeTuyLYSLTsk7lnxSbFej5obvrQvkUqfxi6ShAFiMph2cvFltjxvtUFgT26EuHeznbqGi1jTpfWMMdldUa9eUD68l/+AYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtp78t1725904735tsqb683y
X-QQ-Originating-IP: SlWR3ebFtQFwIsKb8jWM7Nn7Avz2McDZb8Gu19RY14M=
Received: from localhost.localdomain ( [183.193.124.18])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Sep 2024 01:58:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4273995715301047773
From: Kaixin Wang <kxwang23@m.fudan.edu.cn>
To: davem@davemloft.net
Cc: wtdeng24@m.fudan.edu.cn,
	21210240012@m.fudan.edu.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>
Subject: [PATCH] net: seeq: Fix use after free vulnerability in ether3 Driver Due to Race Condition
Date: Tue, 10 Sep 2024 01:58:21 +0800
Message-Id: <20240909175821.2047-1-kxwang23@m.fudan.edu.cn>
X-Mailer: git-send-email 2.39.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

In the ether3_probe function, a timer is initialized with a callback
function ether3_ledoff, bound to &prev(dev)->timer. Once the timer is
started, there is a risk of a race condition if the module or device
is removed, triggering the ether3_remove function to perform cleanup.
The sequence of operations that may lead to a UAF bug is as follows:

CPU0                                    CPU1

                      |  ether3_ledoff
ether3_remove         |
  free_netdev(dev);   |
  put_devic           |
  kfree(dev);         |
 |  ether3_outw(priv(dev)->regs.config2 |= CFG2_CTRLO, REG_CONFIG2);
                      | // use dev

Fix it by ensuring that the timer is canceled before proceeding with
the cleanup in ether3_remove.

Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
---
 drivers/net/ethernet/seeq/ether3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/seeq/ether3.c b/drivers/net/ethernet/seeq/ether3.c
index c672f92d65e9..f9d27c9d6808 100644
--- a/drivers/net/ethernet/seeq/ether3.c
+++ b/drivers/net/ethernet/seeq/ether3.c
@@ -850,6 +850,7 @@ static void ether3_remove(struct expansion_card *ec)
 	ecard_set_drvdata(ec, NULL);
 
 	unregister_netdev(dev);
+	del_timer_sync(&priv(dev)->timer);
 	free_netdev(dev);
 	ecard_release_resources(ec);
 }
-- 
2.39.1.windows.1


