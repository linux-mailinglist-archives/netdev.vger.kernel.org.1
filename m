Return-Path: <netdev+bounces-275681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEADDbv002nToQcAu9opvQ
	(envelope-from <netdev+bounces-275681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:00:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 810023A5F7D
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA57A302F0D2
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5DB38D6BD;
	Mon,  6 Apr 2026 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zhdt7+3M"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF238C2D6
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498347; cv=none; b=guaWmhPq2kX9emrS3jteh1hpTB9e6rV/Zl/BGpo3NH7uJyprcymjVIdgQSdk89k9XjfU5WlsF+MuIV4dSuTSEwv4napv+rLzqtzNSt1i7jX8t97p9c6wVx690hPAZsyd8pti5GoOF/rYDsb3b+CXCDU4ipv7Gf3gfRRFuUmEWlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498347; c=relaxed/simple;
	bh=X5rjy7mqR00+5ilijbVHYlvpgIS2fHz1wGldFo+23AU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bxw/sh4k69PpFXbR1lqQz23HPiqDRfpmt7Drv+LkLdHaF3UtmIMV1mYKbYqNn8LV0RoFxcomcBPYiUjzOkeMp4eeVTxVqxZIKIXErGGf4gG5IKt3OIAsZKlh5wcCGy1P+jdcrLclSA0/my6XWPMkArzMUK4agvaykXUJZr6T9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zhdt7+3M; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775498334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TdEHKp6Sjx6DlhyLwNbUs3hFS5RwtmRESEqCX0Oeqdg=;
	b=Zhdt7+3Mu1mGVN3N5YDIlAC0rWHNnOTMKVOQytXsqWTCGOvtrOZouN5DW3qapDlin21KOi
	RroZ342LAx7kjwSN11uU7eNSEYJizs8ssD2P7FcC/qbe2v/mW0neircZLg7TtvMfsDcirF
	ZVcoLlBN8eh8UJYVckPl3kua6KVWA2Q=
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
Subject: [PATCH net-next 1/2] keys, dns: drop unused upayload->data NUL terminator
Date: Mon,  6 Apr 2026 19:58:09 +0200
Message-ID: <20260406175810.1018681-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; i=thorsten.blum@linux.dev; h=from:subject; bh=X5rjy7mqR00+5ilijbVHYlvpgIS2fHz1wGldFo+23AU=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmXvxjdc/e9elnizT/3U3eurL9yZl/S852hC6O+dKm8+ 5XNyOd+q6OUhUGMi0FWTJHlwawfM3xLayo3mUTshJnDygQyhIGLUwAmwsTFyNBwTCeqXrR1tdTz 2lLWv9+uZhqmnZX9sHlC5E1V7bdJHaoM/0t+XhQM6E2fFHLV3jtSbeejr5Ys5mzuT1Kcb3y+/kz jLgcA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275681-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 810023A5F7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In dns_resolver_preparse(), do not NUL-terminate ->data and allocate one
byte less. The NUL terminator is never used and only ->datalen bytes are
accessed.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
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

