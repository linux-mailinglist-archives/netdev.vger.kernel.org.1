Return-Path: <netdev+bounces-278001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OvqGOGx3GmbVQkAu9opvQ
	(envelope-from <netdev+bounces-278001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:05:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A633E9886
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 430AA3002B78
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65803A6EF4;
	Mon, 13 Apr 2026 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyl6q5fC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280353AE6E6
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070739; cv=none; b=d1xkd8msycFasHTIpZoqb1JfS7X1nW56xQR4oh+ar8K7NNqJlb8oZwzLEUu6AeKrvfpx6kBDwi4UPjr8mGYX9mGjaQVB6ZMDQEIYIzShsMl230oGVZtSgg252Q49ijK+rQlfDRaZ5c2y9/wrfRbSWclrc3AyAImRx2yI3gDcCng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070739; c=relaxed/simple;
	bh=VEt8Tir2cp1JOzuV9/MbAWkqPlobq1TC6ZmpPL9KeQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nfyzjq7/JWlDP9qu8HhbzSbTkeKkvtwirG/hOTZ7O9XxaGsM+Dzh5+odKlf2ZL32ndZqsVo9DUa++nhwNOc56dwCoFHtbed2wfiMPe075BVKE3kcsQfHvVVULONTqhnWrkwEg0RwnHBKSzt36PgCUz/BYJGIWiIoClT3XjUq2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qyl6q5fC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2494440f3so13840465ad.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 01:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776070737; x=1776675537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nKznZJFJgXR/beDDRo8kmPw1zF8lRhV4z+PdjdUnuao=;
        b=Qyl6q5fCDfLvPV7ItNIZ/BerA9WtgXx04jQXIX7FA3SrRjzheKmY00P69m+iBf2zEO
         +X1mYk/ze9AK4eOmiYGvpYc68MCWatdxbreKicQfRhTPXDYjohuquPE7o+ZalEjlcahj
         LDgtrQBfOlw30lgStDUB1GA2dsFODp5n5GP/5foGLG3Ac6OJSDSE6azPJEX8e+8LX3eU
         JHZIhgnsGhG8kFddwT0SHs7PMB/wh5xWppDqxGWZBV0JS/V+aW4Opn30xV48vo4cTEtA
         NCEMTdJCvMx/41dNiMVy+TCtXjAW1CrlHpLYKhYKFJau+HnNlV8ndqckbQx4pPRz9Jcm
         Wc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776070737; x=1776675537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKznZJFJgXR/beDDRo8kmPw1zF8lRhV4z+PdjdUnuao=;
        b=LIAFuOem8yXSkTgkztQ9mLU3wMdDzp6UQj2EOFOg7gKlkwVeX3zcR1709jofuNRNj4
         TKeCXr4CcyhCnabGgITEbcQyVW2ua1aca79zLIa1RyzCpkhEWSTfJ0MS5r63wSrNdtfD
         f4esrmWk5zBkal4S3iTUWeuwZrMwEBIm4dELoYoMhtgk948xEHMLHidHcCu41t4dyKdS
         NkNe+sMR3U0mNG+2h3684OJZmcM/MDuoH6IQNL2YBO7ZiKsMw/VCBE13i0k6JxQPGQKQ
         qpdV3tWVTsJDUvGDSdvTmhWXimjYL+gDKd15SYVN4S8YCeMrBPh7z5yc3KVXdO2PVhL6
         XlNw==
X-Gm-Message-State: AOJu0YwkOn1VChZecRwcCTKfN0/QMGUngZbbADXackUDIzdluRSH6h1j
	9D0KG1uk1OYJNWV2qXmUUSWBbGp9oNtzjM752YifauM907zCUF2mXrFNlQuGfg==
X-Gm-Gg: AeBDieuB+NMLvC/qO/bFYUFLEkWGvxEPjKX359pHb5eXCyXkIn2fH3tvwAzRRjBp2Dq
	uSdbBTDM2CGMcIItPI6h2NVVB6tRpbZgGEFDwaDGx/3cMFdAG80cN04/QQJzHbTLGnab3VDM4lP
	GOrxreK3G+aUKtVN9R+dno/gK1aJ/afR3sA0Cy97PnvJ62kN+kgPTxM10YOu908NQvWzSHV8Ora
	l5T8vIhC3BHKtJFJnLLiyZ1aI92jpdognSelKbnl5ynMq6c48hX4CHuAVuQc6h4uwgXmeddzoNb
	gJgj4ZXFaHn+CQKpHIEjDeTnArz2MFsEziVBM2jLK/sTx6zzA+7tePhtcn+enjLoIJFYvBLS+sL
	EYFQLr+kA8VjEQCclBreuxwQPi10geJ9mHCKE/sa4rJ++FnWOB5x8ku+5+/jAVa1arwfrXgSn/m
	7WOb4dD97NHuS41vaZ36z3ZhxGs7o3GiEyazw20Fi+I+1bCIYhxCeeqxtv/bPj2g93
X-Received: by 2002:a17:903:3c44:b0:2b2:ec46:dfed with SMTP id d9443c01a7336-2b2ec46e10fmr52014855ad.31.1776070737248;
        Mon, 13 Apr 2026 01:58:57 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dabc08sm112126695ad.5.2026.04.13.01.58.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 01:58:56 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: netdev@vger.kernel.org
Cc: jmaloy@redhat.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] tipc: Ensure NUL-termination of remote algorithm name
Date: Mon, 13 Apr 2026 16:58:52 +0800
Message-Id: <20260413085852.76786-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278001-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phx0fer@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0A633E9886
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In tipc_crypto_key_rcv(), the algorithm name is copied from the incoming
message using memcpy with a fixed size of TIPC_AEAD_ALG_NAME (32 bytes).
If the remote peer sends a name that fills all 32 bytes without a NUL
terminator, the alg_name field will not be NUL-terminated. This string
is later passed to crypto_alloc_aead() which expects a NUL-terminated
string, potentially causing an out-of-bounds read when the crypto
subsystem searches for the algorithm by name.

Fix by explicitly NUL-terminating the last byte of alg_name after the
memcpy.

Fixes: 1ef6f7c9390f ("tipc: add automatic session key exchange")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/tipc/crypto.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index d3046a39ff72..ac072356bf0c 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -2325,6 +2325,7 @@ static bool tipc_crypto_key_rcv(struct tipc_crypto *rx, struct tipc_msg *hdr)
 	/* Copy key from msg data */
 	skey->keylen = keylen;
 	memcpy(skey->alg_name, data, TIPC_AEAD_ALG_NAME);
+	skey->alg_name[TIPC_AEAD_ALG_NAME - 1] = '\0';
 	memcpy(skey->key, data + TIPC_AEAD_ALG_NAME + sizeof(__be32),
 	       skey->keylen);
 
-- 
2.39.3 (Apple Git-145)


