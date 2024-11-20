Return-Path: <netdev+bounces-146384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE369D339A
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A8F284724
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 06:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F929158558;
	Wed, 20 Nov 2024 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Fpyz7lNA"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D874040;
	Wed, 20 Nov 2024 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732084465; cv=none; b=f1zPxW8UCxw4mAV2imCueJvAzosP9W9FO+7TXGRqW6nsJxrkqRr1WXh31wcxPiBjUHSd0Hkj+ibIWFJIDKO0AT6zyYp3h2SbJq52kMkW+VuhTYsI+Tqx5f/xKuCia5sS2k95tCpcilpdn0ahslLXAAnnnfUyP1CTxpt/JYJUY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732084465; c=relaxed/simple;
	bh=3uumOuNXlCpu8TMT0VJQpUU4Tx+FKX2daARpB3THYQk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=oVd22zfM7cVyQwK4fVjI0FyIyp8Ev/eIs8mUeP9JG+mxvUKaZ2D3yiGVxY3lJHHe2DUUGyKDHFFaoosqmPqy2Ol50VPpFCsizZKXzznBRmv5kIJ87QV32KzYub0fwbbSL7L3owfvzI6AH9BnzGOQiNVFzRCU/tMRYcsHE0Fw2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Fpyz7lNA; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1732084457;
	bh=f6l5ar/S69nXGkZml8nQA3BBhPwpLDKxZGJrvkTNWD0=;
	h=From:To:Cc:Subject:Date;
	b=Fpyz7lNAk/WOKk2XCDg8XLERM1L26UDJ8rQqwnf1UNpP4eR0Fv4WSrhOeHSbLrrWy
	 30fhhaifOQT8Mv5ahUebQ9GnUq9Is4euBHY8PuUEi8tMKgxZlvOwGd0rKoaOF7uPAy
	 IFvLNBI7fo+QhmhYlfvtBz6yJvg0RTGpeD3Q27bQ=
Received: from localhost.localdomain ([111.48.58.13])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 6F611248; Wed, 20 Nov 2024 14:27:54 +0800
X-QQ-mid: xmsmtpt1732084074tzesikb58
Message-ID: <tencent_9E44A7B2F489B91A12A11C2639C5A4B9F40A@qq.com>
X-QQ-XMAILINFO: NCmjBvJFq6XN2aVtkB2vMkETWjYiChSTJ1rjUva3trTa8Tl8g/UVlYgjz4e+jj
	 8OxCJ89zkrYHTr06rrr54Mvi2qiAcveXAVDf4FUMAFM7KkrhTQvrPLj8+02eAMW4okyQ3wWeCayv
	 dtOO9ck8vNpgj/Dt0V0vKGRvisCitZlbAYHJMgstSq7qdYW7OYNEB0+ritCrINGbi4EP0xQXie0h
	 p73vqudjtLPvCkrzltSBcvzuwMU7kX4/xBrAP/ibjIpS0ghZhmcTo9yGCwaKk2Z1OAN0AbwDgG+G
	 rz31PJI674Pk4v+FxrHnAxpRrcCjlpH8pXAMcPcKVaQ7DIN793ASvjbILaX/6IuztRGO4PAmiPIK
	 JF0MGYbTm8RJRDyJWyeDjuUpm72ZwvXz76omvNvKyEaUhmqiXgA7UplyLQWu7RIla92URTitzeol
	 cP53lGHtj2ZQ5thcyJeJQyUsB0rJ/uv7x5mk2n6mS1/4aQ7oMwrVVW1QyUbJkBELR8e4IkLukxXA
	 YQrzbxFsUR6euwiP2wvIv92qXvEJn3gN8oph4CdbYMiYyL7ykAOHLUBz5ZfNlcm72Ch15cWXUkN9
	 6LOJOuoPgrfs93FJ8VQm5SB9YBW9iSTyXsLvAPUFeIaDNSRAX/TxGEeDw0s7KZIVSrr5HEWSHjGM
	 jYRKouu6dtoqzj3u/iYDzJjR8pD0VNzqP4EfgWoHpB7imzxK4kIsPBaFODKgGMlvXNIMkB47VZ56
	 p40p/uSmKCR5/JTqPWJiAlKHze9e35ux2WQ2RmHYb75g4iCs4NHSgnXyzmYWew6YcRxqSTODNaKR
	 0Mf1RvVXBI2QP/WvYCvyWCpCcBHDvLkV/JPQxKgJR7Ljun4ZdHfxHz8kskORNgjJ8xGQ1nBRMSKC
	 4kdQD0/LQQEP3FvUZBfr740p8mYEfhO4OH1kUXhE21U4/ukflO1OaA3ro5v1JxOhNwtuKGHTY67k
	 SyAGTgdgQCL0pWY+15o0lhB8FCieO4aVw/AbL88ItgbJPCuwNeQPfZY8bHLSMY5a5+JuB0y7h0U5
	 g5Hmeogw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Cong Yi <yicong.srfy@foxmail.com>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Yi <yicong@kylinos.cn>
Subject: [PATCH] net: phylink: Separating two unrelated definitions for improving code readability
Date: Wed, 20 Nov 2024 14:27:53 +0800
X-OQ-MSGID: <20241120062753.140472-1-yicong.srfy@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Yi <yicong@kylinos.cn>

After the support of PCS state machine, phylink and pcs two
unrelated state enum definitions are put together, which brings
some confusion to code reading.

This patch defines the two separately.

Signed-off-by: Cong Yi <yicong@kylinos.cn>
---
 drivers/net/phy/phylink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3e9957b6aa14..1c65fd29538d 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -30,11 +30,13 @@
 	(ADVERTISED_TP | ADVERTISED_MII | ADVERTISED_FIBRE | \
 	 ADVERTISED_BNC | ADVERTISED_AUI | ADVERTISED_Backplane)
 
-enum {
+enum phylink_disable_state {
 	PHYLINK_DISABLE_STOPPED,
 	PHYLINK_DISABLE_LINK,
 	PHYLINK_DISABLE_MAC_WOL,
+};
 
+enum phylink_pcs_state {
 	PCS_STATE_DOWN = 0,
 	PCS_STATE_STARTING,
 	PCS_STATE_STARTED,
@@ -76,7 +78,7 @@ struct phylink {
 	struct phylink_link_state phy_state;
 	struct work_struct resolve;
 	unsigned int pcs_neg_mode;
-	unsigned int pcs_state;
+	enum phylink_pcs_state pcs_state;
 
 	bool link_failed;
 	bool using_mac_select_pcs;
-- 
2.25.1


