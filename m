Return-Path: <netdev+bounces-285772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OicFm3O/WnujQAAu9opvQ
	(envelope-from <netdev+bounces-285772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 13:52:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CBC4F5FA8
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 13:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4673B30095D7
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 11:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B91396579;
	Fri,  8 May 2026 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOCwlp59"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC537187E
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241126; cv=none; b=asjL9nlvL54JI7geQkDQ7wZG9aqFVhnp5gHwjt8okFpIHM8SQcO8E/wBxeFJ+1RJdHrBC1ERWqrkGjuhYSzrWV75vW7rSyfyWSoThh07J6A6e0hxaGtNIFdKTsymy7m3VWlFKfun1p767r6C1RxGKRAsX7Y9P7O9BfM6gth71Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241126; c=relaxed/simple;
	bh=ptCOJLqIonTgMhtNihp+/mYlppQ9B9mnY9fKEMk9YGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h2IsKpZGic//hEkpKlITFpTjWgqJcxyR7AE/NbXlw+jTEVQY3qZI2cQFFUh3wjFLBQwWp3tsCY9HBiNaq8mriX86on0eG83hBhsGRLw2cF6vRGcex8wJPiha4BfK7MIiUGxDjWsZg/Fz4OVCI/rLytdgaX60jKNt9T99Vn/XLa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SOCwlp59; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3662e7756f0so800111a91.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 04:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778241125; x=1778845925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ww2OBpUwBFC1dT/hNun9Ss0JKM5q3IqCHeg50FSTSv8=;
        b=SOCwlp59vJsCxZMp06JzYFtMYqqd1acbVOp5bReOTWJlA1owwGU8sH01ZmM8lGDhx8
         NIgjgV0Aat5+H7wPUGeWgS33TesK/eVay5AIGIt4Gjn2WfiGelbEjEa1g+PMorNg6eR8
         qudVYTARzDRchDIBCsD22aZkqk0u0UuV93IfhyBZl/dz9hjMWYR4cfrq7N/clr7ibrvc
         86m5b1PoLktV/M1BohBxH2ALTB0fnARrDBUPHO6gqFh+dODNSwi7zWyWEukBhhEUhesa
         Ke4Ee692edxRMfjY+Q/7rXDvjoKisfY2q1euliCt7byN+lox/De8yig2fwGnKyr+ib7R
         695A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778241125; x=1778845925;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ww2OBpUwBFC1dT/hNun9Ss0JKM5q3IqCHeg50FSTSv8=;
        b=Nk7oyCSOzaU9rdU0BplDirZuaUyO/e1mDZD8C3wKgpVgug/kdTWG0n0HxE2C8Dekfb
         oFKWaUixNRmiRUpD3A2Q6CP7JHRk64njbobU6NDexUAyIdPs/uUWJbOkxIeZ+LYKiyfU
         5zi3ABd5e3NAGh8nT09qoRKRoM15rT47q/vtXZSCgdAcIWlMON5KdwhWiQ7m48Oo2RAS
         o112AEEBDz3i+x7PjCQ1P9EXXfMb1hwtrvqNXqus7Er2ppTzi46i5mRBsCjzCLBjde+y
         QLRg2Bm5bsE4718ct+6usluuXUh9hjKtWgZYNCSB4m6FPiN8J6MEv9rBKAzkBIapZxq6
         lk5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8vqyU5W7V6KYJbO0ZaF3PEzfoC6EnF74r9b7dxyZQk5v0pDo32n1LKynfXJZ3KFiFWdygP3xA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrymxqov1bQmETFCdq3AsweezJnQQ562qkSeeMwzfEK09gs3Y/
	Ji00MYr3cp480YEZs7RiQwM9RyLuquEHIObU4wr8PKA9iUjT98U9GwhMJ8fsNUuT/TlAvYBbBp5
	NLzs9mQ==
X-Received: from pjxx6.prod.google.com ([2002:a17:90b:58c6:b0:366:191:7105])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:578d:b0:35f:b572:ece9
 with SMTP id 98e67ed59e1d1-365ab3e614dmr11651413a91.5.1778241124664; Fri, 08
 May 2026 04:52:04 -0700 (PDT)
Date: Fri,  8 May 2026 11:51:17 +0000
In-Reply-To: <863d7892459fd7627388d8b0c1670292.y2k@desarrollaria.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <863d7892459fd7627388d8b0c1670292.y2k@desarrollaria.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508115204.4068686-1-kuniyu@google.com>
Subject: Re: ipv6: ip6mr: Call ip6mr_fib_lookup() under RCU in pim6_rcv() and reg_vif6_xmit()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: y2k@desarrollaria.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	idosch@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 21CBC4F5FA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285772-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[desarrollaria.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: y2k <y2k@desarrollaria.com>
Date: Fri, 08 May 2026 13:21:21 +0200
> Commit 019c892e4654 ("ipmr: Call ipmr_fib_lookup() under RCU.") fixed
> the same issue in IPv4's reg_vif_xmit(). The IPv6 counterpart has the
> same problem in two places.

No.

The change is just for rcu_dereference() added in the commit below
for ->exit_rtnl() conversion, but IP6MR is not yet converted.

---8<---
commit b3b6babf47517fde6b6de2493dea28e8831b9347
Author: Kuniyuki Iwashima <kuniyu@google.com>
Date:   Thu Apr 23 05:34:54 2026

    ipmr: Free mr_table after RCU grace period.
...
    Note that IP6MR is not yet converted to ->exit_rtnl(), so this
    change is not needed for now but will be.
---8<---


>=20
> In pim6_rcv() (net/ipv6/ip6mr.c:578) and reg_vif6_xmit()
> (net/ipv6/ip6mr.c:624), ip6mr_fib_lookup() is called without holding
> rcu_read_lock().
>=20
> When CONFIG_IP6_MROUTE_MULTIPLE_TABLES=3Dn, ip6mr_fib_lookup() accesses
> net->ipv6.mrt6 directly without rcu_dereference(), while the IPv4
> equivalent correctly uses rcu_dereference(net->ipv4.mrt). This
> inconsistency means IPv6 multicast routing lacks proper RCU protection.
>=20
> In reg_vif6_xmit(), rcu_read_lock() is acquired at line 628 after the
> ip6mr_fib_lookup() call at line 624 =E2=80=94 too late. In pim6_rcv(), th=
ere
> is no rcu_read_lock() before ip6mr_fib_lookup() at line 578 at all.
>=20
> Suggested fix for reg_vif6_xmit():
>=20
>   + rcu_read_lock();
>     if (ip6mr_fib_lookup(net, &fl6, &mrt) < 0) {
>   +   rcu_read_unlock();
>       goto tx_err;
>     }
>     DEV_STATS_ADD(dev, tx_bytes, skb->len);
>     DEV_STATS_INC(dev, tx_packets);
>   - rcu_read_lock();
>     ip6mr_cache_report(mrt, skb, READ_ONCE(mrt->mroute_reg_vif_num),
>                        MRT6MSG_WHOLEPKT);
>     rcu_read_unlock();
>=20
> Suggested fix for pim6_rcv():
>=20
>   + rcu_read_lock();
>     if (ip6mr_fib_lookup(net, &fl6, &mrt) < 0) {
>   +   rcu_read_unlock();
>       goto drop;
>     }
>=20
> Additionally, net->ipv6.mrt6 should be accessed via rcu_dereference()
> in ip6mr_fib_lookup() to match the IPv4 pattern in ipmr_fib_lookup().

