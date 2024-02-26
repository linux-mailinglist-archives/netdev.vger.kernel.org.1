Return-Path: <netdev+bounces-75003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E12A0867B40
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78220B33043
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C9612BF1B;
	Mon, 26 Feb 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nVCOrVpk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD212CDAB
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962683; cv=none; b=lxvcUvGEOm5Hn7saG1JFB6a8SeAuwAJsnV34r0h9fTfKiZpibv/s+jN3gEglPxiilJuZaakVU4SunQcxkPh0wkLStRz/WuGt0s44a0paH/Jl76clP8TDgRtI4OTDbAuNh7daImK+MYIxFZ5w50Ryay1Fnqmb/96M0vQ2CQhdeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962683; c=relaxed/simple;
	bh=qXsKGtS5mMmPhmDH/O1V5SzZTY0A02ImeRmP6n62lp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lrg65qoUuoAh3pueZ9SBW5/p3Iu0LOrfSbN1xFx/c41/AAruvOh50YbGLrEEge7apLp04FIOQlz1E2lTGQNdsOrAzIj1vF6ErYDNxbYrDLPO7K6OZSq1Vn5JNdG6fDLd+jDEMThnXWyXjBHS39aeYbM1BoVhXCk2mWgl1S8u7YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nVCOrVpk; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-787b8dd3330so439665785a.1
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708962681; x=1709567481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dIN9KmsG7wqEMtLwRD7dPVDofYYSOoWcPxBhtcVLCeM=;
        b=nVCOrVpk0OpGs3PEbFDhVEoVdVk6OX1s4ki77GweiAoggkR5mNrQB725Bc95zdjGWT
         NELBjCErNtZ4whJawP1lvtmNrr4gq40sA+FykgIFUCXBHwq+FYMiyGH9Lau9vz01xdFw
         72Qj0e0r5Ke1JqAIy74LoBbcnU34HZhZ54bIuQ9GCPNd440Rh+be2ehv/mBMgPh/O9Gg
         UvfoQiDAFEq4WI47b/JwcZ3UYWC33YcjkkXQU2mz+9ZAatVZs0sGRwS+JGtxdhNpCy9A
         NyYLXoPxOtHc+tx0E64JyWLWaMKCxLJN7rifc9Wz0HFoyqNVss07wzGADO2wZJGYfvN6
         uTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962681; x=1709567481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIN9KmsG7wqEMtLwRD7dPVDofYYSOoWcPxBhtcVLCeM=;
        b=JE3vT7fenjCKGCEc82V4zScUBG6Rs0wc3fJpRuuYTK3cKg7EuROTY9vTAsW1bPJ1dP
         wFhWKUhx4hys+Dh4Ya388jLgF+jrW9eFYxoQGnzH8I4o3pp/5gjZVq3eTfh5CdG7yWWp
         UuRNGUH+OWP9z0aAEiCBGFcJKrzhmyS0/Kj+XF8AI0Xmd5PDl6dewpezPUi4z8sn8z/W
         N/ADhJ6XAfh5GMzec6BRJkdsuOGHPcPy833Hnr4HGydc3J/CTldio+BD43kmJXR5CMX0
         daIlp50C4M+NWdXyNJ+SDsnxDS8jYlzFzFajw8vEHCAPQ51XQCNi9Qycak24BNJf056k
         vKVg==
X-Forwarded-Encrypted: i=1; AJvYcCW3HgbQIm5rDvd0/hXwu8I/0yQKujc6MU0bmpaPMfnPusqf4hn0qH6w36BOzD99g5dkQqSVJ8+HRSOqCo/qe9Rslix7yNUK
X-Gm-Message-State: AOJu0YxdjnRMh5luLSVzRC5trT41F8QODJOvfQFGQfHcsb7+AXr8a6dX
	DirLjNYLwYpo6CpJgWdmCYoy/i8poZiwsbjLP/bEZqpunGqP4zaYop5SZOgdH3QUdeFqROtFlEy
	3K3J0Xw3d4w==
X-Google-Smtp-Source: AGHT+IGz+fQxcbu/2AFaaqCKLyYGNeeKD1h7Ldo8gD8h1Obg5b2LgVrXjqAHmGJTh19trk/rNK+nIPTHqbtokA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:658b:b0:787:cbed:79a0 with SMTP
 id qd11-20020a05620a658b00b00787cbed79a0mr17327qkn.2.1708962680826; Mon, 26
 Feb 2024 07:51:20 -0800 (PST)
Date: Mon, 26 Feb 2024 15:50:52 +0000
In-Reply-To: <20240226155055.1141336-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226155055.1141336-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226155055.1141336-11-edumazet@google.com>
Subject: [PATCH net-next 10/13] ipv6: annotate data-races around devconf->disable_policy
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

idev->cnf.disable_policy and net->ipv6.devconf_all->disable_policy
can be read locklessly. Add appropriate annotations on reads
and writes.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c   | 2 +-
 net/ipv6/ip6_output.c | 4 ++--
 net/ipv6/route.c      | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f2a91bdda23f808d38640d3f3ec91140386bc640..8ba024f227b43fcba11fbfac1f3a9691841efcbf 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6698,7 +6698,7 @@ int addrconf_disable_policy(struct ctl_table *ctl, int *valp, int val)
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	*valp = val;
+	WRITE_ONCE(*valp, val);
 
 	net = (struct net *)ctl->extra2;
 	if (valp == &net->ipv6.devconf_dflt->disable_policy) {
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f08af3f4e54f5dcb0b8b5fb8f60463e41bd1f578..b9dd3a66e4236fbf67af75c5f98c921b38c18bf6 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -513,8 +513,8 @@ int ip6_forward(struct sk_buff *skb)
 	if (skb_warn_if_lro(skb))
 		goto drop;
 
-	if (!net->ipv6.devconf_all->disable_policy &&
-	    (!idev || !idev->cnf.disable_policy) &&
+	if (!READ_ONCE(net->ipv6.devconf_all->disable_policy) &&
+	    (!idev || !READ_ONCE(idev->cnf.disable_policy)) &&
 	    !xfrm6_policy_check(NULL, XFRM_POLICY_FWD, skb)) {
 		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INDISCARDS);
 		goto drop;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 1b897c57c55fe22eff71a22b51ad25269db622f5..a92fcac902aea9307e0c83d150e9d1c41435887f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4584,8 +4584,8 @@ struct fib6_info *addrconf_f6i_alloc(struct net *net,
 		f6i->dst_nocount = true;
 
 		if (!anycast &&
-		    (net->ipv6.devconf_all->disable_policy ||
-		     idev->cnf.disable_policy))
+		    (READ_ONCE(net->ipv6.devconf_all->disable_policy) ||
+		     READ_ONCE(idev->cnf.disable_policy)))
 			f6i->dst_nopolicy = true;
 	}
 
-- 
2.44.0.rc1.240.g4c46232300-goog


