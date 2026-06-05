Return-Path: <netdev+bounces-295560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sxQOHkEqImqCTQEAu9opvQ
	(envelope-from <netdev+bounces-295560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:45:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA3D6447FD
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:45:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=fX4PYkiv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295560-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295560-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B50B303F987
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56D43CFF55;
	Fri,  5 Jun 2026 01:43:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A43C584A
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:43:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623815; cv=none; b=l5hmMk0Yd6FdN6pV/PmN5EFoL1fmIs/LlZAd0aEUHxXFH3FZOFDkHWntFSBB2vlL4GSjx3EMaqIMxmo4DqJgPIcc43OeDtMmWB3CPq3hYpYbRMS877bFjMXyMJcj83Rd5vMUMUvwoA4+lb5iDmCj9WfV6K9cT4eHEU2EBPHzueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623815; c=relaxed/simple;
	bh=58lYn4NE3WI2y/xPW1YkIlCmljVDW939C14m1Tbmczc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J9DGdWMlKTgvHkUKsVPZOqRE37UoTv1cBLds4u92q/B++1k8Ml6e3OAErTcBct55hZHSGf30jN8GLI3e5tOqjdj962ZfF0hJ3Rj8fyq53icGVS/OD0rtQadDEZD4hs2crTCSz1snMNSxBU5oN0cCmTCLFD1jxxo92U3JN53MzgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fX4PYkiv; arc=none smtp.client-ip=209.85.160.74
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-43e09813423so1348479fac.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 18:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780623803; x=1781228603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h2ow12NtxvVPueHOKMb1jCbeRS9jueVp2e0oPGXbXU8=;
        b=fX4PYkivtbOFs0PWAKAEgTpJog32kB5SbrF68qz1SsO6xAKNzlwyvrDWXC5BHSm9X5
         LtRM3DOmGosaECu8sa3Zxtz+rqFZsPR6IRvXObZE6a8dTzqCDDsV+LPPW1iltJ99zdGw
         BT6kq23yAFqbxCvzf+l3oVjZiSD1pJCHis5NOI/pX3mn/irIbzvkTFcPLHz1H8+MtbAr
         gagMFGlX0rbnZY++1kTdnoKQn8yrQJ/xtvRD+PImb9770zZkvRLw0SR7hmh5kznXEiJd
         exht0tkkMyKSe8TP6bDBbkKSxtewe8gQ/SJ/8HSpkMwUOBnWBok+so6nYZCtDoxs0bAi
         nmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780623803; x=1781228603;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2ow12NtxvVPueHOKMb1jCbeRS9jueVp2e0oPGXbXU8=;
        b=PPrXnhAhOH+ef7Atg67Ojxa36hIuH0yYZmGAc1UrgmpJQ0B6zfvFFhned0kA3KYnfQ
         kFEoMixW65nWup2a9xU4RaVs1MWTlHG29Kacyy9FTtYCqsgpPOWqyRG3zAJhuf1PdZiT
         3wqpRYdFo/HzlOooWTd7odNQvYWLYVXmURDckD0oVMye+ggwaJrqSvkF/wZ1Q3dQKzzc
         9kfW1fsOaKkSV5vhpJelVk8gcFciCvAVQnkUd4jsCEOHiQb0GUKUbIU+4SXRuwgvETuS
         jwmgy0du4x878N/FUNVu7PuKCFehAjiPE6uwaikwnRgN3ZqQsSYSue342m2Pm+Y4Op8z
         MaCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8HMTrAJ5ObRYU0KaGkuv7bS4b+i0eb/2IWxLQ9JATlQN6t9v6JMjEtGtb+YJjITn2hUmmtXRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt9MviE/OQzx+BVYvy+n9fiEZ28MjVgyimhXKtO+24vpfZ9hYn
	aVZONPYvLO0hCh9f9RGcrywkDARezNNrIy4YRtYCgOIjUPC4WmRUaGvIAclEgb2bhd4p+nXTLWx
	e7m2JfOqUTVWoRU3IHlsURg5osA==
X-Received: from oaff25.prod.google.com ([2002:a05:6871:c919:b0:441:1c3d:9b6f])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:358d:b0:42c:1f88:ac with SMTP id 586e51a60fabf-4413dcbd75emr730101fac.29.1780623803290;
 Thu, 04 Jun 2026 18:43:23 -0700 (PDT)
Date: Fri,  5 Jun 2026 10:43:16 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605014318.3890804-1-yuyanghuang@google.com>
Subject: [PATCH net-next v2 0/2] ipv4: igmp: annotate diagnostic procfs data races
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295560-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFA3D6447FD

This patch series addresses several unannotated data races between lockless
RCU-protected diagnostic reads in /proc/net/igmp (igmp_mc_seq_show())
and concurrent writes in serialized paths (RTNL and group spinlocks).

Following the precedent in commit 061c0aa740d5 ("ipv4: igmp: annotate
data-races around im->users"), we annotate these intentional data races
using READ_ONCE() and WRITE_ONCE() macros.

- Patch 1 annotates races around `in_dev->mc_count` (interface-level joins).
- Patch 2 annotates races around active timer-related state tracking fields
  (`tm_running`, `reporter`, `expires`) on individual multicast groups.

Changes in v2:
  - Remove "Fixes:" tag from the commit messages.
  - Fix reverse Christmas tree variable declaration order in igmp_mc_seq_show().

Yuyang Huang (2):
  ipv4: igmp: annotate data-races around in_dev->mc_count
  ipv4: igmp: annotate data-races around timer-related fields

 net/ipv4/igmp.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

-- 
2.54.0.1032.g2f8565e1d1-goog


