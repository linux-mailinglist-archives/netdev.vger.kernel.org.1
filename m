Return-Path: <netdev+bounces-304628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fxrkE5jsR2q3hgAAu9opvQ
	(envelope-from <netdev+bounces-304628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 19:08:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D60BD7048B8
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 19:08:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b="w/yvFOKd";
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304628-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304628-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54C57302A4C1
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 17:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAC830ACE3;
	Fri,  3 Jul 2026 17:08:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9E8233939;
	Fri,  3 Jul 2026 17:08:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098517; cv=none; b=VI0pF7ucS373I3vcke1mqaX19tmOGcWmM8lrl1hVYOOF0Pd1fkGipNhTiBO4e7NRVFuJtvKCHVS64K/QRnV9svCl3C6m5A88P0q5KxLqUDjuqLuMCVUo7QbdfyCEcn0KKP6JdxSDCaAyt2gvV+zv5JbFcayMEO5FMyi/Wbe/aSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098517; c=relaxed/simple;
	bh=kOTVN0YUZSWbyJOT54upD70yX2yEyjP63PqwcKL0Rks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duEpfEzJODozUuT6dkrXlnlsxSJ4iBQeciK/7dfYOkgKv3hkLzcaNUz0gVGA90mbp5XgnsgyFTvNIKUz+Gi92qtXlL8OrpPAeh+EfUqgaE4NLPuDR2B8k9G4Bv2vq1Ide6wXRTvH/1w/CInUEZp44VPPMZfGh6oA0rch2uNFVmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=w/yvFOKd; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 07E1D20758;
	Fri,  3 Jul 2026 19:08:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fJgGPq0NXi01; Fri,  3 Jul 2026 19:08:34 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7E0B120612;
	Fri,  3 Jul 2026 19:08:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7E0B120612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783098514;
	bh=ysNqnKDzY+RnFfgApwbfvS1ufyyGXstfm6FplbjVISk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=w/yvFOKduv0BezRlefzd0T1aEAInnSkoXobDVYSLfKxwVZ6VV5oXPNvCfkD6fjWBV
	 HZhWU98x65T4sgnrUh4xc2uW5hs/YfyijxeAmgY1ep0nfIFWLuVW238SLTNY4znsAE
	 b8I6D3Tn3D1EmzQXCP4Ek6IZGwP+0JcAdMf0NmVmiv1LjUzmDBXjqGHNZiIFWnjH0H
	 znYcrvgvMWjLPWyiF3j7moySpe8xuzwpDUUQkz5QURevLVDVE6tVCWLFqWdJ885u8S
	 Kklx4s4lMoeIe3rfdWasCOq3d7V/7G394hiSpw0REw6k06u5HkSHNBJFqVI4tnNQ/8
	 azUsYW6tIdDsw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 3 Jul
 2026 19:08:33 +0200
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
	<linux-doc@vger.kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH ipsec 5/8] xfrm: fix hw offload state leak on xfrm_do_migrate_state() error path
Date: Fri, 3 Jul 2026 19:08:23 +0200
Message-ID: <migrate-state-fixes-v0-5-a69e8637ba3b@secunet.com>
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
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:antony.antony@secunet.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:hadi@cyberus.ca,m:shuah@kernel.org,m:sd@queasysnail.net,m:netdev@vger.kernel.org,m:evitayan@google.com,m:tobias@strongswan.org,m:fw@strlen.de,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304628-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,secunet.com:from_mime,secunet.com:email,secunet.com:mid,secunet.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: D60BD7048B8

In the error path, the cloned state is dropped without removing its
hardware offload, leaking the offloaded SA entry.

Fixes: a9d155ea9b44 ("xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 29cbdc836cfc..87ef198993db 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3500,6 +3500,8 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 	xfrm_state_put(x);
 	return err;
 out_xc:
+	if (m.xuo)
+		xfrm_dev_state_delete(xc);
 	xc->km.state = XFRM_STATE_DEAD;
 	xfrm_state_put(xc);
 	xfrm_state_put(x);

-- 
2.47.3


