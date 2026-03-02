Return-Path: <netdev+bounces-262775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OqxJY/TpWmQHAAAu9opvQ
	(envelope-from <netdev+bounces-262775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 19:14:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFF21DE4D4
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 19:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACA3D303DABB
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 18:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4341C330D43;
	Mon,  2 Mar 2026 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4tLn7Az"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8B30DEDC
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475277; cv=none; b=jBIQdrm3Z20fkVfDl1KTQq82CuiOEmlJmECvZLd/TDy2vz2AZw29cSoVR3RL8kXvDGjhNag0Bm0XZ4rGO7LXcIkGb+t8igV6K+GnUhv8RZ/nwpvsT32i2D1pSwwI0RiGlTUu7uT4k2Fl45Bwmo5YVpNXYZEDP2OEWBG5SQcbbkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475277; c=relaxed/simple;
	bh=Wr0PnyJ2+tVWY5LQUuc8GJW+GcNslwrZ8Jd5+9vJ73c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ghWzpHvfF9bZyrrgLfNYHIJetnvlZv8EqJKe0bm34hiYYDrXK1euIUem+hpDnsuaakMREj2+5UcyRu5W2McDVkidGlrldnmnIr4SVt9PKJZXz+1WSC2IeNesQX0RMx1p8qLVO4rMJtcpJqYIgM5j+XO/m0VYRkAkFoXNmi4pvLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4tLn7Az; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cb3b0d938dso3972701985a.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 10:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772475275; x=1773080075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m6kSYdvUaHCqp6LFFxtjvvPYOzPb7dudlzE4a2692cQ=;
        b=a4tLn7AzLwKAsMhbf1efroeNOXiIPtITeLOAbxMQ+V3wOUtHOMrdGLGrt3lbInVzBE
         XQJ1yxuyFKx5gN7IiHeyA2G72dHiFi4BJhAKt7WvTIlmvgfSKCximnbddM80zbK5Pvzm
         ZCSyZcMJIy27L3VE/e9b3gRtDmbSoJ3i/kxjFDm8iQ8gncCbdBUO7xUJs5LhXnGIanSM
         TwjHlBfl5/DxTa066YAbfzy5bsfhFr5t5sQEow8H9FCMmtrKqUIyGn8EWVt7xpA3S/UA
         ShzvHdt3wmdeZs0Kwc3tKkb4T+PhdRi3Bff+hIETnlgHuhcoUU2uCTHGFV0ZXPcloavh
         E9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772475275; x=1773080075;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6kSYdvUaHCqp6LFFxtjvvPYOzPb7dudlzE4a2692cQ=;
        b=eVcoTCw6Io/YuwDm9TnMGeQxYnD4ZCeOk1RrznDvO5+fbaqNn0U2RW4wTv8G1VsTRS
         wSRaOGyr6Oy+JeMpKMTt448TBGLZqUuB3twbuMGyoFkoVVSPM8neWf94ATzy3R26lRpV
         E4yWwKSkL3xYcRMZSFo7cykSyjdsm0M6xAYzEJNUPmzZQuAE4SAWPr2QmPPZqEP8HzuL
         2G1zuCiargMFuDVm9B2ti/dEaqk7Pf2slyK+vAjvMzRmBQs8cJioUC6ZiAnZgYYhtgYn
         1CAjKDkFOZ/B7AnfiY8e6lbmVv0RPtoOieZVRHZ5MaX8Lb/bxxkCSKXxddBnHAj+XK4J
         nnMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnPZO49Z79gCoq/gXfP1YqiBn+X7EFVqMdjWIPZhcGcb0uK+dLlL+wsaTHpNWuKgQpTDZB3wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsy+ZujnmwoDVL7QiYGIMlgN0XQ2PpM+a53FvEK+a7LWVR1N8q
	aj1Eh5PAmx8Glz3BjRG+68JCW0iTbkjrWRt2Nllz08mWufPicZ+du3fb+CEmSzjwIIqc5tb3oN9
	qU9gtMR+7EDH8dQ==
X-Received: from qkgf19.prod.google.com ([2002:ae9:ea13:0:b0:8ca:30dd:e140])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2591:b0:8c5:3415:aceb with SMTP id af79cd13be357-8cbc8e8095emr1707545085a.32.1772475274431;
 Mon, 02 Mar 2026 10:14:34 -0800 (PST)
Date: Mon,  2 Mar 2026 18:14:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302181432.1836150-1-edumazet@google.com>
Subject: [PATCH v3 net-next 0/7] rfs: use high-order allocations for hash tables
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EDFF21DE4D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262775-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This series adds rps_tag_ptr which encodes both a pointer
and a size of a power-of-two hash table in a single long word.

RFS hash tables (global and per rx-queue) are converted to rps_tag_ptr.

This removes a cache line miss, and allows high-order allocations.

The global hash table can benefit from huge pages.

v2 and v3: address various kernel bots reports.

Eric Dumazet (7):
  net: add rps_tag_ptr type and helpers
  net-sysfs: remove rcu field from 'struct rps_sock_flow_table'
  net-sysfs: add rps_sock_flow_table_mask() helper
  net-sysfs: use rps_tag_ptr and remove metadata from
    rps_sock_flow_table
  net-sysfs: get rid of rps_dev_flow_lock
  net-sysfs: remove rcu field from 'struct rps_dev_flow_table'
  net-sysfs: use rps_tag_ptr and remove metadata from rps_dev_flow_table

 Documentation/networking/scaling.rst | 13 ++--
 include/net/hotdata.h                |  5 +-
 include/net/netdev_rx_queue.h        |  3 +-
 include/net/rps-types.h              | 24 +++++++
 include/net/rps.h                    | 49 ++++++---------
 net/core/dev.c                       | 61 +++++++++++-------
 net/core/net-sysfs.c                 | 83 ++++++++++--------------
 net/core/sysctl_net_core.c           | 94 +++++++++++++++-------------
 8 files changed, 180 insertions(+), 152 deletions(-)
 create mode 100644 include/net/rps-types.h

-- 
2.53.0.473.g4a7958ca14-goog


