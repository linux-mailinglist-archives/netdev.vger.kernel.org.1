Return-Path: <netdev+bounces-175554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0404BA66596
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 02:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435453BC1F7
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 01:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1071F875D;
	Tue, 18 Mar 2025 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Y+x7McyD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA801EF37E
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262093; cv=none; b=c+HcncjPgIyAYLbDfcfSBMgFLQvXHGQCpRUjMe/94/Ewsf3ljfA0owcPYjFhOppBJpGkmDPbq63CH84Le9bEATCQjshPpRMtfIE06aoq8CnqYtrvyR+7Zn0xS3RRtQNRTKzpGRpefxWf96VS8vVPCegTtxZVXP309gAqHU/Axgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262093; c=relaxed/simple;
	bh=YJpc8pMxsLYNNRUlWrZ2kHAl3oEphn4uU6QJ53WdTXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FvweliQJV2yA3NTkEexCtfvm9DjGdgqnhJaJOQ8jwqG4uB0z7fuTgQRJsCdeCVXXJiCPRG7PL/VZcTWj7kDgGGuzf1clQvvbS9f2++RzK4UW4qwSBEWUp621lwqiponGOiYCBpxPOxiB/LEnOmUT8ydJLgwR+5YINbtVbzjJqOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Y+x7McyD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39130ee05b0so4943749f8f.3
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 18:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262089; x=1742866889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPCXdq4tprzLBOzXTqu3VwlhD1GLSx6PuFq2gznYrOs=;
        b=Y+x7McyDJ9xn2vStP7LeZTfvNd+8UfCBEj+EFb7uI9IJNnQozPv7+1y7iwFux9Y4Jm
         M53xl73Ww29eZk3eR8TUuUb+FAEbZjiOwBKSwAj9qYhgpZOuue82qSYM7FU8XaaYbKke
         SVpdvfWqebCOEdJk0VprnuyCJskuGzU1Yj1gMxV/AXvojk1H/xgBqzoqEQjRFuu/2FYI
         3uiM/3KU8HtWb+AMg3vi6QOIqdzFmvheZlf6zSlGrk763SdazlJUVKL9igf+LvgDXKmT
         jazbIzB/ilSdAIaSTULLxL9AkWtqUhPFd6JPBREQ2GF4jiXebCz/t0u7O0YMz2lVE+Mr
         JvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262089; x=1742866889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPCXdq4tprzLBOzXTqu3VwlhD1GLSx6PuFq2gznYrOs=;
        b=tAdpbvhVPRO8LSMFAL1/gZAggQO+dQr5aaCjKs92jOT4M64/X/LKWjnx5MqzOo6PKF
         6Iw6k+8qP3iwnLad1nQOLXgFi3rEfCJprpwM0WL3VmQZyvOJ/uCPaX1bEeEuhh+tnKc9
         cH2HDo7CfBypjJ9qPwbAeVcs/H+mGZZVv6FEkHrYThdRn4tI97auIw4NCYKrHOXeJwb/
         dZwIwXHe1xhmppyAo29wFLRarjFfNC43NfcDdnmkAr6fxxLW6uUfqj/deFJBoYVXL576
         mfy8pIyA3AuBwD9E1GcoRxHKp/zXsx8ODxpzMxi6M/foj++laSA4xFBOwvNzh4MpYKkT
         4g7w==
X-Gm-Message-State: AOJu0Ywc6Zah9qISnvhu7C3UC1n8bT9uMrt+xzxdIs5S6OPvhzCJMfl2
	TdYRMOxGxHVmJU8bN+E6GTTc4mHx8TtLwFErO+LuwUYWxw1V5SUzvi1bwmbB8zbX+hd5rG8Vbdy
	ym1lDeyn7E1no8nH1d3fwh4TDjP8+7b2YnVY4yhBtwyXYWIw=
X-Gm-Gg: ASbGnctipLTF7WkiHMUJC+xWkXJbgPfYeEMVTzl5tWfVPFXh5dHhR7dog1faDL8Bmly
	Ztb3MnfGi2oXogh3wxRDGZi8HQobZkvH/F8V8Atk8aFS5vwQnBj3wC68YiCkkGfaYRGL9QEuZ8c
	70UFwOZTLvC71O5BUmHsYZ7i9i3jRRK2tsOi8lw8sUN9uK+9qb3CCB6j4lrJRJQRiyW7ZOzgKZz
	FskfCW/y7/AHKZs68D50HBrqT3v0ApXffxlnw0ZSF5+0UH+BcR6VCPYPt2OUHaEqji7RLzw08CD
	y7FJAnf4j0DY1C1XJCTGR9FjNRLBbnBjJCJNvopZBg0x1BFO2GwF
X-Google-Smtp-Source: AGHT+IGnaoL+/WrNlf/oi8Lno0uHdghgZDjGsinfDSGjCxDToLt/iaI4Xm7pGExTBg1WAqAkZWM/7g==
X-Received: by 2002:a5d:6d8b:0:b0:391:456b:6ab7 with SMTP id ffacd0b85a97d-3971f41182cmr13912111f8f.34.1742262089070;
        Mon, 17 Mar 2025 18:41:29 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:28 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:57 +0100
Subject: [PATCH net-next v24 22/23] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-22-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
In-Reply-To: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
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
 h=from:subject:message-id; bh=YJpc8pMxsLYNNRUlWrZ2kHAl3oEphn4uU6QJ53WdTXE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn2M8r7cdzqOcWLDNG3hxRpMzLhBTpGvQfazsnG
 7tObj5zdaGJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9jPKwAKCRALcOU6oDjV
 hyAPB/9USkodSv61gegYrJexDUcF49I0LVZEbnFUmIt85ORfzF2NgXGgzfsvsRrDAVvNEjt0V3M
 CcEz9ZfoBPF6YLu60L6JR1KxvmfksxszPKROytIwQ3Pi8xbWnEE0px+NGzdHML2pg4vKUQE9OM+
 0FJfMmbBXUpPn7IW9nmZ1goFdi8f6fcH5OZktSXa3acM/NhRx222UrEqx+2pEOVBKZJKamrI6b4
 PBZhyaVAdXJp0w98YDZ1cBjl/kX/o3VrGU/hWF9IjPWvIXi4DzTOVxOn/6q6tquBa4UaUVcynV+
 x0wjHxIgoui3ojUJpTcS+6PGUFtzRMDT5xdoUBtF/xR/Qvbu
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
index 0e016d39c95e52515437313064e892aa3038adad..46abbbed384a4a98e87fadf5a3d749adb78d1de2 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -135,6 +136,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
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
@@ -144,6 +158,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_priv_free;

-- 
2.48.1


