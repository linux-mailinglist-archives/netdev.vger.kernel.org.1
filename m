Return-Path: <netdev+bounces-117365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9578794DAE3
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721851C20C0A
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72DB13B59A;
	Sat, 10 Aug 2024 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GP5OuZ3I"
X-Original-To: netdev@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73689ECF;
	Sat, 10 Aug 2024 05:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723267627; cv=none; b=JDzKn/u7FrYoFWi7/CNI/CASYgWajzfoHTTz0cjEZ+SIymd+D09Pk0hvTIZHtC2L0yiRyhex/frWZKv5PAka1zQhc4OW4AALIshh9y3z3BsBy04bd+9+9REVdc1l+5IQf+oTaPfREuikJXMAttUEXMpoODj7hxtvu7Za7/WgBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723267627; c=relaxed/simple;
	bh=Z1dDNMmhoGRIADyC1DV4rKCR6DP6n8E9Af7+H9c8yX8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=OCHLxb+7GtVeFNQmGy4Jz0HgZNJs0mFRLNiXpBdbigeg3p8nnBgq49y7rZwaGeBUQK2pWwLZ1wG5dqqXClTBDQ8rX9EElbf02yU2kj0Usxi8b2A6NHrE9PMPJ7fFPfnCK+ezk4ts0zM6bjflcmUVyksD3FvcQbAaynZZYfe/cQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GP5OuZ3I; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723267614; bh=DNEQcqDUE4PNXMibpgqMEP0OfxbegUYXYvKRLwOt+y0=;
	h=From:To:Cc:Subject:Date;
	b=GP5OuZ3IitBs+VJxy/7nKBEOQ+zvzNWqBWiQXRx3jJvay0q+gwPSXU758Jjmhq8LI
	 5GH500QCY1kkeDVmXCXOo4acSUMpY4EAyoY0Ny7ZuyVFjQyhGbWfV9N+vuAo865OnZ
	 3W3sJCcDe2Wtx3GKkYLmVWEkhNoJXzhjGCB5xVBw=
Received: from DESKTOP-3UD078L.lan ([2001:da8:204:1952:dd12:82c1:7784:3c5d])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 6B3A8023; Sat, 10 Aug 2024 13:26:51 +0800
X-QQ-mid: xmsmtpt1723267611taop3ihmk
Message-ID: <tencent_7962673263816B802001C50C5EE77D0DF405@qq.com>
X-QQ-XMAILINFO: OCCQRJgnTnKdsQQ0XX8FEM5eiTI+HvylHFTEM/p6k63rPIcvtH+itBxFosdWvR
	 BYOw0uJ7aBAIWu9Pm8GgWCYbMw3E139VsSkx8z1DyuJ0xCzmxQ+JpptoAHQwt/y0+epZAdruU7+d
	 C4wVyF3eyX2A65QAM00eEPwjHrJo++Whg4HONKHyA+31KXCjDppypHXVU3pGafmYSy0IKmBElEbu
	 lTqrbuwTbfB35mop3X/xJfNREgMCrLG3joaKrT6TYwXn6MOCFVsX7ji7GLTY7xjJZ6i0zsjrgXUN
	 WJKrLTqzPyh0Jxw6W0J1KilW0MPRBMI4TdNUQVf7lbVmhkDtIkF1NrMbYyZpsDK9UA2JDV/UcH7A
	 86AT+La7uzbp7GUCYdzN4r9N6zmTD5jw+PrPv79onczFUt0r2CKz4LxOmIosb7BuZsL/OjFPmNQq
	 T4R722x3gJfbVF4tQJKX1pwHYbwqro2oEBMwc2t3ndtsTaYc3mqjc1iRZw5LarpkVY33yEyMJK14
	 aBzR+mp3MtdDoDGhdTbi7Ip+5Rym/Lbvc08K8McZV2/oxRmaZrB1baPzh/9gB7svIsvRMiJGSJmQ
	 ib5/cIWPgAx+jLmBGP3S/4vfiETtdIZI3hvqLc5sF0VvThLHwI84LYxG5783IDkqs0tuWfXi0iT7
	 PYWZ7IXSdf340oGwRBJOvCDG0kekD3QtD1XBTKERLHyP3FjzQzrzlDJiAnlHZ+yrHcXix/Cdz7pT
	 JmYQXNU0S48JjIjjgDCWXQ2pMVKBdAFOBC9KzOah1G5ysFP4W5atPw81W0jLIV4MLzdEoUd8Ad6a
	 JYCo70uvdxM5AK5Re/4xFVcAsj4VZnl1dfG1DCvvz4b6ZmAjSMmqtQmMCbHlQwrnexEymKf6umnF
	 sUfYZ72we5sRDpCAAhw9DgqOguIDE9Csd3Cvl8P6CUTY3y+NM09JSk7ROA7WMepkqHpJVs/dW9sv
	 G5XnFRhEcF4bhv7NyA5oJy4+3oPu7DHG3HuOXpt03p3Ys8UoGl3NBCn8T0FWV0fMaYkde7MzTWbZ
	 GKC7Hzy2Zne/onrro+
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: everything411@qq.com
To: nbd@nbd.name,
	netdev@vger.kernel.org
Cc: sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: mtk_wed: fix use-after-free panic in mtk_wed_setup_tc_block_cb()
Date: Sat, 10 Aug 2024 13:26:51 +0800
X-OQ-MSGID: <20240810052651.27124-1-everything411@qq.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zheng Zhang <everything411@qq.com>

When there are multiple ap interfaces on one band and with WED on,
turning the interface down will cause a kernel panic on MT798X.

Previously, cb_priv was freed in mtk_wed_setup_tc_block() without
marking NULL,and mtk_wed_setup_tc_block_cb() didn't check the value, too.

Assign NULL after free cb_priv in mtk_wed_setup_tc_block() and check NULL
in mtk_wed_setup_tc_block_cb().

----------
Unable to handle kernel paging request at virtual address 0072460bca32b4f5
Call trace:
 mtk_wed_setup_tc_block_cb+0x4/0x38
 0xffffffc0794084bc
 tcf_block_playback_offloads+0x70/0x1e8
 tcf_block_unbind+0x6c/0xc8
...
---------

Fixes: 799684448e3e ("net: ethernet: mtk_wed: introduce wed wo support")
Signed-off-by: Zheng Zhang <everything411@qq.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 61334a71058c..68c49df80f43 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -2666,14 +2666,15 @@ mtk_wed_setup_tc_block_cb(enum tc_setup_type type, void *type_data, void *cb_pri
 {
 	struct mtk_wed_flow_block_priv *priv = cb_priv;
 	struct flow_cls_offload *cls = type_data;
-	struct mtk_wed_hw *hw = priv->hw;
+	struct mtk_wed_hw *hw = NULL;
 
-	if (!tc_can_offload(priv->dev))
+	if (!priv || !tc_can_offload(priv->dev))
 		return -EOPNOTSUPP;
 
 	if (type != TC_SETUP_CLSFLOWER)
 		return -EOPNOTSUPP;
 
+	hw = priv->hw;
 	return mtk_flow_offload_cmd(hw->eth, cls, hw->index);
 }
 
@@ -2729,6 +2730,7 @@ mtk_wed_setup_tc_block(struct mtk_wed_hw *hw, struct net_device *dev,
 			flow_block_cb_remove(block_cb, f);
 			list_del(&block_cb->driver_list);
 			kfree(block_cb->cb_priv);
+			block_cb->cb_priv = NULL;
 		}
 		return 0;
 	default:
-- 
2.39.2


