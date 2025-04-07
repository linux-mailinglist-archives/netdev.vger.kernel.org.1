Return-Path: <netdev+bounces-179632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989EFA7DE79
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77313A7B5B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FBA24A060;
	Mon,  7 Apr 2025 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HRd8o50Q"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59F23A9B6;
	Mon,  7 Apr 2025 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031122; cv=none; b=Lgb+SdU5mcy03kGVm2StWCP5fOs6AUFOW0zI2LGXBDplD7BRRUNRixSnwz54sRZ284/eZ+C4wjqzT3CVrrZnPWp6UPq47kVHOZaZG6wk0wiCsTzreH38Na20Qi1F5j2w8nfS2L9o4ezcT1p8XAq1h8PctoFwEUD1cWMb/t3bB1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031122; c=relaxed/simple;
	bh=EP1KymtgMgbZpZqAIGN1ppT0EOijNSsu9AkvWc5csVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DbooQTWfw/2+FCvCDN+hmRfabdFCUapyv5xZUV2+fGjXJ4Cv8bdRa1/g9lkUbT5+XM81LSaTEQ58Hrw7UVwjYDg7MuTUhyCRyhiTb0IZdTdmsBDIBl2tu0LRC3f15Wip0V3+gTK1wCUFnSjP6ntxSTFgP/xj3gLCD0fQkV/D6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HRd8o50Q; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96A7944310;
	Mon,  7 Apr 2025 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744031116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HnHmAe40fcEqMw5EeqY5E54FMr33D6Spd3JkgsCsMDM=;
	b=HRd8o50Qd6nt4OXCR0ac04aW4HbjdT3y5aIn0pLBFC9Kr+3kEkR6umb2H+AwlkAnmDNgtQ
	NrqqXHhKYSV2Lum9alkPFQRHs22TwKtkCiSHI2479Mp4C9VUkXcysPSrTN7XWnVW7S0Qez
	KmqEXBZEaON+AteOQQ2wUVfu6ofG/Nastjw7uJdZyagWymljeFpbI0mE+LTd2+zi1phyxk
	ZirjJAnOFYRqcpldCkciPa/l16OxXveH21c4rOoznpCENfjpF2oKZpuuZQszfOiEYZb9Jh
	9ADUrq8C49vmpTYlGBEz+sR0bTu8HvUgOrCnBkXGQul5q/TqdcEfx69V4rh33w==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Michal Kubecek <mkubecek@suse.cz>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net v2] net: ethtool: Don't call .cleanup_data when prepare_data fails
Date: Mon,  7 Apr 2025 15:05:10 +0200
Message-ID: <20250407130511.75621-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephedtheeufeeutdekudelfedvfefgieduveetveeuhffgffekkeehueffueehhfeunecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiiv
 ghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

There's a consistent pattern where the .cleanup_data() callback is
called when .prepare_data() fails, when it should really be called to
clean after a successful .prepare_data() as per the documentation.

Rewrite the error-handling paths to make sure we don't cleanup
un-prepared data.

Fixes: c781ff12a2f3 ("ethtool: Allow network drivers to dump arbitrary EEPROM data")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: - Fixed typo in commit log (Simon)
    - Changed the Fixes tag, as per Jakub's comment. Eeprom appears to
      be the first potentially problematic case, as we risk freeing
      twice the eeprom data. I couldn't test that with what I have
      locally though.
    - Aggregated Simon and Michal's reviews


 net/ethtool/netlink.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index a163d40c6431..977beeaaa2f9 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -500,7 +500,7 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 		netdev_unlock_ops(req_info->dev);
 	rtnl_unlock();
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_dev;
 	ret = ops->reply_size(req_info, reply_data);
 	if (ret < 0)
 		goto err_cleanup;
@@ -560,7 +560,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 	netdev_unlock_ops(dev);
 	rtnl_unlock();
 	if (ret < 0)
-		goto out;
+		goto out_cancel;
 	ret = ethnl_fill_reply_header(skb, dev, ctx->ops->hdr_attr);
 	if (ret < 0)
 		goto out;
@@ -569,6 +569,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 out:
 	if (ctx->ops->cleanup_data)
 		ctx->ops->cleanup_data(ctx->reply_data);
+out_cancel:
 	ctx->reply_data->dev = NULL;
 	if (ret < 0)
 		genlmsg_cancel(skb, ehdr);
@@ -793,7 +794,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 	ethnl_init_reply_data(reply_data, ops, dev);
 	ret = ops->prepare_data(req_info, reply_data, &info);
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_rep;
 	ret = ops->reply_size(req_info, reply_data);
 	if (ret < 0)
 		goto err_cleanup;
@@ -828,6 +829,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 err_cleanup:
 	if (ops->cleanup_data)
 		ops->cleanup_data(reply_data);
+err_rep:
 	kfree(reply_data);
 	kfree(req_info);
 	return;
-- 
2.49.0


