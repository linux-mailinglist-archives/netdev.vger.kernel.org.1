Return-Path: <netdev+bounces-293489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGxNEvTZHGqaTQkAu9opvQ
	(envelope-from <netdev+bounces-293489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 03:01:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 962C2618945
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 03:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0819D30086EE
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 01:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB8B15B971;
	Mon,  1 Jun 2026 01:01:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA72D5FDA7;
	Mon,  1 Jun 2026 01:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275675; cv=none; b=CKMapdgTuYnoUzucDG8q/NeL0/Tf+SWAsj7nI1PeeTjV7VTFL3yLsuvGiJsnUYI6h9wjhVY4DsxrlPKFIRVvPu1odZnrh962D97G+I8NezST5+ZeO/UXfV7YDyCNHeCz9fXrlhrrPbsz/OYl3zjUFkMLS4C+4DNrG6qVLMrhrwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275675; c=relaxed/simple;
	bh=VdDacIgbwXmWuXA8GIrc7g15U71VknDUlGPE5f3K/eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6MwDYhxSPJrdeXcJ7cEvnLwA8BXMqWRfRzUzipcnBlcu8VKy1xzu9n2/bB4GH8l1PRRnju+v2TSbnaRwbtsAPX+z3tGgqLscz/I6y4vit36BKvO2JcwPb77+TAP5sQDCiss5fZYjacmFmio6s6U9ZVVqG7geTciL1PDZxs4MUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5a3214b45d5511f1aa26b74ffac11d73-20260601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:90625c39-3129-48b2-902d-29c7749be6e1,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:f432ff75abedca96198ec1fc4468285f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5a3214b45d5511f1aa26b74ffac11d73-20260601
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1585378741; Mon, 01 Jun 2026 09:00:59 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: kuniyu@google.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	joannelkoong@gmail.com,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	yanlonglong@kylinos.cn
Subject: [PATCH v2] selftests/net: bind_bhash: fix memory leak in bind_socket
Date: Mon,  1 Jun 2026 09:00:40 +0800
Message-ID: <20260601010041.1810-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <CAAVpQUBBsOxHjxaisS9Qf4VdxSb6TbLT2HaAE5cgsC3HQ4qohA@mail.gmail.com>
References: <CAAVpQUBBsOxHjxaisS9Qf4VdxSb6TbLT2HaAE5cgsC3HQ4qohA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,gmail.com,kernel.org,vger.kernel.org,redhat.com,kylinos.cn];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-293489-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[yanlonglong@kylinos.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.940];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 962C2618945
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The getaddrinfo() call in bind_socket() dynamically allocates memory
for the result linked list that must be freed with freeaddrinfo().
However, none of the code paths after a successful getaddrinfo() call
free this memory, causing a leak in every invocation of bind_socket().

Fixes: c35ecb95c448 ("selftests/net: Add test for timing a bind request to a port with a populated bhash entry")
Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
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


