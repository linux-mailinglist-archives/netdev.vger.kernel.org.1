Return-Path: <netdev+bounces-265222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJo1M6DrrGkYwAEAu9opvQ
	(envelope-from <netdev+bounces-265222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 04:23:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE0E22E6CE
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 04:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 385E0301F9C1
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 03:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874ED280CFB;
	Sun,  8 Mar 2026 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VeqE7Zku"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0924B28
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 03:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772940189; cv=none; b=N8zsunpqQjiylfCP1KJwsv6j7W7+84qfioElnrzz5TPC6AWBiuhf/paMIvY9TT9SSPWZkzj3auhHjibYdNlT321iH7h+eGRiAApWz+pcaIQ2TkI9wSXk6q6pwYagHcd0RTRSEw0IKZb2Bu3dcjV/mg9KCc9MLBC6IR9ToHsMMTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772940189; c=relaxed/simple;
	bh=EpS5hHyuSIjf/ZS9SJNOb8l8Geq8JkSLIkKOjVNvWos=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GBWdzkKTxdZIZZbToAnSU+KzWSEtHmM6NO044uAMYA4Ido8ukHKybxRGi0a1zYK7ItTM53LbkNCVNMqRUrwchQ5bPAr90fpVzUa/LUdGFAUd0aqQI4HJaM2pIAYr8WMOhXZTF7/mBUKTcDg8kmQhWqQnjG5oZL71RsHAAuNtT4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VeqE7Zku; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3597f559e70so5165043a91.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 19:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772940187; x=1773544987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uk1l7u/EZQ9dYk7Ghgiuvc1wfJT8+uxRd82/b2IDS4c=;
        b=VeqE7Zku4RJ9tVGXyZauOIIOsxu0x/ZmokFvt4DkJ/39UVdcEav6GHJ7pcyP4wyZ0N
         ECzanWgpk1RQiDJgb3GEw+rXkJPomKtQf16vAq6MOii066yPqzYjp1mne/QkGWabHF0y
         h40yji6ZKqun1/q3Vt7CtrfbHrN+61w8UuP2U/qby+rYGnM24maef9qlxFEcqJGLzfkS
         XQrx0a13WTwoNKehpQBFNNodij4liBYOXHGuuzLb9Q7vdyEsVYAe1JEgHtvjJ6NqrGgt
         6k4Q9dTFaU4diifcdoO/q9kotyHGHBaWPpoRxQpcZo2QOleVigmbNblj3+r1GhudsoiL
         A/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772940187; x=1773544987;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uk1l7u/EZQ9dYk7Ghgiuvc1wfJT8+uxRd82/b2IDS4c=;
        b=txNqZNIGdsVwXt14PSeEntwovEphaLrFF1nHmTisKrAMuPwBnGjDiP5ArWTsXc7MZx
         6m6uF2brRMYaSAjNkQOrmk4duUSpaINda76lJs1s+IPgJrECFy7QoU+LOi0M/Vr9hvVg
         j4XvcUE6068VRCQbK6qj4Lr6rovoQAGSKfaqNTc4Wjy/ej0W3bfj+SeJ+Vi1VEGPrpY2
         vxYxRS+JoEeBpqxRMlkcpzVm4THl5ycTTBOYc2yFNaatx8rgEfOXzdIIkl+h+OZvdSbz
         Q3Qip24AHD23f8xdi3cBggjTTHNyw+xpDCKMEB6f3rqseZlUhdX4F/nud7pu/ELMYS/c
         luVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqNBUxasVTtdBLYjIRIHcnMRv94u5/AlkdJUJUcozmdRAL4ltkgI1Nt/AfL9/zoDywJHqx7rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3RAGrtGNVHvBhjT/VVwqR7n1egAQyuRlCQHZ8ztzN4T42uqP
	pBp8BijLjFyYqk1x43ReyfQS0HVWKsouNPBbQYRNHQf7L/XuGM5a3wY7wRq7+eOZbegYyaZkwcy
	8HVLSyQ==
X-Received: from pga7.prod.google.com ([2002:a05:6a02:4f87:b0:c6d:e340:fa67])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7283:b0:398:78c0:6dca
 with SMTP id adf61e73a8af0-39878c0730amr2388124637.15.1772940187339; Sat, 07
 Mar 2026 19:23:07 -0800 (PST)
Date: Sun,  8 Mar 2026 03:22:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260308032304.1841198-1-kuniyu@google.com>
Subject: [PATCH v2 net 0/2] ipv6: Fix two GC issues with permanent routes
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2DE0E22E6CE
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
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265222-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Patch 1 fixes the unbounded growth of tb6_gc_hlist due to
permanent routes whose exception routes have all expired.

Patch 2 fixes an issue where exception routes tied to
permanent routes are not properly aged.


Changes:
  v2:
    Patch 2: Fix build failure when CONFIG_IPV6=n (no net->ipv6 definition)

  v1: https://lore.kernel.org/netdev/20260307024709.718395-1-kuniyu@google.com/


Kuniyuki Iwashima (2):
  ipv6: Remove permanent routes from tb6_gc_hlist when all exceptions
    expire.
  ipv6: Don't remove permanent routes with exceptions from tb6_gc_hlist.

 include/net/ip6_fib.h | 19 ++++++++++++++++++-
 net/ipv6/addrconf.c   |  4 ++--
 net/ipv6/ip6_fib.c    | 15 +++++++++++++--
 net/ipv6/route.c      |  2 +-
 4 files changed, 34 insertions(+), 6 deletions(-)

-- 
2.53.0.473.g4a7958ca14-goog


