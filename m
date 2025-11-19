Return-Path: <netdev+bounces-240064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFC7C700C1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E915A4E7593
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B40031ED78;
	Wed, 19 Nov 2025 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsZsQf2+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D526FDBF
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568539; cv=none; b=ZwWh/uvFAykBmvDIdJE62Bt6w3G1pE6GmssUa5HS9HU5AhvIasNTtmrwBtpSy1y+myeoRd6RBqELcg2S2aV3z4/DdPdzgUWzm0qIPV8E10tU1hZCSz5qLI/TpWl4fldb8jD2L4uXXuzBBawR9Z93xINLLGlfVsFLSYw7u0y1Ymc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568539; c=relaxed/simple;
	bh=Z3cJOQ2ccJsQ0oWrL1rpG5fsyyBggDRUQgteyGwCcbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3HO5402FK+/70/GAPx1rQbn3wc+Btvds0WP2CQPL/bAQO5hNQCV2Znrpbt9sZPlW3/e+uTAU+PXpdxWIZK5t+NHPL2q80ICfV/HkO24bf5pHSec2/k4TVtZ6KFDQLUdYmSglV+MUfypDAJU8B8xVqLV2J+EhBy5ttt8DEsZz8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsZsQf2+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b736cd741c1so873519766b.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763568534; x=1764173334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SizZzBPjLKOoZAzPRbyBM42MsY16LLyvAwLNC6fcHOw=;
        b=AsZsQf2+kfGPGV3q17h1dhrrTg+T73pYWlEPIqm8v7yJ8Q7C+eGA7uVmk669W0YeIV
         ih6M+AYqUB3Vlu/DtW75lpdvs22ezYXQVRM4RebP/UtWkakTtudunTVKXVugICJTlnK0
         BVzixu3i+DAde99cYSmFErdH/Gg90j8cVxYuxnXP1zkJG6ydij1/ctuTVCuUbc2+ZbWD
         VCfK0aoUYMjyKOPiIiz1ENH8+lDOHwaWGfyVh5k0CLEyHXUC9KpJfs/sI6J8CMN9c/Ja
         vRsJRZ5YqoyFVpl3AcTlgGGqzbeSOxsfUZZLGgLihtJqUzpQY3hxU3jvwD/1fAy4vfZS
         QIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763568534; x=1764173334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SizZzBPjLKOoZAzPRbyBM42MsY16LLyvAwLNC6fcHOw=;
        b=lqBaPNXd5AWkK/swC7tGZDsDnlS5kxis5wDMUifMV1RMmLfhYXvkVuQjl/UQs1TIlO
         ugHYBPGzvzFFU6/syxRtD5kUe9J6tykF+ieaIvgz7v0eJ+//xpS6ml5iJCAY23tf8PoA
         Wtd/paCGy8QrrH8jy2VUvU4Ua8vmE51ggiEgy/jjsRC8x5a92PyuNe6qtjuMd5nzfv+G
         wu/6Np1H/U73NtpVDUeacMwa6tBtBdXIt5NxaDCQc9C/PmB1zHXtCA6UupY5E81GTBRO
         UPsZR5TYTkKsnmR/j8hfH13K7s3yjKaFsJfE2vR6CiaY6Bcg4KNNqDGgjrza2dIM326v
         DjCg==
X-Gm-Message-State: AOJu0YwhBFFWYdmZGqRywJIGszayGPW8XTLywbYYOqriPrqadtoV0n1Z
	VQogjc158oIDviX4ut8BAk3td4nSXId5GW8N8J25tRLRz+GZRsPWPxms
X-Gm-Gg: ASbGncvv6tAhs02JxL8DkJ2T1uD3vz6IOcspINtbgmeMALMsHMgszghfjx/+5dOJeXb
	MaYi6QUg48Zf3sJUApkaEWJoa30NMRLyQRB52vo1WgWOYGgyA5BuGOCRSb2NrTNi+tisCtXY4k2
	D8fu/QmNAiy0b31lPbSxGyhXGCzSXjpvPOKeSV1mr+9GVyn5Bl/C5hPRn87YjUadaC/ToVnWRb2
	bTkfEWYZKft0fxBaJ60dG0wdisw3Oi60mzZv9RZoI63O5lEeoqJT8EX99Ofa80Uqx0TZhcU7WC8
	yWTy+XuBx06hsZbMWBpACi1cEBHTxmuV0zPHTOQpcZw9gqXSbJcDyQmKjhh1bELqmC+gQHZRi64
	0QAHE6kZYK4ozIaIbNFSjkimiXatOqR4S+AslTN3XsD8Iuj6cfmbqeQSGcKk6gp7bJ2GWZRAv+g
	XQ2kfyKofnEM7ZxOszaMZzbA==
X-Google-Smtp-Source: AGHT+IH2cx6mffoyjgk5HxK/FEYr6BIhhOy7D3Vvb4brj04ZDUMSv4/MBmhJNb8U2haI1icmHHq8Iw==
X-Received: by 2002:a17:906:794d:b0:b73:1905:bba0 with SMTP id a640c23a62f3a-b7637869c14mr374006666b.17.1763568533551;
        Wed, 19 Nov 2025 08:08:53 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad45afsm1657863166b.24.2025.11.19.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:08:53 -0800 (PST)
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
Subject: [PATCH net v3] team: Move team device type change at the end of team_port_add
Date: Wed, 19 Nov 2025 18:08:50 +0200
Message-ID: <20251119160850.378824-1-zlatistiv@gmail.com>
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

 drivers/net/team/team_core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 17f07eb0ee52..d7625a390e94 100644
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
@@ -1212,10 +1208,12 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
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
@@ -1290,6 +1288,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		}
 	}
 
+	err = team_dev_type_check_change(dev, port_dev);
+	if (err)
+		goto err_set_slave_promisc;
+
 	if (dev->flags & IFF_UP) {
 		netif_addr_lock_bh(dev);
 		dev_uc_sync_multiple(port_dev, dev);
-- 
2.51.0


