Return-Path: <netdev+bounces-107284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B93791A762
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E9F1F2475D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51F118F2DF;
	Thu, 27 Jun 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YHSXstX+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418018E778
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493705; cv=none; b=uw2e2oNOIXDie3fCI4DkDXNOM17jXZkWE8OZthustkkLu64dgY6MoYw/+Xgw2defKVUsTVLFB7s2JlEvW/ut+LuxU3p6VRJ/6rFq+cp2wiaDUCQ2wHVbrlmdtcfzHITCacX4vDp6I/M2niCO0w6Dy0M2JGzLSpLiT++2Fvy3e+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493705; c=relaxed/simple;
	bh=RVMYNbdN51kkjJnss2TueF1vuo8kFwKiti72srdqkOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXMjzT+BJ1REkz3ILSYsJziI1FeEX9jNFd602yXgSpDWqw8tPCl6ZYai2QlOw0hJ7Jr9HRljJyWwP6ZMAkAIq1WYvg9sY2yvhrry6IRCCWboPY7lxd0dq5qgOb1IaOZYSvyuO9WEfzbHEwdcTGvn+2I0+zlju0q1iFcIYaar9kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YHSXstX+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42562e4b5d1so8837585e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719493702; x=1720098502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjKKswhYZfNAJG0X3IKY/rvV4CESAee1DJsp2gbMC8I=;
        b=YHSXstX+cdyERCmMnuNmuUOiYGAX+HkDAQMT66+FJm0OoIf452A7ZDaDmaueLOb78w
         z4SKjwviv2WUw4XVi8/vKEyx2/zKyoD0NQ+hVJTxooGsN7hZiWWlMpgNGjRJBXkHd+Fz
         c4noCnp5qy+JC+NuKHlx/mBnoigafeUCdn8sbLUgAR/O57vQ4X1WPQhb0in6cWO3n300
         vcVF/Pt+C1pkEHu2iKHAuPPAwTtFIb6/G7c7fvjhrWHPBxJqLN39yIg+S7ujKzlesqp5
         hNS6kQ9x+mJvXNr7/+B69kA0UwmOxXPeXUykmz+hoj74TvP6g0XtvbKIUj9GAzl7ulU6
         WaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493702; x=1720098502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjKKswhYZfNAJG0X3IKY/rvV4CESAee1DJsp2gbMC8I=;
        b=wI6Ek60U0lrByMm6DbNQEbYP1XkAWy3t1sLYZHLTv+b8Csx4VgIYVL9zIZ6r7acaHD
         mLAXk5HFsa3ZJxYLsFyeRTmX4+uFLhqgVSnasR+8EbP8mn8eeFQFxYD/8bOLvXwCBx9u
         Dcak70c3piBrjZVOmFJHxhmz6Ro+aIABMuMGdcvPkuZ0CMKVm0h9BfKxCT/73scvpPTs
         3nasAtz83WPHLNpazoM1cH1pZXhUucgx/cr+WeLURb/if0w4odcY+W9Ftsma3iSj5d5h
         phxo8dMyQLxR10m/QmtzupsGL6svpqf68vPgTkVuVld5+nuzyCX/Qgzleoo1MGfRHRfu
         famg==
X-Gm-Message-State: AOJu0YwKFbHtOU6HH8rHfglSpgahIOn1Zn2oGRPiY/DNi5IH3cAK/fSY
	OxvFjb4U3GNXb2hBGCAp75b/2RXliBKWXzE9g9IcFioxVZXAp44AUsDWs9rGgD3cVfkc6qMS1PC
	Q
X-Google-Smtp-Source: AGHT+IHTvASkCstMTjlzTs4yJPgfGsx+hwXQlSZd4dJROg8zt3xVvWGyIx7D9fuPRW1FZzS5Ls4wuw==
X-Received: by 2002:a05:600c:6c97:b0:424:a822:7845 with SMTP id 5b1f17b1804b1-424a8227914mr42020055e9.10.1719493702019;
        Thu, 27 Jun 2024 06:08:22 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2bde:13c8:7797:f38a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b6583asm26177475e9.15.2024.06.27.06.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:08:21 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v5 24/25] ovpn: add basic ethtool support
Date: Thu, 27 Jun 2024 15:08:42 +0200
Message-ID: <20240627130843.21042-25-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240627130843.21042-1-antonio@openvpn.net>
References: <20240627130843.21042-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for basic ethtool functionality.

Note that ovpn is a virtual device driver, therefore
various ethtool APIs are just not meaningful and thus
not implemented.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index cefd7010ab37..985dfcf1744c 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -132,6 +133,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
 }
 
+static void ovpn_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, OVPN_FAMILY_NAME, sizeof(info->driver));
+	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));
+}
+
+static const struct ethtool_ops ovpn_ethtool_ops = {
+	.get_drvinfo		= ovpn_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_ts_info		= ethtool_op_get_ts_info,
+};
+
 /* we register with rtnl to let core know that ovpn is a virtual driver and
  * therefore ifaces should be destroyed when exiting a netns
  */
@@ -155,6 +169,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 	dev->rtnl_link_ops = &ovpn_link_ops;
 
-- 
2.44.2


