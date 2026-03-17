Return-Path: <netdev+bounces-268446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEfnEqrpuGlplgEAu9opvQ
	(envelope-from <netdev+bounces-268446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 06:42:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 542642A40B8
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 06:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2101D3010686
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 05:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AE137F733;
	Tue, 17 Mar 2026 05:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdM7Lny4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8C282F2E
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 05:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726112; cv=none; b=Ge7heRi5ikZ/l4kjrKurVxxlGrKCW733xBim5e12t75ewnQP+Tf14vwhK0UPFgzOlOof+16mNrirZ48iDFLX1/sg4A2hhTy7TRPNjVw+CVjB7C0sOCafuHIGNoLNw7IVVZHP3jnLXv9s+BcockjlIBWGWswFM9FyFy5wjR3UHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726112; c=relaxed/simple;
	bh=bltp3WJAylvLdfOQ5q+iE7Igpst4STCCh4hr4m1hx5E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sBD9+nGbc4FGhGnmEJws5YnjgpEmV098UyHNl8GHY4kS6Z1K9x0IgrzyEbP7Z7vt+YBPC4RIK7QTD9oN1m4gOHix51H3+Bae0eZbHVYBx8x5oOXdBOnFrPHGcBiBESbInekFZrOxOxq3O0leDOjsd1zRobiWWeKJs7zpnAdNhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdM7Lny4; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b97b7e0368eso264967766b.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 22:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773726109; x=1774330909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/aseV1JohbHZtQxOSTDVIyaCJRT3wIWyomxb4YwbsJs=;
        b=XdM7Lny4kDM5mG8unAVNW/01cajvbi3iCjTsI9k25xzGVVUoaFwbKfY8MhSEh7yPu6
         OnLqcNNBGnVF1g8soXk1NXdO3W+VVQ+QsY+zeykMfD4dyKZvshTv/kv/dykVoKv1Qv25
         PuOscBnQffthI7f5Fd6816DUmIAhy0W279Q/WkYloqmfhgkJAAU3wNJXbYejZV+xWTqO
         JV1U+cKePKPXs03/xAlkAMwfmSAg/1W5ri+H/2rlZmuSAtnQXXRTocch5H9wKrnGOOTF
         lhihCQ6N30Qt5CmCpdPbvCsZjwayOq7gq7uuvVoLcaZdqaY24DaoOhDjWBjQOqcJh5DK
         nrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773726109; x=1774330909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aseV1JohbHZtQxOSTDVIyaCJRT3wIWyomxb4YwbsJs=;
        b=JlWPdLeI7Yxg4kgRPufOxXJ+0XjGlYqvj7ZX3MTrIrdokXjVUo08fF9ERUPA2P0Y5b
         lvirDReOiONP2RPiBaVACiU6mhWM73rWZgW+R9MHJ5Mv/C8p6xJaNw5Uy/qa27TzylKy
         n9qOaGOXoMD71LBUf+JVmvq9jq1dxsqIDfW7afKQoe9t8WTOU88z5qMtdo8aRyB90uLG
         895zhKDDdIOrpxYVTwA2HRML+bCBWHofHt9IdUW+5XUuyQN1oXyBQUJaFf30CVdEY0fD
         C8AxC2F774ictU0ADzmnDqHr8X0Do5L8tntmxq97LdFLRq/in2DVlG/rDQGL8guvWaGt
         BBEg==
X-Forwarded-Encrypted: i=1; AJvYcCUw1nYYS7T+OEvLUNkBPBvMu8T1PlxccGH368kP4+FXDYw9ewFl2SdjVYvuay1CUgnOu9Z5+AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSjUmvXx1Mk0nwq9Rw8wlezjvK/3rrNqg/YO8tDq0v8zFGk7mn
	rS9COF60D544eAUpQcYiJCc32/J267uXgjOS0hUD2P7GyI3gRaNVdXXk
X-Gm-Gg: ATEYQzwYIhxm0Hvmh2IczB73o65brekjsNopoN7QTWxktAGCz0I9TO+pJc7spqwc/xq
	sDZuiL1YBvzvMDkDMA46b7XtS0dvpx7hpcGCzxHx6ICPijoBPxv3PJ4gZyRPNjIFevaqyKKT1mw
	hgC3uLEZhnUsomvcdiTUlrH0NBWi3n6GmcWhdKi1X7n3J3DGX8SLhhfLjiI29VB27dSf3Qp9oZP
	Zash90hm62L1c8KmIVxCHEFVEi2Epe22PUTl6MDvYRPNIfbBaf+xo5Y1FRPfQ9GSqzTJn6rMLzJ
	eAJIYQnowauCXVSSOg41/FYHsWJ+GrADp1bJw1o5aqheA+QFZn/RvZ/r9J1UdipNvwBRpuzn3WU
	opjOiYFIHybRV6s53tX2yYW3fzF/zkTBb/sTOqam6BVjugC3bIHynYnoRVhQ0LtsLPzjH54+3xD
	e918OgXAY=
X-Received: by 2002:a17:907:72c2:b0:b97:b20f:c5b2 with SMTP id a640c23a62f3a-b97b2100569mr440106766b.9.1773726108699;
        Mon, 16 Mar 2026 22:41:48 -0700 (PDT)
Received: from gmail.com ([2a09:bac1:5520::49b:49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976cefca43sm687527566b.46.2026.03.16.22.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 22:41:47 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: linux-ppp@vger.kernel.org,
	James Chapman <jchapman@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] l2tp: ppp: use max L2TP header size for PPP channel hdrlen
Date: Tue, 17 Mar 2026 13:41:40 +0800
Message-ID: <20260317054141.524879-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268446-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 542642A40B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

chan.hdrlen is read once at channel registration by
ppp_register_net_channel(), and used to set the PPP net device's
hard_header_len. It was set to PPPOL2TP_L2TP_HDR_SIZE_NOSEQ (6), which
is 4 bytes too small if sequence numbers are later enabled via
setsockopt(PPPOL2TP_SO_SENDSEQ), causing unnecessary skb reallocations
on the TX path.

The setsockopt handler attempted to change netdev's hard_header_len by
updating chan.hdrlen, but the PPP layer never re-reads it after the
registration, so the update had no effect.

To avoid the unnecessary reallocations, set chan.hdrlen to
PPPOL2TP_L2TP_HDR_SIZE_SEQ (10) unconditionally at registration and
remove the ineffective update in the setsockopt callback.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v2: rebase to net-next and drop fixes tag
 - https://lore.kernel.org/netdev/20260313034732.209792-1-dqfext@gmail.com/

 net/l2tp/l2tp_ppp.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index ae4543d5597b..99d6582f41de 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -787,11 +787,12 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr_unsized *userva
 		goto out_no_ppp;
 	}
 
-	/* The only header we need to worry about is the L2TP
-	 * header. This size is different depending on whether
-	 * sequence numbers are enabled for the data channel.
+	/* Reserve enough headroom for the L2TP header with sequence numbers,
+	 * which is the largest possible. This is used by the PPP layer to set
+	 * the net device's hard_header_len at registration, which must be
+	 * sufficient regardless of whether sequence numbers are enabled later.
 	 */
-	po->chan.hdrlen = PPPOL2TP_L2TP_HDR_SIZE_NOSEQ;
+	po->chan.hdrlen = PPPOL2TP_L2TP_HDR_SIZE_SEQ;
 
 	po->chan.private = sk;
 	po->chan.ops	 = &pppol2tp_chan_ops;
@@ -1176,12 +1177,6 @@ static int pppol2tp_session_setsockopt(struct sock *sk,
 			break;
 		}
 		session->send_seq = !!val;
-		{
-			struct pppox_sock *po = pppox_sk(sk);
-
-			po->chan.hdrlen = val ? PPPOL2TP_L2TP_HDR_SIZE_SEQ :
-				PPPOL2TP_L2TP_HDR_SIZE_NOSEQ;
-		}
 		l2tp_session_set_header_len(session, session->tunnel->version,
 					    session->tunnel->encap);
 		break;
-- 
2.43.0


