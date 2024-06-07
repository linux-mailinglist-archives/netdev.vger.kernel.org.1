Return-Path: <netdev+bounces-101694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A61C8FFCEF
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E76C28A87E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E912155C9D;
	Fri,  7 Jun 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G3oXzKi1"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3995B155725;
	Fri,  7 Jun 2024 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744737; cv=none; b=ZXVLzcBXLijLXCOk4dgITJYKd4X244iHKymuYRq10Ix+5d0H2zm/p21TKu5ZVgEKPJdy78q8SjQPSqZ9jA21hyflueO+QxItlOA5EI6B/0W5Ss2w2/EeqWWEiHIHrzh5Qd9g5qh273FzL6Ifz3deDw45O8hDvGYBOQCp6zU/OGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744737; c=relaxed/simple;
	bh=qT13R1OnRDV3a1afGQ4ExjF7MEbhuPvbGRFaRmw/X1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWSYuZS7OYyQITAYabnbgezZEAnCmHcgsbAv0EujyKRQiYL24KnNZvqg9wVLU5uhVQvIFH8QWmzapWOONaFuool+RrKUuxqCG5gu2I0MyPzdOfusxN0oJ4Os2rfYwpIb9/hUxmAov4bUy9uEsM6fs4EDe/jrkGtGMVxGLbXAXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G3oXzKi1; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D2A21BF207;
	Fri,  7 Jun 2024 07:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717744734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oygbDLiuF7e7Ih1qbHzskVfuqfjnaRNnv7o0s99CswA=;
	b=G3oXzKi1NP83QWjYbd+AIUGXEJz94nOD3DDKCDYjVXIOiOY9h/90Gy7U1MZAnMpdKCaQ1O
	n+TKnOCUwckuPYXJ+jzqpNk6Mw64kBgDCxPDq59HdqvhHsT5lRWdjcAXTuG6xQ9v2U8mjm
	ahWZRa6lEccb5wUrr4uAsZL2OuLqV8v+T4V9+pJF05LWeAf6+gEpKmJhWhIUcSzBmaDu1t
	Jy3q1NbBl0knGVl7FZjj3zVX6K3l1nycTbY76duJFmXhKUPwqBm368EB96fZA14/EgSo5H
	Q1p6yK+i+y5moy7FvPRTJRf+guigJM/QcGS47D9NeorblMk5A2rscYHUC4GF0w==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCH net-next v13 06/13] netlink: specs: add phy-index as a header parameter
Date: Fri,  7 Jun 2024 09:18:19 +0200
Message-ID: <20240607071836.911403-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Update the spec to take the newly introduced phy-index as a generic
request parameter.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/netlink/specs/ethtool.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 00dc61358be8..38c2ed0da739 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -35,6 +35,9 @@ attribute-sets:
         name: flags
         type: u32
         enum: header-flags
+      -
+        name: phy-index
+        type: u32
 
   -
     name: bitset-bit
-- 
2.45.1


