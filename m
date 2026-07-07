Return-Path: <netdev+bounces-305505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UabwKIAWTWp0uwEAu9opvQ
	(envelope-from <netdev+bounces-305505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:08:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F6071D065
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:08:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=MDhPEj9f;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305505-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305505-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48A8530A09FC
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DBF348C70;
	Tue,  7 Jul 2026 14:53:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB064350A10
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 14:53:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436015; cv=none; b=JOTsyz2zeNP1Z3Sq2W4XNFnRg0q3bRMskXQHIEZr1ZfnF1OvdH3PlfFK+zkm+4eIw0gPRXqLxYzw9luFZwzXVFQXscnT+v3EvYLvQRuQC3gM6ZgHBiOShRXq2Wv/ZsK2DrPX6u60CKZiNCD4zo/Le6EOpLYZP4f1gwxuqKj5GV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436015; c=relaxed/simple;
	bh=h+ryLfDaDt5ItUxSxTJR9NANmDGckpwrZZlaxqmUmWI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IUQHO5N8IytZTnCjz/RL8r/D7jZynpF215EzJ1qEDUSI4suSQYhB9/tzE7uBpOF74o0y5nFQYLidfvzXsGTGkjMwJNOnQggm5cwQSt71e7o9tlZUp4n5CiDKnHCMwkbdWVqnBcMC6rbzLad6iTYuXzfp/2YuoUFa2QnmtOJbQx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDhPEj9f; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8f1d3eeab92so56496726d6.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783436012; x=1784040812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dUheqUENlIK53LS2jT54JqHTs8OxEa884FQLcdwCn6k=;
        b=MDhPEj9f8E9TPyAcuscyM+yvmxTuXkl4bTlY4QvudMqD2/zBpcmx3zKmf2zpcLHG0h
         E2QA9JTdQe2jybvSlc6J19gVXs5ExCEedeapZCNUZ8gceqTdRTrivB2/U56X+BELQ1UE
         1pYxdKkrtuHjxYXbmCAxLEQ2xEWgujEgtrdXQw99YUVE3fAsaFQ+oGLeCqmO0q6gLpCO
         v6k9iWIvvc6ffudFTy/d7we7T2hyM4L4OmVeQ6bRQ95MC8FXFfOvnULXI2M7BHZL6mi+
         lgihO0gR1iJxhtRVe/bY6EX5RchCY8rLwxBBbiHBn0Tm/Vyt03C20jsjzOVXzOsxPYgu
         LK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436012; x=1784040812;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUheqUENlIK53LS2jT54JqHTs8OxEa884FQLcdwCn6k=;
        b=kBxYnGQQoHeEekj4/Az10JfyyiTXJPst66Ns1XgD9uFl4F5yX/jN/DZ954lN1uIfXt
         Vja4upBE6NqFHWc5Z5A3F2YhXGYGVD27w1/79pdqbw3PoSJD2148LKO83RtB89miRR3B
         KbwHk857zRK2EOUe0CZ45tByHGU9tOSzRlrWCaG+D0l0s+INgWaXG4+AoZMez+fj7UVR
         n+3K8DK0r9gVg3TFPJ3bG+Le1iX/wllFGJE4trd1+z02tFfXOae6oXYRfchavAzDjMJZ
         YpdGii04MUOTatrFfB7iOxjuFiyD8sZIV7bxag8AsT4AqZV2VY3PaL09oieaoK1vNe3r
         RF4Q==
X-Forwarded-Encrypted: i=1; AHgh+RoxTUlboMga2k6K3gc+REdx4ve0pE/cYNaAdCIz+uxu6OpfWEepdAlCfC25zrIXOt9WLdHwDuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpf9ep4wxO4vv1zbat8ECb/A4Javpy/rm5FYngruIaX6p3A0IA
	pCCSDejdCb9d3iDeYeXUab9J3E95XWkWSyXp7Y6d0zYuaTIIyYxeXbDFO9rSv/tqKjmnN4EQFw3
	gmhpWdojrnFpH5g==
X-Received: from qvvv8.prod.google.com ([2002:a05:6214:8088:b0:8dc:3559:783e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2e49:b0:8dd:4979:4b19 with SMTP id 6a1803df08f44-8fcb289c3f5mr72517216d6.13.1783436012152;
 Tue, 07 Jul 2026 07:53:32 -0700 (PDT)
Date: Tue,  7 Jul 2026 14:53:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707145331.3717941-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/3] geneve: make geneve_fill_info() RTNL-less
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305505-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lunn.ch,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12F6071D065

This series makes geneve_fill_info() independent of the RTNL lock by
converting the device configuration to an RCU-protected pointer.

Historically, geneve_changelink() updated the device configuration by
copying the new configuration over the old one using memcpy() under RTNL.

To prevent the transmit/receive data paths from reading torn values during
the copy, geneve_quiesce() was used to pause the data path and wait for
a synchronize_net(), causing packet loss and latency.

By converting the configuration to an RCU-protected pointer, we can
perform atomic updates via RCU swap. This allows data path readers to
safely access the configuration locklessly under RCU read lock, and
removes the need to stop the data path during changelink.

With the RCU infrastructure in place, geneve_fill_info() is then updated
to read the configuration under RCU read lock, removing its dependency
on RTNL.

v2: addressed Kuniyuki, Paolo and sashiko feedback
v1: https://lore.kernel.org/netdev/20260701120454.3533252-1-edumazet@google.com/T/#m887804321856d9b5c7142107e81b52553e60e6ab

Eric Dumazet (3):
  geneve: pass geneve_config pointer to helper functions
  geneve: convert config to RCU-protected pointer
  geneve: make geneve_fill_info() RTNL independent

 drivers/net/geneve.c | 370 ++++++++++++++++++++++++-------------------
 1 file changed, 209 insertions(+), 161 deletions(-)

-- 
2.55.0.795.g602f6c329a-goog


