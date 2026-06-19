Return-Path: <netdev+bounces-300569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IoXjBpKYNGp9cQYAu9opvQ
	(envelope-from <netdev+bounces-300569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:17:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7566A3866
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:17:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qruiG3Ym;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300569-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300569-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E48D2302D747
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5333C314B63;
	Fri, 19 Jun 2026 01:17:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9E2D6E72
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 01:17:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781831822; cv=none; b=cUk8Vqw6a9iamvNgk5f5Qhuws0nssRkQ1/K/N9cJPXNyYrVIrq7CVIe6O1i6dGLysvwtjxJnHEWnqgvcnNZMjjosPH9VIq5P1KjL5ohmWuk6fHRDpkj12fiEH8Thb+wHpTlb3lhxPquPFC6RgwNUPTlFVl7bAsPHBflDGGNocfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781831822; c=relaxed/simple;
	bh=yS4zke65y5xtPrX7fIX/gUvyCzyJ0GhsMJGZ2zYTxmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmG1GNcCO6dg+nsgLp8HEwtykt7+oy5HV5uDgvbte73+YPed7WIgz+hpGaL8EGt5NIhJ04Jro8zm0PXZSiusRiV6/cMpFYcvxCnOe2qbfQK2hyP2W+Tj8db/7rJlPI38DdtTTY1nHGzSrQE1GPukDx2+Sow/KCavPoNDrGX9RzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qruiG3Ym; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4629051c946so1283703f8f.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 18:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781831819; x=1782436619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LrkXLS89dCgYbD658RGV02w/lCW6GVeMxe/xQguIcXY=;
        b=qruiG3YmcgKuJDzdeCbLDPxoaGYzn1iD/iKK4o+sevfmNHnvsPGtv1UeynuF8OB1H5
         Qkl0by5qJolenavfUuC3BwJWYzHQTc3Sl0M1Fc7WjpB7UDvLCNuK1pCbFL5RgbGcbMOL
         gnoHP0Yew2fbgXv3Rbv9xPlRKFm8QzSZjlP1racH3MVlIRBD8T1oBdSMEQvvMV9zDeoM
         s+j0h+V7pchLrRq3lMHRH396gRbR/D2YNnFFbS21y+eZbljUpOav/6WGp4GYjyNkB1+O
         Q2kvEdLriHxBhB+n5bxLz9sCbI5XSel5lqSkShmoeOQPWCKKObS5SG+/n044jnFMybp4
         Vtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781831819; x=1782436619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrkXLS89dCgYbD658RGV02w/lCW6GVeMxe/xQguIcXY=;
        b=rJCo1tLf3r2z/FvqSJLGkk/h1T/WA4IZbHZiwjoHT9wi/UmiR1CYxAeJBvFs4/r69l
         me1oRsAyO9shw8nVIOmYgeI58RhwsikVOSkdEt6pBQHpYzEO3byjKzoWdwbINvy1U+bg
         YMx8AwOYiCSWtRHvMoNFnMqultJPHBRjxRJjq7EcaBXbryGcFILhcvL+7b5pqjyFHXc3
         YYXdFe4Qn5pScYsLOzxcsmUL7/WjTGJpjJ+Fp5lsY/x0gQFVff2QPwp8E0HEpP4+ANRK
         Dr4uuNHsIvc07j7ATvkjX+Qo+viG34mzTjUSj+nwOXgf2wPmuskfODs9hp7+1xVGNnYE
         yFbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8KEDAs33ZDobutbQW1ZTmfM+mUYbOAmyGmpAk0j45X0OK88jOBpznCTnrWzfdOgdVO1kY+zmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVnEqdW9ce0dVXpXyUTpIlqd43NZTg3NDXrp4edlUCYF1YqCLv
	yQhwrYslSNoWk3XLyflK7LZxpiSBl9krVxXW6fcXwx7eGQTjKZqdd0pp
X-Gm-Gg: AfdE7cneDFAw/vS7pGRSZPIXILs/bFYxFY4cu8R0mc6UDOOSw9gP60MV0zK6UGSWhhM
	J4WvVTJnzyl9BMoZAikVdTxR4cNzh3aSQ6NDh7GvAl27k778pCamqbQNv/8EP/BaGluR7/lyY16
	AWZ9/d7JfcXRwrJf5fKAnsijq9ZDqpePKW1c0guFeTYk7/ILKQleJSBXJRnLSn4AhINHgYO0pyc
	w+Dd7ljDltQrqkmI57t4p6Non6rtG96QJFFJnYi/UX+vMVnEeWZKB6axu64MJm/bk3frZi5qM1y
	3jniPSnpL541MAzOrC2SL8C3UaJgVhZv0dhrr9FeZa27mRO70SC/eh78BhcHL3w4X/1thOhCwMK
	IQMCThH3lj6h2JC+yOekR+hDQIWeIRzJepfAI+QEuHrsnkERHUyP40imPOEaACerBIeSxveZaXy
	IPRHUIbASxNvoFYCV5JVqcC75o2zOJkK94E1oVbxgeeit/sQ==
X-Received: by 2002:a05:6000:41e5:b0:463:1d06:ab33 with SMTP id ffacd0b85a97d-4651e7b3a5cmr1806044f8f.27.1781831819067;
        Thu, 18 Jun 2026 18:16:59 -0700 (PDT)
Received: from cool.klos.xyz (ip-86-49-81-200.bb.vodafone.cz. [86.49.81.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650c114a50sm3998872f8f.33.2026.06.18.18.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 18:16:58 -0700 (PDT)
From: Jan Klos <honza.klos@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: Jan Klos <honza.klos@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV10G bit
Date: Fri, 19 Jun 2026 03:15:15 +0200
Message-ID: <20260619011519.50009-2-honza.klos@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300569-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:andrew@lunn.ch,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:honza.klos@gmail.com,m:linux-kernel@vger.kernel.org,m:honzaklos@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[honzaklos@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[honzaklos@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF7566A3866

On RTL8127A connected to a link partner that advertises 10000baseT
speed cannot be changed to anything other than 10000baseT as 10GbE
is always advertised regardless of any setting. Fix this by
clearing MDIO_AN_10GBT_CTRL_ADV10G bit in rtl822x_config_aneg()'s
call to phy_modify_mmd_changed().

Signed-off-by: Jan Klos <honza.klos@gmail.com>
---
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

base-commit: 7d8297e26b4e20b5d1c3c3fe51fe81a1c7fbc823
-- 
2.54.0


