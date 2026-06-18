Return-Path: <netdev+bounces-300425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DiL7LdPrM2qYIgYAu9opvQ
	(envelope-from <netdev+bounces-300425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:00:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F4E6A042C
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:00:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dHCJAI+I;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300425-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300425-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F43D308F374
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDDB3F6C25;
	Thu, 18 Jun 2026 12:58:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A213EFFC9
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 12:58:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787494; cv=none; b=t3TB4fBD8yk2Q5FspfTNlic9nPTcNst0+DqqQm0FcPu+x8Bf9oeCphReEGeSTHbMdcnvKDFiYb9bPgNrOod5VaGkRMEdXCwoRB6lMpTd1N2TiMFir5ABrKQzgGJglj2xWu3n1wiKfOjNLy9IswmAzE0q9hloOJwdYuJdnFEoXXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787494; c=relaxed/simple;
	bh=ZcRVlQJeNRXK2M0MgaksgKzLa1cJRySbcnQ11oZN5aQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9xkxboEIgM8/lcRQWwqSMlyszvWQ5XXegW24xBbHbRWu+h8rcgGV5gdyWhi0MGIPHxS6y12x2MK54Sewj3xfOx1zDdKgAy6q7uBzUg6MYUXPBi+r7MyMlMPGFazDwJAOs7J6BBt+qClSU3KV6VB/DD+HhQhnhbEpML1hnw1m0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHCJAI+I; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-460166910e6so610725f8f.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 05:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781787491; x=1782392291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0DEjqI/MjSZk63smQxo8R3imVIUNR3yg/nfskjDHjk=;
        b=dHCJAI+Ie3nAXIE8Bj/+/eoqtaAv7lYZzZ2Ap3nUY1D53R/VhXVgMp0YMJ8nVtKEvD
         UiIVtEk4lgqL97eotn5p0BCAPfXkNe2kVilVuFgyzYmZ4y0hd+pYt3X4MBeELaKwCGmT
         hDSFBMneevhAA2ls/5XEAQTwmLspXzhW19X3ZzerzPqYnHec5nrTbT0KQMr6WK1BOeY7
         O8ftJoNwygfoV+uXUkKMmC8OmYbRhrJFN1s//OyuSmOdADScSS4uUi53aWZMmIvbz29M
         8+LHckJ9QC9EqzYElkSyuvbuLqhipe6qtBkXfqFr/W5ZpSNMI4yXZvw7tRjSGazD18bb
         Rw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781787491; x=1782392291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q0DEjqI/MjSZk63smQxo8R3imVIUNR3yg/nfskjDHjk=;
        b=JB3Laoa91TucoijN7+sto6AsNNVJpOgXtToc7t5HjawjYT9rcUQG5gHhRDZNwBItW4
         c9av8Mok+Cg32uMUrvOeZOiQOxHxbAuTCzm6+f6ljwWLmfvTTiz2n4S2jWBDLyCbmdCa
         X+9GkPJA/aLXZKJPZT/04jV/5menZLIL0FaNym5qfrOw1hdfo/IsGjWBVvg9Fy58ml26
         1VQ2hCSSUnvN7fDjSuYHHeUZdpODTD5qR8Ef8eEoDkppz/a3FgDBSVFhiLN7EvWLQXPD
         nVyfCSBAN9iEqJgf6ewcWY+YQbOgfePdi2dxMCpTqDoy9YVdixC0UjOgBZyGa4BM/zHA
         sgUw==
X-Forwarded-Encrypted: i=1; AFNElJ+LsYjKNrc2CZtOyzt1e9DA6pwbQKLujSg6ohsr05sYlzHsKL8qVDUBR04/Hf9Y+zr9eoTaC0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgKh6BTU88EI0ev59Jgze/r4OFjl17e5VgLecB4yyFImb9fn8
	DuA0zJagor1kpcMvmEJ+ViwXYZZVmCsy8Gs44D/yljr3G6JNv19Y0/1X
X-Gm-Gg: AfdE7clgJjQcSqjBfLTt9igTPbHsguOWm1cEgMHHWPk6q5WCSpRiPg0NBOAbEXC4Iv5
	feOUQ3gmZOcRF+gGzFZIr2JaTYNy21NQlgYUFE5Tz800eOaZLywqANet6qWtyQ8+yxMvp0PMQKt
	nGFPj1Nx3saN8DMEIJU0NFpyOBmfw9/kaHXonmfLEaRota7Nc6NENPs/jP0ojRx8U4nx1WbJCYN
	J+TpBwjLYT3QCUn1m4RRevNTc9Be++ohPB8kJL/97Y72AF/w6aazqD8UWk7EEbIlfEx3jP9G/Bz
	X5RCWvnHf199WqipCEGfCf5/wRBtdZVOtH/hhxW/fC1DuilvKeYeFVieIhO7adjHMuMXjXavdc8
	bNMrrTKKoqbhz9IcPdfRt30NENDL2fymUQiJ6fd1RVVdBadEvLCSsjG7HCkKi2KqhTrv6BJ0bFZ
	0Ko5xaRYfgYeV8qFc+8ILiu8aHGHvFBwa6ebrFkfR3yuL3lkZD72pjF475ivr9jQ==
X-Received: by 2002:a05:600c:5297:b0:492:3c7e:57aa with SMTP id 5b1f17b1804b1-4923c7e57c1mr12852015e9.0.1781787491038;
        Thu, 18 Jun 2026 05:58:11 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49230a458f2sm241451585e9.3.2026.06.18.05.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:58:09 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [RFC PATCH net-next v8 01/12] net: phylink: keep and use MAC supported_interfaces in phylink struct
Date: Thu, 18 Jun 2026 14:57:09 +0200
Message-ID: <20260618125752.1223-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618125752.1223-1-ansuelsmth@gmail.com>
References: <20260618125752.1223-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300425-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:ansuelsmth@gmail.com,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34F4E6A042C

Add in phylink struct a copy of supported_interfaces from phylink_config
and make use of that instead of relying on phylink_config value.

This in preparation for support of PCS handling internally to phylink
where a PCS can be removed or added after the phylink is created and we
need both a reference of the supported_interfaces value from
phylink_config and an internal value that can be updated with the new
PCS info.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 087ac63f9193..4d59c0dd78db 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -60,6 +60,11 @@ struct phylink {
 	/* The link configuration settings */
 	struct phylink_link_state link_config;
 
+	/* What interface are supported by the current link.
+	 * Can change on removal or addition of new PCS.
+	 */
+	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
+
 	/* The current settings */
 	phy_interface_t cur_interface;
 
@@ -629,7 +634,7 @@ static int phylink_validate_mask(struct phylink *pl, struct phy_device *phy,
 static int phylink_validate(struct phylink *pl, unsigned long *supported,
 			    struct phylink_link_state *state)
 {
-	const unsigned long *interfaces = pl->config->supported_interfaces;
+	const unsigned long *interfaces = pl->supported_interfaces;
 
 	if (state->interface == PHY_INTERFACE_MODE_NA)
 		return phylink_validate_mask(pl, NULL, supported, state,
@@ -1868,6 +1873,9 @@ struct phylink *phylink_create(struct phylink_config *config,
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
 
+	phy_interface_copy(pl->supported_interfaces,
+			   config->supported_interfaces);
+
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
@@ -2026,7 +2034,7 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 		 * those which the host supports.
 		 */
 		phy_interface_and(interfaces, phy->possible_interfaces,
-				  pl->config->supported_interfaces);
+				  pl->supported_interfaces);
 
 		if (phy_interface_empty(interfaces)) {
 			phylink_err(pl, "PHY has no common interfaces\n");
@@ -2828,12 +2836,12 @@ static phy_interface_t phylink_sfp_select_interface(struct phylink *pl,
 		return interface;
 	}
 
-	if (!test_bit(interface, pl->config->supported_interfaces)) {
+	if (!test_bit(interface, pl->supported_interfaces)) {
 		phylink_err(pl,
 			    "selection of interface failed, SFP selected %s (%u) but MAC supports %*pbl\n",
 			    phy_modes(interface), interface,
 			    (int)PHY_INTERFACE_MODE_MAX,
-			    pl->config->supported_interfaces);
+			    pl->supported_interfaces);
 		return PHY_INTERFACE_MODE_NA;
 	}
 
@@ -3761,14 +3769,14 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 
 	phylink_dbg(pl, "optical SFP: interfaces=[mac=%*pbl, sfp=%*pbl]\n",
 		    (int)PHY_INTERFACE_MODE_MAX,
-		    pl->config->supported_interfaces,
+		    pl->supported_interfaces,
 		    (int)PHY_INTERFACE_MODE_MAX,
 		    pl->sfp_interfaces);
 
 	/* Find the union of the supported interfaces by the PCS/MAC and
 	 * the SFP module.
 	 */
-	phy_interface_and(pl->sfp_interfaces, pl->config->supported_interfaces,
+	phy_interface_and(pl->sfp_interfaces, pl->supported_interfaces,
 			  pl->sfp_interfaces);
 	if (phy_interface_empty(pl->sfp_interfaces)) {
 		phylink_err(pl, "unsupported SFP module: no common interface modes\n");
@@ -3939,7 +3947,7 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 
 	/* Set the PHY's host supported interfaces */
 	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
-			  pl->config->supported_interfaces);
+			  pl->supported_interfaces);
 
 	/* Do the initial configuration */
 	return phylink_sfp_config_phy(pl, phy);
-- 
2.53.0


