Return-Path: <netdev+bounces-301297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3LYbIBY/Omrz4gcAu9opvQ
	(envelope-from <netdev+bounces-301297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:08:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E87A76B527C
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:08:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C11yMzU1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301297-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301297-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 848DA309683E
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE8D38C2A0;
	Tue, 23 Jun 2026 08:05:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F10331AF07
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 08:05:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201945; cv=none; b=SbZfeN/7d+rLkrKkrIgzo+QVQj9QEv7U2/NbNgXWovJB0Q2N/zBI5TMFkIYdKplNlwXx6r4OkaAf53RMBF/aSh78fGNufX/utMlSasrgjSKqE6UjEVy2Da/8ETVZ9LxnU+3jmCu1U9mAqbyhF3O5ZNwMw862qOJgOI7b0xIMN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201945; c=relaxed/simple;
	bh=l7Grnr3PmFISuxul3Ve894yunIdFyWsPBWHXEUkjAck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKm7ud2Bw/fQm57XUghRJj5J0P3mEwJk/tgSJhBedr0oL7gCyl1W1rR8EofCifPutcDtbjzj4a98oEKe8H00esQqzuZEE4wYsGMXu/a9s463qTAfqSZkYrbp3P1wuuQ3AX93BVapGmfNNxO8B4V21SnLrqW6Bm2RPGRJ1zzUYTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C11yMzU1; arc=none smtp.client-ip=209.85.218.50
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c07fcdd75d3so647210566b.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782201943; x=1782806743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSJzQ7BvL7UAfauGXcds5wC0m0PWvmurBL/+ctg9lkA=;
        b=C11yMzU15eEJtUGFBdeD7ST8IAX8DL6Hs/oIzPujvZCPZN+yigz/MxrZgIA4TcFhev
         VdcN86q4AFLVCjJR4Q/Ceng33jjz5zZr8J12JVzeC5M2mwgvlT5fjasnf2mh2QfdWDo8
         ajBRSKZv+CiQP6+nM//s7jpSohQGb6VryuO670lW+wFIvDIThMVJEKlGcI7D7ljl/EU0
         SxjPYGAr2A+byv3YJQLCu0ML6G7K+AwrwAH9R4JeZAieg46tdDk2CtAECgAWOKkxgMwi
         R9P+rnPBQ4TNMYPZKc98ZVNj8Al7x/VJB9qLlUt+Ya3hAooQSOhR888XoppSCx/tNAAm
         +2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782201943; x=1782806743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gSJzQ7BvL7UAfauGXcds5wC0m0PWvmurBL/+ctg9lkA=;
        b=Pj3+vaBIWb9BSgEc/nQzddwtvaeWDfDj0+7vieFEMzYAyMblvZRIKHXhkG+4Lqs9/X
         RfNHNEDIlSuQtGhIHfjfCfQFIkJasYrgfESvy0MwKCEVnBEjDdge/n1WYkTRtq/xWfLf
         0zoH8w9QFbGxfS8c64fnqn1gdshoJmlUFMbbmLpfUIhz8cSAZkDTiRDy4PPGlVbry+sb
         njgiVHlAv15l0nc954uuLaAn6WS+dxfXP74JdLwJFG62Ckl1skHXgdc9LkBFR9ry9j91
         MBBhl/Ii3coa9KPRbmyVbDk9YLRaW0ZMBM8hdVgGK7E5lwMTRQKaSDE8s3jzaJDsJCrB
         D/6A==
X-Forwarded-Encrypted: i=1; AFNElJ/1M+8XtU2O0UqAc6Dv+ncY/z4sL1YU0fLT4aGqDBKz/ZDW8VrY6OPZkmIdT0lUXBXy2lwzNvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK2mNuskAuXN9Tdb90X7YrrZvLEjZUCbwyQhstryrI3qL9J8e7
	8UhmDnUSX/kwDvPcEe4v3m1DYP8q5KejmsCq+hjMk6ZTSQldV3mnhndf
X-Gm-Gg: AfdE7cnYrHAAL/UQmJOIGB5D3AsBaV1uWv7A/dsKY7EEOWY/PEIwxQrZzdNJAfboGWR
	uET/xLlju/KnAFA1Mfl6KDHrzbsg+Mr/8xkAY4UqGcaVQLqId5iI7pEKF3+6avo7YX9PrckZQq3
	9dOs9E2lgRad1y9MhtKzN88Ynr2UKHFsChKf1rOGDFOGTxmS7/p2xfQFQthQACrbKq2B7Np0ba/
	+siDPD2RY9LLTS58ruqVqM8jKBcIX+QTCo8bjdJQnmJxOi3bawHDtaz4vbRpQ5E+1Dg1dt9Q/C6
	q6HSxOrHHpEl+7ys8+pnA8jjRRuXUQ38zssGATXK4VwpgvIjBHcSmcSsJfrTQYOzgrCVcCXfE8H
	kVtOY7CQLS505X30X+XwEZ6m4t3GvTOsnjzW5zKHPTjjzneVXG6jbEKYs4Yia6HUF4ItpwOQHbX
	3pIctn6pxdfhT/U55BFeBu/t++Hp6KKSmzBr3pro7qkr2U0JMfWH30dA0eDJMopNIp5SltadlMi
	imJWDs=
X-Received: by 2002:a17:906:c14d:b0:c0d:1553:3da5 with SMTP id a640c23a62f3a-c108f0fcd14mr71897766b.35.1782201942670;
        Tue, 23 Jun 2026 01:05:42 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46667221de7sm32486503f8f.33.2026.06.23.01.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:05:42 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	maxime.chevallier@bootlin.com,
	bjorn@mork.no,
	olek2@wp.pl,
	kabel@kernel.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net-next v3 1/2] net: phy: sfp: free mii_bus in sfp_i2c_mdiobus_destroy
Date: Tue, 23 Jun 2026 10:05:37 +0200
Message-ID: <20260623080538.7646-2-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260623080538.7646-1-petr.wozniak@gmail.com>
References: <20260623080538.7646-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301297-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:maxime.chevallier@bootlin.com,m:bjorn@mork.no,m:olek2@wp.pl,m:kabel@kernel.org,m:petr.wozniak@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,bootlin.com,mork.no,wp.pl,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E87A76B527C

sfp_i2c_mdiobus_create() allocates the I2C MDIO bus with mdio_i2c_alloc(),
a plain (non-devm) allocation, and registers it. sfp_i2c_mdiobus_destroy()
only unregisters the bus and clears sfp->i2c_mii without calling
mdiobus_free(). As the only reference to the bus is then cleared, the
struct mii_bus is leaked.

This is hit whenever a copper/RollBall SFP module that instantiated an MDIO
bus is removed: sfp_sm_main() takes the global teardown path and calls
sfp_i2c_mdiobus_destroy(). sfp_cleanup(), on driver unbind, frees
sfp->i2c_mii directly, which is why the leak only triggered on module
hot-removal and not on unbind.

Free the bus in sfp_i2c_mdiobus_destroy() to match the allocation done in
sfp_i2c_mdiobus_create().

Fixes: e85b1347ace6 ("net: sfp: create/destroy I2C mdiobus before PHY probe/after PHY release")
Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
 drivers/net/phy/sfp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 03bfd8640db9..c4d274ab651e 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -963,6 +963,7 @@ static int sfp_i2c_mdiobus_create(struct sfp *sfp)
 static void sfp_i2c_mdiobus_destroy(struct sfp *sfp)
 {
 	mdiobus_unregister(sfp->i2c_mii);
+	mdiobus_free(sfp->i2c_mii);
 	sfp->i2c_mii = NULL;
 }
 
-- 
2.51.0


