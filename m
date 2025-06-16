Return-Path: <netdev+bounces-198327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF37EADBDAE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1CE189023E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C556230BC9;
	Mon, 16 Jun 2025 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0O6YFdo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD522264AF
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116882; cv=none; b=ndrlff3qnz025nvE4byb2z0qSPwmHIl9t1bUrSrf9YVVsu63JA4x70gPF38NxheSUqPQHEe4o16pcvxdxwPzFmw5WQ8vEIU84ayPtImu3U2EFhEvAGDWuSj8S/yYCIqClQJiG2NV28mVbH09SI4dtK3U26IY/31yISRIo1lDFuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116882; c=relaxed/simple;
	bh=d4q0GIFHsXzAi8nQzfGppwnM/ZjAt9wbO8eR2afszR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cv8gYTX/LO/1U6z8xhnTKepr0xmTy/U4W5yVa6EyRieDUr7AkeJGSuYqDlw0ttr6qppHOD85h4ktbXcF8AuuRIqADIvwpIWKm8nFKmlcRViPMcS6lP2PDNpEH+H3Q9CJiIwGPi2AygnFdsTKCPHo3mmH8J3bUhs1VuXQBpSB38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0O6YFdo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2351227b098so41574075ad.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116879; x=1750721679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNxb8GeTSkXmOqDfB91SfjKPy7YHoEB8WEuzrKOdgRw=;
        b=N0O6YFdoyJlBg+FYFsvgxHeSu0O4uq7yUFBxv5zijlQT0RYWLma7Mqbc+b+IIm1x76
         ZcQkTvY374ZTCdiR5tKxpl1Vab2QINpZCfKHKkHIYRX1SgUMRmsggcmzP/AGwsL6zRVG
         +n5h8PWAj5v477auqs77g/TJdOudnLomMG/DSXU97wPbQX25IUJg0Wz/qknm3KzZ0uOK
         IW+mv82ifDvLb46BBy4oMDtMxri8pIrW5PQZTsS3CY4vrmGnYy5vlmfghrBM5GCmC5ym
         e5MO9aiEb9/0sCe7QyZOK4a6Fr/mSWFweYbMWAJ34bofW8HTWV2Iiy5hYRk8yFJ2igVu
         Wqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116879; x=1750721679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNxb8GeTSkXmOqDfB91SfjKPy7YHoEB8WEuzrKOdgRw=;
        b=MNEcJrNp3g6Z/WaM64fCMIj1IQkGPJXrfTAHJlNSQiK62NFdA/gpR796rYUSHhwoWe
         HuhDZSwB5yV33I9SDt15F/M/PGVvL+5ocLcs7RhLgbCBTYcwz509K8NYl08p0aSJZUDv
         Oxzc+QD0MbGuGJ/fiTVuEOEu1yZyIgCtpGDe/IZhG2yl8m4GuxgAMBxDsmD4vfLjsvr1
         8xhLjK2OT4CiKBtXemPwArhK4IyWXkSLpgxMJoaCcwQi0SRG3YV7v2nv5BdjEXXvcHne
         TKywaFIRJBKK4FP+8rQtVe+eAmo+o6FZjMOu5+JUHuZyQnDckiXOrBTVlfiAg7O14Qgo
         sxeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhbDHq0nflDRBUwLGSHmtv0eaUgla5bfVFaBzJjefFYFiwHOIHXCUXpaSgvJ1/q9n7jmBfY9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAC2Kv6LKlC7jFHuuo6zMqmnYcCw7TmXKYW0jAuHW6dSJpSfRS
	9ncthcmhSW8oeAJcVNaQWYSiRasqEGdv4wvTu83AnI8qwTnmxziduGk=
X-Gm-Gg: ASbGncvCyE6xo73TrSH0MsRHgurJXQ7g+yqC7G3nBL/fFau82SBwLDFIMow/884iIHb
	qNM5PAtewL4GwQDQ25RKwxGWH9MxuOfEgN6pZ6k5yTEVupS2s3gwZGc7E9nksDH2k2hhOM9Xr1u
	nJlC/jSUiR+3U6V4zX9vr0ypKGyZ1YjMFgW/R6YyzmcAoD8o5EmSl+6vz70MyH/6QhbvmbZsC56
	NjE1CN2TiHIIe11lraW+1lg5l7dmnU9czMVg0nsNRomwKcF+2gYmeqx5y1CGv7+3Hq4SrQ90C9B
	vqyn8LKtn8ZMNYSum7l96ZOvPEq882enFu0iSNU=
X-Google-Smtp-Source: AGHT+IGwSBacH8j0iR4NAV6+lXu3mXGTM/XxeAZDzk9OijiaeneSTKDe+EVGDfaxhfqnl7U8K3yXCQ==
X-Received: by 2002:a17:902:7049:b0:236:748f:541a with SMTP id d9443c01a7336-236748f5e94mr89396395ad.0.1750116879159;
        Mon, 16 Jun 2025 16:34:39 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:38 -0700 (PDT)
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
Subject: [PATCH v1 net-next 01/15] ipv6: ndisc: Remove __in6_dev_get() in pndisc_{constructor,destructor}().
Date: Mon, 16 Jun 2025 16:28:30 -0700
Message-ID: <20250616233417.1153427-2-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616233417.1153427-1-kuni1840@gmail.com>
References: <20250616233417.1153427-1-kuni1840@gmail.com>
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
 net/ipv6/ndisc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index ecb5c4b8518f..beb1814a1ac2 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -377,11 +377,12 @@ static int ndisc_constructor(struct neighbour *neigh)
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
 	ipv6_dev_mc_inc(dev, &maddr);
 	return 0;
@@ -390,11 +391,12 @@ static int pndisc_constructor(struct pneigh_entry *n)
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


