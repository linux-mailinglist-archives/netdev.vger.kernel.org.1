Return-Path: <netdev+bounces-75361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7719A8699C8
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D543EB24E3F
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D107148FEB;
	Tue, 27 Feb 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BH4s06pZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0011487D5
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046138; cv=none; b=sFNvEq0djpwAoOU8R+S+jYWc+Cwifhf8ENmM09RpwiOOncqARPXCjfWBdOMhh/lZUK8eErIkAxkH4Iz+tQZovdbteHAyJ/yc/FtRNaMTrKAFtSUafSouI24ECGX63oO09iwJwA+9V8tP2XrZ7TApYSXA1LPKYF/CHRy5tPB5fME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046138; c=relaxed/simple;
	bh=bvgy3BXTDeDwSpNUb5X9z4U+xzt3f2Jbqki9VxAB4DM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M+ZmjnMiufnPhAptBMEjGG4kbdV6vLCSdJfP5jhrVxKQnHzgvnXlZBoFYUxL6POK5Vb6k/2cmw6NCdxQhh9WjM5/A4bb3rYRN/WWqu/PYpKiVwBClPmiE6PXs5dfgB0t31T0uow49nwNWXlJAg8Ed33JQySnggmMWwSQlKbC2H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BH4s06pZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc15b03287so5703074276.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709046135; x=1709650935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDbTPmNx3OQeJaBavQrvUs3QxSO4pTm+H8no80/PDnI=;
        b=BH4s06pZW1DfMIOxfzO8YjNoQhewsaOQLwSxwtCQMIUwwyd33YaVkyS2FSxidLnKVJ
         K56eVeAVFFmOoFXtYkeRSJz/PngoVGzChQNQE05p/0e2g5c0RzF/wwtCLa13hRE+xnqt
         87amTjJTforS1L9GG04nC2XJAiScCHKvPZczUaLB/KWvW/NH5Y8WZ+2YSe1FoeuoKccC
         ERn/b9ERj+3hLA7mGWYyL9EYDCeCqUoiHTQCW5ymsSsl0/lARXCFg7Q8kf03nA0RLQst
         djGoYJxbAsgRyDZzfQ8UD91Yf03grzwTfSwYZ3Pm2fGkHOiPTpFw4Ygf4O2YQoCPlgPp
         C6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046135; x=1709650935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDbTPmNx3OQeJaBavQrvUs3QxSO4pTm+H8no80/PDnI=;
        b=M46f5+tww7rFf1CNOt9ts2O+2X9WBANGtoYx/rwSRY1PK62+Mk+wXhafqMzWVSPRbx
         Kf6974kjyaau6JoKdfn3LyeI96TGnZSV20MF5hz8gsa0Wb+CethzkCEal9cytoPEKDT/
         EzeTu2b5DlictsXsdhlB3/7v0Lluy9ZaqbZLW3xbCoHjGvXv0HVibn5vIvOpgXkJwgd9
         ThYl8cJo+IOSPSMTdHdIvzT1yHAlsgq3rQF0sN7p8wry45gc7Bbmsa7nlKUwAtO8+wXJ
         4Q3bahqek7QpvQjUPGO4VJRIw1Xn2Nw01t8r0VIjl79aT0IBTKnyfC789WkfTwVcyGje
         DWLA==
X-Forwarded-Encrypted: i=1; AJvYcCUxV/VuJlMKmhJ+Z/1QqpxKJxNA+sWlzJMVqwDJsMfl2o5IiIu0GajTg3pqZhK4eajQwebky66N0krX9EK17L3OTmLKZQ1N
X-Gm-Message-State: AOJu0Yx5qgneZ5CMiTntuYH/CGQtrlZJPFtl6jJHLHjG5+V5zGR6ZBD8
	YynVYLJC9M0WxDBmMfVmzr7oDaI5QtMQyyuvN4nrp//U3azzVqtrMOuQxxdHEI8DwBo7DYMPRfx
	qPKhIMIZAkQ==
X-Google-Smtp-Source: AGHT+IEEFIzRLP/gfeTAL+wWUyE5VkNzh9mMS2uWQrJEBlLC/4fQDUVwTm3J648wM9WcGG6So/nOMnOpwt+4xA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1081:b0:dc7:9218:df3b with SMTP
 id v1-20020a056902108100b00dc79218df3bmr96193ybu.10.1709046135646; Tue, 27
 Feb 2024 07:02:15 -0800 (PST)
Date: Tue, 27 Feb 2024 15:01:53 +0000
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227150200.2814664-9-edumazet@google.com>
Subject: [PATCH v2 net-next 08/15] ipv6: annotate data-races around idev->cnf.ignore_routes_with_linkdown
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

idev->cnf.ignore_routes_with_linkdown can be used without any locks,
add appropriate annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/addrconf.h | 2 +-
 net/ipv6/addrconf.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 30d6f1e84e465e06a88bbbffaee70fdbd4ec5dd3..9d06eb945509ecfcf01bec1ffa8481262931c5bd 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -417,7 +417,7 @@ static inline bool ip6_ignore_linkdown(const struct net_device *dev)
 	if (unlikely(!idev))
 		return true;
 
-	return !!idev->cnf.ignore_routes_with_linkdown;
+	return !!READ_ONCE(idev->cnf.ignore_routes_with_linkdown);
 }
 
 void inet6_ifa_finish_destroy(struct inet6_ifaddr *ifp);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 8da30b6391e792121efa0705d61c810d4dacd3e4..2f7b76a6ba7da21a51c4219bdb96b7e060583b65 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -566,7 +566,7 @@ static int inet6_netconf_fill_devconf(struct sk_buff *skb, int ifindex,
 
 	if ((all || type == NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN) &&
 	    nla_put_s32(skb, NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
-			devconf->ignore_routes_with_linkdown) < 0)
+			READ_ONCE(devconf->ignore_routes_with_linkdown)) < 0)
 		goto nla_put_failure;
 
 out:
@@ -935,7 +935,7 @@ static void addrconf_linkdown_change(struct net *net, __s32 newf)
 		if (idev) {
 			int changed = (!idev->cnf.ignore_routes_with_linkdown) ^ (!newf);
 
-			idev->cnf.ignore_routes_with_linkdown = newf;
+			WRITE_ONCE(idev->cnf.ignore_routes_with_linkdown, newf);
 			if (changed)
 				inet6_netconf_notify_devconf(dev_net(dev),
 							     RTM_NEWNETCONF,
@@ -956,7 +956,7 @@ static int addrconf_fixup_linkdown(struct ctl_table *table, int *p, int newf)
 
 	net = (struct net *)table->extra2;
 	old = *p;
-	*p = newf;
+	WRITE_ONCE(*p, newf);
 
 	if (p == &net->ipv6.devconf_dflt->ignore_routes_with_linkdown) {
 		if ((!newf) ^ (!old))
@@ -970,7 +970,7 @@ static int addrconf_fixup_linkdown(struct ctl_table *table, int *p, int newf)
 	}
 
 	if (p == &net->ipv6.devconf_all->ignore_routes_with_linkdown) {
-		net->ipv6.devconf_dflt->ignore_routes_with_linkdown = newf;
+		WRITE_ONCE(net->ipv6.devconf_dflt->ignore_routes_with_linkdown, newf);
 		addrconf_linkdown_change(net, newf);
 		if ((!newf) ^ (!old))
 			inet6_netconf_notify_devconf(net,
-- 
2.44.0.rc1.240.g4c46232300-goog


