Return-Path: <netdev+bounces-251837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGALOgKmcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:10:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F454F73
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A22A25ABBF4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19382481A91;
	Wed, 21 Jan 2026 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKJepzdk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422CD48164E
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989568; cv=none; b=MRU253NImNLLAelfYuIAEoM3ebyjHTqZFgjHpPIB3XGZG0rKWVhFA8i4CN+yk03YOir370rMKZPD4DRqMuh/RYvEcAJ/7xd9oAwOve52CNcMgT9p+weSt4jZv/jX+13Sn90mGxdPQLwvEgr9TBEirnoqYTguTjilY+CafkOddN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989568; c=relaxed/simple;
	bh=oIya8rrwe81tu2zeFAwGC3RowGdO1ZLGNeS4EmEbcIA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rIleqwXCI3+S5zPpNuD+ohi3UVevHsYfd274vuthtqanMgCYwBOzkZAeBf4RoIBji+ktnNAzv7wUm45m6VYlNQx5rb+iy/Yvb/4X8Zpebomp+ByzIjN3him4GJOnV+R7KoDpx5TZn6VaZuHb5nh0EVZ/kpsYqIZejQBpO9Tj6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bKJepzdk; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50146430e1dso150754031cf.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768989565; x=1769594365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mnY2Aj/3VqTXnmcggg+Ll4ncea3qf+hPkHJe0XPMTNc=;
        b=bKJepzdkfOIa9UHK/3hiibaASkin+nTvc3pmVStvj/5kohEZ3MIg1DGSAj89rXbZPy
         FJSzcAfofkxgHV/wnfTfJc3dp5icZUZ5EwiRFjjpTBrWp8qaQ8OKpfv4iOMK1lMxR9SS
         kqlYgONZoS0moyYdqIR/sT3nwELzxcaeRKBnbQ1eO/GXhwlCiDqZ/AG96a0WtZODpiQW
         vVWR8xH62uAyOOAw+3MxAQAWL0iYdPH/HhlJiDq9Q3OQkG3n8ZCV7bahtCzmpQQpvmAZ
         yfEL25KoX5FG7JD7OuZkMCZ+uanqO3L4vQMO+Nc4k5h8tDDAJmcWnmOM6sz5FQbkFVkZ
         /0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768989565; x=1769594365;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnY2Aj/3VqTXnmcggg+Ll4ncea3qf+hPkHJe0XPMTNc=;
        b=Cl/bg95ui6zmlE73ixRpuH6FmAMREJH90WOjYQzR5F+MugPK99WkVFZIUu2xPLHC1W
         amDln+yVhIDLMcbDqVpD7dVJ+9Ds14lX1gruLPMh7koAUQZNDqrNonKFWQgBVlR3XK5B
         rSCxzEODZfQp4fkarVgPaUvh1dRp9orJdzVmrPP9K5xUA4MwjqjWjmw8xA+c2J/Ijs7U
         NcGv5bDawKmteRS8kofcHffPNtgwdQ0k1r+n9l3wj2pcGfeuT2nCf8vSS6qo7A+Wnr+w
         +ABfCf6WvRHmBd/RtMMvpARPLKljDdMrlPsqzI9rOpW5Mt+LB++snkOVm68Jeh9rwmb+
         +/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC/gwMhHJjVG2of/1C2qWOtn0oCxql1CAYmzuQba+cDndswOR632p8fRopkCefBhV0x753dpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZg7XAEXGFPVjouIx+A/MHcwidi481y27DjQRCPGGeifFcvHR
	LZOEnftVxMn9yqLuhaZCgU9A0v93ApRkfNwmXHqJ090MLhtCy6LB19+uToswkiXytvOo+7jE0RN
	V4ecf0XfGDMdJWw==
X-Received: from qtxf4.prod.google.com ([2002:ac8:5d04:0:b0:502:984a:7db4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d56:0:b0:501:17a1:4ccf with SMTP id d75a77b69052e-502a1de049cmr260751791cf.3.1768989564881;
 Wed, 21 Jan 2026 01:59:24 -0800 (PST)
Date: Wed, 21 Jan 2026 09:59:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121095923.3134639-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp: remove tcp_rate.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251837-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 730F454F73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move tcp_rate_gen() to tcp_input.c and tcp_rate_check_app_limited()
to tcp.c for better code generation.

tcp_rate.c was interesting from code maintenance perspective
but was adding cpu costs.

Eric Dumazet (2):
  tcp: move tcp_rate_gen to tcp_input.c
  tcp: move tcp_rate_check_app_limited() to tcp.c

 include/net/tcp.h    |   5 +-
 net/ipv4/Makefile    |   2 +-
 net/ipv4/tcp.c       |  18 ++++++
 net/ipv4/tcp_input.c | 110 ++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_rate.c  | 130 -------------------------------------------
 5 files changed, 130 insertions(+), 135 deletions(-)
 delete mode 100644 net/ipv4/tcp_rate.c


base-commit: d8f87aa5fa0a4276491fa8ef436cd22605a3f9ba
-- 
2.52.0.457.g6b5491de43-goog


