Return-Path: <netdev+bounces-298338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7F0+KzUcK2pF2wMAu9opvQ
	(envelope-from <netdev+bounces-298338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:36:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA25675334
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:36:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=IH1VT3MY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298338-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298338-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FEDD32A9E39
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B59399D0C;
	Thu, 11 Jun 2026 20:34:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703D25A2DD
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:34:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210097; cv=none; b=SG+RSOqMdPaQyzkHN0JnpF/PTu0E/R9T3gfyxJZV8ZWj+/GLIi8H+XIp87O8piXfGcFMn0NhoPsSH6QlyoPVW1QjRgOUKSOIkgFKSYxvYk17Z6fK/babNggPt0e/dEoonxd7hsaTJvNWB3wNRCk44Wv1uO33L2+qLMKYsAsZFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210097; c=relaxed/simple;
	bh=7VfpZ8dgZUIdt5b4gRulfd8Mi+d5+Ac8mVUrYifKbQU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OnSMRmxheHmP8P6E7idSn/f6TF9AFFZNoNsl1PnQ1AZoiLOdjQqeYj87MOJBu64e3IRlQQAaoliOMiBnot73f0WxtXLmAqfXVlYfWLYfq3VYx7B+fB6N570L8JJTmgGGPL4SVT6PyLlICaSeDmtIovzYWH8tFWPM8e4adfEGeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IH1VT3MY; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-517ac42d958so3485151cf.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781210095; x=1781814895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ArBJBBLrMDUi4Q9RUdtcTsCIfKVynO6jif8Gq9I/YJY=;
        b=IH1VT3MYlGU4CkNPWn//2igseow8w7gsyLfPi1b8tX9I+4Lj+NhrBEufPJfYXBRvZB
         vsZNcags2cRUGgZ7XhBxhpyBN5GDV/ZxbUK1gMxKHH1llr+s2YtPJURur9QYhSSesydd
         JzRiPDcYebdxYtPY5Sf/2O80fWAJW5YtvpnpRCHlZaJVLGzM7CLQmI6oylDka2ykXdju
         3OtFdKfERv5+B+hzsf9dK8wIhc0J3gb6GpAIEZZ8b7FpMXkzw3mrKDg37Eu3arsiG2cP
         7fwIBClW5viycXEdoFaAeak5N6QW4r8OgF4+ht4s+PFHJ5Lg/v9Z5SWBZ17wYym0CPU6
         eZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210095; x=1781814895;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ArBJBBLrMDUi4Q9RUdtcTsCIfKVynO6jif8Gq9I/YJY=;
        b=h9CUwct3p6gdzaMhVGFsC59coVtPtrvh1lFGQWJkAEOq9ivcP1r7tHbsgolzxctP6x
         zhxcBJYCc4tSxFWHFjJrvIYEF159mnBbr0voBCDAJ+rMWiq0gvhhB9Pm2lnBlc9mT8R1
         FSgcjmEh9XSt1UuEg5IB7el1uyN7WD4m02D0tiZoigJsxDGZXRoHlnaV+f2pHtiKzQV4
         Do0jArpajMY4l+MhBXKeypv04F6TATQ64KqMRbAWaJrGK7mEueB9ivmkiizfhhl2Tb/l
         TUSX+ElBT360hI6cXb1+1VET/UA0GfKVwAui06uFOW5tqShNxztBAlQOGuLF82qntLdQ
         CZZw==
X-Forwarded-Encrypted: i=1; AFNElJ/4yzG4XqNkVU4Cxp/jI710qEA/3igvROnz9WebiqCWiOR0mLnsIeOcqr3Pqr9+cTadQJpeaHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+dO8AlMUgqtU4J6MWqtnrJpLZCvP+Ptbw4ozGsfWaBXzNDzVI
	758NtI/JPeEIUQSQmjGucKgpy4RNJuu7Chpc9QksdSar/0Mka8R4wStfQwRMNy8txNiQaQGkjAG
	ja61oMoxfcGsYDg==
X-Received: from qtkk6-n2.prod.google.com ([2002:a05:622a:a946:20b0:50e:41ac:5218])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1786:b0:517:7e26:369b with SMTP id d75a77b69052e-517ee23cb4cmr69651421cf.35.1781210094685;
 Thu, 11 Jun 2026 13:34:54 -0700 (PDT)
Date: Thu, 11 Jun 2026 20:34:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611203453.3067462-1-edumazet@google.com>
Subject: [PATCH v3 net-next 0/5] net: bridge: take care of p->flags accesses
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298338-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,blackwall.org,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AA25675334

(struct net_bridge_port)->flags can be read/written locklessly,
and thus can fire KCSAN warnings, or real bugs.

Prefer atomic operations (test_bit(), clear_bit(), set_bit())
and use READ_ONCE() for the remaining uses.

v3: addressed Sashiko's feddback on patch 2.
v2: addressed Nikolay's feedback on patches 3 & 4.

Eric Dumazet (5):
  bridge: use atomic ops to read/change p->flags in sysfs
  bridge: use atomic ops to read/change p->flags in br_netlink.c
  net: bridge: use atomic ops to read/change p->flags (I)
  net: bridge: use atomic ops to read/change p->flags (II)
  net: bridge: use atomic ops to read/change p->flags (III)

 net/bridge/br_arp_nd_proxy.c | 22 +++------
 net/bridge/br_fdb.c          |  2 +-
 net/bridge/br_forward.c      | 15 +++---
 net/bridge/br_if.c           |  2 +-
 net/bridge/br_input.c        | 12 ++---
 net/bridge/br_mrp.c          | 20 ++++----
 net/bridge/br_mrp_netlink.c  |  8 ++--
 net/bridge/br_multicast.c    |  5 +-
 net/bridge/br_netlink.c      | 93 ++++++++++++++++++++----------------
 net/bridge/br_stp.c          |  4 +-
 net/bridge/br_stp_bpdu.c     |  2 +-
 net/bridge/br_switchdev.c    |  8 ++--
 net/bridge/br_sysfs_if.c     | 60 ++++++++++++-----------
 net/bridge/br_vlan_options.c |  2 +-
 14 files changed, 132 insertions(+), 123 deletions(-)

-- 
2.54.0.1136.gdb2ca164c4-goog


