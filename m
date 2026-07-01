Return-Path: <netdev+bounces-303541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gy0OAkbORGqw1AoAu9opvQ
	(envelope-from <netdev+bounces-303541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:22:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D79696EB0AC
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:22:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=LHYi6pn1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303541-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303541-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11381300845A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE283BCD16;
	Wed,  1 Jul 2026 08:22:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9252571A0
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 08:22:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894141; cv=none; b=Yv9AKNUR+Xs2ptBtZjSFt5NV+i91qtWNePiHRvksnQawaVejak26IPVwfH512MaHVNkXjcE9dE4jCoP+Rz5KA/gQd61QnHBDE/zz/0HpcaxONt4hEVlxGxo0kA1pXFC0hZ9pB1GHlXnxuXqGV9Jz67O2GoiQSCPQn3w5AWvQLYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894141; c=relaxed/simple;
	bh=qQSyS8fSu3ZupCaXdhxpPxafeo35MlYgUzHpCaPCgyU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JJ5p2v5nqpNJl8OVaPijQklgg9dEeByK1oWRsGh+uzaIDHgpBaPU4SlwvA5j75vwxNH6aojpyUkvxvLnfC98mn8LTj1IM++G8qJ0pBvHa9yY+HsXzPd522gJF2miVpX5/hqBJa2cXGEVLcg6H1aE0Alldg8Pku7LSvupf8at8RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHYi6pn1; arc=none smtp.client-ip=209.85.222.201
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-91931144870so48275985a.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 01:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782894137; x=1783498937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hKjuQcEuPReDEeT8Vj3MEK8WYjR2H2PEYJfyJeyD3CM=;
        b=LHYi6pn1DPjfbFi16Dn8XC2FmOH1Km8CfMGqv7ig8a7uUS16NCeBfjF3nOgcf59mQU
         BgFbuaC0lkjsq4VNOkH7T70gZiwwZOX5VQ/QIAZvFleaelto6i5G5Fp5bgudAH5Qd/s0
         Jcma/Vqj2SFCxLe1OczwDgORF7ep/SBWKa5fbd7MDLilg0cI6pUrSdTKJfpBnFMkuUwr
         urRMURxIiKEjF7MjKL4Bgx8Wa1ja9Ye6zxK57uLQrTI4lpIwKR6F7YTT7TpgKjw02cuh
         s+Djf1F6dQAwGgPQc5tUA2pp9HeDlf4A45kSYbdC4+jGdhzeZukMwzia1JfOhciDUqdw
         W0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782894137; x=1783498937;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKjuQcEuPReDEeT8Vj3MEK8WYjR2H2PEYJfyJeyD3CM=;
        b=jyiuUeS32/OxHCwHxHDKMp3l5OA6LNH4eD+pMq1AKParXhUeyBty4g/OmF0/XXfsxt
         TmPs6nXo8l4u+ajDaKTgjHyhSmHcGSi9yTpBl0DrMWaGOO3JdY5D/+7aRo2YTWm4YeJD
         qbpgzKlqcRbeILt2vp8/1a01KQlrz1jU7XxxH9bDSNc9wHIbqpi1IcshfOPACkxOofxJ
         c79lBugSUXwzG7wDtTxsPO6oeWG1y3shxH2KOaMmilXxe9UaLSO+z0JksBftXdYvfyoO
         3O8YBoZr5eBOffjqRdzM9woIrXMgShnfqsaCAJ4aGwjZHrU7y2ouF849rLa1avW00AD8
         un5A==
X-Forwarded-Encrypted: i=1; AFNElJ/bkWJEoaXKb8ysyste++sywSCRYgijwQsaJoEiBhLj5e1uYbTqNJKoTloZUDMof4qB25bwRSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuOSjftm3Ecso59RNDw/CAKlTtAnBgh3DB03Ii+0TAOkbwwMJ
	+UYI+JVi5M5MZSI+yXjA86q2c2fwsw+o7pYBRgv2vtpN+rzhIcryc74d+7MbyGPcPJX0MQFCn38
	DpIFMEUatBUlipw==
X-Received: from qknqh15.prod.google.com ([2002:a05:620a:668f:b0:92e:5fed:adf7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4612:b0:92e:5c0b:a6a0 with SMTP id af79cd13be357-92e782574d5mr84953485a.26.1782894136415;
 Wed, 01 Jul 2026 01:22:16 -0700 (PDT)
Date: Wed,  1 Jul 2026 08:22:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701082214.2974946-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] macvlan: RTNL-less macvlan_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303541-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D79696EB0AC

This series removes the RTNL lock dependency from macvlan_fill_info(),
allowing it to run under RCU read lock.

The first patch annotates data races on 'mode' and 'flags' fields which
are accessed locklessly in the RX/TX paths.

The second patch transitions macvlan_fill_info() to RCU, adding necessary
annotations for other fields and handling concurrent updates to the MAC
address list by computing the count dynamically.

Eric Dumazet (2):
  macvlan: annotate data-races around vlan->mode and vlan->flags
  macvlan: no longer rely on RTNL in macvlan_fill_info()

 drivers/net/macvlan.c | 109 ++++++++++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 40 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog


