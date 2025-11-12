Return-Path: <netdev+bounces-237778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BCAC50211
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB08189651F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 00:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C271DC198;
	Wed, 12 Nov 2025 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLRxDIeq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499A1B808
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 00:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762907710; cv=none; b=exq99gCrmvpMjiAWe637rDyKzVrriAlImojRAA0b+9gXbD9DdbC1Q2j8LiJHnQF4hptIlQvCuGLBMlwJB/+7zOEcuUZby8LSTdnYjuCzVK7kBDeuR+sjEBhDqqkuIpZ0GcRmvJIgdkqOl7RQo/tucf6jk7WPLK6TaxzTtZj2M7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762907710; c=relaxed/simple;
	bh=/uddJhBBzzW8L+E3X13d+vydY17/3a+z2ohQB6rVS6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dn3wgaS/NK4LnXwFU/aK/Kn8ZZbDvXQjhhSgrIpPnnJGC6oUSXWExSDoPHeut+666VkznEV0+6nhLTuln+DJc7vVmlIruwf2n6bxQTeva/ogPpvo7zIdKlCXw09avTv/AIwVYHmMWOCSyG67p6HLiaPt+uHeUVqFFnxiawBb9FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLRxDIeq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b733707e0b5so1818966b.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 16:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762907704; x=1763512504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8bA5fyqCC+W6u0vk7OwR/d5lvOlTqdfez3AJaemrP4=;
        b=lLRxDIeqpWVSjy4aNVeVN/KjYWHErAt+n6I2YfgUZK1vsm0QKU9D4XExHJWxxYQM98
         ZCPQqfZ+bf4uqq7tU0EldzfQbVl/Ss4E4AZYLgDZ8Kv20O3WU313bIo+YD/JdSe7CVwe
         Fwkk5tnKwmJ8BH8d5C4lwrwj4IDVQ+/+eyZUyMBlD8WGLQeim89f6UqQ60qi/KlG349N
         mj30GspfrfyAGlHxi5n0aNCSoAWAqWowEaacIBoAJ7CZDisa6j2DIxe4ELP6JPYOgiow
         K+yJJYUs4+LNhOgHZb4yCtyxhX/GxM5Kcb0T7BRTwr1174lfI9SKmCZ+4Z1L1GwJ/JtL
         7XwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762907704; x=1763512504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8bA5fyqCC+W6u0vk7OwR/d5lvOlTqdfez3AJaemrP4=;
        b=ead3EBVAUyDYZ53MEKi23BBQQh6DK3Na2QEFT2VgkONPP7KS4WtAdff2F2K9+xfLr5
         ntWEXE/Rqm5KiAozjuJhNZa7kKdh+7cW6YeUvOUoz56QgqJhygfogGhBAiH5T774oSdA
         UJpyDus5PFdIfcjjLBZomMCaS4XTIDaEXn3iuF3nGGbND6QpewSvPer7ggqz6Bk7neu6
         /+P3XBptpPwQLDB9lh0zq+JQJM8qum9nG+TAsNgsv+wIxE8y0btZ7kfdny5rPi/spfrX
         py3TWreO+DfaskKhjeKMtsDiAXQRGLj0m68WPwzEsyE4at0OnVShbf6JOmZi40Z0ofOF
         YU1Q==
X-Gm-Message-State: AOJu0YwBy4VJTMnmKod/aFiRW+7w7Yw0id3GWvBrjZLYTWtTSWlVvTRz
	B+bWtZp+oEc1n7hS7ljGAPozE9Js4jr0PncS73n5g6jWgpyjhUsAo9+7
X-Gm-Gg: ASbGncvVDBK4OFt+IkQLqF2TLIcEtQaVFCq0FTFPYbHAsAccO4qivhDDcq/FSITlLLC
	t4BI6L5x5qIqmphJOxDw2r+/dIPKx7J8HO2LvcwFNk/SyuA+XsmWfzxIqqXtckoGsfzJ8n+CHuJ
	1LLDkbRNniIEHQ/UAU0AGbORzT+u8EwSxXT/woCqR3/ifscGxcVa+uPg1TjEIs+QQH2f5OIdhKG
	eSafno+2LvpYNju15EM5/3nvDUfd1DM7fKDJZACIf0aqFsDM5vC/9v73t0zNOzUngyiF57Rp6m7
	PfzDHXRzEV/D+mf8RpxSQ8a7+WoWtQHu4a/NBa9v+w5kmJne94f+AsHR/b+W8m4GERw/6kaQYQ9
	ePvV8XAhwX8aVe0jrNumKCa/BXLfB6PK4r3Nh/0M0y7WFJkonPPm/3qIIzZaAZ151YLBI/WG3KF
	wLdrkc5onegSY=
X-Google-Smtp-Source: AGHT+IGqrNbW7Y2frs0SjkA276j6v0NPZI9klOiEtgkLEjlg+yLRP1GOA3gr1+LqrmTZn0GT7QZWpQ==
X-Received: by 2002:a17:907:3e1e:b0:b6f:9da9:4b46 with SMTP id a640c23a62f3a-b7331bb64cdmr106614966b.43.1762907704029;
        Tue, 11 Nov 2025 16:35:04 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcb0aasm1434568666b.11.2025.11.11.16.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 16:35:03 -0800 (PST)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>,
	syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Subject: [PATCH net] team: Move team device type change at the end of team_port_add
Date: Wed, 12 Nov 2025 02:34:44 +0200
Message-ID: <20251112003444.2465-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attempting to add a port device that is already up will expectedly fail,
but not before modifying the team device header_ops.

In the case of the syzbot reproducer the gre0 device is
already in state UP when it attempts to add it as a
port device of team0, this fails but before that
header_ops->create of team0 is changed from eth_header to ipgre_header
in the call to team_dev_type_check_change.

Later when we end up in ipgre_header() struct *ip_tunnel points to nonsense
as the private data of the device still holds a struct team.

Move team_dev_type_check_change down where all other checks have passed
as it changes the dev type with no way to restore it in case
one of the checks that follow it fail.

Also make sure to preserve the origial mtu assignment:
  - If port_dev is not the same type as dev, dev takes mtu from port_dev
  - If port_dev is the same type as dev, port_dev takes mtu from dev

Testing:
  - team device driver in-tree selftests
  - Add/remove various devices as slaves of team device
  - syzbot

Reported-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a2a3b519de727b0f7903
Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
 drivers/net/team/team_core.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 29dc04c299a3..94c149e89231 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1134,10 +1134,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		return -EPERM;
 	}
 
-	err = team_dev_type_check_change(dev, port_dev);
-	if (err)
-		return err;
-
 	if (port_dev->flags & IFF_UP) {
 		NL_SET_ERR_MSG(extack, "Device is up. Set it down before adding it as a team port");
 		netdev_err(dev, "Device %s is up. Set it down before adding it as a team port\n",
@@ -1155,10 +1151,12 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	INIT_LIST_HEAD(&port->qom_list);
 
 	port->orig.mtu = port_dev->mtu;
-	err = dev_set_mtu(port_dev, dev->mtu);
-	if (err) {
-		netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
-		goto err_set_mtu;
+	if (dev->type == port_dev->type) {
+		err = dev_set_mtu(port_dev, dev->mtu);
+		if (err) {
+			netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
+			goto err_set_mtu;
+		}
 	}
 
 	memcpy(port->orig.dev_addr, port_dev->dev_addr, port_dev->addr_len);
@@ -1233,6 +1231,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		}
 	}
 
+	err = team_dev_type_check_change(dev, port_dev);
+	if (err)
+		goto err_set_dev_type;
+
 	if (dev->flags & IFF_UP) {
 		netif_addr_lock_bh(dev);
 		dev_uc_sync_multiple(port_dev, dev);
@@ -1251,6 +1253,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 
 	return 0;
 
+err_set_dev_type:
 err_set_slave_promisc:
 	__team_option_inst_del_port(team, port);
 
-- 
2.51.0


