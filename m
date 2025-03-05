Return-Path: <netdev+bounces-172060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A37A501B4
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 044477A3B28
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B463D24F5A7;
	Wed,  5 Mar 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f939CQ8O"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE68C24EAAA;
	Wed,  5 Mar 2025 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184392; cv=none; b=j5FdOXNGR91EP3zKagHw9OquNqR3k0U6AHyGOZZquUczv1vgnNMm2IVZucDkxswW4KGjtJ0caF/pDtaOx/nj6ZNwF3YKx6rynBYQQWz0as3tr6YYfwBhWMFlG4WEDyUfnHN99cNLLhcxpGYmZGFYMOj+CXsf18w2iUqfsZivIQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184392; c=relaxed/simple;
	bh=WyIXdMpNK4GEJ0DYzGITV5H/zjEEBgsM1xMcXw8II/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdF/gpc0SIl+448qwvXZvYDLoVeB1C5p127M12jQYvCpvfNpO5p/dEyxq0cSEQWsQ4Uxf7fZYKVQIREUT+4UEEfvDynASAxa+co+kGo9LJpBTxgiwgUqBhugxesOd4eN1XiNG9i938oVSJdYvyPsz5L2YA0sYzSuOwKWfQnEhL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f939CQ8O; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B7FC44120;
	Wed,  5 Mar 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741184389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+x958E8fd59wo0+S7PShlBqxAJBPIungIQ5oX/0I4ho=;
	b=f939CQ8ODCi0F1EgpvuCG5vlwN9oysZaONqaeSoRBnPbwZQGnWdCvB0wUjjNzQUkmAauMu
	OZ6ZpOpDQfMcl3sgdrT4M0YJrbP3IIK8o4WUVefYrd5uXESoxQZtOc0sSFHCT6FnD1/QeA
	n7hjVqLyoki1LvC3iHDeoyxMsyQCFkydryywx9ljuIQqi9E43Fy3XFsG4tiKe4i4hF1t+B
	lByFw/HCTvLPH7YS6miQBLm84BJ0XwfmJkDIpxGHkS+W1GcK1466Aby0/qZH1WK2edAq9u
	WC9DWydSGN7kLst1CVNkO6Djme1flLbqc972QhiWiq3l0B46CzpT7+NzkpUr9g==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: [PATCH net-next 6/7] net: ethtool: plca: Use per-PHY DUMP operations
Date: Wed,  5 Mar 2025 15:19:36 +0100
Message-ID: <20250305141938.319282-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305141938.319282-1-maxime.chevallier@bootlin.com>
References: <20250305141938.319282-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Leverage the per-phy ethnl DUMP helpers in case we have more that one
PLCA-able PHY on the link.

This is done for both PLCA status and PLCA config.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/plca.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index e1f7820a6158..2148ff607561 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -191,6 +191,12 @@ const struct ethnl_request_ops ethnl_plca_cfg_request_ops = {
 
 	.set			= ethnl_set_plca,
 	.set_ntf_cmd		= ETHTOOL_MSG_PLCA_NTF,
+
+	.dump_start		= ethnl_dump_start_perphy,
+	.dump_one_dev		= ethnl_dump_one_dev_perphy,
+	.dump_done		= ethnl_dump_done_perphy,
+
+	.allow_pernetdev_dump	= true,
 };
 
 // PLCA get status message -------------------------------------------------- //
@@ -268,4 +274,10 @@ const struct ethnl_request_ops ethnl_plca_status_request_ops = {
 	.prepare_data		= plca_get_status_prepare_data,
 	.reply_size		= plca_get_status_reply_size,
 	.fill_reply		= plca_get_status_fill_reply,
+
+	.dump_start		= ethnl_dump_start_perphy,
+	.dump_one_dev		= ethnl_dump_one_dev_perphy,
+	.dump_done		= ethnl_dump_done_perphy,
+
+	.allow_pernetdev_dump	= true,
 };
-- 
2.48.1


