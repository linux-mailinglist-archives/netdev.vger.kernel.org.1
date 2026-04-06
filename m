Return-Path: <netdev+bounces-275779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPudA1xE1GnPsQcAu9opvQ
	(envelope-from <netdev+bounces-275779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:40:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4990E3A832A
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F422303D703
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 23:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A08632ED3A;
	Mon,  6 Apr 2026 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrjAOLZY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3293191BB
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775518807; cv=none; b=FE8zN8u+XQ6oZTRcRZjtOVlJS71WgyVxhSrkDmS4cd+w/l22AHBGG4BNLRNJhqrDV6Z5CkiWYgd1Mb0OCUQUNfoM360ANbFW1NqNwF+QHCi3tBAh3y5bPtPZRkBYOVyJ4EPNECTeB19Bsor8JUQ6dqXPKtpAgLOJwy+xSw82amA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775518807; c=relaxed/simple;
	bh=mGt75SnvaPRypeP+PnFAZmsCVL+F9lljS2GpxdG288Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mHAXCWGNL14Q5YoE6U1XXqCYdPhONnYFHPE3zKGpbRBsSGzQOAPmM1aC0a+WwzAvIDA99EyuH7FqPw/fA/C4uc4KbqPk3Cp+qmQ56mKs0bc1ATK+tvNsqo28YbWGNnL6D+fJqpc5MRAC6CJhT9sAfOkqLRekm89ajQjHSeYKnWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GrjAOLZY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b250d3699aso108969145ad.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 16:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775518805; x=1776123605; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1hcYTP3VT53MAcPTyOSTzBSmynY4NyEpZMracFsGLhc=;
        b=GrjAOLZYndynJXhTGlJABZKrYIkOn9+Qw0/8fp8RbFoH5bUqSGn0oti4z52ncMzQzZ
         ZnCu7+oW/gsreW2eOqwhWmNTGpxuHf/FrwwPB98dq3/dNUhBd2hiCZBunbapAt9QRx6/
         RZDPZH+DD7Rfc2pjgF+vnClKM0QnOhiY80EF6y6ncV7RonzQFdAV89Rr1Ysc2j+B/Otj
         g/5nDult53Pl3BIX4pBXn0kMaOf3gbF3Uhmiti/84Dd3nTyD4PsRMkFdHYnKTvDaHw+/
         mp3J6YYHeVIQnSPHsBhDyjHdIWcrQ+BoGAZLH/YPCsoGX2ZYCay6FesNJVJ0oePkdZWk
         VDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775518805; x=1776123605;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hcYTP3VT53MAcPTyOSTzBSmynY4NyEpZMracFsGLhc=;
        b=oHX5v7rLSwyycaBXozA8+NduUIofi5a3qfIvk/YhM3W135VpLMxrnWgu3advKRZUiY
         v4rndkvpGIdJsBV5z7DU2rtD5KFaSvVK/Be6MaGZDkrks2200u6l6kxgYCq5XaL3RLv0
         323s/zSu1qyk5mLa4p8ijSoaYtSmCn5eJNkzEnnohIupGM3jSkPccFbmWP6nbbzXQCIw
         u0h85RsO3Y88OXagTGZumXW9UTiU7KSRbPmBrD1DfK4nvMKj6KZP/eYSTmRDmZOLamfE
         NsYXybVTQMkHz2vlt1U9sTBnrGPVT2HT2L5FiQtQGFPcV0JWHCVDslgUwHtJG3heyg1d
         P9CA==
X-Gm-Message-State: AOJu0YxFT+v7WXcxM4fb+2DaExh0yjkqXswbJeIHe5INS4q+Wf1YXXSa
	yq6t1ThffWjFmnfs3nIFpBp734Yl8TEVNlAn7OE540RTBZYmeDzlL8DakBguOj4dV2f6gM8tbfc
	Ah6ivoAj0w6oeOTuYRAITVh72AgGajFcftDcWOMAFQHHrnmvviMS2TmJnwsq0wK769ntCQ0YfvR
	/HmQ3F/3Tx7auEbZul/5wzcRNrRFOIRJHalsWG5Ts0jVniDruq68RKwsCP9cZUkOY=
X-Received: from plbms7.prod.google.com ([2002:a17:903:ac7:b0:2b2:6f73:54e0])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3c47:b0:2b0:67a7:5c4b with SMTP id d9443c01a7336-2b281802d24mr160270145ad.28.1775518805097;
 Mon, 06 Apr 2026 16:40:05 -0700 (PDT)
Date: Mon,  6 Apr 2026 23:39:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260406234002.3610542-1-hramamurthy@google.com>
Subject: [PATCH net-next v4 0/3] gve: add support for PTP gettimex64
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, jordanrhee@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, yyd@google.com, jacob.e.keller@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21]
X-Rspamd-Queue-Id: 4990E3A832A
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
V4:
- call out change to dev_err_ratelimited() in patch 1 commit message (Jacob Keller)
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
 drivers/net/ethernet/google/gve/gve_ptp.c     | 317 +++++++++++++-----
 5 files changed, 268 insertions(+), 95 deletions(-)


base-commit: 5446b8691eb8278f10deca92048fad84ffd1e4d5
-- 
2.53.0.1213.gd9a14994de-goog


