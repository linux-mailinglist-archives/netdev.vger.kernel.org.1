Return-Path: <netdev+bounces-298469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eDkkAi+oK2ohBgQAu9opvQ
	(envelope-from <netdev+bounces-298469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:33:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F03676EED
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:33:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=TnmHDcul;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298469-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298469-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E76E130D21DE
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35903BD63C;
	Fri, 12 Jun 2026 06:32:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC85372076
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:32:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245955; cv=none; b=V09/epfRKYhea9CHvphlTKDSM39yROXdZMjavQWZpow3B4J1/V2hDGeIF8WzTRYm0HQ+k19w7pEsOPlSsNfFtc9NDyo3UFvPuwGiG59gQIuCot/VRk8uh5Hz3g4oGATWqGAoefYiaWnlD/UDVaTqHLqRT3VielVU/lx9oCWh5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245955; c=relaxed/simple;
	bh=k5m72iPTHKYOPr1Czpwx53TfhLQtbdim5mJ0TYQ4R9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n6iMxsRF3D/yWE0gJDI/J2TGQX8uYmeENCDW7/P6Z5MxlCu+9tQebej0IKo1kqZYYvn3T6cfWfetKVO9ZWC/M8wxI247dN11bntpwDO+ZkCUhppzv7TUoekhRreE43lkHfFcQK5+e9BQwXpCft2R5u/Kz50jTvO8JQQucD3gBa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TnmHDcul; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b982ec27aso507886a91.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781245954; x=1781850754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LzOv2pnDNRfaQO5QAYtzMap+eeJtaKsDfNMe3MP/Cr8=;
        b=TnmHDculfnQFs9bLpkDkPE4mVrVv5vcgVr13TiFwq8c/X0TIesSVeFzNkaThaJPgI1
         qUuicFArNXEdktM16DfcyMn1F+qj+V1oe4qNe4UINSqALd2kX+FetRaDJob54dmxkPnp
         8m/Lo1I3FJ477bk/Aw3dcqO11WwxA0j3cysGD5/ekh+UvoQsBxH+OUDWi4OdK5grUCoS
         wsbIxxxlLjnu3Xbvau4PGhkwKIohoxYA644UTjGg+FfQDrIqjH4V1gjDtGZyndY6BUz3
         azHysaRrRVfyyWHNNES+caJ1KY+AU8ov9P4XoqxHSuUTB2tgzZjh3wH1GyGWzE0e9FzZ
         OXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781245954; x=1781850754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LzOv2pnDNRfaQO5QAYtzMap+eeJtaKsDfNMe3MP/Cr8=;
        b=Sr3OR1CEj/OxmYT3LWSPmOeEAYNLkRZj12aOFK4R1M2o4mRN4MICyV90pDn2u+Qrz5
         Xa+bDiEWS+5mEYJnipVbtM7vqypCAP6anxAsUYGF21fUU0bhZKp/i1WtgRWSlkNMthf/
         N9TLwwhXARXGuskFkWqbHLBPPlzwBEJv7/1UVFuGQQKMTjRtdcdDdQKro0awX+rugh+D
         2O7+OeLn6YzZK7RxDhcD3g6ZGO77jqufegDLN0EdD9O1TlJix68Ui71d106jg0P3p4L9
         8Tix8qxsbEQ2RgLvCBIBbkJh2RmBNKA0ZCm4ejm48cznpoR/EQKRd9n24O2BED30P0gd
         R2Hw==
X-Forwarded-Encrypted: i=1; AFNElJ+LO+F+6VW6eUpgbWpSYr67eVA/H2yzHluzQofg38g8pzdX7y6JZOdZK0Y0C/pKfwvrtv5FT3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywox3uxcERlquy/d+h6sSLGFerhMEVFJLzTzOl0FzSjUOEPVIXz
	cyGwTIB3x7tYNrzEe/hfk2kYbcoPl9NjZIlmvs1gSAhO8X77wkDQbdR8AXSqDluDg96uwuMECFJ
	Ag+hKVQ==
X-Received: from pjbbu4.prod.google.com ([2002:a17:90a:ee44:b0:36b:8132:e6f1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5346:b0:36b:9798:4f67
 with SMTP id 98e67ed59e1d1-37a02229651mr1840941a91.8.1781245953562; Thu, 11
 Jun 2026 23:32:33 -0700 (PDT)
Date: Fri, 12 Jun 2026 06:32:06 +0000
In-Reply-To: <20260612063225.455191-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612063225.455191-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612063225.455191-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/5] ipv4: fib: Free net->ipv4.{fib_table_hash,notifier_ops}
 without RTNL.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298469-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69F03676EED

We will call ip_fib_net_exit() from ->exit_rtnl().

However, some paths will still access net->ipv4.fib_table_hash
after ->exit_rtnl().

For example, fib_flush() is called from fib_disable_ip() for
NETDEV_UNREGISTER.

Let's move kfree(net->ipv4.fib_table_hash) and fib4_notifier_exit()
from ip_fib_net_exit() to its caller.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/fib_frontend.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 3b1bd53c7357..c3e3b5633fd0 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1615,9 +1615,6 @@ static void ip_fib_net_exit(struct net *net)
 #ifdef CONFIG_IP_MULTIPLE_TABLES
 	fib4_rules_exit(net);
 #endif
-
-	kfree(net->ipv4.fib_table_hash);
-	fib4_notifier_exit(net);
 }
 
 static int __net_init fib_net_init(struct net *net)
@@ -1653,6 +1650,9 @@ static int __net_init fib_net_init(struct net *net)
 	rtnl_net_lock(net);
 	ip_fib_net_exit(net);
 	rtnl_net_unlock(net);
+
+	kfree(net->ipv4.fib_table_hash);
+	fib4_notifier_exit(net);
 	goto out;
 }
 
@@ -1674,8 +1674,11 @@ static void __net_exit fib_net_exit_batch(struct list_head *net_list)
 	}
 	rtnl_unlock();
 
-	list_for_each_entry(net, net_list, exit_list)
+	list_for_each_entry(net, net_list, exit_list) {
+		kfree(net->ipv4.fib_table_hash);
+		fib4_notifier_exit(net);
 		fib4_semantics_exit(net);
+	}
 }
 
 static struct pernet_operations fib_net_ops = {
-- 
2.54.0.1136.gdb2ca164c4-goog


