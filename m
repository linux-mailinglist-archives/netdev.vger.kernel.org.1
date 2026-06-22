Return-Path: <netdev+bounces-301188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T/i+CfSFOWoLuwcAu9opvQ
	(envelope-from <netdev+bounces-301188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 20:59:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF126B1F2A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 20:58:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="HU/3f4iX";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301188-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301188-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2135C305043D
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAE73469FC;
	Mon, 22 Jun 2026 18:52:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1133F58B
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 18:52:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154372; cv=none; b=hoxWk0BdQVkUlyKaiCULm8QhucB6asrGnOS3W7YFXGbU8z+P+1TfqKlVw8qdGeM03YvZf0kQDK1sXdj5dq5it7lukIvIJWYX/bEe7CnQuFAa7jZTaJzLJ4jKMXeYcZYN+lIjgFikG1wCwIHYUgE7sSNlCCCosb5lRpPRp7kvDwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154372; c=relaxed/simple;
	bh=tDyYHse3WP0DNWl34llpjdqgP8tQd4WqI/dOWUIG5J8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GnnN25CZulhVal5s0i5uIH0Z1/k0OqsQQTcrJsEcWiF0KG8PrLkLqykHYNrIueHb+rYIxaRe+DpCX8KbjdYcCRCfL/EoVGw8T+6LaQtgWN3Bi7uNxqMgRpFX8sYr7PdEWPUUNZRWN2lM5ZpYtsNDGg3rD1YfM83pw71KxD9ZkgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HU/3f4iX; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-517c65c019bso120996321cf.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154370; x=1782759170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L5zUy7Occ9qQS2/iGdSG45HCNIMWOMZ4XyPILwkgfIM=;
        b=HU/3f4iXqD5GkdPaKdsMxoEy4ZkdKNWO31wcRivp8+OTFWFJEs+lwwt6+m9mtHFnL1
         ZSDcLKGk0WqjDrfMHlroHPgzDRdZjMwcevFd2Ey6TLv+aP4ZPlNkB9fPSTsS/w6GwIt7
         t6lfEfgpngBo+i93x8SbI1gqCVWWzRXibmAL3/SKEeLRBY8RmTpV4s8B5wmA6xegJtX1
         MmhSoz4QxT2OEfsbqtXS7f3Jg/C+BPxO/GFgsB+6WVm2jIixBRbE5dklsMZOl4UJyr9T
         3TsCcx7meF1MQnrwoxsF3hmeggbMzaUN3+fsyW9zyU5I/uZknPLB3rNU1i4+kLwk/Tfj
         IpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154370; x=1782759170;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5zUy7Occ9qQS2/iGdSG45HCNIMWOMZ4XyPILwkgfIM=;
        b=eJT+S4JLVJZnSQLZucFNLY0U1L2hlPj9dMNJzp8KTTu1C2cKZFSIsHWGd2hY5YTCdq
         dRNPv5ny4YnzTBC1m839rbXVavQYqZ3xtXBkiXDnsk0ychSztoW1XnMsNT+pqhkqaph7
         NhFti7ga0rUM/kmrdWoz6KAfKFM54w+6/GKPcnZBwexqn8xHGl19/OEUJBWB+PMeapu6
         i70Y9psQr2jHFYBCFnsAoKUx9BuAvSltgUDpJ0gpZIC4XBD6BXTs+QxAkozpXdjagE1S
         ivFoKHyAejXHiNCs7vUNRl3r0EfiMDBeMhQuUBBOeEyKtTDSZOQXwzR8Uq9xE8v++mHH
         Vm6w==
X-Forwarded-Encrypted: i=1; AFNElJ+RQuZyjd8m99Oj22UrTNdqeEvRFhbYRxm5peNEP9T/ezcTiqUm+gdy9BizPS5I/+fcXbJrpHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwblsyRCf1+bXTvPe/tgUwIrbusCoUMV8ndPtTtl5Axi7Nx8BUM
	xAX+BaEizwfaF0QXhqW08RL4VMRpY1bdk/Rfh1ifTC4SexHi9Vpjmm78NfAvywBSZloYUcwra6+
	ywd1EZYY3OY+/2g==
X-Received: from qtpg3.prod.google.com ([2002:ac8:70c3:0:b0:519:f94d:a3bf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:a0f:b0:517:7701:c085 with SMTP id d75a77b69052e-519e4a766bbmr240186711cf.21.1782154370058;
 Mon, 22 Jun 2026 11:52:50 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:52:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622185248.1717846-1-edumazet@google.com>
Subject: [PATCH net 0/2] tcp: make TCP-AO lookups more predictable
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301188-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:0x7f454c46@gmail.com,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CF126B1F2A

This series fixes a TCP-AO key lookup precedence bug.

TCP-AO stores MKTs in an unsorted list and returns the first match. This
allows newer, less-specific keys (wildcard VRF or shorter prefixes) to
shadow older, more-specific keys if inserted later.

Fix this by implementing sorted insertion in tcp_ao_link_mkt() based on
key specificity (VRF binding, then prefix length). This keeps the RX
lookup path fast while ensuring correctness.

The second patch adds a selftest to verify this behavior.

Eric Dumazet (2):
  tcp: fix TCP-AO key lookup precedence (shadowing)
  selftests/net: Add TCP-AO key shadowing test

 net/ipv4/tcp_ao.c                             | 27 +++++-
 tools/testing/selftests/net/tcp_ao/Makefile   |  1 +
 .../testing/selftests/net/tcp_ao/shadowing.c  | 93 +++++++++++++++++++
 3 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/tcp_ao/shadowing.c

-- 
2.55.0.rc0.799.gd6f94ed593-goog


