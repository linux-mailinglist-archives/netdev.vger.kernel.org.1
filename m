Return-Path: <netdev+bounces-240912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24966C7C00A
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 01:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 73D903587C4
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 00:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D4C1C5D72;
	Sat, 22 Nov 2025 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCUc5XHM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E732CCC5
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763770834; cv=none; b=EGRa9Pak0T5iQ5qE4B0v7sqNKjozz/OyHCa9qwzeEBqULXZZg5W8FmcsaSvmSgP2/UFbAE43wdlOw21vREfzzokMWJfxziIhq90fP0lYpAnJzZUQAmFdeN/GYNm4aZfD9hT2UvL7zCNsICTkDdo8zZ0hUaScGKu7CPW5UWD5J/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763770834; c=relaxed/simple;
	bh=rJoQQQVl3A5OBD0qoQTUH/HKulcN+Tm1hu8kr4bTSys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qz2n+nQbEt0epXZTP4xfcbMxk8Ymi0r2/0UMT5yscP5ivFGlH6UbN07DcyRcXwA0CrYsoKiM0pR0y/ZB+jvfnEC0rjQG1W+jfs53u7NcOqKU3eW4DNOgUi2ftbnL4LIdlQOhgjsrs+Q07TG0mCQyZqnTBVKhhtJRg9fDl1NZ1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCUc5XHM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so458932266b.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763770831; x=1764375631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAp9aZ+uW/j52RhXFBcyoCAsa70B/Y4OxqM/BiEieGk=;
        b=XCUc5XHMdo/UT5SHXibYM9seqnIrEGRDdnYdbz2+d/eup+gjdIsvG/V1O7HTfoDAJe
         KFGa9C2y9jhfbz1d4wQHiBLFiO+MNguBnHaZ9EDm/W6wTzC7Dy4++EFPPPzSD0esAouA
         UxwSGvAtBGPyd00HFXChWKZQe4S0x2IQZVALwFrbBwW8VB17Hqk7JF3sdAL28gEwgEo+
         8ZBfrNuiAZWLCah3Mx40CedHhedZVBGR3pGhrbZBUJ3XEz4u/KMcKALxbdKcOY0rLZy7
         /EBhUflfCZUk3Vd5ESeXRcKe8RAx2CFX1S5ot/HlaU8RfqOTWnBAvUW3trr+UioLP8Kd
         oB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763770831; x=1764375631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAp9aZ+uW/j52RhXFBcyoCAsa70B/Y4OxqM/BiEieGk=;
        b=uMCQLNudLAJqit346iegbFgGtx3QneqkkF9nRY19hnm5ZzyqMcKN1TswtPMQ7NXP5u
         LDmDlY7ZvHbkODSVjk/WHlWf63Zre2F2EMHXRNFbucss1CUteJYFBPpEF2p3YQAMxTpR
         2CdE3R6VvIEpxinqCaKWiJQZBgWMgVumFNDl7tcPXhNMFQYJhAE03hRyGL/TuiRozOds
         LGWYDSnu/F1el0O6psufxlw66wodzjW7U2HrIi7bnH8/DMCzxlpTTznNmKEZGcuQYalv
         eeAgp2vtrlV6TyaRQFQ5d+fU4hDze7L0KrwM3CxcmVEUulb50j7TtwvgSST11mXQ+AeL
         wmOQ==
X-Gm-Message-State: AOJu0YztYmopUSfohVoXrAUrtal5feK4DjeBLT/df5xitEtq1KPFgyVe
	bIdvSoBqkBCRzQL1yo/3HpgmyQM1UgDr1suElxhriOtMfwCiQsD/H/6Z
X-Gm-Gg: ASbGncuRJJAaHvTE6+vtlpJUs+/dLLvAVFEyFlA1pta0ti+bRINkXN5J/wAx/wi+KOw
	UsB6tDgsehThMKKVKUKrDhFq3Q0X0DJm8R5e6JuCpyGD3Lw29+mO7aSoGK9Tkv6kIYULkQiV5Ru
	MmFx699JebmVeUw2YWxrT1HEcCgq/rhLlLYgL92d+wb5Tlwc0mVVkF+uvc4hiLpZ2oFl9urJ9PY
	da4IfJm7TuiPLQ35jyKXHrcF6kR2PGOTDrvYPHld+0nWS178cb5yjW3K/AKotukI/c1Ar41Pndo
	eF0onNMS61poXfujzLqTLbwMvQdt4DKfqhpc9pyFXYWGiG5fRLwfaxLnjxK8cN08EmdkPOMD68s
	xlNSDia78U1/MrV9dfHuT8Th9ofDOKrPFI/32JrElK7uRW/x9WF1KPg9zHd+2bYM+0SSiTkbhkk
	+tDPKXQABqRNfqwzKVawYUtA==
X-Google-Smtp-Source: AGHT+IHwH08qVkgII6zjFUUDK4LO3V9/FMSKTA0oD9d0P7wNSGNESnDtmGP1YSKgkzGu1UoXEaV5TQ==
X-Received: by 2002:a17:907:3f1e:b0:b73:5acd:465e with SMTP id a640c23a62f3a-b767153ee39mr438247666b.11.1763770830585;
        Fri, 21 Nov 2025 16:20:30 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd6087sm587410466b.44.2025.11.21.16.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 16:20:29 -0800 (PST)
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
Subject: [PATCH net v4] team: Move team device type change at the end of  team_port_add
Date: Sat, 22 Nov 2025 02:20:27 +0200
Message-ID: <20251122002027.695151-1-zlatistiv@gmail.com>
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

Later when we end up in ipgre_header() struct ip_tunnel* points to nonsense
as the private data of the device still holds a struct team.

Example sequence of iproute2 commands to reproduce the hang/BUG():
ip link add dev team0 type team
ip link add dev gre0 type gre
ip link set dev gre0 up
ip link set dev gre0 master team0
ip link set dev team0 up
ping -I team0 1.1.1.1

Move team_dev_type_check_change down where all other checks have passed
as it changes the dev type with no way to restore it in case
one of the checks that follow it fail.

Also make sure to preserve the origial mtu assignment:
  - If port_dev is not the same type as dev, dev takes mtu from port_dev
  - If port_dev is the same type as dev, port_dev takes mtu from dev

This is done by adding a conditional before the call to dev_set_mtu
to prevent it from assigning port_dev->mtu = dev->mtu and instead
letting team_dev_type_check_change assign dev->mtu = port_dev->mtu.
The conditional is needed because the patch moves the call to
team_dev_type_check_change past dev_set_mtu.

Testing:
  - team device driver in-tree selftests
  - Add/remove various devices as slaves of team device
  - syzbot

Reported-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a2a3b519de727b0f7903
Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
Changes since v1:
  - Add a "Fixes" tag
  - Add a simple reproducer in the commit log
  https://lore.kernel.org/netdev/20251111171341.4c6d69be@kernel.org/T/#u

Changes since v2:
  - Use already present exit label "err_set_slave_promisc"
    for returning on failure of team_dev_type_check_change.
    This was suggested in the initial patch thread (v1).
  https://lore.kernel.org/netdev/20251113211142.245216-1-zlatistiv@gmail.com/

Changes since v3:
  - Revert the change in v3 related to reusing exit label.
  - Add a brief comment before the conditional call to dev_set_mtu.
  - Add more descriptive commit message related to the conditional.
  https://lore.kernel.org/netdev/20251119160850.378824-1-zlatistiv@gmail.com/

 drivers/net/team/team_core.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 17f07eb0ee52..25562b17debe 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1191,10 +1191,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		return -EPERM;
 	}
 
-	err = team_dev_type_check_change(dev, port_dev);
-	if (err)
-		return err;
-
 	if (port_dev->flags & IFF_UP) {
 		NL_SET_ERR_MSG(extack, "Device is up. Set it down before adding it as a team port");
 		netdev_err(dev, "Device %s is up. Set it down before adding it as a team port\n",
@@ -1212,10 +1208,16 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	INIT_LIST_HEAD(&port->qom_list);
 
 	port->orig.mtu = port_dev->mtu;
-	err = dev_set_mtu(port_dev, dev->mtu);
-	if (err) {
-		netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
-		goto err_set_mtu;
+	/*
+	 * MTU assignment will be handled in team_dev_type_check_change
+	 * if dev and port_dev are of different types
+	 */
+	if (dev->type == port_dev->type) {
+		err = dev_set_mtu(port_dev, dev->mtu);
+		if (err) {
+			netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
+			goto err_set_mtu;
+		}
 	}
 
 	memcpy(port->orig.dev_addr, port_dev->dev_addr, port_dev->addr_len);
@@ -1290,6 +1292,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		}
 	}
 
+	err = team_dev_type_check_change(dev, port_dev);
+	if (err)
+		goto err_set_dev_type;
+
 	if (dev->flags & IFF_UP) {
 		netif_addr_lock_bh(dev);
 		dev_uc_sync_multiple(port_dev, dev);
@@ -1308,6 +1314,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 
 	return 0;
 
+err_set_dev_type:
 err_set_slave_promisc:
 	__team_option_inst_del_port(team, port);
 
-- 
2.51.0


