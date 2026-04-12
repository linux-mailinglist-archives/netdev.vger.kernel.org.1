Return-Path: <netdev+bounces-277802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEogDVOm22nbEgkAu9opvQ
	(envelope-from <netdev+bounces-277802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:04:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 858D23E421E
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1303B3058E1D
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A38578F26;
	Sun, 12 Apr 2026 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGpQaASC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6A37C926
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002444; cv=none; b=OGQ8Y6n0sW1dRkimru3njdqOo+pqzshjKhzSmhId+a06rioFvNE9pRe74uJQnWVJTSeZrIvSZrK4Zlo8jrqmqiQUxcSxtC5mG6TVPtyFT+I4l0wdoi1KtDEP9sGHrYkKsE7p04GM1bzbkP1NpsVmfCl4cZwzpbJZTyC7XQoWEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002444; c=relaxed/simple;
	bh=zcEQ344RiBm7JrfsgTgQ4Lp6CjbZtUDRo6ogiL5TbHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdOJf+aDWYJ/Uskn/g97UQkSqEANi45wjd9MfvmAqxcuygc3DoCbJ05LF8yiRM5pGsIWsUzd7SZ6YYkmtu8LoV8UrjMaoTnhx6oktepNalAxzZwzLd11OilEeyy7Mb4bzG9uhHe/bXPzZic3qwHylUiWh6kswWVz9fsF2qao0aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGpQaASC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfce3a195so2198490f8f.2
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776002441; x=1776607241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNQ4/Bgols+4vK0uVdE0kuKThLWN9Gx/3rmL3xyL0Gc=;
        b=mGpQaASClSZZdW3sshx72H505xOtSaza6rn+UfaUh2aTggWGRAJRfY+vTSxOGuuxZY
         B6GOXBg+CcxaXmk7YkT6vy+d5Ms3EFQX4GoLtYeZg8EH8KgoLyPPDFDXolzzSbfNSXrZ
         upuvIPMVjnsJTu9XNPmD2K9JftY6pdro0I4j2LasfhE0bivVOnEWYIEGpnBY9o+MFc4j
         Z35+8gJuHvVQCJOSOPIwTRED3MhynjnpW8rSGAqTfciFNSOj3nX/1NUEuu/9gG7oj9nE
         nUMouj/iQjrYpojI7ta/D62+I2x+jOcUKoLUbtdfpLBWZS2U2jgmKyfSfvFa8eaHo6Q9
         lfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776002441; x=1776607241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cNQ4/Bgols+4vK0uVdE0kuKThLWN9Gx/3rmL3xyL0Gc=;
        b=Ww/8QDgQ6t7ZFKVqY8pp9VkK+YNIVfJVGnOrOPPua0kdKppO8XYvvvi8GJA8A0o75H
         vSNeshMMHU1LnI5AG9dDseXEbRCaHl0W2mfTesfzFr0X3ijLz2laSO0Eky1LQx3WapW2
         Db0vyFKtK2xd8zYG3fHiWuVLDgBe/ITJPX75viC31HOf7lfTBAvOKVc9PtAOat32xnZL
         5or/igt2u2fBbgpXZ+4SPjaBMrSMmaeuu1mlUDbJcUvMAStE+kV2duJT0yXQObta1/5v
         6b9ODsz8i89rXSeFVBbzJepS1FCSWo6jJEq3uEuiYhuYeyM1oz7XVUq6n5Za5WucoOWm
         LpdA==
X-Forwarded-Encrypted: i=1; AFNElJ+UrVyL+xZYmRESGDg8d/bzpm3lB59PRpcaQw7pS9DIUmLELSPQUXkzDX6nfxyLrf31m2fG+Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKhWdNp/B6nPzTVzSTFiZhQCaBglLZy8UCJvbkk24YGbNXesPP
	4NBKqSV6PKofvQznnplbYrdSkqu/dywNdq0VOYy0XIjSysK57E3MzCeQ
X-Gm-Gg: AeBDieuKLL5yIeMLjL3mZnMNNZK9ikQSXlqfFk4Dvyedd8QzHd8297zCT9S67K7s8g4
	an2qRHP4k1JmwnP1UvVYHJQGapMieFkNBDnPDeYiXcRAb9ashK/UHgpwtBemrTik6VTzSCyUkup
	eGs/g/JCOnBfR1KoRWf3uEuSPLVP9mfI9G7YCBDfSbvE0jSEOW4DQSnYrp3h+UdZeHPmVzMtePD
	GhH9oHZzqDPAvh/KfpaB78pwnXOVEDQtxs+8DVCkJm/85G9oBujPO/goXA3uRKdf0cn15SmyUiL
	Wi8XVhnn5i70T2XA8WQ6o1ianphp7tmivxuKDqoxJJUrcOel4yEzgYIGr5rGQQybBsMtvI2Nt9b
	fSyFgICyLv6FH0F640weGX+ZHEyRWULY6yHTBHaHrKPYQBvjnY8yL97JFY9kEynb1cGwXzpdTQX
	q8Q1Y7Bz0arX31Vc95oUStb0N7njpIXs/hWlvpmFd57EeTJPSCi7Q2mxSVwxo=
X-Received: by 2002:a5d:64c8:0:b0:43d:76b0:78e with SMTP id ffacd0b85a97d-43d76b0161cmr2231826f8f.14.1776002440962;
        Sun, 12 Apr 2026 07:00:40 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:6956:2074:5220:4650])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50015sm26127538f8f.27.2026.04.12.07.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 07:00:40 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v3 5/5] net: phy: Move phy_init_hw() from phy_resume() to __phy_resume()
Date: Sun, 12 Apr 2026 15:00:27 +0100
Message-ID: <20260412140032.122841-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412140032.122841-1-biju.das.jz@bp.renesas.com>
References: <20260412140032.122841-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277802-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,armlinux.org.uk,vger.kernel.org,glider.be,gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,renesas];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 858D23E421E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

Now that redundant locking has been removed from PHY driver callbacks,
phy_init_hw() can be called with phydev->lock held.

Many MAC drivers and the phylink framework resume the PHY via
phy_start(), which invokes __phy_resume() directly without going
through phy_resume(). Keeping phy_init_hw() in phy_resume() means it
is not called in this path.

Move phy_init_hw() into __phy_resume() so that PHY soft reset and
re-initialisation happen unconditionally on every resume, regardless
of which code path triggers it.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch.
---
 drivers/net/phy/phy_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 4a2b19d39373..16fc2fc63c50 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1999,6 +1999,10 @@ int __phy_resume(struct phy_device *phydev)
 
 	lockdep_assert_held(&phydev->lock);
 
+	ret = phy_init_hw(phydev);
+	if (ret)
+		return ret;
+
 	if (!phydrv || !phydrv->resume)
 		return 0;
 
@@ -2014,10 +2018,6 @@ int phy_resume(struct phy_device *phydev)
 {
 	int ret;
 
-	ret = phy_init_hw(phydev);
-	if (ret)
-		return ret;
-
 	mutex_lock(&phydev->lock);
 	ret = __phy_resume(phydev);
 	mutex_unlock(&phydev->lock);
-- 
2.43.0


