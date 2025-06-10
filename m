Return-Path: <netdev+bounces-196083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F163AD3776
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11FA57AD61D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC6E29C356;
	Tue, 10 Jun 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NpEVBoC2"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AD029B8F8;
	Tue, 10 Jun 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559814; cv=none; b=DEahx9q0O5CbOoIzzggWTWhtsCsx+xzmLw0yzWfkZOahgRDkBrE9gId1HuWYNGLk//a0EYWxZ7W0HmCEU2d2LK1xbPezxNWxSTn1+ilpBGBj+ayZ2zG2gB50MA/SCS/D2ltoHzEZpk2jwFmwsKQ91gAdwR8EuEjIV2meeoVKhNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559814; c=relaxed/simple;
	bh=DmCeH0Zap4bFK7OS57K1yJt8pMYCLk6oGTpR2/zEPCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=YLIrgLesVDcBuan6gAwu/QS92oKdxx1DGk4abnT3EoZcuCIYs/ZlVwmA2cpUb+eG13BcJGL2LwH3Jj+0/B7vs1yI/T7OoQCXCW/Pgnmv4vFjR0EsYU6YfniG+IeTqgOTFR85WTnxwsNKAXW/UBCUWi8+akOyJoVd0On9oLbtRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NpEVBoC2; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77BC242E80;
	Tue, 10 Jun 2025 12:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749559805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28BDecRRllzmqXnQ2gNlOozbkXizXU8KtH8nt6Poe5I=;
	b=NpEVBoC2S12Anf97gkAq8pJEvano4/LLJa4YZ/WrwKCLIGa/wOa4Y+2B4+vU5Ob4K5lK0U
	QgZhNvOXbRod7RxYXHQtwQ/K7NG4jRcRbq7Js6liT++JGrriVjnX3t8EyagQb5Rg3uHOw6
	7Jchg51YLXgjfRC+0Gr1Rzx5d4oVyCUB+DKEpek3nbVaXe2wzrvvxrzGh7BJNuwSsuQy4r
	hzyTbQtjmOXTLB02S/58bDWmJf6WvQ6IAgvtMtxS2TBSxiggGK6rq1WDzOLf9KUObMPCMK
	RG+wlMFUeVDPsW6+e+EpkyVmS0KCo+Tx32ip0aGMjevPg6joAHapqPqwWIrywA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 10 Jun 2025 14:50:02 +0200
Subject: [PATCH ethtool 2/2] tsinfo: Add support for PTP hardware source
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-feature_phc_source-v1-2-cbd1adef12aa@bootlin.com>
References: <20250610-feature_phc_source-v1-0-cbd1adef12aa@bootlin.com>
In-Reply-To: <20250610-feature_phc_source-v1-0-cbd1adef12aa@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kernelxing@tencent.com>, Russell King <linux@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeefteeifeefheevheefhffgveduffeltdeivdethedtieegveehuefgffduheektdenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtiidprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtp
 hhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhk
X-GND-Sasl: kory.maincent@bootlin.com

Add description of the PTP hardware source to indicate whether the
timestamp comes from a PHY or a MAC.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 netlink/tsinfo.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/netlink/tsinfo.c b/netlink/tsinfo.c
index 187c3ad..fd528e5 100644
--- a/netlink/tsinfo.c
+++ b/netlink/tsinfo.c
@@ -52,6 +52,37 @@ int tsinfo_show_hwprov(const struct nlattr *nest)
 	return 0;
 }
 
+const char *tsinfo_source_names(u32 val)
+{
+	switch (val) {
+	case HWTSTAMP_SOURCE_NETDEV:
+		return "MAC";
+	case HWTSTAMP_SOURCE_PHYLIB:
+		return "PHY";
+	default:
+		return "Unknown";
+	}
+}
+
+int tsinfo_show_source(const struct nlattr **tb)
+{
+	u32 val;
+
+	val = mnl_attr_get_u32(tb[ETHTOOL_A_TSINFO_HWTSTAMP_SOURCE]);
+	print_string(PRINT_ANY, "hwtstamp-source:",
+		     "Hardware timestamp source: %s\n",
+		     tsinfo_source_names(val));
+
+	if (!tb[ETHTOOL_A_TSINFO_HWTSTAMP_PHYINDEX])
+		return 0;
+
+	val = mnl_attr_get_u32(tb[ETHTOOL_A_TSINFO_HWTSTAMP_PHYINDEX]);
+	print_uint(PRINT_ANY, "hwtstamp-source-phyindex:",
+		   "Hardware timestamp source PHY index: %d\n", val);
+
+	return 0;
+}
+
 static int tsinfo_show_stats(const struct nlattr *nest)
 {
 	const struct nlattr *tb[ETHTOOL_A_TS_STAT_MAX + 1] = {};
@@ -185,6 +216,9 @@ int tsinfo_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		printf("none\n");
 	}
 
+	if (tb[ETHTOOL_A_TSINFO_HWTSTAMP_SOURCE])
+		tsinfo_show_source(tb);
+
 	ret = tsinfo_dump_list(nlctx, tb[ETHTOOL_A_TSINFO_TX_TYPES],
 			       "Hardware Transmit Timestamp Modes", " none",
 			       ETH_SS_TS_TX_TYPES);

-- 
2.43.0


