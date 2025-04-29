Return-Path: <netdev+bounces-186848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADABAA1BFB
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458EB1BC08AC
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAECC270EDB;
	Tue, 29 Apr 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2h1M0uk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D2126D4D5;
	Tue, 29 Apr 2025 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957859; cv=none; b=jAPnpA9+A6g9kbLxkbQrbU3Rc+8criN5VpBmCnOLkbawiEj7RBx86AS37vtNw+vGXJs9e7okVtObRfl5sQCa/E5Dsg7xvK5uCfbBsZTb/72g2c47RbvwJS6g5xhme52sOKoaaj7x00e7LhVOZOZydMElXuD3gpLHg8TQtPnpifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957859; c=relaxed/simple;
	bh=OyfoL4dg4jOrrHgAB98UspsGy9e2jurahMZb59aN27g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRkNOIaWttY4cWfvRsF0KOEldsDVNko3ldzZrdEPmZXA+JLORBb6ZTDiiBJ7YR63PHW3oZndV5cJgY5m79SQuGp5lVq9r48HDW4dFcMzyIHsL5kP360y8Kg66C9XYhfr5nnA9gw3QwaKs6auv6WnwgYkb6Iicbdv+bMRsS3WTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2h1M0uk; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so10268636a12.0;
        Tue, 29 Apr 2025 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745957856; x=1746562656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YluLA/cjNdRsPKzNlcYRBddzxqszjgxx9cIg46mMLU=;
        b=J2h1M0ukouOP4GLgkjbcE0EfRz6yN2SSXT4UsXMQJZHKpmbcWnjySIzcdDQUr6wIBf
         +6nBXBPZ5AFjYOWKMhMgxz7hI6DCIStI71wYLilcPCGhTl3AweN1xP2xUioKuzbu4vDC
         0sBGF+T73nBkkAc4TQrxh1on/QrvWh2ZGxOJ/GmrreVcSK3LDxrTn1mM/08cfVWf13GH
         wVzsNU5m1+oZncdgSkyTvUqqwVXpZclk8TYhD7btvCAw3hgIJT7KWAr7cqZxHP+i3uWb
         UKvXonLVxgMWoCQN+nae+Rv3n9ia2hqbXMd1ISBjmw3HbGfluArlvvefAxwLz1MZC0c+
         PEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957856; x=1746562656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YluLA/cjNdRsPKzNlcYRBddzxqszjgxx9cIg46mMLU=;
        b=WAQAlw+dipxD9KnEwNU+qsnPI3lVcezQfn+PAMcqU/Zc2n0M0xjM30gn29dy4S/2K4
         ELNkCXmpCK5wo7+p7OVH1Cz8j+uKe402XHGb/birMrslzjDrsDNru3apvJgDhnaJh8j/
         s+Pb7SRxQtsUxXJLykpn6jlZRFVtN49ONoyUlRDxn7QSAYVXTOw7Ypfo5qZ3BTluh4vA
         dUVVd1WN8rGEw1QXLXeSB4OjdftHrygXQl3hHoqBERjBUrOLgbyOphvntWD+hcD0bqDg
         yyj5eAtBLO1j+pUzuLT0yU090LEICc7alIF4ef330lzlNtZtwFHUMPqUntZaOpJ78JcI
         wwDA==
X-Forwarded-Encrypted: i=1; AJvYcCUFSO4gMawM1/tGGbo2HGK51B/vuDkRxAcZWdvZ/xL88zAoyMza5ii5LwCkwMc0sqNRg6IRZP7sJtC1u10=@vger.kernel.org, AJvYcCUSqDAN/clX2cDvonGXx8W8CLpOWDfp/Xa28ZQ92ZIUk/RZlBNkgfrfkF2hr8RKuXAVAP/nXxpe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3eWm5YsaX4TL1RaksrC+xzBgQaWanUDlRzku5BU4Uqj9UyUGQ
	gGh8Qbt6HnBlFNFh1LvF8rF5aqNJ/cHuMwwCasVYjFuNZ8Xcq3Jy
X-Gm-Gg: ASbGncuHcKWv8Ma2uhjCiKVIt87wSCIbArVRtNImAAyl0JH3qTu4gbmpyHAW2912QXX
	2p0u8YCVjRMZkxvrDbIpoTogZnecC9gA87AaCHvHSQgB7cs5QjagrE1URzlkD/O8JdWxo3x9hcC
	bGe/AkEZ/yLuDg0R71QdsymETzPD5rst3gLJrxs97BFXcL8aKz89BnVgzZQO885rXdpmTWc7ShQ
	l+vxFFFbO3ECR5I+MPIqrGYg1SOGlElkUMdUAC8jfRFV41LD2e1lkjojfGfkYKq1IN53lcw6uWo
	NSuNpLF/wn3Y5fvMzlWtev96KicJqR8ZfYXMplB+o45Qx3Lij+36Tm/vcbl3Xa9v9T57LuJVXL8
	whkUBztavdULtOHcD5Ng=
X-Google-Smtp-Source: AGHT+IGHrAknJLWCPmutveio/sagjgn2a5P1tnFbq7zD6jMc6dYaoAYEfMo8PoPIf7dFuogQdh/iQQ==
X-Received: by 2002:a17:907:3e0b:b0:ac2:9c7d:e144 with SMTP id a640c23a62f3a-acedc734163mr69274566b.40.1745957855997;
        Tue, 29 Apr 2025 13:17:35 -0700 (PDT)
Received: from localhost (dslb-002-205-023-067.002.205.pools.vodafone-ip.de. [2.205.23.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf77dasm822417066b.87.2025.04.29.13.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:17:35 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Kurt Kanzenbach <kurt@linutronix.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 06/11] net: dsa: b53: always rejoin default untagged VLAN on bridge leave
Date: Tue, 29 Apr 2025 22:17:05 +0200
Message-ID: <20250429201710.330937-7-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429201710.330937-1-jonas.gorski@gmail.com>
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While JOIN_ALL_VLAN allows to join all VLANs, we still need to keep the
default VLAN enabled so that untagged traffic stays untagged.

So rejoin the default VLAN even for switches with JOIN_ALL_VLAN support.

Fixes: 48aea33a77ab ("net: dsa: b53: Add JOIN_ALL_VLAN support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index c60b552b945c..4871e117f5ef 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2021,12 +2021,12 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 		if (!(reg & BIT(cpu_port)))
 			reg |= BIT(cpu_port);
 		b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, reg);
-	} else {
-		b53_get_vlan_entry(dev, pvid, vl);
-		vl->members |= BIT(port) | BIT(cpu_port);
-		vl->untag |= BIT(port) | BIT(cpu_port);
-		b53_set_vlan_entry(dev, pvid, vl);
 	}
+
+	b53_get_vlan_entry(dev, pvid, vl);
+	vl->members |= BIT(port) | BIT(cpu_port);
+	vl->untag |= BIT(port) | BIT(cpu_port);
+	b53_set_vlan_entry(dev, pvid, vl);
 }
 EXPORT_SYMBOL(b53_br_leave);
 
-- 
2.43.0


