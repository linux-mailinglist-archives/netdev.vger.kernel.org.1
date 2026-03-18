Return-Path: <netdev+bounces-269131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHRADfXXumlZcgIAu9opvQ
	(envelope-from <netdev+bounces-269131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:51:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D9F2BFA25
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50937304F5AF
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3FE3FAE15;
	Wed, 18 Mar 2026 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnOzb99I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DB1392C40;
	Wed, 18 Mar 2026 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851933; cv=none; b=BDvW2VivdMhiFJw2T7dzWgiagxtIp6G5alXIsXQ92GO5dN9TcSPXYUt5tWeeU742a6oS9uiCD2rqMbYO67S4UkktMVruEHOtY//SILWWwt8ibyhfVwiJYE9ubQPpKRmQev5faM3tngghUMkDtpJE5XcAzTfCu6LGJERVYNSqAYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851933; c=relaxed/simple;
	bh=i7QiZWLKSiDuy+JWZoWlsnw6MxIl6xp8yCXQ6R5f7pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCEb9Cl79H6E/zB2yp3iLCBX/IrL2t5jkiBdhyLY+SMPrkZy0bt3gv/WFeLm87sV6LHttPKKg32A2XuRwAZCCZw1mVJQo1Tbn+yEcSdNlcEFZIKQqcwueO3y83CkX1rXju4f/0J8ZoTbnAft2o2bmX/LhIQZD8RoiW2arjoX+HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnOzb99I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F363BC2BCAF;
	Wed, 18 Mar 2026 16:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773851933;
	bh=i7QiZWLKSiDuy+JWZoWlsnw6MxIl6xp8yCXQ6R5f7pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OnOzb99IJdzWRWPppb1WwQY3nqJoJLbNJyKhbBRYNPyDj33oM8Y7KNUf++z49F4tr
	 08LHUHNmcTR34Lz24Rvg6IjBI7XmMfwWPebLtOTS/+cQUVoCqa0cuVRrA1IrzWHthQ
	 7ijkzOPszVg/blmXINrMkRgEZ0Z/FYBsLG3Ly6IeRcrPteuFrWThhrPYcToEWoPveP
	 cc054tjPLMUZwlfn8y/l/SD+oivRZsZCQhddLh0TFijA0XGitHIgtmC/R4BeRfOijJ
	 KW5GsXXQQdiYj6ikQz86p38VDC2tXca1d4A1ugycXVQSEre4WR4AzGlF/Ymte6v/LA
	 M3OpsC7l75SNg==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Ryan.Wanner@microchip.com
Subject: [PATCH net-next v4 11/13] net: macb: runtime detect MACB_CAPS_USRIO_DISABLED
Date: Wed, 18 Mar 2026 16:37:42 +0000
Message-ID: <20260318-fifth-getaway-2e50f7a71eed@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318-surpass-puzzle-f94b46aa8808@spud>
References: <20260318-surpass-puzzle-f94b46aa8808@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Bd2gbW7fOvjC1AVjUN6Hv9MmZ1hZns7eUKZVvI7xatU=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJm7rlx+2fahvr/SaZ1sdZuHf+XuE5m/v7Rf1bf7a8I30 26No5tdRykLgxgXg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbi18Twh3fVy7Muuh4BX9g5 u+63V0yYsFdh9dPEHP/L0pKL9tvmXGVk6LY57tLFzTlRJsX050+ry48uNj92eLdpwtaX786eDr7 6iQUA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269131-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 00D9F2BFA25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Théo Lebrun <theo.lebrun@bootlin.com>

DCFG1 (design config 1 register) carries a bit indicating whether User
I/O feature has been enabled or not. The MACB/GEM driver has a cap flag
indicating that HW has the feature disabled (default is enabled). Add
the missing connection between DCFG1 bit and MACB_CAPS_USRIO_DISABLED.

Indirect impact: avoid useless writel() on USERIO register; this is not
an important fix because USERIO is anyway read-only when feature is
disabled.

If for some reason a compatible sets USRIO_DISABLED but DCFG1 indicates
it is enabled, we still keep the disabled capability flag. This ensures
we don't break "cdns,np4-macb" that sets the flag from compatible match
data.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb.h      | 2 ++
 drivers/net/ethernet/cadence/macb_main.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index cdb9fb2218c6f..bc025719f6008 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -518,6 +518,8 @@
 #define GEM_IRQCOR_SIZE				1
 #define GEM_DBWDEF_OFFSET			25
 #define GEM_DBWDEF_SIZE				3
+#define GEM_USERIO_OFFSET			9
+#define GEM_USERIO_SIZE				1
 #define GEM_NO_PCS_OFFSET			0
 #define GEM_NO_PCS_SIZE				1
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3e0ab23e9b9b0..b11ef703575b0 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4330,6 +4330,8 @@ static void macb_configure_caps(struct macb *bp,
 			bp->caps |= MACB_CAPS_ISR_CLEAR_ON_WRITE;
 		if (GEM_BFEXT(NO_PCS, dcfg) == 0)
 			bp->caps |= MACB_CAPS_PCS;
+		if (!(dcfg & GEM_BIT(USERIO)))
+			bp->caps |= MACB_CAPS_USRIO_DISABLED;
 		dcfg = gem_readl(bp, DCFG12);
 		if (GEM_BFEXT(HIGH_SPEED, dcfg) == 1)
 			bp->caps |= MACB_CAPS_HIGH_SPEED;
-- 
2.51.0


