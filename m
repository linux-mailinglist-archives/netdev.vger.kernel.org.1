Return-Path: <netdev+bounces-65384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F4583A4A5
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD67C1C2233B
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F396A17BDA;
	Wed, 24 Jan 2024 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LCupJw2w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vKSFO5kU"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270317BAC
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086566; cv=none; b=dienZG5KwxPoNxI2diaPThXLCIWYFdagyL2Nixi7ohag3pxMnMtAN/xlJaUHnz/MID0r6vG1+kdfNGoY+tirOfzS0OEC/iAYzvJbpx1vL79AXoNOjW3MvMOIwLruv7F6iDG2e9u/omaO+LiQVC4n2514s5QeYbYfFLXo1ou63R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086566; c=relaxed/simple;
	bh=EpdHP0d35MbmVpnaWu4SzTREv63NRcNTmug6R29HWX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H82YOJGBJtvJsOgbclxXzy1dQEsnLYNp5t3oc8Mi3+SfTyPjqHjPLP5AYhp2MS5pGLLUP80pCpsW2V4HiBN232A10ZyYay6QpbGJePuuDbuX4/aqLqegcafftBXgK0gIFVbcL+rBohn0BOoWwoB2452/4Fovp0bBq8JP3gEXTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LCupJw2w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vKSFO5kU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706086562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpWQWJpYkDehFFRYCFWE0+2P1/XzZiBiXbECZUVKFfQ=;
	b=LCupJw2wd2gwM0FwNCEw8xXbBGMOielC/9ZpbF384ybJCD0+NqeQ/s9llYPJKm9bCoNLq+
	WxQCdx4q7ElipFh6WilDeo+bleSwVxK5zwp4IsimIldyWlPAJglbgs/2HPOQ4EeOYIBwMa
	5QO0vmLcU4twMVUovnTE6Cfch3+xIpE48rY9GWCkmLlq8K19unO4NWYoovp9OsK+ex5p2q
	KoS9pIfl2SjgmXk1dHMyE9kD5YuIiL0c07Y9gsifMjXGhq6Z/SM1nhPC7TzPG09KP8yAon
	RkXYAIlLA7Tx0RmxK3qsyms1TRR5DMEmKfG5YqzK9Z/Yh/6r1TDOncUmFd8Y9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706086562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpWQWJpYkDehFFRYCFWE0+2P1/XzZiBiXbECZUVKFfQ=;
	b=vKSFO5kUm6ModsdQyN1FFAPp/jKtL2kasnvIC722qkxgnNRvODuxCXHZBbYw97Zs7H5Jfu
	w/fNVaragIb05ABA==
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH v2 iwl-next 1/3] igc: Use reverse xmas tree
Date: Wed, 24 Jan 2024 09:55:30 +0100
Message-Id: <20240124085532.58841-2-kurt@linutronix.de>
In-Reply-To: <20240124085532.58841-1-kurt@linutronix.de>
References: <20240124085532.58841-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use reverse xmas tree coding style convention in igc_add_flex_filter().

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ba8d3fe186ae..4b3faa9a667f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3577,9 +3577,9 @@ static bool igc_flex_filter_in_use(struct igc_adapter *adapter)
 static int igc_add_flex_filter(struct igc_adapter *adapter,
 			       struct igc_nfc_rule *rule)
 {
-	struct igc_flex_filter flex = { };
 	struct igc_nfc_filter *filter = &rule->filter;
 	unsigned int eth_offset, user_offset;
+	struct igc_flex_filter flex = { };
 	int ret, index;
 	bool vlan;
 
-- 
2.39.2


