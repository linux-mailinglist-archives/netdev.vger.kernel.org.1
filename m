Return-Path: <netdev+bounces-200818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F24AE70AA
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8BA3AA48B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771792ECD0B;
	Tue, 24 Jun 2025 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G92HF9YU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA22EACF2
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796786; cv=none; b=NRrBsmh8oFw1qlB5kw1W/F3HD+0g69bZOIenAI0v3zdHIXPJ7FpNBr8WVp6fvO+tjvuA98XgqyPcP/cs0xG2sbIa4fPMJpdLDqNmHAZdbnDT+Y9+hKXP9i/UJ1DmmbJ6qFVK6i68H8s4dlafleP7Y0QUFxIkzqnMCaljyHkA3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796786; c=relaxed/simple;
	bh=d4q0GIFHsXzAi8nQzfGppwnM/ZjAt9wbO8eR2afszR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvTVO0A8WNsPP+KLhhlIcdXydQIVSmx0yEnB+XMHQRU4LIhWVzYHI7/aE0+Bg+NcZf39jXo1MPR8esIa6gwyOKXtEbxSxRrmCiJajsPdU6rKSQ+MHp8RKIfXOHJCsRAk5mTEkiNtEMnLC/PVgWR8g4t9Xz8Bo02COcC+FBSwGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G92HF9YU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7490cb9a892so348548b3a.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796784; x=1751401584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNxb8GeTSkXmOqDfB91SfjKPy7YHoEB8WEuzrKOdgRw=;
        b=G92HF9YUySj1i1UHIh3ptTczm5IB8WcJO4bNws5moC7GbLfVSwCfrqb/gEHxyZGr/I
         eo3A6E5x2TZMjde1hhxP3OZlIK+9EBXKxOhwWiK29oOo3zDaQK6RREqL2CYCa8eeaYEf
         36prT1TGfb5quZiJNOV7bSnR7DXbvEcYWkInDYUKZ2wmaTH4ry5IsDc0dz+TjBURSBnd
         fBq1Ly37ZWerA1Zw6u14NnE/FaPbsSn559rNFY6qeZ+1Tzv0dr5K6WD9tfwbGofEgvSp
         UuY64t3qRBxa9clE9SwFgKpinlerq+3QOfO6XAxUHRukJvF+46z4vOLw397K5IKZDeNa
         jubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796784; x=1751401584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNxb8GeTSkXmOqDfB91SfjKPy7YHoEB8WEuzrKOdgRw=;
        b=mGvvWxPuA4fh1H0DQrOZ0gZur6j79JVjgHPya9Nxfef7rl1HioRJmk9oJwuvtSJIWf
         zirBc5+0SKs274qy9EhFtdiMvkGpAzCC/hobclPPgm7UgWt/WgZIU6HxZxQFBFM18GCp
         7z5uxShUosOSeAOIdhtaoB0gYniLkZ3VONdWZiqW4OA1PQnhVE2PeQwplD1zbZ4cbx9M
         lvT3GCTRlRf1krMVkzRgef8qkAWVDo5dFwgGrKgLw3X+Q32duLclXR8py1c/h8ryqY2I
         xLMgC5OBbiOTahINRYi8MDzP+/hoFQ9WCimIqsZx/+8sRxNgImtnCnq2vdUrMdMNOD1a
         yQLA==
X-Forwarded-Encrypted: i=1; AJvYcCVaNVt6e4edSEb7/ubTHY0sXcpBBz1QKag5BGn+mss6DtAXccSXUdhWt88WoGcwJ4FNy4pKaCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfoiPoyS88X0VlwknV76a3VHMKxXHUX6p18BpIhlWkzN/C8MDg
	ZpNwQPe7xgu8le3w/0zWwreS9BPiy1Df9MkyBjO3oJczBkZTgJV/Yg7jATCZPmva9obL
X-Gm-Gg: ASbGncvXI1BOYmCc7+JOdgkLodcfwS9zws0NhTUP/qTLYjVO5LiykclfOUkZ2tzKz6a
	pEtNLJr2Zt2DBDrb2jO2G+SrjarsNo0Z8zw2ukpIa5PW13TyzHPssTW4KthbDDIij68weoVnYlp
	iuIG4w9+o44CNTyxzSFn+fdh0mSPbCbN/UeSYLi8AEvLTwL6mpnY5bXcWLh1dZS851bUYVWTNRC
	L8cO4kIjNK0guQMefT0CZmdH4rHxnmDYsiurU64avlm3/MQEwTuMuIpB8L1VQktLkcBilgTJ3F3
	k9p82VtYox+oyJ6g5xHqAHE/rUUYmJtgqFtipvs=
X-Google-Smtp-Source: AGHT+IHByEREGEoES6fzoH5uAUeHg/rFmxE3PBuT3HTYNHjLtAtcLylzsUcql5UR+kZWujUr2fZ3yw==
X-Received: by 2002:a05:6a20:7f89:b0:1f5:7eb5:72dc with SMTP id adf61e73a8af0-2207f13f620mr561833637.3.1750796784228;
        Tue, 24 Jun 2025 13:26:24 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:23 -0700 (PDT)
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
Subject: [PATCH v2 net-next 01/15] ipv6: ndisc: Remove __in6_dev_get() in pndisc_{constructor,destructor}().
Date: Tue, 24 Jun 2025 13:24:07 -0700
Message-ID: <20250624202616.526600-2-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624202616.526600-1-kuni1840@gmail.com>
References: <20250624202616.526600-1-kuni1840@gmail.com>
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


