Return-Path: <netdev+bounces-287201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHeUGJtDA2pV2QEAu9opvQ
	(envelope-from <netdev+bounces-287201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:13:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F5B52364E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BAD03024878
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FCB3AFB1A;
	Tue, 12 May 2026 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fewOg2eq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03113AFAEA
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596094; cv=none; b=fZLrQ17byTWEqbuFB6rk472inOkKHTPgBbH/cqdAoS3DGraa5heOuilSuPsxL/2qHn17EoIxE9JOhgYNBgFVjud9nddJvxzRIIC6acnBVTUg+sXprA2BJjzjIvlapRzEVSaTBJhOHwyp5IkatxDkDGD2J9ahL44oZ7CeXhkY/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596094; c=relaxed/simple;
	bh=zPhyqa5u2KBrafywdFL39mOjSHIacaNselwTAm6H6R8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EtuI8kPpbKeq54ECa99iy48ya+QeWQgR9R9NdYZjsxAm1QHl0HF3dVC3ODx0hNSpBPqf5XrPLAbpQlZScPFvhYqDGznHNpyl0gDpMdVAlxl0i7xsGpWsjViQ/RQs0sdm9HMsPa0UEimuSXZEVMRa8dWNFp3/1jgtIrH1+r3rSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fewOg2eq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bd2051167eso1090395ad.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778596093; x=1779200893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fDt9lvWWIss5l7S+jZrMRRKou8og9/yBAhB/HlvVJl4=;
        b=fewOg2eqdKc0Q10UjI2QPP+VTwVPWFgN0dudhH0bAGuxZtmIQh0Wx9pg82vTLPjU+/
         eCixib1CyOuddD/4RU1oQT7/bE/k3mN5ofdmwcq9J2TB44Re51vMlX/IJQbDqrhEnhxu
         Kvp04ouUJSUACpUl4LmQIhudgkDMq2QnRQJ3txNL7qPfvBip5MA/pb+hQN10KMdcKGla
         eWrCXleyjtfhlV00YJ+f1otj4YXd/69PuWDBa/cF+oFxQ9QRoVJG42uXI5FuDkbeJxQ8
         wrhSUhbsr5Cseh+BNlx75aIcaUOT/CHD4/c8/4lykXfSo/t5UHe2UkNv66r7F7+3ol4Q
         a5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596093; x=1779200893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDt9lvWWIss5l7S+jZrMRRKou8og9/yBAhB/HlvVJl4=;
        b=pEFXF3YUC7jDzmtlA+FR1HtEOd9lC3Tw94/XOs5nkgUQc0f7RXjbnDN++ohjMTyAbW
         o1pM+SSWTdrZN0KECN6ooyrmvfUn2opNEg4q6ih5GPmEVnKaRMmjqNDk65Yo+0EK6H3C
         ImXjLb0r9oVPcNn5YeEoO8UPpiY9GEKG29aV9+95X+TJawU51UmBp4kS6St/Vn+7Pezp
         HAHPoXjitf6WeHiKRimom2G1LhnfYyuhkLyy0yKqgsUKncrnjdSmUF/65b7ADJqYQJhT
         DXYH4N5odzbd4b2cz/CJOEqeofchvYRfHWUyBzj9imptPi5rLzm5nqmdkyW7R0USDLD9
         uPow==
X-Forwarded-Encrypted: i=1; AFNElJ+8O7buOdruqsKWdrUPu4xtM92XOBZ0c+c9rLbnunzdiYWrJPZyYXbb8Gun7DS87Glyga+QLws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvE3GjxZOWbo6F8AJiXwkt62KtzdX0l68PRnbShar78/IhAb+S
	hFFRaaIFVDrWFM14mkQZZp6UJJEW+cCNMOho9u17/gun2T2hxKYDimuN
X-Gm-Gg: Acq92OFinjYyU42MiMgEhwjbKZzOCPhIAFRwl3CVP0IOmwfDf8trrACB+jOEZK2KMDi
	0lnHBWAj0Ba4xbwHpU/QHjXCl+8ASq438X73PGKVDRNObCJOD5l8f4FKoGfcUok8un3eaRfkyw8
	nfYR+KO13x2LZ3VetgFSVL0Y+XM97w7dWzPdgWA17fojj9U0SpIFBDDAMY72Agsz6Fig/qt+rKX
	oYkKeL39mhVevLBOPlfZHw1IEW9V81Q/LBKVORJTekyu+XYHh6byX8Dsgf7ydByvayHKr6h63W4
	ehtdM7TTNnIpz9wE/P7dfR9GohpQVqhQSesVAAe4xNSJ8TAyUYTUTkLLpSfbIgwhO+BQBqtyIGq
	WJv6s33M7sPPIX9r9aOQh3VaYbLhBuvElEFdN17d6FrnUYlpBCd3UEmQCIkUVaxs0Ep1y07RvOP
	ksI7Mx3ztoMdqrcUMqxD6zBA7st8yW/o4IMiRB1SG80DxOTw==
X-Received: by 2002:a17:903:b46:b0:2b2:eb9d:1648 with SMTP id d9443c01a7336-2ba79c25ad9mr318963505ad.37.1778596092734;
        Tue, 12 May 2026 07:28:12 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d405adsm140861765ad.28.2026.05.12.07.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:28:12 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: achender@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>
Subject: [PATCH net] rds_tcp: close NULL deref window in rds_tcp_set_callbacks
Date: Tue, 12 May 2026 22:28:07 +0800
Message-Id: <20260512142807.1855619-1-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 56F5B52364E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287201-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

rds_tcp_set_callbacks() links a new rds_tcp_connection onto
rds_tcp_tc_list under rds_tcp_tc_list_lock. It releases the
lock, then assigns tc->t_sock = sock outside the lock.

rds_tcp_tc_info() and rds6_tcp_tc_info() walk rds_tcp_tc_list
under the same lock. Both dereference tc->t_sock->sk without
a NULL check.

A reader can acquire rds_tcp_tc_list_lock between the writer's
spin_unlock and the t_sock store. It then sees a list entry
whose t_sock is NULL. The dereference of tc->t_sock->sk is a
NULL access.

Move tc->t_sock = sock inside rds_tcp_tc_list_lock, before
list_add_tail. A reader holding the lock then observes the
linkage and the t_sock store together.

The restore path is safe. rds_tcp_restore_callbacks() does
list_del_init inside the lock. The matching tc->t_sock = NULL
after unlink is harmless to readers holding the lock.

Fixes: 70041088e3b9 ("RDS: Add TCP transport to RDS")
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 net/rds/tcp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 654e23d13..5830b31a1 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -198,8 +198,13 @@ void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp)
 	rdsdebug("setting sock %p callbacks to tc %p\n", sock, tc);
 	write_lock_bh(&sock->sk->sk_callback_lock);
 
-	/* done under the callback_lock to serialize with write_space */
+	/* done under the callback_lock to serialize with write_space.
+	 * Set t_sock inside rds_tcp_tc_list_lock so readers walking
+	 * rds_tcp_tc_list under the same lock cannot observe an
+	 * entry whose t_sock is NULL.
+	 */
 	spin_lock(&rds_tcp_tc_list_lock);
+	tc->t_sock = sock;
 	list_add_tail(&tc->t_list_item, &rds_tcp_tc_list);
 #if IS_ENABLED(CONFIG_IPV6)
 	rds6_tcp_tc_count++;
@@ -211,8 +216,6 @@ void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp)
 	/* accepted sockets need our listen data ready undone */
 	if (sock->sk->sk_data_ready == rds_tcp_listen_data_ready)
 		sock->sk->sk_data_ready = sock->sk->sk_user_data;
-
-	tc->t_sock = sock;
 	if (!tc->t_rtn)
 		tc->t_rtn = net_generic(sock_net(sock->sk), rds_tcp_netid);
 	tc->t_cpath = cp;

base-commit: b266bacba796ff5c4dcd2ae2fc08aacf7ab39153
-- 
2.34.1


