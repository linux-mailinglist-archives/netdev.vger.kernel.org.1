Return-Path: <netdev+bounces-253808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LHhNwCXeGnmrAEAu9opvQ
	(envelope-from <netdev+bounces-253808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:44:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 810BC93046
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAACE30054D7
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A607F343D86;
	Tue, 27 Jan 2026 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QkGItp/m"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0752FE063;
	Tue, 27 Jan 2026 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510654; cv=none; b=KBYrmjrr9t2F9PGDI0CJ519iktAGN/xjC+YXnNj84Gtk855GkOHXVuLsQ2tdqlrsPwa+JrPsNReQJHO3d9PQ/vyW4vXj+xPxRVkIUBUMquKh6qlXOSD49poSHBZrm0s2anoVwRSwNosorgZj5QLH/ypveL8Frh7dywL+8sukYYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510654; c=relaxed/simple;
	bh=Mg+r5tOLzryQHiSagfu3B3DNgl1Xh8UdetYRJyWdtIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRmpImYsTgxcvQF6xqagao7Q+4K0FEFET4GULmO3ZlgcAoRWz74h7kM0VBW7W8xAbyc3cGrzCVcVOD13a09Ty6lMjp7/bRiJgFEq3A0BjBFPAKYB0z176NH67/ew/0CjazRssmYdmRLwtCX/hVpqHmpeYNWBmv+l3R2DmpTcAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QkGItp/m; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7B639204D9;
	Tue, 27 Jan 2026 11:44:11 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8roKOGI0eJrk; Tue, 27 Jan 2026 11:44:11 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E0D25201E4;
	Tue, 27 Jan 2026 11:44:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E0D25201E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1769510650;
	bh=0fBn+50DnATtEoyIitkebLB82Bf9+iOS0cPXWbtr5OM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=QkGItp/mBdBuLcIg8TLayRHipWxtYaG3FviSyG5pjsfkVhY8p/7Z73J33YzD0y5yM
	 uIw7l2A3tCTUy/arQo64NHa6a+TpD8T7fP+MAIemMY8hYxs9vSdl7SMXrLP0WsL0mN
	 HriaXF061CVhMvZT/6XNZ1PGqhuwTzlyOAGHUuHO+AjqNZ5IpfUBCI+Vy5Cl53LZAm
	 O58+xUHkLt8AYs4kVaLLsl2W0MkJmVlcrgb0tjmFmr3QDvtWBwEoo1mrYcxg9zYryj
	 VgjSbi932Oo6WyOz64iVFSQnuBtJcO8whDxZAS3if9wMy8vGRGup1mQak/oLTNclMn
	 d+yNFlVcziA6g==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 11:44:10 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, <devel@linux-ipsec.org>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec-next v5 7/8] xfrm: add error messages to state migration
Date: Tue, 27 Jan 2026 11:43:42 +0100
Message-ID: <dd1d5b341323d6e0f93057c214adf4fc51c3cbd1.1769509131.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1769509130.git.antony.antony@secunet.com>
References: <cover.1769509130.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253808-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,secunet.com:email,secunet.com:dkim,secunet.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 810BC93046
X-Rspamd-Action: no action

Add descriptive(extack) error messages for all error paths
in state migration. This improves diagnostics by
providing clear feedback when migration fails.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v4->v5: - added this patch
---
 net/xfrm/xfrm_state.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 88a362e46972..2e03871ae872 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2129,15 +2129,21 @@ struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
 	struct xfrm_state *xc;

 	xc = xfrm_state_clone_and_setup(x, encap, m);
-	if (!xc)
+	if (!xc) {
+		NL_SET_ERR_MSG(extack, "Failed to clone and setup state");
 		return NULL;
+	}

-	if (xfrm_init_state(xc) < 0)
+	if (xfrm_init_state(xc) < 0) {
+		NL_SET_ERR_MSG(extack, "Failed to initialize migrated state");
 		goto error;
+	}

 	/* configure the hardware if offload is requested */
-	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
+	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack)) {
+		NL_SET_ERR_MSG(extack, "Failed to initialize state offload");
 		goto error;
+	}

 	return xc;
 error:
@@ -2161,6 +2167,7 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
 		xfrm_state_insert(xc);
 	} else {
 		if (xfrm_state_add(xc) < 0) {
+			NL_SET_ERR_MSG(extack, "Failed to add migrated state");
 			if (xuo)
 				xfrm_dev_state_delete(xc);
 			xc->km.state = XFRM_STATE_DEAD;
--
2.39.5


