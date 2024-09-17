Return-Path: <netdev+bounces-128641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB2697AA2D
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0BE1C27577
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C7014884F;
	Tue, 17 Sep 2024 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZmFWHDha"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB90149011
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535308; cv=none; b=L5/0rLM0GPDQW7kJZdNSAPD1wx+33t8dwnW4J6NGcPIoVhem3YpyBpyftkKalnp5qe4hvBacxOlDcUyu3ysjSm+F0cIoy8QaPUXAldmu7YBD56SMVP6bK93H5XS6WXUXQMi8T2SmsN7ixXT6t7NtXiTHR6xSPmLAdok59VXOhcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535308; c=relaxed/simple;
	bh=CvSKqUYGGzrN23TSWSvGgiYutI7fV0Dl+uKhe+KVPv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1cYchkzE1kM19P6ZZCTgU7wcL3OK5NgPx8iU/kIC6VF/9wCgkeWnSiqNsUJaSVPVCLXbcarhi5ikziLfS4VvrJ7GkLGnotZqw2VB/5rmK+UpfbPfRRlKJWZXOvc2O7Z8LgByV7DcHvwNAZjsld2VZbNVqkomrPeFKv3UiwkW7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZmFWHDha; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so31572365e9.1
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535304; x=1727140104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUs0x6ZLrCLPQkjn7ReaHeVyM4ne3u2szq8fXsVtxSU=;
        b=ZmFWHDhahp8mMC4JDQvv7QaJzTD//XoI7gEJVuI+rqA8MBe+d3Z1nwn2+Fe0nnrQqs
         axc6bmpis4mIJ5u17W0Sz+Df9KBgA7T7SFuN9u1WaVxei0L+MaoqgNQ142t9SthMunsg
         uysbq/E28NAFk+lw3WQODhY+yEwd3l2222EVx474kl0Qw2NACXIjK1vwCiuxtaWiHcH9
         PArAn/51Vk1HIyzkbj0Mt/r//kuSF+XgZrLzonzeF+IMHj+JqNhLY2sQxGb6j33k2vkk
         rXthflRjYkSGhWJ/o26fzhURwStshw+/QOeB5QBc6e7pCjI05CF6hjeDsVkdQQl6vHrA
         S1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535304; x=1727140104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUs0x6ZLrCLPQkjn7ReaHeVyM4ne3u2szq8fXsVtxSU=;
        b=cXHOJd+wFTZlKJQPhWK3e8U9ydkl750zPTdPp2dMJwfzqE1SvVYej/u/tP74PHWrWY
         xSVWZgvu4tkkARbKx/7CqoVOA3CUM19phv3to9sDrIddt47Y9XCdW5bBnHvYEFVZUnRp
         eAa7BPC/ANHAYtFE0fS/FxEsGnN2XU97VOEXxTtok6xcbqfwvB68SJGWLBY4Hk0RD5qh
         f09Q10w+ID0XKXTjhPZL/ttC3h9zYxf5sEZFwsEdjal71D4e5m1bZsf7xwiSMJC/efvK
         9gS54zKLl+4F3XbpupnBzJjJkNL2tzxOTkm+QT1tLv1CPWqLR7a06zz5XrCW1kkvK61W
         sEww==
X-Gm-Message-State: AOJu0YxwdLZ8TurejTucLFAjuQYZfXu3NsVM7IlhbbwE0UkaY+FZOFFx
	hxNT8+wysJxx8vghggKIHQ6UJBaerZ4E9ruY2zrJOVraIfYP69HWWS2T6UXcXSPzhFthau4TyfZ
	T
X-Google-Smtp-Source: AGHT+IE00EgLdxVPT0HAoB3cLBg96OylOzUd1Bi2STmOdHBjwGil/uFCufFE9WjG1ChM80uTfzjgIw==
X-Received: by 2002:a05:600c:1c9a:b0:428:1b0d:8657 with SMTP id 5b1f17b1804b1-42d964d8579mr91455275e9.22.1726535304398;
        Mon, 16 Sep 2024 18:08:24 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:08:24 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 24/25] ovpn: add basic ethtool support
Date: Tue, 17 Sep 2024 03:07:33 +0200
Message-ID: <20240917010734.1905-25-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240917010734.1905-1-antonio@openvpn.net>
References: <20240917010734.1905-1-antonio@openvpn.net>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ovpn/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index e63845658885..5d6b898bc3e4 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -137,6 +138,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
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
@@ -159,6 +173,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 	dev->rtnl_link_ops = &ovpn_link_ops;
 
-- 
2.44.2


