Return-Path: <netdev+bounces-163408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE55A2A32A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B1407A200C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECE31FDA7E;
	Thu,  6 Feb 2025 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRGdW4v7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF955B211
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830660; cv=none; b=LAze7pRt2Er03/qbJxkEYXvkGzdGAjj0gfjAl3nogKLwXEQPoGhyfEQYQ5qjX9M76veTSdUmVAvOM8/LfjPgvT5VU24NTx+uxNHRn3OdRXPYEp/eDfO/d2ITgU347t+Fksjca9t6hHxKJHQOrxddHkupjFkznPZHXw2mYHRa2Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830660; c=relaxed/simple;
	bh=JJABBlwcvDjDIM3lWchXbu8gLI+tq2Ms1DTvnGqrG3s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kNuj1rOwRRNfnAzKGscCYgBwmfk9dNRT6y1bocHGjwBltY8nAzq4YiWBIu1J6X1kQWx2I5ade0DYRfKeE6tEgiSWBoGovEHCeJzw0TAjlVQ8BmqhdN1IQAovSH9C9tjC07VEqkm6dOQzw1G+bBt7scMxVhWxp/P6GBlP8m5z6PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRGdW4v7; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7be6ccb09f9so52613985a.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 00:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738830658; x=1739435458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rpXbjxBDoJmYJpPs02CCIldAaKHSJVqyJxexo2RJUe4=;
        b=GRGdW4v7fHxzrGG4V/qiSk9cXHLbrGFDw8PsFvhUEWFwO2BZN6shNJwYPxEVOEs3ki
         Niw4H0niNQV7pi5cVoKMqjVSFXhQv/Z5qtT2sq//Gt2b49sq4qkguMPYVKfXfSOJKLHi
         FyIGy1/tNv9NJUNImnjsr0LhwKBwJyF+krl5Y8EjUcVe6w+o0vbPrcyzSOwd7LxcRwZi
         8q3lt+OPW/WDAMtt50Ylv6E0VYSvnBOLi5n8GFbqFCckf9KwSJMLyxY7tnI/6bNUzKwq
         B8PHpK5XSG3Myo5fY5GvU04fPk0fmB3GiMrZI7OcPWzTGIZ691LfbDyQEetBwFkIPved
         ZrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738830658; x=1739435458;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpXbjxBDoJmYJpPs02CCIldAaKHSJVqyJxexo2RJUe4=;
        b=X7YdwsijTzIg6Hv2jOnm2cEmGS+XVrtWMJJsJLxtIx0ZRk5Xwx6PYHlOVLb4GGTA5n
         DvcUjb5cxEvS6wU5lwWJd6/DpDrdYJIfnLLsCMAiArLe0zYTRpMfTDzuhUZvrJcQ6/r8
         KOJGgZMZBLCoc40hF0ZYSWuO07Aa6YoA9Syq76VV5HEG+t/N7oX/wQbmWLqWITF3iyy2
         4aCH21OtoHmhQmtRamhEMcszHyMzWpG0AxMhxmpsvYja2S+kXZGezafdnalA4WFplMkh
         uMrraclVQ1LB20LkgzC63ImkUMSRHjMBZjf/gdauEu2lnZnI45KPClwU2+WKbTYE8ZgA
         WXNg==
X-Gm-Message-State: AOJu0YyzLtfy5K5AcO8BBtQ3sbl9bV3hIgj8ItkJQHAInQxfcl//kDLN
	H04e46o5/0wMDB1g1VK4U0WyeEDzW3wgHmyWyzSKAmfYLCSGZWHTQIjgHJj+aEv9VpY1CnGqNa1
	LpwdcMHON2A==
X-Google-Smtp-Source: AGHT+IGBn+Dl0ZZ5+GjUkUhQR4QyrtjMg7XK7jtOBaAHb4dPDkNbdt1JDhgBVu5RpRRXy4Cfw4vRt9T0Wq1WfQ==
X-Received: from qtbgd13.prod.google.com ([2002:a05:622a:5c0d:b0:46f:d4d2:5d23])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d91:0:b0:46f:d515:d2f9 with SMTP id d75a77b69052e-47028166ce8mr89035241cf.8.1738830657956;
 Thu, 06 Feb 2025 00:30:57 -0800 (PST)
Date: Thu,  6 Feb 2025 08:30:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250206083051.2494877-1-edumazet@google.com>
Subject: [PATCH net] net: fib_rules: annotate data-races around rule->[io]ifindex
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

rule->iifindex and rule->oifindex can be read without holding RTNL.

Add READ_ONCE()/WRITE_ONCE() annotations where needed.

Fixes: 32affa5578f0 ("fib: rules: no longer hold RTNL in fib_nl_dumprule()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/fib_rules.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index e684ba3ebb38563abefc034c16ba381635285953..94a7872ab231855dd9965efb099c09fe3728e1a2 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -37,8 +37,8 @@ static const struct fib_kuid_range fib_kuid_range_unset = {
 
 bool fib_rule_matchall(const struct fib_rule *rule)
 {
-	if (rule->iifindex || rule->oifindex || rule->mark || rule->tun_id ||
-	    rule->flags)
+	if (READ_ONCE(rule->iifindex) || READ_ONCE(rule->oifindex) ||
+	    rule->mark || rule->tun_id || rule->flags)
 		return false;
 	if (rule->suppress_ifgroup != -1 || rule->suppress_prefixlen != -1)
 		return false;
@@ -261,12 +261,14 @@ static int fib_rule_match(struct fib_rule *rule, struct fib_rules_ops *ops,
 			  struct flowi *fl, int flags,
 			  struct fib_lookup_arg *arg)
 {
-	int ret = 0;
+	int iifindex, oifindex, ret = 0;
 
-	if (rule->iifindex && (rule->iifindex != fl->flowi_iif))
+	iifindex = READ_ONCE(rule->iifindex);
+	if (iifindex && (iifindex != fl->flowi_iif))
 		goto out;
 
-	if (rule->oifindex && (rule->oifindex != fl->flowi_oif))
+	oifindex = READ_ONCE(rule->oifindex);
+	if (oifindex && (oifindex != fl->flowi_oif))
 		goto out;
 
 	if ((rule->mark ^ fl->flowi_mark) & rule->mark_mask)
@@ -1041,14 +1043,14 @@ static int fib_nl_fill_rule(struct sk_buff *skb, struct fib_rule *rule,
 	if (rule->iifname[0]) {
 		if (nla_put_string(skb, FRA_IIFNAME, rule->iifname))
 			goto nla_put_failure;
-		if (rule->iifindex == -1)
+		if (READ_ONCE(rule->iifindex) == -1)
 			frh->flags |= FIB_RULE_IIF_DETACHED;
 	}
 
 	if (rule->oifname[0]) {
 		if (nla_put_string(skb, FRA_OIFNAME, rule->oifname))
 			goto nla_put_failure;
-		if (rule->oifindex == -1)
+		if (READ_ONCE(rule->oifindex) == -1)
 			frh->flags |= FIB_RULE_OIF_DETACHED;
 	}
 
@@ -1220,10 +1222,10 @@ static void attach_rules(struct list_head *rules, struct net_device *dev)
 	list_for_each_entry(rule, rules, list) {
 		if (rule->iifindex == -1 &&
 		    strcmp(dev->name, rule->iifname) == 0)
-			rule->iifindex = dev->ifindex;
+			WRITE_ONCE(rule->iifindex, dev->ifindex);
 		if (rule->oifindex == -1 &&
 		    strcmp(dev->name, rule->oifname) == 0)
-			rule->oifindex = dev->ifindex;
+			WRITE_ONCE(rule->oifindex, dev->ifindex);
 	}
 }
 
@@ -1233,9 +1235,9 @@ static void detach_rules(struct list_head *rules, struct net_device *dev)
 
 	list_for_each_entry(rule, rules, list) {
 		if (rule->iifindex == dev->ifindex)
-			rule->iifindex = -1;
+			WRITE_ONCE(rule->iifindex, -1);
 		if (rule->oifindex == dev->ifindex)
-			rule->oifindex = -1;
+			WRITE_ONCE(rule->oifindex, -1);
 	}
 }
 
-- 
2.48.1.362.g079036d154-goog


