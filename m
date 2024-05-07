Return-Path: <netdev+bounces-94241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D008BEB9E
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 20:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE4C281B65
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3980716D331;
	Tue,  7 May 2024 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3U/TCjFA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7964C8A
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107308; cv=none; b=C2cP+7pg7H43Qr7Fd1kGLIvFm1hhlKdz2jGVOIfL64G4gFfi/Bpy8CylWXlab6AgAMavCZ+vA9qBmqoCF7UQXL32fx2rawZzRckUCd5SnufMmTmvTXSJ+POjinlEaVGnprLJEOEwWTTAL5GUtUOh1krTeOV1L7kR1dLaOIc16pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107308; c=relaxed/simple;
	bh=Sk3GzLrED9inJbvrqZdYm/mzHv8t9CSE/ayx1FCAOH0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nXueRUeM7ciVyAZpXy/LMb6BWTc0U3hdWsf8aAFKA/WyLIHo48MyTO1xYvZOHNz5e0ZTKD0BUKWbZP8N6TLtEh8NGk2zG3XhCGb0HM50GMmXh/XipvEiyccl1Z5LCr56f8uQMh7ZgE6opu5VAE/aoGnwvXOVjtNb50dJrUrhBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3U/TCjFA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de603db5d6aso7232929276.2
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715107305; x=1715712105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I1d3OMA9pEyYDd45jAzErkRbXVFyR1sAH55KehGxxrI=;
        b=3U/TCjFA1JtRmGwprmEnBSmrPcBI+4F6aPI9Z/N265tJW1/YH1QMTdU4jvSvxKgtf9
         GE19gq1rBCHUYwsXX8oM9EFXWlh0v7Kpnmb1QdQCcRU1F8uRCeWhgOs5KQueyI3lsT94
         kL7iCFdHDzimaF2nsRZRh7YMHPiriNNE/KKNWQ3OEKf5cYgFuuzB9Ozny35MQDbgBZbD
         2YiD+4CGvPdrwfqNeGwl2xgfddzCk05W37rb6EDyn8SRY2U+ZF+/0jPO5YJsJsCBTNDM
         eHI7zpL/nGMcHktJtzQxYpy7r1P+Nfm8GxvytPR7WjAxcO/Jipa8NCWp/KRyaPV+Jelt
         tEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715107305; x=1715712105;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1d3OMA9pEyYDd45jAzErkRbXVFyR1sAH55KehGxxrI=;
        b=j2xwX7fxxVGhiD6vkq6EU8J1DwFM1acQ7KHVvVpdEfkNc01uWn4slzKZ22/sBjcP6s
         cPwiPqo8eoI9RmfbL2KTEVtqm5EtXf5NB4Fx8aUZcrm1iKoePOYJ26SQaVEOjfA3qV6c
         Pe2qRBs3JVaiCot3wr0Ip+ef+9qUJ+pC3JNGKoDtNhwlS8oeT04WGB7zmHdtlJtiQJrl
         +uElbMY/CE5lY0JYdzbQ7GdIbQ9FAqcA2saMSGHiHxBp4w/napOAj2+9rDSbd/+X2QzM
         34s+lWQsIuNL49edCQeAdoMlyoLuOLh5nvCCiOm7j5ug4JkSa12OHSXtB1gupTffl/be
         gICw==
X-Forwarded-Encrypted: i=1; AJvYcCVAaesHofzO5p58sMyfA3EW2jggP0KTO5MgLhEtesk4hPN1uF3D57B3NLrzoUIM2rsrn+jJE+CX9zTNubIey1Up8yAlTl6H
X-Gm-Message-State: AOJu0Yyw/pyl+IMD1XfBHVeY5SnbypwPgH7QgjJHmi2x/ciIvJEm6UZQ
	FId7/FfcaIYpIBbZ7iqfsGjTCWy0idW7x8mGS7BBjys9iz6cDcwfGhXJI+b4cuSNcrwo7EYNwpd
	nAN3FBohO9Q==
X-Google-Smtp-Source: AGHT+IEx6mDfs9Bei/MFFaB/PMCo3baRWg7wrEGpKKIkoNuOslm73+VFbLdTjsMaN0ipt/1HnNPS11sVda4lDg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1082:b0:dcd:88e9:e508 with SMTP
 id 3f1490d57ef6-debb9d889ffmr121272276.5.1715107305582; Tue, 07 May 2024
 11:41:45 -0700 (PDT)
Date: Tue,  7 May 2024 18:41:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507184144.1230469-1-edumazet@google.com>
Subject: [PATCH net-next] net: annotate data-races around dev->if_port
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Various ndo_set_config() methods can change dev->if_port

dev->if_port is going to be read locklessly from
rtnl_fill_link_ifmap().

Add corresponding WRITE_ONCE() on writer sides.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/3com/3c589_cs.c     | 2 +-
 drivers/net/ethernet/8390/etherh.c       | 2 +-
 drivers/net/ethernet/8390/pcnet_cs.c     | 2 +-
 drivers/net/ethernet/amd/nmclan_cs.c     | 2 +-
 drivers/net/ethernet/sis/sis900.c        | 6 +++---
 drivers/net/ethernet/smsc/smc91c92_cs.c  | 2 +-
 drivers/net/ethernet/xircom/xirc2ps_cs.c | 4 ++--
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/3com/3c589_cs.c b/drivers/net/ethernet/3com/3c589_cs.c
index 5267e9dcd87ef90927e7806206dba7d108e96ddc..be58dac0502a6f777010e4005ef8537b830074d6 100644
--- a/drivers/net/ethernet/3com/3c589_cs.c
+++ b/drivers/net/ethernet/3com/3c589_cs.c
@@ -502,7 +502,7 @@ static int el3_config(struct net_device *dev, struct ifmap *map)
 {
 	if ((map->port != (u_char)(-1)) && (map->port != dev->if_port)) {
 		if (map->port <= 3) {
-			dev->if_port = map->port;
+			WRITE_ONCE(dev->if_port, map->port);
 			netdev_info(dev, "switched to %s port\n", if_names[dev->if_port]);
 			tc589_set_xcvr(dev, dev->if_port);
 		} else {
diff --git a/drivers/net/ethernet/8390/etherh.c b/drivers/net/ethernet/8390/etherh.c
index 05d39ecb97ffeeeb95c5fa84cbfc487ee6a61b73..e876fe52399a0a0b853724b60e3dd0416a3f5320 100644
--- a/drivers/net/ethernet/8390/etherh.c
+++ b/drivers/net/ethernet/8390/etherh.c
@@ -258,7 +258,7 @@ static int etherh_set_config(struct net_device *dev, struct ifmap *map)
 		 * media type, turn off automedia detection.
 		 */
 		dev->flags &= ~IFF_AUTOMEDIA;
-		dev->if_port = map->port;
+		WRITE_ONCE(dev->if_port, map->port);
 		break;
 
 	default:
diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
index 9bd5e991f1e52be30a5285196779d725ae9b481e..780fb4afb6af0d907d70dbfb01268a74c4fd9d7b 100644
--- a/drivers/net/ethernet/8390/pcnet_cs.c
+++ b/drivers/net/ethernet/8390/pcnet_cs.c
@@ -994,7 +994,7 @@ static int set_config(struct net_device *dev, struct ifmap *map)
 	    return -EOPNOTSUPP;
 	else if ((map->port < 1) || (map->port > 2))
 	    return -EINVAL;
-	dev->if_port = map->port;
+	WRITE_ONCE(dev->if_port, map->port);
 	netdev_info(dev, "switched to %s port\n", if_names[dev->if_port]);
 	NS8390_init(dev, 1);
     }
diff --git a/drivers/net/ethernet/amd/nmclan_cs.c b/drivers/net/ethernet/amd/nmclan_cs.c
index 0dd391c84c1387e35a6eab6952cb242fd5ee7c5a..37054a670407bb072ae9bfcb373df4b3ab078257 100644
--- a/drivers/net/ethernet/amd/nmclan_cs.c
+++ b/drivers/net/ethernet/amd/nmclan_cs.c
@@ -760,7 +760,7 @@ static int mace_config(struct net_device *dev, struct ifmap *map)
 {
   if ((map->port != (u_char)(-1)) && (map->port != dev->if_port)) {
     if (map->port <= 2) {
-      dev->if_port = map->port;
+      WRITE_ONCE(dev->if_port, map->port);
       netdev_info(dev, "switched to %s port\n", if_names[dev->if_port]);
     } else
       return -EINVAL;
diff --git a/drivers/net/ethernet/sis/sis900.c b/drivers/net/ethernet/sis/sis900.c
index cb7fec226cab63451f1c5e31287d67181f4f8a95..85b850372efee01c142f3f63bc2d495450512110 100644
--- a/drivers/net/ethernet/sis/sis900.c
+++ b/drivers/net/ethernet/sis/sis900.c
@@ -2273,7 +2273,7 @@ static int sis900_set_config(struct net_device *dev, struct ifmap *map)
 		 * (which seems to be different from the ifport(pcmcia) definition) */
 		switch(map->port){
 		case IF_PORT_UNKNOWN: /* use auto here */
-			dev->if_port = map->port;
+			WRITE_ONCE(dev->if_port, map->port);
 			/* we are going to change the media type, so the Link
 			 * will be temporary down and we need to reflect that
 			 * here. When the Link comes up again, it will be
@@ -2294,7 +2294,7 @@ static int sis900_set_config(struct net_device *dev, struct ifmap *map)
 			break;
 
 		case IF_PORT_10BASET: /* 10BaseT */
-			dev->if_port = map->port;
+			WRITE_ONCE(dev->if_port, map->port);
 
 			/* we are going to change the media type, so the Link
 			 * will be temporary down and we need to reflect that
@@ -2315,7 +2315,7 @@ static int sis900_set_config(struct net_device *dev, struct ifmap *map)
 
 		case IF_PORT_100BASET: /* 100BaseT */
 		case IF_PORT_100BASETX: /* 100BaseTx */
-			dev->if_port = map->port;
+			WRITE_ONCE(dev->if_port, map->port);
 
 			/* we are going to change the media type, so the Link
 			 * will be temporary down and we need to reflect that
diff --git a/drivers/net/ethernet/smsc/smc91c92_cs.c b/drivers/net/ethernet/smsc/smc91c92_cs.c
index 29bb19f42de9f58661d5af3550ef78603fa373b0..86e3ec25df0799b243e87d0c30c9b6c06127aae2 100644
--- a/drivers/net/ethernet/smsc/smc91c92_cs.c
+++ b/drivers/net/ethernet/smsc/smc91c92_cs.c
@@ -1595,7 +1595,7 @@ static int s9k_config(struct net_device *dev, struct ifmap *map)
 	    return -EOPNOTSUPP;
 	else if (map->port > 2)
 	    return -EINVAL;
-	dev->if_port = map->port;
+	WRITE_ONCE(dev->if_port, map->port);
 	netdev_info(dev, "switched to %s port\n", if_names[dev->if_port]);
 	smc_reset(dev);
     }
diff --git a/drivers/net/ethernet/xircom/xirc2ps_cs.c b/drivers/net/ethernet/xircom/xirc2ps_cs.c
index e9bc38fd20257b96b9fb11a5cce19c5fd5d17aaf..a31d5d5e65936d88615bf28d5b5e3a650b8cc8a7 100644
--- a/drivers/net/ethernet/xircom/xirc2ps_cs.c
+++ b/drivers/net/ethernet/xircom/xirc2ps_cs.c
@@ -1366,10 +1366,10 @@ do_config(struct net_device *dev, struct ifmap *map)
 	    return -EINVAL;
 	if (!map->port) {
 	    local->probe_port = 1;
-	    dev->if_port = 1;
+	    WRITE_ONCE(dev->if_port, 1);
 	} else {
 	    local->probe_port = 0;
-	    dev->if_port = map->port;
+	    WRITE_ONCE(dev->if_port, map->port);
 	}
 	netdev_info(dev, "switching to %s port\n", if_names[dev->if_port]);
 	do_reset(dev,1);  /* not the fine way :-) */
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


