Return-Path: <netdev+bounces-301418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ZFlJcLCOmp1GAgAu9opvQ
	(envelope-from <netdev+bounces-301418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:30:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B356B9102
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:30:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=K+SuTrAq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301418-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301418-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F00CC300954F
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB01C37189B;
	Tue, 23 Jun 2026 17:30:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF222B8DF
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:30:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235838; cv=none; b=pemBM9NtGVJYFyVyZD6dxOYnJPbkYgNq8LoF8ZnPbvGkumQFoEkNrREX225xaDPu9fchPbzXAw1tf058GTV3TnFuqJdwbK8vzjC3pp1kTjlxERAjSVXFJIykvEb2Dl1nWyTYTlfOCnbauTfug1aPeU9RdG63E9gV9wejo3ev32A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235838; c=relaxed/simple;
	bh=ioYi7GcamJsn90KVpyn6iZZp/MavdRPxcFcKwqGKZVs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JGP9ot75zHFq26rq1bgdjGuWFCE0u/m9a6tYMU5kjNdUzgdEYU7HxU+c90sCWNDqzWdldQt3YCzTEf9yXVD9ApTNVcVe9QB9WRXkN3M+bpjd/O1y0L065ZUKmnTBpHiuFEB00YX8uvmUoZLfc/ov6JteEN3rXhwE4fHwopYDSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+SuTrAq; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-517878a92c5so301331cf.3
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782235836; x=1782840636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rcmW8M8dG6XYKq8c3St6rtT6Rm6Lmw1Yby76Z5jO128=;
        b=K+SuTrAqdHxEoErvk/d/dIOyZhkbfFYovjVkbUYA0i+DzMsbIO8dj2RcVWlMdLJs2Z
         /T1Hqm7fUT482DN4uAI66Rm0GlpWrOJ+UwxMCV01CQLkCn3PCLdh106afCC4M5isXgut
         JC2vEZF7BnyY1+qdsqE1y1LtMw+X/JdOPWWHij/pgx9deTX9yiKxN09kfMQ0+Ut1Apwj
         rKHALEUvE+hVGH2r9+8y9kC2Kr6KO6Zgt6gvb25SOjrhw1xQShv3khXy81ikAJTuD+iA
         8a+BDcOGSZqGXvTI6YJKlXKGZia3LDd20koEfR+BY+m0iK5DwaGOu7quRfmnpyyNPEJR
         IjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235836; x=1782840636;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcmW8M8dG6XYKq8c3St6rtT6Rm6Lmw1Yby76Z5jO128=;
        b=HYQPgFE9LhG4zETeH5toAedsG0yy3FzarmMTE2y+vA/Zy07bNy6VVIkF5yl0iAEx60
         wAfagNeBAhsZPYdqk34s66qoG6I/MfRVOzKFSuvImp06l4uhkig0+NsHaQiz6dXj2zdh
         Dueku2g/QCW67qduaiZH4Ommrk/hfSK2U87hCZh+rndrCjnSl3P1iUVfEeeaPDZ9cBFi
         DKp55SLN/nUMVeSSb2K7bUw6VCj52oEAUTQFdsTrJpVwcOz2VUMH6M2ZYLXmpzez5/5p
         M1oXqAoo5eiAKJ3fOUWjhPxRyk15T7VikhGWVvmGe0r8vt+K/uZRJBLiPVPyarPyjKNt
         cqvA==
X-Forwarded-Encrypted: i=1; AFNElJ8Xiu823sk0/W7stIRq+nhCO+dP+W2LEzIfFJi6wy+dMjxCsjKI5gLfWcdQSbykhmb18+POsxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkURsZLpNdrzPJdmC3TTIIaR2SYBCfN5G5OB1ljaJCaEcRRBok
	5m9poitp/fjZcmrOhYnkI6PWhCPh+rcQ9TBnHuLuCpDfk7URcvWlXezBoA62C6DToL05R/GQkm3
	C/ZIBzOBpzUZ/3w==
X-Received: from qtwy8.prod.google.com ([2002:a05:622a:48:b0:517:697f:f2b2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1484:b0:517:75d8:b956 with SMTP id d75a77b69052e-519e4c6689cmr306690041cf.40.1782235832046;
 Tue, 23 Jun 2026 10:30:32 -0700 (PDT)
Date: Tue, 23 Jun 2026 17:30:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260623173030.2925059-1-edumazet@google.com>
Subject: [PATCH v2 net 0/2] tipc: syzbot related fixes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, tipc-discussion@lists.sourceforge.net, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301418-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:lucien.xin@gmail.com,m:jmaloy@redhat.com,m:tipc-discussion@lists.sourceforge.net,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:lucienxin@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,redhat.com,lists.sourceforge.net,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4B356B9102

First patch fixes a recent syzbot report.

Second patch is inspired by numerous syzbot soft lockup
reports with RTNL pressure.

Eric Dumazet (2):
  tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
  tipc: avoid busy looping in tipc_exit_net()

 net/tipc/core.c      |  4 ++--
 net/tipc/udp_media.c | 19 ++++++++++++++-----
 2 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog


