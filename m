Return-Path: <netdev+bounces-200514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 730BDAE5C91
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 08:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C81D1B615D2
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 06:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED5424468A;
	Tue, 24 Jun 2025 06:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L4LAEAnI"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E319CCEC
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750745213; cv=none; b=FHCptMcQMGzMVHNMF9owpXU7YwAqGXEA6MPl7xlnI63LwTxLwHqFrjc9Om2OIbKW0ER+bTzuiRfFNXAEghUa3foJUfvGLMGZFRSQGyTnyhEWAZWm1YOdD1widZEttAr9irMIDgfHzY9kDo6CZDevDE9XXHxIoV608Z/9rIaecEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750745213; c=relaxed/simple;
	bh=DeR0qGLoFdq1dDzO2MbjU8ApQIrU94VuGea5g5+nRL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZ3whlA4LTiaVEglL7RgaXk9DA6qz0ajC/NL6qp3EWVV1zaKrZVtfdgja9FJIY7iashT+/HKuCNvN4mmfBxSSLlGK09rCiYwSDigRrEEmIttzviH+A7OVFssERBS7H4zBScmc2RdBwaOyjCWukiUrOp46/T0LSZCHz2WRkpF7tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L4LAEAnI; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BBF9A438EC;
	Tue, 24 Jun 2025 06:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750745208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SEM5J1bDYOyuFXQfOzwQO+SBoFb7zVcOhx6z9rtvnBk=;
	b=L4LAEAnIhC0ScmAUF1CSZtsRKtrzS8TSSfG6boE+ln6ITnOdqKDrYrfFqo8Gp4TmnKM83B
	/VjqM86gl7n3EU6j4kbwFzIDRiFwB5enUpa3C9s/0DGb+/Oanw+cZCEWy8/SUskBYF1kJa
	GIR0C+y+Byo/4ltB/fHtB15/hs0rPqaI3mM45MVqsOadcVjdFMn81KNEiQLc99iICcPRS7
	RFpcttBvr46bmOv1tvHm/UFx8JYpK1r/fETLzL6JaOv4Q0kX7sMpEEfj8agr7s9T1ASCKQ
	GLbO+70xpjpNwcmPQ90MfJzcDM20/dxEtkpFNtiO1vhRG/9+603Dvuk692quiA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: [PATCH ethtool-next] monitor: Add notification handling for PLCA configuration
Date: Tue, 24 Jun 2025 08:06:41 +0200
Message-ID: <20250624060642.2926925-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduledugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehtdehueefuedtkeduleefvdefgfeiudevteevuefhgfffkeekheeuffeuhefhueenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepmhhkuhgsvggtvghksehsuhhsvgdrtgiipdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdro
 hhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhivghrghhiohhrghhiohdrsggvrhhuthhosehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Physical Layer Collision Avoindance (PLCA) has configuration and status
netlink commands (PLCA_GET/SET_CFG and PLCA_GET_STATUS).

The PLCA_xxx_CFG commands generate notifications, allow monitoring them.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 netlink/monitor.c | 9 +++++++++
 netlink/netlink.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/netlink/monitor.c b/netlink/monitor.c
index ace9b25..c511389 100644
--- a/netlink/monitor.c
+++ b/netlink/monitor.c
@@ -75,6 +75,10 @@ static struct {
 		.cmd	= ETHTOOL_MSG_MODULE_NTF,
 		.cb	= module_reply_cb,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_PLCA_NTF,
+		.cb	= plca_get_cfg_reply_cb,
+	},
 };
 
 static void clear_filter(struct nl_context *nlctx)
@@ -186,6 +190,11 @@ static struct monitor_option monitor_opts[] = {
 		.pattern	= "--show-module|--set-module",
 		.cmd		= ETHTOOL_MSG_MODULE_NTF,
 	},
+	{
+		.pattern	= "--get-plca-cfg|--set-plca-cfg",
+		.cmd		= ETHTOOL_MSG_PLCA_NTF,
+	},
+
 };
 
 static bool pattern_match(const char *s, const char *pattern)
diff --git a/netlink/netlink.h b/netlink/netlink.h
index ad2a787..290592b 100644
--- a/netlink/netlink.h
+++ b/netlink/netlink.h
@@ -92,6 +92,7 @@ int cable_test_tdr_reply_cb(const struct nlmsghdr *nlhdr, void *data);
 int cable_test_tdr_ntf_cb(const struct nlmsghdr *nlhdr, void *data);
 int fec_reply_cb(const struct nlmsghdr *nlhdr, void *data);
 int module_reply_cb(const struct nlmsghdr *nlhdr, void *data);
+int plca_get_cfg_reply_cb(const struct nlmsghdr *nlhdr, void *data);
 
 /* dump helpers */
 
-- 
2.49.0


