Return-Path: <netdev+bounces-304726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +3aBD31iSWoR1AAAu9opvQ
	(envelope-from <netdev+bounces-304726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:43:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CDC708483
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:43:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Hu9L2Es0;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304726-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304726-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 558033006086
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A0C3043DB;
	Sat,  4 Jul 2026 19:43:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9231DDC35
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 19:43:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194230; cv=none; b=nmXkov439u0eT3N1g6aNswtjbqnmIBQvdf8MVJ6CqpY31JrjLnFURYw6ggZT4lbfAIy5RAKFK2zL5MetSLm/MBMYm9t6SCKEWv/RZEeeyyTmTIE7fzY5WVprbFxCIEmhN3sWBhQzEobzM7ojn0ELpY1HJoxKlczQanXg2YNPNtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194230; c=relaxed/simple;
	bh=nDcqpfcSYtGiTmE1KtE64eNhffrCJt9Nx+rVod+WUtA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NguGMdIIUyIggl+fV51FpPuLwrFj1QLN1+CGeXcJEnLKB/YurWnhlMkBWx0sNpsToz0BBBrek6JwyQAsrzY1V1irDaU5OQqT6bjvHsJL7m1ZcrEvXrdlWLcboTW7MJo34YRWCwsZOjRhvX6gO13/hYylW1lLUCiSkvTC9iuI3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hu9L2Es0; arc=none smtp.client-ip=209.85.128.201
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-8001bbd2f36so44244737b3.2
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783194228; x=1783799028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SEcHqH0eg/YeS2pxbS09R2DgHUajNbw27MHOYqolFF0=;
        b=Hu9L2Es06bxNT/JRDE9vz3TTIFzYh2DiEdX5pKvA6dG5rORMBgRYw+JhuWr/fSg+Jg
         gRJFPhtKOLmNKWhaoBQJGSr8Tjf0DQTjrD89GipngCP6dZenXCavB6yF77BPvin4HEeN
         5kTgtkgf7im4fKKyn40u67+DBmCzfpSPvlymuaEW9kyZ0hk2w4oRsp1Y0gSeeo8y8mLa
         3aw6b/VctR0LgjLkWp3Zkt7evx/qOfN3XJm3GB6JmbFH9ZRP0I3z2M9nibP2W2dQje6Z
         ppTdfPwWg+tehOwQqO3ZQDkgfXINrWWha4tFg6ZPxCTdKubzuv8Qnh1a3xbbPfvfTe68
         s8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783194228; x=1783799028;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SEcHqH0eg/YeS2pxbS09R2DgHUajNbw27MHOYqolFF0=;
        b=VGa7RaYXxoGFpScASM6mFdvECyjXt/dz55cyZt9un4sXA5HnT0se9P8eKOGzgCIirG
         3abezyZ9lyRJSQV3bxmnaEgMy/vA12PZm9zv/PjQvSXw4aJLfG243qI1MxWsMo18VIsA
         cu+rT4ch4goFIxm/g+iCrA8G4LybKydaVHV/6CqkZnPjK+tDW1IssUQef82Rew07jH9x
         oSAH0B7GXGmwI9vLkyoe6SDb03RWXRi5tOmwVTxyFH8UD2xw2ecX3iFWFiEx/r2SHwG2
         nQMYaId8sgxvhaZNJWs1K24V+DSuMK+6lER47Ot23SWsCW6PhW7Y1azPYNpNlVq5vviK
         LR5g==
X-Forwarded-Encrypted: i=1; AHgh+RowvJYFoTaM6SVB8zv2+bj0ErTHCEzsWJL39JrCitUMG9xEeKP8j2E13wCOjSBHABS8cfjW/b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoGh90r5GPs17tmzsqGCQEifiJc3Q2Fqx4i12AdmEEANyL29VP
	+SUYh4eXebrrLYPH3ttefCx/BDSAQw67i4XCs+RuCucgP8FPitCT1fdeEkJCRuah1zg7E+/e86Q
	QJpHB+4GBPwLqOw==
X-Received: from ywbhj9.prod.google.com ([2002:a05:690c:6189:b0:809:f6a9:17e0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:888:b0:814:6d86:8197 with SMTP id 00721157ae682-817397ecd48mr47230847b3.44.1783194228247;
 Sat, 04 Jul 2026 12:43:48 -0700 (PDT)
Date: Sat,  4 Jul 2026 19:43:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260704194346.4065071-1-edumazet@google.com>
Subject: [PATCH net 0/3] ipv4/ipv6: Fix UAF and memory leak in IGMP/MLD
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304726-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38CDC708483

This series addresses two potential UAF vulnerabilities
and one memory leak in the IPv4 IGMP and IPv6 MLD subsystems.

The first two patches fix a UAF where the packet receive path races with
device teardown. If the device refcount has already hit 0 (but the memory
is still held by RCU), incoming IGMP/MLD packets trying to schedule delayed
work or timers would call refcount_inc() on the 0 refcount, triggering a
warning and eventually leading to a UAF when the work runs after the device
has been freed. This is fixed by introducing safe hold helpers using
refcount_inc_not_zero().

The third patch fixes a memory leak in IPv4 IGMP timer modification. When
a timer is deleted and not re-armed, the code dropped the group refcount
using refcount_dec(). However, if the group was concurrently removed from
the list, this decrement could drop the refcount to 0 without triggering
the cleanup/free path, leaking the group structure. This is fixed by using
ip_ma_put() instead, and deferring the put until after the lock is released.

Eric Dumazet (3):
  ipv4: igmp: Fix potential UAF in igmp_gq_start_timer()
  ipv6: mcast: Fix potential UAF in MLD delayed work
  ipv4: igmp: Fix potential memory leak in igmp_mod_timer()

 include/linux/inetdevice.h |  5 +++++
 include/net/addrconf.h     |  5 +++++
 net/ipv4/igmp.c            | 21 +++++++++++++++------
 net/ipv6/mcast.c           | 38 ++++++++++++++++++++++++++++----------
 4 files changed, 53 insertions(+), 16 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog


