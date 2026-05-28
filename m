Return-Path: <netdev+bounces-292825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMSWHSSZGGr4lQgAu9opvQ
	(envelope-from <netdev+bounces-292825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:36:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 193965F7346
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B99C30144DB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB7A348C54;
	Thu, 28 May 2026 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obKU2iHD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECB632FA2B
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996958; cv=none; b=LwSdxedPwb7RhiNVR6WrT9yTVQg1LQrlAco7AmRn5GoT/QHHam8KYP/Cu1Wv3AENPc1zJHGkDgmffMx0UKQNvRx0qvs5IO+VDRS8cRuqnYb5M5i5SYHPuAdB5kUt255BvIoepBXgA8W8IoyqB2qPZbIxdBYur88HPJRmorr/7Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996958; c=relaxed/simple;
	bh=qMJ9GDx/LcLFtFm48POgp/hzCEGEIelLj9gHGm5a49A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YZl6r9njj4+P3yVuChPVnLTIoiAGczfDJYu5An7HzCl4kLzAuR/fWGNXlZ9o2dNiVwziU7BxOdXQgyfR7Ntp1qx7aevw0PeF3L5yPKR7XCjmVwhmHZWNI6PXlnQsqGp24DtIOYxdO0rB4PWnOtQdc9Xndbuu+d50QoZOSHUnUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=obKU2iHD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45e7c636e74so7010659f8f.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779996954; x=1780601754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gH3EgIUi99kVADWBhwokWNF0lPw5gXQdjRCExyBDYMQ=;
        b=obKU2iHD2T/333GZMAA/qAxoIN/P4V9FdA+uxCTIQsYDR5voJ8S2xHaQXh3xAWLadC
         jWXQ0pzqCxQRg0mDOddLu+zxC3sqxC3V99oRBBFDbbC5BxJWSaOMgx5jKDG8emM1gW0z
         fD2G97a2CmJNDCeaFxMmJ+EgAiKy3YfL8UWyUFq5n6kist4zoSXpAvHLj4XJm+sAFJUY
         8KzUvt1PJJ68Mrsu/dHSFuMFJsBPiPWAdhWe/fpiNkjtobjoNGqxbQ3Ytk99OeSPWikL
         tC53zypljOyjCSH9x4JajH4toEKu9hHdOOulk7dwkZQD4f4U26JPqhQ1Lq2rB71t4+8J
         CVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779996954; x=1780601754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gH3EgIUi99kVADWBhwokWNF0lPw5gXQdjRCExyBDYMQ=;
        b=c/DW03S1Qe/F+rZB7CUHai0O5IhDsZyvDkt0/voUFun3Rp3Et0eVnAGA+j/aXjRnp3
         L8PqHW5gnvnIjudEt8T8VtU60HyMitPwKwY4qJ0TnoIPgTd9k+dXwTwX7GFJyP8nRcWC
         knmIu7o0gav5x+2tNGAueiSiHw0M/xmOKY+N7C+a1tx21/JAlc4K8OO4HPxhwPiWlCa7
         Zj21ZoVJ7PtmXJXtmHLb6bVEOp6ic0+0eQjyxJtYAbHIpC/JO72+F0GxYLrZ0LxAo3s8
         yQhEHkCxDAr7M74Z4Wm8Bq8WVFlnOPkvdX3YPGxUoD1eQYmBskwyE7s5dn1A8DXMF24G
         gYVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nEq30imokeTH/g9+YjkV9PSZRpTwswr8JZx8RbhPPbB5/WNdiXp/adIlR9+0tBbaUwNuTQqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+krPHY0NEH4qmzTHc5CfAEQJL9of4gKvltyr3UUtm3meli1bI
	L+xZsFn50PmSBL/uV/zARNFcuIscnp/dmktbqrblQEOZqyXSOzzC3EN9
X-Gm-Gg: Acq92OHQpV59XM4EBc+kt03bRgwYQt2gysmDXW90XwNRE3YgKIoIcflXwSxzMnpupUJ
	cQDlljWasRvQQm7CsePig5CBJ1vhG7cJ7jMBmfdzdN69mAKm3U8ypt8+srAp55rYYCwHR5iupxO
	W5ysYDKHeAydYzdC+KMPCluBFLfliQ0AWW061pfQ4zCO1jU8OpJgeUjeg2iRp8dp3SV/rZZFRLk
	I0pZm973kBR7mh7/QX/K1KfMqThkk57paCzpMFJxCxaK6TcS7lqjAZsbVGcuqJgPPA1uTQfIMyu
	XKdV54+dr2XGqm1lvq2Zz13yCk1sMcQGGKMPD8czkMf4/3mpFyEExbYEsh7mPuo3QmH7SDCtSyz
	5hS7WpaIKzYTCE4COX/YsH7hnG2SdikdhV8Mh9HrENUxd+u6rQkhePzZ5PkE0aOBcg5ra80xoQS
	3lIFAAPIRynDkvP5prGaBq3FsJ8yFAbcTnM/FzELkJXy0LfKa2v0wp3ZE7ATOB9AWELF3Ndfkz0
	CQS58A=
X-Received: by 2002:a5d:58c8:0:b0:45e:da9b:97d6 with SMTP id ffacd0b85a97d-45ef05f25e7mr770631f8f.27.1779996954233;
        Thu, 28 May 2026 12:35:54 -0700 (PDT)
Received: from Ansuel-XPS24 (host-79-42-252-49.retail.telecomitalia.it. [79.42.252.49])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eec5eba06sm4220471f8f.22.2026.05.28.12.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:35:53 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/4] net: phy: as21xxx: handle corner case with link and autoneg complete
Date: Thu, 28 May 2026 21:35:41 +0200
Message-ID: <20260528193545.11160-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292825-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 193965F7346
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing case in custom read_link, when autoneg is started, autoneg
complete bit is reset but link is still not up.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index d5738117eca6..0db82da8dbdf 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -658,6 +658,13 @@ static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
 		return status;
 
 	phydev->link = !!(status & MDIO_STAT1_LSTATUS);
+	phydev->autoneg_complete = !!(status & MDIO_AN_STAT1_COMPLETE);
+
+	/* Consider the case that autoneg was started and "aneg complete"
+	 * bit has been reset, but "link up" bit not yet.
+	 */
+	if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete)
+		phydev->link = 0;
 
 	return 0;
 }
-- 
2.53.0


