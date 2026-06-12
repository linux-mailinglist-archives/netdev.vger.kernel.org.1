Return-Path: <netdev+bounces-298753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zGDUAdhDLGpYOgQAu9opvQ
	(envelope-from <netdev+bounces-298753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:37:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D80C67B63C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:37:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=WyYuE+97;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298753-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298753-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4501031AA004
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0C2407CCE;
	Fri, 12 Jun 2026 17:36:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E666240628A
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:36:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781285811; cv=none; b=Y0VAe94lT+ZhVovwKDoVarOaGMg5Z6CT/xe2TKG2VtBbbckh6PI7SnN3d2dxEb6xRZ9cSiD9rWcdfYYYxMuSUYqtt89QH42bQrcKRLKCniKTD9nOL3vnNel1QUTXfZeylsLo/YWYlWSouoNiiZwv9hxs+zxYc3VhlA9FBHbPLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781285811; c=relaxed/simple;
	bh=EDZfpL0WwzkQ8hq0Wdv9p5cHlrRrzU/QFy+XGloNPb0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Byzl9KnO3nyOP+vYTYpnqILc+HS/meoKBGNQwup75amJ83eoleSlfv0hDRlff3fLeM1Mhp7mihTUbmVFX6XdueWsd8d3dp0ku+THLcACg91Z8jDSD1aJALFsILQHPfqjPUflDjJf1zcnB2dsgqBMwL2FlJ5coDd1Mbiy5YGWlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tanshuhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WyYuE+97; arc=none smtp.client-ip=74.125.82.73
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-138acbc0e69so90518c88.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781285809; x=1781890609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m0AdHFT5n0KXuYQG6JAlkPd+J0hfnrhnYB6jEfLYTzA=;
        b=WyYuE+97EJ9bsa7IhWc9y/6IJIl0afFpUBghlu8gynTlgDbeAQqzm4TgVQjEbjwTYn
         sBGUn73BwAwBqfCeUq2SPoan8RwrSlWb86c8FJ5palTE3hiqLudeCMfps+ztW3vOHreL
         UQi48/iNfNW9+H6Y/zdF27+ToZFJw+dZneqvZ8R3AIAB6GE2hMS8iV0s2fyuCVFbclY+
         zJLlD0Eywmg2//4U8qH7lzrPMLrnR0zS68mGE9yIOjGLhD+N2fJEEkE4yX3fGcFSZgQO
         avdaeG1ozxJZDxcB7ASEWN0fvi8crrP3qrYIDUPKKLJy974BRO0bS34mtXDE1Mt8QdVc
         hpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781285809; x=1781890609;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m0AdHFT5n0KXuYQG6JAlkPd+J0hfnrhnYB6jEfLYTzA=;
        b=YMZMf671MRc5x6ctfBrCMLgsIrxZTgiZLZPkW8XMH5WcqefZV5Kh+GVe5XN+uGfLjO
         jE8uN9EhZ4W33nbGlpyd1PMsQF2lVzOIGgrfm36S1YoIkgGm+y08YzET9MUdFBg324HM
         1pOG+QxVRIOGsZLYRA1v9nAVH4M5Nyo/MuzbMDMV7EauhuIV97yKnFCcvQhxThmlzZpa
         Icjtd66ggxoBwiBhKO+pDJnaqulCqYF4KZ0Y1mNuP3zKm6HmaDerGjMgIY/yMAhqs63e
         qHJWg57oRQuA+e+89LTBxzkjWITsG0EB8d2TJ+BMd/mLyfjdVJ+3/lYmLnyl4XRimeHE
         5Msg==
X-Forwarded-Encrypted: i=1; AFNElJ9bqUlCyoJq2JUi/GSEtt7j2IEXcgc76PJuGuRKaKlh3NGTLR4yz8TNwzA6+UdjSmfDBjb/Ffo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywadwq/oSdkA0C1Ng+ZYhM0RLiuBpgT9dPUvLewp5ry8NgFQni
	kgOIt/VqK2qSwV+lrrxM5DY0G4oNzQX95aiaFw2kPzeQAwSBLhQxdZkWw1zzVeHm375QVqI4xSQ
	2509U9naqEQjMigaz1Q==
X-Received: from dlec6-n2.prod.google.com ([2002:a05:701b:4286:20b0:138:4e1:4728])
 (user=tanshuhao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:ea24:b0:128:d4be:7438 with SMTP id a92af1059eb24-1384bbc646fmr2287331c88.30.1781285808673;
 Fri, 12 Jun 2026 10:36:48 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:36:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612173644.380972-1-tanshuhao@google.com>
Subject: [RFC net-next v1 0/2] Reuse threaded NAPI kthread across napi_del()/napi_add().
From: Shuhao Tan <tanshuhao@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Shuhao Tan <tanshuhao@google.com>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:tanshuhao@google.com,m:almasrymina@google.com,m:skhawaja@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tanshuhao@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298753-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tanshuhao@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D80C67B63C

Currently the lifetime of the kthread of a threaded NAPI is tied to
the napi_struct. netif_napi_del() stops the kthread when it destroys
the NAPI struct.

This patch series reuses the same kthread (thus preserving all of its
attributes) across napi_del/napi_add. This series now tie the lifetime
of the kthread to net_device instead of napi_struct.

A normal use case for threaded NAPI will be "enable threaded" ->
"configure the thread". Driver reset (that can be caused by a NIC
configuration change) often destroys the configuration and causes a
usability issue. This series aims to solve the issue.

There is a downside of this approach: If a device reduces number of
queues while its NAPIs are threaded. The kthread associated with
removed queues will not be stopped. Since the mapping between the
index passed to napi_add_config() and NAPI is an implementation
detail of individual drivers, it is not straightfoward to perform
a garbage collection and stop kthreads that are no longer associated
with a queue. This patch series tries to minimize the effect by
parking the kthread in napi_del. The kthread still shows up in
/proc, but should not consume CPU cycles.

There was a discussion
https://lore.kernel.org/CAAywjhR0TPKZ-xzqjSP709OVmZWUisDNv2CVc_VxgOrXRtop+g@mail.gmail.com/
around what to do with the kthread between napi_disable/napi_enable.
It seems that there was an intention to keep user configuration for
the kthread across NIC configuration change. This patch series extends
the effort to cover more NIC configuration changes. Roughly tracing
through the call hierarchy of napi_del reveals that at least the
following drivers will not preserve the user configurations:
- idpf: idpf_set_channels(), idpf_set_ringparam()
- mlx4: mlx4_en_set_ringparam(), mlx4_en_set_rxfh(),
  mlx4_en_setchannels()
- bnx2: bnx2_set_ringparam(), bnx2_set_channels(), bnx2_change_mtu()
- gve: gve_set_channels(), gve_set_ringparam()
- ena2: ena_set_ringparam(), ena_set_channels()
- (non exhaustive)

These drivers destroy and recreate queues during configuration
changes. If a NAPI was threaded before destruction, during the
creation, a new kthread will be spawned for the NAPI.

Some drivers do not have this problem, e.g. fbnic, netdevsim. But
these drivers and the drivers mentioned above will still lose kthread
during link flap (ndo_stop/ndo_open).

Because the kthreads before and after these configuration changes are
different, all the attributes associated with the kthread are lost.
These include CPU mask, priority, scheduler policy, etc.. If the
threaded state is preserved for a NAPI, it makes sense to want to
preserve the attributes of the thread as well.

Link: https://lore.kernel.org/CAAywjhR0TPKZ-xzqjSP709OVmZWUisDNv2CVc_VxgOrXRtop+g@mail.gmail.com/

Shuhao Tan (2):
  net: Save kthread of threaded NAPI in napi_config in napi_del and
    restore in napi_add
  selftests: net: Add kthread preserving test in napi_threaded and
    busy_poll_test

 include/linux/netdevice.h                     |  13 +-
 net/core/dev.c                                | 151 ++++++++++++++----
 net/core/netdev-genl.c                        |  12 +-
 .../selftests/drivers/net/napi_threaded.py    |  41 ++++-
 tools/testing/selftests/net/busy_poll_test.sh |  24 +++
 5 files changed, 203 insertions(+), 38 deletions(-)

-- 
2.54.0.1136.gdb2ca164c4-goog


