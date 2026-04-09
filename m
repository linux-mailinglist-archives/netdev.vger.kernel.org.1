Return-Path: <netdev+bounces-276869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCsNGwtY12k6MwgAu9opvQ
	(envelope-from <netdev+bounces-276869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:40:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 060303C7251
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0A25303EC21
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DB32FFF81;
	Thu,  9 Apr 2026 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dCdabzY7"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDB03290C7
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720295; cv=none; b=jG6Pu3JdnHpw61EEnJGEotiTDKzZ7eTIYde0zWihIUlCa4/eRVduPJCLK1iVoJ7cGmjsCwNL9Rfp4daNEK6QHf48EiJxgL6iFgWYJwxiSXoQj29y8Cn7eseaTfMYW7CfVVhUQ6/6c5KE11+cKGhDoWajD3DXZ18e3WyX9r/rllw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720295; c=relaxed/simple;
	bh=8xXXIyEyFcsv2WEY6XC1McBLZV1mz4fpXbk4JS0/CGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iV7Jn3CP8DaL3Q8EzpIiyq7U5MLQFmTr0LFfOyuvzzJvkfEisL4C6UDrxxx6teZ2Fme36CvXQ1ZAzJn4PjaGbUm4ZomQR0oJhXYuUySMIfhrXZELmr8MwaARPUH+x5ee5CCxqd5GO3aZQQ7lrbUf0NBoYWL8hJxJj7saGy/WUa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dCdabzY7; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775720291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XO95DJgYuIRiki/em3gJ46nrj4GuCDSSRhhf89cQDVQ=;
	b=dCdabzY7Vtmn2JPhi/tvJjImF+9bugoSmpITqOutVd79xknoN1x2SPvRbo/V6mA3QrDsBX
	gToAaBu2ZMtWsaHTNti5M2XPnkrr+yaVMo2LVRlHnJD23JsbaSG2S1/VgWdRJCy4e0nK/G
	CtRsUWrcn8fSSaFJm30ZYlGDtw4QtbU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tim Bird <tim.bird@sony.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND net-next 1/2] keys, dns: drop unused upayload->data NUL terminator
Date: Thu,  9 Apr 2026 09:37:11 +0200
Message-ID: <20260409073711.57020-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=thorsten.blum@linux.dev; h=from:subject; bh=8xXXIyEyFcsv2WEY6XC1McBLZV1mz4fpXbk4JS0/CGU=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnXw9VXserX9Z8TnZpYa7XZf9+D42wRZ97Y33L5u3T+n vMOZ2zfdpSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEvj1k+CsWs2DhpoXJzmmH S8r/LuKIT6xqWNuafOCc+3k+3eWsNgEM/wuv9beVFMfH7T59SIFvQ4XJ9MqjjyYk7Z97Q1Qo2sf BmQ8A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276869-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 060303C7251
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In dns_resolver_preparse(), do not NUL-terminate ->data and allocate one
byte less. The NUL terminator is never used and only ->datalen bytes are
accessed.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Resending this because patch 2/2 didn't go to netdev@ (Jakub)
Cc: netdev@vger.kernel.org
---
 net/dns_resolver/dns_key.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index c3c8c3240ef9..451247864a63 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -203,7 +203,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 	kdebug("store result");
 	prep->quotalen = result_len;
 
-	upayload = kmalloc_flex(*upayload, data, result_len + 1);
+	upayload = kmalloc_flex(*upayload, data, result_len);
 	if (!upayload) {
 		kleave(" = -ENOMEM");
 		return -ENOMEM;
@@ -211,7 +211,6 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 
 	upayload->datalen = result_len;
 	memcpy(upayload->data, data, result_len);
-	upayload->data[result_len] = '\0';
 
 	prep->payload.data[dns_key_data] = upayload;
 	kleave(" = 0");

