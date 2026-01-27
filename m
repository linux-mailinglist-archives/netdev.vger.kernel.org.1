Return-Path: <netdev+bounces-254010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOXCJmMweWlovwEAu9opvQ
	(envelope-from <netdev+bounces-254010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:38:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE449AC31
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 685CB3015C92
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059802877E8;
	Tue, 27 Jan 2026 21:38:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F872C0268;
	Tue, 27 Jan 2026 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549894; cv=none; b=U/TV3pEspJkgzEck7p4kqMq5eVMEAgpU2mjJLTzREY/W2Fhdm/6bHr0vQHJ2OG1cUkGYh1f1SFuaIeXoRYHc8BouZm/mYDlf3dzY3Q3tsSJjlG6DrrqjA4t2dNwgIW5ISc5x3QA4ygEET9XWzTbuICjgSaFPsCCwCWPC0HYcU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549894; c=relaxed/simple;
	bh=qgLjxlGPE8LtstuKhRWvQBtnGI0E+AQpGe//Thhg+ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjhY+xvOR7KIDS5UTB2K7rk3RNiugPcrhke74Ds9Am+lSXwnxHvfZXqAplW+iaGuRslkuRdg70kWnlbG9wcxQ3jwjEr8iaXul15GJEXMFSEgAMZUjzVuc8Q68Z8gkv7zLcqNsB/dy7FLgC3AQAQ0J7Nmee3yY0iA3ZVq00FzmVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vkqlF-000000002w2-2zSz;
	Tue, 27 Jan 2026 21:38:09 +0000
Date: Tue, 27 Jan 2026 21:38:06 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v9 3/4] net: mdio: add unlocked mdiodev C45 bus
 accessors
Message-ID: <fc84a702ad97f651416b645f4f8bc1efc7f8d162.1769549559.git.daniel@makrotopia.org>
References: <cover.1769549559.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769549559.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254010-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,makrotopia.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FE449AC31
X-Rspamd-Action: no action

Add helper inline functions __mdiodev_c45_read() and
__mdiodev_c45_write(), which are the C45 equivalents of the existing
__mdiodev_read() and __mdiodev_write() added by commit e6a45700e7e1
("net: mdio: add unlocked mdiobus and mdiodev bus accessors")

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v9: no changes
v8: no changes
v7: no changes
v6: no changes
v5: fix indentation
RFC v4: no changes
RFC v3: no changes
RFC v2: add this patch, initial submission
---
 include/linux/mdio.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 42d6d47e445b..52d94b8ae371 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -648,6 +648,19 @@ static inline int mdiodev_modify_changed(struct mdio_device *mdiodev,
 				      mask, set);
 }
 
+static inline int __mdiodev_c45_read(struct mdio_device *mdiodev, int devad,
+				     u16 regnum)
+{
+	return __mdiobus_c45_read(mdiodev->bus, mdiodev->addr, devad, regnum);
+}
+
+static inline int __mdiodev_c45_write(struct mdio_device *mdiodev, u32 devad,
+				      u16 regnum, u16 val)
+{
+	return __mdiobus_c45_write(mdiodev->bus, mdiodev->addr, devad, regnum,
+				   val);
+}
+
 static inline int mdiodev_c45_modify(struct mdio_device *mdiodev, int devad,
 				     u32 regnum, u16 mask, u16 set)
 {
-- 
2.52.0

