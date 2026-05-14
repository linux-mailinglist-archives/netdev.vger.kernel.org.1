Return-Path: <netdev+bounces-288092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGRNALtTBmr1igIAu9opvQ
	(envelope-from <netdev+bounces-288092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:59:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 919535479C9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 942003046EF0
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 22:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011F63D2FF4;
	Thu, 14 May 2026 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2CMDmzD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569FA3CF970
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799527; cv=none; b=Kpgel4hy4qSOHDfGcNiKd84RyXp+oeRWgJRhTg/ntIKq4YMuIAmDcm4C1O02le2p6OSGO3NTlBSntxe2082Ct1yMyvQ0n1s22Ex7nPL16W0QSis+A23xc+YpqH69k2Wc+ZzFL+XC7ByNeVmWJ/dOhS/9Hf0lXahpdTwop1cXIas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799527; c=relaxed/simple;
	bh=/qjm5ZKW7H5hM0pufmFbpxERliW4fANV382lYR2qWWs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nEwKLg0xgQ3/n/PazKCngvjH9qDrxf6vCAtCk1R4uZ3uVilmp3LHmG+btv/+4pFCs8mAmtHQEn8RzhtZtFO2Fr8M9qMjxKtFq4BPxgPT/X/OrfXxI3/DC5cYDHZCrKTpmrPbbydoQaDgA9QEFkGIXNnj2Bd5Y1mXhRI5UE65c/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A2CMDmzD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-365fd467cf6so7487852a91.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778799524; x=1779404324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P6PtJDoNweIJ+/ReW/BSbxyG9TrShliqxkJhNudTCnI=;
        b=A2CMDmzDH0Gsi2qCkPRLLGai98Bu6u+6aLQ6Pyr7QIc5cKbuxNv/qtGWQDxxU4wnPn
         7tvr7ZGiNXAW77SHdSj2BN06P/8SWMF/pPis+JGz/k+U8JwdHgQ4xODRBFw0aKmqnJay
         dp+wLPHmKTN9ntgWJky4ZVplaa1l0wyDWMcNfbuX3e09lDGytQXN7KHuuhXDfkC2vlj8
         KXl+nsT70LvrZE5y8hVdbuQ7W+o3wiS7BvOaFXGO3q8fCkuH+E4DgAiiwQr31CrfCYTF
         XNJ3jWmiZJBNug4mDhFRJFwp/L5fF57QJIAdv8vNzryXIZTo/iWLBXfgV7pFPUjhoZUv
         9vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778799524; x=1779404324;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6PtJDoNweIJ+/ReW/BSbxyG9TrShliqxkJhNudTCnI=;
        b=akzH7r+A6eAH9yj3gFYScXxuJeoZsYbvDkS8cuv39sCZB60M5CK+H4kvdrzqeJn180
         WErsPXpsaNlOvg0XIS95+SRgShItNMZTEm1nVIkP5bK+ZVs1E38eQswZQsG3smWMqOTG
         8a+d2n74Ft8Ozu2AXOLVkzcrlfRldBspusUwIstkHTzvV/p2NG24bgc43KfKld8Xreli
         T/Un+Zn4Ox27D8AqE6LEhGFzGdSGQRFdu57Az1YtLDNLKGB/WCUqlgJsIJY4yizG8CE+
         ZOafaNz/Or2zQjdLexPNLlu+JhyUUfdsdBW2y/O8Br2/cRS6wQPubNcmioGtof5Xpra6
         ebww==
X-Gm-Message-State: AOJu0Ywnwi+bMBjrTRUBgvX11sR/3uV+ONiKMUsrF44z41j8iqCsiMsO
	e0UcnGWcB8uElz1PMP3m7y0yw3z/Nq4Nq7RPZHdkCBBZ8+mKV3G+o1EUVhUx/ASZOYhcVE32PTt
	0CcDCtOxTKb5iOitSjR6+44bSCd3rn+KVudrzxLZX9xhpL3/4A9CHnVSWOVpFwTUHcMO0XSPBBM
	zh3Ie2aGQPaTa8BYYP9lLIkAtHXEGnbxh8w800+3xTIXYqH5n9Fp+EV+EMC9aVCAI=
X-Received: from pjn15.prod.google.com ([2002:a17:90b:570f:b0:35d:a917:a7bf])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3505:b0:366:aba:4c86 with SMTP id 98e67ed59e1d1-36951dd5abemr1208079a91.27.1778799524147;
 Thu, 14 May 2026 15:58:44 -0700 (PDT)
Date: Thu, 14 May 2026 22:58:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260514225842.110706-1-hramamurthy@google.com>
Subject: [PATCH net-next v8 0/3] gve: add support for PTP gettimex64
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
X-Rspamd-Queue-Id: 919535479C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-288092-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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
V8:
- Fixed opcode extraction for extended commands (Sashiko)
- Link to v7: https://lore.kernel.org/netdev/20260511231812.1801984-1-hramamurthy@google.com/

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
 drivers/net/ethernet/google/gve/gve_adminq.c  |  41 +-
 drivers/net/ethernet/google/gve/gve_adminq.h  |   4 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   6 +-
 drivers/net/ethernet/google/gve/gve_ptp.c     | 369 ++++++++++++++----
 5 files changed, 344 insertions(+), 96 deletions(-)


base-commit: 8ebd24a7822cbae25beeafba49b2159d6a68a5f2
-- 
2.54.0.563.g4f69b47b94-goog


