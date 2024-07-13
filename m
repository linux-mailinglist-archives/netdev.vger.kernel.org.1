Return-Path: <netdev+bounces-111218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0A89303E5
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E951F227A4
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E708F135A71;
	Sat, 13 Jul 2024 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4wXu5l7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE89136E05;
	Sat, 13 Jul 2024 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850128; cv=none; b=fGtdvkuU6x64MCix/Bj/Bwp9Bm1B7U4XfK6zMmcCi6Ax3+X+3S1YATbr8l02erAn6MAlsnOQMbkIOPdJUdOKiwqGF6bqXxCxdBkFqwYVsEmpw3OljUFV1SmzushHPOuHufYdjZ/dZCbj6E5OxBM1f3ROkc2xTuUozj1rP3j+nNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850128; c=relaxed/simple;
	bh=7bCGbcfx70RiP+ql8fDb8kYzlGutv+0imJcDQfZHDD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QGpzpu99SWqJBq+H1BOFl4izhPzNbsz2g9TmUnwj+pieiwg/ha8PpJaOY7L+gVLp6bIrpmCeJnRgPc/uCP5eIr7XRaMFTGczJZlZ34iCVx3aKsrKLE+C80lQ5yEIMuMUBTzdnz93a6qmsDEzOQ/3qb9ZF40BX1BPZYYes09nuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4wXu5l7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eec7e43229so30331841fa.3;
        Fri, 12 Jul 2024 22:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850125; x=1721454925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqgCsXPgQR+KBVmH4O95ngJb1/Pd+9E/rt28mJ6/gDY=;
        b=W4wXu5l7OrxhPQ8jFU85tBurxNmEUrTQEcwR9LLK21bHN880WyPh84A5V2Lws0C15v
         EDvCEanx/G62/mjVouE2+vNjIZfpgPadQTBhWfy9NFHlTkqBFK9vGib0xEgDMSNaYO45
         ymL/hpJ8V4WPfC/qSES0kNI+fDZT+AaROW6Y1cCd/S0fgilf3wJ8eKUD5JFnGIMkQyX+
         eBr4PYXzDRCb3cL+bQl56AimdBEa0pmE9ZyYddoL6lap1z2Hp50tpNYfbjJq2n+qj3Zp
         ttn9r3YHCkv3bhijM1ZjlGju7wEHHcTTpUUCpqEEg+capYYIJUbJFVo7IVzmoQI7XtEd
         VOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850125; x=1721454925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqgCsXPgQR+KBVmH4O95ngJb1/Pd+9E/rt28mJ6/gDY=;
        b=DL6cXFmN1xwW967Wu2+pwDkBVNuYAPB64p+50baXUL45CYXdHH6hl6JR1yxkcZ2gYD
         fdBC0cQ9MMIcPwI9yxO8VHoBuWLmDLjKEWHCjDExK5ifVfJBZikwpBQyAqb7FSiniVdS
         o8L1wBJZtvmA8ZmfTRbVYYTFBi5my9QWeAO5z2fn0smXjYpDsGZKPPRUld66AKlLiqpq
         nVTHEuAS5LpxLwtBOIMiz7m73hBx5wcOajPWjmAgefPn8VnUZaJyziGNtDtbY1UyVQim
         owAKCXC+eK+henVzhZjGE5xqipFudzeDAce5jh/vywWSxPdiyK6qkp9Rm9aCCauIuPqp
         8UDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsfGrVcUJZW3fZTBIb18WGQHQoVNHZzIZraOy7boJPjiarBeLoOQuzy5Cw31S4EpidcafI4kdHWUff2Vq6MpjIA0HGK4loCDY3ByAw
X-Gm-Message-State: AOJu0YwejmekAh2oGedV7rtCXf5gFh+fhrg88KhNhD3CyMuMRpTvsX9q
	VxNY0sYHYkVHpONcf/Ss1poMVykVs0MhPCgCyBltO4ZveUYv1Rm0T6o/SndI
X-Google-Smtp-Source: AGHT+IG4dyKsYWVBIJfpxRz9Ahh3gKhRKYiru9t9DmQ7gsgdp63tOB0yOojwPnccQT7zpOJg74hnVQ==
X-Received: by 2002:a05:6512:3d08:b0:52e:9382:a36 with SMTP id 2adb3069b0e04-52eb99a318cmr9862230e87.30.1720850125073;
        Fri, 12 Jul 2024 22:55:25 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:b4ea:33f8:5eca:e7fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1ceesm20515666b.126.2024.07.12.22.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:55:24 -0700 (PDT)
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
Subject: [PATCH net-next v3 10/12] net: dsa: prepare 'dsa_tag_8021q_bridge_join' for standalone use
Date: Sat, 13 Jul 2024 07:54:38 +0200
Message-Id: <20240713055443.1112925-11-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713055443.1112925-1-paweldembicki@gmail.com>
References: <20240713055443.1112925-1-paweldembicki@gmail.com>
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


