Return-Path: <netdev+bounces-282009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBKZC4Ps8GmBbAEAu9opvQ
	(envelope-from <netdev+bounces-282009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:21:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95512489CF8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ACE73188062
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A899372EEA;
	Tue, 28 Apr 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LYp2jEKE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56D333F595
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395858; cv=none; b=GauUQzW6gL5rBA1wdzgKPhmKzsalLos1AUqgwPZJU+4nO92szxkgWSGzSjHlzU64WxRNg2U2iOrxZ/sIXScf4pZydztO9cBATDLTOtp4bGErEQgvfLPgAujwFcxyW0MhcgZrkZke1MTr/UrX+bgPDAzzale8PECkAo6plGZ6dIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395858; c=relaxed/simple;
	bh=pO6stthgR/V4ZXefRDeAnuht+jkmnlnRKLcdFg7WKnY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BDt4Wni9rQ71N9Ig/IV9yMdzknita/fkNtUgInPgc5UGQcDxjP3IVIAgYjOwjlc3P0i+SMF3SrTTEN7T8heO6r8qcHhQWA59g39IKlnvNJ8gnSbF2tFMLz5+n0m8Q4ouqRihM+jYfYRWcM6dq0ZOlGTDNQQiQ4S+YQHT8ERHmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LYp2jEKE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-79878791ec6so262814107b3.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777395856; x=1778000656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3tcICOxMBTI2sSaaw3mWzDuzaXjEAMWkGT7RCWACzuI=;
        b=LYp2jEKEKo59jx1yticTA25o5v+GtQFOLG5oXrfInlIemkS5hE8rrUQIyNjTaU2Wqx
         viaOeo483+ZbbU/SmIQ20vGHBKJ87NS6ua8tvfX2uaRkGIbXd1HaKQHt1T8/KstR8L1m
         5o/plFhoZ1fwLgLbrUBbRR32eVA+LphoFtrAt0HqewF6Q4IE0OcF9UtRR38+vQVedr0X
         reXPeHpfqC44sKpRJYS8NKbMGg+70Hwu2KegIobw/clrTfnf1JwjWvNkK5rQ9fnhgz4k
         6XmcIr3V0MyReyvA7eT4hTufSb+EOrV1RQcAGqc0GWAUTCwxovgmxt0VCuHxTv6jkFnW
         3kUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777395856; x=1778000656;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tcICOxMBTI2sSaaw3mWzDuzaXjEAMWkGT7RCWACzuI=;
        b=N73CSYF7jnDy1GSfLpbdj9g74GCWGghv3oEMyRJIZkSqTUQ4M/Nhp50bC67rU24bQJ
         tQ0wLMaUGb9R+xCP8MaA1zMAKSGxv25LIS7YyMmFgjr7uRzZ1WB4m6uybKJH9omNFf0n
         FR42A+U/BwuCNF7SZSkymz4+JUNwLOS6xDYS39rjn5qYMQZZmr3aO/wEUXYtluwP+vLP
         rd4ZZlRo+EPC0LxjauU0t9NdayUtw8aUTG+ScI3c3MQzCUN0h+KVZKAlVF8BAstyxDr1
         idMSFrZuL7lBa0q378ABk/GJ1f1QniXenbCn9tjdIS+RTFhkf7J9h4+8FQBWYn8WwHiA
         PcFg==
X-Forwarded-Encrypted: i=1; AFNElJ8cVYtRE9RXoISOr/XFbiJdJyOvqUPvomXcaQt3bRZPGWnzpGNHDg9NusvsLlY7lmIFy+xQPhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaoLSBw5cutPDwDeVb6wvjBtkpnZrqCA4m4v2W6NdUQsS+X6iR
	XcUHIRftDJRII0sAaKf4Hhv6WhodAEDbJnRxYgaW6EnBG4n0fVZRDLG1xbfx4TkOl1Spg0gYqaG
	Fmj8wCWbKb8GdYQ==
X-Received: from ywbkd8.prod.google.com ([2002:a05:690c:4f88:b0:7b3:59b0:79d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:c50e:b0:7b3:b0a6:2c5b with SMTP id 00721157ae682-7bcf50e7662mr41690017b3.12.1777395855732;
 Tue, 28 Apr 2026 10:04:15 -0700 (PDT)
Date: Tue, 28 Apr 2026 17:04:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428170414.250566-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/4] net/sched: tc_dump_qdisc() optimizations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 95512489CF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282009-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Before converting tc_dump_qdisc() to RCU, we make the following changes:

- Use for_each_netdev_dump() instead of for_each_netdev()

- Only dump qdiscs of a single device at user space request.

v2: addressed Jakub feedback (thanks!)

Eric Dumazet (4):
  net/sched: propagate tc_fill_tclass() error
  net/sched: tc_dump_qdisc_root() refactor
  net/sched: switch tc_dump_qdisc() to for_each_netdev_dump()
  net/sched: speedup tc_dump_qdisc() when tcm_ifindex is provided

 net/sched/sch_api.c | 129 +++++++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 60 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog


