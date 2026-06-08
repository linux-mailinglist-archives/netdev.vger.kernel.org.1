Return-Path: <netdev+bounces-296519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mtERI4+1JmpNbgIAu9opvQ
	(envelope-from <netdev+bounces-296519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:29:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E62266562A4
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:29:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UtZ1Eefz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296519-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296519-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 519A530A4EA0
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D0E37BE74;
	Mon,  8 Jun 2026 12:22:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB16379EC8
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:22:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921335; cv=none; b=Yg1BO2Ax5jwhOVP22+SK4ytHIV/3AwXk7HDPZa2kCmiyuEuSxdh8jh6xuU1MWQ60RaSusoZrJvypDuVeRs0AYsPuybh2/58hNg8JlZw+gGZ51WrzNEBuL3wrSEGevqiaP/RJ55eOhIq42THiYRx2IsZzvL97FROemNnPxCX8eLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921335; c=relaxed/simple;
	bh=pJqUumrKB0/4u7sCPTHJ6HR6zBezcfnqVPonu9qIXRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPUdl0Ty3Uyj09AsESUsFjbMalyPlrW/mhyZnf69YQShSDHCQOYiU8QnlfgTgjIczcdpphOAA07Jb2wBBmlp3cFbK94uF2cV8LhXVc2hOv24QkYer6YU3VThLaDL523iP1c6zKlvJSEl81cPo159sEeOzMqZNzivmkC4wQVkbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtZ1Eefz; arc=none smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5174a3a025aso43582501cf.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780921333; x=1781526133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MrGBPEEYekEzJUDI/0IZdur05EQK85djWZvVSId+E0=;
        b=UtZ1Eefz/D4ofFBQktEDtqzkRvTmD1Ii92dgiEpQ+a/7O9S57anO2EfFcr9Peclbju
         GQ+BqqIk4LrJQIFvnH6fyDOhhyDKZX7IWXlK1pPREYyRAKlLf2NLHE0GvCyhUqNyZ/xz
         V/vORdKJWUVkL8pwpqBeltXSrABQ++knNzA87xJxfCxWFXtxEZL6GH+grZYGz8sur76t
         qM9uYN243klJUCo5ftMBAJR831vp+OiOj5bXojq/7h87Y+dO3uQs54YcbsuctVVbxqiw
         JDSfETbB0UqwmlBCOlH/F4nIdPZqby5Zjc/nh7jLL37BdporNN27Z436ujmVeaWI4umq
         pc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780921333; x=1781526133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+MrGBPEEYekEzJUDI/0IZdur05EQK85djWZvVSId+E0=;
        b=sTcj2f78cn31WQ1zb6d85/lTg+ClcFn4lkc5Boh33H2vf8pryA/oyU/IDTPGFCrYcO
         OrUjGxKxx/QdTwswoR0c8Kox9rRyk4dqm3iiuWeJJTMM0OG6Q4JjJH5taDfMLecNBv7H
         rs6pJ4382PufvbMhhVGHx+rJWohZb5sccjf6yvWatiUAjdeqZeytmHsEHFLxwyzP3XhT
         a4xkrNCK9xe9zJ1coQKvo+aaOp7ve3WZMdBLd9T1R1rZrm+R5DBxiy+XmSSh5gb3TU/p
         JorRWJiprftr2P4x/QYrBvqqIkWkI01FfKofe5LaufVjViYZ4lWusjQEpT89QEUtPGrO
         CgOw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ysb1B6vBFgjlpVX9VJ6ycYSMvbllkPVPnBjpLDTAdWjxi4wYotSQD+C6eFvHiqTVP4OYyoiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzffPf7hG6LcNPiRfVWvXRBZid8p5EtilpcBVAGGR3cdQQDCmmU
	bg1dnq7eLDZrJwKR+qsTZsAX/NJ+ksX+dpG6qy6tT7EB4TTvuQBkpzqj
X-Gm-Gg: Acq92OF+ON65nntU6P4lqOHMdpCN0vgoZjO1hZ3j5JUAOGw6zHcuu5dS2mNy161vo58
	RTUMwSDZnAZI1kNq0gFsXAeuoHxjZbH8dKv/GchQgRbCyLg9S2a9fYsF7rf/es81+H4n/cY30HW
	KtUB2xhgTD0YOURnfKzPcKEUdS+ltV3Gb1wevnLBS337032/1mWBoX919nvVaR0c8tFlKgvYNP9
	Lcd6O70tNLTjVZoG4oQ6BKzY3osyJSo2/oGGLnDzbmUyrCKNE6iFQoO03lxM8RRwuHsdx72QyJj
	mkQ6gBJqDUnHgWJwhoTA65CYm0EsWgksJQaS5KVZYIPVlIBoVfWsANw/mHVIZGD/gEWFNJlmX1r
	LFY8p0yQGoozfIlj8oDCcu4XeKk1OmQIr4J1VYAnwDURspVhYo1NdozCxhIufw8TV2Ao0q0JTii
	yTQi6/es7pa/xCR7JdPO5Bj9yraOUJ1PuHlpCOftS8Y94OLZnsxLYf6qHZ7jyUGpZx6uVrO7lMN
	nC+ufsaP3Z6Zi1PNaTf2W+HQ97Cuok=
X-Received: by 2002:a05:622a:6203:b0:516:d781:589a with SMTP id d75a77b69052e-51795b1547amr192448551cf.22.1780921333115;
        Mon, 08 Jun 2026 05:22:13 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517af149fa5sm46086911cf.3.2026.06.08.05.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:22:12 -0700 (PDT)
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
Subject: [PATCH net v3 2/3] tipc: prevent snt_unacked underflow on CONN_ACK
Date: Mon,  8 Jun 2026 08:22:05 -0400
Message-ID: <20260608122206.458290-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608122206.458290-1-michael.bommarito@gmail.com>
References: <20260608122206.458290-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296519-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E62266562A4

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
v3:
- Drop the conn_ack local; test tsk->snt_unacked against
  msg_conn_ack() inline (Tung Quang Nguyen).

v2:
- Validate msg_conn_ack() at the beginning of the CONN_ACK block and
  drop invalid messages instead of capping the peer-supplied value.

 net/tipc/socket.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 9329919fb07f0..f64f7a35b5c91 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1362,6 +1362,9 @@ static void tipc_sk_conn_proto_rcv(struct tipc_sock *tsk, struct sk_buff *skb,
 			__skb_queue_tail(xmitq, skb);
 		return;
 	} else if (mtyp == CONN_ACK) {
+		if (tsk->snt_unacked < msg_conn_ack(hdr))
+			goto exit;
+
 		was_cong = tsk_conn_cong(tsk);
 		tipc_sk_push_backlog(tsk, msg_nagle_ack(hdr));
 		tsk->snt_unacked -= msg_conn_ack(hdr);
-- 
2.53.0


