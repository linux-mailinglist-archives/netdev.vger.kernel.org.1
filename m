Return-Path: <netdev+bounces-244055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0790CAE9FE
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 02:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC45B301840C
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 01:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4336E21D3F2;
	Tue,  9 Dec 2025 01:28:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ED416132A;
	Tue,  9 Dec 2025 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765243739; cv=none; b=fax7zEPCWRRbEwkvqDMdafXlxWpX9rQC+Dk7KeWEVMtOJJVX6wGkTL0VGsrzHMSWHxnRyYx4OsiOQ27gNYPzHa1q0Et4hXqXH+gHTl583XDSoKN9/0wOf9qeGTHuWQ3eJ2pmb/+2905fJUhvbA2KYbXWvZRNI6WZDBeRmdxO+Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765243739; c=relaxed/simple;
	bh=JrWuVqm8rMEyruWFvkdUXinjXbAbaKJCeQdFj8VUF/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFpUuOFna1+g7mMbrMVYtNY1MLgmCgkN1vyUYbiAjW1MVB7l1EKGHpZMqMzw7EbWULznoSpRwXk1iqtDdQDSypLDCeBqDWH8+30iJTuEqecdaA1k1tnZH1F02e9zNpMtFfGIuxxQbGGUbxnMLbgoQYCxAPCucQWR+tAqAT7omqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vSmX6-000000005Ak-26FH;
	Tue, 09 Dec 2025 01:28:52 +0000
Date: Tue, 9 Dec 2025 01:28:49 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net v4 2/4] net: dsa: mxl-gsw1xx: fix order in .remove
 operation
Message-ID: <63f882eeb910cf24503c35a443b541cc54a930f2.1765241054.git.daniel@makrotopia.org>
References: <cover.1765241054.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765241054.git.daniel@makrotopia.org>

The driver's .remove operation was calling gswip_disable_switch() which
clears the GSWIP_MDIO_GLOB_ENABLE bit before calling
dsa_unregister_switch() and thereby violating a Golden Rule of driver
development to always unpublish userspace interfaces before disabling
hardware, as pointed out by Russell King.

Fix this by relying in GSWIP_MDIO_GLOB_ENABLE being cleared by the
.teardown operation introduced by the previous commit
("net: dsa: lantiq_gswip: fix teardown order").

Fixes: 22335939ec907 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4: initial submission, not present in previous versions

 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index cf33a16fd183b..cda966d71e889 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -652,8 +652,6 @@ static void gsw1xx_remove(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
-	gswip_disable_switch(priv);
-
 	dsa_unregister_switch(priv->ds);
 }
 
-- 
2.52.0

