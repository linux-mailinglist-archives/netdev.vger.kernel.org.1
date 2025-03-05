Return-Path: <netdev+bounces-171930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA74FA4F750
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 07:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100651890252
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 06:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBE51F419C;
	Wed,  5 Mar 2025 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgOvhZbe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CAA1F4190;
	Wed,  5 Mar 2025 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156805; cv=none; b=NePqFMm0NbI14AHQVOJNIbuv1TY7MSQTiEkQpZt3EsMq4S0ECH5/K7tz8v2w5bjyrpn8RidsZ9n7rbgeI8HAOuMJWaOmzO2KMHFH7j/XLZJLxnDQgz1S2ZDBH2g0hXZ5dpIm7SAnaJc4ihHT1LGuR/pzs4QtuR70gVA9xBeJA94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156805; c=relaxed/simple;
	bh=kmVtyRIsp60GI1eJ+DXHiPcXJHc/x7HJlATseKAAuY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X10jjnlKkWwjEeywaHCkO0+c0V+sf/SSX3gjdo6G6WxCj8gnU2ODekXOfUD6IwEjgeCiUzvkg35iQP2cwtaoNPo5v+sIvY9htpWrkhnT77PX6URXYUYAM+dRvGTmJi9euXM+PsZameIbJAiHC8s5XET5pcOHWKQIXgQrJKvVQ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgOvhZbe; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c07cd527e4so578283285a.3;
        Tue, 04 Mar 2025 22:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741156803; x=1741761603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nls7kmdirsxklQsEsdMD6n3p+K9nTnYY1CAEZgsVHU=;
        b=GgOvhZbelLyEDO/f8MAjwWFtJaYIpll5cGosCdEDxvIYbhhrzkhg8vnsIaibKTiP1Y
         AiqRJoh1XkvQRk2BypuivVEhWNsK09AZg55AEanEB3IMBbPaH5/mR+2RgTnh+PIlcTFO
         2iHzFvBT0P9U+a98tzeutR7cgIIfMMdeFH7cYRe2s89bsMF+B3BQS2wAYKZr5MURzjly
         kE5SGaCpxU7gKpEfDj36B68ISynF9cNZ8x6xQ3b6C/c1l+KLzwzNcmhkIHOm90rt07IA
         8Qrnc4pIf1btI7R4wQ5FXeMEJSkvCkt5Vwtps7C+cBpZUrKk61eyVuL82+OfRLd5BIcd
         N7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741156803; x=1741761603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nls7kmdirsxklQsEsdMD6n3p+K9nTnYY1CAEZgsVHU=;
        b=dS13KC7ammxaQ8MgCDNX2iLrVBQ18NCJ/Pl9+cdLpjZWFNeErOJQ0QzfUX3FQQINOf
         4/kPGNN1FEZLyuXdeGApinAjTNJK4tokE8UNN3POOIeI4tUZ4Lappvl+//TSvVKiC7eS
         v8qdGc4ItB32fWKt8PGrlXZ5St1fBLhehg6/hPQrwYpEDurZ+UkyEqcegKBKln0rOOP2
         /6sFvbtBzDC4zF2mkIWGxkGo6UlSygxMMXNdmBVKDjvDJtP1YmpmKAMVBsxz/UT1Rj+9
         S/YvLv3N+OQyc9+jWaJtMOPhKGbB4jE2ZlUAdRP7m1Ms2qx6HEzvcIL5v9XRd9mz0DY4
         VEwg==
X-Forwarded-Encrypted: i=1; AJvYcCW320oGUmpXwJhU/E5UIFb+t8iuqVs47mfadbVu6g06Ww2/aR+h+3gRL89W/LuPGayQ0Ajq9h5LYG/o@vger.kernel.org, AJvYcCXgJPtqP7mcqOVQFs0NMK9swB19cCFp2Cg9+Yq3Hwig7idjAmuTo1QhnqUbSLPd6dIyvFBANCBL2f6+isRM@vger.kernel.org
X-Gm-Message-State: AOJu0YwBu7mhKWR3+vy3vro/mG7AEms863jpZCiJrbNSlvPTD0kepXpU
	qwlV6RKjhg4KpsmJh/lgVvwsbwePpGmurhP2SKtLzj6sBEqGxixn
X-Gm-Gg: ASbGncvbHUE2KsaYPwYgdWHqyoWrlMdTmRS9Qb6G2DMb3pz/ABiTg759eOC2ldJpUlD
	hvIgAvmWbdUzjov1YJ+OCbSfllFJp3xVRXykjTTn6YnuQQSmsyJgQ3xoUSUosm6Y+eTnCUOhUoL
	nQZeLUTl8ioRRyddmna7BvWAYIrL8XiiiqbfqG6XHgbC85ZG1qK2aB6VZeMQg4SJOjlpnPhXQDU
	dKpQGnJhdU7CVicFIVofnQU4tz/DKSiKq4inCMzrbegGqVzF3PoQClN6G+xNhquMXC1Q3Xs6kJG
	oIQHdU74SE9r+xZvGDpp
X-Google-Smtp-Source: AGHT+IHvjwxT5WbMC7jnX9jkcACdhgQLJENaJZs+PW3Nv5C/K/7SkZFAn2aK/Z5GNbzrtFbbjPi8Rw==
X-Received: by 2002:a05:620a:6288:b0:7c0:c2d7:5f2d with SMTP id af79cd13be357-7c3d8e7b411mr307853585a.28.1741156803205;
        Tue, 04 Mar 2025 22:40:03 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3b67458e0sm409029085a.57.2025.03.04.22.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 22:40:02 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Simon Horman <horms@kernel.org>,
	Furong Xu <0x1207@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v6 3/4] net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
Date: Wed,  5 Mar 2025 14:39:15 +0800
Message-ID: <20250305063920.803601-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305063920.803601-1-inochiama@gmail.com>
References: <20250305063920.803601-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "snps,dwmac-5.30a" compatible string for 5.30a version that can avoid
to define some platform data in the glue layer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 4a3fe44b780d..8dc3bd6946c6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -412,6 +412,7 @@ static const char * const stmmac_gmac4_compats[] = {
 	"snps,dwmac-4.20a",
 	"snps,dwmac-5.10a",
 	"snps,dwmac-5.20",
+	"snps,dwmac-5.30a",
 	NULL
 };
 
-- 
2.48.1


