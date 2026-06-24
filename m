Return-Path: <netdev+bounces-301578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A5IdExubO2oaaQgAu9opvQ
	(envelope-from <netdev+bounces-301578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:53:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B72066BCB5B
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:53:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=co7Du9pq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301578-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301578-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E48F630C015F
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8083A39936D;
	Wed, 24 Jun 2026 08:48:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14322395DAA
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 08:48:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290901; cv=none; b=cXjPOEBNZ0MuMY4ozPDWa0PRD0Xehyq1+AH3DekUIMURoD4r3AgeVBTGALzw7rXDTs4ByFJmSpP9OWyEnFYshF7Fz54SVbieS7gmEKZPejpcEXLTZTltZdTegllrfzQ0S+phyBylKRCPplWTc7fnLF4W6qYPm4tlXMPStqWhxIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290901; c=relaxed/simple;
	bh=UQ8ZercqnEexR10BCqp8G+i78OvuTl8M+8IL2LNTl+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Occ/2nxxF0oFBZ79KafrH48Z/zU760VT/62WxYH/KZxi7OjRdBynBJ3UJaswkK39ozoJ9bjDuz2SinLVoRSUL9Agl4oGIr1TYn2BgP2RjmfBqcnJWUDBZFIEJHiJmzQapX+/fdLHAQIXJ3v1hn8r5LCXEAZ+U1D4ufIGEMYOIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=co7Du9pq; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-463b2f6fc9dso872663f8f.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782290898; x=1782895698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82FA35TCqJ8Eddf8LJXiGKVbEkzxEdof0NFAzA1rmpE=;
        b=co7Du9pqMcheFaYT/7qXObRZ5pvrSrWflCDvItHjBSzY583ppUT+anEresOV/1ZvpU
         EAORMU6/7AGAza2M7kYjXCMs2Jz1ulet9KvpABTxHNsrJEScnPMVnfOwf9U03diOqYNu
         XMZGFvW5IhN+BJ9XNeDgniqaNuOFutO2FJfgGRPQLY6QVMqJADXVyZ6HrG8san4bgD3r
         BgjixKPOqtAWT0hoPq2KLmp7B4i///cC65Qux6tyUFcJJHwmtFu5M9SFoFeia5LHEauv
         ZGEE/B+BBmwn+wNmASYVj/9pG/bFYS3AuEbRJR9mO2zpDX7A2HGxOBAseUr4koID1dOd
         zZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290898; x=1782895698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=82FA35TCqJ8Eddf8LJXiGKVbEkzxEdof0NFAzA1rmpE=;
        b=ej3RisPt5HK+t27JH1T9m5VQPRxfqM1ZWaFHfxMCSkRLgXFtBy7Eohb89WRSWYUkNC
         85sr8VFsYkCV5eIVSalSw0KgXmngQrtsWUAArNEYbG3IC6S0Gjw9s2y00ctavkiAhAjs
         OEWH2iyA+aZThH+oVzaNfFGR1Ae1ylEK8XY4W99lQY3jovIdZsXih/4Q4VXhe173d4Dj
         WAO15vJy1Ma+WUpoE4rIERSza4v66IB+ZI4jRHxe8Mm42xkSi0sjyPQ8QwlqTu3gvBD9
         OF0xpDDz5AQcLsT4zI0lG0uivxhl5Ki7BD4VqjsrCO35mjhF8viB5s2RSVwzL7Tl+AkN
         bUqA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4Md7tGlURaE2OPM6nBw0oYjRhEI7DpWVUILSB3CfP8/qEVndvYnV3d9f2tcUJtEy/tAOHiVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB3EqbSx/W/cM+/0tlC7IT2hoLEudPpwAKIoqtvvZkzEwTOT+8
	0V7VD5j279G6+MGhGvKH5d6bgRtBnj03hKLAZW3XwEwy+Lij+sxSSdLc
X-Gm-Gg: AfdE7cm48ipLJSwOot01sAjWN7SMos6TojU2DjNpQWmyVDjaXir9+GB29jYQXQVRCT1
	SnkB4pcSMFpuv1K1ju8hbQROYyQh9i1jAVEKhvSN4e0pLFFs/rUBySpUuHZ8quJ1MtOEU+4SfFE
	0m5S515lj1cG8yMRD2GEKCyJOc/TvHTC1xtFnAGhWJtyQiDrs6NR8WCSwUaiqHpf6sc2/+Idkfp
	4m8YR6tyX0QgVtPrYQj86hJK5nAJ7nWkMwDDuMmBVlOXtWBv0aRRBmANrgaNBiubM/vy+Vu5Fw+
	8AT2tlustfIBmpLAe1htvBsMWauxtgodnUsHOD+bJRsNgeNbGd2OoqLqXMfeZfUnJ8GLskt4/Fk
	LGshqC+wPiTRU1ijyhGqSW/oqsavWe0xELGmVcnMyT3ipiPmhvyQQkXD4Ztr3CJzf3eicvn7s5j
	keArOyZGFD1o0u3kX3SoS6Jrnwu6SwmVKgT4X46B+THXAUp5yKuibw9+kXF4V+oyS2U3QagANE0
	O4ifDY=
X-Received: by 2002:a05:6000:2587:b0:45d:41e0:467b with SMTP id ffacd0b85a97d-46c0951d92emr3798306f8f.3.1782290898438;
        Wed, 24 Jun 2026 01:48:18 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d9371sm5065849f8f.21.2026.06.24.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 01:48:17 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Bjorn Mork <bjorn@mork.no>,
	Aleksander Bajkowski <olek2@wp.pl>,
	Marek Behun <kabel@kernel.org>,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net v4 1/2] net: phy: sfp: free mii_bus in sfp_i2c_mdiobus_destroy
Date: Wed, 24 Jun 2026 10:48:13 +0200
Message-ID: <20260624084814.20972-2-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260624084814.20972-1-petr.wozniak@gmail.com>
References: <20260624084814.20972-1-petr.wozniak@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301578-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B72066BCB5B

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
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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


