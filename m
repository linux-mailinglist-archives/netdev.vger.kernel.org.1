Return-Path: <netdev+bounces-282172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOUPGL1e8WmFgQEAu9opvQ
	(envelope-from <netdev+bounces-282172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:28:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE03A48DF58
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5836D3011C40
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C35243951;
	Wed, 29 Apr 2026 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RdC14iyG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C193723C50A
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426106; cv=none; b=HzbLcg3rD1ETwRxGKA+dUZVYtJe+aPdizVv4UNQBDdomhWHqogYxOvJk36Q1+BXbcSORqlUqbrsnzt67ulkF8jNQhazvjSol5lrydP0ygPw7mRZ/QAWb6Q9CVO2JEKFccTOZy/2Wne+8BZYbyjog8N73eWIQNpF6Ii/yDw3EeSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426106; c=relaxed/simple;
	bh=zmJwPP5H/36Qy9Yn78dY9bAnPw5MKgKV3aHtvdWwKAI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Zh8TppM9ddPqW82FAtkKrt9bURRXvMGnl4kTt7el8zuxvbqKlxqQ0F0HhQlQoTIynr1JZGORaeSXPIBKpYTgC2Sm3LqsyBNIWsaBgw+VUBjfbOnxGRU/JLmcNAFPOAde9pf0dVzgPb5KCuUe6jHkLYZCfKniloxE9QLJeYNuGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RdC14iyG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35fbb5779e8so12626452a91.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 18:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777426104; x=1778030904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mu0FUvPadnlRyYwD6jTUGg5RqUrWd3I8LqUbgKPP4HU=;
        b=RdC14iyGtx35EFv93IjHTPZZwdTJTPn+YMRkaHamWdC2FzcMezqF7jvMXEDFAKMfxA
         NWmQs/ywswaFdJRUwo7+8tbnzdykYQbzb4XifSCG4Ks+Dp8gft5Nk6+pbGyqxwuC/l9d
         kTFJNHa9dfhrFypsGUPDHMyQ3C2wfx/rvOPkIiohThi4WteHkEAHcaerZnfB9+Htb0q9
         ydlDSu1c6rHwvHJ2oNyPX7a3mt9nrpHbkhiKQTCV0fH8DK5xF1nIq+SCd6qugHJx9277
         9gO+U6aosrCdRskINg106gI/6v/DZv1LAiBpABGo7H/wSy9clkExdprSOYEaPV1J7TpQ
         zYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777426104; x=1778030904;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mu0FUvPadnlRyYwD6jTUGg5RqUrWd3I8LqUbgKPP4HU=;
        b=HuDR6ZTTsYh4cT01fRnS/Ut62ApgHmavKm4wmxUMBG26+XGjbKHuPYEfgY9/nMJak8
         llw5Vjmg3c7PeO6ktmQSZGpfpWACArArNT7NXHOY74P14kEuIeeIMmCnSs4oIatFSkIK
         HkwR7/7QT33MRhzxqCVmizT1Hjf//M2TA2nK8W3hFAPoCt/G2mGwPFwh1PLsU9voHqYd
         kVDwMsvYPY3tBG1MxDahu0ttnhLmbp30WYD7TIHAMKEIWrGEbeuyUabGL4zQ/XwS69uU
         YVJxBN0cnCAenqjzEKMEHkco5OpqbxiiYnMSgfVL/Luk58PMLrZUF3mfIPlDZmwGRpqE
         bGdA==
X-Gm-Message-State: AOJu0YxRdKO1CqzBf5mhSr8dBAaRlWw2MbZwh2eRVyafbKkXStzhvZ/4
	n12CCu1IUrny6Gxzd7xiW7skPllCsJ9vzEowgeCrVQOmY0ILbzgHTIYO5X+iIzfJay9IhfKYpGI
	5kvHkOCzTT3KhjRAcc7gERomd0Q3aNiChf2NSE4speOcHE7lrWf5UUgXdKRL4up0zZrgWMisHkE
	3QsBlJF9iXDe7DtlVEZTPzNHHQxTmK7mccJiu6bDmtsGcsSDMy7a0FsWTac6GyeHY=
X-Received: from pjbga9.prod.google.com ([2002:a17:90b:389:b0:35e:5ac0:1246])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:562c:b0:362:f860:f9ba with SMTP id 98e67ed59e1d1-364a0ae65c7mr1771280a91.1.1777426103485;
 Tue, 28 Apr 2026 18:28:23 -0700 (PDT)
Date: Wed, 29 Apr 2026 01:28:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429012819.3102675-1-hramamurthy@google.com>
Subject: [PATCH net-next v5 0/3] gve: add support for PTP gettimex64
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, jstultz@google.com, tglx@kernel.org, 
	sboyd@kernel.org, willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, jordanrhee@google.com, 
	thostet@google.com, alok.a.tiwari@oracle.com, pkaligineedi@google.com, 
	horms@kernel.org, dwmw2@infradead.org, jacob.e.keller@intel.com, 
	yyd@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CE03A48DF58
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-282172-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.952];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Jordan Rhee <jordanrhee@google.com>

This patch series adds support to obtain near-simultaneous NIC and
system timestamps with gettimex64. This enables daemons like
chrony and phc2sys to synchronize the system clock to the NIC clock.

GVE does not have direct register access to the NIC hardware clock, so
it must issue an AdminQ command to read the NIC clock. Due to relatively
high latency of AQ commands (~100us), it is necessary for the hypervisor
to sample the system time sandwich inside the AQ command.

The first two patches pave the way for the PTP implementation by
quieting excessive logging and refactoring an existing routine for
thread safety.

This table shows a comparison in chrony tracking statistics between
the typical implementation pattern for gettimex64(), which is to call
ptp_read_system_prets() / ptp_read_system_postts(), and the
implementation in this patchset, which is to use the TSC values from
the device. The RMS offset is nearly 4 orders of magnitude smaller in
the chosen implementation.

|                 | TSC from VM           | TSC from device (this patchset) |
| --------------- | --------------------- | ------------------------------- |
| System time     | 0.000000005 s slow    | 0.000000001 s fast              |
| Last offset     | +0.000005606 seconds  | +0.000000001 seconds            |
| RMS offset      | 0.000009020 seconds   | 0.000000002 seconds             |
| Frequency       | 4.115 ppm fast        | 0.362 ppm fast                  |
| Residual freq   | +2.515 ppm            | +0.000 ppm                      |
| Skew            | 18.480 ppm            | 0.001 ppm                       |
| Root delay      | 0.000000001 seconds   | 0.000000001 seconds             |
| Root dispersion | 0.000081905 seconds   | 0.000001169 seconds             |
| Update interval | 0.5 seconds           | 0.5 seconds                     |
| Leap status     | Normal                | Normal                          |


---
Changelog:
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

 drivers/net/ethernet/google/gve/gve.h         |  12 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  |  27 +-
 drivers/net/ethernet/google/gve/gve_adminq.h  |   4 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   3 +-
 drivers/net/ethernet/google/gve/gve_ptp.c     | 316 +++++++++++++-----
 5 files changed, 267 insertions(+), 95 deletions(-)


base-commit: 790ead9394860e7d70c5e0e50a35b243e909a618
-- 
2.54.0.545.g6539524ca2-goog


