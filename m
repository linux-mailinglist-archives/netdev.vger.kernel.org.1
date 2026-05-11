Return-Path: <netdev+bounces-286848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEA+Ir1jAmossQEAu9opvQ
	(envelope-from <netdev+bounces-286848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:18:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88347517380
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FD1C3009F27
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86995356748;
	Mon, 11 May 2026 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WbEmcW53"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DECE313534
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541496; cv=none; b=P4gFI53UKokqQM1bFu7NNbQad2NzAcWe+09zXxQAU0b/Nfe0tP4UC9AgQgxkm2RVqG6mQEgitI0XGwJNOAUDK+SIDOvWdo1Mn0OPvI8Wr4crv1Igz2lfTdclk6q+CLIQjEEPv/Cg0Ix+bpJJYJL95bC609iukjYJdQORdMtQY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541496; c=relaxed/simple;
	bh=P/+7QckzkN3iWZB0fMIG0eUn84IR4BnpoOomVbsBJIE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Gdw9alaZAALrmDSvE3BvKR9dBCn8UOcUKSG8F8unkAchOH8wBDum/hOubA0UuTOUS6B97HEhMFC4NydE8LD7olQBRF79EjTkdo0RfXyeAzNeMiBPtuHQFQJKsC9koxiKn+PrAJkFO3WwHeI8iR7pcbFEqilMJn1jZGYmGLKV7l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WbEmcW53; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828acf7c1dso2135288a12.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778541494; x=1779146294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tNeZSJgyteowdX1SRkPcPc59AOt7e3AJKwYQvQ7+AYQ=;
        b=WbEmcW53QskcWcQbE4e0GBcz7MBeZAgK3FbtESNcc690pCgonov9Yw3N9t/gE91bbk
         MEIJUKt1Y16b7Pz9AjthYkLyYw6dI3xmfqEbfiKuqczX6z/p6uql5/D5YY+BHXvyb9SA
         8zzxPCaWxdJLjZBxhSQI9WD69dhxpmTyZkYLUxBIemnu97N0iOyyIAjdWYqrlAEhNqXh
         6mTjsAgb6d7a1D9X3buNSyBfAhbL/N55d6hxjJRdn1InYvrr0DiDBsSEiKxZdNSB+u5Z
         lBSlhYkOZEmba3Xt+uppULdorH+DX+9DGqbM4nXm56r0n+0H6xESNz2gRBNWiOW+okX6
         CtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778541494; x=1779146294;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tNeZSJgyteowdX1SRkPcPc59AOt7e3AJKwYQvQ7+AYQ=;
        b=KNxJz040XtmTHgRTgpgQ0ebPo8MptBrhJ6nLp0Ol2v0vve7uDFSI/5pmhX178/VEb2
         8qYarsaEBul8lEkJqa7PkJkWL+/RoegY5t6sIUnzKadLBea+onIDHC1bWx1D+HHV4HfK
         wewf8vLXJ+H0glvXHtUoh2ZiYL19f857fHLS8CU/jxjYpkYRfeDu6EAw5a3xuNN0aYLk
         woF0ydnOLfo+ittcyn+9uopkMSZ/rsjQ174xxoCIsh9ln6idDNfUH3oICyfWEqUBnqDO
         Dv7WNvBq7qfPLvCOpZ5Vc0msWwjo+6oTB3xsouQExa4LpgYzoBdE8a2PYry3ZfzgX5rS
         XDKw==
X-Gm-Message-State: AOJu0YxaB/0WkXtHejiwYTxcIzUtZ1QMMIqbrIoFQjWmPB5dnHW6IsGD
	Dm0cJyCqrTT/zsT4IWrN5KzvCcw2qgrNqgNjYdG61iF2iiF6VFt8h1tyy6v17kqIAabEe//mHpY
	fRwpygrB/Kwg5YLx6mKCEFHlv54qQax1u0/BsPYBdsL3L6wRWynUU6MoaCSw94wqaXcPAyJNMCq
	Pb9h5IVemjknLXvOgTdLnDF4768XiAVYukHzjzHdfxXjFLNXddWnf9g6ZgBXsOYoU=
X-Received: from pfje16.prod.google.com ([2002:a05:6a00:d0:b0:82f:6eb4:9793])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3901:b0:83d:446c:498e with SMTP id d2e1a72fcca58-83eebe8294fmr468880b3a.39.1778541494066;
 Mon, 11 May 2026 16:18:14 -0700 (PDT)
Date: Mon, 11 May 2026 23:18:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511231812.1801984-1-hramamurthy@google.com>
Subject: [PATCH net-next v7 0/3] gve: add support for PTP gettimex64
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
X-Rspamd-Queue-Id: 88347517380
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286848-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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
V7:
- Changed err from u32 to int (Sashiko)
- Actually committed stubs for adjtime and adjfine (Sashiko)
- Picked up Jake Keller's review tags
- Link to v6: https://lore.kernel.org/netdev/20260507211304.3046526-1-hramamurthy@google.com/

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
 drivers/net/ethernet/google/gve/gve_adminq.c  |  30 +-
 drivers/net/ethernet/google/gve/gve_adminq.h  |   4 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   6 +-
 drivers/net/ethernet/google/gve/gve_ptp.c     | 369 ++++++++++++++----
 5 files changed, 333 insertions(+), 96 deletions(-)


base-commit: 63751099502d10f0aa6bb35273e56c5800cc4e3a
-- 
2.54.0.563.g4f69b47b94-goog


