Return-Path: <netdev+bounces-64053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA69830E5F
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 22:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2BB28248F
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 21:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E629250EF;
	Wed, 17 Jan 2024 21:06:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12FC2554E
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705525610; cv=none; b=B3gJXFTJoE/z3GJK0bLFNoQntQ6Orp57Yw3IJRGecMDtU3kQTXrotnODY5+xpmT9a40dPgEAqj+TMeGPTvbW0p0mezzQVyUpujVNlGwm8ZlK6n4tnDrqKVa5wBlqXdCLGusXtZaFhPu9TS/te1AiRELXkEq2ru5neUmoWmRQjCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705525610; c=relaxed/simple;
	bh=ZCZtU7sGFfzj7clYaW0jjj9UugpcHwZlgd4aPPeCcuM=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-SA-Exim-Connect-IP:
	 X-SA-Exim-Mail-From:X-SA-Exim-Scanned:X-PTX-Original-Recipient; b=J/vP9N0JxQHjhUUPKsrSoHDW5Ytis/Z6GumWvJiyLyJHC401bDC42iuBaez8XugQuKOQzE/kWo6oGhkYkuyDL7GcvsDtmDdnmW1aHBiLhqRtuXFEt0JSViPCx6vTfO3pBXZxB6C09dKtx6yB87tQO9BR79cq7Q2v6AzG9Er9xC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rQD7G-00079O-Te; Wed, 17 Jan 2024 22:06:30 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rQD7F-000Xnr-1r; Wed, 17 Jan 2024 22:06:29 +0100
From: Lucas Stach <l.stach@pengutronix.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: [PATCH] SUNRPC: use request size to initialize bio_vec in svc_udp_sendto()
Date: Wed, 17 Jan 2024 22:06:28 +0100
Message-Id: <20240117210628.1534046-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Use the proper size when setting up the bio_vec, as otherwise only
zero-length UDP packets will be sent.

Fixes: baabf59c2414 ("SUNRPC: Convert svc_udp_sendto() to use the per-socket bio_vec array")
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 net/sunrpc/svcsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 998687421fa6..e0ce4276274b 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -717,12 +717,12 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 				ARRAY_SIZE(rqstp->rq_bvec), xdr);
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
-		      count, 0);
+		      count, rqstp->rq_res.len);
 	err = sock_sendmsg(svsk->sk_sock, &msg);
 	if (err == -ECONNREFUSED) {
 		/* ICMP error on earlier request. */
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
-			      count, 0);
+			      count, rqstp->rq_res.len);
 		err = sock_sendmsg(svsk->sk_sock, &msg);
 	}
 
-- 
2.43.0


