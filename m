Return-Path: <netdev+bounces-70448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF1084F020
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 07:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98416B2227C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 06:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D90157323;
	Fri,  9 Feb 2024 06:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ4nmx7g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78957310
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707459095; cv=none; b=P7pEPOF4IE8OdWkKWJt560s//GQKkOPQ4M7EXKm9/QjQTW9DaF8kem+8aSjeykyx9ejSI8p1v5Sta8GpTtZeXCdAgckN5fbakWe6qyx+Cr9TCRZZzgFahbImGqJLfH6AfZ6UWWu/+yY5n73Q8PA0EoZIx7bpJynYlua0dhcXMeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707459095; c=relaxed/simple;
	bh=dZG0QNi7SRRemjy+9xsvodF2DVs27fYnCafIVrknPc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4sMlt0UcNlZimzVfqaryAH0ttCRnhYM649cCAUCOqWNTsez4QRbo3O17ilc0zhNRh+Njc1HnyEvchtYFLfwcXJ+G56cPS3JLw+Thsuebh+DBEIkLa1NXRytCFoJE4q9xN9v52gSer76DtKgPSHnikN1et4rz49Dox7QT8e1Fjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJ4nmx7g; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d70b0e521eso4556105ad.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 22:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707459093; x=1708063893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sM+bOrDz8l8mOQF3TbcRWuLzYmI3ryKTQszVG53QEDc=;
        b=jJ4nmx7gcHhTkrQ+Uy9cYd06+Kw5r5+WFZ9+K12RsZGc0PpUPghVVkPaCKIrr+FHM8
         bfXt3EEhQWGm7g0O/bMDkX+CVq0pGvUyESkhnmjFLo324AnxjaLQBMtAuLEcee7GErfj
         rTuFjYxjxhuGcRnIl69yHY9jwWqyMKJBv3Fk0VXc+aa+GdNCimic348pw+XMFtkACPnT
         vNjxBgx+KrvyrdgqPc6bC3hkqjtE5Z6kT441JhMYHQCx2a7hoXrgq7M+B4fRY0ntXY/N
         yYCwORKMqaARI7T3709+oxjTYDm/hlepWM69qQyG+flCuGxVPZxD3chUqNAc7fsKoRkC
         nigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707459093; x=1708063893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sM+bOrDz8l8mOQF3TbcRWuLzYmI3ryKTQszVG53QEDc=;
        b=XPFoMVuHDrLkwLa+dET1OCJYe/Cu43EcZQ47a+rV81dMACK8ChpMN3e87Wng4jGway
         ZUeyYayQxFIvXDGFo2IHw4oyzxc8hSonG4rNLVnEcxveITB3Jc+F9lai/6BwHQg/2J1P
         gYdMRsqlpv4VGY9wBcsvMMZzK63p2byzpnFMDcXlEMpWKO1EAbzDFY4YLZQzEXgXXheZ
         vvZ/OAhgKgc8CgivGqfe8YjEJTYITfacsX+mBc1LWy7ETTCxzqwTOl13rx1qZVoZE5Ca
         cWBVlfdr/wBuVovCrAT8cdBwMMmDpYMF9R5Tv8ON/REbCee3/NLVmZghP5c9gUgHOG5r
         AWlA==
X-Gm-Message-State: AOJu0YxMqNx7ymtZMxO7I7Mme/Wxuh4ti7ePt+OMnZd8FGB9y4/dRRIP
	85/nVObn5jWeTxj/QNVk+Dt4AIWHJIWZIYt86gVnBrkL5WPNdT7Rq0G0tv+v4o0=
X-Google-Smtp-Source: AGHT+IGk9n3ZvfHCVpqVhZQz+azEG+pdSAVhPjmJoWF7AFiJF3vfcOT2y9h4GcQCVYjqGUXmlO1xgw==
X-Received: by 2002:a17:902:c408:b0:1d9:aa2d:db69 with SMTP id k8-20020a170902c40800b001d9aa2ddb69mr693411plk.19.1707459092683;
        Thu, 08 Feb 2024 22:11:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTkF0V2G9TkUSEkVvoBl9Zu3f78b18MfHPYpxLY/eD54jS9su/W3bVh5eoZK4aS6DJMwv42D/ozi5GQDf/3MC3Llg95xkY4NE7TMhPR4spSeE+Pazp1jmoQH/OrEOcEp/4E5j1n2TXeajVYywRWtOWxlOlRaM/wYfI2QAecRWUeavHPt5naQKBiZxfaDEaMIwTxWFoz6FeAKMIRlPhvjuwbk8BAH1wlRA/boCstTdtd9yc7VOFrUrbfd5pGCrl2At9hnkFKZ0=
Received: from petra.lan ([2607:fa18:9ffd:1:3fa5:2e62:9e44:c48d])
        by smtp.gmail.com with ESMTPSA id je3-20020a170903264300b001d93765f38dsm740843plb.228.2024.02.08.22.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:11:32 -0800 (PST)
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
Subject: [PATCH net-next 3/3] net: ipv6/addrconf: clamp preferred_lft to the minimum required
Date: Thu,  8 Feb 2024 23:10:28 -0700
Message-ID: <20240209061035.3757-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209061035.3757-1-alexhenrie24@gmail.com>
References: <20240209061035.3757-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the preferred lifetime was less than the minimum required lifetime,
ipv6_create_tempaddr would error out without creating any new address.
On my machine and network, this error happened immediately with the
preferred lifetime set to 5 seconds or less, after a few minutes with
the preferred lifetime set to 6 seconds, and not at all with the
preferred lifetime set to 7 seconds. During my investigation, I found a
Stack Exchange post from another person who seems to have had the same
problem: They stopped getting new addresses if they lowered the
preferred lifetime below 3 seconds, and they didn't really know why.

The preferred lifetime is a preference, not a hard requirement. The
kernel does not strictly forbid new connections on a deprecated address,
nor does it guarantee that the address will be disposed of the instant
its total valid lifetime expires. So rather than disable IPv6 privacy
extensions altogether if the minimum required lifetime swells above the
preferred lifetime, it is more in keeping with the user's intent to
increase the temporary address's lifetime to the minimum necessary for
the current network conditions.

With these fixes, setting the preferred lifetime to 5 or 6 seconds "just
works" because the extra fraction of a second is practically
unnoticeable. It's even possible to reduce the time before deprecation
to 1 or 2 seconds by setting /proc/sys/net/ipv6/conf/*/regen_min_advance
and /proc/sys/net/ipv6/conf/*/dad_transmits to 0. I realize that that is
a pretty niche use case, but I know at least one person who would gladly
sacrifice performance and convenience to be sure that they are getting
the maximum possible level of privacy.

Link: https://serverfault.com/a/1031168/310447
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 net/ipv6/addrconf.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0b78ffc101ef..8d3023e54822 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1347,6 +1347,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	unsigned long regen_advance;
 	unsigned long now = jiffies;
 	s32 cnf_temp_preferred_lft;
+	u32 if_public_preferred_lft;
 	struct inet6_ifaddr *ift;
 	struct ifa6_config cfg;
 	long max_desync_factor;
@@ -1401,11 +1402,13 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 		}
 	}
 
+	if_public_preferred_lft = ifp->prefered_lft;
+
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.valid_lft = min_t(__u32, ifp->valid_lft,
 			      idev->cnf.temp_valid_lft + age);
 	cfg.preferred_lft = cnf_temp_preferred_lft + age - idev->desync_factor;
-	cfg.preferred_lft = min_t(__u32, ifp->prefered_lft, cfg.preferred_lft);
+	cfg.preferred_lft = min_t(__u32, if_public_preferred_lft, cfg.preferred_lft);
 	cfg.preferred_lft = min_t(__u32, cfg.valid_lft, cfg.preferred_lft);
 
 	cfg.plen = ifp->prefix_len;
@@ -1414,19 +1417,41 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
 	write_unlock_bh(&idev->lock);
 
-	/* A temporary address is created only if this calculated Preferred
-	 * Lifetime is greater than REGEN_ADVANCE time units.  In particular,
-	 * an implementation must not create a temporary address with a zero
-	 * Preferred Lifetime.
+	/* From RFC 4941:
+	 *
+	 *     A temporary address is created only if this calculated Preferred
+	 *     Lifetime is greater than REGEN_ADVANCE time units.  In
+	 *     particular, an implementation must not create a temporary address
+	 *     with a zero Preferred Lifetime.
+	 *
+	 *     ...
+	 *
+	 *     When creating a temporary address, the lifetime values MUST be
+	 *     derived from the corresponding prefix as follows:
+	 *
+	 *     ...
+	 *
+	 *     *  Its Preferred Lifetime is the lower of the Preferred Lifetime
+	 *        of the public address or TEMP_PREFERRED_LIFETIME -
+	 *        DESYNC_FACTOR.
+	 *
+	 * To comply with the RFC's requirements, clamp the preferred lifetime
+	 * to a minimum of regen_advance, unless that would exceed valid_lft or
+	 * ifp->prefered_lft.
+	 *
 	 * Use age calculation as in addrconf_verify to avoid unnecessary
 	 * temporary addresses being generated.
 	 */
 	age = (now - tmp_tstamp + ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
 	if (cfg.preferred_lft <= regen_advance + age) {
-		in6_ifa_put(ifp);
-		in6_dev_put(idev);
-		ret = -1;
-		goto out;
+		cfg.preferred_lft = regen_advance + age + 1;
+		if (cfg.preferred_lft > cfg.valid_lft ||
+		    cfg.preferred_lft > if_public_preferred_lft) {
+			in6_ifa_put(ifp);
+			in6_dev_put(idev);
+			ret = -1;
+			goto out;
+		}
 	}
 
 	cfg.ifa_flags = IFA_F_TEMPORARY;
-- 
2.43.0


