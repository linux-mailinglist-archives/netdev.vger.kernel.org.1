Return-Path: <netdev+bounces-161357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36065A20D29
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47ACD1888D21
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB3C1D63C3;
	Tue, 28 Jan 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ezYjmSjU"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A61B2EF2;
	Tue, 28 Jan 2025 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078556; cv=none; b=ouCqB+LWJq4bw14+lU+lnC1DGezRu6b7hx46SLPMDpQs02ianxs5we8egawNnR9lNg5bLM7Om3foJbuAFQm7I+ZsXQaHKhTkotKTglX2MonoQCigcaVNLDFFqx8xteuELwpn5c2n2DSrqEOABLokYzVznhegPADaN5MucYusjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078556; c=relaxed/simple;
	bh=ET95UK2L7raus7pbcXHS9o+2t+fG8EpyB0NvOLP2q84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ddZYtLfEN0TGh2DhBS/VjAHJ6yEDuN3yP1r2HYD4GgcrsZOO/jm1L+ZXyUhQm7t0yDDpD2YI5uoaxqIZYzF7F3Ol4U8cfj3sJGCEXaTsUXpKcM//bbAsbCNohCJ+zW8WF2exzjYl4qZP9bhnYI/i/ZoXvQRYpENR0IZtra5IJJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ezYjmSjU; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 150F2442EF;
	Tue, 28 Jan 2025 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738078552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rTxlV9K0ljWIiSCdZkHAjt43N+EaEEiWZA/fGnFRXk=;
	b=ezYjmSjUPHwxl8aMSM45Frhe8U/29RrynEHxawCjw8dFFy9MV9cAogIuZpe9wmTI06yHgZ
	K1xbclYmQSEqrbtHNVcg3fL/1N1gL1FIXk5b6fmjiHOB0SfiiH4HTgsQXsgfmVFuBfJbgU
	irOjRuOfPhRS/8H8b6RQCp/L/ux7yh+4m8TO/WdNQUmxffoyKMlOumAWS7VpndYqvWDOoN
	LNXfoH3l3pquYvxBCqGreBOFD85q4g0jKGo0vDU6oRzlQ54GKX4vL44oaGkXp2vPZHPDtc
	AJqyK64FvORGZef7rrXiJDhA1ceA6mU36Hk4VsQjlQY59bjHMFEH9vrhjTsAAg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 28 Jan 2025 16:35:47 +0100
Subject: [PATCH net 2/3] net: ethtool: tsconfig: Fix ts filters and types
 enums size check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-fix_tsconfig-v1-2-87adcdc4e394@bootlin.com>
References: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
In-Reply-To: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

Fix the size check for the hwtstamp_tx_types and hwtstamp_rx_filters
enumerations. Align this check with the approach used in tsinfo for
consistency and correctness.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
---
 net/ethtool/tsconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index 9188e088fb2f..2dc3a3b76615 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -294,8 +294,8 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 	struct nlattr **tb = info->attrs;
 	int ret;
 
-	BUILD_BUG_ON(__HWTSTAMP_TX_CNT >= 32);
-	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT >= 32);
+	BUILD_BUG_ON(__HWTSTAMP_TX_CNT > 32);
+	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT > 32);
 
 	if (!netif_device_present(dev))
 		return -ENODEV;

-- 
2.34.1


