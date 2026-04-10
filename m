Return-Path: <netdev+bounces-277436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBtIENcJ2WnnlQgAu9opvQ
	(envelope-from <netdev+bounces-277436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:31:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D7A3D8B13
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2083302803A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3673D3328;
	Fri, 10 Apr 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDREwrzt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76DB3CFF65
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831351; cv=none; b=S8lY3ik+qXS2QGPHY0aExe/VXbhm6R7m72qwGTAGTnU9J0B1yNt9cqlNGBCDwX8T7qC+Ezj9TTZZXy/WioRHiy6gUin7vIc51mzZquai+HIX3AK2CmOT2EbuLE6Kr+zTqFe4bX4+Z/RJO3L4kMxxnS3CiK+xYb1nCjx+0vIxM7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831351; c=relaxed/simple;
	bh=TEf5F57v7HEnHtXPb+hOYDZ5jDdp0Hf1213WKXRWpec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+ybzpqQ9zpZ9QFOpFZKIcNA4lppSSg6SJK4cgIKEbMcxet4lUEccGGyEUXFpTmEaoDCdAKzemz5IjhUWuiKDjGD0AdmKNYKkVQVAL/Ugp+Z7o4gTEp3+WJxHwZRe6Jem/ArsshKSNdZMjDZv20Y5avHpBWOuJFQDiJmEbVO90A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tDREwrzt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso1742533f8f.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775831349; x=1776436149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+pEe+gtdxvWjftA7HMrj78CByc1wgd3xl+mbsfpya0A=;
        b=tDREwrzt+BJDg+XjKWmRVUbSqCAO2s5tCmEDoKyq7Vw9jwo56xdlbgnpBpX9nWAsps
         10TocxSq3Ph/9AV0DlZQhOkj3RcfNe3KKfx/W/f0AWPQsRJkiSbIX0mKqJECcuTJ/4yU
         Mbbxm5pDoro48sfB8RzSEbxAC0Irho/IzqCz3otIWP+r0Xv2tx8Jm99ZtXeZtoV5v7sJ
         8dsIzIIBv5d4aVcbtkGkd/xgByfwUPPOdsSwQkJtq6Rr81arTS5iKwStmkBOAN6elZyg
         w4lFknzkPjMPSrx0+e7CvbEX/ORMizQeS9x3BHqty4K9AVwqKd3fEvpk95Iam5jQi68n
         H1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775831349; x=1776436149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pEe+gtdxvWjftA7HMrj78CByc1wgd3xl+mbsfpya0A=;
        b=h8+z5d84OtWe2Rs+wVwiHAbMcHLHfwFvtHEgbYeSStGwuI1FZnmkBAAuLQVYp7ghFz
         3kRskFUzVKPCHin7TZDPexmrcqt6YYzCcSepzm1M2VcHWVvn3bzMp/zG+WnqrdySoloN
         eQbtBcLsjmwg/dLjwZin32QGEAyV2QrIjWk3nI6jXWMPePePT9A9D4LLVaEmYv/wJ5eO
         r+dts3QnlZZzIJfDwCGT595B6tkJVU1aaeVwPfv0xo9YMGLanrYM0sRiOB2JJt762J62
         /yiJrw8gp10djbt2EXn8uSWrX3hkaR2P+LoFApXFkcwoVv+K9ucpOv6R4wdrfZ3kbHLs
         Almg==
X-Forwarded-Encrypted: i=1; AJvYcCWEVQ/RIahVapf1pyisJWZr5jxMQ0OmUOQ3CvuyrYXpFd84EswXD1wVEu1wWMVU/m9ICiTsMDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4Wf+ys/4oXtb2ZLNdSnCRqvPRGDTduXBADAE1WD3teksNJC7
	0gSvhwF+bWbWqgFqW/fNweb4w18JdNl4l/V0nuGsn/tu8UVFWxIJgYnZ
X-Gm-Gg: AeBDiettHPZqZhReb7GExEFNEU4b/cF7isg8O8APU7NWInpdDt4O2G1z/Dm1ZDGv/e5
	L92twRf7jFAj5lgkhl31fLSpenH7HlxjPJkkn4SuF6X1vwqNuIegs35lQVc9SAx9QxENt6rUf12
	/L93hI1uD3QfxsOs8VA6kwZ93OQiHnWfhsVEd1c4/NQazsYz6NL966ZmLoCfxwaM5DDjqWROhXi
	Zw8PjUVsZ0xSXR1QE6mA41Z7x2dagN7hjz3+nuNp6A2aIlq+GvBO4raE+fuFrq/75P2R0zjAPBH
	rIejYrjhzVfOUo26c4Gg7x9RcHSz2/lJSoMjMazgbp4xO7HlF0D2nS0bZLV9EdLzTbGTb6F7IMq
	aFBW35hodUQJOmxdviI/f0Qao3Ssr4B9CO2c11zlmx9Sb+euKbrA7ci/6qlqPCsxL2AdEKHijIA
	qW0Kqg/9jm0Y5BMmsx9F5ZXcbWp+HycRRj8J0Q3pv4D+Tu1GOr
X-Received: by 2002:a5d:698b:0:b0:43d:68c4:df0 with SMTP id ffacd0b85a97d-43d68c40e82mr725167f8f.10.1775831348892;
        Fri, 10 Apr 2026 07:29:08 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:2bb2:802c:245d:23d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm8389818f8f.35.2026.04.10.07.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:29:08 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH net-next] net: phy: call phy_init_hw() in phy resume path
Date: Fri, 10 Apr 2026 15:29:01 +0100
Message-ID: <20260410142904.439666-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277436-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[renesas.com,armlinux.org.uk,vger.kernel.org,glider.be,bp.renesas.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 93D7A3D8B13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

When mac_managed_pm flag is set, mdio_bus_phy_resume() is skipped, so
phy_init_hw(), which performs soft_reset and config_init, is not called
during resume.

This is inconsistent with the non-mac_managed_pm path, where
mdio_bus_phy_resume() calls phy_init_hw() before phy_resume() on every
resume.

To align both paths, add a phy_init_hw() call at the top of
__phy_resume(), before invoking the driver's resume callback. This
guarantees the PHY undergoes soft reset and re-initialization regardless
of whether PM is managed by the MAC or the MDIO bus.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/phy/phy_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0edff47478c2..8255f4208d66 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2008,6 +2008,10 @@ int __phy_resume(struct phy_device *phydev)
 	if (!phydrv || !phydrv->resume)
 		return 0;
 
+	ret = phy_init_hw(phydev);
+	if (ret)
+		return ret;
+
 	ret = phydrv->resume(phydev);
 	if (!ret)
 		phydev->suspended = false;
-- 
2.43.0


