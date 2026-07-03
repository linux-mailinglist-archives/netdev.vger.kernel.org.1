Return-Path: <netdev+bounces-304630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wLhuJcbsR2rDhgAAu9opvQ
	(envelope-from <netdev+bounces-304630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 19:09:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C91A7048E1
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 19:09:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=WgYxb3N3;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304630-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304630-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2685830138BD
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 17:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDE630C14C;
	Fri,  3 Jul 2026 17:09:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E7230567D;
	Fri,  3 Jul 2026 17:09:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098560; cv=none; b=icjCLzW7YcAiOt/E0ypyekju4WCDuNM9wkVRA8pL5v31Ejw1zNDmAcYnvo3OxxESSX6vLA5gTQSkQi17kgSCHnsxoCtCIUVtMNR0Fp4ZwO4ZLVbpBX4BfaPCnaCSiMcnVpqaE1yKg3jyvBUHQpK7ic2URjQeY2qVfywWMJ6Van0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098560; c=relaxed/simple;
	bh=7KXBDDGfEDvsUB8sV01FHNGX21r2o9KN+kI/1Wr+8M8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtvlZRtewawlyC6mvBCETpAlgN6aQ0Rt4MmFtAj4GWnul5Ojx4uvEQnfD5NldzRpr7MmbqdbOjoCsVivO1DbZZ1pCqDdzZFpnkH5/c/R1iRzdw0IpkKWo5d3sOZeJPiNt3GnAT3PUfUIYZIp1HwXTnoaYVcQk1p/V3Dp58EH2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=WgYxb3N3; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 61DF7207B0;
	Fri,  3 Jul 2026 19:09:17 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tDbJrJTgnoJC; Fri,  3 Jul 2026 19:09:16 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D78DD20612;
	Fri,  3 Jul 2026 19:09:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D78DD20612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783098556;
	bh=culDFA36StAzYKhWgRHC+fxClLOtoJbt8zYq6Y+4If0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=WgYxb3N3i77VPqWd0ubfG31mcyqBfznx9ReTil05rYGU0H025cAz0PjRrex+V1i5s
	 fxB2zjAWGzAGyDWlTsu0V/hHR/AZYLu4/Dyxn/+M0m8yurzF+OSN+F2zcd0DuG2YYY
	 ubJ60BU+T6PKHtDOIEeQD7+s7gllIbqOeBKBWQ7V0jrfuujnO21jEErM8CjeDu8hJ6
	 FpSJGvnbiiUfv4EMjZUUNPlIgbujae4Cm1RFv6GMn2QbKN2n6aSOXxfhlpdhOkDWaF
	 bTYC5BGZvAnwhkxKrwHTRiwfKXtPFvuOgQ9974bJ1XLuVaOTszETLThH2Tv92zF2TQ
	 qCpl+aNYznWTw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 3 Jul
 2026 19:09:15 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
Subject: [PATCH ipsec 7/8] xfrm: pass extack through to xfrm_init_replay() from xfrm_init_state()
Date: Fri, 3 Jul 2026 19:08:43 +0200
Message-ID: <migrate-state-fixes-v0-7-a69e8637ba3b@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-fixes-v0-0-a69e8637ba3b@secunet.com>
References: <migrate-state-fixes-v0-0-a69e8637ba3b@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:antony.antony@secunet.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:hadi@cyberus.ca,m:shuah@kernel.org,m:sd@queasysnail.net,m:netdev@vger.kernel.org,m:evitayan@google.com,m:tobias@strongswan.org,m:fw@strlen.de,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304630-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,secunet.com:from_mime,secunet.com:email,secunet.com:mid,secunet.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C91A7048E1

xfrm_init_state() takes an extack parameter but doesn't pass it to
xfrm_init_replay(), so replay-window errors can't be reported via
extack.

Fixes: 231a1744dc43 ("xfrm: add extack to xfrm_init_state")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index bffe985e42ea..0b3dc7789dd7 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3369,7 +3369,7 @@ int xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 	if (err)
 		return err;
 
-	err = xfrm_init_replay(x, NULL);
+	err = xfrm_init_replay(x, extack);
 	if (err)
 		return err;
 

-- 
2.47.3


