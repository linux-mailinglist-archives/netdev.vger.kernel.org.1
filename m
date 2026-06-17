Return-Path: <netdev+bounces-300263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z54xDlckM2qi9wUAu9opvQ
	(envelope-from <netdev+bounces-300263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:48:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB4069CBB4
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:48:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lfoltrSG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300263-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300263-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1326B307D8C2
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 22:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7AA3B14B2;
	Wed, 17 Jun 2026 22:47:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC353939B3
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 22:47:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781736464; cv=none; b=iq5ZLxu/Vx2NGhQ2/oo5rcaCeNQM+jivaK/ovIG9K1c/UCb6UK0FRopY2OvpDtvStvUCvxCcnRH7izJtBGYn/tpEv1hy58ROvmMADSURa9MMPMppFgK3mcF8DGUbttbtPHJ8a/SrdZfyQgQYzVx0yeJ+0IxF9ooyrvCxoIgncn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781736464; c=relaxed/simple;
	bh=0Pw+svSWJOtjmDDewpriaF+GOGAm5aaXJWRfsX8EmrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bAjaouFtCHCVeOJ1k86XhHf37h16EPTLByWl6Ny5t4J2cMNKVOk6MiJEvgr2u2P2RYYDBuUVwtDhVIWpHRiSp2m1ZSZfPR43djj7hNzSIsLxl0J21vO2X96YGJN91djRWNytyuoQQU7gorNTwOWS81faoL4ScslVrdlilX7JQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfoltrSG; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso110356a91.3
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781736461; x=1782341261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/y/t5Vl5iUpYZm6pqLSniaJaDjD3Clg3KVSkarvnkg=;
        b=lfoltrSG7grlGoSqXQOM8cA7fEB2pkJWPdj0rviNxZXbf1iNCDkcxf134Fpxxdi9TP
         4cu5DW+9Lz4WQ8Ru7iTb18vIcspmrDX9JSZYGvRmnMIaMsTtslw1IMh0NOKDTa+6VAHF
         +BPdgpCVWJ7fTJI02n7mzQenErqYXP3rebLuLbTAMPtgDLuvVx0aoGEuOGo6oI8j0BKn
         cWEhnbxE1dtUssdEqqhnOiCC4N98w8djbsNwS1ODd2tutOjPYNxPntimVglerCXnQjkW
         WDheYs3UpjSRMBO8TNeP4KsG55KIu4N/pvqTxhdCgns5mQ86C/dp0dcXZ3h1WsyIWGWJ
         STCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781736461; x=1782341261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/y/t5Vl5iUpYZm6pqLSniaJaDjD3Clg3KVSkarvnkg=;
        b=cMv6c84gYxkuDgOrrHkkjZXKPWrCRmUJnN34S9Zn04C4BKJnsQcLMKqRDCI9FHaEo9
         PZW1pxh/3bPLPxVSqtJVUQwTMTyuj64uaJYXUtzrN99N2W8gVeNBJXv80g2ALBNYfRC6
         PCYiA6iwjSveR12PJGC5VIlrD4/Pa03KKRVcG+DMzB1g06VN3eMImfqP9/8aoB85WRi2
         PVAFy0XDNYwQffn/+V0EcScr60iTS6CQTjxMOoyrfELRNHTRaftDBhaDcoa4fDUD2br7
         6m3bv28X74QaEjx0T94TUuYKN/Z5XtbYjRMUw53BcKtFDzAyIjYDgHAFHHCEKYEYN+o6
         KlYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8owfxSxN07aUbiKal4uX2upbs3NEFen+duqy11cFJvSW7H7kzD06D6cmW6UwsAMEyZ2m/wlFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5eiZobDYfDtPFyPl+JDrUU1V4BJC7uyw6FIUoGf9P5YynkX4
	+nz0xZ2KbQ9h52BjSkozMY3EbbytcLBBsfsdXYPjH9LAgcEupoiwxr2e
X-Gm-Gg: AfdE7cm9nTVt3mBNx+qHCS8MI8WpC04tPHUpW++NyrefSVjGOlMuHnHj4oS9Zs/d1nf
	FAct5OPFOGWKkLdrLFoJsDrGO5TViWGzzmiy3EcAMFa14PQcs5QmepzoaSsWI8ioEyM/HFPotwX
	T+o9kGb0n6fiabM9wrjE5m8O9A+XH6oBE/+lEq4OFuu5Y5OfBmocVawoueEJlJ6MeOdF8ZLtzU0
	WdNLS2IWHQSy33BZpQEOlWtwecj8cebmpw7/S4YbUsN1FwUCsJeFvtO1ZKZ6MKfw6U6zPZnxO+z
	gKV4pASEaHNjLcWLQjKYLPWOnrUhUpw71ofZTy+ihPAia2an0OBFKYBbSYfLTBi+9FHHZso8yTi
	RaIVHOykGFT1eLX2UIkLBHs0zrmnqzuWRu3TnuESiKBOlycbNWiY1N2YWWH/p4pYcoRYUZyFBUm
	QvgGFN9RRflAJiK+gUQY1mBx40WblM75+lFwLUq0kYUv2PZWOjuOMyTQOljYHp8LHzwhX7Miw=
X-Received: by 2002:a17:902:e945:b0:2c2:245a:3366 with SMTP id d9443c01a7336-2c6bc24a8a6mr55669695ad.27.1781736461349;
        Wed, 17 Jun 2026 15:47:41 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433844a70sm170772265ad.84.2026.06.17.15.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 15:47:40 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: ameryhung@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	eddyz87@gmail.com,
	edumazet@google.com,
	emil@etsalapatis.com,
	eyal.birger@gmail.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rongtao@cestc.cn,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	toke@redhat.com,
	yatsenko@meta.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next v3 0/3] bpf: bidirectional VLAN support for bpf_fib_lookup()
Date: Thu, 18 Jun 2026 04:17:26 +0530
Message-ID: <20260617224729.1428662-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com,etsalapatis.com,linux.dev,redhat.com,cestc.cn,fomichev.me,meta.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300263-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:ameryhung@gmail.com,m:a.s.protopopov@gmail.com,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:dsahern@kernel.org,m:eddyz87@gmail.com,m:edumazet@google.com,m:emil@etsalapatis.com,m:eyal.birger@gmail.com,m:hawk@kernel.org,m:horms@kernel.org,m:john.fastabend@gmail.com,m:jolsa@kernel.org,m:kpsingh@kernel.org,m:kuba@kernel.org,m:leon.hwang@linux.dev,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:rongtao@cestc.cn,m:sdf@fomichev.me,m:shuah@kernel.org,m:song@kernel.org,m:toke@redhat.com,m:yatsenko@meta.com,m:yonghong.song@linux.dev,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DB4069CBB4

This series adds VLAN awareness to bpf_fib_lookup() in both directions.
BPF_FIB_LOOKUP_VLAN resolves a VLAN egress to its underlying real device
plus the VLAN tag (XDP programs need this because VLAN devices have no XDP
xmit), and BPF_FIB_LOOKUP_VLAN_INPUT runs the lookup as if a tagged frame
had arrived on the matching VLAN subinterface, for iif policy routing and
VRF table selection.

The l3mdev/VRF flow-init fix that was patch 1 in v1 and v2 has been split
out and sent to bpf on its own, since it is an independent Fixes:-tagged
fix that routes to stable on its own schedule. This series is otherwise
independent of it: on the default CONFIG_INIT_STACK_ALL_ZERO the VRF
selftests pass with or without the fix. Only the one full-lookup VRF arm
("IPv4 VLAN input, tag selects VRF table") depends on it, and only on
INIT_STACK_ALL_PATTERN or NONE builds, where the uninitialized
flowi_l3mdev otherwise misses the l3mdev rule and the lookup falls
through to the main table. Applying the l3mdev fix first closes that
window.

Changes v2 -> v3 (all from Toke's review unless noted):

- Split the l3mdev/VRF flow-init fix out to a standalone bpf submission
  (it was patch 1 in v2).

- Patch 2 (VLAN_INPUT): bpf_fib_vlan_input_dev() returns a
  struct net_device * with ERR_PTR() for the -EINVAL case and NULL for
  NOT_FWDED, instead of an int return and a **dev out-parameter.

- Trim the BPF_FIB_LOOKUP_VLAN and BPF_FIB_LOOKUP_VLAN_INPUT UAPI doc
  blocks, and drop the in-function comments that restated the commit
  message or the flag doc.

- Patch 1 (VLAN egress): on the skb path without tot_len, the deferred mtu
  check now runs against the resolved egress (VLAN) device, not the parent
  params->ifindex was swapped to, so a VLAN device with a smaller mtu than
  its parent is no longer checked against, or reported as, the parent's
  larger mtu. Found by the bpf ci bot; this was an open question in v2.

- Patch 3 (selftests): re-run every case through bpf_xdp_fib_lookup() as
  well, since the feature targets XDP; and flip the no-tot_len mtu arm to
  expect the VLAN device's mtu after the fix above.

Open questions (defaults chosen, noted here in case a maintainer
prefers otherwise):

1. An unmatched, down, or foreign-netns tag returns
   BPF_FIB_LKUP_RET_NOT_FWDED, matching the DIRECT path when
   fib_get_table() finds no table, rather than a new return code.

2. BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_VLAN_INPUT is rejected with
   -EINVAL; restricting now keeps relaxing later backward-compatible.

3. The name BPF_FIB_LOOKUP_VLAN_INPUT reads oddly next to
   BPF_FIB_LOOKUP_OUTPUT. A pair like _VLAN_EGRESS/_VLAN_INGRESS is an
   option while nothing is merged.

4. The egress flag leaves a VLAN it cannot reduce to a physical parent
   plus one tag (QinQ, or a parent in another namespace) as SUCCESS with
   the VLAN device's ifindex and the vlan fields zero, like a plain
   lookup. The input side instead fails closed (NOT_FWDED) on the
   cross-namespace case. An XDP caller cannot xmit on a VLAN device, and
   a zero h_vlan_proto does not distinguish this result from a physical
   egress, so returning NOT_FWDED would be safer for XDP. But the two
   cases differ: a foreign-netns parent is clearly fail-worthy, while a
   QinQ egress is still a forwardable route (tc xmits on the inner VLAN
   device), so failing it closed would reject a usable route. Should
   egress signal NOT_FWDED, for both or only foreign-netns? I left it
   best-effort, but will change it if you prefer.

Taking the tag as lookup input follows the approach David Ahern
suggested in the 2021 fwmark discussion:
https://lore.kernel.org/bpf/6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com/

v2: https://lore.kernel.org/all/20260616223426.3568080-1-avinash.duduskar@gmail.com/
v1: https://lore.kernel.org/all/20260609172052.81613-1-avinash.duduskar@gmail.com/

Avinash Duduskar (3):
  bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
  bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
  selftests/bpf: Add bpf_fib_lookup() VLAN flag tests

 include/uapi/linux/bpf.h                      |  41 +-
 net/core/filter.c                             | 125 +++-
 tools/include/uapi/linux/bpf.h                |  41 +-
 .../selftests/bpf/prog_tests/fib_lookup.c     | 554 +++++++++++++++++-
 .../testing/selftests/bpf/progs/fib_lookup.c  |   9 +
 5 files changed, 741 insertions(+), 29 deletions(-)


base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
-- 
2.54.0


