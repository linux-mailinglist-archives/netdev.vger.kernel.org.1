Return-Path: <netdev+bounces-270420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNEGGKv7wGkwPAQAu9opvQ
	(envelope-from <netdev+bounces-270420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:36:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 622392EE53B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 863EB30095E2
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7B7381AFA;
	Mon, 23 Mar 2026 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="SrpTezx0"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90652381AE3
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254913; cv=none; b=UkvxDH5qo+/+4bkQV9u29lJGvJRlJDwv2tdeDBmXyUDPWmEfvWbyIffKfDNP9j2cS9zDri6FLMxV/ohmpmgTXzv+U5XE/PGzVC1i0mKCyyxFMqy+hdPm2aI1MJ+HaTugjkUMgE+/VNapo14158wLrRr7wd3y33DYS6wSROzYmcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254913; c=relaxed/simple;
	bh=RcKuRVyp3dUtno6BvOktjKlMB6frsCzSFkWZrig/a6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4gM8I8rE3sUjOUepQv/ZPIV+hYSghq3FuDB/Zqss8WORQnopFSFcHDzdqLoodQ8qrfbxt69rm0YkoDbPtcJOD6WaRydpxQDvu1TM+ruZsFWhtLYJqq9vf2o/fMsagKDZbbiFro1jEV4h3wcfRQgxizpoVGIV+20G816fyaIa3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SrpTezx0; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6F2C8205ED;
	Mon, 23 Mar 2026 09:35:10 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XopczZD0q50x; Mon, 23 Mar 2026 09:35:09 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7D8982068C;
	Mon, 23 Mar 2026 09:35:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7D8982068C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254909;
	bh=mJTsI8IMj9FroJfRtqXywipM8uM+WciQVPZwEFZLGnw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=SrpTezx0QS0tJMIsZpY5q9O42p5qwx+X/FGXlIARZ/aNHCUUDN7t2VIiqH93lLdct
	 n8Bc+TVpJWcpaZAAXBCwsJkI5l1JffZIKja6AobsiEtmeEncscEEkQgfqmRrXZluOZ
	 mybrIC96rrIWfEtduU0+e7tKEqSU333VX7tnNwSFai99ims8dW/fYamU7jY+S1NSr5
	 M07Bs99CPIj4hDxjJQviewmBfAhieCgZzFihdnSLOis2HorSsjnJ8vwOmjNqPID1pG
	 W9D0oQMrP0cTJwqeTt0THLO5hzes77yxYz0dXyxyZkFM+bNUY1c0CXmny39ehw8D4X
	 rhzdG8TE+JwZw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:35:08 +0100
Received: (nullmailer pid 2741854 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 19/20] af_key: validate families in pfkey_send_migrate()
Date: Mon, 23 Mar 2026 09:34:00 +0100
Message-ID: <20260323083440.2741292-20-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323083440.2741292-1-steffen.klassert@secunet.com>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270420-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:email,secunet.com:mid,appspotmail.com:email,apana.org.au:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 622392EE53B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eric Dumazet <edumazet@google.com>

syzbot was able to trigger a crash in skb_put() [1]

Issue is that pfkey_send_migrate() does not check old/new families,
and that set_ipsecrequest() @family argument was truncated,
thus possibly overfilling the skb.

Validate families early, do not wait set_ipsecrequest().

[1]

skbuff: skb_over_panic: text:ffffffff8a752120 len:392 put:16 head:ffff88802a4ad040 data:ffff88802a4ad040 tail:0x188 end:0x180 dev:<NULL>
 kernel BUG at net/core/skbuff.c:214 !
Call Trace:
 <TASK>
  skb_over_panic net/core/skbuff.c:219 [inline]
  skb_put+0x159/0x210 net/core/skbuff.c:2655
  skb_put_zero include/linux/skbuff.h:2788 [inline]
  set_ipsecrequest net/key/af_key.c:3532 [inline]
  pfkey_send_migrate+0x1270/0x2e50 net/key/af_key.c:3636
  km_migrate+0x155/0x260 net/xfrm/xfrm_state.c:2848
  xfrm_migrate+0x2140/0x2450 net/xfrm/xfrm_policy.c:4705
  xfrm_do_migrate+0x8ff/0xaa0 net/xfrm/xfrm_user.c:3150

Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of endpoint address(es)")
Reported-by: syzbot+b518dfc8e021988fbd55@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69b5933c.050a0220.248e02.00f2.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/key/af_key.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 571200433aa9..bc91aeeb74bb 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3518,7 +3518,7 @@ static int set_sadb_kmaddress(struct sk_buff *skb, const struct xfrm_kmaddress *
 
 static int set_ipsecrequest(struct sk_buff *skb,
 			    uint8_t proto, uint8_t mode, int level,
-			    uint32_t reqid, uint8_t family,
+			    uint32_t reqid, sa_family_t family,
 			    const xfrm_address_t *src, const xfrm_address_t *dst)
 {
 	struct sadb_x_ipsecrequest *rq;
@@ -3583,12 +3583,17 @@ static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 
 	/* ipsecrequests */
 	for (i = 0, mp = m; i < num_bundles; i++, mp++) {
-		/* old locator pair */
-		size_pol += sizeof(struct sadb_x_ipsecrequest) +
-			    pfkey_sockaddr_pair_size(mp->old_family);
-		/* new locator pair */
-		size_pol += sizeof(struct sadb_x_ipsecrequest) +
-			    pfkey_sockaddr_pair_size(mp->new_family);
+		int pair_size;
+
+		pair_size = pfkey_sockaddr_pair_size(mp->old_family);
+		if (!pair_size)
+			return -EINVAL;
+		size_pol += sizeof(struct sadb_x_ipsecrequest) + pair_size;
+
+		pair_size = pfkey_sockaddr_pair_size(mp->new_family);
+		if (!pair_size)
+			return -EINVAL;
+		size_pol += sizeof(struct sadb_x_ipsecrequest) + pair_size;
 	}
 
 	size += sizeof(struct sadb_msg) + size_pol;
-- 
2.43.0


