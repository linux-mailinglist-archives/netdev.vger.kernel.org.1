Return-Path: <netdev+bounces-219471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88CDB41750
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2FA7A8170
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F122E1F03;
	Wed,  3 Sep 2025 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="HR/wXGE/"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE472E0B44;
	Wed,  3 Sep 2025 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886092; cv=none; b=Ilv4/ppTb3ICCV5EOSPBAN7rY69NcnpzHthEECpXBXaROyB7a8ijoV8Rnl5eExiNXuZzi/lrzNCjucsHJvzmXTCJI/ly0R0zh+qtkNqB8MJ3dzm96bncUStyYyrQVUWzXFR7U17CIicq1MSWz7jupip4OZhOGumyf/g9fs+W29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886092; c=relaxed/simple;
	bh=gnR1bN4f585sAR+aIfz3xySKJKZ+0Tyw9oY35sth0I4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=S6bkcFq7ci7wQ9whk3zujd+o3rYEC8pIUZVwjZ5f2YCu4iD181bY355Foo0dVQmO9Yzlxt/02yLY1w1pmj+heF+dzvfDkbzrC8N0wykL4DOb+YURTP52eXLDia0NyrfqXXCCiFiPN7PfU5IkXZchWVCthambSznNT79hbiLzYw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=HR/wXGE/; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756885783;
	bh=vzMRSNquciMXGu8CwgqTnQ8mVrWWx/y+NRlacn/1wyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HR/wXGE/KlTH6Um+r73VKHRCiALo8wOI5wShGr0utNZSrcmLM23EaqLYVMqIkeo4o
	 GUB65WBqIhcROp5EiJzAJertLy+3bfh2FHxVSp94UAMMWcLL8E63x55SERpbc96f4a
	 wpk82uW0EJOdwDNmjnDC9pKBF8hq+9WbWRGHID+c=
Received: from localhost.localdomain ([112.94.77.11])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id C69804DE; Wed, 03 Sep 2025 15:49:41 +0800
X-QQ-mid: xmsmtpt1756885781te2ww6i6a
Message-ID: <tencent_160BBED8A83CECDE110A344B51B6229B1209@qq.com>
X-QQ-XMAILINFO: Me8mHstNM5a8lCEGyOeB2iBqRUF6Z995iNftjEIEjBpIpA7H6UrG9igKltqiLB
	 5KsZ1fVl/e/qd9lH7WdqD5sXyGsz33vT2UUvASLtNG6QxRid/fIOH3qUPtvSdWsBJFPtmz3+M7GW
	 +OAJ6TkmZYzFm+06/X/pkJkddww9Z6h6+AxKcLWeFwTps8rTc2XGsNSwygXsTvgds1YAPK+Fb0AS
	 wSTZRR0SONaRiquWhZYzm42Lsjd5D+pEWfKXAUjZZAh2wJTUPrMeopryyA2Jk23GQJf4FuS5qQhG
	 N5XqqTETAiUxIdB6UNM/4CoRT2J7TiCm3HTAe9eDi9IASQ0iCJhTLhiuNV8xQXq/B1Vgjr5mJ1Bl
	 WO8xOwxaG1REERwQL+MkGvIfWkVnODaW2PIIOGdTZB7SBoWTpiFG7mj6mK6gtrU1dSapHN9qioW9
	 jzBko3SvT9Aq9rS2XYTMHLph/Rgkf79EHoJ/gCMzGyX1UXv6lAfc03MiifFhoCLcSH26oundLz98
	 akeZwIavqxNPA4GdNaGHgnlcPAaehCPv7nch3vbFinTdPv8wbVry+LOu0E7iRCK6toRwkEOujTtS
	 BmecV3hc3GooxSZ60Hal13fC9O+4W4r1CsQtlV+XsHKvOPh/OX/JuraUVPx/EAgNFnmP/HZ4FGOd
	 fivj73l4+Zx/fmGF9DgZyOfFGWUUfWkLdtTJ+a3NF4WZAekzjyWuHDMwp+nHwp6gA/tt7vh1Bb3H
	 ek0oCU5yHi+TBkDw9eKP093DR/pv74JMuMFU5J88bLTMkFTwcVKINSK1GYji3NTgPPFiuDXEVL7o
	 bH5g/85LhJKEPXUjIdAV1oABrOdljeinUsC8fLEum1wSr97/dPMo7Anp11ldCWzm/1WxkGfm/Lhx
	 G9JU1EdVb6T6CeS1o8+f1oxwe55YjgMMO2TWV3JPTjG67vZvcLNIUB5FR9E/XGe8iFqbPQ0MFqY2
	 5OlYx1jAM+OiooeYsEpYccSgSiEx1SH4Qb24G92WGMqQTLu5VTyDbwm5yisIRqh6gMSi9JgR+zGC
	 /ayAMkJ5O7OINCZdBK+8izZw2ZXgT3NHX88eREeQFfLxOSJYhnucoh59FnaBuxXGfucAYyxAhamI
	 mFcZwOYV1mCsRAKBBAhhkEHi0VDRkEOeehabMw
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Conley Lee <conleylee@foxmail.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	wens@csie.org,
	mripard@kernel.org
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conley Lee <conleylee@foxmail.com>
Subject: [PATCH] net: ethernet: sun4i-emac: free dma descriptor
Date: Wed,  3 Sep 2025 15:49:39 +0800
X-OQ-MSGID: <20250903074939.503937-1-conleylee@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250902155731.05a198d7@kernel.org>
References: <20250902155731.05a198d7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current implementation of the sun4i-emac driver, when using DMA to
receive data packets, the descriptor for the current DMA request is not
released in the rx_done_callback.

Fix this by properly releasing the descriptor.

Fixes: 47869e82c8b8 ("sun4i-emac.c: add dma support")
Signed-off-by: Conley Lee <conleylee@foxmail.com>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 2f516b950..2f990d0a5 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -237,6 +237,7 @@ emac_alloc_dma_req(struct emac_board_info *db,
 
 static void emac_free_dma_req(struct emac_dma_req *req)
 {
+	dmaengine_desc_free(req->desc);
 	kfree(req);
 }
 
-- 
2.25.1


