Return-Path: <netdev+bounces-265700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EwviK+kVr2nHNgIAu9opvQ
	(envelope-from <netdev+bounces-265700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:48:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2493623ECCF
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0291B30C09DB
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 18:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A633ECBFA;
	Mon,  9 Mar 2026 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="R3+a195b"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92013ECBEA;
	Mon,  9 Mar 2026 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081957; cv=none; b=SheInSRxKy3zddlhq9+1QKFeaC2K+JA4rfQr2SuK/cYYhgqUH9EhafxfA6sKk8Bz9bOm2SDdiJzvnwHwxNuQX3Cx7emuZ7V/Cz5Hts8b001rJhmzTJ9tjkja2GcOJLUP63rX2oAtXe1eYKHpfS7f7c/47FYNsJBaiZ8r0We1JRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081957; c=relaxed/simple;
	bh=Ilc0cZ4ZdMcO9ZbhLSwBoRO6ZeOpJyHVCLVkXaLuurM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UF1bA7tSJaIKg/jgTlR+zy6DmJOv3dGBy22vzKq8wyDkm5pm+iL7+XNJiJxGKCZr9NeTIdsgtp0FvzM//vTAr+yYgMNFSOQJU+QyvxKAmNaYdWHdqiT66LT/3IyxdfY/jXep4kthb6u9LAqOBQKPpdA1zOkNtUmt3SZLdbQzkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=R3+a195b; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7A38D206DF;
	Mon,  9 Mar 2026 19:45:54 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZUEzoKh_hJox; Mon,  9 Mar 2026 19:45:54 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E4887206D2;
	Mon,  9 Mar 2026 19:45:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E4887206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773081953;
	bh=fTTx/UWXnuTyYhpaDBxeCcxbUeejTWlcGCeniaDAIck=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=R3+a195bQi4xZVw+hrCebIoOpacsAS4guunHcOaaZs69SFRuc/6o05d8z2yJrgA9L
	 qwsraNs53GP/Cnq6zljTQFQU4zFKCCO6RXvJ6H7KyvvWKbhdxD3y3KJFAJahIwVBmj
	 llwxURZxTp36n4KLvR491uqQovw9xOAmX5Gzrhnz09c4ZT2JKrajZ8tU6S0OhEHtD8
	 fY7WnMNI2/OaHfIhdQj26IRnZ1npjzj3EHzUBAb7q52fM1V/9WV4jKl3MkQTa0kQUV
	 WJq5jVQF2deNYADWBzCXcNOsNsUimqNItmZj2mVpeOEYBKPi6LkxQqGmVzOgDOsFfn
	 we6S38oVPzXHA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 19:45:52 +0100
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
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<selinux@vger.kernel.org>, <linux-doc@vger.kernel.org>, Chiachang Wang
	<chiachangwang@google.com>, Yan Yan <evitayan@google.com>,
	<devel@linux-ipsec.org>
Subject: [PATCH ipsec-next v6 03/14] xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
Date: Mon, 9 Mar 2026 19:45:41 +0100
Message-ID: <migrate-state-v6-3-9df9764ddb9e@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-v6-0-9df9764ddb9e@secunet.com>
References: <migrate-state-v6-0-9df9764ddb9e@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Queue-Id: 2493623ECCF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265700-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,linux-ipv6.org,paul-moore.com,gmail.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:email,secunet.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The current code prevents migrating an SA from UDP encapsulation to
plain ESP. This is needed when moving from a NATed path to a non-NATed
one, for example when switching from IPv4+NAT to IPv6.

Only copy the existing encapsulation during migration if the encap
attribute is explicitly provided.

Note: PF_KEY's SADB_X_MIGRATE always passes encap=NULL and never
supported encapsulation in migration. PF_KEY is deprecated and was
in feature freeze when UDP encapsulation was added to xfrm.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_state.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 86f21a19a0eed04325b2ea26b5fe4fbb3527b2e4..20ebd10dbee5cf0ee29c81c9cc3839fb031597c2 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2008,14 +2008,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	}
 	x->props.calgo = orig->props.calgo;
 
-	if (encap || orig->encap) {
-		if (encap)
-			x->encap = kmemdup(encap, sizeof(*x->encap),
-					GFP_KERNEL);
-		else
-			x->encap = kmemdup(orig->encap, sizeof(*x->encap),
-					GFP_KERNEL);
-
+	if (encap) {
+		x->encap = kmemdup(encap, sizeof(*x->encap), GFP_KERNEL);
 		if (!x->encap)
 			goto error;
 	}

-- 
2.47.3


