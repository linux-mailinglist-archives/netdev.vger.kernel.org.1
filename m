Return-Path: <netdev+bounces-75364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6D88699CD
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9C51C20951
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9314DFF3;
	Tue, 27 Feb 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCG1T902"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681A149DED
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046142; cv=none; b=bFP5uoSzfSh4R2g5JFAtmQSRKwEMnP0uqYyc0dMcj32+VNnRBx3nK9Kb5eBD/pcBTO7K5mqQB3UXzaQ86qoMpIYZ5Q5JwOdtkR65Bl5FTuQ0neqZLvBgEC1N5gwt7albNkU6VY0ZVSAnI6QOUYqPJ6cnBdoPHgr17g+UxXgzCLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046142; c=relaxed/simple;
	bh=2Anz9e3VBt6krF0bVN3Ex0zXSJmDy3SO5azDtUYJnDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iwjjzZ5cOZr/D0Y0jqme8mCai+GesM22IbUVD465wih8rgw+7IUjJS+IRnsCWLwMPtO5jhQdS2Fc/LlvAvtj2/PTVPzAJCB5AUfUBrocDBHyvM+CYLYar6CqStp9t4NjoyEHUtDRe3+dMl4/hHabTC58DJzx2DYYQZ+0T59sA1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dCG1T902; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so7217455276.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709046140; x=1709650940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GP/RU7lKJqtbgRmHRHLFCE1zP8m3sDXB2YYpqanzTao=;
        b=dCG1T902RwnL//XmAgonthSt8/Rq1jjkj6SX3tKSzimU2v7TEIF73G4xyVHZIHmhEl
         vwGxlZuy2M9aEvY20wp6Ogu1l7Dty2EceLzVhwOhVTpXBYplUGZWJ6tSixLZu+Xb8pyc
         Rv8po+7tymSChNzliCRalPZHJ3jIX9DIP1SzYjDzouRcJKUVdjjo03yzQsog2HHpKl1N
         68cZo9kx0rDnsi+rVQJeq44k0yfMXPEiOamatrc+5BDLgGp9rYPdFMS2UpYu2SFjjTOt
         GwHGnrqd3bwqh5GUjnm+gd51G5aT1T7tYcpDIZjqgiggz8sZY8jjsOQFiLetRliU+0/g
         t3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046140; x=1709650940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GP/RU7lKJqtbgRmHRHLFCE1zP8m3sDXB2YYpqanzTao=;
        b=CZcBjZzilKs/feY7T4D7tXAwWVtKyWFm3lCWYo2yd9MxsDYWIWpD/GRMhEgzvwhBZK
         uilLcdb7VktOO9NNQYEFbs66uxcpYnkSURuR0lpdd6FwcmARr+rFgiz/R0V6YtcLVPIS
         mCcQxhswF9yQEG6+B08E9xo5//rWWi4O3YeRwd7tWAyBUSS3KV85WmnHDFe6PCAM0Yih
         g82KDQ0tfQ0lE/Os3t17O0+RpjGGedxsjJGpV0tEQnm75U+cvNfDxz3socfrOH4yoqMN
         P0qFAozRZeSCdoZXwSmX2X1EBCgeA//7JQfheH38A1bqcGLEt7H34VBod5KC1C9WThc5
         PAJw==
X-Forwarded-Encrypted: i=1; AJvYcCXG1NR6oNKn/TFcYlG+uHDvDgZJJl5KwYQYNIErBP0oFS8rKfKUfKKJdoAcwj7ZjZj9eReDqIMNbX1BWoyCVQJzjcE7del5
X-Gm-Message-State: AOJu0YzB8olr4PW1DHP1UC4Q8TZVYg42A/zflj8w/p8Y7/g1WB6YMWSK
	YrjoP6sy0LG30+TbaEEQdDx7obBQwsSR5KPOI/4mw3lhY4ESaKaDAuXx1SfXw4uC07ibTyo7KL5
	Vt9QM7lRJRw==
X-Google-Smtp-Source: AGHT+IE0TKrKqCL6eXw4EHx/BWZG7hhwKSj1TVGsieJSbz1PhkJ8CswhN6XzcfX5hiLwnWb8QgLbYXlg2Mhhtg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:18c3:b0:dcc:f01f:65e1 with SMTP
 id ck3-20020a05690218c300b00dccf01f65e1mr628366ybb.8.1709046140092; Tue, 27
 Feb 2024 07:02:20 -0800 (PST)
Date: Tue, 27 Feb 2024 15:01:56 +0000
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227150200.2814664-12-edumazet@google.com>
Subject: [PATCH v2 net-next 11/15] ipv6: annotate data-races around devconf->disable_policy
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
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
index 8637957ab9c8fcfce2a81910c8ae0e965f32b7f4..392e64df991a4005736883af128cd82ac3895167 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6697,7 +6697,7 @@ int addrconf_disable_policy(struct ctl_table *ctl, int *valp, int val)
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


