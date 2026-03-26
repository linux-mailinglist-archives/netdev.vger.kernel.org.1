Return-Path: <netdev+bounces-272274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE7XGqW5xWkeBAUAu9opvQ
	(envelope-from <netdev+bounces-272274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:56:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E7C33CD45
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D579305A484
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40003345CBD;
	Thu, 26 Mar 2026 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mccKv7sH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A584B344025
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565133; cv=none; b=kcZfpQ6zWeaA9pu973clVcGGmcvIzjHiBJR3T5HhxHT6XAjaj6RfBeuKwVKZOlBlbDgqbT49Z2ppnjS2eNCXInVlfWDujhl1hAeuz/oDxJYJVBeRvppXeFNPoWqXCma/XEW8XulRgNl+bLK/ESAPWvl97iMywne6MbIq11jpptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565133; c=relaxed/simple;
	bh=d24yFDrcbVdxC849ACOfVcdtjeCjV7I6Vta77nevR88=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=n11oQw7Ja9rG7vNNTbShWV6FoQtlbHERrkAZcdRTpNiAYYAaP5VoN5/+X2a6P43SHnGdM9duxn2NupEwX2ZcobXn3GZjJQ54eHJBNMQPMD+DRSBYwpsNQTnmA1cJ+Xipfe+fEBGfuhJ7UXHFwoyXwFV8dVcN8MuZz0TbQMxvDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mccKv7sH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7422397574so2578754a12.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774565131; x=1775169931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L9mfLSr3iC4uQpiQYaWzWq/7NPFs0+yjP9nmA8PkcV4=;
        b=mccKv7sHtWj7jKEQz40DHnEgBv0NP7dj+LELq6J4lyipNQqy15awFl4sGm7iZ7LVOD
         uxJMXZUFvDGV5JtE95E/YXCg+Y7yBmbTwXdBHARjPoIHVqy9hi32EaH+dqRsOhLHy8PC
         D87KqFAp6c3WX4VGdWUcvhv75aqiwUmPd+QXSsZwOSt7tSSVkKALzBs5X/x/obdNKK7H
         UzhBTXuuSqRJLNXRZotMC4+tMWlKI0sem2L6s4VY5SJByLvjJbqiaShZgVbpyvDCK6WD
         4QD2MyFNLUy6dzyRjzIHGObBYR41ckbceWS9GWHImbWLtFCne6Z0D6TGSLBZhs+3kQj9
         N0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774565131; x=1775169931;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9mfLSr3iC4uQpiQYaWzWq/7NPFs0+yjP9nmA8PkcV4=;
        b=pnF6y6ROzev7V1vWP8gX9dJaLUVPmlr7PRCHbw0+RRgUOxk1LIbMW0nkirfcfkoAhl
         fYt611mafccIoZYPewIzwU/zpjNseTeN4peE9WgInFzAHvxrcAim/I0uyVLe0jaTS+Fy
         knq02BECtRE931vC+71fURNjn5MJepu3/5NWdFoAk9j9SSA5mvF+GOTl8MVT5OAHfPAt
         ua238lfv3PC6UP+8zXF1tVVcw37EwgNWqe1sqo87HI78+GCl0uScsfX4aJ1Q//HsTSd3
         In1X6olVEubxKhoUdi1uRZr2AU4y7HV9tchZdIYtHiP53keLbUi/niFmCA+eTdNwA1gv
         AN/w==
X-Gm-Message-State: AOJu0YyZJF6NmMZL1kQ+VcnvrbN/D1oLlBlrSQHZb5Hxf8jtvOTWeXbl
	PlDK4LT8heMoLp/F+vyBfq0VRZNm8CDhiuxeEuCue6TKAk4IMXFTWLa3NyNqpWcMEmItT+tCfKy
	0hwxoGk4PN9rTJ46SpFle3Xk6R5ntLMZlZDr8R2KPADoUc2foStOnEDc+6F6yMzDOzkbapJBjo6
	hhwfetWnjl3fghAayUAVvwdkbsJ/U0tV6cKS+PZLPQbC4ly+J92vvObXzcTy4tS0o=
X-Received: from pgbcs9.prod.google.com ([2002:a05:6a02:4189:b0:c74:390e:55b3])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2a15:b0:398:bcee:4506 with SMTP id adf61e73a8af0-39c87b86836mr250935637.38.1774565130483;
 Thu, 26 Mar 2026 15:45:30 -0700 (PDT)
Date: Thu, 26 Mar 2026 22:45:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326224527.1044097-1-hramamurthy@google.com>
Subject: [PATCH net-next v2 0/3] gve: add support for PTP gettimex64
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272274-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74E7C33CD45
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
V2:
- Fixed compilation warning on ARM by casting to u64

V1: https://lore.kernel.org/netdev/20260323234829.3185051-1-hramamurthy@google.com/
---

Ankit Garg (1):
  gve: make nic clock reads thread safe

Jordan Rhee (2):
  gve: skip error logging for retryable AdminQ commands
  gve: implement PTP gettimex64

 drivers/net/ethernet/google/gve/gve.h        |   6 +-
 drivers/net/ethernet/google/gve/gve_adminq.c |  26 ++-
 drivers/net/ethernet/google/gve/gve_adminq.h |   4 +-
 drivers/net/ethernet/google/gve/gve_ptp.c    | 209 +++++++++++++++++--
 4 files changed, 220 insertions(+), 25 deletions(-)


base-commit: 5446b8691eb8278f10deca92048fad84ffd1e4d5
-- 
2.53.0.1018.g2bb0e51243-goog


