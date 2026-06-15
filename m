Return-Path: <netdev+bounces-299495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RfeLJSAWMGr2NAUAu9opvQ
	(envelope-from <netdev+bounces-299495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:11:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B93368782E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:11:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eihaTJ1Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299495-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299495-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 252C630027F6
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422CA3D16E0;
	Mon, 15 Jun 2026 15:11:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45DA3168EE
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:11:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536281; cv=none; b=XPdTn+hKulFq4Eg7FL9EbdKUZrdYuBIRZbL7QE75ffepaUo15pAQo++44+FNMh0City9U1KvOyw/iwZKrgr03/Tn2wVU2jKhOkaxw2eWaXkG4x5JVxPOYCQ7GwFJKCwym03E/QA1pYJnBNTRzDbtaCx6SNnX95KkStwgvUc4Sp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536281; c=relaxed/simple;
	bh=VL9zQWD8H1SjF2MkfF9+3rSYoioI+goB1u7B8YNFWgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KDUM0tC0FZX1ZgWsmo70r8Kmx72yC5PYrfGmrsYuIdgMjn0+HkXenu44w6tEw4f092nlQFxkVrL/1056fqspa/NRy9DtObsuESylN/rop9PLrhF70HepNYlBqy1wRt+EOiEoQsYbuYhNekP89YKtWKuq0rINgpAxBzLDwjX1/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eihaTJ1Q; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso31073815e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781536278; x=1782141078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=atumCYZH4kfixZGFrkvd6pjJYdqMUcUkjREboEVQyOE=;
        b=eihaTJ1Q7B/IJFzop2El7pLlsfO/+gXNCDOFQd819YFo48LLzMurThImyc2SgMfife
         OBoLtiuuOm7zTYXtpzu9BUkIY7C66qIanpOtkAeaOif7c8T4T1P5WBCxxKvyhVb2jRqE
         mMUBjTTeYePvx1PsmGDYqn+V9mQc+s6k+hemgx93C6R1+eDRajzuIpW8zqcs5ZBMCSNC
         qYMAkVi2P3IN6o6XXnydCYRW1BrJRWRYEQFfdk9qH7o/TX28riOAz0/WkuNSQeHMn2lp
         7PBudttq9n+kxQu3eYqGFYXKfz/Mf0OT2wj7K0GY/kKjbxVtX1IwwXhZVHZnqYyvbPHo
         lWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781536278; x=1782141078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atumCYZH4kfixZGFrkvd6pjJYdqMUcUkjREboEVQyOE=;
        b=l0xD31i1W9kDPZ04YTQBxtKfnIHQQQq20uOGaSyW9kZRF67AZGKBiJUjYNxftTefZI
         zWvhBvXipoXTxgWBC6j4IiTiZo/fUE5EpFLrJ/WBV7O0FC/r3lkKk/3zosmKZuTmeBK6
         38i2yCgLRD2YnzFgz8tMsg4RwTuR1COA1rK4l6qQW29HGShkUcTAcyDYdQ3WIWzKC396
         MUy58xP0etvxYXJD9lS1soUeP1eXXPpkUt/vyWEarydOm6d11x1fhdkVUm5KOAFTqjc8
         do5/hst7fTdGAgQy9bsl7KNrzqP77ljhzx4cdDlVVIRoesWl8mftdpHRSeoYGC1WTMt7
         uLxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BRjNIYBBy67L27oHkTy+AeCUIrUpb31qBawrecl2CWf/h5qFOofGie+GYyqoFqPYNFO1oKr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjmYVjA6VlxMhagZT3HrS5jscdsOCWIVALW/kONo18YBrNt/LL
	yvELk2j0t9/h5u+Sk8I2+/kWuCPfQlskJRTQ8jXVd9KXcp8cKsixCbqb
X-Gm-Gg: Acq92OEeNlmM+caUTd60CqSNiaCY/7JeZzIkO5gdJPbQ1KCVr+cZchRBQRJLiM30MVp
	7LNijuvKiTSpUYQGbKBTYY1WPawAObilsEJnqcQK0Q8JjGpMSQBaXoBVIaPbnDXEJse5shILFbj
	qPzMeJAinOCTiXtp7ejZrtuFEws68BGA/gTGaehd7qSHAZSPRhtjmPQ07PSLJJGnmz2AYlppltq
	zj9ClFaTZ/s1mM0N9AvzLFv5nYj4dZDGFqUPy+VjhDqQvWZXScflC07Dkr+6s9Y572yUKEK4qhu
	M0+cYPECRhXmUy/mHJQv22nm+poAXP1rx2yNm1Ssime0nOgMb7EBrZym2iWWcVfHDgTx6XW0nAI
	4Q/9KmWYUYZcOJU3utuUTXxF5l+YzSAqVCtELpCO3g8CwSUyImDwoyBAbsnurgvLvdTic7SWm+R
	AnXSKH/nI9m3vLamNnoFonuuqh+yyv1DLJsGlP4euCB6sdoZxWbWi5JUU=
X-Received: by 2002:a05:600c:3b02:b0:492:2f3c:d0ed with SMTP id 5b1f17b1804b1-4922f3cd1a2mr6544955e9.30.1781536278038;
        Mon, 15 Jun 2026 08:11:18 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-492203d08bcsm260449915e9.13.2026.06.15.08.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:11:17 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH net] net: ethernet: mtk_eth_soc: fix supported_interface set after phylink_create
Date: Mon, 15 Jun 2026 17:11:00 +0200
Message-ID: <20260615151106.15438-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299495-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,armlinux.org.uk,makrotopia.org,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux@armlinux.org.uk,m:daniel@makrotopia.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:ansuelsmth@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B93368782E

Everything configured in phylink_config it's assumed to be set before
calling phylink_create() to permit correct parsing of all the different
modes and capabilities.

Commit 51cf06ddafc9 ("net: ethernet: mtk_eth_soc: add support for MT7988
internal 2.5G PHY") while introducing support for 2.5G phy for MT7988,
probably due to an auto-rebase, placed the configuration of the INTERNAL
interface mode for the supported_interfaces for phylink_config right after
phylink_create() introducing a possible problem with supported interfaces
parsing.

While this doesn't currently create any problem/bug, move setting this bit
before phylink_create() to prevent any possible regression in future code
change in phylink core.

Fixes: 51cf06ddafc9 ("net: ethernet: mtk_eth_soc: add support for MT7988 internal 2.5G PHY")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 7d771168b990..5d291e50a47b 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4960,6 +4960,11 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
 		mac_ops = &rt5350_phylink_ops;
 
+	if (MTK_HAS_CAPS(mac->hw->soc->caps, MTK_2P5GPHY) &&
+	    id == MTK_GMAC2_ID)
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  mac->phylink_config.supported_interfaces);
+
 	phylink = phylink_create(&mac->phylink_config,
 				 of_fwnode_handle(mac->of_node),
 				 phy_mode, mac_ops);
@@ -4970,11 +4975,6 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 
 	mac->phylink = phylink;
 
-	if (MTK_HAS_CAPS(mac->hw->soc->caps, MTK_2P5GPHY) &&
-	    id == MTK_GMAC2_ID)
-		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
-			  mac->phylink_config.supported_interfaces);
-
 	SET_NETDEV_DEV(eth->netdev[id], eth->dev);
 	eth->netdev[id]->watchdog_timeo = 5 * HZ;
 	eth->netdev[id]->netdev_ops = &mtk_netdev_ops;
-- 
2.53.0


