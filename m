Return-Path: <netdev+bounces-172816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91532A56352
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D23B0F53
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 09:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90361E1E10;
	Fri,  7 Mar 2025 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DTwqFwJV"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC4A1E1DFA;
	Fri,  7 Mar 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338785; cv=none; b=g+NDBYPoCq1xkg9rntPHdBttfsbxpruBHBuhg3oHme+Q16rMRgBF68aNvLusR7VidiscpABbU0dbNWA33M2wTuLkCuvHiiM+u8C92676NyPsy13/8DKeD40ShUU4iXBEu/v1Cv5P297HiZkm+SKh7e+4QUImmAJN/K8iGMmH9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338785; c=relaxed/simple;
	bh=JqkWFYEADorTubWP1yeQ1voh1B4gQ71VaWSI2tAoP7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uR/vfzupanYH8NVGP9D5Gtp8pLw3MD8aAHxePaIRKIbN+9959RhkB6WDAqk4tnWKjl6JSUqjOzvwpDZAC0smzpbx5VPCO9mxch/XdklV2cYChmL+Vu/9rXN02P+izC5h//125CKYI2ti2uECf6+Il/8bXPeeb7xKica7LCLWE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DTwqFwJV; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12897441A1;
	Fri,  7 Mar 2025 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741338781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r2nUahvPJphx+fjhhy8XOftJr/a/W/nh42oanoB00PY=;
	b=DTwqFwJV6pe2MykMc/kVHrNS8dRyg/4v/9twueriSuUCZOPGIW9oC1Yzs/jljq/Vu8JLAj
	l3onUBcB5Mb8gWcubzyI9crJ1hXOwedUBDBV9vzWB4IkDpP43KDDizEaIZgnWeQqjSceKp
	ySm3f/oLJADJ04p4pReV4f0FMdxmNGoAZFQ+8b+iqCR8xQeA7GoVHUYa65c7+MLaXpt0YQ
	1Bs7zCbI7oGh41OpxnJtpqWR3AfVRNy4W5igen6HMASllarRMT54+lIorb+7tbbZu2/XLn
	x2mjc+BxdzqfJT8iy7hIoS+yYm/muTEhOaAMtH76HaVKHVp8dZXfq5SIGK+4ZA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] net: ethtool: tsinfo: Fix dump command
Date: Fri,  7 Mar 2025 10:12:55 +0100
Message-Id: <20250307091255.463559-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgedugedvkeelhfehfeeuieeigeetgeetuedugeetuddvveffieekgfejkefgudeknecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmeektdhfheemgegulegvmeejugehsgemjeeggeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkeehkeejmeejuddttdemkedtfhehmeegugelvgemjeguhegsmeejgeegfedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtrddrpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhgrughimhdrfhgvughorhgvnhhkoheslhhinhhugidruggvvhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

Fix missing initialization of ts_info->phc_index in the dump command,
which could cause a netdev interface to incorrectly display a PTP provider
at index 0 instead of "none".
Fix it by initializing the phc_index to -1.

In the same time, restore missing initialization of ts_info.cmd for the
IOCTL case, as it was before the transition from ethnl_default_dumpit to
custom ethnl_tsinfo_dumpit.

Also, remove unnecessary zeroing of ts_info, as it is embedded within
reply_data, which is fully zeroed two lines earlier.

Fixes: b9e3f7dc9ed95 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Remove useless zeroed of ts_info.
---
 net/ethtool/tsinfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 691be6c445b38..ad3866c5a902b 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -290,7 +290,8 @@ static void *ethnl_tsinfo_prepare_dump(struct sk_buff *skb,
 	reply_data = ctx->reply_data;
 	memset(reply_data, 0, sizeof(*reply_data));
 	reply_data->base.dev = dev;
-	memset(&reply_data->ts_info, 0, sizeof(reply_data->ts_info));
+	reply_data->ts_info.cmd = ETHTOOL_GET_TS_INFO;
+	reply_data->ts_info.phc_index = -1;
 
 	return ehdr;
 }
-- 
2.34.1


