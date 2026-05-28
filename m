Return-Path: <netdev+bounces-292592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLtgGq/6F2oWXwgAu9opvQ
	(envelope-from <netdev+bounces-292592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:19:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FDA5EE730
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3C803008D55
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4E937882E;
	Thu, 28 May 2026 08:19:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F7C377EC6;
	Thu, 28 May 2026 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956395; cv=none; b=jG8seQvchLLtTsbGhTwCI2K3sGDZiJQKmrQxCj3zubd+6CBvyFu35Jc71DNKacCgSS/VMRocbvGKRlNDyorlnZB/EiUz5+SILEXFwluZ0TdwUPMcSxd7JxTJRy7kZ6oqMbPGJhetLG4Aqo4yGPoV8eWJAAG/7tiGMC+v1yLsdOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956395; c=relaxed/simple;
	bh=Mf1aN3Zacoq+faK7m54zAYktA3WIIOyBi1siCpda6E0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IIru0XcVKxpRfDdpkuTvKm1s2cX8JuKj8rdzrge0QAK2NpVbCqr1c9wZxj4utdHoA6cBqOmbeXOgJH4VUwhUSaE+n1pNINVPAEUz17srMN4MRp9m4Fu7z7SbnHICS2DTk7+PQj/wk0FEMRVBRxIYGqlyWKyiJRxTu0/SwcPeOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fc6074005a6d11f1aa26b74ffac11d73-20260528
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:36a78eb0-f564-41c6-887d-22655cf4fbb4,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:5aca2b057ea4ffb847db433b823f895a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:1,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fc6074005a6d11f1aa26b74ffac11d73-20260528
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1044439411; Thu, 28 May 2026 16:19:45 +0800
From: Bob ynn <yanlonglong@kylinos.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com
Cc: joannelkoong@gmail.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bob ynn <yanlonglong@kylinos.cn>
Subject: [PATCH] selftests/net: bind_bhash: fix memory leak in bind_socket
Date: Thu, 28 May 2026 16:19:19 +0800
Message-ID: <20260528081919.841-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-292592-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[yanlonglong@kylinos.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 86FDA5EE730
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: bob ynn <yanlonglong@kylinos.cn>

The getaddrinfo() call in bind_socket() dynamically allocates memory
for the result linked list that must be freed with freeaddrinfo().
However, none of the code paths after a successful getaddrinfo() call
free this memory, causing a leak in every invocation of bind_socket().

Fixes: c35ecb95c448 ("selftests/net: Add test for timing a bind request to a port with a populated bhash entry")
Signed-off-by: bob ynn <yanlonglong@kylinos.cn>
---
 tools/testing/selftests/net/bind_bhash.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/bind_bhash.c b/tools/testing/selftests/net/bind_bhash.c
index da04b0b19b73..2bd100777448 100644
--- a/tools/testing/selftests/net/bind_bhash.c
+++ b/tools/testing/selftests/net/bind_bhash.c
@@ -52,18 +52,19 @@ static int bind_socket(int opt, const char *addr)
 		err = setsockopt(sock_fd, SOL_SOCKET, opt, &reuse, sizeof(reuse));
 		if (err) {
 			perror("setsockopt failed");
-			goto cleanup;
+			goto err_free_info;
 		}
 	}
 
 	err = bind(sock_fd, res->ai_addr, res->ai_addrlen);
 	if (err) {
 		perror("failed to bind to port");
-		goto cleanup;
+		goto err_free_info;
 	}
-
+	freeaddrinfo(res);
 	return sock_fd;
-
+err_free_info:
+	freeaddrinfo(res);
 cleanup:
 	close(sock_fd);
 	return err;
-- 
2.43.0


