Return-Path: <netdev+bounces-265682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLkOBfoNr2lVNAIAu9opvQ
	(envelope-from <netdev+bounces-265682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:14:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E38D23E667
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3AEA302F98F
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 18:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAAF27467F;
	Mon,  9 Mar 2026 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYkwAkM5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E5169AD2
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079702; cv=none; b=D1ZzCutcGgkvqIFyzidg63KdZ6DaQgIoC88KYHIqVOm9QlxSBI5+I+dA1shBjiiD+bhf3eYNzEKX1rjLi3IjAYrJwxh38LVYmInw/IdpTTdC4n5+7fpwCky0fL9QsYQvR2wwLtoQPLJl6Twg6lHhMJc65MMVUPkn2lYQokR1XoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079702; c=relaxed/simple;
	bh=pHXO8GZNKzWHHjS11uVUoeVDBKj6DMaEjf7vf7shg1k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DbKCFWus/gi8KMCvec/av5YomCY8wT5keqaG5ih+b3uu3UDmU4J8fjA/zrMgb7YGDNnCaK4ljbn9ipfaDBsFIk/LariaKIvbx2U1/Hvcl8eaTMxymdSiXgcGbDEbgARqSZm9luJnZGue4lpvlCH31vX1jf9W9eVBvjZOAHX7/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYkwAkM5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630753cc38so54000986a12.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 11:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773079701; x=1773684501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SSvyxLEWYpsT1FmHWkL0pWV32hlYY8paSDx6+V25IME=;
        b=aYkwAkM5+Nx5iMhDrmprZTN76uaMogt3prRW6w4YHgpxhxafIlpVm69utC8DUf3RY6
         bxC2gSA7uYPOq9gjin1d6UaO98leAW5nUTKNXzCGTT8CNMEdGNdAbzlp6pFuAg4pJRjZ
         M4V1wQ0q6NLNR3zpwNjPygyV/7njf0JQ7X+zSv2qj6UBJVV7HugTpKjq/p9SYCgSgcMZ
         cgbCQtQIG4a12M5NjjS27N7hZFHaAtBGhdpfObbUSXHTA9JHAlokxEQH1UYfSIxWfXzu
         3GbOaxetg+2NfQcqfdPaSmTefH4riBp8cj/krPkBRmAbbB5eQ3NyFu/YNaZKb7ojYyfx
         Ctpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079701; x=1773684501;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSvyxLEWYpsT1FmHWkL0pWV32hlYY8paSDx6+V25IME=;
        b=MjVT2uMzMECnUGCSPhFMKfXz6Nk4VzEU4wtSRn834mLSR9PsXEytLOSqAI6Ps3hPf+
         aUGkLbEMV5ss5VHZKeOcuZz7eN+uwN795RL1mvJPnFl7tjzJpEGpF1/xXKEm4iJLsY5/
         0BBKU7JoljUO/lgkq1jOnfxRYSqesy9F4GzQSLTMqSsGC8GNQsxo8arfCp3YlCtCWnT3
         mELUIGgT8CPijEmLTk7ERgPEWQ3QvO+wQIDLOS33f/0FkqCLxYKiBTA5tgg665mXGlRj
         +CVlzQ43vxVRHK0tSZsx1AbHs2gbwBsTqfOSqJ2CwfVv+wYBQkuY2Hk3ECiBGUUgvjLC
         8sGw==
X-Forwarded-Encrypted: i=1; AJvYcCVbLXvrvDGQqIhv4aVfs1cvPRcEJUV4QjQ7/SEMUnO93A4Xala6BbN4ooi54/i2yHs2xbI0GbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzboSYrmQ0tFzf9/dTKh5r0zKFzXEPiXSowZJBT2yL12F+1LkBl
	vUS9t097Nf/eYoM4aD3d/kojxPCKivn+87yH+i+eMAm2wUnjQ7CilTkoehyFlhLdY9186ROLYsO
	RBgeTYA==
X-Received: from pfbjr8.prod.google.com ([2002:a05:6a00:9148:b0:7f4:e7a0:9b05])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b53:b0:829:8bb4:1030
 with SMTP id d2e1a72fcca58-829a2eaa5c1mr11138096b3a.42.1773079700462; Mon, 09
 Mar 2026 11:08:20 -0700 (PDT)
Date: Mon,  9 Mar 2026 18:06:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309180804.3471287-1-kuniyu@google.com>
Subject: [PATCH v3 net 0/2] ipv6: Fix two GC issues with permanent routes.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6E38D23E667
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265682-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Patch 1 fixes the unbounded growth of tb6_gc_hlist due to
permanent routes whose exception routes have all expired.

Patch 2 fixes an issue where exception routes tied to
permanent routes are not properly aged.


Changes:
  v3:
    Patch 2: Use IS_ENABLED()

  v2: https://lore.kernel.org/netdev/20260308032304.1841198-1-kuniyu@google.com/
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


