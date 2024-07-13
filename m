Return-Path: <netdev+bounces-111213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4679303DB
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D870B1F221BA
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A1A61FD4;
	Sat, 13 Jul 2024 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV+HAv3o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A0E4EB38;
	Sat, 13 Jul 2024 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850111; cv=none; b=ASTYfgi5M75upPbkshb7Ffrr5H1+kUSzjjSXxvc8FsCWAbtGRtDFSSKt7HGq7y7talppK9Snwndv42cIIK7jk2Ta0QxjSWXI1uJzkXkH3hUtsXz12ptZfffEYDBxnU+wkgAxuEwyZDdQx0+AtEw6gB5u82WTd/74rawuKJRpAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850111; c=relaxed/simple;
	bh=qUDf5bzJIRpuGG58MPCP71MO5E3Wp+3Z/HtiGO427us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tOYDzTh0N9+2npWtfQSP8LhDNfYWQO4DvwnoMIFXRDmNoML0//uwDoV0E4TZcEcmmlImpm1hEsFvbllPc4FYd5UK5Wq4TXVNYCRoQgZmjguw+9/o8w+jHU3hAMhfSMrNlcXXTdXqWYH2mXXZmOGy/jxU2matJOmawE8QHRHgsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CV+HAv3o; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77dc08db60so337047866b.1;
        Fri, 12 Jul 2024 22:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850108; x=1721454908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEox4l3skoYQyvZFS9at+xzCRoM9sUiX6FsbRszzTic=;
        b=CV+HAv3of8cflRwNBnEN+l6fKbGve8La2zKM+bxkBzQBlOB79iou4EMKVN23fLHKd6
         HMflaYe9Eu1+yAM5SinZs5Z19zIt68QyQwRD4rVs2nRy4kpLuLf87/U2aBtwJEAc44gB
         +4dRp0SkqzhaCRqM9uEIdl3Pq322XQoqJ2O7CdPDyZ0HT3lQZpui06KTSiFoKob0B/dw
         GOmxPS+jPhf71Vwn32cb9nz9QpguBJDolZ4Oum2ifQlVj/SOjDR4+T+bWSfNY4NcWXG4
         Ff5r1ESPQ0kS4h6XWJ+tLOmC3MWFMD9+QBhcQlUpQrGIHpz5MKYdTl1/wj9z8yvU2Un5
         1Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850108; x=1721454908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEox4l3skoYQyvZFS9at+xzCRoM9sUiX6FsbRszzTic=;
        b=oog7YEqMr37xdy59wa0Gfqgg9X/K7anyXIaCYF4TGX/uyhnOBIOfcUgvRZyWVLBa6U
         CjjxEPkESe2WycXdOqW4OfpLSHxw0gwUm2CUdYf/KMHPSRTn0AtENHC7KDa/TYVRKciR
         TbNVNlM9/ykz8deqqW2sE1h31aPO9c2wMyaWtSFWzQQsLYts2MHV2UBJ9CLAMkIegeHj
         jEUMdWANJ8ieW8iVdoomPZYNqn35IUalCTpudwGdYsUcoZ6q7BsyNlPz8W6P4qv92PlM
         BHmzx9cRNSHa0WTYfUKr/2UVV1PoBCwfKcEqHvpLBWdOGKEusV8O9y8atNMycAEVXVty
         R2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXjapYdl3NQO3YOgxcYlec3L3u23XgYVZ3V/fkX8FCVb/QRSC1+Yqojrsht4s8kRc4DWcNfSRRYNCHecS9SoKfjtSVHR0Y5adRdvENB
X-Gm-Message-State: AOJu0YxEZKuaiZ3L9mmi5W3AAaaKpQIX+6FaUbxZLtLUe858BzRek3Sc
	i7rfuyxxkNP1mYjG/3dwHRGO8nggQ/QrPHOEzjOizYhnq2C5bpsQn35ZP0qy
X-Google-Smtp-Source: AGHT+IG052Q8Ca32OmqKtpHUVymPLfBthlM0z6cmL1v2dMev1y7817YFthT1g5Fhi4EWZ/QYTzaBZA==
X-Received: by 2002:a17:907:d93:b0:a75:20f7:2c71 with SMTP id a640c23a62f3a-a780b6ff667mr1338557766b.38.1720850107892;
        Fri, 12 Jul 2024 22:55:07 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:b4ea:33f8:5eca:e7fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1ceesm20515666b.126.2024.07.12.22.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:55:07 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
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
Subject: [PATCH net-next v3 05/12] net: dsa: tag_sja1105: prefer precise source port info on SJA1110 too
Date: Sat, 13 Jul 2024 07:54:33 +0200
Message-Id: <20240713055443.1112925-6-paweldembicki@gmail.com>
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Now that dsa_8021q_rcv() handles better the case where we don't
overwrite the precise source information if it comes from an external
(non-tag_8021q) source, we can now unify the call sequence between
sja1105_rcv() and sja1110_rcv().

This is a preparatory change for creating a higher-level wrapper for the
entire sequence which will live in tag_8021q.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v3:
  - added 'Reviewed-by' only
v2, v1:
  - resend only
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8,v7,v6,v5:
  - resend only
v4:
  - introduce patch and replace 'slave' with 'conduit' after rebase
---
 net/dsa/tag_sja1105.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 7639ccb94d35..35a6346549f2 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -652,12 +652,12 @@ static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 	if (likely(sja1105_skb_has_tag_8021q(skb)))
 		dsa_8021q_rcv(skb, &source_port, &switch_id, &vbid, &vid);
 
-	if (vbid >= 1)
+	if (source_port != -1 && switch_id != -1)
+		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
+	else if (vbid >= 1)
 		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-	else if (source_port == -1 || switch_id == -1)
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	else
-		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
+		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
-- 
2.34.1


