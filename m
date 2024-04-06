Return-Path: <netdev+bounces-85456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F69D89ACCC
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 22:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4561F21467
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 20:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE664D5A3;
	Sat,  6 Apr 2024 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lEGet9oK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8240BFE
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712434444; cv=none; b=rouFN3QBG/2ftFSjUs2TKN6PDEMYoPPI39mKQMmnwQqueDGReS0kdt8IdyJTLTyUF66D+iPhvAStnM9he7dvgLse7GRdpeJ11a9+3S94y246TyevIAQHys46jgFC1yxbCnwZ6hslzUqeLEcAyA8dE4SaOyluR6R5DuNG9ZCwY6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712434444; c=relaxed/simple;
	bh=dPK4yJ/wMTUGXfY11lM69yuurbQ4o+h92kvAzJWymQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4SD3Q4dyT7J332WdnTdFpMgSF5QAY42mN2oy5cXPDr5pfvob9c7Ev3eWtwTg00b7l6xy4YUlkc1oznGIl2ksFRaQ03mvXt+g6Wglo0R/wp6H+f19fZsNCPGX2mi3fh/sesqjcKX6dnfmicjA9gVWW4w99EJRj9grEXqcFUw0+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lEGet9oK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=l9yzCC1WmjUwoD3WEo32xMh7QV1dA91xU2AoG/lzElg=; b=lE
	Get9oKN/zOuw+AwAaOyeiKOyR1tjRoiW2q0ZbHNEvGQ+T/hXhYb8m57Lf6X3Bhrt4YIR4wqw+qgaI
	g6BDCFn18Byob3GEIGwFQEVdxDOTAEtq2qAAep7zzPUBzMGyQl6nSol6uW4pyOz056CANRAL4lwKI
	+yFJhPnULaBmZx8=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtCQJ-00COA7-9K; Sat, 06 Apr 2024 22:13:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 06 Apr 2024 15:13:28 -0500
Subject: [PATCH net-next v4 1/8] net: dsa: consolidate setup and teardown
 for shared ports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-1-eb97665e7f96@lunn.ch>
References: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
In-Reply-To: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=8EbkyqPBZ3n1DjiPoB84kJWTcYoVICCluJIHblFC+i4=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmEaz+C9t1x42l3WIJJdM9XZTt3rjE4sjUUyijb
 9AgLPCmahaJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZhGs/gAKCRDmvw3LpmlM
 hJZHD/9YHLf5GYcqrBEy/rVwIY+CyKyEimirBedTB18kF0iNfy5dvFBGMUyGX7cV/jxnc3L0+0O
 I4xKkoCNT6nXBs1+DlW31/h92w/xir9KyoIXljZlTlGy6wITqMdPN1BLeXDPVAwa+UIkFeXoezT
 Ifp/OBdZA7FNjR/A2YirrPb+QXmdxipn2m0FKTtuDPIKVU75RKFc/fM0bTxTwiNOBVo0nmJIb7p
 GxnmUdqfhbguC0XC+T0t+MkZ6I5AT5kXDfSB4Tr+HvhtLG21T3L/GJgBxv95/sAmlIeKuWj6KSg
 ms0O9hqXDz7RLr1PZBS5ZtChAk4uR+RBhzqgMGJ8yyGrmxtWU9Z3xYbkUVmpKr1ClzGsKUBQnBj
 dymgnecLD9iA0pfVtL4Ora4sDwULiAO1DvLl2cSAKbldFR3b0tjGdlrA1I7+9qC8jjtBnWP3lGg
 QuOV02tfHYjFKO4WaqmWS/nORBH7vTIlpfnsVgO1ZxcCmR3o3tMzczrfGqfEz1vOXOmf6b+eAZi
 36y0WJd2QLADmQiXKAXVLvhUfIMYSBRL3ySupDF5t5nGFy3MS2ehnSUgqenqRCWXtCpnQTKGGF5
 J9ww2TDBi8ICiIl2PI6Gs8Mom3q7otvsKw30g/198EbVnyOhi/s42qTz7gg+qxR7nLeCuM2Uv/V
 ttli+sBTefIwwXA==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

From: Vladimir Oltean <vladimir.oltean@nxp.com>

CPU and DSA ports have the same port setup and teardown logic, only the
string that gets printed on error differs. Consolidate the code paths.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/dsa/dsa.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 09d2f5d4b3dd..64369fa5fd07 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -479,23 +479,6 @@ static int dsa_port_setup(struct dsa_port *dp)
 		dsa_port_disable(dp);
 		break;
 	case DSA_PORT_TYPE_CPU:
-		if (dp->dn) {
-			err = dsa_shared_port_link_register_of(dp);
-			if (err)
-				break;
-			dsa_port_link_registered = true;
-		} else {
-			dev_warn(ds->dev,
-				 "skipping link registration for CPU port %d\n",
-				 dp->index);
-		}
-
-		err = dsa_port_enable(dp, NULL);
-		if (err)
-			break;
-		dsa_port_enabled = true;
-
-		break;
 	case DSA_PORT_TYPE_DSA:
 		if (dp->dn) {
 			err = dsa_shared_port_link_register_of(dp);
@@ -504,7 +487,8 @@ static int dsa_port_setup(struct dsa_port *dp)
 			dsa_port_link_registered = true;
 		} else {
 			dev_warn(ds->dev,
-				 "skipping link registration for DSA port %d\n",
+				 "skipping link registration for %s port %d\n",
+				 dsa_port_is_cpu(dp) ? "CPU" : "DSA",
 				 dp->index);
 		}
 
@@ -543,10 +527,6 @@ static void dsa_port_teardown(struct dsa_port *dp)
 	case DSA_PORT_TYPE_UNUSED:
 		break;
 	case DSA_PORT_TYPE_CPU:
-		dsa_port_disable(dp);
-		if (dp->dn)
-			dsa_shared_port_link_unregister_of(dp);
-		break;
 	case DSA_PORT_TYPE_DSA:
 		dsa_port_disable(dp);
 		if (dp->dn)

-- 
2.43.0


