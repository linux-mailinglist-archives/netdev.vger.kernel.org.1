Return-Path: <netdev+bounces-288641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HSWETaHCGq7twMAu9opvQ
	(envelope-from <netdev+bounces-288641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:03:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B03B555C391
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB630300F1BD
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 15:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFFA3E2AC5;
	Sat, 16 May 2026 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOITm0rn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB1B3E2ABA
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778943795; cv=none; b=Ky9AowENmL+L4OfhvzYw1dWjBUwNoNQ1VfnGEud2WDOLyaTxJQRIxl1Tv3cJr230TQ+HdwWoImEjNoVbGkTRonGiWNdzZAfFy81nmCg6y5Igxw2zUj5p7mEQ1mJMo5QEnuXvVLg4i4XGQ9PMVsWzd1fDYLCCwwKvqijc/cygwVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778943795; c=relaxed/simple;
	bh=QmkJpHUldte/egmuA7DGybI2tVG7cghkcZq8VmZIces=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pK9Zs/3D9qIu93xkgq/ehQoWEfgPc6vVlRlWaJ8oDRuvLSIP4QvQ8qUGq/tmOoS2XnAOw8B+1prMnzCcyc9d1q4cL0pMGSx1xv2q0v4P0czgXI1lUY46jKVbgMUQYZ9ph8zwdJO5xEzLgs7sB39Cc0ee0ZGZdiJ9tLjJd2i9HYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOITm0rn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bd4f8260e4eso189340066b.1
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778943791; x=1779548591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zxxDjL5gnnI2uwzrc+KACxtlyJsnDYW3Yb57xozjSks=;
        b=bOITm0rn8gqxIeMDd3KMioNG9rgbxyqM9xpgEJDiJ1GF594FuruJ08UKdFtbYnZaZ2
         KLeUP3ZhQD9+UdsepnT9gM4GJWSo/IEdWbiS5T2xJnqKce1rJHSCLHovwaa24xkFHwM5
         fUil7fCpNBVavaU8CiTWKpnJKsl8rmcegsAs6KqF1UAm0who8+41zdwvx03JMFEIsLKF
         2fUw378H+couxZhoFxMJTBVx2+Vo3HVmdAT6eTHcObjX+Gqs3qSrrQ6RuifepZY6Yayn
         nvTiryJfsJ8Utvbx7K9Orw76xSEC3VR0sAVjhf9o463eH6Hy8eF0wvtCSRzeRYv93sDI
         CA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778943791; x=1779548591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxxDjL5gnnI2uwzrc+KACxtlyJsnDYW3Yb57xozjSks=;
        b=c1WUhVNt+3Qb7S3P3yHD+7+Ii+cvNa/bEyylQQLkPPSg8nkPVI0TQt1ZPBagtDdF70
         bZyEOSvCdxNHVFPmpmXyMCGFmS+Dd8WO6z2L9/L06TUaI/jv3tSKjw3SJiwpCwrq50PI
         5e542UIGLKg9rmQOucIdg1RCIqYhqItT4kQ6ClZw6ZjiOdOf2SvratduwNWPIt0JGFFr
         zHCBdWKThd49k8xh8blQFAIDl3ZeacB1isCk1mjS6COYKrCgPboFtXQF7SXNOxWbg526
         a9nstU46SUuP6BY+zwOoDSCfKuXx0pywV17Znxw/DYo13fd+ghAILYi+sVsaadd8uaNf
         vnHg==
X-Forwarded-Encrypted: i=1; AFNElJ/q2xyifWqhNWVs1r2AIJjcDp8OzQvIY1GSvJI1X2TZyp92iHl4BqXmklyTQhKrgYqJo2ALjZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydrhLsc6ZoluDhENvbCl4NKEzsYmRkBto16S7QjNH2XApeVigJ
	d1A1vxkjhdnz7eMq/xCyut76impbLSbVpKeYmKQ8SODfei4+kmC2h3A=
X-Gm-Gg: Acq92OGwd9BLMKeuuPyBVWt2MkA/zYmwJ17r0dNbnddyOpY28v1ncIdmh4OY1vrmjNl
	i7bH0il7FwiGaWpT9mY9KmLtes61bMqAzrKVQmfar+dw2IpZ8NdmFmxj7Fx3DDt7ZHDcWFt+LQh
	bK7HVEWEWK+N5ilpnyLbP5EAFIRML+3XIKRiHYTsL2hwaykwKFCqdZRKgdEQXBaRIOTmJP7mfJ8
	pBDRpps24T9gRMwNUlw7g19CYhR4mWDZMSjkoykXzeoWeFNlVn/474Vq7kNw1V2Pfgng0Wz1ovR
	lRgqWbfXZ4KZRdlt3BLAUQoej4SY6+UyX2WOPIAthyW5U6Fist2QOcTfGUCYpqqxPR2G6V2Mb3H
	chVvmVIeZrQ6n9cDMVsp38g1fM3OjH7LtDMaoJUteONpV+9N1xKVRrRYo3rJ/PI3Di9UHaFWZLF
	l9uE7KQP7BKA7RX/F77nFrwnRnvPL9axkQASVcsVQAM8mKOJUOuOS8z83NzhpB33tCXnAASS/qo
	jCiZTPkjhkD669fn9YSrkkeNYOC2Nz0/6n+j3eXoic=
X-Received: by 2002:a17:906:f59a:b0:bd4:6c96:f87b with SMTP id a640c23a62f3a-bd5178f913bmr453717966b.28.1778943790650;
        Sat, 16 May 2026 08:03:10 -0700 (PDT)
Received: from nn ([2001:1ab8:1003:0:5454:f357:ba89:4e22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b3e8fbsm3313946a12.2.2026.05.16.08.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 08:03:09 -0700 (PDT)
Sender: N B <gen.benner@gmail.com>
From: =?UTF-8?q?Nerijus=20Bend=C5=BEi=C5=ABnas?= <nerijus.bendziunas@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: phy: skip EEE advertisement write when autoneg is disabled
Date: Sat, 16 May 2026 18:02:51 +0300
Message-ID: <20260516150251.879680-1-nerijus.bendziunas@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B03B555C391
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288641-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nerijusbendziunas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

genphy_c45_an_config_eee_aneg() writes the EEE advertisement to the
auto-negotiation device's MMD register space (MDIO_MMD_AN, register
MDIO_AN_EEE_ADV).  These registers are read by the link partner only
during auto-negotiation, so writing them while autoneg is disabled
cannot influence the link.  On some PHYs (e.g. Broadcom BCM54213PE)
the write nevertheless reaches the chip and disturbs the receive
datapath.

Concretely, running

    ethtool -s eth0 speed 100 duplex full autoneg off
    ethtool --set-eee eth0 eee off

leaves eth0 with TX working and RX completely silent on a
Raspberry Pi 4 / CM4 board (bcmgenet + BCM54213PE in rgmii-rxid).
Switching back to autoneg recovers the link.

Prior to commit f26a29a038ee ("net: phy: ensure that genphy_c45_an_config_eee_aneg() sees new value of phydev->eee_cfg.eee_enabled"),
the disable path was effectively a no-op because the helper read
the stale eee_cfg.eee_enabled, so the underlying PHY behavior never
surfaced.

Bisected on rpi-6.12.y between commits 83943264 (good) and
effcbc88 (bad) to f26a29a038ee.

Fixes: f26a29a038ee ("net: phy: ensure that genphy_c45_an_config_eee_aneg() sees new value of phydev->eee_cfg.eee_enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Nerijus Bendžiūnas <nerijus.bendziunas@gmail.com>
---
Changes since v1:
 - Reworded the inline comment and commit message: the MMD AN
   write is read by the chip with side-effects, not silently
   ignored. Suggested by Andrew Lunn.
 - Tightened the reproducer paragraph (was repeating paragraph 1).

v1: https://lore.kernel.org/netdev/20260516114334.812828-1-nerijus.bendziunas@gmail.com/
 drivers/net/phy/phy-c45.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index d48aa7231b37..126951741428 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -940,6 +940,14 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_eee_abilities);
  */
 int genphy_c45_an_config_eee_aneg(struct phy_device *phydev)
 {
+	/* Writing MMD AN advertisements while autoneg is disabled has no
+	 * effect on link-partner negotiation, but on some PHYs (e.g. the
+	 * Broadcom BCM54213PE) the write itself disturbs the receive
+	 * datapath. Skip it.
+	 */
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return 0;
+
 	if (!phydev->eee_cfg.eee_enabled) {
 		__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};
 
-- 
2.54.0


