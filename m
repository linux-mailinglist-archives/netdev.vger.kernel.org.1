Return-Path: <netdev+bounces-124831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C470096B191
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA021F26F2D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 06:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1EE13AA41;
	Wed,  4 Sep 2024 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcOaYKve"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA48839E3;
	Wed,  4 Sep 2024 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431281; cv=none; b=kH+X3R8W2osgmJS1AcCaHUqsuo7GvdJ4YuUdGhhNaP0Ilop3ffMnI5cQQd/og/5KRcti6xmXiWcyg/5xhn9sH+YZoN7ZlCFLQzVbk/g/R8KNvuU5KXu1Rl/JlQRPP7n5pNqN4YyrwXxARCmRN+wIGFP1jDQVL7SQ25yHoUYFhno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431281; c=relaxed/simple;
	bh=KKvHqt3siS6yomCisTHDJUcUhDzuy3LBBgDMRQ4k+Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rd6R/FkbTB4vLQVbsAoVJpznoH3JISJ6LrW9K/blUYu94qc6VX2NpVpB0Ea9hW2ly/amQo0z3Zbgz3sgkcJaqDiEP4JWpWIH7FXCvLpD+sm4nplWoWYGqOlbn+HVHtk2ZI6GL5N/3EUOeNuSYcnptpCAz/jHt7XPF6ZOE0tgGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcOaYKve; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a86984e035aso756639266b.2;
        Tue, 03 Sep 2024 23:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725431278; x=1726036078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XndFyI8puSjAv9/6vHD7/Fma9yvh6kpyB+LRqezDNzk=;
        b=WcOaYKveycOVq3BYzo/ugqI9aAKPKRjtRLAm8d5RbBBOfHQqQMppEkMdZTgn2jGCpN
         R1PCMawkXKSPNVUG04ZL9R5/2fP6HKMzqb1EJasAbM+E2Dvgiy3YlTwNoN6fFrHU99Nj
         kyee8D8dpG1NcwVFLKE9kzKR+unVdN8rBQ7wOW7/2KYaZzij/aNfvQ1+662RSnlzaX/F
         Z28BT9rIH+UdK5MSPbeSoqHOGjB2g3oDu5OLUJiWPmKYqLO70o/uDZCUKeSVecFdbaBk
         rqzEurOaS9QWHmewobeSP8NcHS/KLmlpy23SmFaNTbvmI4smhksBF9z9VjuDNcfvUKS+
         PV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725431278; x=1726036078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XndFyI8puSjAv9/6vHD7/Fma9yvh6kpyB+LRqezDNzk=;
        b=kkmV6StiwMm0BLGgEdob0fWtjEnAa+F0m2tZ5pI+NHSPDUzTnVYnNxyjXxK7K+wuXd
         ED4RwqoqmminMm0YxR45LJTTHQK2OQTspbB4avA/n6jCbfoN51yXKMxvrUbGPJwDi+nL
         FTxL34pAEwgIC0heGsbB2xEZWhk/6U9ir4rkqG/7et9VochFoa8g+vhIlLy4YIDiIch4
         Xq47wIdgtCXLtalNRbgjhUyb4LhHca1YnvFej1TEp1fxUotgt3s+f36gU4q19F/a0ugq
         ao8c/ba0p2uM6WrHQt9+3a/6X41SdiRSDlGkPs6AwtSrath4h6Nv8yyGpIxAJ9MmL65k
         F17g==
X-Forwarded-Encrypted: i=1; AJvYcCXKMYS5lnAFRyGW/gmwFSFftBRVykByNO98LVotYHL5tt5uADi/AVccpyxtnb14hMcnWXLer6bW/cjhs8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKQD/o3nHhzwwd7TT8I5N9ykObRSj7KNxUNuJL3bvwWUqNPQpb
	S2QeAefpvd2nq3wEzvpOmoJsIp+b4Z5CP988eYEu3cDJNzA4iN88
X-Google-Smtp-Source: AGHT+IGqRdhlSbRBFRUDFkNS9/prBBxbHcHxOrFcquStHEOeY4xfizmbi3zAqf7gQMqVc5WNOUo7lw==
X-Received: by 2002:a17:907:948b:b0:a86:c252:aaa2 with SMTP id a640c23a62f3a-a89a379d069mr1190820166b.51.1725431278130;
        Tue, 03 Sep 2024 23:27:58 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988ff0465sm768659666b.29.2024.09.03.23.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 23:27:57 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Arun.Ramadoss@microchip.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristram.Ha@microchip.com,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Subject: [PATCH net-next v4 2/3] net: dsa: microchip: clean up ksz8_reg definition macros
Date: Wed,  4 Sep 2024 08:27:41 +0200
Message-ID: <20240904062749.466124-3-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904062749.466124-1-vtpieter@gmail.com>
References: <20240904062749.466124-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Remove macros that are already defined at more appropriate places.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
 drivers/net/dsa/microchip/ksz8_reg.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index ff264d57594f..329688603a58 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -364,8 +364,6 @@
 #define REG_IND_DATA_1			0x77
 #define REG_IND_DATA_0			0x78
 
-#define REG_IND_DATA_PME_EEE_ACL	0xA0
-
 #define REG_INT_STATUS			0x7C
 #define REG_INT_ENABLE			0x7D
 
@@ -709,8 +707,6 @@
 #define KSZ8795_ID_LO			0x1550
 #define KSZ8863_ID_LO			0x1430
 
-#define KSZ8795_SW_ID			0x8795
-
 #define PHY_REG_LINK_MD			0x1D
 
 #define PHY_START_CABLE_DIAG		BIT(15)
-- 
2.43.0


