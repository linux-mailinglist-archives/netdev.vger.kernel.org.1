Return-Path: <netdev+bounces-284193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOM2KbJz+Wn78gIAu9opvQ
	(envelope-from <netdev+bounces-284193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 06:36:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6374C670C
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 06:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17D6B30125BE
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 04:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC193B8D41;
	Tue,  5 May 2026 04:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="NDjb75bT"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5F35F5FE;
	Tue,  5 May 2026 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955649; cv=none; b=WgZ5ZGEYdmnCsYLFHtpiufY7RhcQvsUVtg+QAGJQcBBAy7cWuhk6ZgJ9xi63eRhfctvVv4ttfV6bw1fE51jmOJV5GimpkBdSQu5AncPQAaHfjZocxVF4DAHSETdQTzTzepkrH0v+p2/kDFlQFU/AFfbUFHrSpyHeXyG8AyNPi4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955649; c=relaxed/simple;
	bh=GEgcwQSivjEmA9c1faw8oiTdUx0iQD86pdf1wqOTzRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTPJxmlNyTV/DJeycMvGvTyNI1Rf7DHoN/Q0gZK189MWUvxynXYNy9hKIFfEY6s1DFo5bFpLZOBq74B4yp1gzIwm2qTGpdZpBLCtn3BJEmiZ7ztD/u9citUHQrFjSyuWR0JkIn6E3+esibpN/gOTR5ncSpuAvzKq+KBvSI2VsW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=NDjb75bT; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 41C31206E9;
	Tue,  5 May 2026 06:34:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AZpULGyUdYY8; Tue,  5 May 2026 06:34:05 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9E75020049;
	Tue,  5 May 2026 06:34:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9E75020049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777955645;
	bh=apXyL2JPhsOMYPnDTtlAKoQzmWK51ZwYMi27gCWRk3Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=NDjb75bT/I0u07S5Pt10j7ny+4VOrXMtnjRFZyXhKYBkB4dwWbrCxJ7Ci9jVcq7xR
	 ona+TrNCEwkAcp1gvxhPnzGJ2Is8zsR4NZshbq9AGkXzJTbcoJzy1Ce6det8KENJzn
	 XxI7FxMu5hFR/N6kJhWcveZH0yk3PSt4GGzO6KGOI660vgjlnkXhlrx0dibHf777m4
	 BDRHFwlpToEMl5Si2EYRNkVG1/EmngbOc0ezxa4lizujPjoiUFCQeiR/BtO0vhgSlj
	 H6V0ej2JkYwt6pDcu4V3U84+zLuihZ/uygRjNH35ZOPdL44kwGPf23c3UO5ZBDgfJG
	 U0XTebjaYSc8w==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 06:34:01 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Masahide
 NAKAMURA <nakam@linux-ipv6.org>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek
	<omosnace@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Chiachang Wang <chiachangwang@google.com>, Yan
 Yan <evitayan@google.com>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next v8 09/14] xfrm: add error messages to state migration
Date: Tue, 5 May 2026 06:33:49 +0200
Message-ID: <migrate-state-v8-9-4578fb016965@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-v8-0-4578fb016965@secunet.com>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Queue-Id: AC6374C670C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284193-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,linux-ipv6.org,paul-moore.com,gmail.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,secunet.com:dkim,secunet.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

Add descriptive(extack) error messages for all error paths
in state migration. This improves diagnostics by
providing clear feedback when migration fails.

After xfrm_init_state() use NL_SET_ERR_MSG_WEAK() as fallback for
error paths not yet propagating extack e.g. mode_cbs->init_state()

No functional change.

Signed-off-by: Antony Antony <antony.antony@secunet.com>

---
v5->v6: - in case dev_state_add() extack already set
	- after xfrm_init_state() use NL_SET_ERR_MSG_WEAK() as fallback
v4->v5: - added this patch
---
 net/xfrm/xfrm_state.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index fcf6f0c6400d..1db48ecda80d 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2130,11 +2130,15 @@ struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
 	struct xfrm_state *xc;
 
 	xc = xfrm_state_clone_and_setup(x, encap, m);
-	if (!xc)
+	if (!xc) {
+		NL_SET_ERR_MSG(extack, "Failed to clone and setup state");
 		return NULL;
+	}
 
-	if (xfrm_init_state(xc, extack) < 0)
+	if (xfrm_init_state(xc, extack) < 0) {
+		NL_SET_ERR_MSG_WEAK(extack, "Failed to initialize migrated state");
 		goto error;
+	}
 
 	/* configure the hardware if offload is requested */
 	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
@@ -2163,6 +2167,7 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
 		xfrm_state_insert(xc);
 	} else {
 		if (xfrm_state_add(xc) < 0) {
+			NL_SET_ERR_MSG(extack, "Failed to add migrated state");
 			if (xuo)
 				xfrm_dev_state_delete(xc);
 			xc->km.state = XFRM_STATE_DEAD;

-- 
2.47.3


