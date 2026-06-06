Return-Path: <netdev+bounces-296140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n9PXDYByJGra6gEAu9opvQ
	(envelope-from <netdev+bounces-296140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 21:18:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E0464E1CE
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 21:18:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aUoq7vUA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296140-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296140-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B06AF3062ABC
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 19:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD343B7779;
	Sat,  6 Jun 2026 19:14:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E0B3BCD33
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 19:14:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780773283; cv=none; b=u9uJ55bwh5CiFNkHJybxAyv3U6qPYMXCpXcktAmSqlM6vU0Fu8bXYZJNBWUN/VR9tcceHBu1zXl7BK6CtWixeq9w6lLOh/JVbjZsPj7liYIFnLubuGKuhZfDk96f1L3BVzHxSSaHse7YLCHVblDFbE729zThceqjfVVnZhYANsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780773283; c=relaxed/simple;
	bh=/WGTThKiWoXaSPSBRFPFPXRr9IPffFu1oz4NhaY1Lps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOy0hQH0TM9KT9rfjbEbjbdcoD7zYE93ApA8CQkNz9N0JcoVMNi4GuecXojsyFKwtNBoZSXXxYTzSwDR5D3zeJjoP5l+uwXggGctnhcX8EwQlP85IeDRjcvZioAZ5q96rn/lFsnzskGdJTJG+XvEXRJ9ZBvxm6fBAB3/I4hNxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUoq7vUA; arc=none smtp.client-ip=209.85.222.171
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91587626ae1so349431585a.3
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 12:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780773274; x=1781378074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjaADf0iYzsBqrk/kDn29iyRmVw1j4V13eigHGwqym8=;
        b=aUoq7vUAiLBJvx9PivNDG3JP9yHFffC/m/QADat2PITOqc57BZIHZkK25tNTvjPVJB
         1qO61ueZ1JatUw0F6gbt3S/u58M1ASW5/wzSfIswe0fC1mLnW1MpOo+4qvzxt4YEiSHM
         tR6ETKUx211ABjX9ODIyhUw8HNuwdT2TopCl0n6k2d7IHJW75yLnApCHSKYN9kXDUKAk
         QM7InWAi8TNiTZNTuANXcNv+hhCPsRRYdUBy6qa3GOljPX54UbfPo1OogK00B9OnXt9O
         jUMmzhs8Xss8ZeQIt31wrGgC7TEWH8hKfAEYK+6aI3CFfQyGAXQtoRb01sR+ZS5KLhc3
         tIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780773274; x=1781378074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GjaADf0iYzsBqrk/kDn29iyRmVw1j4V13eigHGwqym8=;
        b=ATlJ73sSk/0u6bYgnPx5tr9f+OPNb4UBdC+4d8nEPy92dh8H4o5q/tV7WKc4liMLZy
         4I+5ChwQz5TOYVRMY3LiMnLh/lNUKc3Az1aQOlVHGwLKQ0XpPsclwGecipOSd4aw8FfG
         q1mj4HUrOGTszitnm+IdJSvrGJH2g5EV5vb8UZBq03F7hyH8EWJHJVR2ZLyYydQTjk8x
         SnsAhLPmyg79n1W0x55zRC2hFrdddMwpOND4oy7g4yV7IzjaC1oSc2FzOf26xggOxTQ7
         IzKpea0t2QXAqb3VVVcWiu1H6O04TLVmbyowwS2M80KUrpVltwppr4MHYWUrmkClwNsK
         VkJA==
X-Forwarded-Encrypted: i=1; AFNElJ+j/oBVWTtbvmpOs9KMR/nIgbxP7UKfMK8qNe/w5h9O+AMEZSEb2QJfSosPYkPMzTJ0XNSy1bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5kwGs6QIwpYBVXe4StbzriS3RMYZ50KScJMC2xsbbh5BVCPF
	Q86XyQuaK7hGsnMs5uylvy3Ix7HY4D0cq2HrksL3XnMNrDk4XbZQe9Q+
X-Gm-Gg: Acq92OGmMGxXo6mYNlcUTrK4HMWsD11JtRQgtOhp3Nee6T5oEq2Oj6au5bmx+D8zYLJ
	pRLeznq1vyhJDx2jfD9JEH+R6otYPB9MAhSNjmpOs2+pAc3mYQYSLr4XXjpVp7CM4m+32t7xvI7
	NhNpHgOryHg+TE0Dfly4nqYUUAcGOaE7nKDLu+epOoM08ruKKK9M0v7gJetCeFXKGsDVIYbSRIq
	w/r3zf0NKupHHcJbBphrzLAJYKCJzTkQ2r7gtkWaZd2Q6bq89k5lTESKW8fLDAEpBA/Icw+Li+t
	/z/3RGv74Sp3b4zIHdm5c1gOZm01CYJTkfBUxzeCh5xA5qg1XwpHqDLp911I0c12e8MWvc2+5R+
	X7iIMvR3AuZef2qZeBY0Q6se9PZ6ITwS1eec3CMUyqFz6bnytTHKAu4xOCao1ChsTA6H+ugZXAp
	OQKoLeqthGGGFZh5lvS9Fx1diB5rP5MGs3cIg1VKYfm/bFr72S/v9YBvaC9BAa0zSIxDmhWZnks
	GC3SO5GEB3Z3TOQTZJ8wifKWO/TcfAeM5IUK2vXWQ==
X-Received: by 2002:a05:620a:701b:b0:912:1206:ddd1 with SMTP id af79cd13be357-915a9c758d4mr1494790885a.1.1780773274164;
        Sat, 06 Jun 2026 12:14:34 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00a4f4sm1311699285a.3.2026.06.06.12.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 12:14:33 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/4] tipc: prevent snt_unacked underflow on CONN_ACK
Date: Sat,  6 Jun 2026 15:14:12 -0400
Message-ID: <63f37dc57a6d2cc614cc466582cd8d69192c720c.1780766454.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780766454.git.michael.bommarito@gmail.com>
References: <cover.1780766454.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296140-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83E0464E1CE

tipc_sk_conn_proto_rcv() subtracts the peer-supplied connection ack count
from the unsigned 16-bit send counter snt_unacked without checking that it
does not exceed the number of messages actually outstanding:

	tsk->snt_unacked -= msg_conn_ack(hdr);

msg_conn_ack() is read straight from a received CONN_MANAGER/CONN_ACK
message. If the ack count is larger than snt_unacked, the subtraction
wraps to a near-maximum value, leaving tsk_conn_cong() permanently true
and starving the connection of further transmits.

Validate the ACK count at the start of the CONN_ACK block and drop the
message if it acknowledges more messages than are outstanding. A peer (or,
for a local connection, the connected peer socket) can otherwise wedge a
TIPC connection's send side by sending an oversized connection ack.

Fixes: 10724cc7bb78 ("tipc: redesign connection-level flow control")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
- Validate msg_conn_ack() at the beginning of the CONN_ACK block and
  drop invalid messages instead of capping the peer-supplied value.

 net/tipc/socket.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 9329919fb07f0..80ad973cda16e 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1362,9 +1362,14 @@ static void tipc_sk_conn_proto_rcv(struct tipc_sock *tsk, struct sk_buff *skb,
 			__skb_queue_tail(xmitq, skb);
 		return;
 	} else if (mtyp == CONN_ACK) {
+		u16 conn_ack = msg_conn_ack(hdr);
+
+		if (conn_ack > tsk->snt_unacked)
+			goto exit;
+
 		was_cong = tsk_conn_cong(tsk);
 		tipc_sk_push_backlog(tsk, msg_nagle_ack(hdr));
-		tsk->snt_unacked -= msg_conn_ack(hdr);
+		tsk->snt_unacked -= conn_ack;
 		if (tsk->peer_caps & TIPC_BLOCK_FLOWCTL)
 			tsk->snd_win = msg_adv_win(hdr);
 		if (was_cong && !tsk_conn_cong(tsk))
-- 
2.53.0

