Return-Path: <netdev+bounces-300761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PujRE2C0NWrd3QYAu9opvQ
	(envelope-from <netdev+bounces-300761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 23:28:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76F6A7CC1
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 23:27:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Thc3JeaJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300761-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300761-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F96F300CB04
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 21:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820583BE645;
	Fri, 19 Jun 2026 21:27:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4CC32B126
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 21:27:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781904477; cv=none; b=EiccdtEDbCG4ylYM/hFn3nCMHqD9jmqF7wn8BAWg/4hLupVPGJbSoPiMhh0Er+p7b3GSxyrGcbeXiOeytoSGFKsR4AwLohn5JD4qS8hs+fU15vBDmPaW6DnqLA9iLmdr4Rrx3JFA97vJaQbTqMn7SA51mCYZoX1GoCQ/5d0hojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781904477; c=relaxed/simple;
	bh=Zf/DRfCPO7igODsd5U3zTkuiwgoYAXC2cqky2cDd5n0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aum+u4qwVQFP/sBxhJQsOposFw17zJ+PrjCMTvo8CNi1vNNU/SACnx+UHxNzDgW1q01VHwYxNygOuU2pLy6GUXeyXQJvnyM+d/68dGORzju4KuwklmqTQCueup2+F1K66oGrCpz3FkJKk5N1p0mrGosmpisLaGTI7CpP94AGLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Thc3JeaJ; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c6af282daaso35954495ad.3
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 14:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781904475; x=1782509275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XShJL3DbLd6WwGmbvq1ajAKLsbtMdZ08RZ20xfTeNEc=;
        b=Thc3JeaJhloG5/KGmIGKVaiUm8v5tlG6Qx5HTdEYovdQtX/c5E3v+EvMEd0U1SD7Lb
         ydVh4o28II7OlMvuQ/B79poAYln8Mh7WMArC0ypAdWZvk67a3BU/u8NnyNrxNm9UHI3z
         KlmECfHloVK6m8kr5a3lh3Adejx8qyNMLHG9oCgN8BmTd+1V6pc8ktEXJ0Hm0lufzEgF
         03hULLk8OA5delsEeMDgwMeqRQE23vGPctirWYizsWjo0HU9zW1tcSuRJ8fRNf/0bd4C
         QqqOKG+1IydGnbdYQCO2xY9kLaSsg+puOM+NSSftLBqWmf6mZkoQ7ho32NY+jQiyXhEm
         RP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781904475; x=1782509275;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XShJL3DbLd6WwGmbvq1ajAKLsbtMdZ08RZ20xfTeNEc=;
        b=n1IltjDxfeJ8TWXpVk8mWvuoE+7JzDPQVPK6adicmJrzumPKTTINxxJlcdymSAd/H9
         zft5WybOailMJB9xoezaRoquYKRIaEsmAwFpp2LAIWRnNZwAXGHO8EhrmXgbmBh/e9SN
         XFyOHzLzFULKOkoiSEyfK4TYdUPZaMrnpblL095+zNpnk8UQbN5Vdz1MVMQE6/Zab2CS
         Ncxw8ZpPcKD+wjhw6Gh0Qcr23RBfnVbnGdqVQsqRI97XIH9dqDTTffWJxSspGXS95Ik0
         3RvdzyrRajarCH+QZvqhOR6jhHHtDR9YBvPqh8M3YXJEWSFOtGYxurP92gXt5riI799k
         H9KQ==
X-Forwarded-Encrypted: i=1; AFNElJ9TzfOHN+QwqJ09n4i29e1JEpaSzR3Q59sBDN6jFCdhKbVIEt6kjpyAWwUuyfbgxMboeRX8+DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOvNy9IWwl94h36+xU+meNgEMM4Pq/CbSDdVSbrkQHhZ2mkRSx
	2NEQF6rRH5Y4hZZu2uJLmnfV1w3sQnv9I65aTQPoTBYwZITdEqWirqg0BqfTFNVnnEfbGLHj7RO
	dT8XTJw==
X-Received: from plrd16.prod.google.com ([2002:a17:902:aa90:b0:2c1:9d1:eeab])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2352:b0:2c6:9d3d:dfbd
 with SMTP id d9443c01a7336-2c718caa362mr58336405ad.16.1781904475012; Fri, 19
 Jun 2026 14:27:55 -0700 (PDT)
Date: Fri, 19 Jun 2026 21:27:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260619212753.3367244-1-kuniyu@google.com>
Subject: [PATCH v1 net] ipv4: fib: Don't ignore error route in local/main tables.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300761-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA76F6A7CC1

When CONFIG_IP_MULTIPLE_TABLES is enabled but no rule is added,
fib_lookup() performs route lookup directly on two tables.

Since the first lookup does not properly bail out, the result
of an error route in the merged local/main table could be
overwritten by another route in the default table:

  # unshare -n
  # ip link set lo up
  # ip route add 192.168.0.0/24 dev lo table 253
  # ip route add unreachable 192.168.0.0/24
  # ip route get 192.168.0.1
  192.168.0.1 dev lo table default uid 0
      cache <local>

Once a random rule is added, the error route is respected:

  # ip rule add table 0
  # ip rule del table 0
  # ip route get 192.168.0.1
  RTNETLINK answers: No route to host

Let's fix the inconsistent behaviour.

Fixes: f4530fa574df ("ipv4: Avoid overhead when no custom FIB rules are installed.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ip_fib.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index a71a98505650..c63a3c4967ae 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -374,7 +374,7 @@ static inline int fib_lookup(struct net *net, struct flowi4 *flp,
 			     struct fib_result *res, unsigned int flags)
 {
 	struct fib_table *tb;
-	int err = -ENETUNREACH;
+	int err = -EAGAIN;
 
 	flags |= FIB_LOOKUP_NOREF;
 	if (net->ipv4.fib_has_custom_rules)
@@ -388,17 +388,16 @@ static inline int fib_lookup(struct net *net, struct flowi4 *flp,
 	if (tb)
 		err = fib_table_lookup(tb, flp, res, flags);
 
-	if (!err)
+	if (err != -EAGAIN)
 		goto out;
 
 	tb = rcu_dereference_rtnl(net->ipv4.fib_default);
 	if (tb)
 		err = fib_table_lookup(tb, flp, res, flags);
 
-out:
 	if (err == -EAGAIN)
 		err = -ENETUNREACH;
-
+out:
 	rcu_read_unlock();
 
 	return err;
-- 
2.55.0.rc0.786.g65d90a0328-goog


