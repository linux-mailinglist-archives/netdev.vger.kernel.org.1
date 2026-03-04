Return-Path: <netdev+bounces-263581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBjcMtKzp2k6jQAAu9opvQ
	(envelope-from <netdev+bounces-263581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 05:23:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2AF1FAAEC
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 05:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 234AC30DE1A8
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 04:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE24737F747;
	Wed,  4 Mar 2026 04:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ridhp1fT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5537F744
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 04:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772598180; cv=none; b=oI7oSCLVr3BE5gs9P2U1Y2KOE3F5lQs9jeMIi/rzJ5dvVPap1JTL8MSj0oXtWG+neugPMmcEROZZSyFj5vaCJWY1K9qQ/MtLqZVxbX9QCsFutnP3yMetPvGmDjtCyswbx0QWdf8BGEd0z7jrDn0zArb5crJEDBOjtCIIZlyklOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772598180; c=relaxed/simple;
	bh=nRy2FzFs/r4kUMMPr3kq4VSikbpVpQd1Td056bAX51M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQTxGak4sL1cEhfeDPLfgw1r6ULFGhn4kAA89R0ObdljjW0r9PQNUjri6ol/GKQMJowdgQTyRweAsF5bSgqmECXvsgAjuld7mOF1bImeyw1MsEaWItO/gLRC1euzjgoJZRtOlOkiFxo0qzvGGiQ6o4lBNoNwbvcxEIAlQEDvhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ridhp1fT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-359832fc558so2661001a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 20:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772598179; x=1773202979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+srkKSczGvbAl5StF/1HuLhYt6x9ZKLfgwAQ4JLLYDM=;
        b=Ridhp1fTgV90lfrRo+ns1bObDCqtPhzQToSTbj48Ks+7yGJHE2HIZ1Z1+DPwzp5320
         b9Mefx6LvJxanobKlC5Wo5NWm5MnOuTjv263f0B+JXtpZs94Tn673FbHNR62MKFBV3fy
         qemGSIqgVaCT0SZ1PbF9HRWp30nLJ3NSc+rl2ErTMS2ccxI0kaGSZ5N3fNIoz97VDAxL
         nNTUtPhdAGA8Mt7K0jHuz8aaHgVhWWlQ5Kg0GT6ncsbH2lke87xpmt8gIMs/yCtvoWVD
         Fe6OxMtDNhED1k1JGOnyNK58P88QEny2l8iijl7QI5zKpZaBJM9Wqms6XZN3eDM44KLo
         xi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772598179; x=1773202979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+srkKSczGvbAl5StF/1HuLhYt6x9ZKLfgwAQ4JLLYDM=;
        b=fP6Z/+ae+x+nZpTJpxWgInjFyLEbEGipbXSrFkMLphxWRDICxvzMMhsUEVsb3Tz8JI
         4pKxUxRvsXFqsneBzVHcRlYrmhyvjA238Zf0b2ZPsimX6bNOiXAp9DEk58QiDGTVh42w
         hiyhlujignT1GDkuNvt3mEXcsfZwh49yLouKJYD++cZ5x7gBC8h8YOc/X0QSBWcCtYyo
         IAFhVbYwuciEG+GbOJ8vWqgkFipyJI5A6OGY+XAtf7XiWi0TEdPx/+q1mMTUSUljDGlq
         o6FiCHYC2smVQiRa7i8vJDcW2jczKHWnUoO2k+fduySNcI2VTi6fPt42E/P99NrBjCTi
         tpUQ==
X-Gm-Message-State: AOJu0Yz1mjiCWjNeU9GEWEhrnPKtERjYe8BKehYCZxz678uTxWFIR4It
	QhUtcdWiG+rkqwHShHCnv86z++QPvX2goP3R5b2jdYMlJ7GssQWrBH7CdXmzr3Gvv2g=
X-Gm-Gg: ATEYQzy0gekVui7iQiOzzJqMu8EgXz2pU86XeIWUCaH41Ru6DPJk2s0oqw+wauYx7cs
	fJQDUbWFtCI+BXTZ5TWBDuCcznDEUZ84DuGco2NGnAS26YQ7MyTBAzs17+WiP+iQzUxFnHABkYC
	FLTI9HAgPAFOOFsZcso2oOeu94CwbKDi+YG+uPnjczQAeVteYjH47pg/OgjXx10radofd/QGun0
	lfO6ROCBM8+2XXPUhdGeA//eRtzAVixPryji005ie2PiXEeZdalA79SPuwRWYbwuyKnA7SaqYxC
	Hz3QeDx+RK4g5t9Ond2CK7JiTd+6yiiJXegUqthkIjlMOckZqgg0T/VIB34lHS3dXmIdNqYeHbx
	a0Sxi8e69O5JRMA2OON9I3fNuSUxtjIfRLD5z4P4tSl87tvb3dR4/xMWEmXhcf0ODxaFhKImUPe
	mhSt4JyCOv4j/7HXz1j623JVHP+Cv9Yk58DBh9MXwZ9TqlbSe2jCWy2g==
X-Received: by 2002:a17:902:cec8:b0:2ae:4d97:3012 with SMTP id d9443c01a7336-2ae6ab32e22mr8671725ad.49.1772598178698;
        Tue, 03 Mar 2026 20:22:58 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3e4e34e6sm116143305ad.30.2026.03.03.20.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 20:22:58 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: xgbe: use device_get_mac_addr
Date: Tue,  3 Mar 2026 20:22:40 -0800
Message-ID: <20260304042240.7964-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C2AF1FAAEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263581-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

device_get_mac_addr is basically device_property_read_u8_array with an
is_valid_ether_addr call. Allows just checking for ret.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
index 47d53e59ccf6..0d1b2e4ca8d3 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
@@ -252,10 +252,8 @@ static int xgbe_platform_probe(struct platform_device *pdev)
 		dev_dbg(dev, "sir1_regs  = %p\n", pdata->sir1_regs);
 
 	/* Retrieve the MAC address */
-	ret = device_property_read_u8_array(dev, XGBE_MAC_ADDR_PROPERTY,
-					    pdata->mac_addr,
-					    sizeof(pdata->mac_addr));
-	if (ret || !is_valid_ether_addr(pdata->mac_addr)) {
+	ret = device_get_mac_address(dev, pdata->mac_addr);
+	if (ret) {
 		dev_err(dev, "invalid %s property\n", XGBE_MAC_ADDR_PROPERTY);
 		if (!ret)
 			ret = -EINVAL;
-- 
2.53.0


