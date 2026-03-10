Return-Path: <netdev+bounces-266250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L8eJERQsGmBiAIAu9opvQ
	(envelope-from <netdev+bounces-266250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:09:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F155E255460
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54801302F733
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7D83B9D84;
	Tue, 10 Mar 2026 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE80cUBM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6024640DFD5
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162465; cv=none; b=ebeQPmdGWjFzO4wfDmjGfPk0nqA2ZTl83cHEP9+LxmvoTpLRFaOwmS7q90spBUx++5utlr0OlnwVs4mnBhZu1t7iyw6v62lMGX16M3QFu8Wuo2YnERN1dwo4nr7Y4IvQPrwmzEPj/DRXc73glwdA65figGZFSrxgU3rvWI+UmBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162465; c=relaxed/simple;
	bh=WbbQzFfNash0ak6vvZ8JHHiDHuWiqvb6G0aj2KzAHH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onV5JOmhXZoCjHGeVqAcWwk51qHLdMR9HQ47fgUiatSLBxFxwQJThtjoBLLqicvBYakja3Rvm9QiKBpL37seyUg4sv03rbZWx6HnB4heyfDV2XvBfKsx+akoEq4Xn+GlrWeormgz47VAGdc38Xn9u74raZfuJD1o1b68ogChgp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE80cUBM; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64c9c8f8783so125627d50.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773162463; x=1773767263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsE/wJoZGbLF5L8GTMnDOMdqAYhi1A4RQQKPiPPW3gA=;
        b=LE80cUBMMhejDveZZ4so4bJ28DUCDiH1wCRsy+EN3UR6TGbho6Wsjzhn6CpC70Agrk
         +QQg90Z9QXw73IHJeVNENUMz4vezd04VKGqLFIFT3y3hp/ZEj+B5bP/0UHKpn6CyocW9
         5mTNe6xbIcSCvkOcu6dKsUvpPWiYBKmOfzFffJJiCQ1lK7TlS2bp5/GfPoAAmccoBrLc
         br8EP1Mh9m+6Q/EDp63nbD9KXSViiFFlzH2TTrf/NZqtHzTVtmO1YJ8yg1WQw/o8DbmV
         YnL1KENepScbUkWFGYW7Q09fDJ+aJbqUyqPUKiLBHlFaN6qIxBJ3msntHqFZKmj2QNAm
         FiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162463; x=1773767263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsE/wJoZGbLF5L8GTMnDOMdqAYhi1A4RQQKPiPPW3gA=;
        b=m22SOahi8etKlov/2P9DlhPyotFfH521Q4NV0FGqgjlexYKq4xgrg6XheeNB+l2IU3
         p/WsgK/970Dfs9iVZQcj4Sg8KwzMw8JNRXoELD5377Wp16cEJImE75E+Q2L5064WVhC1
         VcLijmM/wbJvxVaLTt7Udgzzg1lTB5lWiqcF/LToju0H+8bK98LKl2LZlrT8rPOI73kR
         whbru9iDJtsa9WDOAylySSHleFK0wb6ECGQ5Z6qGZQN0c5I9UhIYFP3SG8ufPWoE34Jh
         /NaerLnika/cb6GyvUj3Lbjd89se8YYUku+Mv0Lfou80ZtMDUIw4+3Ygar6LP+7AAiRA
         gdpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8SKzTGUW3z3QKha8k6kzg9jR17LWm45yRwmP/ohSwZI7JY03rnLz9Kz87jn0iShTpYGYo1Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qM9fXcFEIsyb2VLAZIDQOvSfhqCJXdLwNIQbLiCGcrL+canq
	4hcv7JuYbvkzAg3vDyJUWCU1Si5xsczJdTlrF9Bfr1YkBgCADkE/RnPJ
X-Gm-Gg: ATEYQzzcGiXXvGSE0gjhLKI2Nls8Z0z+zEiD5Zb1WfXZMS23YfDyADcm5wkicFpr3sQ
	HNPpN4nKQP9oHMvgI0vEDq62KzE+Uq2dz75yycq4Eju5LLLUkecTCuaBMp8XObuaDV7wmFLuuxv
	zRP4zMjMPkaFyjpm43nJ3Rv3qin0EWGXDBIF2NsUBRApIdRM6URK8mE0+YD/dth4N8yBm0CJftM
	yys0ij5MM3cehdopmDuY8Zit8KSwgtH0Tik+TMDQa2+LhEWzLdPh/gFdE/bffxSv18t0Hm20zoC
	Z8o1tg9RAqcVUQvNU+6HFuHCCStiMedcWFVC/7zyByYqzznyvGJvu2dGR5KRAo0YS1xzKEexmlZ
	vrqeAx3Ha1ecVV987UQwU2qT2HlVETzZQiwwCaVZhY2NvZbV7oYV1VygGtsgbgbgWVYJVX/1lEn
	AJct9knq/vpX47U9BIHIAliWaIJCkHde6iwnrAlNf3hdzjiUwr9gmRXF/DSQm6EwqOc4o=
X-Received: by 2002:a53:ee42:0:b0:64a:ce57:cac4 with SMTP id 956f58d0204a3-64d5a13e158mr2992719d50.24.1773162463385;
        Tue, 10 Mar 2026 10:07:43 -0700 (PDT)
Received: from desktop-linux.python-stargazer.ts.net ([50.168.180.218])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d175d32cdsm6930041d50.2.2026.03.10.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:07:42 -0700 (PDT)
From: Mehul Rao <mehulrao@gmail.com>
To: jmaloy@redhat.com,
	davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ying.xue@windriver.com,
	tung.q.nguyen@dektech.com.au,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	stable@vger.kernel.org,
	Mehul Rao <mehulrao@gmail.com>
Subject: [PATCH net v3] tipc: fix divide-by-zero in tipc_sk_filter_connect()
Date: Tue, 10 Mar 2026 13:07:30 -0400
Message-ID: <20260310170730.28841-1-mehulrao@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F155E255460
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,windriver.com,dektech.com.au,vger.kernel.org,lists.sourceforge.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-266250-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mehulrao@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

A user can set conn_timeout to any value via
setsockopt(TIPC_CONN_TIMEOUT), including values less than 4.  When a
SYN is rejected with TIPC_ERR_OVERLOAD and the retry path in
tipc_sk_filter_connect() executes:

    delay %= (tsk->conn_timeout / 4);

If conn_timeout is in the range [0, 3], the integer division yields 0,
and the modulo operation triggers a divide-by-zero exception, causing a
kernel oops/panic.

Fix this by clamping conn_timeout to a minimum of 4 at the point of use
in tipc_sk_filter_connect().

Oops: divide error: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 119 Comm: poc-F144 Not tainted 7.0.0-rc2+
RIP: 0010:tipc_sk_filter_rcv (net/tipc/socket.c:2236 net/tipc/socket.c:2362)
Call Trace:
 tipc_sk_backlog_rcv (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:32 include/net/sock.h:2357 net/tipc/socket.c:2406)
 __release_sock (include/net/sock.h:1185 net/core/sock.c:3213)
 release_sock (net/core/sock.c:3797)
 tipc_connect (net/tipc/socket.c:2570)
 __sys_connect (include/linux/file.h:62 include/linux/file.h:83 net/socket.c:2098)

Fixes: 6787927475e5 ("tipc: buffer overflow handling in listener socket")
Cc: stable@vger.kernel.org
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
---
Changes in v3:
- Decode stack trace symbols (Eric Dumazet)
- Link to v2: https://lore.kernel.org/netdev/20260306185005.22120-1-mehulrao@gmail.com/

Changes in v2:
- Clamp conn_timeout at the point of use in tipc_sk_filter_connect()
  instead of rejecting small values in tipc_setsockopt()
- Link to v1: https://lore.kernel.org/netdev/20260305215336.645186-1-mehulrao@gmail.com/
---
 net/tipc/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 4c618c2b871d..9329919fb07f 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2233,6 +2233,8 @@ static bool tipc_sk_filter_connect(struct tipc_sock *tsk, struct sk_buff *skb,
 		if (skb_queue_empty(&sk->sk_write_queue))
 			break;
 		get_random_bytes(&delay, 2);
+		if (tsk->conn_timeout < 4)
+			tsk->conn_timeout = 4;
 		delay %= (tsk->conn_timeout / 4);
 		delay = msecs_to_jiffies(delay + 100);
 		sk_reset_timer(sk, &sk->sk_timer, jiffies + delay);
-- 
2.53.0


