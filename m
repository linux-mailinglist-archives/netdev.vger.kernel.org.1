Return-Path: <netdev+bounces-122300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AEC9609AD
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1E11F23C6C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095421A4F33;
	Tue, 27 Aug 2024 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="S5Z3jIGa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383FA1A4F24
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760426; cv=none; b=UrKtZxk2O20p7rCh6/qZtUBHi37FiWgYV3p45eohl2H8gj9o88Ggm3Q7MLyghyTv3qUH+6W9kj16q/yyzFFjBUp79hLUD2bsAKw3FXh47aame/iPwSLTlm3Usis0pC+vTIbFJ+E0hxyQHAovlEK6bj/nEWyVlSOO58cs30qw8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760426; c=relaxed/simple;
	bh=bFjSxn3UsvnT++qpnletaxrz0hGEroGsrt4q0pNf874=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgBHC4tlwKQMToB6NY3ExajsMlGO3nxlMZTRxTnMckzD8Ya6hyoBg+SANQpj8fooVJJdsHgKmu4WFii/xCYKofD/emk0hQkT3wuMZJvKHjyv6NfnNQiv6lkgrEOZ1iZJXPdPNwmg2AyVRwzaeEnkjSMGTyUDWWCVxaxYhXQhFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=S5Z3jIGa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280c55e488so29404185e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1724760423; x=1725365223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhXP8SODVKlGvDN11fmRPRo+wWrpKiG9nbgFKuh1dDY=;
        b=S5Z3jIGaZUISNhUEwKlVTOH3eOhQCwOA7pAoF52sk/dqoh7FVcOSjipnzL1WGJL++/
         hgoIG2+LNTrosDXwdBX7eQDYwEXjqMMQa7NEXwP9zEZm8iLIMKUvlLgTADjM1xDnW16f
         /WVGRTJhInEfdjhSpecqcouN6GojI6NoONWUzyS8JpD/1GTpd9Nl5ujAl0L4A3q+4Uz3
         O2Vhoph50njJ+ChcpQJH4F/DrY8Gfn6S55l6xCMXXuCiCjZOn90RXQqPynGTD9KKkUCB
         jgJ6ysGHHX9YCXxkwp/CAJ2Up24/HM2MNUAQxbdpknIVSAXmfRz2A/yCHL0AXlP0XGxm
         YS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760423; x=1725365223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhXP8SODVKlGvDN11fmRPRo+wWrpKiG9nbgFKuh1dDY=;
        b=m2ia03cN+PengwbCrffGjOU/5V8oks/xyeeRSq8DDq4CNTcMUOD/sqHnjFdfJvfKXL
         qJVMwxneXZmmidE4oDWcVzfgzfmxE/g8RfmWCx5bHQDI9iNHsi2avPIN03uTEeqp7sxp
         g7mhzpgymR2Jh3LUJJ/bArnl9KDacathA2nrsxaUqVGamitievnjx4LZN2fQUqJyWNae
         xlWloicX7cKXdn4+R6NuMhIRCgbpr/BTQ1pda5qGnLOaM75feqhowUJjq+gZEHgOh0cQ
         53SQ+5sKinusR8sYL/WFfDrMBHE2JkjlWonnfaskaDrOzmJ+NqdqvOvfIOHaH4nc6x/m
         ITOA==
X-Gm-Message-State: AOJu0Yx9c+AKgP4rS+sV2sYmOwsKKD3/wpg/0Us9ATqM8+6ENbdZy0p0
	Ok5t+w3KRYcL6aBtkr3z88Ldijr4gIA03wqj8dNmqrn4XDjTzHX30pkniWUr3cNLrzbDcExkx+J
	C
X-Google-Smtp-Source: AGHT+IEQ1dJdvid6Ejm4R15BxjZ6KcVDBSLqsuqoPN21t+7VItfrf+Iezc7DiVQ+/0oUnbVxq5G1Hw==
X-Received: by 2002:a05:600c:4fd1:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-42b9a46186fmr15432965e9.6.1724760423279;
        Tue, 27 Aug 2024 05:07:03 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:69a:caae:ca68:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158f14sm187273765e9.16.2024.08.27.05.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:07:02 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v6 24/25] ovpn: add basic ethtool support
Date: Tue, 27 Aug 2024 14:08:04 +0200
Message-ID: <20240827120805.13681-25-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240827120805.13681-1-antonio@openvpn.net>
References: <20240827120805.13681-1-antonio@openvpn.net>
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
index 0f9d79a05f4f..b29d16894e8d 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -141,6 +142,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
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
@@ -163,6 +177,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 	dev->rtnl_link_ops = &ovpn_link_ops;
 
-- 
2.44.2


