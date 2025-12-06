Return-Path: <netdev+bounces-243917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A30CAAC1A
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 19:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13859305CF29
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 18:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E00B2D3A70;
	Sat,  6 Dec 2025 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoDg/Ug0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2A3224891
	for <netdev@vger.kernel.org>; Sat,  6 Dec 2025 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765045585; cv=none; b=NhcLBxxFFvh8ODWPwBukWU1Z1G+T+LH3iy/49Gpm3ODq7//EOZURLisH5Zp0qaXD6CB2Ut8mA7nY0RuBoSK34BGicAxFkqnAA5qekTF2rpD4oA6ZLEZaON+fQFhpy9w3IvEdmEENSHBLtmmo79UlC3NN+/FXjT05VAqIPa9tJPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765045585; c=relaxed/simple;
	bh=1IRpld83xMZ/drvhIoU9A9UdatZ3zIc0QHPBeO90PwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBkJfTyoMpLzdRUGlwod3KErH53KXNxgM2YOUovbjYT3Thce1h4a51AAIPhCIzmNq9THVOZrP4+aBzuj6YuGVKIN4Sy6PtbKqlHW8UxE76+4aIhKJ7HaJdSyDCZvuEqGndinbybB/vibLG3Cpo3yR1na3110LxciBdM54OGh96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoDg/Ug0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-295548467c7so41213965ad.2
        for <netdev@vger.kernel.org>; Sat, 06 Dec 2025 10:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765045583; x=1765650383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QEfkkRUioZd9SWMtUtcnRsb5wthZOOn5MPiTu5OxMss=;
        b=DoDg/Ug0Lt4U0JGQOLLqxSEJF8egCZV1QBo7piiZKny4RFvcyOJyTHIhTwerxmy5gA
         WpBER1SjMPalu5HSjnJjyvhAdvX5JHjKubTUpQIVMlGyZBMg+aJup43XC0GNI3gMn3kk
         z5rBndFX5mAa3KuD96FTR/uFIwL9cZycG0wN9ZGAmycxw4uQJJ7/TDrWr2A8xsEgHgdu
         JImEK8peU88L31kygImlA3bfUPJwg6VjI7sJ2jOvbVGath0Vpu1TiaYiikSbWxn9pirh
         /SHzreNysTU74B0YnlKeqXAhsSRgTZOnC+GQnxI8YvPt2m1UUnTjITLRaE0AGRFjOpG2
         0pzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765045583; x=1765650383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEfkkRUioZd9SWMtUtcnRsb5wthZOOn5MPiTu5OxMss=;
        b=aNtxZ0O1cBPtLuoz+YvUlJ+LgJDxtKnS3rCISXVlCK50N9apUHWSTIgkvS7w/FsXKs
         AoKk2b8MbXHExPQL7REDnHAfvKTh0Iw+ZWkcOaWq+LBaavWYha6cdYMUcrmFmlf0KPhu
         fSxaQ4Hw6lId26RhPKXJcXfv2Zjyw3qY6FaKqBDBLqEcsmEuyLJRFjFoVKFgp6r/Q6bd
         RlImdCf1AA4fBqq3VkwAEO74g926yS8LMh1AHv5xTSSseJDOTtdWNHqmjZu0PNdPciRs
         au1XuU1uc/PXld41aOLmHf2yDRofMFrmGZcm+AM4Y7fA+EGwM26aDYZNEa9hGD63dVoo
         ytXA==
X-Gm-Message-State: AOJu0YwiCq/sbk2l2ZJK7tLOG6tFEsnFDRfZ7O2XLsdUh3tZBR7sIBdi
	qA99CFt1Se2EA4EhHJoGheAK7Ayzt1Def3LZXN47NYPtjOP2cUIPcBo8
X-Gm-Gg: ASbGncuDbASwamNkNJ0I67w4nFtKoGlnbhD4r7+N5wtN4FjpSovAo4nmSDPwYeQQR6W
	2j3z+N/CfuSpmiM3fjpxo/5aQRn/RpP1QtV/T+yKhXF7kQ12/usl8LXjE6P7jaaMCPJFQOVXGKY
	D2DSE106URjThPiNqlLt7K/Jq1/rW7c7LdKtri52wVGrNK5fJtnuLTrsl7egjDq8UdEj/JdZEZG
	/gCI43lZNsvBYdNKiAJ3Ccfmy/MVODiosQ/L3T2lO961H7P0X9vmiGgen1dDYkJgH+G3+6tDb08
	L3piVqWxJ78+VDNubhXQ9HKndj/imk6m3Ja5lf+A6hXLSoTNuEMkyeTECXv/jcDepEms8bMkP0s
	oPgjZGOMSmfC6Xx2dPMyiXW/giA1Xr0pbUadCykczXaHH3UW4AnVjo3Rb3XBE8eKdP6dTsEskbV
	eERT2BZszrgyuciHdYd/qgtOR3d8Y1fDg=
X-Google-Smtp-Source: AGHT+IH8EXv3HmShX3Wm2g3nJMA/0KBHJl1YeOTfruj4/5dzk1gF9j0LRym7UbCIarUtUcrQwWcDRw==
X-Received: by 2002:a17:902:fc8f:b0:298:485d:556b with SMTP id d9443c01a7336-29df52771b1mr26094415ad.5.1765045582895;
        Sat, 06 Dec 2025 10:26:22 -0800 (PST)
Received: from localhost.localdomain ([103.98.63.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6ad1sm81824845ad.90.2025.12.06.10.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 10:26:22 -0800 (PST)
From: Dharanitharan R <dharanitharan725@gmail.com>
To: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dharanitharan725@gmail.com
Subject: [PATCH] team: fix qom_list corruption by using list_del_init_rcu()
Date: Sat,  6 Dec 2025 18:25:57 +0000
Message-ID: <20251206182557.10090-1-dharanitharan725@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported-by: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
---
 drivers/net/team/team_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 4d5c9ae8f221..d6d724b52dbf 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -823,7 +823,8 @@ static void __team_queue_override_port_del(struct team *team,
 {
 	if (!port->queue_id)
 		return;
-	list_del_rcu(&port->qom_list);
+	/* Ensure safe repeated deletion */
+	list_del_init_rcu(&port->qom_list);
 }
 
 static bool team_queue_override_port_has_gt_prio_than(struct team_port *port,
-- 
2.43.0


