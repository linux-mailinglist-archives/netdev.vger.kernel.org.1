Return-Path: <netdev+bounces-276342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEimB1wO1mmfAwgAu9opvQ
	(envelope-from <netdev+bounces-276342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:14:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DB23B8D58
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0554302DF5F
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C83839BFE3;
	Wed,  8 Apr 2026 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8pq8H+5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515C39B958
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635814; cv=none; b=f0ZSMUF2flFuE7fGkeRGUF7ItQFN4B66zb6nFFI+iV9mgOGaIq4RC2Yl3NkhAYSqpHiZMqS2N+hXkjqHqXZETzHvM3oFMYoRWGxNSL2AbPnI7u6ul4g0hXJnffZ0kFfOuSfzBBkfOvIid57KpVMbKLrMFduj91JEtbGXtq7oqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635814; c=relaxed/simple;
	bh=8RvzoVcB6Zt/BgetcFZrinBZBPZ1Bk7IELss8ULC1Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L3+MeCWxtaxtoBDfAKVx6fFhmwRpK8Kgf9xIcl8iHYZuIuoJkOM6Gra50w5AaV7PXdPD0QGNqPtY1z/I32g0tsvS8bPpiQG7AwK4Ut+9WLi9IFo6n58hyJIZYkjoCwis6KWl7eT5foFp3t2bfeJMK8tSNq5liCF0CD9VlVeppEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8pq8H+5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-358ed696623so2605252a91.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775635812; x=1776240612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ltBM8UmKdiKmSJncXBXuq9PCJZyjGT4jg7mXF5Aup5w=;
        b=S8pq8H+5dg0Kt/Tib3oKrZCRjABR3zOBcP5T+PScyW/5X8RUfflz0Wu7rwUemAskyS
         zqaT/v7ttajh44WmgQhCQNYPnTtWRaEg1Vu5FVGBH/eHLbGAgN7vhtjSTQmZ94iwL2vK
         mXba70OeNo1LAfzKmx5Owu1ST5ymH807g6ambSdBY0Oex7DVBlIFRVvWtVhPDAVDI8Ms
         4ssYHeQq59dePWIlPUbTULdHS3iBGgP4mcUhi1218/Ad/Wv7gqnZnKqL20QD26Jm4YZd
         U1FD6L/bxNnY9C61opS7T9PuVd6meHj9HmHj9Ff1sDiOOfyUSskm/sMp3bz7/D8n5b+P
         J67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775635812; x=1776240612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltBM8UmKdiKmSJncXBXuq9PCJZyjGT4jg7mXF5Aup5w=;
        b=pMitIDd3eshY0ZmYRkYc1T/TT0jQMBFG/RdgANPLUPVfsVeQgUJBVtDfZVHrdrih1A
         JcdjrJ8a3QRZ7vPcPGsinpmpvOgoEPlsCvZen3ZAW6wAMsqrcojvUYFBi0+x1AqDvJ71
         5ZCLcmo4h1qRnjJLT3fgGYUCO6Ra1EMTiioN8oP9YHHOKt10vN+X2GqJM/kwWbDm0VZT
         pr9T/dROol1GoxZp0uhcSl17/LPBBsUyBnW9qSLHjoT0vYZqw06qYmH9ZczNSRK8ihGT
         omwLZaI7pIANOpO/5DngZR7U9ala7QDX+qBCzFDOdkCVElZd1ErGY+4X9dnjk2KQby/L
         Xaag==
X-Gm-Message-State: AOJu0YyiE8t+Ruqg7IXtaMXixOCUCCvEfsAqJkuzIgJi7QRW5CO5+TUn
	WSrA20gc0fGDtEgv/DH90KLfqagQcNsFREK4SYtGJ8lFS1+RT5c3PCuQd+GvVcdhmyQ=
X-Gm-Gg: AeBDieuzU0heLXji2WFHVe1J1hsI+TZQ7rq2dObSVz8y5YKPEbEHu5FeiVtjhb26OYb
	24XL85zeUqk9Az3CMoC+u79irEFHJ3FnMXRlJfFdZu/iuny7O6+GGyz1tCrz899o4IArfk8CGRW
	28K/LTE7NvQAhzlCqA4wYjMWr3DfHrDEQwk3jiEBILhFacMFxZhdOc/zpktILl9PiiuxoBC+mjv
	Dl7RE5FQTtyQsoBDfq9+8z1Xo6Q4DCHsDhY7bhn22e0ZOVvqmPgNlA8hW2tjQp4KGL/r9lL1JQR
	69Uuonm5nOEu90Tc+N5LawB2HN3qF+iXrxSDEZ9/Eq+YAYyVCNEt2RtutAs01EmsNLa2p/9pyn1
	SOP6CUFljpEGnbcfbu1Rui3SuNLjoGHB9ldENBXJS4yOhix8h7dU2Im2peOQ+PMdeNjJYnIViS2
	+9kXe7+WzMrhUSPijN7Q40YN3FtJ/eTZAEfh9DjDE=
X-Received: by 2002:a17:90b:2e46:b0:35b:96bb:47b9 with SMTP id 98e67ed59e1d1-35de68d5e83mr18655320a91.19.1775635811950;
        Wed, 08 Apr 2026 01:10:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:250:3007:3:9ce2:e058:5819:7b4f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e288bf78fsm856974a91.4.2026.04.08.01.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:10:11 -0700 (PDT)
From: Junxi Qian <qjx1298677004@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net] nfc: llcp: add missing return after LLCP_CLOSED checks
Date: Wed,  8 Apr 2026 16:10:06 +0800
Message-Id: <20260408081006.3723-1-qjx1298677004@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276342-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[qjx1298677004@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64DB23B8D58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In nfc_llcp_recv_hdlc() and nfc_llcp_recv_disc(), when the socket
state is LLCP_CLOSED, the code correctly calls release_sock() and
nfc_llcp_sock_put() but fails to return. Execution falls through to
the remainder of the function, which calls release_sock() and
nfc_llcp_sock_put() again. This results in a double release_sock()
and a refcount underflow via double nfc_llcp_sock_put(), leading to
a use-after-free.

Add the missing return statements after the LLCP_CLOSED branches
in both functions to prevent the fall-through.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
---
 net/nfc/llcp_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 366d75663..db5bc6a87 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1091,6 +1091,7 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	/* Pass the payload upstream */
@@ -1182,6 +1183,7 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	if (sk->sk_state == LLCP_CONNECTED) {
-- 
2.25.1


