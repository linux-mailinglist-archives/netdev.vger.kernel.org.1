Return-Path: <netdev+bounces-129228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D239297E5AC
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 07:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55857B20E92
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 05:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EDEEAF6;
	Mon, 23 Sep 2024 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK9BYrWW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6A17996;
	Mon, 23 Sep 2024 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727069949; cv=none; b=a23HG+BeaO37j7qEIceTU/x4eToDd6LjeYwQdUBLAK8KPx9EfFA9xI16TdVEq+3/XEzGUazJeghH5WyB6LcJpkAEXFysC+A3/3+VJYlKwI/BDQROfwupCDIHtfOcCx6LiclZP4xfx5iBObLnPPlAwYhgNrs6Tf107hqZyRNFsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727069949; c=relaxed/simple;
	bh=KLqYVUVSeJnuEqG4D+Dx2keqPgCYluGkixsgYvOgMdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaArPbUvzI64ybTNR6SuDoSFyh58wdMaD84iEeFbXD4yh4YMupZQ6aRYJ+8hRhNN09E2fg6qCjIP2decgd0tC+7m96Oxh6TpznTmC75KrvoK05hj74ejhnobnoHnne8YX0OF3br9c1V/IhtT3yO9mlhFkz4HVbEx5cBBesMNuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK9BYrWW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7191fb54147so2907483b3a.2;
        Sun, 22 Sep 2024 22:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727069947; x=1727674747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYSzy93Z1kT06bxakvwIIe89yhaOpfH+SPPvpoZ8Oj8=;
        b=AK9BYrWWnxAst9sFRd7PlWICt4DYwEzmPwcby1XnUuhEyrc5oe2QNj8dHVdxzs6cAD
         VmZt59etcL0axIJ+EcucGzrM38KdMnZ4r1QB3Jmph0Pp8Itxk574tcEUFB9H0e0yfivX
         uzy6+aHXK3NJGWF2v4EPzdY2I2M8/zy5PiDrd684Ot59j/AvP7Ho3jHOoMUXWSkBKk3f
         Of8lgB8ly1K6ewTZ6HiDmKDlpJeH7CSub4m+NVyfObCCQxdcDO2Wofp2uDE7YBhQ7L4P
         NgrI4GIv6cj431A8Ap7A7+vehk/XOU3u8ykIfGwkJqUrzUd+hXiI9veW1UnNjvvXbXcR
         664A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727069947; x=1727674747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYSzy93Z1kT06bxakvwIIe89yhaOpfH+SPPvpoZ8Oj8=;
        b=AKtwim5iG1iPRtoyAqZcNT5Zfxc5gDV9otXHn+iEXzBkzH2kTv4jpLpLkoHCrU4e68
         gVW85EzQKcM9boEzdSN3jo03kPt+3t36GFBtRhSDCzHygIBchMU1fIESbTPWWGoMkkkN
         yWbYB7DZAxQMKnBi8Zv0lJW7iRdoO+U129JoYJAe+eRJV4NN+7LS00or/JyxfiYJYwrL
         M9GOADlnhPKxZZl27/TGKnIlwIix5yEZ9OPH2kKRhHZJkFUDDiIpBJ9TPfb1SGG0i6Hn
         2cFZpVZTm3mq9Fqvf1zIaToCPFWeqDCu08gCBt+AdBZvRsLPORbzoTbnmnRuYl7sGBkU
         mq/g==
X-Forwarded-Encrypted: i=1; AJvYcCVatrjoEUynT/zFVPr/YVtlutoPHB5QkpFcI2KaeKXRvWIAkkAE7gS+49qlOgjFoW/mZNTtUyotUsbrgB0=@vger.kernel.org, AJvYcCXIzLacuZl6muwevCkginRGArwnSTjXCY6OflAAiHJy2DEqgqgzhYahCbkTrkUtY3AIThnGGqcc@vger.kernel.org
X-Gm-Message-State: AOJu0YywCeb/vq3vgIspIDhHtj08+ja2uQdgxwkHpI4BNjtZBA2rJ4+e
	efPtdGNF38o5SSeiGEtxQyr4cDGIUV/mauOAzdA2TY+XSg2n4C7B
X-Google-Smtp-Source: AGHT+IHahzVhTsIOnELpI6T+hDoBzw//t7m4xEE0t1bfbOFxCBUorXCpLyYuIGOxiWBnC9oN7cY8hw==
X-Received: by 2002:a05:6a00:92a2:b0:710:da27:f176 with SMTP id d2e1a72fcca58-7199cd6bbc4mr18281852b3a.12.1727069947006;
        Sun, 22 Sep 2024 22:39:07 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b98257sm13130330b3a.166.2024.09.22.22.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 22:39:06 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: andrew@lunn.ch,
	florian.fainelli@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	bcm-kernel-feedback-list@broadcom.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] net: Add error pointer check in bcmsysport.c
Date: Mon, 23 Sep 2024 05:38:58 +0000
Message-ID: <20240923053900.1310-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error pointer checks in bcm_sysport_map_queues() and
bcm_sysport_unmap_queues() before deferencing 'dp'.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v2: 
  - Change the subject of the patch to net
v1:  https://lore.kernel.org/all/20240922181739.50056-1-kdipendra88@gmail.com/
 drivers/net/ethernet/broadcom/bcmsysport.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index c9faa8540859..97d2ff2329cb 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2337,6 +2337,9 @@ static int bcm_sysport_map_queues(struct net_device *dev,
 	unsigned int num_tx_queues;
 	unsigned int q, qp, port;
 
+	if (IS_ERR(dp))
+		return PRT_ERR(dp);
+
 	/* We can't be setting up queue inspection for non directly attached
 	 * switches
 	 */
@@ -2392,6 +2395,9 @@ static int bcm_sysport_unmap_queues(struct net_device *dev,
 	unsigned int num_tx_queues;
 	unsigned int q, qp, port;
 
+	if (IS_ERR(dp))
+		return PTR_ERR(dp);
+
 	port = dp->index;
 
 	num_tx_queues = slave_dev->real_num_tx_queues;
-- 
2.43.0


