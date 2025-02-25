Return-Path: <netdev+bounces-169479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF568A4427C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE422174B64
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E3126B2DB;
	Tue, 25 Feb 2025 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUPWPa4n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E320F076;
	Tue, 25 Feb 2025 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493068; cv=none; b=F3qLh14iG+VvelThEs3+BG01r0PNrJ609H07rUsSWAEChN8Ji0DfZgL1sOrD7x2X7/yhvJLzpIHhlUCb1qgJzfclxmI9lHwvF0AwUc/A9z+p1b/wRTm7qiRDXZuj1PWNB1wW9x2aqsqfXWLJuSrv4OvX6LHLN7odtQgk6J6v6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493068; c=relaxed/simple;
	bh=go1mE9+6Gnf09mRgfZKcNZ8lEWmnfnzRfoURcvriDl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A/3gVA4CPqI2w/OtY3ciloI4fFXYNHIq4AhtHNL+WS6yzM3FiRpnaUiGk2mgObBnNFOgH+Kckwg0yHOZgqU69GRGAYnnvM+E45d/+7bUbIBAWqsGKYmxqFe7p9k5EgVrKcAl8lsvH9shg18RZMQGzCx8Hye70xxS5ZLQIAjiwX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUPWPa4n; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f2b7ce319so4705842f8f.2;
        Tue, 25 Feb 2025 06:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740493065; x=1741097865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/KgWBEXvpPJ1izY+CQ5WBRzeUj02pc2AV48/6n70IVQ=;
        b=UUPWPa4nnB3+/asqEjixwBC80UTvVLLEAdmebiQErjCKOF24LaTqalzD1LstfhbVuh
         oIpqEQGNXn1+GyAL+6M/if0DnYxOW2zzeDD+k8o4lBGFXvbi4UuVgBt1qwRVtGoovsQ3
         qeSq5sgBCc1ernFBkQ8fqlatfRkPlQxQspjOVQbjmjjGcFdBOzkyQMIFrxeHw3SgAdXS
         961wkAaC6Rc9P+KgY5cb1pHt4bH9+hG2nHhFxNEYirn7SKVaZU7bILR/bn+pqRHG5/E3
         AnSC8JOqeu2/gIwqi6vQag2+Ryjdxzgz2QJIXzK2JsbSN2NhaqSMK9D9T3Igyel8ZKfa
         R09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493065; x=1741097865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KgWBEXvpPJ1izY+CQ5WBRzeUj02pc2AV48/6n70IVQ=;
        b=eiO1Agnr4RQi1mdyZD6k/5YbFnMNJksUe/BtChb9g+OJDjr3TE2sqHnVMX93l+Jsji
         xbbu0hfPl+EwvgdF0QcZLRhXY49/OFV8UnkrLxtDUUff5wCffaD5DZG/dhIeLne9ZDGe
         IsIwut/nntIswW4hpvD74ZciKpSXsOSNqJn/WtaauuAcG12aivCrSzjZl2qTyNfyJmUR
         olVRy4KNOeQ0zjrenv2fSLJKD6gexDIwQr8vUQOTOvlggADKoNGy+skuNYZK6NOxTcRL
         7n8El9Ysslg0DrwRj218cLixT6Pg9D+xEaNr2pYrVLz1IVaM+YU9WUAnm/fcz9PoyNgN
         zgbw==
X-Forwarded-Encrypted: i=1; AJvYcCXkYOPy/8M1kRRS+LmEVBjS/yZv610lmW1iw974q+y+0/p9KFhCfuG2YV9eMb55jtd2Bn1APmSwqtmDHhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7zoU4UeEJAxd7h8/oTADZ0xGdaKuf7nl7f/VpOnYGZA1MtbJW
	DPC5C2RcGYKF7apoEzzj+Clq+jXkSKbBPtpDSDMNCT1xCRyLTS9WnWXrkVWM
X-Gm-Gg: ASbGncsb0bSk24g2wKbt47YrDTst6T3uIdRc+p+kHvI2YdASTiECKVNwW1gdtXDCg59
	AKy5lRNAitSlsf1v+J9meijC7swTcftUiSwTUHm7J3K5Yf9i1YIez12i9uoTYFgwYlOUla37V85
	Jt8lEmgHHH2qHEcVN9Hd6xfgXVqEL1LOQEayEEGWiLpSn3RfclMXsUO4Zwh/Syc1aZBsh5dJnFS
	nm6BQZmaK1ucUX84klsRXlgSNoCb3MtjDhy1fV9WvmOOnmiGGtuRvGtWOsAkWfY163+HOT0SsgB
	iMPH7v/S9ZW2tpq+VYc+gwHj5ItspZtrIGzy6FQ=
X-Google-Smtp-Source: AGHT+IFZSXG8PEqzt6l0ksAlLiAmH/XPg87BT/UfaoQ0ZTdJdIbQZIab2dlPhgvKtPXzZUJKPpAwiA==
X-Received: by 2002:a5d:59a2:0:b0:38d:ba09:86b5 with SMTP id ffacd0b85a97d-38f6f0c4985mr11781297f8f.52.1740493062969;
        Tue, 25 Feb 2025 06:17:42 -0800 (PST)
Received: from localhost.localdomain ([45.128.133.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1546fadsm27738485e9.18.2025.02.25.06.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:17:42 -0800 (PST)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	viro@zeniv.linux.org.uk,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	stable@kernel.org,
	idosch@idosch.org,
	Oscar Maes <oscmaes92@gmail.com>,
	syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
Subject: [PATCH net v2] net: 802: enforce underlying device type for GARP and MRP
Date: Tue, 25 Feb 2025 15:17:09 +0100
Message-Id: <20250225141709.5961-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating a VLAN device, we initialize GARP (garp_init_applicant)
and MRP (mrp_init_applicant) for the underlying device.

As part of the initialization process, we add the multicast address of
each applicant to the underlying device, by calling dev_mc_add.

__dev_mc_add uses dev->addr_len to determine the length of the new
multicast address.

This causes an out-of-bounds read if dev->addr_len is greater than 6,
since the multicast addresses provided by GARP and MRP are only 6 bytes
long.

This behaviour can be reproduced using the following commands:

ip tunnel add gretest mode ip6gre local ::1 remote ::2 dev lo
ip l set up dev gretest
ip link add link gretest name vlantest type vlan id 100

Then, the following command will display the address of garp_pdu_rcv:

ip maddr show | grep 01:80:c2:00:00:21

Fix this by enforcing the type of the underlying device during GARP
and MRP initialization.

Fixes: 22bedad3ce11 ("net: convert multicast list to list_head")
Reported-by: syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
Closes: https://lore.kernel.org/netdev/000000000000ca9a81061a01ec20@google.com/
Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 net/802/garp.c | 5 +++++
 net/802/mrp.c  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/net/802/garp.c b/net/802/garp.c
index 27f0ab146..32ab7df0e 100644
--- a/net/802/garp.c
+++ b/net/802/garp.c
@@ -9,6 +9,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/if_arp.h>
 #include <linux/rtnetlink.h>
 #include <linux/llc.h>
 #include <linux/slab.h>
@@ -574,6 +575,10 @@ int garp_init_applicant(struct net_device *dev, struct garp_application *appl)
 
 	ASSERT_RTNL();
 
+	err = -EINVAL;
+	if (dev->type != ARPHRD_ETHER)
+		goto err1;
+
 	if (!rtnl_dereference(dev->garp_port)) {
 		err = garp_init_port(dev);
 		if (err < 0)
diff --git a/net/802/mrp.c b/net/802/mrp.c
index e0c96d0da..7ee7626f5 100644
--- a/net/802/mrp.c
+++ b/net/802/mrp.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/if_arp.h>
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -859,6 +860,10 @@ int mrp_init_applicant(struct net_device *dev, struct mrp_application *appl)
 
 	ASSERT_RTNL();
 
+	err = -EINVAL;
+	if (dev->type != ARPHRD_ETHER)
+		goto err1;
+
 	if (!rtnl_dereference(dev->mrp_port)) {
 		err = mrp_init_port(dev);
 		if (err < 0)
-- 
2.39.5


