Return-Path: <netdev+bounces-306977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xy2QAjLrU2rSgAMAu9opvQ
	(envelope-from <netdev+bounces-306977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 21:29:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E52745C16
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 21:29:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=P4xxHuf9;
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306977-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306977-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43AE4300A8FA
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 19:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD48B3B47FF;
	Sun, 12 Jul 2026 19:29:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CF53B2FFF
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 19:29:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884558; cv=none; b=LNK6ybG1u/FyzmL2/SvLbDs1qe1F94g+HTs/JvU5kRiWjRF32RV17oS6QWxA9iEdmaTMfp62XiJPpbtVVLB3IUBUko5Yx8Xc06Fp6PEl9Ln0lAx/1kOoDLJHXUCV/Ak5oSlWBUZcvNoiABpGxZKcJdjUC7+oc2Pvof3+1TImU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884558; c=relaxed/simple;
	bh=QJQE/GXd0K169a8mwkplKKdkmQ5sBJfTjp2LDq9OYG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iONYdzOe3gnGj07/ufkiyKFpnn0Si7u99qaxbJ0jiHEUOUEMWeVOlBSm4QHhnCqTmDUlE6S+cARAbVLc7Q6tCH1si7slLyZRRUUnewCrrjYpZOWmz8PjoHgS/pAIrw18yPMSZzR3D3/26w6fAPZ0J8OkNtfKIkSmp7jXGXV94IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=P4xxHuf9; arc=none smtp.client-ip=195.121.94.185
X-KPN-MessageId: f798f299-7e27-11f1-9e8e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f798f299-7e27-11f1-9e8e-005056999439;
	Sun, 12 Jul 2026 21:29:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=jTewONXvFxgGhvbpYUlhsacZJwkbZKyIKe17J6I4b48=;
	b=P4xxHuf9t62cHKEpGb8t8CYqH1Jo9Yzt4DwnlWQdIvKB5c/bifaVrVkLK21nLkdXiDOEw6J0TrH7u
	 5X8mBl4JeOjrgEqzn2I5w4BlZYBBGaXZgHxHZd/XMHeChXLIfSjTs29IaLtg8jMzJPDfOXBRYDYxd8
	 M9FH4lyE+Diyax8ZS2FYC9Do0vGMUGpn4Vunqn0mpLgrV7l9jKRTO9KmP7277dekfVIGO01MTkvAKS
	 2B1bRypjDG+MahpGNzYoYoi/7uKuin1gAXXcbY2k+5Xs83vTWaCPJgmEZAvxrrdsUXd+jYe6Y58tTf
	 iEMuUJ/kv3SXrU0pa5ecQeWF7SMcAhg==
X-KPN-MID: 33|CwIQjKs957AdyUdlOp28+PvDB5Y+7tZPq2VDRTbC4dBudSZCQT7UlPggFgSIGBk
 0a9iTxHxpnTlNdDTQVGrIQzku4B7uHbphAiBJbSelbKM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|NTLceOVGjkZuZpL9PCIGW5OMiyJ1Uw8ilTMavKGxPBNhuwrZUZcnYJg6hQHzEKF
 2D3BmVEg5K2TpefHHy1d+8A==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id f757ec1f-7e27-11f1-8dcc-00505699d6e5;
	Sun, 12 Jul 2026 21:29:14 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [net-next v5 2/4] net: scm: move scm_detach_fds() from common path to scm_recv_unix()
Date: Sun, 12 Jul 2026 21:29:56 +0200
Message-ID: <20260712192958.1631672-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712192958.1631672-1-jkoolstra@xs4all.nl>
References: <20260712192958.1631672-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,xs4all.nl];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TAGGED_FROM(0.00)[bounces-306977-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jkoolstra@xs4all.nl,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,xs4all.nl:from_mime,xs4all.nl:email,xs4all.nl:mid,xs4all.nl:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45E52745C16

scm->fp can only be set when using UNIX sockets, therefore we should
move it out of the common path __scm_recv_common() into
scm_recv_unix().

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 net/core/scm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/scm.c b/net/core/scm.c
index eec13f50ecaf..a73b1eb30fd2 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -523,9 +523,6 @@ static bool __scm_recv_common(struct sock *sk, struct msghdr *msg,
 
 	scm_passec(sk, msg, scm);
 
-	if (scm->fp)
-		scm_detach_fds(msg, scm);
-
 	return true;
 }
 
@@ -545,6 +542,9 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 	if (!__scm_recv_common(sock->sk, msg, scm, flags))
 		return;
 
+	if (scm->fp)
+		scm_detach_fds(msg, scm);
+
 	if (sock->sk->sk_scm_pidfd)
 		scm_pidfd_recv(msg, scm);
 
-- 
2.55.0


