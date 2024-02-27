Return-Path: <netdev+bounces-75356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF0A8699C6
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA69B2A6C6
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42263146E83;
	Tue, 27 Feb 2024 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="guMpOjWP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE3E1482EC
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046130; cv=none; b=VgAvlqSbtYO7V+h+tLO3Lr9tiVYM1yE/d3fvlTpnP7wPXTLGWgHNut2CLspjgZIYBCuHR4P44tnrL22czBfaodWUjHC7sAAEFr/LravELFbXGsRb4aZDDTbs4V9TKw3fBqveg3pGGGCV9uvGJzoYZhlU27q2d7uFoGTGCPPkHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046130; c=relaxed/simple;
	bh=x2c9nMKA1axUnMu2DyjYUx8BQdPSCKuAQQDZDRELXho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NEw7R7QN6z/9VHAlCEKz4Sa+x6HhAVpflIHfuHIQ18LfiJTmSOAr0dLJWVDPrduSeagoc18jUiEDPHPhQs7dNSriYk9U2pfc57vSHC2eTfjg9dDDA0E1IMvcfoNnlGC2Xus9BvTZujKCb0guV1kyFNGdrpSfHr7o6pYkpw/M7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=guMpOjWP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso7833344276.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709046127; x=1709650927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=745wwRGSfwSLHPSu5VRPQses0YXB6t8LC+uyDRzZd1s=;
        b=guMpOjWPj+xygxIROqSXPGWmCv3hQA4LFQ8mNF2xSTrEIuoKT+0/g1X9hPdpAWeVWt
         LPUJYWRz51HNgXGGwrxP01AG+Ac85vmbyxJdsXCjFfR7hbEr9jnYs9N/WYxY3gs6wwG7
         DNt1D2z8ftp5d16LdtErSsvVwZHIF8qjWtfV5lMPzSfEOYnehGbH8ede9s8XJ0gJrY0M
         5ZYmKMdUvuU3TxuN954aiOYJBSRGzwLLC8EBnhWRSoQ8Vv6r0zHV6S919PMySYBrMOzx
         +AQp7fz8L1VAmzpMGaOHlnfd8257wjyy9MqMtR/N7xcLr0bWgpb0qAtUgKow1Pc20TIC
         KASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046127; x=1709650927;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=745wwRGSfwSLHPSu5VRPQses0YXB6t8LC+uyDRzZd1s=;
        b=aodQhoEfjF4wQmU3aEwu+AUwd1Megv+q6jSjtnGf7HRYQf1V+yNtNr9K/BemAZYvu1
         xRYdTHzHERMPGBMDBj3R53Fdm8KmhvMZimkCbTxQnTAr4Z9vKLKrsDMP5e7kJWaG+iDs
         7s9P0wDfWhZj9Gb2bw0R93fExmWf9AGAGO4e925haTazZet5AbW7mvsYlDlRkpy16N1t
         /9CY7i9yHGAQj3yrCzFeXlul1FMKiiV+WpqURZ22xD/7YXipDqUNFPBAJtYh2lFJCv33
         /ekpKmpoYDQLGwsTzbIdvAHK1wlsKCgmGyI9eyuQ3JWb6LKaNQegeMv9TzdaEvd9g0cx
         3PWw==
X-Forwarded-Encrypted: i=1; AJvYcCV0xOJ3aoU0GK/VuAiYW1G8esYOyHZx7ifmT90Qwf/KIKHDW7Vdd6DPN9GTgsUP3+hvNqqeVLORniqDDLcPplpp+wdzHniq
X-Gm-Message-State: AOJu0YxeTa5Vr+dKhinVjLiUu69m3IMXgUVXUd5/2uI/QQKOdNeEVAY9
	2WJGh/krIUrL0oD5gPV1QW48rOLBSlfntNqpyyn9c1IdbjZLLafmmr86p6H50Jmg+XfOghOC5+Z
	cQUyHnaAzKQ==
X-Google-Smtp-Source: AGHT+IGpsfoGastSgnzZyc0GVkEp0pxS440lPnqFDOrc8Q2y6brJks8CJSWLk1Ob47UGzBk4M+cCb0x52zsn2Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:68c8:0:b0:dc6:dd76:34cc with SMTP id
 d191-20020a2568c8000000b00dc6dd7634ccmr89437ybc.1.1709046127722; Tue, 27 Feb
 2024 07:02:07 -0800 (PST)
Date: Tue, 27 Feb 2024 15:01:48 +0000
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227150200.2814664-4-edumazet@google.com>
Subject: [PATCH v2 net-next 03/15] ipv6: addrconf_disable_ipv6() optimizations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Writing over /proc/sys/net/ipv6/conf/default/disable_ipv6
does not need to hold RTNL.

When changing /proc/sys/net/ipv6/conf/all/disable_ipv6,
the generic WRITE_ONCE(*p, newf) is enough, no need
to repeat it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9c1d141a9a343b45225658ce75f23893ff6c7426..88b129b7884564876a51b359137c33e9b75ee9de 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6398,25 +6398,23 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
 
 static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 {
-	struct net *net;
+	struct net *net = (struct net *)table->extra2;
 	int old;
 
+	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
+		WRITE_ONCE(*p, newf);
+		return 0;
+	}
+
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	net = (struct net *)table->extra2;
 	old = *p;
 	WRITE_ONCE(*p, newf);
 
-	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
-		rtnl_unlock();
-		return 0;
-	}
-
-	if (p == &net->ipv6.devconf_all->disable_ipv6) {
-		WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
+	if (p == &net->ipv6.devconf_all->disable_ipv6)
 		addrconf_disable_change(net, newf);
-	} else if ((!newf) ^ (!old))
+	else if ((!newf) ^ (!old))
 		dev_disable_change((struct inet6_dev *)table->extra1);
 
 	rtnl_unlock();
-- 
2.44.0.rc1.240.g4c46232300-goog


