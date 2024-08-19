Return-Path: <netdev+bounces-119606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A38C956508
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DBF1F22844
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469AD15AD9E;
	Mon, 19 Aug 2024 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bkb7esSh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD46415A87F
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054033; cv=none; b=jY/H/0gRTfzQH1Ujkg7c7NVaJwEnWmRsH90YuI8EdPH8j6q72mogxjbte5RPNMr8WFPfmXHTA2cFObeKuV9JBndHVqPT4PjM7zLzZqadyOL9Rv9baxmybSI/CzW1Xom0ocSPUn2lTfV5/vwg006abKqRwD7hmrP4n9gxOfkSygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054033; c=relaxed/simple;
	bh=H6sez1XWIvu+zlzMFh3M5fFdumBUiPWe/sLQkHhvYHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGuTzuYbi1vnHHoGQKus90DPc9KoIwoWxiE2DXRge7L0zsT8TCuCi8qqL7bUWtLhY1g2mlDePDzR9GN5CIF9usM0Bh+5uMH14WyppeOwhnzA2F7T6Slu0SpmFtVhcNwMrKXa9n/KiT64tIS/2lQ7GyunbLg8BWrcmN2NUU938Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bkb7esSh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso3390666b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724054031; x=1724658831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6I57evoLQvXCTBfsroOrJwSZgG1ZuVr6u69WBxxO90=;
        b=Bkb7esSh+tWOugKN6pS3+zaKvUNN8XcRPOo1wndaUqZyulXhbfrXXlxdNOEWd19Bg/
         NVZxsDtwvaHlHunJyffHcsUzQNQU0ioDJRLOLG78IgfreUs1d2geGHfI2RW8ukD/FC0G
         4WiFzaFkX9VuC6QrEIjm+lM7Of4/I7MsT1zi6vy3IrMZ25VDTFcq9u70UBQqrb356tuR
         uEgpMa2Xp7mkEidRzTr4jY9EIYeXp3x00nQ+LpWT5LZdO5e8YT9hJrQeWS39AQ2iMOjH
         b2uN/a1pJ8nH2nvQ5pVHgPT5Ow7CT2Raem5gBmR0NUD0EY4u2x1EmVvdYp8+YseXzebo
         9eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724054031; x=1724658831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6I57evoLQvXCTBfsroOrJwSZgG1ZuVr6u69WBxxO90=;
        b=HA9yHAX8XTxYb3iX5+eT0J1a9pWpqe6jtZszLks8kpVf5xlxJvuMEE+Tn5fSX3Xe3m
         dFly61croCyHLmox3w+Ncqxuceh/xld9lhLiH4+hguS4waHpgCE8CZJMKPrqgwhBNjql
         jgqbDS1+ijd665PWMPYn0h+fSZ9CIhKbf8IUtFWJZONpqjdPSGWQayAOxwo4wsC6iqJf
         w9Bi2zo1IWZBUpg6dhnKnG5yUoFkod+JELSnYIAIF6Paf/Oj8xNvbWNMtOvZwOPyDly7
         SBipYSu0Iknr3aKMGHtdyfXPA3aGT1OpWvPSvjMA5oNAHxo5wO2+yrhOZ2WJmmUewh6r
         ESGw==
X-Gm-Message-State: AOJu0YwsbFMMCWmpYk/tSybR6j1bb5Dk3E0KIGO5dAqmcW1CBm+9GA2d
	RMmnaleqorBVzsKxv1TSt1ZtqkMLo1kziox6ZxZ8BPkZhLDADwVnlEl9voXksUhg9A==
X-Google-Smtp-Source: AGHT+IEq5Dv6jaQc9KtMj6kpe6JPoyjfuLqHas2UiNlZnzBvOD/+VYsfU6DqbBle6q4kTh6V8c4KSA==
X-Received: by 2002:a05:6a00:10c9:b0:70e:9383:e166 with SMTP id d2e1a72fcca58-713c5271f80mr11650233b3a.29.1724054030496;
        Mon, 19 Aug 2024 00:53:50 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef6eeesm6147151b3a.118.2024.08.19.00.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:53:50 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 1/3] bonding: add common function to check ipsec device
Date: Mon, 19 Aug 2024 15:53:31 +0800
Message-ID: <20240819075334.236334-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240819075334.236334-1-liuhangbin@gmail.com>
References: <20240819075334.236334-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a common function to check the status of IPSec devices.
This function will be useful for future implementations, such as IPSec ESN
and state offload callbacks.

Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 43 +++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f9633a6f8571..250a2717b4e9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -418,6 +418,34 @@ static int bond_vlan_rx_kill_vid(struct net_device *bond_dev,
 /*---------------------------------- XFRM -----------------------------------*/
 
 #ifdef CONFIG_XFRM_OFFLOAD
+/**
+ * bond_ipsec_dev - return the device for ipsec offload, or NULL if not exist
+ *                  caller must hold rcu_read_lock.
+ * @xs: pointer to transformer state struct
+ **/
+static struct net_device bond_ipsec_dev(struct xfrm_state *xs)
+{
+	struct net_device *bond_dev = xs->xso.dev;
+	struct net_device *real_dev;
+	struct bonding *bond;
+	struct slave *slave;
+
+	if (!bond_dev)
+		return NULL;
+
+	bond = netdev_priv(bond_dev);
+	slave = rcu_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
+
+	if ((BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) ||
+	    !slave || !real_dev || !xs->xso.real_dev)
+		return NULL;
+
+	WARN_ON(xs->xso.real_dev != slave->dev);
+
+	return real_dev;
+}
+
 /**
  * bond_ipsec_add_sa - program device with a security association
  * @xs: pointer to transformer state struct
@@ -595,23 +623,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
  **/
 static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 {
-	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
-	struct slave *curr_active;
-	struct bonding *bond;
 	int err;
 
-	bond = netdev_priv(bond_dev);
 	rcu_read_lock();
-	curr_active = rcu_dereference(bond->curr_active_slave);
-	real_dev = curr_active->dev;
-
-	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
-		err = false;
-		goto out;
-	}
-
-	if (!xs->xso.real_dev) {
+	real_dev = bond_ipsec_dev(xs);
+	if (!real_dev) {
 		err = false;
 		goto out;
 	}
-- 
2.45.0


