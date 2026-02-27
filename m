Return-Path: <netdev+bounces-261707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBsLLw4SoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:39:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAD31B2519
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E457B307C42A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30B1332EA0;
	Fri, 27 Feb 2026 03:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fl1tCNTU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4002333436
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163566; cv=none; b=RXeUQnKI7nIz1iSpoDpF27EfeQ4/05OC/nuykk/D500GnE9eV0ojQlKu+mtoP8BJ42D5hMftP7ZG2Maz0LNvjwSuqBHIeHitUf/LY/N4VPlTtdIYBYLnHyidACvI2V5uR2hL0YKt7X4OeBrwVFA8EPt9DA8HshBk489ORul5MIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163566; c=relaxed/simple;
	bh=kKEHhwjXIaHBm3ToFuUT9mh+Gveii7SeON53xib5K2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qx9AQEr00xE0oNlRQW9e1qJZdeIQ+mBwmIqIR6HbeZYit6bmJFEoEipoQnd4bvylWjFtSCyDov4Di6XMiDSLUsazssp8Y90Q5+7U0lW0LJfqRkCYcyQbxMQU7aa6+nMhLC3AMBz0xaBMgHcdE5qRciNz9kJEX/ptP6KB5PM0E6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fl1tCNTU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-824af3c6c0cso749340b3a.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163565; x=1772768365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAQncS9q0KS8av/CYiVqCVzMqOWwZ6rIHWqMUVwte94=;
        b=fl1tCNTU6p1tdcz2EovZvQUpWxKOL0ZRJFKl7aUi5R8qL6GW0/4nd+HFO/jU6uXDtm
         81haxrVOfOa7fRLYLeBJ+Qh1Ch6N2hiq8HKLUGM3+OBsnsKhkgNg/svhm7Zg1vIQBCXC
         ixymTuIi9/uCN9AZ33/llofxpr6FIeLAqyyoHvriVSS4U+j/GNBJmd4FVnUlx6cryk7j
         oEx7TKL74utIqJOIitimp9+xJ65vdhpt4Q9rbs6hmJkPGbdkvDTkj4d7Q3cr2jY1QRPG
         NrU1noYYLUskhfiVCq1xS9Z0YyzHVEm/BM9PmVnEiZzhHWvyh2rDWoNgVKGm1OndSzVp
         xN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163565; x=1772768365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAQncS9q0KS8av/CYiVqCVzMqOWwZ6rIHWqMUVwte94=;
        b=pIlcnOVI1srbQXokpSvNlmTn9+ABPgBxGJtvp0ocMGc0ldpdJyBVh0FO7IWmrq6wSV
         h8oAMcLof+GVbWdW8w2XUDPVIOFKz3wrrsSCrtBdXreukb81GgVgk/Dw5wbApObE8NSm
         bOWIlxfPSVnu1ZphH5cPDFrbfTQv7GvHtaeeLR8wvMqeZUyvo4adakvAAWsdlmXNFB9R
         8BT1X06ZHAq72QATgV691oge8t3bp2DMFkvpc7Wljg80Gx09sHiD2+nohqsqbgCwAO5F
         eCuGDH0fWBkhvWnQm5PvjiUwhkggPVb9ilAOap3G2zVTxQNl7R1OP7KGj4g9ssYjsB8M
         CXPA==
X-Forwarded-Encrypted: i=1; AJvYcCWfCpUHfDSFkjWt03pddRAwbxo77loT4fPjasg/1V6qIWgwNTm5G0HLT47XTLRstbY5k18F0yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwVaCY1+VJCUF61N+WE6hJipX+Qi3LusIDXaqI2La4GJQ/nsHH
	EBpcxmk2PzgYRPR3i0BE+k+336mMP/tvdBcXWR69keZykNFqggPv5CzQL7tAdwgMJyxp3OyVjWM
	n43uTJw==
X-Received: from pghq18.prod.google.com ([2002:a63:e212:0:b0:c70:e4b6:a279])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9518:b0:823:30a1:d5ba
 with SMTP id d2e1a72fcca58-8274da04bfbmr1290496b3a.51.1772163564767; Thu, 26
 Feb 2026 19:39:24 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:34 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-12-kuniyu@google.com>
Subject: [PATCH v2 net-next 11/15] ipmr: Call fib_rules_unregister() without RTNL.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-261707-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3BAD31B2519
X-Rspamd-Action: no action

fib_rules_unregister() removes ops from net->rules_ops under
spinlock, calls ops->delete() for each rule, and frees the ops.

ipmr_rules_ops_template does not have ->delete(), and any
operation does not require RTNL there.

Let's move fib_rules_unregister() from ipmr_rules_exit_rtnl()
to ipmr_net_exit().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipmr.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 354e7dd1f374..77ae0fd9ec31 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -282,6 +282,11 @@ static int __net_init ipmr_rules_init(struct net *net)
 	return err;
 }
 
+static void __net_exit ipmr_rules_exit(struct net *net)
+{
+	fib_rules_unregister(net->ipv4.mr_rules_ops);
+}
+
 static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
 					    struct list_head *dev_kill_list)
 {
@@ -291,8 +296,6 @@ static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
 		list_del(&mrt->list);
 		ipmr_free_table(mrt, dev_kill_list);
 	}
-
-	fib_rules_unregister(net->ipv4.mr_rules_ops);
 }
 
 static int ipmr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -348,6 +351,10 @@ static int __net_init ipmr_rules_init(struct net *net)
 	return 0;
 }
 
+static void __net_exit ipmr_rules_exit(struct net *net)
+{
+}
+
 static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
 					    struct list_head *dev_kill_list)
 {
@@ -3286,6 +3293,7 @@ static int __net_init ipmr_net_init(struct net *net)
 	remove_proc_entry("ip_mr_vif", net->proc_net);
 proc_vif_fail:
 	ipmr_rules_exit_rtnl(net, &dev_kill_list);
+	ipmr_rules_exit(net);
 #endif
 ipmr_rules_fail:
 	ipmr_notifier_exit(net);
@@ -3299,6 +3307,7 @@ static void __net_exit ipmr_net_exit(struct net *net)
 	remove_proc_entry("ip_mr_cache", net->proc_net);
 	remove_proc_entry("ip_mr_vif", net->proc_net);
 #endif
+	ipmr_rules_exit(net);
 	ipmr_notifier_exit(net);
 }
 
-- 
2.53.0.473.g4a7958ca14-goog


