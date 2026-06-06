Return-Path: <netdev+bounces-296152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1VhUA82DJGq67gEAu9opvQ
	(envelope-from <netdev+bounces-296152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 22:32:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A79164E455
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 22:32:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="tpzfK8 s";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296152-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296152-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6B22302A2AE
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 20:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF61F3D4123;
	Sat,  6 Jun 2026 20:27:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5DB3C3BFA;
	Sat,  6 Jun 2026 20:27:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777646; cv=none; b=QxbehmHx1Bgp6rLqp8Z0LOpPiK/eHJdWnBwdi/l8UAphVPtTH5EXnpCvcNJYi8haH1BHje7shnOiaBUomo6nHu4RA+AGREgG7btEb08YTSa170uMP7eCMz4FfDKx6IJOj+OKShp9TkrcN6voL8z0PSN8X6kQXoez3+jesaVvaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777646; c=relaxed/simple;
	bh=tHQEQrPxlubWISHX02zXpkKqs7TtIMm13+hU8WYJMOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N8Im7psRFFWsXDt6YxoD9pNV5y3vRRMMstyNXcfVzkw+gaVfCIcukPEmhPyoo4kEdHKqHR8wuwY4Z2Cl0UmUACVgePLSA0myt95QipS1ctTaDtHUVyadDTT+ylCfrGueCrfMAZnrfpwY+6Zvk860C8QZwaSvkO8iU3z6oECOrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=tpzfK8sl; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbv-007cHl-U7; Sat, 06 Jun 2026 22:27:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=9gIdnzM+dAgG4gvnmdxAjdZuQXK+gY/bR0bwUb0i+Fc=; b=tpzfK8
	slwFwN9KZk7UmXtXiSkmIv/ImS8D6SQXxDgt9/6Wmym7Zt76I+in+meuBEeJPsScpvXWdkhASAVqG
	ZYidEm1mIIrpCeKlrlqmFj5gJjw8h6cunogj2/C8mi3QzfkUbu2HJhaEWBiuFgWd0KXXucKLcLTe8
	l/BHby6tvnWXvCZHMJ/7kNR7h6KYG1yvcqX6M1uQOcjHvPHtnRHrc3Nppd8hk8Pt8wHyVSMML4b4f
	fOYqA2bAb6/ZvMHSNUJS/8GYDP/mRHvnrgmvQ6nCfYr2ydGEQLGYLqoVBIgfirHjC9RXCaehW3lbg
	If2eIrPkM/YmfMW7ik2DlQ5TlQBg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbt-0005Ct-SW; Sat, 06 Jun 2026 22:27:14 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbl-006V18-4d;
	Sat, 06 Jun 2026 22:27:05 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] net/ipv6/ip6_vti: Use strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:23 +0100
Message-Id: <20260606202633.5018-29-david.laight.linux@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296152-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:herbert@gondor.apana.org.au,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:steffen.klassert@secunet.com,m:david.laight.linux@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,gondor.apana.org.au,nvidia.com,redhat.com,secunet.com,gmail.com];
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
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runbox.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A79164E455

From: David Laight <david.laight.linux@gmail.com>

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

 net/ipv6/ip6_vti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ad5290be4dd6..c6cb756a1091 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -186,7 +186,7 @@ static int vti6_tnl_create2(struct net_device *dev)
 	if (err < 0)
 		goto out;
 
-	strcpy(t->parms.name, dev->name);
+	strscpy(t->parms.name, dev->name);
 
 	vti6_tnl_link(ip6n, t);
 
@@ -1161,7 +1161,7 @@ static int __net_init vti6_init_net(struct net *net)
 
 	t = netdev_priv(ip6n->fb_tnl_dev);
 
-	strcpy(t->parms.name, ip6n->fb_tnl_dev->name);
+	strscpy(t->parms.name, ip6n->fb_tnl_dev->name);
 	return 0;
 
 err_register:
-- 
2.39.5


