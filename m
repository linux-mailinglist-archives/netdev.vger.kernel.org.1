Return-Path: <netdev+bounces-132570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627B999223A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 01:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0E228183B
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04DD18BB93;
	Sun,  6 Oct 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rim3lu5j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3228377;
	Sun,  6 Oct 2024 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728256825; cv=none; b=feD+dfqt4UBTGJG6typyQtVY15s/8YdaHrv1ez7d4/uYDl6NqZhKMEg64RMYu6EJNHS5xI0PWvfjc/oo23+uIp3qdXGrW0yt1LNudy4JKE8Wci7uQ5nN91tCx1loieARUuh4qgWlrBDw5XxhOewP73YbUgIkl5tn5ovdlbIiXi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728256825; c=relaxed/simple;
	bh=OGZP2oouUX5Uqhoa9giSrckDbuLWI9cEQEkxfUKW67M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KwXl9hIms4Huk+QA/DcremZYuNQFiQVUvypryjVsheaxNeVWKsnUr3wpro+C1X5lEcSGMvQI0GkXA9jeRjMtaYBfMAQRmmXzhgNgfsXREA22wbC7+o1IuDYjXDlOvq8ZQoR6Jj9FCs3ONcIS4pOo05SKdwgujeE1sDPTZ6PFH60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rim3lu5j; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e221a7e7baso614594a91.0;
        Sun, 06 Oct 2024 16:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728256823; x=1728861623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWD2zMKfINKte2YJYP7FEhQFS1joaH2BoggACO48Gts=;
        b=Rim3lu5jJWAXumn2BUHsPgUgvN5rAk+eviaJDpPAxd0Ig62mGpfwim6yHyt5ZB4i8P
         e7uwzwMEEbmLM160woVTmD6xzAEWvI2lP4SAvFcvQ3mEbiuoTz7uxw62E3RpReFgEtS8
         XbdPsHIO7Q7ziJfvsnN1l/Q/5y3QUjOD4KRWLyAp1YKAyC1HEgJJIEGpuJVKEhcqcv5Z
         58m5u2BkNtyoZ936wUDRbR4FFdZsIlL8ES61lE+Or7PciI3jbrxhCnuFM7GM6yQ5T7Du
         lV4Ram9wYx7rOj6RPG3dV92BjzJ231DnZbxbQOdQglctGSKCrKMBty2AfVwzpMFx7PGH
         4BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728256823; x=1728861623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWD2zMKfINKte2YJYP7FEhQFS1joaH2BoggACO48Gts=;
        b=GJcIu19DC8szX4K+k8BuBRAAk7LArFZwWg1yoMw730vxPaIreDr2LsNtAPJw7TGmra
         +zCL3BpgP80rox4M2b/Ij2G3EtFQgdk5MPqVTeUbISkb/Jbbmam+dQYZm2F8jTFmAXn5
         GFhI+ahCqq1pcqP4ciFYh07AXwnzVHV0th2vTZh55b9jN9ilpNx1FITbM5Io3ua5vSMb
         7b+sweYPshRltkErEjI8xuW5DOXZiymL+HARCY06kXDLKnlE2Izwwf4airqYiOlETNpj
         5ZqGSWX57VDwK5la1IRtXOyNBjoxzg4di1VlU4ew07aqV4KLBPQLXre7f9umtdPR0mOU
         QUEw==
X-Forwarded-Encrypted: i=1; AJvYcCUb73yjvDir9lpNXmj/2hS/O4TLaTctvca3y8NAGtvW7Tak5BafuuCjAm/T9Oj02uovqPUFkflImr611nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqfEuy5BpWH0IW3DS3o6g6sjPYm3Z92ds3zfoDi97MIa5VPmK
	KEsFucojj3J2kfEPhg+LunUcHkUo654/IfMSette60UnJOaByyMaaG33A/fa
X-Google-Smtp-Source: AGHT+IHV/eEl5E756pvrEfJu7ysX/xPubqsDRVeaU+qhtx3erBueetlIITrBRGxY4BzMRaiVJQQFAw==
X-Received: by 2002:a17:90a:ca16:b0:2e0:5748:6ea1 with SMTP id 98e67ed59e1d1-2e1e63c000dmr14338452a91.37.1728256822828;
        Sun, 06 Oct 2024 16:20:22 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f6467sm3886800a91.45.2024.10.06.16.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 16:20:22 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>
Subject: [PATCH v2] net: dsa: Fix conditional handling of Wake-on-Lan configuration in dsa_user_set_wol
Date: Mon,  7 Oct 2024 04:49:38 +0530
Message-ID: <20241006231938.4382-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the original implementation of dsa_user_set_wol(), the return
value of phylink_ethtool_set_wol() was not checked, which could
lead to errors being ignored. This wouldn't matter if it returned
-EOPNOTSUPP, since that indicates the PHY layer doesn't support
the option, but if any other value is returned, it is problematic
and must be checked. The solution is to check the return value of
phylink_ethtool_set_wol(), and if it returns anything other than
-EOPNOTSUPP, immediately return the error. Only if it returns
-EOPNOTSUPP should the function proceed to check whether WoL can
be set by ds->ops->set_wol().

Fixes: 57719771a244 ("Merge tag 'sound-6.11' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound")
Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
v2:
- Added error checking for phylink_ethtool_set_wol(), ensuring correct
handling compared to v1.
___
 net/dsa/user.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 74eda9b30608..bae5ed22db91 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1215,14 +1215,17 @@ static int dsa_user_set_wol(struct net_device *dev, struct ethtool_wolinfo *w)
 {
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
-	int ret = -EOPNOTSUPP;
-
-	phylink_ethtool_set_wol(dp->pl, w);
-
+	int ret;
+
+	ret = phylink_ethtool_get_wol(dp->pl, w);
+
+	if (ret != -EOPNOTSUPP)
+		return ret;
+
 	if (ds->ops->set_wol)
-		ret = ds->ops->set_wol(ds, dp->index, w);
+		return ds->ops->set_wol(ds, dp->index, w);
 
-	return ret;
+	return -EOPNOTSUPP;
 }
 
 static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
-- 
2.46.0


