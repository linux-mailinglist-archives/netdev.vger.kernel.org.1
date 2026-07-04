Return-Path: <netdev+bounces-304692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q21YNczQSGpvuAAAu9opvQ
	(envelope-from <netdev+bounces-304692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 11:22:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D670738D
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 11:22:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oZoHUO1v;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304692-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304692-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 991CD3018BF3
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 09:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69E13A16BC;
	Sat,  4 Jul 2026 09:22:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8CC39A058
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 09:22:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783156933; cv=none; b=kCXoOb2raxQgwb2yXwf8KWn2HtVnZnBaYp/CEWIic8eEQJCspvB5+ZZ4yUMrjA9clvj/z43ehK5x8a7C85v3uJFEsWnJ1kgaO7YPNWQ9ptYpJkejyXm20T7YztURSjo9D3gu7c2iTRjd7n9/nZ98P4vH4gWvX42iJC2SirxS9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783156933; c=relaxed/simple;
	bh=dllSngM0zvxO1v5ssnhzMkLAGt8xboxcd17Ii9VCYBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LNVmo+kP9B/o56xVeBNfYBA7+YSSj5G7b2kBT/vH4f5c9wKpi59iEHIKBLjmjzrAc5goEJafROxI1ENAc9OTHWtcEo1PqkTsNpjq0rzhL7pb50fPyBV0T0ZQmOuPJQ8h2FzGze8ItdQuF4ChhR5pJ39gvDcFLHs3AC0gfGfpduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZoHUO1v; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-382a3fe0d28so620368a91.0
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783156931; x=1783761731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UzWJONpzkCdirFiS8VKHmgg9vJNeKiCmuT7IeyhNbw8=;
        b=oZoHUO1vyfgJsHrlj7jXnac8Y7jFX6bNCl/ftdu8IISRsqEME/uJE0/A83H8yVsc7t
         WHgiurXdOrn5zlM1oRmm50BegFEyQ30S9GgqWiqVNfBlZCJQTJa5VQNo69nm+H7NfZYu
         YV7LX4d7GySYMkDpu6jqNh/99w9z/nnf8U+XYOA82KAuEcRIyC8k9f73l1anTQNO2sqF
         2G4pKU0w4aGPSLilKQcC4Wye+w0Jr/D0Y3XqqEHJMcBtSJ0SbP+sfhluMMeIHDF/3K0D
         020XnE++zeBtNcH7tXs/3NllP9rf6Lf27nCIx4Fqm3mSJwZPSBrVQGerPUYMMvwHMHhN
         8fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783156931; x=1783761731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzWJONpzkCdirFiS8VKHmgg9vJNeKiCmuT7IeyhNbw8=;
        b=JHXhkKfDsJkQ9H5AC/Eh1k91j3u+RU7ZMFQzDv+m2PBOxzsQOi/gwXWSUk9GnJf578
         wLsalx7IqM/+VDVEElmLRGcJ7o7wUZsWxEyRDGzmNQ59CpBJsZwqciF1p59vFH7QeDvM
         nZ87AWIcvVOlmBnX0Sm6ElcaXJF84GxZ36fKqwuQfkV7pP/tf1v7qaPMnWjJHQuxgB8i
         lXdLTkTxQoNyWq9njobtEfS2o3ukzp4cF0opFEtyWYhCGtytrlVidnQ2BR1NxmwpsBnk
         eR0Vzn38X/Vglwec7R8EPNEmk4Dldxdn+HPRmEAK/L6f5ZvHPNActKKWC5Gg6YFxw9P7
         lPrg==
X-Forwarded-Encrypted: i=1; AHgh+Rpm0RysIwBvTNnwcAWAWO2R54vn65VuNflr0K/Ucrck/ehRI0iXSRRNEKJdstoV2ZtswvP0v3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc98b9K+dXOQHh23jUbyhu3utYW71B9Zy3MBhdOoWrdfAV1CpL
	VmVXTTOz/GgratfKp0yfxqO725F8Tf2GHrAm1kEEJPebngO4CzqaFyV1
X-Gm-Gg: AfdE7cmStVXIB2Vxosvc0iqgUI3+8LPJqrSBB9zCICQzlfFgnaPLV6R2K7ZUoG6ZFFK
	dI3jAeN8JTvfTEXWH22zYvC3OzAa7PSxHD5W0QJR6wp8m6C6PnxiuSM9kfNrT+Xf9ratF6HmRpw
	GEnOem4IYG9K6/8nw4hoXAKZSHtOnkKyYh0/ygCQbGGy+oApPck7zL3y87weREdl8hX683SSfu6
	DREWURSTi0pPgCKXmILM7hVJ4KREIOoff7+rQvfBbsikYoAUE3Imtl7tVPmKH5v9rw1vFrpdiAN
	gxk5z2Mgm1CkNyBwqBMtAQvybKLlMsmjK2aepmAGkOZh0iEIwAMyZ7WR8PhpfR2EJ634FhicEQc
	nYh0UG155YKhC0sunei2rwlmLKJcMoMi0SytFJmzI1NMiHnym4xKBS4sN2JMY7RwUzZtFj0PhKI
	7xt57svVD4abbr3Xcm5z0ttt+qTNL7WW8Ba/dOAI9Nu4zPXAqUaHzjdIUcAKxGcuiF/AYh4Pw=
X-Received: by 2002:a17:90a:e703:b0:37f:9ce1:736b with SMTP id 98e67ed59e1d1-3829f9ea9dcmr2672536a91.33.1783156931264;
        Sat, 04 Jul 2026 02:22:11 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc27ae7sm28006464eec.26.2026.07.04.02.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 02:22:10 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	yatsenko@meta.com,
	leon.hwang@linux.dev,
	kpsingh@kernel.org,
	a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	rongtao@cestc.cn,
	eyal.birger@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	toke@redhat.com,
	dsahern@kernel.org
Subject: [PATCH bpf-next v6 0/3] bpf: bidirectional VLAN support for bpf_fib_lookup()
Date: Sat,  4 Jul 2026 14:51:56 +0530
Message-ID: <20260704092159.1256823-1-avinash.duduskar@gmail.com>
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
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304692-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:toke@redhat.com,m:dsahern@kernel.org,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 339D670738D

This series adds VLAN awareness to bpf_fib_lookup() in both directions.
BPF_FIB_LOOKUP_VLAN resolves a VLAN egress to its underlying real device
plus the VLAN tag (XDP programs need this because VLAN devices have no
XDP xmit), and BPF_FIB_LOOKUP_VLAN_INPUT runs the lookup as if a tagged
frame had arrived on the matching VLAN subinterface, for iif policy
routing and VRF table selection.

BPF_FIB_LOOKUP_VLAN opts in to replacing params->ifindex, whose value
existing programs consume since d1c362e1dd68 ("bpf: Always return
target ifindex in bpf_fib_lookup"); without it the output is unchanged.

An egress that does not reduce to a real device plus one tag (a QinQ
stack, or a parent in another network namespace) returns
BPF_FIB_LKUP_RET_VLAN_FAILURE with params->ifindex left at the input;
re-issue without the flag for the VLAN device's own ifindex. A VLAN on
a bond reduces to the bond, which picks its egress slave at xmit.

The new return code is appended after BPF_FIB_LKUP_RET_NO_SRC_ADDR
(nothing renumbered, tools/ mirror updated) and is returned only when
the flag is set, so no existing caller can observe it.

Changes v5 -> v6:

- Patch 1 (BPF_FIB_LOOKUP_VLAN: resolve a VLAN egress to its real
  device plus the tag): no code change.
- Patch 2 (BPF_FIB_LOOKUP_VLAN_INPUT: run the lookup as if the tagged
  frame arrived on the matching VLAN subinterface): no code change.
- Patch 3 (selftests for both flags, tc and XDP paths): comments
  restyled; dead skb.ifindex write removed.

v5: https://lore.kernel.org/all/20260624030530.3342884-1-avinash.duduskar@gmail.com/
v4: https://lore.kernel.org/all/20260623025147.1001664-1-avinash.duduskar@gmail.com/
v3: https://lore.kernel.org/all/20260617224729.1428662-1-avinash.duduskar@gmail.com/
v2: https://lore.kernel.org/all/20260616223426.3568080-1-avinash.duduskar@gmail.com/
v1: https://lore.kernel.org/all/20260609172052.81613-1-avinash.duduskar@gmail.com/

Avinash Duduskar (3):
  bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
  bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
  selftests/bpf: Add bpf_fib_lookup() VLAN flag tests

 include/uapi/linux/bpf.h                      |  50 +-
 net/core/filter.c                             |  97 ++-
 tools/include/uapi/linux/bpf.h                |  50 +-
 .../selftests/bpf/prog_tests/fib_lookup.c     | 712 +++++++++++++++++-
 .../testing/selftests/bpf/progs/fib_lookup.c  |  36 +
 5 files changed, 931 insertions(+), 14 deletions(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.54.0


