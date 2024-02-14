Return-Path: <netdev+bounces-71612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507238542C8
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 07:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0556A284C77
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 06:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BF91118F;
	Wed, 14 Feb 2024 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl8uh1Ux"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC011184
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892095; cv=none; b=Hkz5DH5Yd5C0PeBGce0B8ssf5ECZxzuuJPk/GpHcV9p/d5UHsX74GQI1r/9gBWxO23Vka5oFI0Uj1kbUrUOxckN4SYZy2rgNeIMJ+jhIFiX5LRod/Rm6t5v+NmAC4usnm4pyLeqHHfZgmSffnLIlonmGI4Kv+qeJ1O9S7q8dVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892095; c=relaxed/simple;
	bh=rHQygRb37wI8CjF4pUfkF+1ThaVluQJuWA50UCngsG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq0xbBYKuVuhdY0qtPZa8F6ej6fcKXzhcMFmBpbeDYQDu8j+6PGjrVImGv1MKKHoj9ttJnd8fYHpMLgupzCulHI45ngXb9OoS/j9MmwZhwwIrZGa0+vG81hOy5WS4ArJl5cllaa5pZFm5hYyX/CctoXzUVQtMqRnEV544vY8Sl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zl8uh1Ux; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d91397bd22so39300215ad.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 22:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707892093; x=1708496893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l2G10WRscQHVrzcFySRcXO99KOvqXERni9GLl5mRxM=;
        b=Zl8uh1UxLzh0cLUGVIzZPTyV23OfzOXJUbJkRBUNl8H5Ua36bkqGkxImS2KYpc/LWI
         BynQLGtLk+vIR0zbRxg9SJ2unbQXD0NLxR/amV3c/QxBnzAOt2o5enT3y0qXIOg3iDUJ
         dYiVu1i6uivtM2/9gNZyN/ou0fa2PAKTBhh6/oldKyoGhzUSX9kzJSi4/EHjmWfDcHbn
         1LpbXHTiGEGhYP9J+I3VFuxUaFWGh+K7weMLPXFF3vYYJDblo1xV+bGje/3qbd3qIk96
         ecmZJW3XI5ZZvFNPSLeOwrUREAnCPRWSUqYP+LpP7zs9gC6l9VJnyqcGDWYdCmLmks6k
         fSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892093; x=1708496893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5l2G10WRscQHVrzcFySRcXO99KOvqXERni9GLl5mRxM=;
        b=h+ur+RsN/6vzroJhq0MSAB76/SIxHMD9QadFg9jQDPOmaYSQ4HWG2shh8ZQEJ7pBdp
         0EU37lRhY6/XruOuMcxXzenwaBot1WnU8gAfau1PzBN1BAY/vAyPL7C3kD7dEeU6MjKE
         g/lOdqvYNEfO3gCY1kiJWXcukQ6NnAXpnJD48Bkjw/Hca0o6+Rt8S+rj3s6WwFRFyFwe
         Tvnd317b/QM7dk8T+uJXnDjMml49qu1vOAnhxLKJJ7cqsZjOJQTIgD1TB5NwGYoMTfou
         DZKbsVLmSltLL+0vHsGNxnnv8/hw9Kpw/wHji+vASZrPD/LiWD8wAMUua1SS92q4cGhL
         9wIA==
X-Gm-Message-State: AOJu0YxLqHfKLJbimQOOmcZKkwQvKXHAzJLo8hQ8mzA9G+6UoJKJectU
	vh6ObHfj8btENz4lnsHyhqvgPcdVeEaHduHWCdwNVNuQxCD+Bt4UZHNHKEnvEmg=
X-Google-Smtp-Source: AGHT+IEuIZeFuVilrDbGjSur8HYqZAut5c9XyJsUOkHTABD+tM4/i5MpeASj/CyD90qwESKoejQVLw==
X-Received: by 2002:a17:902:efd4:b0:1db:4287:c309 with SMTP id ja20-20020a170902efd400b001db4287c309mr1556252plb.11.1707892093044;
        Tue, 13 Feb 2024 22:28:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeqy5JwVCl1ECrAUIdU/BAaXdP0KPOk9ykmbnHVISjuEWn0USU5chMPCf+m30w8QioJmzzY1RLD3NjMIaWplbik/Egt885CFyrBYG/Kmbly14W61l6+zHsvWFdbFZG+dyOkDVIy5sC3qCeUJZ4arsQk3/MvIOfAJCSFVKwEL+a3m8t9qT0+OhqdrwTaOQ7aUhegfaqWnO0pfpSvttexaNYSs69MjNqBqgDbzWDOiIYc8OQj5eP01VtHS0KK6cLib99rdXzpOI=
Received: from xavier.lan ([2607:fa18:9ffd::2a2])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902e31300b001d8dd636705sm1983843plc.190.2024.02.13.22.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 22:28:12 -0800 (PST)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	dan@danm.net,
	bagasdotme@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jikos@kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH net-next v2 1/3] net: ipv6/addrconf: ensure that regen_advance is at least 2 seconds
Date: Tue, 13 Feb 2024 23:26:30 -0700
Message-ID: <20240214062711.608363-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240214062711.608363-1-alexhenrie24@gmail.com>
References: <20240209061035.3757-1-alexhenrie24@gmail.com>
 <20240214062711.608363-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC 8981 defines REGEN_ADVANCE as follows:

REGEN_ADVANCE = 2 + (TEMP_IDGEN_RETRIES * DupAddrDetectTransmits * RetransTimer / 1000)

Thus, allowing it to be less than 2 seconds is technically a protocol
violation.

Link: https://datatracker.ietf.org/doc/html/rfc8981#name-defined-protocol-parameters
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/networking/ip-sysctl.rst |  4 ++--
 net/ipv6/addrconf.c                    | 15 +++++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 7afff42612e9..458305931345 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2503,7 +2503,7 @@ use_tempaddr - INTEGER
 
 temp_valid_lft - INTEGER
 	valid lifetime (in seconds) for temporary addresses. If less than the
-	minimum required lifetime (typically 5 seconds), temporary addresses
+	minimum required lifetime (typically 5-7 seconds), temporary addresses
 	will not be created.
 
 	Default: 172800 (2 days)
@@ -2511,7 +2511,7 @@ temp_valid_lft - INTEGER
 temp_prefered_lft - INTEGER
 	Preferred lifetime (in seconds) for temporary addresses. If
 	temp_prefered_lft is less than the minimum required lifetime (typically
-	5 seconds), temporary addresses will not be created. If
+	5-7 seconds), temporary addresses will not be created. If
 	temp_prefered_lft is greater than temp_valid_lft, the preferred lifetime
 	is temp_valid_lft.
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ca1b719323c0..68516493404a 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1339,6 +1339,13 @@ static void ipv6_del_addr(struct inet6_ifaddr *ifp)
 	in6_ifa_put(ifp);
 }
 
+static unsigned long ipv6_get_regen_advance(struct inet6_dev *idev)
+{
+	return 2 + idev->cnf.regen_max_retry *
+			idev->cnf.dad_transmits *
+			max(NEIGH_VAR(idev->nd_parms, RETRANS_TIME), HZ/100) / HZ;
+}
+
 static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 {
 	struct inet6_dev *idev = ifp->idev;
@@ -1380,9 +1387,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
 	age = (now - ifp->tstamp) / HZ;
 
-	regen_advance = idev->cnf.regen_max_retry *
-			idev->cnf.dad_transmits *
-			max(NEIGH_VAR(idev->nd_parms, RETRANS_TIME), HZ/100) / HZ;
+	regen_advance = ipv6_get_regen_advance(idev);
 
 	/* recalculate max_desync_factor each time and update
 	 * idev->desync_factor if it's larger
@@ -4595,9 +4600,7 @@ static void addrconf_verify_rtnl(struct net *net)
 			    !ifp->regen_count && ifp->ifpub) {
 				/* This is a non-regenerated temporary addr. */
 
-				unsigned long regen_advance = ifp->idev->cnf.regen_max_retry *
-					ifp->idev->cnf.dad_transmits *
-					max(NEIGH_VAR(ifp->idev->nd_parms, RETRANS_TIME), HZ/100) / HZ;
+				unsigned long regen_advance = ipv6_get_regen_advance(ifp->idev);
 
 				if (age + regen_advance >= ifp->prefered_lft) {
 					struct inet6_ifaddr *ifpub = ifp->ifpub;
-- 
2.43.1


