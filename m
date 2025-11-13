Return-Path: <netdev+bounces-238505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FEDC5A118
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C1974E4F58
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CCB321426;
	Thu, 13 Nov 2025 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE9AvMS2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B920D320CAC
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763068331; cv=none; b=Hi+PgakjkwgI8qoeGlsXOQuwu5QghacVqCQfGU4er3N3Yi5UYx6wxUDn0qrUxFZ0Zg4HJRQHAIunfDNg31BnS07vfCk0obinRnyoK6/5L6/fOpI3F2yNZTujNymbmzDtTn1tJQ7SnyiBCLIx31bI6MsEDMoaLyqkexs/OXAw4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763068331; c=relaxed/simple;
	bh=VZz8VeGMD34/0SPFsGJY9Zec9mHyRzTy7RjCb0SFz3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMvkuQZZTVY1TBf09OtBMAs4oL1+MFBAeYKjMZ4H8GxRU6hP1etGeHOa4EANwR1FxaYxxU6N3YKGGsoT8WUTmx21X0tXCKoHcvu7F3oQuwApEqBapgCxbtO+ys+/L+Z+3rT8PTHW8zaT33bk5AP5m6pejL5FPKOve755NVEkmvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE9AvMS2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7260435287so182858366b.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763068328; x=1763673128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wyeY2XNsdqhfXocUSjoPZjzq+oQsyNbMvmr9wItdoUQ=;
        b=kE9AvMS2cfy+EA9GgKflu/RE3Cuibbu3f1mIhyrSwE8uj2A7XaBfJ20NM3UtQCJ739
         j/jS01VHINekHbMhjxMlr+U/pE/0OfVXF+5EO4tC3PhgNJBYiOFIHGlZj4wNfGbza5mM
         T5yog6Lprd0mOTVHCNEm5J8I4+jGySsNVIq7QBhkwFW8KNROXJ+PgUlEWhH1ub3tnb6e
         gq/92o89EpH2L7udLImGxdVqT01UVSHb/OBI8Kt+nu0Xk7kzI7wrlHAKSWkUcBRU+2Nf
         KOr+8MpyYIX55vdmugskd6H1wHmi2ZN29O7O0+CCJDVuTygVO968bFuMF42DZ8+rcFEN
         06ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763068328; x=1763673128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyeY2XNsdqhfXocUSjoPZjzq+oQsyNbMvmr9wItdoUQ=;
        b=HLIuaWdfbA2V1IXu7PR8b6LGLwDEX94kw1/r9AYIQxnMyEjmwXn4ugkkXC/enSiQ1Z
         MXUl7D7KyiBnefJ1z92RMXVcOAdU74ae7LqOlpTh9qzQO/40xax8MDWX+coJ5j5EiVpA
         cafED/t0w1vRmSo1obhEuWmdKZUb+qdXaRHNCW1h9JENw63v2U5EQyaTJWv7ALalw6lu
         kVqtNhL/yoMPX1f66T8h3R4YaY203iqcBWj/odlaK57J68lKuUMojtOVrFvRcGx3KjmI
         80wUWT9hrYhUaBh9nAXhOjGR7JyIUuPAw4D/5ElaumjzZxxr8Bsn9hLzRSZ5G84jfV2C
         YNWw==
X-Gm-Message-State: AOJu0YwhabyLkfF/PIaVpyGW1lVU80QNVUDgVGhBZYKAx5AROu8UZFZx
	WqxbSCLc1q1lPtWju6uP78yVM+z/WtfldT5Oqc3FQCbcje7/OidPmxDR
X-Gm-Gg: ASbGncvTFZJP1V7fdoE1iG1fgVhPRJPh/w+przV6nT2bVNxV3Zte9yyz3m/WgyyaUIT
	AaqNi0mcxEUv33mG66jP2piJOXg26Zmk9WfkxVL3CrCoXo0yRkPAxFbsvHctnAsxSvvJo9OgehF
	rup8YO6dlEykiJ8GASgjqQuBOC637ixIbUvOWmxHHY0k2FexjU2ZuzkplABjinJa5QxU8LhZ2AZ
	rjbppCbenHJxeEGFxiOVFoNp7n+TIGXaQKrh3TfbUH9ylozgb4/0IsrX3Zu9m5XIQ3MFx3KLnpS
	qU402QBakbIwAcMFzaBoROC/7L2slkiKHEXHr8gVFkDamGxCd2JXGN1OfaqfIVYSQ2GjiRCHcpl
	CgCxjA7VlSDlxOQSO1wLCQ0IwvAtsYWcLu34dWu/MiswIZKB9aeS3hqIUPWh295lDeCNzS3b3YW
	x/b69NYtQmvCM=
X-Google-Smtp-Source: AGHT+IHiDc/7hf9TqjsuwSPQ+FK0WK3MXANc1n+4UzxCZWDV8N5JWcs8yaQjBqEdwkwAyS0qmrlBJg==
X-Received: by 2002:a17:907:60d4:b0:b6d:5914:30c with SMTP id a640c23a62f3a-b73679841a7mr52617866b.34.1763068327739;
        Thu, 13 Nov 2025 13:12:07 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fda8d69sm237324266b.50.2025.11.13.13.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 13:12:07 -0800 (PST)
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
Subject: [PATCH net v2] team: Move team device type change at the end of team_port_add
Date: Thu, 13 Nov 2025 23:11:42 +0200
Message-ID: <20251113211142.245216-1-zlatistiv@gmail.com>
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

Example sequence of iproute commands to reproduce the hang/BUG():
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


