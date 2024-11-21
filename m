Return-Path: <netdev+bounces-146663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0F9D4EF3
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB601F21AAF
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97541DF751;
	Thu, 21 Nov 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TKH4TMvy"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AD1DF263;
	Thu, 21 Nov 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200238; cv=none; b=p4US2dddlI+T0uc40QmPN4NOAVRv/c1zwIQ/YWag4PQH+xxW/73S9LnjbGdYDfVrPl2KnbYGNEEhGwEJjwF60WED2J39Jq8fDdj5R5Uwv7KwYpj20mD+vGvpB6wYxInmUuqNVL3gI/JynDFV7dopV8SGqb5wGPRcpHADy7GQTQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200238; c=relaxed/simple;
	bh=rP+gjxfNiydSHOlT4Rz1/ZTy07AjwCiEEMb4usd8nBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E2svQFzJh2CZgihJE3uQndprbwMJWZWn29i6w7jdM3anV4DfNyFdnV9yPNQ9p/S8u0iWjw4qKJYbnf/wPifW0E0PNVIfoV5ALpLWW9SPLC2YCpB/qcGp9++9Qag9KIC85Y+p9uQsw7c3/wfboOlFUUmDXMbtHQX7tWewnPZDQnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TKH4TMvy; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41A494000B;
	Thu, 21 Nov 2024 14:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bP1tzyckBMmYWq9DCKVrsYF6OCjs8sclMJz28WzMgsE=;
	b=TKH4TMvy/YPRsNjWIDWtlg41nY1Aq+yhQUZ47XO3mjmcxxMLQ4w/FDxJ3YGvLEuzehKfE1
	0ykmyN3XwXdMvKRu/C18PYiP2VfbDd1H68XXA3nj6uIHjkyNUD8ncDkQOk614bLddtb47m
	gmDVnZQzvAXifx2brnxpz9ZJrK/Mk9E7MfcNdjBFSlzUowCm7QYg+yHp3XQxTdxvz7BZpf
	kM9JllzFyik1A/HYfqYSl/G5444Ye8xZGw78HfogU4+XX0djhOjBypKFCxacHjglTOME8Q
	Ex6vXcYveIlrHFYgnsByS1BsA4nRGAHFqIFIYRl/d6UtLuUKbJRN1tXFtkgtPQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:37 +0100
Subject: [PATCH RFC net-next v3 11/27] net: ethtool: Add support for
 ethnl_info_init_ntf helper function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-11-83299fa6967c@bootlin.com>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
In-Reply-To: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Introduce support for the ethnl_info_init_ntf helper function to enable
initialization of ethtool notifications outside of the netlink.c file.
This change allows for more flexible notification handling.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- new patch.
---
 net/ethtool/netlink.c | 5 +++++
 net/ethtool/netlink.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index e3f0ef6b851b..808cc8096f93 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -805,6 +805,11 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 typedef void (*ethnl_notify_handler_t)(struct net_device *dev, unsigned int cmd,
 				       const void *data);
 
+void ethnl_info_init_ntf(struct genl_info *info, u8 cmd)
+{
+	genl_info_init_ntf(info, &ethtool_genl_family, cmd);
+}
+
 static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_LINKINFO_NTF]	= ethnl_default_notify,
 	[ETHTOOL_MSG_LINKMODES_NTF]	= ethnl_default_notify,
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 203b08eb6c6f..d04a8e9d54db 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -322,6 +322,8 @@ struct ethnl_sock_priv {
 int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
 			enum ethnl_sock_type type);
 
+void ethnl_info_init_ntf(struct genl_info *info, u8 cmd);
+
 /**
  * struct ethnl_request_ops - unified handling of GET and SET requests
  * @request_cmd:      command id for request (GET)

-- 
2.34.1


