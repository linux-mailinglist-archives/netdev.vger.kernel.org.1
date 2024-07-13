Return-Path: <netdev+bounces-111278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFE593076F
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546B7B21DB4
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2304417836A;
	Sat, 13 Jul 2024 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWasuZQf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69612177990;
	Sat, 13 Jul 2024 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905428; cv=none; b=KXeLzotYlRaPNaRVzD6QBYytY/MAVGluQDMEvhi6HngKH4DsDXCMWVczUsiTypI3rzMU+5ea+1o3EjhEm1ins74msKM1kJU53cEAEh0a32/odx2rcgxv1tBLRmkG8RjcvWkJhnlb+XNzbIv/Bw5IqxVtOysBhJOW49kqhYy+ryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905428; c=relaxed/simple;
	bh=MVXmrQ2LRCuJIf/94lH/IfWgZoufMkSDKJmB8MbQINo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OsAmACM4U6GNhmMDHi4ApV3c8ug84zOCq0IFmVTMIy25YTJDfx6yeas23gI6Gk5TNzAIv1N+E1k+uaCb2eVMiY1+4vJXub66xW9vkiMV5YdH9NTlgfj9uB1yBIy5akUUdFTer+NQVVxrgA8iUbq3vOOzMrB66WVmUZSP24MdI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWasuZQf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77c0b42a8fso640482866b.1;
        Sat, 13 Jul 2024 14:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720905424; x=1721510224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rh1vKhQI83uBVL3wLqhVH8a/5LN3/IDubJghfAucUvc=;
        b=CWasuZQfRbpThJnL4OEYS5UHH40CaoBQQ9gPVKBpVQ8vyQpe0Zd22VDmBOuJMxGC8x
         cGq5Ihb96V/tmnVcZi3zNB0g/F2Jb6v/fS56Be+4YX1kiKnckTI+j/YrJTKhFdGPoJXg
         /wheL2RBxUrGuD/PCZxGzOIoxKYDRu7sZpcODJk4Nyp9qlHnn5btkSURzBYyUzWUCs40
         rbsQ99+jhy3HpGbZKiwE0EicGfullV2LeASIYzjcdQy3VVvlAm1XBcIYw+P7XiRFZWj0
         74CaJXeDTQIICXX4A3VqfVy9C3TAOp1shU3+/cgbkt04AeKsNucuxJqczZQrBpHov46T
         tFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720905424; x=1721510224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rh1vKhQI83uBVL3wLqhVH8a/5LN3/IDubJghfAucUvc=;
        b=GnevduW/OKvEecKK9qIM4Ev/3lP/cq/ZhildppqoGAc4bziFVHyUF6mq9c7ZSdvmCo
         JQTGhD0ydGNx87iQc0aO/HpwWvQfO1hNVSj4irj3HRl2Ao9KNze8AioljiBwoeRkIG4t
         +Q2VjlXuYb02TGM6bLAkOBT6g548HJu7YJuNITG3Nj9q3ghL6XU6JMAkS1Vt4wacsbTz
         fdlYWLmokThgM1AZOcWChZyksZf1e7U7c9DpNHnc+5kDYKrrp78RAk4ckM72jOFDVKJT
         dyXO30S/Mri/WicB8ZvBu6lPgct89QKn1bAmnDtknemFZJV0zm6AY/w9Nyrz1RMdzFmT
         pj/g==
X-Forwarded-Encrypted: i=1; AJvYcCUuCjlc7FeIe2w18sQWgPpgcW5jqwsRfQLA5926MVvlehOiTUFIhs4rKAX2Tb27eGhSSnxFPnjnPXxVYS0+kWQrv4qFrgaxGZwssLkw
X-Gm-Message-State: AOJu0Yz/dGnOpt7svktuWlYeJv5sphXUquMTY+hWoFIkY80mBjP15VvL
	lUXXCl9GS6i6SL+eywLe0FT9/PBqu1Jx3zWcBMBK233gyv4DUNQFcakhbOO+
X-Google-Smtp-Source: AGHT+IEIu+3YlARYqTKgb4ZN+PQScmNIkc6S2L87Y9z7eBUCHpyM2Y/b5zktZ4qu9+T3GiyIDqSe2A==
X-Received: by 2002:a17:907:7f14:b0:a77:db04:8ceb with SMTP id a640c23a62f3a-a799cc6ab6cmr617731266b.19.1720905424387;
        Sat, 13 Jul 2024 14:17:04 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253b6sm1187286a12.41.2024.07.13.14.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:17:03 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 10/12] net: dsa: prepare 'dsa_tag_8021q_bridge_join' for standalone use
Date: Sat, 13 Jul 2024 23:16:16 +0200
Message-Id: <20240713211620.1125910-11-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713211620.1125910-1-paweldembicki@gmail.com>
References: <20240713211620.1125910-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'dsa_tag_8021q_bridge_join' could be used as a generic implementation
of the 'ds->ops->port_bridge_join()' function. However, it is necessary
to synchronize their arguments.

This patch also moves the 'tx_fwd_offload' flag configuration line into
'dsa_tag_8021q_bridge_join' body. Currently, every (sja1105) driver sets
it, and the future vsc73xx implementation will also need it for
simplification.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v4:
  - resend only
v3:
  - added 'Reviewed-by' only
v2:
  - resend only
v1:
  - introduce patch
---
 drivers/net/dsa/sja1105/sja1105_main.c | 5 ++---
 include/linux/dsa/8021q.h              | 3 ++-
 net/dsa/tag_8021q.c                    | 5 ++++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 0c55a29d7dd3..c7282ce3d11c 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2133,14 +2133,13 @@ static int sja1105_bridge_join(struct dsa_switch *ds, int port,
 	if (rc)
 		return rc;
 
-	rc = dsa_tag_8021q_bridge_join(ds, port, bridge);
+	rc = dsa_tag_8021q_bridge_join(ds, port, bridge, tx_fwd_offload,
+				       extack);
 	if (rc) {
 		sja1105_bridge_member(ds, port, bridge, false);
 		return rc;
 	}
 
-	*tx_fwd_offload = true;
-
 	return 0;
 }
 
diff --git a/include/linux/dsa/8021q.h b/include/linux/dsa/8021q.h
index 1dda2a13b832..d13aabdeb4b2 100644
--- a/include/linux/dsa/8021q.h
+++ b/include/linux/dsa/8021q.h
@@ -18,7 +18,8 @@ int dsa_tag_8021q_register(struct dsa_switch *ds, __be16 proto);
 void dsa_tag_8021q_unregister(struct dsa_switch *ds);
 
 int dsa_tag_8021q_bridge_join(struct dsa_switch *ds, int port,
-			      struct dsa_bridge bridge);
+			      struct dsa_bridge bridge, bool *tx_fwd_offload,
+			      struct netlink_ext_ack *extack);
 
 void dsa_tag_8021q_bridge_leave(struct dsa_switch *ds, int port,
 				struct dsa_bridge bridge);
diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index c0eee113a2b9..3ee53e28ec2e 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -286,7 +286,8 @@ int dsa_switch_tag_8021q_vlan_del(struct dsa_switch *ds,
  * be used for VLAN-unaware bridging.
  */
 int dsa_tag_8021q_bridge_join(struct dsa_switch *ds, int port,
-			      struct dsa_bridge bridge)
+			      struct dsa_bridge bridge, bool *tx_fwd_offload,
+			      struct netlink_ext_ack *extack)
 {
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	u16 standalone_vid, bridge_vid;
@@ -304,6 +305,8 @@ int dsa_tag_8021q_bridge_join(struct dsa_switch *ds, int port,
 
 	dsa_port_tag_8021q_vlan_del(dp, standalone_vid, false);
 
+	*tx_fwd_offload = true;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dsa_tag_8021q_bridge_join);
-- 
2.34.1


