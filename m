Return-Path: <netdev+bounces-305748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jcl9L08lTmo4EAIAu9opvQ
	(envelope-from <netdev+bounces-305748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:24:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F897243F9
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:24:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=p4Ol3m2x;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305748-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305748-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 215593004687
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 10:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8F53A1E8C;
	Wed,  8 Jul 2026 10:23:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F6F3947B8
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 10:23:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506233; cv=none; b=KWbWGR+netIpP2i9NE/VLZAyrXQCUclxH/W+2TIBpuUK5TSB7lzoK0YFZsApCJReUNyTFK9QSuXpcGy6JuLKQhXb4gSX1i8X8932pKvyA/tUGkQT+f+tGF67O182lsUj/xa/4SuB67m0x3BTRyjclmcPFeEqCAkV2MtQCpEyVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506233; c=relaxed/simple;
	bh=NbM57NUEnyZPiWIlBM88pNF9T9dCRUrWgoKS05GHLpo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU/M1T8gzrVXYrt999+b39thQGDUeCNtUuLNR98blqrdurT+yD+dEVC+XbOWkX8K2f3JZaBwS4msUE9S0PAsRFN+tizsIW4sOaSNp/LgCMmcmhRH3KuD2ptFqQLaMao95tYvMUSB/RLuJ2+nzJfsHfmUtnvy7IPcky45kd9A39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4Ol3m2x; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47def004ba8so93674f8f.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783506231; x=1784111031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZsRXfT5ibQiwiJAzw9HJHDQeaykvfcjebj1qaMIo5g8=;
        b=p4Ol3m2xXJmIcHiJ3gvvR/pLz9wRRQp2CqkvS7vRnK2ezKJ7hkvKa1s7vyEUwCoG0H
         IE+KEeTs2l4ZKMhslY/zOT78qmeTEt7XaZ+NRDsUyQArQ9xapWkOvE7rYmHy46XbmoIB
         pqfrgtiPgJHvgA4CT8ZvhwsK8SyOmDGV/Y/0mkMRE4R2U1dtlEt0p4xWAja7TPmchB6g
         w/iu08h4Orb674szOkFyyBKCLjkp98EncPDrs39Awj04JzL/qdrjPsOLuiBzZajTC0R6
         jXDxP+MFUU4ePn+7TmzbhPBEYNcF24SGuKVAn1R4jYImC1AkDbwgg0cfK+aDu256zQa1
         o/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506231; x=1784111031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZsRXfT5ibQiwiJAzw9HJHDQeaykvfcjebj1qaMIo5g8=;
        b=ESk5+wVrsKESGmyrZWzmiT15vUFnvTZygt7LQbLsF+EmlPJmQqIZ3dYX2CsZDVyp8v
         1lDspN7hYJC/62R2xZy6yvTsu/iLQh1oIAmnbOWBVEe1rVIzurTlCvRMMrlaOV81rLso
         thPoHZYvV4vzl70NzxK9EPO7y2NJ2DJZTa4r3SBOb4JXg7S6NJYDaIKizJMP0puhCE21
         5lAT3AK2ZxV26uGTZd2DxHL+2Uc7KcjiIgV+CvJ0KpGiGIDKLUJuuxswUYpKbvldpIQE
         o3sgbm0g8R/EVdh5/II4lCaZReN+loiIpx62yu7/Y1Mnm8mad46gkOwF+7SAkijNJW4l
         p0qw==
X-Forwarded-Encrypted: i=1; AHgh+RoL3NCNCvE3rh6TMRXOiqgfkDJNnzpkuKq7YX16d+ZKkvjZvBaIUC/4EFheprKtLkLn8PtF7tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaCrMF48UICLcvK81ZcQeTnBiGc9LhS5osz9Sr06ztUISTSIFw
	sP1WBUVmhXPXxUBNS3AuS6YxX0JGUtDeAaELCExkt0sV6bZ4FZt3m11a
X-Gm-Gg: AfdE7ckk0/eu9W/BgZuwlSQsFSE8HGzNK3gzTr7/goRGfNB3Wa+BGnszM7XkJv3Sm9J
	e42Nb9d+/r6usSmisbYxuUQ2YbCXGmhEaB9TUCWeDn+AyGXSKML8QrHvRralfD/nrhNQ73UQ8Ih
	VNCFNDbgh/njwmOjns1j688B+jitIXQNd4ukQfjGaoSUa9xZ302S1SWgK3bu5deGlWp641nMBJU
	nsd1WTRuO+pdNacfasN85jAp2yT1uAw41bQZ00K/C8eiOKpr40EYih+rbXoaI1G6Nk/gN404Zbm
	L6J+XegJ/56hg/ClrJtxaJP+rBrC6gLHoIsGLd7b+rrv0tbgUjsYexhredOInZiJVnJZDB1x7nA
	peDntwCrnZbznWLNwXQeGS6phxk4HU5CyF1YTiNz5ONT9wsZxk7PrFpg5du2yENs2wXqhzZq/rF
	VFo/UML16W9wCAdU6riYxAyNsxvx+njEHhq6zZzCZ75NVsUIRtluil1y+eSpsJKViWJtX/3hNU3
	gzyd8lz
X-Received: by 2002:a05:6000:26ce:b0:473:1706:7f01 with SMTP id ffacd0b85a97d-47df077caedmr1960726f8f.43.1783506230730;
        Wed, 08 Jul 2026 03:23:50 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm40660248f8f.36.2026.07.08.03.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:23:50 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 1/5] net: phy: mediatek: export __mtk_tr_write
Date: Wed,  8 Jul 2026 12:23:27 +0200
Message-ID: <20260708102341.53919-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708102341.53919-1-ansuelsmth@gmail.com>
References: <20260708102341.53919-1-ansuelsmth@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305748-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ansuelsmth@gmail.com,m:daniel@makrotopia.org,m:dqfext@gmail.com,m:SkyLake.Huang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,mediatek.com,collabora.com,vger.kernel.org,lists.infradead.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4F897243F9

Export __mtk_tr_write to directly write to debug register.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/mediatek/mtk-phy-lib.c | 5 +++--
 drivers/net/phy/mediatek/mtk.h         | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
index dfd0f4e439a2..78b998af5238 100644
--- a/drivers/net/phy/mediatek/mtk-phy-lib.c
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -36,8 +36,8 @@ static void __mtk_tr_read(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 		*tr_high, *tr_low);
 }
 
-static void __mtk_tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
-			   u8 data_addr, u32 tr_data)
+void __mtk_tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		    u8 data_addr, u32 tr_data)
 {
 	__phy_write(phydev, 0x11, tr_data & 0xffff);
 	__phy_write(phydev, 0x12, tr_data >> 16);
@@ -45,6 +45,7 @@ static void __mtk_tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 		tr_data >> 16, tr_data & 0xffff);
 	__mtk_tr_access(phydev, false, ch_addr, node_addr, data_addr);
 }
+EXPORT_SYMBOL_GPL(__mtk_tr_write);
 
 void __mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 		     u8 data_addr, u32 mask, u32 set)
diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
index 320f76ffa81f..f172f7d671c9 100644
--- a/drivers/net/phy/mediatek/mtk.h
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -72,6 +72,8 @@ struct mtk_socphy_priv {
 	unsigned long		led_state;
 };
 
+void __mtk_tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
+		    u8 data_addr, u32 tr_data);
 void __mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
 		     u8 data_addr, u32 mask, u32 set);
 void mtk_tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr,
-- 
2.53.0


