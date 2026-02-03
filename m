Return-Path: <netdev+bounces-256319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCMyL0UKgmmCOQMAu9opvQ
	(envelope-from <netdev+bounces-256319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:46:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8BDDAC60
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6944530BA327
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED35C3AA1A4;
	Tue,  3 Feb 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qMNTzhG9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7B3A1CFE
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129656; cv=none; b=QmrglUL3X77FXfPF4IgQc3y+1a+HyyHXLkd0bs9JoJ5tNZToVPyUtRRBYgz7MBpikKXOiAnhvUEhSY4Lymrn2HkMhdcGPWimBUC12K5eXQizGAl/mCDRbs33KHK4MshcaKxUzoVE8CjaS0taFqsbIpwMEqweq2QjDiu+NurHaHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129656; c=relaxed/simple;
	bh=AlceBayYmXifnK5JOexd0Wr5qjz96Uh4LbV08MOhbc4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gkEHUFu211E72Cwz3fnur6/i3y5my4D+SRpoM6M8XMIPzplHHL7jRsMn77nf0vkHudtiy5ulV7gGIDwuJRI32NaOj5SHHOA3r1zgpUk4F74pT4e9xvG6isDSTF957XZGrwHVeuUUCnKZoswjDvY/ZSKXWwKSA9EexQfj6BcI9Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qMNTzhG9; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c71304beb4so1302657985a.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 06:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770129654; x=1770734454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rtnkJWqd4tTO0dqCrMoGSUPfiAYTv2lKfIeHBJC6O00=;
        b=qMNTzhG9dJN+ZFNKGRKzyt6urt40ai93rDeIchz/lFieRhHn+PMbRtEl5RefUB0kUN
         s9n2UGa3QyeJ4tQ7yh9UDjANHIUTRqA35aE0lcUqgT7rMcvesdOKLpMU/ECzcA/aud31
         9sHphnulZA+nPnVk4tXRVJ+NAjP6tGU6gXr7xT4gSCDqqbBXxs60q2JXf7rPOCFV8Ojq
         1LjiusM5VD508Nrhm1e49owd+JNFmJakCf2j4ohNyAh6lbQ0l1UeRlFqou/HiIPFpLSp
         87wsOWvGogohJ8Lj37win8I2PEi8pMtCO9OL1zb79lZxdYxGEsc8eNHgMCR1UqVpawxC
         rRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129654; x=1770734454;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtnkJWqd4tTO0dqCrMoGSUPfiAYTv2lKfIeHBJC6O00=;
        b=IfWoRKH7+C9AecMAoNFe9swqggigmnYqYlFLugRqY8r93klzl/j/XMAAjkR1uaR/f+
         2hH6BEmG6+j48jItQu4K5OGl2fH4rmUkGUWycFjAUH5J2A7WdfaZ2dztDQLwp4OA+rOW
         H1GC2ByxgZ1m4DMeYWwmmomZLd4DeLyJ3n94RJMyxYR/raG2NgdAk5Hiu80o5jBPvJGX
         R/ouzcYdwZwBd4XFpwhmX2Y0JgV/LM/vbYqJE9qHmhvrShli6Xc8IMmTPBI1E05Tzi5e
         C+IxHU1jtUelHcMbQalBVuEtSFC2/xXTaaExzn9V77nNP32h6V/BoZsPMFn14xxyb8EE
         Fw8g==
X-Forwarded-Encrypted: i=1; AJvYcCV/M1/thx/fEykCI1bi0wS6DWxNgz30suYMVtksqGyVFf4g4OK1E1VSFPF2hI+pVG/3JQscEqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLAniKBR9IbqIvJCYDaBr5sSB9DyepcRB5q8H5dCGW616IzCGi
	vz7pVu77xV7muxkambbf27fN2b2VNerVWdZ5IFUbdJwtnPdZ12QJ/jY4Gd1spI75bSzbdaIw17i
	hL2XiMt3JFh+Gqw==
X-Received: from qkoa1.prod.google.com ([2002:a05:620a:2e1:b0:8c3:9707:a7ad])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4447:b0:8c9:ea1c:f21b with SMTP id af79cd13be357-8c9eb2ef919mr1988983985a.54.1770129654589;
 Tue, 03 Feb 2026 06:40:54 -0800 (PST)
Date: Tue,  3 Feb 2026 14:40:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203144053.83193-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] tcp: rework tcp_v{4,6}_send_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
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
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256319-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C8BDDAC60
X-Rspamd-Action: no action

tcp_v{4,6}_send_check() are only called from __tcp_transmit_skb()

They currently are in different files (tcp_ipv4.c and tcp_ipv6.c)
thus out of line.

This series move them close to their caller so that compiler
can inline them.

We save ~200 bytes of text with this series.

Eric Dumazet (3):
  tcp: inline __tcp_v4_send_check()
  tcp: move tcp_v6_send_check() to tcp_output.c
  tcp: make tcp_v{4,6}_send_check() static

 include/net/inet_connection_sock.h |  3 +--
 include/net/tcp.h                  | 12 +++++++++---
 net/ipv4/tcp_ipv4.c                | 19 -------------------
 net/ipv4/tcp_output.c              | 28 ++++++++++++++++++++++++----
 net/ipv6/tcp_ipv6.c                |  7 -------
 net/mptcp/subflow.c                |  1 -
 net/tls/tls_device_fallback.c      |  3 ---
 7 files changed, 34 insertions(+), 39 deletions(-)

-- 
2.53.0.rc1.225.gd81095ad13-goog


