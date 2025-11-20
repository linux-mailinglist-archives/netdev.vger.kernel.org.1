Return-Path: <netdev+bounces-240364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ACFC73C8F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 426942A702
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 11:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091F224BBFD;
	Thu, 20 Nov 2025 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YTvaOEKs"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BBE30C616;
	Thu, 20 Nov 2025 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638997; cv=none; b=IxVjWM0Im4F5cBh9uJQYnmGNAUzf5F2HXhTYYSF2Jq5dZoT/yhyZONhv3m5i/GT2E7aOavblKAaSbhofpitnnzLNex/4JYGtxLVU8GvPRTPVbfeHlIUWiaCyqZFVc9EZlc6TJC23exRBAC5+Iaan+O91dpZ0k5K+s8/s7hGed3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638997; c=relaxed/simple;
	bh=zqVWV2QeIlrdnAm3DssJ0HFs5drSidU78EULLxvBlLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MbeM+3S2Q+hIHQ6wK+FoPIViW3RJhCTmM4fbvbkgxdg8tEjGyyaaTPwDFcxZFywz+11yUKOl+gnojYmQsI62d+bQpGlKb8JxOZahayXhKh3mNYslJh8sGoLstlEluCA8Nx0LGLuJN17RwpQQ1fcedqLV7n4VCHZ9JADfjqeKZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YTvaOEKs; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yr
	fK23LrUAkQKtQxkuCa4V9B+UAkoTk1hAX4TlCz0hc=; b=YTvaOEKsJdQ/sa+xp/
	iWW0Wv9wVi3/rXyO62bSzWMa3UDsiBGm3LBqGBOPfxpgrj8NneaXE/uA1rwmKkBX
	FY2gZgGkWkq0UMAZmqvPFvBts8WHFiDvD5S1TNE4KYTmrBxJWF5qpZzsUTcxv1Ip
	8+pnsQsBz2UOclSvBAu1tuZEg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBXs11d_h5pwg45Bg--.2183S2;
	Thu, 20 Nov 2025 19:41:20 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mani@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] net: wwan: mhi: Keep modem name match with Foxconn T99W640
Date: Thu, 20 Nov 2025 19:41:15 +0800
Message-Id: <20251120114115.344284-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXs11d_h5pwg45Bg--.2183S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyUuFyUtrWDtr1xXr4ktFb_yoWkWFXE9r
	n5XFnrXw4jgFyYkFn7GF43ZFyfJwn7XFn2vF1Sv398JF92q343Wr4rZF4xXrWqgrnrJF9r
	ur1DZ3WYy3yxKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKeOJUUUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGQ4MZGke-YoUUwAAs4

Correct it since M.2 device T99W640 has updated from T99W515.
We need to align it with MHI side otherwise this modem can't
get the network.

Fixes: ae5a34264354 ("bus: mhi: host: pci_generic: Fix the modem name of Foxconn T99W640")
Fixes: 65bc58c3dcad ("net: wwan: mhi: make default data link id configurable")
Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/net/wwan/mhi_wwan_mbim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index a142af59a91f..1d7e3ad900c1 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -98,7 +98,7 @@ static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim
 static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
 {
 	if (strcmp(cntrl->name, "foxconn-dw5934e") == 0 ||
-	    strcmp(cntrl->name, "foxconn-t99w515") == 0 ||
+	    strcmp(cntrl->name, "foxconn-t99w640") == 0 ||
 	    strcmp(cntrl->name, "foxconn-t99w760") == 0)
 		return WDS_BIND_MUX_DATA_PORT_MUX_ID;
 
-- 
2.25.1


