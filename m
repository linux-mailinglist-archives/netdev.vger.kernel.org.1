Return-Path: <netdev+bounces-277799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N85L8el22meEgkAu9opvQ
	(envelope-from <netdev+bounces-277799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:01:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3AB3E41F8
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05164302A53F
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBF4375F95;
	Sun, 12 Apr 2026 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djZqx/vD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187A30F806
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002440; cv=none; b=EV74wI2zCxTN2M9rbLfC4PiUdoSzQpSJj4WXNIgn0YzM4OGNmCEDVlllUy9fXN43VZ4upVkTRUinQvd9NLknjxWoKFNTBKtR094CJ0l8OqzAROxNMt9jXz2A5bGw6+FYl19aT2dsYlBS7/6OtK9Xf8EdYNMkpnx3i1t0Xd2WCfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002440; c=relaxed/simple;
	bh=0kCU53SzmV+uinnrkVidKHIPcWwqk66luWO+WnEojvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqpIdkM+4VeKSY/PierXyKkCyxTbrCiZCQ7vO3OjCwjw8cs2MdogX/rq/b8VCBZi10IpO2hOQyxCsdQ4wrg3fVPx/+OjXPJt26CfnD1vUZ/yAfr2uHp7b+plepZzlx1S60VUvIJgjIowRzNwrxv0g6+IUNtcm2eET6e44EhLmy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djZqx/vD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso43239435e9.1
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776002438; x=1776607238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIWV0wD0IVAod/dfAsNX5Qr54zSgEU8/W7tRZNFLB0I=;
        b=djZqx/vDe5Thv2DKY82iTkaU9cAkcWPQvWc4bWhja7r817oLp/YSNGxS3nw0O84FC6
         hZt6b7pCHb+vWOm7HSZQxlPaIdubIu0yOOTBOiacnV8XC1HzfsNcqUh0H3KL59Ro4D1p
         Mh9WdGLX5+ffSbT27xs6HjbcNHTohWdXWAycl0zhAlJ1kL6MFRaSgvAXDfoI2TdVIjoC
         fgEUkVtkP43QVLKba8MuDKkgldZJTYwX/lgMe/EhufTOOhLS4kAD9urVf2XZwNzHbPwF
         4JTcxBIYp3naWyIpYeqHmXEX6ByTDy/AkGo6eyHpbWKgDRTmVoSbj3RwF6uQQdI/ikDL
         fr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776002438; x=1776607238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jIWV0wD0IVAod/dfAsNX5Qr54zSgEU8/W7tRZNFLB0I=;
        b=E/BimaxgJ0Onu+67fUzDXIzvPp8LOgLYoQK9Gyv0lmsMBGn8m3645OyZI6J1GKZT5m
         YuV0D/tHxyW0Waeiv3mpj7FNLnbca1T7J+XllXjP3cRdmNDTSR0w0AqVxa5be7Tk/j0t
         zlNECkSl2JlC51b4imu80EDVWDpKLDINKyvx+wr3LjEeRFzbODKYqyuZ8qC1520n8tfW
         lEJ8fIiRT7zkmmnSEDHGx6ogBNTHjpyVnFJC03wPJMYRgWPKouHb9EFRaD4IO/IFiJ91
         nRIDlExL3KNgfKoFC2cP//Z+CNGedV75ODVeMFMc/NFN1GYZNXft2+sGYDCPxAjOsBwQ
         eEYw==
X-Forwarded-Encrypted: i=1; AFNElJ/avQiD7gE026vO5HT/fp6NjqTHXrE/YlH0Gyp4XT3HgKyP1mtPmsWcb72TfgwTmJPmFFHni54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcn50VE9ANxJpExXVcLlJurrvZfxT3gRYE+YnGZN2DODjrJ2KX
	7h8kiNeudoEb3KYDc7Vlk50GF2Alr2E0QJjXeKidwnxtt2R6qTJ9cZ68
X-Gm-Gg: AeBDiesZYVoY7JsdwXxM1Uc66QkB4aG8Sajr3vnckmrJCP/g7iu5HlRYrxqEzpDf93J
	GroyvQdI6eLg2qHg0JGwKVvRUAbyEIjevFOdpbrH5LKEVwjiY1qKkNLs8lJAwVg/seyUeqNwmjq
	z4hWiB5/eha1AZxbP8SpdWiH0EdYs+asrRhVxyVfd6+JV6dhFTvlX5STYnoWVlLIV2DRCLUy0TM
	SpZDRM02IvcCFCTkubj3/J6MwJuCPLlVhm4pzoMI6Vr595f8zd64hpbQ5LRa4dk3TX+YckulK7Q
	fDn2YAU3GmRL7Sgw4Qkxglv5koApqJiCma/WbvPxbSmKqNHX7S1A5UmtksAno5o/OMOe8dWWfPp
	a1q/W1UTgbWRL5nGr6XzHXBOf4ScQ1bxsy75DUCO7H/Jr1cjXRh+umVtV0pmPJ+HmDiJC8hmWo6
	ltLdCS2pQVAIscPTOBUQzCAaaIxDsaIGzHNG23y7xqY7dlHVdr
X-Received: by 2002:a05:6000:18a9:b0:43c:fd0a:5c6b with SMTP id ffacd0b85a97d-43d642bb025mr14837112f8f.50.1776002437560;
        Sun, 12 Apr 2026 07:00:37 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:6956:2074:5220:4650])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50015sm26127538f8f.27.2026.04.12.07.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 07:00:37 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v3 2/5] r8169: Drop redundant phy_init_hw() call in rtl8169_up()
Date: Sun, 12 Apr 2026 15:00:24 +0100
Message-ID: <20260412140032.122841-3-biju.das.jz@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277799-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,glider.be,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 6A3AB3E41F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

Since phy_resume() now calls phy_init_hw() internally as part of the
resume sequence, the explicit phy_init_hw() call immediately before
phy_resume() in rtl8169_up() is redundant. Remove it.

No functional change intended.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Added the patch into series
 * Updated commit description.
v2:
 * New patch
---
 drivers/net/ethernet/realtek/r8169_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 791277e750ba..cb22105f323f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5032,7 +5032,6 @@ static void rtl8169_up(struct rtl8169_private *tp)
 		rtl8168_driver_start(tp);
 
 	pci_set_master(tp->pci_dev);
-	phy_init_hw(tp->phydev);
 	phy_resume(tp->phydev);
 	rtl8169_init_phy(tp);
 	napi_enable(&tp->napi);
-- 
2.43.0


