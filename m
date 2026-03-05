Return-Path: <netdev+bounces-264570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLIuCIT7qWlcJAEAu9opvQ
	(envelope-from <netdev+bounces-264570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:54:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F48218B1E
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 824EE300D571
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B618A3612D6;
	Thu,  5 Mar 2026 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoLsCsNV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD527EFEE
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747647; cv=none; b=HzFmHefP9QWGOpUK+MBIglarMHbmotiiA1gubI021T3Boo5Eio6XBnkxL5w4pDuJ1hVdqlRwLo0eOBHcEc0Q6ZrLFc/l6YjjilD8xvwKH7wkWAq/qYWb0omxm3qqqVN/r2chZnufAGk3AUoQHxp+fUa8ClJ8m9G0xjalLB5P+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747647; c=relaxed/simple;
	bh=HJCddEP3HpwEtFqNu8fH3f450OqH/961LoMvQQ4Dmvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbywfHDQNoeo59xa5Iq5nOtD3aGkzLVeZe2G0JXnA6uFtX/FzIjRkuiO39HumJiYso40Gru0CHgAn5gn4NF2OLvXE2XbF3jAKHAtICjqVjWvcASMrsUE/xmwQ6EbroE3GP/06Ocpgc8KaGzE38qQigqsueqWyHUWgDNxgiCIqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoLsCsNV; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79853c0f5b9so73948377b3.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 13:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772747644; x=1773352444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LDyT5wYyzGLSfGloP9Q597W13aZWnETTygjbppIux2I=;
        b=RoLsCsNVO9/BSuieErIsbnqgIX1c5jJWKoiENzXkBGHT+LDBRxCehHEYRxcpqDhcpI
         R3FnlEvwZ3chRXv7fW/k2gfTSxRahBlg/lcA5NAzcLpJwBosZx1zPQI1OrHqXL64gcdI
         LMV97nbITiWn1X4HTo/uMI4S/W9fySASXcYMsuS2RLe4s2db2GN8HAiHhuD46e8fTP1V
         IzbHIqRnAuYwjQjf6KB3ee5Ev7mnPk2UUHocHGOAqHiQaWpVQVOMNNr0zrJRUyAudquH
         oV83RarCuDgHOAuwYvI66CURrVZQDAAAcrgBK/DyA3HarkjS9cg9BGsAPWILsDQRl4cL
         7BKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747644; x=1773352444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDyT5wYyzGLSfGloP9Q597W13aZWnETTygjbppIux2I=;
        b=oUychpYU32RXAyER2rlOppIhZVowhoXmtKBhOvrzvn/TXLEWrYmkbySMgI22ETjbvX
         dki1ONrP6jMaG6Fqy8pXJi3lbX91jgTfWShvofbiYL8y9P1HzXPQ3bYGuKowVkKBHApa
         q92dvMXS4YN6veLyHOLPzkzNw9/0FqSDNLgfhoDMDUzhWjWiVn8AoX5M+BSrMiElXcs1
         +XilsgAxhUmRTUifSBvPX/RVZnBk6KVFU0vK/65zvv7nv270Yv3k+bb4cQLFkIB3926q
         M3BKD/SUipMDQvrHSrbbUk2Gi0137uEHbNNDovotPWW97kLialvpVHX+fZOIr/Mi7dVi
         j1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGP92k+v+BG/QxCZT7HS6OJlNZSWYALbBRWRW/w+ReoKoZBsgYR4eld1enQ6rd/Cj1KTDSCeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhPRSSpk1RgNObTzpcU0xYfrYHMr17wwVkbPUN+dLXt68au4N+
	q+Li3ZYy4nUPBnpDj0D753ZmoeHPlocfCEdj1EU63auFCEuWXrukLzZu
X-Gm-Gg: ATEYQzylCWCfZ36MP7ztxgoilOHqI0OUr4chKUjWVES1cQnzfSYr1sv42j/eFP6uJlI
	AuROZ2+2A3Fz5HhA+Bcb6TYAMvZGio2w7VLYNDdvj2x2iLfo5Mqe4weZbqzFK/zG10SzKN+TDsL
	smAcG6JXETJSQuiRtmAY2e2zHmFX+21/GwLlzoEUSKg1Ex7jPUgthDs3wFInOf2T/dtp4T01bWB
	hraG8qKUvo7RBRt9PKRlBpSd5gfCXeC+RpqbmlN7hVp/C08FoY7oHmv6YnPPkGYworVJwcvAnrj
	7PiYJ7ROw28efd99kHNDglOYEkFsHyF9ys75e9Hx7GrBElw0BMuqAaKrilRIUeCholT1rqVY+FU
	u1+Adlt34Xhr9q048boP68F5v3rOKsucLgwio8KzVYNNSbSufDN0/SRVzWgO3HG/71gm1IAxCrS
	fIHTHPW3tMV8CgmYPtENWmGY4EWEX9b4q3MbDABrMkx64bmiVoD9UnHtkd
X-Received: by 2002:a05:690c:660c:b0:798:6561:2a7c with SMTP id 00721157ae682-798c6ca2ea1mr59720497b3.41.1772747644186;
        Thu, 05 Mar 2026 13:54:04 -0800 (PST)
Received: from desktop-linux.python-stargazer.ts.net ([50.168.180.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876ca7354sm90121677b3.52.2026.03.05.13.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 13:54:03 -0800 (PST)
From: Mehul Rao <mehulrao@gmail.com>
To: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mehul Rao <mehulrao@gmail.com>
Subject: [PATCH] tipc: validate conn_timeout to prevent divide-by-zero
Date: Thu,  5 Mar 2026 16:53:36 -0500
Message-ID: <20260305215336.645186-1-mehulrao@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 67F48218B1E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.sourceforge.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264570-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mehulrao@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

A user can set conn_timeout to any value via
setsockopt(TIPC_CONN_TIMEOUT), including values less than 4.  When a
SYN is rejected with TIPC_ERR_OVERLOAD and the retry path in
tipc_sk_filter_connect() executes:

    delay %= (tsk->conn_timeout / 4);

If conn_timeout is in the range [0, 3], the integer division yields 0,
and the modulo operation triggers a divide-by-zero exception, causing a
kernel oops/panic.

Fix this by rejecting conn_timeout values less than 4 in
tipc_setsockopt() with -EINVAL.  Values below 4ms are not meaningful as
a connection timeout anyway.

Oops: divide error: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 119 Comm: poc-F144 Not tainted 7.0.0-rc2+
RIP: 0010:tipc_sk_filter_rcv+0x1b99/0x3040
Call Trace:
 tipc_sk_backlog_rcv+0xe4/0x1d0
 __release_sock+0x1ef/0x2a0
 release_sock+0x55/0x190
 tipc_connect+0x140/0x510
 __sys_connect+0x1bb/0x2e0

Fixes: 6787927475e5 ("tipc: buffer overflow handling in listener socket")
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
---
 net/tipc/socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 4c618c2b871d..85c07b0ba0ec 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -3184,6 +3184,10 @@ static int tipc_setsockopt(struct socket *sock, int lvl, int opt,
 		tsk_set_unreturnable(tsk, value);
 		break;
 	case TIPC_CONN_TIMEOUT:
+		if (value < 4) {
+			res = -EINVAL;
+			break;
+		}
 		tipc_sk(sk)->conn_timeout = value;
 		break;
 	case TIPC_MCAST_BROADCAST:
--
2.48.1

