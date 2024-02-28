Return-Path: <netdev+bounces-75748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5583186B0F3
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724701C21F4D
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47001586EF;
	Wed, 28 Feb 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQ6aPgKx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D4151CDB
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128496; cv=none; b=TuAZgp5XwJeCo13CrZhTpRJyCNEZYJwhag679gBA5LKoq0eW60If/0DNaowPeNHUUplh5oIcdsMfHz0xXAek3xdeyZRsZKPVgKJ8yPbND5QyC/1bIsDGx8F1SBzC1q5Ot355Oqn+LjRR3+ka6cqefWKNtcAtRr/qFTr+ZsPwrWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128496; c=relaxed/simple;
	bh=37i2tXE4tjKcp2Txcdvw0Y29p29o5Hp9vPQSdrQNu60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gA500z4hG8cahFoRQO34OpIJmkJkiOO1X1b6+ILc4oBlLl+7eB9J3La0Nl/pvUFwdLzCmbTj3X83ILCeh+407zMCkm41JJFY1KcEXHS8mF5SEs19uxk4rm1fhH9/sto4KjBK8SCezZ1Aom+fGqmM+FayftQ8jjV+Vw380sb4EPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQ6aPgKx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc746178515so7527594276.2
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128494; x=1709733294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IqDklRU6xerwK/HoCTmWPyGypizoUF4xDNpwuD85Hlk=;
        b=FQ6aPgKxMC9ypux0ADFTlvFJ4+NE/pEs1ZkFBz3K3amc106X/BnjLPzWIfCetZzONj
         IsFlA002S0aIaUrdirzOEZLbx63PSlRqmprklO9Ok1oGJAs5MQBNY3y5MBZeroS3k7rm
         R7kf2AYZVAxBVglJUbhKMpxsz4R8TrXNQLKn6o9l1DehzVAAyfvZlPG0Ilz3d51m2tq7
         BTU9gS1Bge6Ju36c3bHz61XsjqzKZNpJVuChPLMrgljg9Y2UKvdu3IXAvQErgkmJCU72
         u1nct1RjLjLF/rYgZcKtg3vy2EFiNET5Q2+s3Z7T1Y5OAvUcAYa7YnDrSC5qAvXMW/Yf
         +q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128494; x=1709733294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqDklRU6xerwK/HoCTmWPyGypizoUF4xDNpwuD85Hlk=;
        b=kQf5VC/8rFSPt3+N3PRzRermRaTKLxwunycC52JNyOjb7+H5UzzMDYmTzYTEXgKLU+
         lADxONaxCdX+ijUTtyTFf7li6eE2owHiasxt6e0mozH4FTYgUBmkex0ULc5QnQMoeVBc
         WxYWMDgu3eYfgxzek/Edyt++EoHrA7BFKb3oDJ8VeuqKUFAM/qNuv4sohmU8nJ/juLey
         FBc+e7RGZSqyELZWlK2gOIOE7lpaq5hErFmVBjejy9Fz7uxntb+1zUP+W7ErpAx8cPki
         bTKQlYbwgcMzMAUTN5VCEG+4faZimbNbin07dRPaLpLtQNiH7dAtJ5tRgmjhmAUb42Cu
         ykxg==
X-Gm-Message-State: AOJu0Yzc/0HziUHh5gm4Qkod2HCdF3x7NQJwxcJXlxVEtbYBB0OX91VF
	M1e8JMAKjx1QOFg75it1B0y81vFIOEet2v7ebPI1khjtdtXeuboRcy6sO5LyPsvIR3SuF0CnGMH
	Um/DCiZghnw==
X-Google-Smtp-Source: AGHT+IHAAQT8MSHo6rhrozkybAbbRlilrMRks6RTGJwYeW6OoJ38AxKFtBk8BxJ2tjE4MhcKUeCkSM5xEQpzPg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1244:b0:dc6:ff54:249f with SMTP
 id t4-20020a056902124400b00dc6ff54249fmr367352ybu.8.1709128494406; Wed, 28
 Feb 2024 05:54:54 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:32 +0000
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228135439.863861-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-9-edumazet@google.com>
Subject: [PATCH v3 net-next 08/15] ipv6: annotate data-races around idev->cnf.ignore_routes_with_linkdown
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

idev->cnf.ignore_routes_with_linkdown can be used without any locks,
add appropriate annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
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
index 37117df401bc47ab66cf89ebcaee1684be84b4c2..31a8225a5abe6f315f110d83568773504aa97e08 100644
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


