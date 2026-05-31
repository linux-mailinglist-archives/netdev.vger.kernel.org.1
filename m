Return-Path: <netdev+bounces-293374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZkSKIuSlG2pzFAkAu9opvQ
	(envelope-from <netdev+bounces-293374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 05:07:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB6B61443D
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 05:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A08C93025164
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 03:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF332EBBAF;
	Sun, 31 May 2026 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBRlEiDl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6D13B7A3
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780196831; cv=none; b=k2L1sWgejMLWk6bmjV1VHJVyKBbfHyYVBMqUk8ScfJ12q76KpL4M8a3l51hp+jV/Lw3+XdgV5nBk4wo5FF9D27ryjrYkjni2UJWnLW2gN0hR3cappGjHm0PugmF/FdMtnRRA4N2bBRMBjOqf+k7c35XAKHMzN5sYuTMbIrRGAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780196831; c=relaxed/simple;
	bh=aZF8ibfcTpVWXO+FAfE4NlgLei4aig18a2/6Ql+psr8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hg+s/+G6e5JyFo2GV986ThQZiW5pOm7VVqb1PeHKOSzM4+mqh8si9Tq+mOqXJgqYgKk0wAKJ7JsVv2nDQ4Qq1z7a3R2Hav2uoFoM95PHEHFnwVTEjNGRRkkQBLSAa27ttebWk/lL6AHdsjgW6C8asmHyO1YLWmVrp8USRuY0FvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HBRlEiDl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8582b167f7so602293a12.0
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780196830; x=1780801630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wcGe90UENUjqdbuFSlJAzTBdFXFc1tmmAGjowomBLqc=;
        b=HBRlEiDlmyRcg3hcNZBN2V4X0DaqTEvypfYixNbMGds3WcArO4UTi0O7m+dWmqTXrf
         OUT67nGUXCHy6AfRuC4qH0Nf9lTvwvW0piXbuG4JPGixr5oFtnF9r1oY8+Wti0NkKpKR
         wbb2kmrTpLSFNp72e2yDAT9THlY18xkL1m8wdIDHBpHkK1Tx7npuzoEPQhBxbmmgYteq
         3pGSzjvTmSLqRuTDgFO9kDncLVqlZj1/NzswV9ucBLlGFCU6IlKVYSNzHL7fy7l+Mcv5
         wgcxnlpZkIA+0EQDYLafg/EzbG2S84WRGUhqmcqz6EHa1+BrISJkhtlC7ClHmaYNclsK
         3KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780196830; x=1780801630;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wcGe90UENUjqdbuFSlJAzTBdFXFc1tmmAGjowomBLqc=;
        b=dGY8lOoZSuiZE06GKzIBHQ4soxFFUAeDbURGN25Z1Lpo2JwsxNFZ9L4C7auQI0sjuP
         3yDHRKvu3AXHpDLm1k/mywd2MZdYxsDtP/SvFnSpffqUgsAGuNg0zK7knCLQZ/hsQBUQ
         q5mRH5N3P0E8u7vj7oOGHlPjcMtckp1fFiOdkAfhUJilLiVghPneDxgZHKbak5dAsWob
         iDekFg6CwQhzqwBj8ZrU4C1c1ZDC8oym5+j8l9MVIVxpN/BP5z4Oi5/OtPTr0RwwSuXq
         dhgLHjlOFRrG4lWI7VzDxeE78JGqRPKLhr/4LpMbWKan1NhWrpej8hzZR2cbS93kC6cd
         hdtg==
X-Forwarded-Encrypted: i=1; AFNElJ+J83fpirpWrbj+Pv9ELEEKCmClU5nLnsCMG5PtBL+0Eff16ziURYhv4wGvxpoiABh7fw3mnuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVHDkgil6sL5+U0lmRGxx96IA6WNk36NWwiA87KsW3Lwn7hYqI
	8FC33x7FsX5M7SzkFW7MB/2a8BF2D8fiNPtOvHV2NrAwGhWG/GNxvK/PKWukUycXxVWyxq+2lrC
	/O96m9muZFuydcT6tM0NqMV5xPg==
X-Received: from pgee24.prod.google.com ([2002:a63:1e18:0:b0:c82:c472:2b9a])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6f06:b0:39c:787:f197 with SMTP id adf61e73a8af0-3b427f33690mr5573334637.36.1780196829612;
 Sat, 30 May 2026 20:07:09 -0700 (PDT)
Date: Sun, 31 May 2026 11:07:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531030705.3754389-1-yuyanghuang@google.com>
Subject: [PATCH net-next 0/2] ipv4: igmp: annotate diagnostic procfs data races
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293374-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DDB6B61443D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series addresses several unannotated data races between lockless
RCU-protected diagnostic reads in /proc/net/igmp (igmp_mc_seq_show())
and concurrent writes in serialized paths (RTNL and group spinlocks).

Following the precedent in commit 061c0aa740d5 ("ipv4: igmp: annotate
data-races around im->users"), we annotate these intentional data races
using READ_ONCE() and WRITE_ONCE() macros.

- Patch 1 annotates races around `in_dev->mc_count` (interface-level joins).
- Patch 2 annotates races around active timer-related state tracking fields
  (`tm_running`, `reporter`, `expires`) on individual multicast groups.

Yuyang Huang (2):
  ipv4: igmp: annotate data-races around in_dev->mc_count
  ipv4: igmp: annotate data-races around timer-related fields

 net/ipv4/igmp.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

-- 
2.54.0.823.g6e5bcc1fc9-goog


