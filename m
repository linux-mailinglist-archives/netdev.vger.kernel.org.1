Return-Path: <netdev+bounces-267455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD4yClAStGlkgwAAu9opvQ
	(envelope-from <netdev+bounces-267455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:34:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6BD283F81
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EA003293E62
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39533A3E6B;
	Fri, 13 Mar 2026 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="gmFWOMue"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D6398914
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408237; cv=none; b=eQ+cp/fSb3MC+BBq7mLYYEaPlxKIk7qwlVmgdPCu1IQNf7LtqK/ZOuxRP9+OiVimDSTsgRxIg5aW3KT045Yn2ITNVQGpD2CQAaIA/PSEZ0kra1J+8OYH+2CpouquK3W1b4K/2yjtS2qiAuhC80xM6uS22X+ihp/cNzP+x68APvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408237; c=relaxed/simple;
	bh=nZ+k6LwmVTzAEw3vuuHe+hasE2D5fqRByDUONeH3iyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W18jjjkBWKhwMMz9rgCS+B2DpHFbFtOLc9R30JEmdTx+AN8WwrzcLvGLMLLPEGLnqo/0Emb4A7qNPXWn96auC32KX8AU92z02rzk8HK2tUswLrRJmmgNCZQ1ai2u7c0P4gzZ1zXJfkldJbsHDokutAzXOTKoCV/R/BDaVMTsFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=gmFWOMue; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1271257ae53so3313426c88.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1773408236; x=1774013036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTmBFIgmTmliDvtg+vbiajCTqXtJ+XpWwf8ulZ4sMAQ=;
        b=gmFWOMueFqJt7Vv2JNCkya42Qirwk/73yZbgt4Ee8sRjdXGri8SNkA9em1MCO+ImvW
         Hmzv8Zz3xCTeMF75DTAaTAkHaEwLgfa4fDT8txR4xZXduGUykPixTNjRHepXDrJWKxGh
         oeQuq5JofEBXjaCNO897N1rW0imSvBlOYO4JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773408236; x=1774013036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kTmBFIgmTmliDvtg+vbiajCTqXtJ+XpWwf8ulZ4sMAQ=;
        b=UNVl3SMBm0WVrYXsMgNnqrVY9BGtDy4C9+FZ6AHzFuPGvIEgEOymRty7MBiZ0AzFIy
         nMA421ZCy19pao5QnrZlSoOkuXXrsEBQEjKcwtFHhZZmFdOT9nmPi7weGuVek0E0q8S+
         9QoZpNhb6JkaMSfohW29e58i1BxATYe3KHGoDfdUWTtrpXCtGmhhPSDzUg/d3aBIpOHu
         xHTFDhB2f/E5/kZyzOeyid6CpNuKqX5BCBQEG5vcA52wJu4RcivZfdkB6kFp4xQpOmyH
         yRZVQrgDkwRE5worNj1kBzidh755YSu7VomFiz0g3n2mzBPDCfV+oLK1NM8ZC0FLHa1y
         XnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXUBZtCwJimdJubZDYch5SpMg+ZMKuq171mBxZc69EDY2MBaHSNBaBYXqL9dK1FKRQiQxam8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg8ZSua1xmZ8BAI2M0G2tVsxzD5LZQxlyqFvdArM7iafN3j5na
	+3Sp7IjSa705R0nAfBU0zgOq/Y/qobPuPd3ARq+fzSLOp5ERWRkqPZTJSUI6HxW323A=
X-Gm-Gg: ATEYQzwam9J3jLvX61lkGxCxr+5bM/unXcS6aZOnonDmLePqXfwDuvSesmA64OUXtgq
	Y3jS36+1HtrR4z3SnHSJZklfcWTDyuc3k9IDCxlOdRq6ILcDINr1/uaFFvzwb58pF5BcVGU+lwk
	P91oZUgudFSKdudtrkSmSd9HOxC7g5LNEfu+VroTXolmuDZ32RS2maDaoZW3azIvg5ZX4pKng2q
	1h/y5QR3FZ/1HXIZtBjEudoo800X0JL8NITitkM2KwV9K9CKQuapnjTk+gK/vyf/vkrta6rSq4N
	I4tYADK9eUJhPz8+4Gsh0m7qxFOB0DEXn1afHbR0SrlB8VPfFlpcrhxsdmU+BLaCVHVFbu5iRbc
	Aia/eiSqrW68WMoSQVVCrD5wSwWn18qCvvgZIirvqHpDWhlN5aGVAAXCTwudunn5xxm9um4lXkd
	jEfhv6fsoihDW/2sSr+SiThsMbrj0=
X-Received: by 2002:a05:7022:618e:b0:127:35af:1446 with SMTP id a92af1059eb24-128f3e0ea27mr1436102c88.36.1773408235593;
        Fri, 13 Mar 2026 06:23:55 -0700 (PDT)
Received: from fedora ([179.105.152.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384f6csm1846358c88.9.2026.03.13.06.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:23:55 -0700 (PDT)
From: Anderson Nascimento <anderson@allelesecurity.com>
To: dhowells@redhat.com
Cc: marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anderson Nascimento <anderson@allelesecurity.com>
Subject: [PATCH 2/2] rxrpc: Fix key reference count leak in rxrpc_alloc_client_call()
Date: Fri, 13 Mar 2026 10:23:27 -0300
Message-ID: <20260313132327.409785-3-anderson@allelesecurity.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313132327.409785-1-anderson@allelesecurity.com>
References: <20260313132327.409785-1-anderson@allelesecurity.com>
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
	DMARC_POLICY_ALLOW(-0.50)[allelesecurity.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267455-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.0.212.49:email];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,allelesecurity.com:dkim,allelesecurity.com:email,allelesecurity.com:mid]
X-Rspamd-Queue-Id: 7C6BD283F81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When creating a client call in rxrpc_alloc_client_call(), the code obtains a
reference to the key. If rxrpc_init_client_call_security() fails (e.g., due
to key invalidation), the function returns an error and destroys the call,
but fails to release the reference to the key.

This leads to a reference count leak, preventing the key from being
garbage collected.

Before the patch

It shows the key reference counter elevated. 

$ cat /proc/keys | grep afs@54321
1bffe9cd I--Q--i 8053480 4169w 3b010000  1000  1000 rxrpc     afs@54321: ka
$

After the patch

The invalidated key is removed when the code exits

$ cat /proc/keys | grep afs@54321
$

Fixes: f3441d4 ("rxrpc: Copy client call parameters into rxrpc_call earlier")
Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
---
 net/rxrpc/call_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 918f41d97a2f..fbfcc611a2c4 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -227,6 +227,7 @@ static struct rxrpc_call *rxrpc_alloc_client_call(struct rxrpc_sock *rx,
 
 	ret = rxrpc_init_client_call_security(call);
 	if (ret < 0) {
+		key_put(call->key);
 		rxrpc_prefail_call(call, RXRPC_CALL_LOCAL_ERROR, ret);
 		rxrpc_put_call(call, rxrpc_call_put_discard_error);
 		return ERR_PTR(ret);
-- 
2.53.0


