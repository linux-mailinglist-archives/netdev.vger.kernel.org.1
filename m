Return-Path: <netdev+bounces-144367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 228FC9C6D50
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A6BB257AC
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E10317B4E1;
	Wed, 13 Nov 2024 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/fCym+g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA791C9DCB;
	Wed, 13 Nov 2024 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495664; cv=none; b=Bxpv3tdxXHlT8WyxUOPJTxqrvVJDZm1CS9OuBfoKeoTB/SCrN4XbedlLjO1DdaVN967rMJx+r/ZG+z4UupYL4jshiPyM+wMAiW7S1+6EhofVgRHTI58kRsZVgZdqERhUBMKuxfFo0SXqFIGh561yPwfsaiKqbuTyjHHjz6tKmqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495664; c=relaxed/simple;
	bh=oQZESZMkxYF0hkQUvzIogzJ0fXSoPdUKiXJn+g6PHBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LjEaAI15yr7knSOrBdIGtWfhNRb6fdoSfUj1qXxzNFw6ADhr6BKCG9MAE3lWIWRdfg3aemR/48kEMGIQmUvygBC0T1IL1Xiz+LFrhSIJpGlQ7XSYcDW1qn0CM72HJMYrXxEf+hVyWzl01jmxXI95TC7Wh1HsyZmiq3IcANPwQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/fCym+g; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ce5e3b116so59777765ad.1;
        Wed, 13 Nov 2024 03:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731495662; x=1732100462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gDdqkUB24ogoEF/Q7p7IMl/brOTF5+Inhox9StrCIa4=;
        b=F/fCym+g16tAURH08f7KxosnJBmfaRsTUUwZDC/ZQZ+/fWvlSGbtqELPeqYSAeqza4
         jh/xVmKOugo+tSKuisc+LvAcrnBxP46fZ+y3VRDHi6fxsys4Ehe0jOiGHAmMsMfHFr7H
         DyYlLOqO1WVk2VteC/N2fromGEr8lznCmD/Ypf3P5mHuz4dsUPbXKWx+G1nkaJpcSrM/
         3k8fmlfeIWPKvnpLCAjOE6QuoVddNhUIa7AJIt38jeJSkUHMYgekSxiGw9UZ1IHDHdwM
         paeBT2skNH5cBMz84R6YtRWteSPvoPct5VUDfALddl5Feg63/bItCKFwmk0C5D5sDFXE
         KUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731495662; x=1732100462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDdqkUB24ogoEF/Q7p7IMl/brOTF5+Inhox9StrCIa4=;
        b=xLN3ICk7RxlJGjGDKXKKWNQ4LeiRsb6zrpPaECKFP0UBAnqhKjek/lzcDh7qPGew46
         edb0XxvmH5isrXPrLwgkap/QrBN+f0HsYzqLINMuZ8gOM58uWx0XcGJ7YlB9caJfJTDl
         Ms4a9OCi0QDfFC+Aft1OjOSakU8IrjMS9ylJZbIgIJ+xqCOgp4QMKRPFXkqbHpI9UGhN
         DIEoJFeGVKVg3dwZC5cju4Ci6O9FJKJu927idh9rcg9HELMUSso18TMhEVSoP5mQ1xYo
         uIqn4y39NTc/XBHRQn8GvQZA7r8RcZdNS4pPCRDuwMxgavA7eF9VwZM/GTJO4FYahE8P
         zLcA==
X-Forwarded-Encrypted: i=1; AJvYcCUrnjhpdcnl248uhujkf/XK3J6IfAf5W1QNEAqNtqNOPk2HEzBCuo4pAWxtqjxAaeJO1iTQ7jqB9Lp0AoM=@vger.kernel.org, AJvYcCWVe1ybPgEP8wbeZZxlQOD9K/JA9BA0civ3Y5gtE61Yy9qm+ZdlMpsBgU+gpTlVLs5Hvr2ATgXh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4IaxT6rteF2XYqRnC6TAsBITNybRy9+RwDBGdsdkIysnuIQtw
	UqiCdqwpxevuFYB3xfatD55DBDfQHEd+AV94mtclm+Z4QTtDaXRm
X-Google-Smtp-Source: AGHT+IFxAclckthpUbyy+iAbzBQemWbTNp7ZwbiN8UpUmPmopOLhHnlMbMAhtb53ojR6u6HTwSNaLg==
X-Received: by 2002:a17:902:db07:b0:20b:775f:506d with SMTP id d9443c01a7336-21183dace86mr288522755ad.34.1731495661779;
        Wed, 13 Nov 2024 03:01:01 -0800 (PST)
Received: from harry-home.bne.opengear.com (122-151-100-51.dyn.ip.vocus.au. [122.151.100.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc8073sm108424425ad.5.2024.11.13.03.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 03:01:01 -0800 (PST)
From: Qingtao Cao <qingtao.cao.au@gmail.com>
X-Google-Original-From: Qingtao Cao <qingtao.cao@digi.com>
To: 
Cc: Qingtao Cao <qingtao.cao@digi.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v0 1/1] net: mv643xx_eth: disable IP tx checksum with jumbo frames for Armada 310
Date: Wed, 13 Nov 2024 21:00:40 +1000
Message-Id: <20241113110040.24181-1-qingtao.cao@digi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Ethernet controller found in Armada 310 doesn't support TCP/IP checksum
with frame sizes larger than its TX checksum offload limit

Disable the features NETIF_F_IP_CSUM and NETIF_F_TSO when the MTU is set to
a value larger than this limit, to prevent the software TSO generating GSO
packets that are not suitable to offload to the Ethernet controller, which
would be calculated by the IP stack instead.

Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 9e80899546d9..34d464f0be1b 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2563,6 +2563,13 @@ static int mv643xx_eth_change_mtu(struct net_device *dev, int new_mtu)
 	struct mv643xx_eth_private *mp = netdev_priv(dev);
 
 	WRITE_ONCE(dev->mtu, new_mtu);
+	if (mp->shared->tx_csum_limit &&
+	    dev->mtu > mp->shared->tx_csum_limit) {
+		dev->features &= ~(NETIF_F_IP_CSUM | NETIF_F_TSO);
+		netdev_info(dev,
+			    "Disable IP tx csum offload and software TSO for MTU larger than %dB\n",
+			    mp->shared->tx_csum_limit);
+	}
 	mv643xx_eth_recalc_skb_size(mp);
 	tx_set_rate(mp, 1000000000, 16777216);
 
-- 
2.34.1


