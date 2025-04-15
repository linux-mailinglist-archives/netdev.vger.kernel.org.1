Return-Path: <netdev+bounces-182721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B552BA89C25
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FBF3B6014
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B462BE11E;
	Tue, 15 Apr 2025 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CCYm+HvM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA342BCF57
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715880; cv=none; b=m8JugMU7HA1s8u8+9vFdHdAa9utKHgZ8Xmu1TcQnNmu/v3eF+Yj+CABZn5SWXbsg5KfvsV7nlE5q4TlfkFfcg/VXpyJcj1YkixdK4vwDkfBVrVhMgBOwv0QJi2iZWRwSxjgNtmNY8u0Mqv0rI2a3bQyyPVN8QCsDLlvUXoW1SVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715880; c=relaxed/simple;
	bh=+m3tlswA/C58CSW303WbNzD55RlTq5TdK2GIiXBLu2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UV7eIgpMKglSMwZIUEbVxKtGQXtCRC6bz9M30XsZdy5m4rMIfOGjQ9sm0MFhR/No3LhMuD6BICGFhgiHgxcA3mFfFmiMYKw29Y0pnm7MjXJfkaTqeR3VufRKZCxWj0lLU7uZ+8htKgO7r2aCRj9ZyOdFcPLDvmnRt21jvjq4YLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CCYm+HvM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so47180975e9.1
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715875; x=1745320675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDo4E58Z4GiyjgViKH7H1rsh8W7CNiDIluEBrKsBDtU=;
        b=CCYm+HvMTAFEbZD51Zuy9Z8v7PsY6iOdytPQBwYBzs804TOwkFytb6IWdTLd+D/cc5
         vKKbUVH0mM15D8ELgKs3VTa1zAT/ezaJ8ViXrJYADcO/J3KnDV8ipnxTSCdtBuKVvX/+
         /CAEmosPXaIGcWwfMdHEtTiqKd0Q2y3n2N8xNxXYBqpnIcy563sxKnKCqgnnfvwwFFAz
         JDRZMgzNX/pFBqNprt85FqSTnfklWoTd/xTZ1l02IIsAylRsbqdNrK0T/tTj9fpmPW0y
         5vOnoDYC8JGjMBFhTceazynYUeZabHeJi7eKjlh8GXGSOOSb4VMfGdMq8pYWFdgc/NkN
         H7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715875; x=1745320675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDo4E58Z4GiyjgViKH7H1rsh8W7CNiDIluEBrKsBDtU=;
        b=lLALrOPEeGPiqPFEA0f0uv32T+wCVfOQ31eLFRetqZXFKEKbUNbQus3W2tihrXCO8u
         9LGLLveYg9WgjEssfL5klvh4mh5Kd7q14lYvETYqJub/ZEIhGZBZqGzzjQuiJYHhBS6s
         iHYBTKbj8asPWosxzU2LY6FaNEqHHHDR2ymkQBOka3zagdw4wQM+IQm9zcEYM3MLYgwk
         oVSWjaD/G1n2z0aj0RtjoSqdg3nhDxBegFnAUMZgHm2V6fw/f7GV/zcPHPJYXiC7SP5g
         tOOH/ao7GJf1VCl4hcE6Sd6zYQvF/y5KeIGP6RPpEzmMOTuxhk/THkfAJ6lGLR6kqlg0
         DoKQ==
X-Gm-Message-State: AOJu0YystsNDUULwxB1sV/Ezty1kRlYkirKam35iyK87d/iINWRFl85z
	4QH7xuswfXdBYmUpO6f5EA2qZKFDMvCBWCBw1W2Wco9ctk1+A6DqdzM7Pjb69POyjHEw8hQCfqQ
	wt3/9f8bAYufZa38kFx6qFK2TMiyOomIEIZ8eOyPJ6q+0rkf1qUl0ktTPFax7
X-Gm-Gg: ASbGncv3OpnsSPnfYXzp65CzeMqctQ8HtPcsmD+A7ItFHzyjOiOUPnAJrOXf0zsT71x
	ubrmvj1xj0gTVYmmgmB9NWaGEcUDK3eigpBW9NrlZNxDCxoGiO3U5DOHgtBr0wBAksDYT5QcjTj
	FGd8v+mvIZs/u3nluAwPN9RVSCuiehFJfZVPKqmO99Cwp6PFMHim3UCoITY0aOIHEaiZpIKIPw9
	2cVBsZ82AZZqgfwdXM2JE8NRobhPXPew2SascyKlnzjsdyA+MSRpEniAsOJBhuGmWH5nXj/F3RP
	mG5qA6WT1NpEYWiCEJumpjwc8Eh6RaKBtfBhkA==
X-Google-Smtp-Source: AGHT+IEFxLDPrCvz+qbpmpr2fHmj5St/mAmYl3ctWBeGLo/g0haXN6SiP/ICM1A8PSpby+n1t8YiXg==
X-Received: by 2002:a05:600c:3483:b0:43c:f8fc:f6a6 with SMTP id 5b1f17b1804b1-43f3a93c7c7mr153344635e9.9.1744715875528;
        Tue, 15 Apr 2025 04:17:55 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:55 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:39 +0200
Subject: [PATCH net-next v26 22/23] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-22-577f6097b964@openvpn.net>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=+m3tlswA/C58CSW303WbNzD55RlTq5TdK2GIiXBLu2s=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn/kBCJAXJ5ieI9UdG7ZdBzCyyuDy+NnVdZLyz1
 zyACUGimESJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/5AQgAKCRALcOU6oDjV
 h5jlB/4h54npijhaPkX4d3rH9jsOt18HydP/dplr6UDnxyMs6R9XhkvR8bgYIywNJVCV4VJSNrj
 BAnwm2DWMmUsCM74MKo5/S18nmKpfTkzmInqqPmDp6IOVy8JkzYMYsDxdueu2S7ivLNug3fqkwV
 uRJaoUoRTXz1cqOdL4EMVvqpJd8tAD7YPIurmewpnw8BWVrt7BCr5/Xtd+WWNS//6OALl/sMHMS
 xiUtoZXrQ9yhS4AQXHqI3Ie8BxXCFup9qSCWs2ranIcJbbMZ3OSt198DgjDELg25HAoqx+YMpg8
 e/CuCa5MGagvmrJaY3ymRqLh7gMTZT5rSSvF8lsJ689JRs8+
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Implement support for basic ethtool functionality.

Note that ovpn is a virtual device driver, therefore
various ethtool APIs are just not meaningful and thus
not implemented.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ovpn/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 232eeb08e929230afca909bca539ef97892837f5..0acb0934c1bea49c2277aeebefe68dde660f2042 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -120,6 +121,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops == &ovpn_netdev_ops;
 }
 
+static void ovpn_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, "ovpn", sizeof(info->driver));
+	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));
+}
+
+static const struct ethtool_ops ovpn_ethtool_ops = {
+	.get_drvinfo		= ovpn_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_ts_info		= ethtool_op_get_ts_info,
+};
+
 static void ovpn_setup(struct net_device *dev)
 {
 	netdev_features_t feat = NETIF_F_SG | NETIF_F_GSO |
@@ -129,6 +143,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_priv_free;

-- 
2.49.0


