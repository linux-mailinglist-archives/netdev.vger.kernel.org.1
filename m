Return-Path: <netdev+bounces-266482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFtXDm3+sGljpgIAu9opvQ
	(envelope-from <netdev+bounces-266482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:32:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF9825C727
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 000EF322D16C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD601331A63;
	Wed, 11 Mar 2026 05:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XdwyEoZf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987D932FA28
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206998; cv=none; b=JCW/b72pcmgHuJJDqJ8ZzM9EnQZJv3Jmjfgj/dgBS3QGRSDbF2LJudpuQ7/tc76E+zLxDwHOsYoe62nXvElows4iMyA9JA5wryu7+sfq+cIvqknBzx6zRPqHNlOsPDrmbD6SVxv86Is3Ofc74APDxLEaQX6xK8LEUHSUmHA9PFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206998; c=relaxed/simple;
	bh=2Z1aywPlQPnrNnMLwNuMtxJMOxcgarA40uKF6sNAE5M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FgsXDl7OJQ8vGo4SUP5iPHrwOpId2oCupQJAXY4hPyZ0U3ZiHh0HPnuAoMmatKvnhoPE3uSzLMY5L6cP0p+LrVgKxY3OZKHbKozZq/PlEuVN0SOLwdMzXG6fLoRBtKZYlNVXFgwXHzS6Pm3/piqU7BqXweRP04Om88JW/GVewPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XdwyEoZf; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8299499d587so2587704b3a.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206997; x=1773811797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Exk8yv3cjyAHr+tLEDTsJE/Fo63xCIyg3B8w3sdy2QE=;
        b=XdwyEoZfFnz2kFOu12TDWRgyO4Kk7FC6f7BJkTYHcW2LaXvS3JcisjoKI0niseiPWf
         Rli1rpZnVFBl+1V67tWrakIovIUc7sESuCTbwFkD5yqUlaERsL797VenoQusGwgnsuA0
         vgIH1oFkvZLjL8tZIKI7Mr4paKXXstIInMKKWctRLtXB/KpFyS4G6yLvB7gwFuR7Krtt
         h7BAsPZrWZOJwFJ9XXasdvKQlrKdqRWGfTq4xpmFyaK6fmpYIH/oNY4FXVk+D80AJxWb
         R8w4MqDwnC2EmWbU0DeZelTITjRlCHi7OyBk5mu4phoz5/KG+sMa477lf0rxFWDgy6oW
         ThFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206997; x=1773811797;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Exk8yv3cjyAHr+tLEDTsJE/Fo63xCIyg3B8w3sdy2QE=;
        b=Q4VGZLH5jT0Rjt+gviBAZ9lafQFipewOCoslEgad9fgmpL+TBgbUecGmtXPvIItJZ6
         1tEIKVdIGfbYotAshqatGVHeu79ACWYR6KgDpcCa5xtE5yhQxxp7iFd5q8j/IHAoJzUF
         ENsd5RGIQpa+YqW5eLR9G/sj6lToICFioh2eyGGX2sNf4uPUIVH3vipRaxeJfku5oWCE
         Q8rFQ8xzwiIr0BIi1tL3Zexnn/EmL+Z6pOmacUO6rBHiwJimL4bEIMNZhNpkgMkwHVo5
         WY97+gi2M+5MwqheDWB/vnGT3im5sOqOhjfX0Su+2hsHhH8ZBAMfhtWqngNvnO0K/EvY
         Om1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLq8EIl8A6mRmK3XYw1eoAuTuHFj5H5Jz8MGpqy2oKk9U1qscFlsWdxUkFQ8wxbVBKRUzB9T8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy066Px38bvUs8ED+Zczw+MRlfxjoJG7n8dE4AzoUNBAV9I3Ugw
	5NDHJsveJGAXWmBykM3Ty38QqqfbtgdGZAYq4PLyfaaq0bsoLxf7wjUpOE9LC7a+IDxdl64tZXU
	u5XVhww==
X-Received: from pfnv24.prod.google.com ([2002:aa7:8518:0:b0:824:c9a6:b9a5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d1a:b0:81e:6d2d:a121
 with SMTP id d2e1a72fcca58-829f72690fdmr1217881b3a.62.1773206996767; Tue, 10
 Mar 2026 22:29:56 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:29:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052954.1224278-1-kuniyu@google.com>
Subject: [PATCH v4 net 0/2] ipv6: Fix two GC issues with permanent routes.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8BF9825C727
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266482-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Patch 1 fixes the unbounded growth of tb6_gc_hlist due to
permanent routes whose exception routes have all expired.

Patch 2 fixes an issue where exception routes tied to
permanent routes are not properly aged.


Changes:
  v4:
    Patch 2: s/,/;/ for fib6_gc_args initialisation

  v3: https://lore.kernel.org/netdev/20260309180804.3471287-1-kuniyu@google.com/
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


