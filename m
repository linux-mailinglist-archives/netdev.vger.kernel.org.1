Return-Path: <netdev+bounces-167404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A91A3A3A279
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38515188E4FA
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36BA26F454;
	Tue, 18 Feb 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jkzXBDAJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0CB269AFF;
	Tue, 18 Feb 2025 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895565; cv=none; b=u8RnhnAOBAA9pCPr2/OOpdsIV8dZvwJr9/wMbwyFVsi1q86U5BN8QYdzHCV09QluCCyr5XrK4YqqqIty0gNzShKaKSzuDDD2ZLZbC7v3/z50ohk/51dHZ82D5pgrBU/piR7zUH2hq0BbG+T93qCSYjhxCwnvSaYCA0CI/zRzXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895565; c=relaxed/simple;
	bh=86C2Qzix1lo6SR8eDMtZdgofRq2SyH17mL6NjMe8zA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/jGe4hUeeGeFTFHVb+LN0FPBDJYrnozJUcOIOr2XBI0J7KqX48UD+pzt70HiE0phvI8AZg56JCatlpGQQG/pVuM3ywXNTEUDY+qVgbQJRCwNZnocKvDlPGvxC5TkCuzy7mBCjn/0m+WyVkvlgYrGxBYMO891TOwmOZrgw7x1jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jkzXBDAJ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A194442E9;
	Tue, 18 Feb 2025 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739895555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSrxaeJMUGvDcs0eOQLiSMH1V+CrX+utqUR+Yq9x+9I=;
	b=jkzXBDAJl8onlsaDvmFDgMEza+/WorA8+V2stIshCUTTGRAz4OCCZ3TzMRrpAPiLkU6zK7
	CexkE83F+d3eF/WoJmYVt5pSBSUuHeIW5aciqPbJRgNLUzgKZFo6vMwPfSuhBGHHruWQ9v
	a8Q7DGG8Ug66Jz8zTchsyMaU/2wGsNOi7HuVugkmWPwLnAdZ8cCqLz2BJcheNP2TCb+VEq
	mWB1fyQoPjwv4c3KqoORtNiZ2Arh52WG2TKnr/AVVNYbcoPBByK2sdm+ii4cGX89Dvk2LV
	znVrRN5I3Y2vVZ71jJ5jiM3u3Gnn4hsYqubdgxqsgrYxxGmkhcyrwnqT/4rreQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 18 Feb 2025 17:19:05 +0100
Subject: [PATCH net-next v5 01/12] net: ethtool: Add support for
 ethnl_info_init_ntf helper function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-feature_poe_port_prio-v5-1-3da486e5fd64@bootlin.com>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
In-Reply-To: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppedvrgdtudemtggstddumeeftdehfeemrgdvieeimeelvgeivgemleeisgdumegvsgguleemfhdtrgegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdtudemfedtheefmegrvdeiieemlegviegvmeeliegsudemvggsugelmehftdgrgedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdehpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopeguvghnthhprhhojhgvtghtsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhuk
 hdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhesphgvnhhguhhtrhhonhhigidruggv
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Introduce support for the ethnl_info_init_ntf helper function to enable
initialization of ethtool notifications outside of the netlink.c file.
This change allows for more flexible notification handling.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
---
Changes in v4:
- Use the new helper in ethnl_default_notify function.

Changes in v2:
- new patch.
---
 net/ethtool/netlink.c | 7 ++++++-
 net/ethtool/netlink.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index b4c45207fa32..bb1a35494935 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -758,7 +758,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 	int reply_len;
 	int ret;
 
-	genl_info_init_ntf(&info, &ethtool_genl_family, cmd);
+	ethnl_info_init_ntf(&info, cmd);
 
 	if (WARN_ONCE(cmd > ETHTOOL_MSG_KERNEL_MAX ||
 		      !ethnl_default_notify_ops[cmd],
@@ -825,6 +825,11 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
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
index ff69ca0715de..af20a175e111 100644
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


