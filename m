Return-Path: <netdev+bounces-298488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LJ/8D2O6K2pxDQQAu9opvQ
	(envelope-from <netdev+bounces-298488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:50:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A12046776F3
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:50:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=HpFDsyXY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298488-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298488-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA13B313408D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3B3DDDB3;
	Fri, 12 Jun 2026 07:48:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073AD38E8BC
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:48:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250490; cv=none; b=fep2hc0Cmb6vOb1KRbYuD+AQETTTrM4KNvVPgRii8pRCIdemB+6ptx6qEYwmylH6uGzVwc7OGn0CjGJNo6JhxE35xGVIIDjgKXFPPlTMSm4raksQBmvEEHFa6B+z0s9HsoQuzeW3Ct15w63uPr+uRb/N6tiZ6dg0S0BxieefYbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250490; c=relaxed/simple;
	bh=Wt0kee5uW5AAQjjPf4rOWldQcRF4BvUOCT8kdxy2tGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNMZxRIGSdW1Da0pEIvaner8o4Vp2QGD2HLVXFipvsgVd9l0qt9IcM0FaHcLy2aLsqVjezIAgZ3jaFndYGByK4e3/Gw/TZGQEZ6hkDBw6hz+wtHkB6N38NshrmaIvlK7VWtlWQcZBiTDF1ZvbPBBUrbUmiP3U4B7ouxMxavRqc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=HpFDsyXY; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6B45A20758;
	Fri, 12 Jun 2026 09:48:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4vlH6Vcn7COz; Fri, 12 Jun 2026 09:48:00 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D2EA2206D2;
	Fri, 12 Jun 2026 09:48:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D2EA2206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781250480;
	bh=dbKoCfXqStKoD7KOm1kOEjm/FLOi2eUgSwOqqtNALg0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=HpFDsyXYXmdKskyVimH2cwV7su1DGhzVyA9Vht35qTl8cVSwm020nxQH7+oDWhOJP
	 IUJ5XaTr16GyeeyHea878CoMeujdDgpirGE+PbimNpYMcSjgTUKSQOB/PvczSiFxEN
	 EsDZgbzXh2zSuljaOwKiKJvFuGjPyddbPYqWIp/NJE2PQvDDsdh4ClrM7Hw8ennU08
	 VSU0eNj0ocHqHBu4XpzhwxhmyazhVaHX1xX3Tgn3tIBOMm/Us79MomDxCLE1NcGcCk
	 oZzg/pRqe4p6jeoFISCQkvouDIF8OE1GW1UvS88ebJbuixj5r1ARFq8YImEScxoYkz
	 9czVhPXTExv6Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 09:48:00 +0200
Received: (nullmailer pid 1768302 invoked by uid 1000);
	Fri, 12 Jun 2026 07:47:57 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 13/18] xfrm: refactor XFRMA_MTIMER_THRESH validation into a helper
Date: Fri, 12 Jun 2026 09:46:29 +0200
Message-ID: <20260612074725.1760473-14-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612074725.1760473-1-steffen.klassert@secunet.com>
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298488-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,secunet.com:dkim,secunet.com:email,secunet.com:mid,secunet.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A12046776F3

From: Antony Antony <antony.antony@secunet.com>

Extract verify_mtimer_thresh() to consolidate the XFRMA_MTIMER_THRESH
validation logic shared between the add_sa and upcoming patch.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ce65e872cbac..62eccdbe245f 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -248,6 +248,22 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 	return 0;
 }
 
+static int verify_mtimer_thresh(bool has_encap, u8 dir,
+				struct netlink_ext_ack *extack)
+{
+	if (!has_encap) {
+		NL_SET_ERR_MSG(extack,
+			       "MTIMER_THRESH requires encapsulation");
+		return -EINVAL;
+	}
+	if (dir == XFRM_SA_DIR_OUT) {
+		NL_SET_ERR_MSG(extack,
+			       "MTIMER_THRESH should not be set on output SA");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int verify_newsa_info(struct xfrm_usersa_info *p,
 			     struct nlattr **attrs,
 			     struct netlink_ext_ack *extack)
@@ -455,18 +471,9 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 	err = 0;
 
 	if (attrs[XFRMA_MTIMER_THRESH]) {
-		if (!attrs[XFRMA_ENCAP]) {
-			NL_SET_ERR_MSG(extack, "MTIMER_THRESH attribute can only be set on ENCAP states");
-			err = -EINVAL;
-			goto out;
-		}
-
-		if (sa_dir == XFRM_SA_DIR_OUT) {
-			NL_SET_ERR_MSG(extack,
-				       "MTIMER_THRESH attribute should not be set on output SA");
-			err = -EINVAL;
+		err = verify_mtimer_thresh(!!attrs[XFRMA_ENCAP], sa_dir, extack);
+		if (err)
 			goto out;
-		}
 	}
 
 	if (sa_dir == XFRM_SA_DIR_OUT) {
-- 
2.43.0


