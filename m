Return-Path: <netdev+bounces-193920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7EBAC6484
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5A41883A58
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 08:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B59D2698AC;
	Wed, 28 May 2025 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fmb4isi5"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC632690E7;
	Wed, 28 May 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748421010; cv=none; b=K3CvoxcBs/kY1ZUCj5g8//fGzhb6QKOqf1EGZFSDhXQSXFyICmAWbNf7e70wp9DYb56rhsdtMO4B1OqghDEYLbfnIm+u5s/1SEnHSyy2HsQqp4+Ckc8hK651RK5Bi9qstM29EWA2p9yKNfm8VRxnILjyIR/kdHVhJdDxJv5Du/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748421010; c=relaxed/simple;
	bh=6x3OGJZ4yRjMFAuw7F0Oqu6NwPdKGCaJCRIig+SHvos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ddkaTqXEmaeqHyGLWgE5jsR6LXYur6TbonIyFlL0kaR2/WXq2oWI5/9QkMq+DefLkjj3RPhXVkFKT8UebMNF9IQYdMMr+vyAoc6ZnSpb1ry7yF4jfzRyvbxipQ/gtYgE70cSzAKrZzin+NGi/yE9NZiKUWte8x9r44Atz1PeXJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fmb4isi5; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CC0243181;
	Wed, 28 May 2025 08:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748421001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shTq+LjK5kytOL+ZAGqX+p9U+O+5+OqX6NmjbEioOnk=;
	b=Fmb4isi5ctT5G4E+PxA6NLD0Xpn3HwwowHzMR32KwsKIs8h/3/Go/bVkp1nRAB4j3AGowP
	Sd6nwUDcOGwYPI1XHQIvGONvbWBBjM5cX397cAKYTOcH5JrfnJLEI4lsrAT26qKTUrFytp
	Ti4iipv9XjTMmffc//RSLPQF+DKMbrrTXcO9dYxa4R8ZQlGY4JEYiOwtRwui8NyqzjTjIc
	jZmpaACJWnfoIMPt43Hzp7buEHV1CgLRSFO7R87xnJbYq7+qBstPmy/5Ya7GW2fyPSWw1l
	au2OcxFZOjlE4tQCv/TZBT95gVBILNLC5dfVkO10nFXa3ZHvDhDQXnNl0tO8Hw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 28 May 2025 10:29:51 +0200
Subject: [PATCH v3 2/2] net: stmmac: make sure that ptp_rate is not 0
 before configuring EST
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250528-stmmac_tstamp_div-v3-2-b525ecdfd84c@bootlin.com>
References: <20250528-stmmac_tstamp_div-v3-0-b525ecdfd84c@bootlin.com>
In-Reply-To: <20250528-stmmac_tstamp_div-v3-0-b525ecdfd84c@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Phil Reid <preid@electromag.com.au>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jose Abreu <Jose.Abreu@synopsys.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdejkeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevgefhteffuefhheekkeelffffvdeugffgveejffdtvdffudehtedtieevteetnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddungdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgtohhquhgvlhhin
 hdrshhtmhefvdesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhsrdhsthdrtghomhdprhgtphhtthhopehlihhnuhigqdhsthhmfedvsehsthdqmhguqdhmrghilhhmrghnrdhsthhorhhmrhgvphhlhidrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
X-GND-Sasl: alexis.lothore@bootlin.com

If the ptp_rate recorded earlier in the driver happens to be 0, this
bogus value will propagate up to EST configuration, where it will
trigger a division by 0.

Prevent this division by 0 by adding the corresponding check and error
code.

Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Fixes: 8572aec3d0dc ("net: stmmac: Add basic EST support for XGMAC")
---
Changes in v3:
- new patch
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index c9693f77e1f61fe5c92f95f5e544371445626c4d..ac6f2e3a3fcd2f9ae21913845282ff015cd2f7ec 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -32,6 +32,11 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	int i, ret = 0;
 	u32 ctrl;
 
+	if (!ptp_rate) {
+		netdev_warn(priv->dev, "Invalid PTP rate");
+		return -EINVAL;
+	}
+
 	ret |= est_write(est_addr, EST_BTR_LOW, cfg->btr[0], false);
 	ret |= est_write(est_addr, EST_BTR_HIGH, cfg->btr[1], false);
 	ret |= est_write(est_addr, EST_TER, cfg->ter, false);

-- 
2.49.0


