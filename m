Return-Path: <netdev+bounces-277590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JuNLLtp2Wn5pQgAu9opvQ
	(envelope-from <netdev+bounces-277590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:20:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E183DCD8C
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 879F5307D2E5
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5C33B27D1;
	Fri, 10 Apr 2026 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pXAy6oax"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9015C3B27DA
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855878; cv=none; b=pIFV487KbH0hhDvLR3O90p1B+UdT2au1n1CBhg0NrZReVYyuJMg9XcqLTNtBJgeUqAuk27sSIkQoY+ADaTJ/Bcsjn6ZFhvZcvkAgMw53tVDUK0ECUhhaj66H7LYxJNwgjz5eT0FuN5sx/5v7a58SmhlP/JC4hk/3OpRjuic3Yto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855878; c=relaxed/simple;
	bh=ys/urQNEaT35RE+ih3TF3UBemNUsN3F+enxuWP0wZgY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LKIl3vUbE2H+W8pqCMbuijCtnVKH/t305ZlxCNyMvbziCEPBhsKT0P+UpMtn1ZM+NWTdVDt6Q8U+ziSwdNpQshQ7sbSdo4pWwU92o1uvoVOk+AqNDK+WE3TKXzoW0tISB0SDHygKzCq11EQaSUZWxAJCReukMM45XOpmlKNLrfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pXAy6oax; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c714cb672so1354223b3a.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855876; x=1776460676; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GCV1PVpgEzbsUFOr16C0mhG6diO8xGWhS9XaumYedqM=;
        b=pXAy6oaxKYE43aDsJ5T08ut6NHDT6qovXbXDWPxeqYPgMjGxFJbpa7YCZP15uLo0NC
         3Kgkz9hEAqAyELnAAsheNItvDTtkChNFzNz+LZcg/YEm81w6kGxFlGGOOlp5hXgquZ1Q
         bgZTBrScTM5C9u+CNnamnmairoQmQ2SO2Q/X5/C2KADGH4/gNOlz3Ka/i4lSRQsEngHU
         6PKMOcIla9Z1X/K5r42PzBs8FYm18JtC29dTbHDtYBA1/yefFFL2j2kCUrK4RyhHVoMN
         xLXsV7K67U5cLI19sxnwKUiCvlmNmHSWK593+PCAmx3fFCGNXJIsm8NUSjtyD993tQiK
         ZamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855876; x=1776460676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCV1PVpgEzbsUFOr16C0mhG6diO8xGWhS9XaumYedqM=;
        b=Vb7Pt1Xw94ZgOj6sXLjzp1L59YyNSP7EfdANHhjYm9kr8S03VllD7xqKNx57nGBl3Y
         YpD/i5GjOBCFlWqAcsidOppCWRnnaz96/HGqWoWV0wxQ3rcSzQ2Js+KcjBJlqAOWkS53
         lWuU5/eQSJg2owglNumEsRpyhTPsxXIGqoCSzF3BGlhM0NPvQCOmJm9tCzCyDLuJk50u
         52VVqEB9c2FSETeJkOfoebLVrgA9qS3pQron3eFVs34Rm/ximvtFFkygumXe71E6vFPh
         /tJKK/XYdtOb8YsvltfeqPaP3gq3A79Dg8bA/ao3uB03f1g99rYl6PX+sXiUZJ682Y5X
         2xsA==
X-Forwarded-Encrypted: i=1; AJvYcCXxiMOGQq5z/+ZozzqZAEmLg8HCM0PDKNiUtALkboVcvkLbahv5uS9zWeWOv934WU5kf72N+zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYPi+fWkrxRSlfW/Cx6MmEXlGu2ljzSheln2XGfdF1ywCCTILt
	xC+iBwhdlRVMvvkTuBBbLReB5ZQ5Vd+gn2bJPVGzudTdz5Vo63dF2Z2ZIpgTOLVtLCUi+GTz76k
	dIrLkhQ==
X-Received: from pfbk21.prod.google.com ([2002:a05:6a00:b015:b0:82c:6cfd:5945])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:330d:b0:82d:99d:5a39
 with SMTP id d2e1a72fcca58-82f0c3649eemr5828227b3a.50.1775855875687; Fri, 10
 Apr 2026 14:17:55 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:17:10 +0000
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-15-kuniyu@google.com>
Subject: [PATCH v2 net-next 14/15] ip6mr: Call fib_rules_unregister() without RTNL.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277590-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27E183DCD8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fib_rules_unregister() removes ops from net->rules_ops under
spinlock, calls ops->delete() for each rule, and frees the ops.

ip6mr_rules_ops_template does not have ->delete(), and any
operation does not require RTNL there.

Let's move fib_rules_unregister() from ip6mr_rules_exit_rtnl()
to ip6mr_net_exit().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 3b8867e150fe..a31e3b740581 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -259,6 +259,11 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	return err;
 }
 
+static void __net_exit ip6mr_rules_exit(struct net *net)
+{
+	fib_rules_unregister(net->ipv6.mr6_rules_ops);
+}
+
 static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
 					     struct list_head *dev_kill_list)
 {
@@ -268,8 +273,6 @@ static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
 		list_del_rcu(&mrt->list);
 		ip6mr_free_table(mrt, dev_kill_list);
 	}
-
-	fib_rules_unregister(net->ipv6.mr6_rules_ops);
 }
 
 static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -329,6 +332,10 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	return 0;
 }
 
+static void __net_exit ip6mr_rules_exit(struct net *net)
+{
+}
+
 static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
 					     struct list_head *dev_kill_list)
 {
@@ -1367,6 +1374,7 @@ static int __net_init ip6mr_net_init(struct net *net)
 	remove_proc_entry("ip6_mr_vif", net->proc_net);
 proc_vif_fail:
 	ip6mr_rules_exit_rtnl(net, &dev_kill_list);
+	ip6mr_rules_exit(net);
 #endif
 ip6mr_rules_fail:
 	ip6mr_notifier_exit(net);
@@ -1379,6 +1387,7 @@ static void __net_exit ip6mr_net_exit(struct net *net)
 	remove_proc_entry("ip6_mr_cache", net->proc_net);
 	remove_proc_entry("ip6_mr_vif", net->proc_net);
 #endif
+	ip6mr_rules_exit(net);
 	ip6mr_notifier_exit(net);
 }
 
-- 
2.53.0.1213.gd9a14994de-goog


