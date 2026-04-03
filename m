Return-Path: <netdev+bounces-275177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOG4CAoZ0Gks3QYAu9opvQ
	(envelope-from <netdev+bounces-275177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:46:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3E5397D97
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5E2A302BA00
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 19:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371AD3D75C1;
	Fri,  3 Apr 2026 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nFi20XOH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E6B3D6CDC
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245473; cv=none; b=q9WPVUJJ3TZ++OvSO0awk2TF+Wv4xBJwg1ZNWtwgavgQj1HtCqudndLGvFLwRsk5+/8SjQxET6etPkdpKO6KQ0xIskjF5U3xhWV9h6Jo7VANjM2YjQ/wyOivy3O9I2ie+t70vy9al0wtXtembL7MgmKaBZCXG2z33efdbBTVk9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245473; c=relaxed/simple;
	bh=7g9TPBs4nSmLr9xjGRKVMq0s37awyZgPlffRNI269Os=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PHqSWsWrY5Di4q/u9jFV3yqARFhjBBKcAThDOm/HQvVQ+LecDvv2eIrD/U8kCJu7L2zAX2vzlfH5b9KIjNii21ceicqaDNu70ww0e5Ao1VyYEulNyNwdXtlpyz0noaDFH/l9lPLopQ6sN1/TvojzrrUtmepdm3etyMemNt44IGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nFi20XOH; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c646e980bso1150317b3a.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775245471; x=1775850271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TUY2ZHSKwgX6VMsUKdwQar+WTelOKcZTTtyDtzteivQ=;
        b=nFi20XOHYipVJ8APPPjXVisBsbpCNKIo3bDQfUkaW3gVTW19E6Jfu5Jl19qukn5SOq
         /cOk2F4KaenzsPnjPs8JmeFWKyUhjbjUc9oE58eiw9IWjmznLSSALT0+dggOIksCbN1b
         AJJ55hTsWhtqTzj3GedRvtV8KodePB9h91suBoJO+2bH4iQLqCVAfRL/KDYSHQkvG7w/
         SuZ92hEA+KYrdOcffQ5kRFQN11EtUmpl1n1xZny0/AI5mWQldj8Xlcm4+xmxiTOIEmVb
         E5g6HS1OYhRbKqFGU4/wKfNgVC0bEjmwwgf09NMpf5zLPa1i/K3D0Faq3WdTxgCkEc6X
         IywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245471; x=1775850271;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TUY2ZHSKwgX6VMsUKdwQar+WTelOKcZTTtyDtzteivQ=;
        b=NMmuC2CoH2fW/QjMvlFkgQy+Y4HILtmIgGglti+vuaTkMNevBX9adSJR1i5tijispb
         C7pCauzcZMCr+Hs3LV3HrAGRuHg6Ye5HilAXJ18Zj2+RjlkR/jplnMMrI40ch+0TaMBR
         aEj1PPdNvkyIW7sB0lXSAUdAHOaS3vXQAcaWt/zsvFINHId3k6jYfQOOFL80ybYyQ/Ma
         NhjTFiq6h3E0oB0PiTSu7C5Bp8xEZIV9QtztkiKC14JV05Opgv8LD1gfmpUpWTt4Zqkg
         6hrTtDUgBh+jNuGjdH1KVq8ATSoT9AJuI2KBJURWff9cQUGjA49il5JhC1PCQGaf+gVi
         7HWQ==
X-Gm-Message-State: AOJu0YyFdrNHRQBn1rKLYTeyA+/zsb2lxqJnuo2xcDz7sL+0MhN+ouTj
	vgqzTVcPOAfhwmUavK2FYmNSOrK/diN2gv8aEmuD229T2sUbV0DcJXvDjddYG+vH8Vwy7t9H6Yp
	Zalrkrok8xkCNTABk21vpZIN3EQ7bYqjDHAOCMNu46+V86K1bqKAk6W6REuiKr1u8XIeYpNhctn
	dGWnCh1kNFsEdgECa9polECN1OSRQUmA1lKEy7UzLPE488eVYmv14fYFJtl+VapPY=
X-Received: from pfbdo17.prod.google.com ([2002:a05:6a00:4a11:b0:829:a0ce:bddc])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1794:b0:82a:14aa:795f with SMTP id d2e1a72fcca58-82d0db6279fmr3875150b3a.35.1775245470310;
 Fri, 03 Apr 2026 12:44:30 -0700 (PDT)
Date: Fri,  3 Apr 2026 19:44:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403194427.1830609-1-hramamurthy@google.com>
Subject: [PATCH net-next v3 0/3] gve: add support for PTP gettimex64
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, jordanrhee@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, yyd@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275177-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E3E5397D97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

When tested inside a GCE C3 VM, this enabled chrony to synchronize the
NIC clock and system clock with sub-microsecond precision.

chronyc tracking
Reference ID    : 50484330 (PHC0)
Stratum         : 1
Ref time (UTC)  : Sat Feb 14 01:53:42 2026
System time     : 0.000000001 seconds fast of NTP time
Last offset     : -0.000000000 seconds
RMS offset      : 0.000000001 seconds
Frequency       : 0.686 ppm fast
Residual freq   : -0.000 ppm
Skew            : 0.001 ppm
Root delay      : 0.000000001 seconds
Root dispersion : 0.000000812 seconds
Update interval : 0.5 seconds
Leap status     : Normal

---
Changelog:
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
 drivers/net/ethernet/google/gve/gve_adminq.c  |  26 +-
 drivers/net/ethernet/google/gve/gve_adminq.h  |   4 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   3 +-
 drivers/net/ethernet/google/gve/gve_ptp.c     | 317 +++++++++++++-----
 5 files changed, 268 insertions(+), 94 deletions(-)


base-commit: 5446b8691eb8278f10deca92048fad84ffd1e4d5
-- 
2.53.0.1213.gd9a14994de-goog


