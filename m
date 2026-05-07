Return-Path: <netdev+bounces-285492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NNIGGsA/WmxVwAAu9opvQ
	(envelope-from <netdev+bounces-285492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:13:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B47104EF25F
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24FA3031106
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5689434028F;
	Thu,  7 May 2026 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="andQxdg0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2373191BD
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188389; cv=none; b=NqO+w0rTyNoRzUj7Cl2E/eSiqnV/upSUoansxCgHNW3Z9L+7X5GrHAhArZmYwi4Ibmqqen+xuAOajjSet/7TP+FSDBDfNsV16F+nmPeBS/0ymxkeQQqp9lXQ5R4zugbErMrnYDl2s8M1sErzAczgxJDdCab9v8ef4Gjq6yW5f+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188389; c=relaxed/simple;
	bh=D9p/C5MXnaQ/+ytu22UzPKs9RYe50xHiDaYg/+9M5Jo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L13IZi8xZaojCIRSwT2uvhdti+u08SiZkKsKOyRX06Qqee8IaEA01r8M4FP2XPprQw0RU8e+n7LPg+f5Mlr7KFMoRXShA7rfzE0Brv6T6/SYvvFef3HYeU/LRP89nB4/x9m2GFqTN6lXCRyBmIyOJp1bIdzACVcYtMAoewJE/Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=andQxdg0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c802922d230so677241a12.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 14:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778188387; x=1778793187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ixm7G3TAnvosLUs13uatdzo91/06h+mlLbPUGhU267I=;
        b=andQxdg0hSBI0T0dshWd8NYAcOYtkaXsl9+U/aXV/qttUGHBQWY6VWy+4kF3UfnyeJ
         1N3NZ+F2V7hBCOhPll5WhAOkKKUFHUMxN7YD39qbvXWNSCKS0osSj6JeGet2RQiQziaV
         wULJ+vrRlINha2ZmlVGS989HBJRKNrTWYjwAgbw090XIv3NjvVwUfUZKkDZiPhkvVyBS
         c01tIF9YHFwBqHGRYY3xzzKm41qgNP6KAh4gxU+gnu8ExIYWXyV3ZY8BpArA7ps/mEyH
         +0uxbDgzcHnW0B3UMiYPP6obMZgNEL9ARuTfBdhNPfRgB/XBtzMFEApc9/5GEdD06R9T
         VqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778188387; x=1778793187;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ixm7G3TAnvosLUs13uatdzo91/06h+mlLbPUGhU267I=;
        b=BIyU2A9wLhuLhuvqTXhV9dNzh3DTbbBI5JMC8Uh2IT4rpxv5wY/7AZyVKXp6LmPdQN
         T+YBPKzW2/TX7hiYyx7cnVtssKANNahNTa7403MhzydNFwrtwQfi/shCM13tBVMV+fOv
         HgmmmFli1MFCtqyaFn2zmjF3iu0Pu8W0FZFgdeuD3EIIBn90Ol0QfwmUix2H1+NukZgp
         h42Yc3c3T5/3lpogW6IHggnTP/vMVnjUhx5R54A871Fu5OSR87x/XtvfajszpE9RqGMB
         4+v2TQl8q/rxX2Pitq7jqNA9e0S53K+tapIRWX6SRShrnTsWB0pdPjdFYmmYuk2eXZs/
         lShA==
X-Gm-Message-State: AOJu0Yw+gNrEYnUtJSQYhrOF2A5vZfoBxAFmAH5Ly3NRglbbktS0h4Dn
	k61kTSf337iIHp/YGKMpxE5eblVxAsnGy59NvOwY6bc8OR2YOb6b9rujSWLuKOuA9tZ9L1hTxmi
	MBeHv3SMAv2BXPMxIFqYb6MihujZx5xJ+XBGzYjyeo+Dm8MgpRduIONxKfczRw9/nPBPiad1gPy
	hsYAslK/ovx9tQtP38QfWOnYExLeZ8XK8jp5VAEkkawSKTyDVsHBb6qSfs0FwHWEQ=
X-Received: from pgar12.prod.google.com ([2002:a05:6a02:2e8c:b0:c76:fe7d:119])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:5483:b0:39b:e1e5:a101 with SMTP id adf61e73a8af0-3aab17d1626mr13512637.43.1778188386448;
 Thu, 07 May 2026 14:13:06 -0700 (PDT)
Date: Thu,  7 May 2026 21:13:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507211304.3046526-1-hramamurthy@google.com>
Subject: [PATCH net-next v6 0/3] gve: add support for PTP gettimex64
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, jstultz@google.com, tglx@kernel.org, 
	sboyd@kernel.org, willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, jordanrhee@google.com, 
	thostet@google.com, alok.a.tiwari@oracle.com, pkaligineedi@google.com, 
	horms@kernel.org, dwmw2@infradead.org, jacob.e.keller@intel.com, 
	yyd@google.com, jefrogers@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B47104EF25F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285492-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Jordan Rhee <jordanrhee@google.com>

This patch series adds support to obtain near-simultaneous NIC and
system timestamps with gettimex64. This enables daemons like
chrony and phc2sys to synchronize the system clock to the NIC clock.

GVE does not have direct register access to the NIC hardware clock, so
it must issue an AdminQ command to read the NIC clock. Two paths
for obtaining a cross-timestamp are implemented: a precise path using
system counter values sampled by the device, and a fallback path using
system counter values sampled in the driver using
ptp_read_system_prets()/postts().

To use the precise path, the current system clocksource must match the
units returned by the device, which on x86 is X86_TSC and on ARM64 is
ARM_ARCH_COUNTER. The clockid requested for the cross-timestamp must
be either CLOCK_REALTIME or CLOCK_MONOTONIC_RAW. These conditions hold
by default on GCP VMs using Chrony, so we expect the precise path to be
used the vast majority of the time. If the system clocksource is changed
to kvm-clock, it activates the fallback path. Ethtool counters have been
added to count how many times each path is used.

The uncertainty window in the precise path is typically around 1-2us,
while in the fallback path is around 60-80us. This table shows a
comparison in chrony tracking statistics between the precise path and
fallback path. The RMS offset is nearly 4 orders of magnitude smaller
in the precise path.

|                 | Fallback Path         | Precise path             |
| --------------- | --------------------- | ------------------------ |
| System time     | 0.000000005 s slow    | 0.000000001 s fast       |
| Last offset     | +0.000005606 seconds  | +0.000000001 seconds     |
| RMS offset      | 0.000009020 seconds   | 0.000000002 seconds      |
| Frequency       | 4.115 ppm fast        | 0.362 ppm fast           |
| Residual freq   | +2.515 ppm            | +0.000 ppm               |
| Skew            | 18.480 ppm            | 0.001 ppm                |
| Root delay      | 0.000000001 seconds   | 0.000000001 seconds      |
| Root dispersion | 0.000081905 seconds   | 0.000001169 seconds      |
| Update interval | 0.5 seconds           | 0.5 seconds              |
| Leap status     | Normal                | Normal                   |

The first two patches pave the way for the PTP implementation by
quieting excessive logging and refactoring an existing routine for
thread safety.

---
Changelog:
V6:
- Added a fallback to driver-sampled time sandwich that is used when
  the following conditions are not met:
  - The system clock source is X86_TSC or ARM_ARCH_COUNTER
  - The requested clockid is CLOCK_REALTIME or CLOCK_MONOTONIC_RAW
  - The architecture is x86 or ARM64
- Added ethtool statistics to count how many cross-timestamps used the
  precise path versus fallback path.
- Fixed printf format specifier.
- Added stub implementions of adjtime and adjfine to prevent NULL
  dereference when phc2sys tries to adjust clock.
- Moved system time snapshot back to gve_ptp_gettimex64() so we can get
  the current system clock source from it. It is OK for it to be outside
  the mutex and retry loop because lock contention and retries should be
  extremely rare, and chrony filters out bad samples.
- Link to v5: https://lore.kernel.org/netdev/20260429012819.3102675-1-hramamurthy@google.com/

V5:
- Reformulate retry loop in terms of total timeout instead of retry
  count (Jakub Kicinski)
- Link to v4: https://lore.kernel.org/netdev/20260406234002.3610542-1-hramamurthy@google.com/

V4:
- Call out change to dev_err_ratelimited() in patch 1 commit message (Jacob Keller)
- Ensure only one log is emitted when command returns GVE_ADMINQ_COMMAND_UNSET (Jacob Keller)
- Link to v3: https://lore.kernel.org/netdev/20260403194427.1830609-1-hramamurthy@google.com/

V3:
- Take system time snapshot inside the mutex
- Return -EOPNOTSUPP if cross-timestamp is requested on an arch other
  than x86 or arm64
- Fix initialization to only register PTP clock once all data is
  initialized
- Link to v2: https://lore.kernel.org/netdev/20260326224527.1044097-1-hramamurthy@google.com/

V2:
- Fixed compilation warning on ARM by casting to u64
- Link to v1: https://lore.kernel.org/netdev/20260323234829.3185051-1-hramamurthy@google.com/
---

Ankit Garg (1):
  gve: make nic clock reads thread safe

Jordan Rhee (2):
  gve: skip error logging for retryable AdminQ commands
  gve: implement PTP gettimex64

 drivers/net/ethernet/google/gve/gve.h         |  20 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  |  27 +-
 drivers/net/ethernet/google/gve/gve_adminq.h  |   4 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   6 +-
 drivers/net/ethernet/google/gve/gve_ptp.c     | 357 ++++++++++++++----
 5 files changed, 319 insertions(+), 95 deletions(-)


base-commit: 8c699be3dad7bba87cdda485dc099226cfc2f706
-- 
2.54.0.545.g6539524ca2-goog


