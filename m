Return-Path: <netdev+bounces-278530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLJ6LvZl3mmxDgAAu9opvQ
	(envelope-from <netdev+bounces-278530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:06:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6393FC51C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06750300C6CE
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12502E8DFC;
	Tue, 14 Apr 2026 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gapp-nthu-edu-tw.20251104.gappssmtp.com header.i=@gapp-nthu-edu-tw.20251104.gappssmtp.com header.b="mNIcYH7Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8637E3EC2FD
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182768; cv=none; b=WyUj5vg1n9MSqVA1L9B4qToks3OQ/eUQmIHzFmWqcUT/9dzcLZAJypQ2JJAwmTmxmpRYv6HcOEoyqyslU66ZbIgnBEQpEQJZdPUAJr/nd/WjvAj0gwb4glRSLQ2Y0Qsb+5oyJjCqYsj2x8pIo5K/aZLSuDWSgZdWYtNGa2r3wX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182768; c=relaxed/simple;
	bh=YVMR67xoVmbo3R7DrrY3BFzqf9KvvM+PS24crAAoNl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KoiDA2BeNxh8oLigWh9L79vUWmI1juwatR5azZG0BYdkDiGnoQ7sMQntRclftQdVFHnbNDfZJ7DgabWBved9ncrVAgy2wKP8kI6t3WeioDKj7y/4tVb64khJm3N4vZ3tWO25W22ggojQLeKF33y4SbKamCAfZLPPvQT8ULFS/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gapp.nthu.edu.tw; spf=pass smtp.mailfrom=gapp.nthu.edu.tw; dkim=pass (2048-bit key) header.d=gapp-nthu-edu-tw.20251104.gappssmtp.com header.i=@gapp-nthu-edu-tw.20251104.gappssmtp.com header.b=mNIcYH7Y; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gapp.nthu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gapp.nthu.edu.tw
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-66f747175d8so2642903eaf.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gapp-nthu-edu-tw.20251104.gappssmtp.com; s=20251104; t=1776182764; x=1776787564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4UBYn3svCFaaDM96B1odDewTPxuO3paQeiU4LyqA9JA=;
        b=mNIcYH7Yy4/X39AdYrI0nJOeOBVnA+qQ90aawYSYfa3Q6FMDCzW1DKibWA+DdU3byk
         zyHpaKYJ+OYdAwXXs0Zoi/gG9CfRs4kp3tosjJ4Tzkd7LC79FiAL73I04ztzV4n2hQGX
         HOJGB2r+2qVVWZKsWAYZNu6OvrzPJzePKKp/MWWFOtZwnmIrfkCX5bdzmLbc1rHRz9q6
         HQ/SzG1q3p5IK9mrobBAc28GhzF4LXvfzkAaU99FUpA6ND8o4ovrQXNKVvrnmRHasfVC
         WaMheoe90tbtdCIYtngd2bzjqJiuxrkH4bUUuEiO0BC0gQWBuVw0tbXzHQv/ByWCokwO
         hjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776182764; x=1776787564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UBYn3svCFaaDM96B1odDewTPxuO3paQeiU4LyqA9JA=;
        b=FvvAKeRnPbHmPbuff41zV7o+ma6dsrN8zyVpIQXzsdFu/+jfD/QVGj4TAoNL42LZA8
         PjvUdrTA1EXCWcuDfN1B1hQkXyarC7T/fefzYidEz3oS9Y/77NAXocLAA4Blp/+8DuAu
         04sa/9/Z3zGbnKEbC9lM+Gfd2gQQziDIvCEgpLoRCggITYOMrwlTKuZXAw87JA8Vsk3k
         xqFCUvcHssfHAiW4ZdXd2YQWS2CJYr3E7RiQ+z9SoyUyMW2wjRA/mio15LE7SnK5R7QX
         vLIDt3K4FjyH/4U1WcFED1aJFeYvnEQ/8ExsYQx0NIbwGAivSwhq1FvFJ7P8ZN2pghUV
         wDUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mnj5zqkHv0QsRzdadtJZ8gvIGrCAg+W3YsnssG3Avz94p/KOzKYb5ruH+78eiv6gBCV0H/BY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxj9yCzUDtEoMC0OfATno6tCJFhqh0EiNfr9sGCrru+I9uCUhE
	DblFPU0jeGvJliZdKC5Uxup5qsYx+7ZdYGh4j7CJwMebfL0vBNdWxhRfjPM3psRrxWVb0yPLwfA
	puHua
X-Gm-Gg: AeBDievVZaEdL10x/GzYtwGyT8nS/P229aEtJjlptkAqjRzor5/sYyO8aFMOF5R5mQQ
	KUnIl60x/g/ReNrbjQBjice5ISy62zpTMks52mgTOlfNsTB/aExv71Ukz6LbbM3m4phAB95N9d4
	DUS+orF9xag6IUU5ecY1ro6BoASZgBzE9t3rkeWJ+D1fWIOCZWgfNTVvzUjpMn4Z2O1Ndd+KBin
	gZTv/mnO/Ivy3lwaSh8LC967MoREt76QAsYnVIKdtpr/P5S9w5yvCfLanR6SJXpKaSDPoEU/sUl
	3DW8UWUPEWTkTWL+bcHv+w0c+hkbGIJFYn1b+IaomZ+1afjNkg6NrMDJki0V2SPkdkBmjGTMD7+
	yF7QkdkquLKWVSy5G/+kc2SCJvRPJRGh+JgvsfK+vEhUQUwwz+eRLocVRn6oGT3icdPcgfsyw1+
	eu4NLOrUzqGcKhbli+3/U3IkcmOJtcq9PpIiCXnlgzYrVM6HjYmf1N9O4F5arbn+Bur+nA4EcW8
	ig6/aaeZuoebg5e7xy61GZ8S8bLR6XHAZ1jhuuIMaGKYXnXLmmvTaiaM7AVeA==
X-Received: by 2002:a17:90b:33c6:b0:359:15c8:e8e1 with SMTP id 98e67ed59e1d1-35e42847a4dmr18364845a91.25.1776182414866;
        Tue, 14 Apr 2026 09:00:14 -0700 (PDT)
Received: from tomato-cultivator-HP-ZBook-15-G6.. (2001-b400-e3db-6de2-a44a-781e-0066-b370.emome-ip6.hinet.net. [2001:b400:e3db:6de2:a44a:781e:66:b370])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f2af90sm155794145ad.64.2026.04.14.09.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:00:14 -0700 (PDT)
From: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: edumazet@google.com,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
Subject: [PATCH] net: mdio: octeon: use %p for bus id
Date: Tue, 14 Apr 2026 23:56:52 +0800
Message-ID: <20260414155652.7468-1-ku.loong@gapp.nthu.edu.tw>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gapp-nthu-edu-tw.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nthu.edu.tw : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,gmail.com,armlinux.org.uk,vger.kernel.org,gapp.nthu.edu.tw];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278530-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gapp-nthu-edu-tw.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[ku.loong@gapp.nthu.edu.tw,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gapp-nthu-edu-tw.20251104.gappssmtp.com:dkim,nthu.edu.tw:email]
X-Rspamd-Queue-Id: 0D6393FC51C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace %px with %p to avoid exposing raw kernel pointer values.

Signed-off-by: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
---
 drivers/net/mdio/mdio-octeon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-octeon.c b/drivers/net/mdio/mdio-octeon.c
index cb53dccbde1a..c9c000bb0cd5 100644
--- a/drivers/net/mdio/mdio-octeon.c
+++ b/drivers/net/mdio/mdio-octeon.c
@@ -38,7 +38,7 @@ static int octeon_mdiobus_probe(struct platform_device *pdev)
 	oct_mdio_writeq(smi_en.u64, bus->register_base + SMI_EN);
 
 	bus->mii_bus->name = KBUILD_MODNAME;
-	snprintf(bus->mii_bus->id, MII_BUS_ID_SIZE, "%px", bus->register_base);
+	snprintf(bus->mii_bus->id, MII_BUS_ID_SIZE, "%p", bus->register_base);
 	bus->mii_bus->parent = &pdev->dev;
 
 	bus->mii_bus->read = cavium_mdiobus_read_c22;
-- 
2.43.0


