Return-Path: <netdev+bounces-267454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDzgAh8StGlkgwAAu9opvQ
	(envelope-from <netdev+bounces-267454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:33:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6225A283F64
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4494A340332A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F7B39F185;
	Fri, 13 Mar 2026 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="k4Tf30qS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E61B39F188
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408232; cv=none; b=gk3aCsPDlFcfSjDdtCuf0LkShI9LfxE6dggTG3oUkM4+ZWq7VUrm7/F+k8lMqZDa4ZjTJ9syjYsVLmvq4nEnZM2kBCnLFK6MEkWjfZhbIII5zu75HHgBJmsTMZHAqTaPIWzKTeW4tI38LtwqqBKtCM4/oELwmwiYi1CDg0kkNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408232; c=relaxed/simple;
	bh=huAQ5w0293U2jP8iOMKk9KrRIzZccMYrro5S8jiX+kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6HmoRLNXlHlXNNHoU+b6TxciqiBqezLKDM1pA5zdg3gO8xJL4Dzb38Sj57NbFzb0mFRO7IP1AHjx6Nr3RgkgHC5pOKdO/cAaaV2guG9TjZXAMWkFi7dtzgLMykz3LFdR0DTVK6zxaMhjeqwcWS7j0jXJsoVRGdRxERrZD5dlmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=k4Tf30qS; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1273349c56bso3229185c88.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1773408230; x=1774013030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=818LJ2WZpxF8xKN9wdQRxpqq9XKg+wYe4ViVF+2MlkM=;
        b=k4Tf30qSNQ89W/3/PqRHo1Pjr3/s2D2Ul/UYaK0OAMbYQlPmissR/AvZq+egHsH02d
         jFusnzAzXoQ0cIyCUwkz87k9mTaKMs3TDx8TY9aCZH4zuM7wwbPmNKbevQydp+Kcbt77
         2bfbymSEhq3QLfABszaTu8+BtpnELjLkXY6XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773408230; x=1774013030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=818LJ2WZpxF8xKN9wdQRxpqq9XKg+wYe4ViVF+2MlkM=;
        b=XsYrCcQveZwu6UCZt5cPCizC8vEiD9JxOTFPHnbe/TfklT7Sxletsyw/u9cNU37Act
         XKWE2Gs2vwJ4wue3iWeu1d2f+uNhfaDZYFXs5mbBlHoJ93odkEZDXhbkhsAGEJqv3KBl
         WEaAtAESYVwDcPWCLC1G70MS1Fc0zwn3kFOZc/rzdGT66d0pAjtBhFJxyB6gloYWpQNn
         7lBm1J3/7tIie1USl932QVhgxJkRNcA+Bm23jrGaMEXF2G9V5/I297eutO98tFgcm6fj
         IE9kj+Ba93OXpvXcZeJ6e0SjdK+U5n7I4Cd/Ce8Cd1yZDVWZ3ne5X3DXEYZSEJ3DupMJ
         wgUA==
X-Forwarded-Encrypted: i=1; AJvYcCWzQ0JK5i+ZZWCUQWG2s63ditpDMnr5CRCte3pUIePy6AGkPTGy5kwtEDhaj7BB4nHaThc+ZuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyMPfqgettha8dobett/+0Bk+46LEdJebwx3vTVsEXyOOe5kAb
	vj5V8UMaEZ/rewqzrLRcxR29l0C6y37vqLNW5ZkXUiHwH+nock3bWzpbNjb3oJtQQgvK3Xs/QCk
	fhF0oHrw=
X-Gm-Gg: ATEYQzw79lAqw8FbrL0YRyta5ot+XR6rd7FXElL9vpUOpgG5/lDP9XprxFTbxt6xjjF
	cGsyQevPrLuCXIo0VvvWe1OdwsUHc5Idm8oSTQJg0b3Z5wQ1Az9toNQ4nFTcDe47Go9v6JBjZXv
	ylUlTm+FN+MYNnCvZXArLSFTizAHl+lLTZwOcdUMav0aTu2P0i+AqJcmBS6FsomOEQCOju0nyFV
	lXyo6kifdB/aePPbXr4FCZLorrS4/+aq8FXAYVJFclTeZ9CQ80kYFo7TSNbi0o4iESiChcFc+cc
	M2Ln7K9jMN5welj7UbHo+YMpTqNN0iz33MTsvvZ2cNVHUCrB4n2WI/1ZLA5eqcQOGae4uqUwhKS
	qjAvSc2okaKzaOhsO9fDPA1Y9dIY1TorK4yKZUID2b7IM6yn2HTx0VVLA3bmXY1lX5NGkDgXr/l
	Ix1uAlFkquq/A/Se4A+X81K7W7ke8=
X-Received: by 2002:a05:7022:4186:b0:128:d4db:4478 with SMTP id a92af1059eb24-128f3dcdb90mr1166079c88.24.1773408229994;
        Fri, 13 Mar 2026 06:23:49 -0700 (PDT)
Received: from fedora ([179.105.152.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384f6csm1846358c88.9.2026.03.13.06.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:23:49 -0700 (PDT)
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
Subject: [PATCH 1/2] rxrpc: Fix keyring reference count leak in rxrpc_setsockopt()
Date: Fri, 13 Mar 2026 10:23:26 -0300
Message-ID: <20260313132327.409785-2-anderson@allelesecurity.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267454-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,allelesecurity.com:dkim,allelesecurity.com:email,allelesecurity.com:mid]
X-Rspamd-Queue-Id: 6225A283F64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In rxrpc_setsockopt(), the code checks 'rx->key' when handling the
RXRPC_SECURITY_KEYRING option. However, this appears to be a logic error.
The code should be checking 'rx->securities' to determine if a keyring
has already been defined for the socket.

Currently, if a user calls setsockopt(RXRPC_SECURITY_KEYRING) multiple
times on the same socket, the check 'if (rx->key)' fails to block
subsequent calls because 'rx->key' has not been defined by the function.
This results in a reference count leak on the keyring.

This patch changes the check to 'rx->securities' to correctly identify
if the socket security keyring has already been configured, returning -EINVAL
on subsequent attempts.

Before the patch:

It shows the keyring reference counter elevated.

$ cat /proc/keys | grep AFSkeys1
27aca8ae I--Q--- 24469721 perm 3f010000  1000  1000 keyring   AFSkeys1: empty
$

After the patch:

The keyring reference counter remains stable and subsequent calls return an error:

$ ./poc
setsockopt: Invalid argument
$

Fixes: 17926a7 ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
---
 net/rxrpc/af_rxrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 0c2c68c4b07e..add72ac61f73 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -663,7 +663,7 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
 
 		case RXRPC_SECURITY_KEYRING:
 			ret = -EINVAL;
-			if (rx->key)
+			if (rx->securities)
 				goto error;
 			ret = -EISCONN;
 			if (rx->sk.sk_state != RXRPC_UNBOUND)
-- 
2.53.0


