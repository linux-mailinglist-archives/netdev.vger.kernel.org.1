Return-Path: <netdev+bounces-296451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BpvMMGWTJmrlYwIAu9opvQ
	(envelope-from <netdev+bounces-296451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:03:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21559654D3C
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:03:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="XfdPRi 1";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296451-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296451-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83D8C306E2A9
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 09:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26A93BCD3C;
	Mon,  8 Jun 2026 09:55:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24503B895E;
	Mon,  8 Jun 2026 09:55:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912550; cv=none; b=LmmnoWhUx5C4oiHIp2AOUx8rCEEHtg9+/5SQJUSPN15XuyPtQPvGYGKLbe46mHwvZSuz6XnVKfyCQIC1UFuEBEa6D33mV/YZWwljR+ndUnocHVMXgAklmrXmbIxsydd1dnhGT33toAec1Dqht04973QHY01ZQcD4u195lI+QqoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912550; c=relaxed/simple;
	bh=Sx4Ze7AgX5RJCC8XRCD64N/GIkt8A6C2cwwFknSZMa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qPIH5McdbxCvpfOYb6LbANgfX2JKZKu5U6g3XYDppAltOvpt3kyFaSVLd5PxerhMPr9QVJ8kxPtLBeN8+/RIPnvbgYs+kdPd5fDvWiGyoxF4kJLiM5xUoIv3rvh/daLrcjkW4EzwR5sQSuzGfjRqQiTze8Uo6vEVnzF5rd/F4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=XfdPRi1k; arc=none smtp.client-ip=185.226.149.37
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhr-00BRz4-0g; Mon, 08 Jun 2026 11:55:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=MEGRMbuHpposeCciz6uVAu3BRF1Ammi62WRqbPW3TPk=; b=XfdPRi
	1k/72dcTjk4m/Bgp0cm2XtwE5qP/bkGx+ZcxIfZ2d09qb/yDuxDou4E+exWgQggybZTmAj1s1P9Fd
	AgUX07kkvGBBZPOtz9XxhtC8oySm/pSfQuUkfLVTEdcz/Nj2xrwvUKMJ1czcNPwjGtJdM9Da4m9TF
	x7g3xvtDOBUxt5Z/Bs4PJWM+84G0rWAo+rxcJNS5BmfWmFRJyJO3OdS+IknYS0jvER7ebyg16yEY/
	SSfJU0iAeDqenYWJkRpWY02UCw2x1TPcB4ZAhcKGKs8soJt3LUiIRBTXBKRZqLhFPPr3RQS27XClc
	gjItoyXB6LA0S4oxnOn1CJJQbXnA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhp-0000GY-So; Mon, 08 Jun 2026 11:55:42 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhf-00Ag6G-4O;
	Mon, 08 Jun 2026 11:55:31 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] net/key: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:58 +0100
Message-Id: <20260608095523.2606-14-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296451-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:arnd@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:herbert@gondor.apana.org.au,m:kuba@kernel.org,m:pabeni@redhat.com,m:steffen.klassert@secunet.com,m:david.laight.linux@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,gondor.apana.org.au,redhat.com,secunet.com,gmail.com];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[runbox.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runbox.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21559654D3C

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures that overflow of the target
buffer cannot happen.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 net/key/af_key.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index a166a88d8788..625822d19071 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1195,7 +1195,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 			err = -ENOMEM;
 			goto out;
 		}
-		strcpy(x->aalg->alg_name, a->name);
+		strscpy(x->aalg->alg_name, a->name);
 		x->aalg->alg_key_len = 0;
 		if (key) {
 			x->aalg->alg_key_len = key->sadb_key_bits;
@@ -1217,7 +1217,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 				err = -ENOMEM;
 				goto out;
 			}
-			strcpy(x->calg->alg_name, a->name);
+			strscpy(x->calg->alg_name, a->name);
 			x->props.calgo = sa->sadb_sa_encrypt;
 		} else {
 			int keysize = 0;
@@ -1234,7 +1234,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 				err = -ENOMEM;
 				goto out;
 			}
-			strcpy(x->ealg->alg_name, a->name);
+			strscpy(x->ealg->alg_name, a->name);
 			x->ealg->alg_key_len = 0;
 			if (key) {
 				x->ealg->alg_key_len = key->sadb_key_bits;
-- 
2.39.5


