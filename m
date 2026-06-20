Return-Path: <netdev+bounces-300771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T9FSJ0nrNWpu6AYAu9opvQ
	(envelope-from <netdev+bounces-300771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 03:22:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB52A6A8279
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 03:22:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HKbOhjGp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300771-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300771-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 486F9304A872
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 01:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB711A6836;
	Sat, 20 Jun 2026 01:21:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB85813635E
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 01:21:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781918519; cv=none; b=lexPNzAtRrPdzLOoEv5sg4okkwzfSwbQRq9ccAx862dcMde7QmIJj1CKfqbKcYrrr/Ht6WcxHDscvgEff5VSADYitQzp3bCxlZECQSIz+aGyMvSeL/WzFlFcBeUGZlSgn5m4/otemz/B/WfZ17MP6J8UymN59jY0KXsPTpNHaYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781918519; c=relaxed/simple;
	bh=HqcjuCULUw4qkZsC+NiC1XrWQgI09RM4053kTIirFTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/P/2ljNSDIv1GnmdHMHM2sfbWPpe9hWlTlV4fC3buYcAFFwAchZEm10blFRE/8ZrxyyFkNsdU62IlUxv8WadNPWTJRhHM/P2WXDU3B+dtnCuvmbVqnebB210AD0fXTposs34nUh1HZF27ohyuxd2wTmDscwHmDRW0WTRHLuAho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKbOhjGp; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso19446345e9.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 18:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781918515; x=1782523315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qFVTuKItGBuoPE7wYIuR/hBckRIiltP6ZLSrXPb+oI=;
        b=HKbOhjGpawx+Zu5WHuWeJsvF//vcspNeUmhmi0h/JKcMUYKu6yK5dY7hxAH6OIFZ65
         zj53WmcQsK845cupQb1Gi71l/Srs8XWFbBi88lcFDg1smVPwrF+hHY9zqP7SWjntfWQS
         0m9JctMiuHPQzYK4zBEhMgJ38h+sLRVc4Qx0z8LVQajLHZZm1YCQ+AJQi0m50rQFESu4
         3fMVKx3/H2i69LnF4B4e+X+NWlTIKR776pvO6qdys+scA2FDY542O/jNlIYQk65i3s3m
         1cAuoTpFejP6kXd5Vsv3HiHt/p3Ny/QoC4aTau0dQHo/tRQgH0tfrs0Cu0JuFaDSWuJb
         fu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781918515; x=1782523315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qFVTuKItGBuoPE7wYIuR/hBckRIiltP6ZLSrXPb+oI=;
        b=tKYgGBomeuEWIXOgDvxf/RUM07hCSweAYGYIrKb2Gv77/9vNs91Ifc3RwUO8lSkDHL
         WutHZh+IuuV1dYH+ldy3ehmhzyTlMqINqDEvuixlV0e738fqiZWI336qks313rTmiTy7
         79XomIod3e5ne5A9y5n2yH15dMhHELfQN+Dcqpg3Q5dkr4JW+dAu0cmSuuqigGdFALi9
         VHqNPGIXDYOe4vnyM4wfLJEBvBHTFGiYUVO9mQoWU4CTkMzaIQWhpdTWTR7MeLKA4uiV
         MQZZfuS9oIm8A0TOdBgDnC5/ktgRcyOvm7Z7Y//40ifneP59vsHEg4fONV5VO3rKLUUj
         leIg==
X-Forwarded-Encrypted: i=1; AFNElJ/SHGkC9PiI3+Czl9M1B/WT16x9XDDfhzsOS4VnUBmOuMOcst4HZe5jeKDuq4ExAnC6omXCqgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqxyj0JE2FVmBbfiyZMavyJfDBaDAEH/fYdQaJ7jvz++E9Qwq/
	FjYWIjAdOX1mmipLvT3Xhg0VS7MolpPLFcn3o3fv/4zYTPskSGP0d2j4
X-Gm-Gg: AfdE7ckxiVKQuVl4da3Q49xYhaAiPNlRrE0xqS3wbwnVv/8Wotc6VoK4+tfpalNAjGm
	DZ4Ea9KhhGA1FrCbElr0DLP0gPKOa6p5AHVXVr4t/Eiw64ZvGzEmHsrsU0aDD9VAUS6PHovD3R4
	+QM5SjRHHcYvzR1IFdkyJz0bWpzh+W4OYqwcahsbuoQkd1Ijz/cbGbx3mhsHQDvWwIYhVUAE5lu
	qkZuX1dO8iK/Fm0Xz11HSm/vXTk5RDEeGFLSLleEEKzVzX2+9Ej/kF8AEMgVB8FtXip7QWn+3JV
	kOTDX3XsacF/Mley5Kf8H8ICKyuIIK9t09RnjCUyqPBUjInIfH2lSwr6KSEMcV7OAEN1wIp5iNO
	ycjagkcX3UTfe7V8wht5dmg60+WLqKdQISG7HdynYiJZDE7TuY7X383TWxJ53JqQpPt+CTc9eV/
	NFfAwTllGx01a1jFNz9ivA
X-Received: by 2002:a05:600c:4e4f:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-49240a486cemr74241415e9.16.1781918515037;
        Fri, 19 Jun 2026 18:21:55 -0700 (PDT)
Received: from cool.klos.xyz ([2a02:8308:a09d:f500:945a:ea46:4571:736b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923392dsm44059805e9.2.2026.06.19.18.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 18:21:54 -0700 (PDT)
From: Jan Klos <honza.klos@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: Jan Klos <honza.klos@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Jan Hoffmann <jan@3e8.eu>,
	Issam Hamdi <ih@simonwunderlich.de>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	ChunHao Lin <hau@realtek.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV10G bit
Date: Sat, 20 Jun 2026 03:19:53 +0200
Message-ID: <20260620011956.37181-1-honza.klos@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300771-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:andrew@lunn.ch,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:honza.klos@gmail.com,m:maxime.chevallier@bootlin.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:olek2@wp.pl,m:markus.stockhausen@gmx.de,m:jan@3e8.eu,m:ih@simonwunderlich.de,m:amadeus@jmu.edu.cn,m:rmk+kernel@armlinux.org.uk,m:hau@realtek.com,m:linux-kernel@vger.kernel.org,m:honzaklos@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[honzaklos@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,nxp.com,wp.pl,gmx.de,3e8.eu,simonwunderlich.de,jmu.edu.cn,armlinux.org.uk,realtek.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[honzaklos@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB52A6A8279

On RTL8127A connected to a link partner that advertises 10000baseT
speed cannot be changed to anything other than 10000baseT as 10GbE
is always advertised regardless of any setting. Fix this by
clearing MDIO_AN_10GBT_CTRL_ADV10G bit in rtl822x_config_aneg()'s
call to phy_modify_mmd_changed().

Fixes: 83d962316128 ("net: phy: realtek: add RTL8127-internal PHY")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Jan Klos <honza.klos@gmail.com>
---
v2: Patch formalities (rebase, tree name, tags, ccs)

 drivers/net/phy/realtek/realtek_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 27268811f564..b65d0f5fa1a0 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1802,7 +1802,8 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2,
 					     RTL_MDIO_AN_10GBT_CTRL,
 					     MDIO_AN_10GBT_CTRL_ADV2_5G |
-					     MDIO_AN_10GBT_CTRL_ADV5G, adv);
+					     MDIO_AN_10GBT_CTRL_ADV5G |
+					     MDIO_AN_10GBT_CTRL_ADV10G, adv);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.54.0


