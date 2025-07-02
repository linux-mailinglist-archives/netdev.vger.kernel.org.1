Return-Path: <netdev+bounces-203551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F66AF65BF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8031C416CF
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686E724E019;
	Wed,  2 Jul 2025 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajDkHLoQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D4230BD2
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497338; cv=none; b=OIzGHAu4eR74hW1bIIb9d040U6j0WBU2+7DIvX8hGMlrXHj/GesG8DpH7Amm+XbIPVr2BnC9VQQRpXkKp/fmuhJOlF9+TtX9wk43cTIohSi3OMXtoN8urOKIvlmaPWwIfRQFCSY3LeJQuhpOsEBIV675IXnOyb39YH4XezVAgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497338; c=relaxed/simple;
	bh=nO78TbKs91ozADxWKNn+m9v63F3m+bMMAoIRowe0M0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqIuuVSxZaHygUto66iAvRIWEPHsKAMctmTu8GWoem/ElmZicTL1OoI5Lh86jdhkpMUPV4Zm/zj6meuCyEQPjKWtYDpphqmRO/JQ1P9z2uT+eR+7S4zR5lPAxvzmWaPsHZWe8IRdYW9xlzPgJacgfnZt5/sbHuGWMfwtyyqb1aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajDkHLoQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-236192f8770so2488545ad.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497336; x=1752102136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9rBjQOwOQsnp8nopCwxIbi9bZFuQ1NMnnhAyxf3SwY=;
        b=ajDkHLoQA6FxG5n7ENdp5bXIElaI4mybVkAFAgkzLfI9UoQ8dln+jUoh+FfLVLuZcc
         5ZU4Pj+LDARPlRW6r97gaIYATE76F1FHGHY+pp+UeG0dovHENZJQ9UiKoDVpfyc1UPmX
         iOMUpSg+m2x12/FwrC0Wo0DgkpUe1D3Rw3b3ZICVJnnduaIYg1+NjZsvsm1Zzgqiobw/
         3AAjograylgUlWkeo6XNc/fAZEj4b36mwR3mftZh3fAGOZ/rRk5MkI2KXPJr5r6R7c+H
         BKp1DE6D7AXM+eSSIUw1pONUTMqtFx2yOXwq32qYgXtc5yQODvzBX+kk+o4HYDKTkPYM
         rVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497336; x=1752102136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9rBjQOwOQsnp8nopCwxIbi9bZFuQ1NMnnhAyxf3SwY=;
        b=cfx0fNfqAuBjPdQY4rcwH2CBfyf0vvk0Pu4JYSRYYhC4JikiNiUoQuqBRHg4Ri3CvR
         eBdTMugEZnq0R5Yh/WtlxgyUBMrh4XCNfrsSAuEECMmw73KowwNHj9HemHxlxcHo5+Y9
         /ryYI6spC4z2wG8EOn8DLwrGQ5ugIpjvyX0To3P13SAAf+DV8ErDeWaAONMQBqzzhvJq
         jpVJNP57ux0msADh+YHz6zOnXt/YyLgDfalThT6649TwM4Hi4GrmDpG4CcrsN1sMmbfa
         jeJw04SGGgLbrGdBUwVvv9TIAoMVXFIxRg7REY6k/XQslK7VivzNjIy77VUbiprva/4F
         V3/g==
X-Forwarded-Encrypted: i=1; AJvYcCUTZ+nBJxxy1tP4tMpXwgsgoBz/B0FxB6OcU1S0+b+Q/0VMPE+FjSg8hg7kUY8zq4P4XAX/7q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRW7jQnIT6Ua0lz5+GboSY0xJN7CVTT0+h6hIDQzrPcQGF7L3k
	Nl73QAb6kxkaEQ6b8xfscMU+S+sJJB7Tly9iXl4Q6OHFprpOmy0hQ5E=
X-Gm-Gg: ASbGnctWIjLXH9TWtvGnTaxfov4ytit0qx/Cy7NHE+ynHykOhZ0RRkUxgkyoQDTgI/0
	Bkjjh+huwoSlFV6Vz0KuKp57R0sRBzTXDwrnzSC86/DbxxSoNYMAp2U5JQkIWMPDWlail4498Za
	Yh+Si126yoh/zYpN4zitSzhvhF9KQ5kI0Nee2KfF9pSm0EJiMsAilXTBC327Q+PWf4Xw91LBvYm
	PAG4XJdq35AMoUa4l9J0w7f4Im5WiJ41o6qDnxbKCVoqeXUZ5RIIarO0PU35GVzYGiOMd3OKTzo
	VPM+0yNUeIuyWsmvolANFBWJ6lcEAS0ex9Ji/Z+GEMCTTqHKDw==
X-Google-Smtp-Source: AGHT+IEhiJC7TlX6Ve+C7WMnDMM5qMyWYlJN1/ZQhzjZLWavmcwOH0hokTGTPt94cZdk/GLkmqEC2A==
X-Received: by 2002:a17:903:2407:b0:234:2d80:36 with SMTP id d9443c01a7336-23c7b8bc5afmr228905ad.14.1751497336179;
        Wed, 02 Jul 2025 16:02:16 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:15 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 net-next 01/15] ipv6: ndisc: Remove __in6_dev_get() in pndisc_{constructor,destructor}().
Date: Wed,  2 Jul 2025 16:01:18 -0700
Message-ID: <20250702230210.3115355-2-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702230210.3115355-1-kuni1840@gmail.com>
References: <20250702230210.3115355-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

ipv6_dev_mc_{inc,dec}() has the same check.

Let's remove __in6_dev_get() from pndisc_constructor() and
pndisc_destructor().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3: Return the retval of ipv6_dev_mc_inc()
---
 net/ipv6/ndisc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f2299b61221b..28f35cbb6577 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -377,24 +377,25 @@ static int ndisc_constructor(struct neighbour *neigh)
 static int pndisc_constructor(struct pneigh_entry *n)
 {
 	struct in6_addr *addr = (struct in6_addr *)&n->key;
-	struct in6_addr maddr;
 	struct net_device *dev = n->dev;
+	struct in6_addr maddr;
 
-	if (!dev || !__in6_dev_get(dev))
+	if (!dev)
 		return -EINVAL;
+
 	addrconf_addr_solict_mult(addr, &maddr);
-	ipv6_dev_mc_inc(dev, &maddr);
-	return 0;
+	return ipv6_dev_mc_inc(dev, &maddr);
 }
 
 static void pndisc_destructor(struct pneigh_entry *n)
 {
 	struct in6_addr *addr = (struct in6_addr *)&n->key;
-	struct in6_addr maddr;
 	struct net_device *dev = n->dev;
+	struct in6_addr maddr;
 
-	if (!dev || !__in6_dev_get(dev))
+	if (!dev)
 		return;
+
 	addrconf_addr_solict_mult(addr, &maddr);
 	ipv6_dev_mc_dec(dev, &maddr);
 }
-- 
2.49.0


