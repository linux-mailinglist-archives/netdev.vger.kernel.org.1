Return-Path: <netdev+bounces-293683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFVnLhlmHWrpaAkAu9opvQ
	(envelope-from <netdev+bounces-293683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:59:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2271261E02E
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A17D3003311
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 10:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B673947B0;
	Mon,  1 Jun 2026 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDbS037b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40930390C8B
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311234; cv=none; b=FqRwhpofT/FKgdtpa+sBdutCJ2YejKyGCTMVeNZ3gZ2ekmRzCW8XoDiybRDgN/hA8xRdwLtbSmev81pGs4SsxSAyd6MglgFA0eo/4WNKLcCsiqf18LylpnRH4ygdH7vvY6VmPafJ/NxBDWzMBvUoCUizmOxHSz08FsZgsvgYAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311234; c=relaxed/simple;
	bh=qMJ9GDx/LcLFtFm48POgp/hzCEGEIelLj9gHGm5a49A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pis0VjtDv/0h/0n3QHK/+9Ays/7s86emETm/LK2DLDxtZ8gW3ACoskR3nOPa1o8ZdyzEjJeOb1C6xt8+XrQeY5v33P9I5t4zQp0vLQvvkoFuD6OEYYlJ000eooTo9HMfgas/4CO/WwFXIyhxNN/5OhpQNsL00EE7qFrjwOJkltM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDbS037b; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490a765f47aso10214995e9.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 03:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780311232; x=1780916032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gH3EgIUi99kVADWBhwokWNF0lPw5gXQdjRCExyBDYMQ=;
        b=GDbS037bT0YxkFe9Zrpy7ENrMf4tib0R4pm5Hut9f7DsN5RWo0p8U7sG1rCUSyaAGI
         954p+sFkz/wWYZtxC5UHuL2DUPka2eyAex6piudREAhZrVgYpK+bfWJTHuYcxteWrHrO
         MlHjZpfSCg7Ev9GknsT2KUTWfsIrvMT926FZJm8TjaQAsPDS3hJ7rkv6vmxCCWq+ttCg
         d5Ms4S/qOpol+19ta1V8tKsjyKCCa5IMH7QTL+5+bTlsWtMJCJUY23cH4/DsSO2p4Tsi
         NXlOpeDXLMEkNHqB+PYI2AsjyfIE9KZ2m/N6Exks1mUu17Tndvt6kAQ6+6Jwjal34wNG
         poLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780311232; x=1780916032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gH3EgIUi99kVADWBhwokWNF0lPw5gXQdjRCExyBDYMQ=;
        b=UYHAsOdu9DTUgcI0yUcpqdPOLEbzghxubd31dXO9gvQyP3dvD5Mm8Y8Y4Yuf1ki8og
         iga18LrxmjsabGP+S2DFzzDMiDYLjCzIqVV+pQq87fEVZhwMtl/VwCaDIte0TZTX/1C9
         IFpzbnKe08xSEonQ2MKpYluS1FBo3bhEnhVYPAKAhBLgFMxjfCoKnzRjGHMyfEA8hNUj
         rqxa25ev5sdOkDdxcGmvqWNGShaIPO3AR7VGn2yy4LR80O/pYGIzkvlXbnVz4rgmHtno
         SSccKkWtPcC0kNojtyDsRuBRTJUzgcBWyHHAkjFR5Sjz6j32tsnhRbgDSwAjw9BmcbEM
         aDAg==
X-Forwarded-Encrypted: i=1; AFNElJ+dZRujkRbuOX+ZQTvlQ6NXI4FFiPWZGRubIWfARsdhuddWzeyyE4PZbJ3Etb6h+BOo21sOkQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6qJL54zj05iZAqDW7Rbnp0Mt1OL8AMrb5BKL8DCpiztBkFAa
	0UrUNLos1mBvR4d5eKyMPXpBrjmVi8i6WlkLeP5oVYka59x+ZRA5uURd
X-Gm-Gg: Acq92OFT2UDPlUmEwMdHSVralhUhGlGOjEssgzaUw8tGSKZMhPIgen/vN08PSrZoJ96
	LTRayaTD16BLNBo90Py0LUK+kGq6ri8yRT6M0iPsE+1NSxJD2Tv3AMJT8jrYd9/m7qlAT9KlL2Y
	rmURXPr7qMRVn/u32UJTEUX1UKsmHJ0xLRcTpd2OSM523Wc5hfAYBsqguX3kR4v0fFmx8zTd2uz
	WYqWxpXpSg95t4zUuRVDd/WNfSK2zeLAKmbAZwO8c2Y4BeK7ZeZ8mhMXLI4hd1IVj+ghV4g6kxX
	zp2caRQNZ9qB6/lia5t2duqXpb+tNQx0KE37lRZHS/vJJ39ZQd8EsBRkgp4CnGKzlQi6knp7hIF
	BpOlPGcpQ1tO7gf1MJGADWH20y6x90L7nlaK9wixhrNvtRTEBIL+M0if140lu9MfE6fS0uFNOeJ
	PrgQt2LkpuAQF6SghIDWJ6Z0e/o7Q1N457bVeWFlLcic6ppqnEDi51XppthHqdjEWtIGvyzys96
	wIk98AXuVZddxH94A==
X-Received: by 2002:a05:600c:c492:b0:490:9d1b:f088 with SMTP id 5b1f17b1804b1-490a29e4383mr182174905e9.2.1780311231518;
        Mon, 01 Jun 2026 03:53:51 -0700 (PDT)
Received: from Ansuel-XPS24 (host-79-42-252-49.retail.telecomitalia.it. [79.42.252.49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c967c77sm257319895e9.1.2026.06.01.03.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:53:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net: phy: as21xxx: handle corner case with link and autoneg complete
Date: Mon,  1 Jun 2026 12:53:35 +0200
Message-ID: <20260601105342.28865-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-293683-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2271261E02E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing case in custom read_link, when autoneg is started, autoneg
complete bit is reset but link is still not up.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index d5738117eca6..0db82da8dbdf 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -658,6 +658,13 @@ static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
 		return status;
 
 	phydev->link = !!(status & MDIO_STAT1_LSTATUS);
+	phydev->autoneg_complete = !!(status & MDIO_AN_STAT1_COMPLETE);
+
+	/* Consider the case that autoneg was started and "aneg complete"
+	 * bit has been reset, but "link up" bit not yet.
+	 */
+	if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete)
+		phydev->link = 0;
 
 	return 0;
 }
-- 
2.53.0


