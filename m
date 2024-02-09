Return-Path: <netdev+bounces-70446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B4F84F01E
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 07:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBCE288B35
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 06:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E2556B9C;
	Fri,  9 Feb 2024 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAgyyMWb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7C57306
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707459093; cv=none; b=kjmoaIhcGW3bd/QyVh2XQkqJh0MFwZnYZphWHMvh6VSC0iATJQ6hQ6jrXV69Z53bBFApGT8ffBGO0vHcu/pzTOelVRllgxNZ5/Qor5i/LlLSJO0zgrIIcRiZYF4hVwprxhmXYJZpUm2L6eoXdfWx+BEG82B69L4ZvN12+g/6pns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707459093; c=relaxed/simple;
	bh=ynUzPpAGylPTJLOrR9TVvlQRT3GJrcyzUzLgoh61uHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q482Aklv099qJNkoQROfMK+6/IO6aj4TS0c07IiNwkDS+2o4fZDQq0b2Uh9BYhbex8h9BXkExTusQStMCF/dh6XevlJse8Hln+t20kv59yQSocmPPYujRsng2AYgIL17kWPyuHF2cmcNRfxDUoNNgtWDr4kPBqKfT548e3MupAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAgyyMWb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d746ce7d13so5006605ad.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 22:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707459091; x=1708063891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w69FvwPxJEmTE4Nu5S/qqkjkkefb5ZX1gIWH2ZAd6AU=;
        b=aAgyyMWbMqYX1XfWwHEjLZCqENtzUDXdCoPjdAimWt+IDDY5B2nQmfCzS0kuqlYnD9
         22fwP/z1O82zuB0YMv4in7/fUZza6W9+0DgbJJ212lXoPJMPsJ1kPqGg6/G8ik8B//dq
         goOnwpAJ9xYBpDMnQ88R6M1CeOZn+2+BolqbomJcRppxKTGNea0oHeBgWBDuJlvveKrA
         4s+ygKJYbWQReluVOl6l1BLtdBziP1E1116R+xG456lzs6XKTweWeM929tGAOkIAg26w
         NLsFOOCKtE/ZFwqqDtRHXLxZKgZbRSKY1Qg/ayz3JeJSPpti5azp3YkmRUAraADYKjCN
         c5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707459091; x=1708063891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w69FvwPxJEmTE4Nu5S/qqkjkkefb5ZX1gIWH2ZAd6AU=;
        b=J6OKMrKQIA64LeXKd7qfFIJUmCpALDUT/35aY4TiMVCi5T5ClWWTPTbqP0JyfKi0J4
         zADUhRwJnpi/rmqKJHbAZbVHC6PRTetjzBW8aPKzxtgjpWEZ/LL+3LdM44UrrZ1mcnIx
         7iF0sSeSx+okVYbP5wXIXlHusnJXdw6IAtiChxN07SlXnJ7mGT0VkNqOA1LncJNIwo/J
         O0HUM+gg9zL488OHMUueL3zXxG0PMYJQ4W/4paCI+PA+9ukOrwm3O/5Bv9+wKIk5d+fK
         OvMSr5AxKmC2f7c0al1xzA4VwZxF4Q87IEJLSE/9l8DoMU2guQ9mKYjSI6F0ocU3aTkG
         +o1g==
X-Gm-Message-State: AOJu0Yy8V/a0uWGSAPg1A6dhML3NVQxpkChaU7bU58QPixsPiuv1B0jE
	JvqVkTcVjraSt2l3y8jvGK+TKShJNrPp6jvhTZqKULILpJf3h17vZTkxrkNA2Zo=
X-Google-Smtp-Source: AGHT+IGSmQFQJZvypTr+dLZJ9+yhr19NLuqkqAKcJiGC7Lmnwj0okZcUm9ROLLrecI2vxVhrbZofiQ==
X-Received: by 2002:a17:902:6bca:b0:1d9:2086:fe5f with SMTP id m10-20020a1709026bca00b001d92086fe5fmr629282plt.47.1707459090802;
        Thu, 08 Feb 2024 22:11:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuKIOfbMMkj0lZWQyf2Mwva6njeppA67MLa36Vt4oaK+x3iYDgKMZSvZVjr9HXuRa0A8VegKiXEmne7zoxd62bd5qVOyxGV3FhSy9h0LYnRmZiw7ga1Gy1uPjqgUz55aThRIfDeDiMJ74OEo6OozGxNzxQJ11rULqifSCVLm8vy0t0y6gWlmeNZ0ANVzQaNXQ+/17imhCLgbnqzYVd5lnSxytkgvxaDQthDS7EBm4WUeeIgDJ1CgzLMiae47m1gOGZjE7frwE=
Received: from petra.lan ([2607:fa18:9ffd:1:3fa5:2e62:9e44:c48d])
        by smtp.gmail.com with ESMTPSA id je3-20020a170903264300b001d93765f38dsm740843plb.228.2024.02.08.22.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:11:30 -0800 (PST)
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
Subject: [PATCH net-next 1/3] net: ipv6/addrconf: ensure that regen_advance is at least 2 seconds
Date: Thu,  8 Feb 2024 23:10:26 -0700
Message-ID: <20240209061035.3757-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 net/ipv6/addrconf.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d63f5d063f07..99a3ab6ec9d2 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1331,6 +1331,13 @@ static void ipv6_del_addr(struct inet6_ifaddr *ifp)
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
@@ -1372,9 +1379,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
 	age = (now - ifp->tstamp) / HZ;
 
-	regen_advance = idev->cnf.regen_max_retry *
-			idev->cnf.dad_transmits *
-			max(NEIGH_VAR(idev->nd_parms, RETRANS_TIME), HZ/100) / HZ;
+	regen_advance = ipv6_get_regen_advance(idev);
 
 	/* recalculate max_desync_factor each time and update
 	 * idev->desync_factor if it's larger
@@ -4577,9 +4582,7 @@ static void addrconf_verify_rtnl(struct net *net)
 			    !ifp->regen_count && ifp->ifpub) {
 				/* This is a non-regenerated temporary addr. */
 
-				unsigned long regen_advance = ifp->idev->cnf.regen_max_retry *
-					ifp->idev->cnf.dad_transmits *
-					max(NEIGH_VAR(ifp->idev->nd_parms, RETRANS_TIME), HZ/100) / HZ;
+				unsigned long regen_advance = ipv6_get_regen_advance(ifp->idev);
 
 				if (age + regen_advance >= ifp->prefered_lft) {
 					struct inet6_ifaddr *ifpub = ifp->ifpub;
-- 
2.43.0


