Return-Path: <netdev+bounces-296659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OTe9LMryJmrIoQIAu9opvQ
	(envelope-from <netdev+bounces-296659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:50:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4038658EB6
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:50:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ibL9kTmg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296659-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296659-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C6393095A7A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73093438B1;
	Mon,  8 Jun 2026 16:22:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8059834751E
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 16:22:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935759; cv=none; b=d5yx+loH0mRAd7jr99lN1MZORdgaGrFulwJQwyIfFLv7Jq7eEQiDQW78+SjZA+lm2uIfeHRbvwJHNjC//IeD4wTSxVQfUpLLhwAMNRi3+TbTk79Ph9RcSitJfdARWFXpwGn15WjctbC3cwil0efEasPhUOAqoTDaxUk65wp+vmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935759; c=relaxed/simple;
	bh=jFcy7qGszDpviUxuZY4SN2f2XLYRG009KZCZxWTYTDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EyA/IPp1DmtznzDPK0IoA1+HYSM1e6OEwmJcvBoiGsICpgr+CKg5SzciDc6WIppwDLL9eodFl72NNIa9Ofxsarmd01FCDgwPQqblpvz8mLP7d3K4selTCTIioUgt61QuBV75gmM/DThKzMO3mxaDmH3hpzBCoYaiQoWQZ+gxHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibL9kTmg; arc=none smtp.client-ip=209.85.222.174
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-91574384cc2so521065285a.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780935756; x=1781540556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yvinHr1mQvwvNvWAosxx0fmHzORHH/aQDJK7llc8tJM=;
        b=ibL9kTmgsM0+NW/9htvvrjqgoaRAMO1LNxr3WhP/f7qzJ6OoEC59FiD02bgPfULDB6
         TNIsI8MVk60PTFrhuGZBx0w26TybCtsElCioHSJWrU06S16pTJUNareffudBXZlTiD1L
         FVOCb+iuJzvKBBjeT2Mxv3FvQzvoEk+yV/KKEd2M2TuvyyW2js0VQkQ24L3HTz9og1mm
         ciksH9e5koDO51zwnc9Rfi6uXWsQpfcjpTqwU/HlqqpmINV4o5nf3OfJnpjwLaLTzRai
         Ttlmeiy4A7AeudNmltsfuDJMN1+NlvwewvyBSKcDHdsG/d16mVYn2YwfLkwrEgBqQ6wm
         TvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935756; x=1781540556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvinHr1mQvwvNvWAosxx0fmHzORHH/aQDJK7llc8tJM=;
        b=D5b8ilzA0/tLeEXPiLxalO0UpBWQMZ7KS4nLn7GbDt5tRn0ekHw5b+gxB9r2cn9B6g
         uRPqG1K6xPFuscukymc1CnAYPwKkfC0i8mkqg4bHMe0kjW+WKQD0Mjk9B+1oQ2txz0co
         bZJSKIEATps/1cRqUPbiqr9UOs985rSixWj6fAG0tIEY7oghK2SVmZpUtbJuKztDL2EO
         za8aeERRw3HPvOHSbigT43HIGJPgKIclZHNVO0pi44wQ1gRn7LFnwNGb8SiwFZfP8kqt
         q9Mvw9GrfTYv7WRJ8bWnNqsCgM+PHCvD1Hp9ydanK8jvYjjFfPKZpS2t2RdVIFN6fY3x
         ydMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CS2vopasaLT0BVhQn8OZUN3GKqyEjRvQG98G9z0iHWdAC46WybFhnqwpOl7oOHFYyEpwCpWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2rkDsM61q6Xuh3w2tJYiIs1jZ73fLuNAQwLd9+7B7tAtBRfFZ
	Ofxm9rJMmnXTZOP3T28KyI4xMQnn29Qo7Xc3SoboCKPb5UWmLC1l7C+y
X-Gm-Gg: Acq92OHrQ6f9x32bT/6ycwXr4NhuUIe7gy8JmjkQ2McJ8feYG/ejNQHirFGYbcs1Rgf
	djrD2vVdKD1j7TNo9EiaF+PsmZAVElRCBnIitaXcNmcbAG3/1Q2n8simAXGH/z7LOOBMZPJICfs
	sbVoEpY3LRXQqcA1fhESbOOZN7wEIOhIombO7U1NMPXBK2lQ5EoxuRr9Dn+5fi+DIa3/YKb4/N9
	fZFG0HP0F+73/M+jqmhDZVi6bQ/j6JoZHrADgvC2cvt/I9h9iAlU+0fs5QpMjvNmqgxf1yor0f9
	ATXk67VwuRLAzQ/HTfXdYmLVgPGDRRGwzAtK//AVTkas9PxF/IiXSI+ohG9s/gvh5c1G1zhPg/c
	DF7F/bnASNACpdv5k0zeXEDn+pmleB1RMfFaAnQI0LV16uykOKZ5nFzruII4LT8X3dvaAzzbASa
	rokTQdoohuuj53e2qf1ppDA3EJl27YnqKUtU/6pnDFl6v74G6ZHZltPE1HxtUA4Q==
X-Received: by 2002:a05:620a:bcb:b0:915:6a2b:626c with SMTP id af79cd13be357-915a9dd11d3mr2539559785a.51.1780935756139;
        Mon, 08 Jun 2026 09:22:36 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9159cd62a84sm1382524185a.5.2026.06.08.09.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:22:35 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH net v1] sctp: Unwind address notifier registration on failure
Date: Mon,  8 Jun 2026 12:22:30 -0400
Message-ID: <20260608162230.46644-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296659-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dbgh9129@gmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4038658EB6

sctp_v4_add_protocol() and sctp_v6_add_protocol() register their
address notifiers before registering the SCTP protocol handlers. If
protocol registration fails, the functions return without unregistering
the notifiers.

Unregister the notifiers on the protocol registration failure paths.
Also propagate notifier registration failures instead of ignoring them.

Fixes: 827bf12236fb ("[SCTP]: Re-order SCTP initializations to avoid race with sctp_rcv()")
Fixes: 270637abff0c ("[SCTP]: Fix a race between module load and protosw access")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 net/sctp/ipv6.c     | 10 ++++++++--
 net/sctp/protocol.c | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index cd15b695607e..ef26878f1282 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -1176,11 +1176,17 @@ void sctp_v6_protosw_exit(void)
 /* Register with inet6 layer. */
 int sctp_v6_add_protocol(void)
 {
+	int ret;
+
 	/* Register notifier for inet6 address additions/deletions. */
-	register_inet6addr_notifier(&sctp_inet6addr_notifier);
+	ret = register_inet6addr_notifier(&sctp_inet6addr_notifier);
+	if (ret)
+		return ret;
 
-	if (inet6_add_protocol(&sctpv6_protocol, IPPROTO_SCTP) < 0)
+	if (inet6_add_protocol(&sctpv6_protocol, IPPROTO_SCTP) < 0) {
+		unregister_inet6addr_notifier(&sctp_inet6addr_notifier);
 		return -EAGAIN;
+	}
 
 	return 0;
 }
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 5800e7ee7ea0..6153340f1b45 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1263,12 +1263,18 @@ static void sctp_v4_protosw_exit(void)
 
 static int sctp_v4_add_protocol(void)
 {
+	int ret;
+
 	/* Register notifier for inet address additions/deletions. */
-	register_inetaddr_notifier(&sctp_inetaddr_notifier);
+	ret = register_inetaddr_notifier(&sctp_inetaddr_notifier);
+	if (ret)
+		return ret;
 
 	/* Register SCTP with inet layer.  */
-	if (inet_add_protocol(&sctp_protocol, IPPROTO_SCTP) < 0)
+	if (inet_add_protocol(&sctp_protocol, IPPROTO_SCTP) < 0) {
+		unregister_inetaddr_notifier(&sctp_inetaddr_notifier);
 		return -EAGAIN;
+	}
 
 	return 0;
 }
-- 
2.43.0


