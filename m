Return-Path: <netdev+bounces-296457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1W9NHBWTJmrWYwIAu9opvQ
	(envelope-from <netdev+bounces-296457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:01:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCB1654D14
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:01:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="atFgO1 o";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296457-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296457-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8DB530610DA
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 09:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8153C5DA1;
	Mon,  8 Jun 2026 09:55:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C5C3BAD81;
	Mon,  8 Jun 2026 09:55:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912553; cv=none; b=BEefyEZLo1QoUar9lEP2f9bs+qu30KnaHmTo3dYpd/HnCUrVHcnhDi0lOYyUOVS3YOE/y/88xVyxQ1TdNOGHZ0pQGG7EtE6hI/AKn/m4pygPjTtWupSgpJ7jp3M9KVNuuORcH8k7ZsXKjeZu/r+8hWNWZKHG46ZD5u+jbDebh6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912553; c=relaxed/simple;
	bh=AG91LVFKrnjtOz/RM2dzsnum4L+mA8LSiQ7Vi+clvrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gcmBhgwmIXKegDJ9YtxSA5rtDHCa2AgRiwy/N0UQADGOt99OAi5utyd3obWCWZtQ6/iMMkbMTtHWtn5Ygyftra4SOkHuwaD2DqKRcxvYVk2FnDrPbygrsb+eWfg9mnBBfHwyGKImmQQ3yNF6DMHOtfjFup4a622CZOdzCvhu2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=atFgO1of; arc=none smtp.client-ip=185.226.149.37
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhs-00BS1t-Es; Mon, 08 Jun 2026 11:55:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=AhJnsDP0GCsdnC0Lo/DknR/Iko2rDvI1Tbhf06iuXdw=; b=atFgO1
	ofoaFoPpCIp/yQFM2WLiq5pAlIleWr1hBI2ni2edWlNYdsdTEsjQGOJQ6pogT78pG9IDVR0LeuAi7
	dVJ5VbI5ZNQ6t0cUhFo5ItuBmCVdF0A2siWQvSbRDOJ1T7JPeH/JCz1/Jiasu8Mkrf16fP/td5cfa
	xZPXtNUhkNOwWf0GXuL1biXVC5mNTW9kJaTatvt4DnuLUjpqJTo0sKnelKEa9oycx+7EdWFS2aOJb
	xIPG0mef0TJ/4mET2wRP1v7cVnjtlLCOLghsWFRyMGV8oxg6iMbpC1yoiMv/LhW1U/Pfp1mlI2rh2
	XKL+O6zO1fAaL0UQefuaiFYTRyBA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhr-0000I3-KM; Mon, 08 Jun 2026 11:55:43 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhg-00Ag6G-Ic;
	Mon, 08 Jun 2026 11:55:32 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: Arnd Bergmann <arnd@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Maloy <jmaloy@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] net/tipc/bearer: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:55:01 +0100
Message-Id: <20260608095523.2606-17-david.laight.linux@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296457-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:arnd@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:jmaloy@redhat.com,m:pabeni@redhat.com,m:david.laight.linux@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,runbox.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CCB1654D14

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

 net/tipc/bearer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index a3bd1ef17558..d68744e253e2 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -209,7 +209,7 @@ int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
 	if (!b)
 		return -EINVAL;
 
-	strcpy(name, b->name);
+	strscpy(name, b->name, TIPC_MAX_BEARER_NAME);
 	return 0;
 }
 
-- 
2.39.5


