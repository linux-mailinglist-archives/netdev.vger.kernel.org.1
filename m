Return-Path: <netdev+bounces-172051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCDDA5014C
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E88B3AD5DC
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01DE24A06B;
	Wed,  5 Mar 2025 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T/3BuNe3"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9624889C;
	Wed,  5 Mar 2025 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183460; cv=none; b=nUV+2R0Zw0qX8W7xVVeqIX2YTwfoSOwUu81BUCpVQWJ3y4Uj2wa0FQ0RXw41pSZMqRdz8bSbCjVtou5fPef6Cb0jghwpgNGIKAcafMn9h0qUOMUwI3XVT15ZQ7hkRDP4AvTVAFcf359OYChHGO3M0zgQszr27KX0JvJ5qxuCN+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183460; c=relaxed/simple;
	bh=3vEK90u5yUilFjfu9msqGo89fE4x6gZyF1UTb9v8fVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pg+UWQqlsoJq3be2Ng5tUacphe6uSQmhdq02V99xXOvJt8ll0DcMFZdYNTZxP+rOz5AqE4grc1CsIHDca+grLrIUkolfnFJ0lEMH6AowpLRGY+jF8KmtYnV7I8xO2E3ZF5/rGPZswWNK9JTviGEdLFxZUo6Yg7lZyV3SdktVeAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T/3BuNe3; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2C22442DD;
	Wed,  5 Mar 2025 14:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741183455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G1CdmG3QbGEUiwGjNNacH2rJi6jSe8rrnhlrR1kFHds=;
	b=T/3BuNe3Ae0+SSYulj6cTe1Ijv9VaB4HvtB5e/jGZzdImJ8u6lmS9Jqo6497a82ObEQXlH
	lSfc92qglGAR8BUoQc0km9Ky5+juGPsJihdkcx+n+j0uzf2pkLIOTwpaF8r1qb0NqeUKNy
	txC4eZaNYo+N/eOF90agkSiOqPotPdHV6pj3EIDofWYIKAQJdCkDD7UtIRJz9m5J/lRVO4
	kICjy3koPVuwOM61lKVrm6Q13DNkE2+jkG8WkOPhxdAzEprOHv9ZJgwNqgXxlWjE7eDbQS
	1XzuwWsJCbwTNanmMmzeEhIySEZ+FaSWHFlJSb5CyJbspYTE/lMz3uHJ+dmRfg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] net: ethtool: tsinfo: Fix dump command
Date: Wed,  5 Mar 2025 15:03:52 +0100
Message-Id: <20250305140352.1624543-1-kory.maincent@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgedugedvkeelhfehfeeuieeigeetgeetuedugeetuddvveffieekgfejkefgudeknecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtrddrpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmr
 ghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

Fix missing initialization of ts_info->phc_index in the dump command,
which could cause a netdev interface to incorrectly display a PTP provider
at index 0 instead of "none".
Fix it by initializing the phc_index to -1.

In the same time, restore missing initialization of ts_info.cmd for the
IOCTL case, as it was before the transition from ethnl_default_dumpit to
custom ethnl_tsinfo_dumpit.

Fixes: b9e3f7dc9ed95 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 net/ethtool/tsinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 691be6c445b38..9edc5dc30de88 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -291,6 +291,8 @@ static void *ethnl_tsinfo_prepare_dump(struct sk_buff *skb,
 	memset(reply_data, 0, sizeof(*reply_data));
 	reply_data->base.dev = dev;
 	memset(&reply_data->ts_info, 0, sizeof(reply_data->ts_info));
+	reply_data->ts_info.cmd = ETHTOOL_GET_TS_INFO;
+	reply_data->ts_info.phc_index = -1;
 
 	return ehdr;
 }
-- 
2.34.1


