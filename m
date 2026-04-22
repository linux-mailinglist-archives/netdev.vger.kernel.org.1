Return-Path: <netdev+bounces-280279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFDpGjsX6GmxEwIAu9opvQ
	(envelope-from <netdev+bounces-280279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:32:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B01440E0C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82DB33033083
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DB018C008;
	Wed, 22 Apr 2026 00:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="CgYG5p2U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A9347C7
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776817965; cv=none; b=OGThJ/DlxwnbIZAqGc+d4Dga/a8RT2jyLH4zDWsmiT8vbZ/e8PxjucPurwSOwuYC69bcirq7mxCUfc7E3HmLZz5zigLj0Nh14u0aZpXnIDcgIkbOxHpWGoi2lTQga4Bp7BXA+83Wo6S2CPmcD22bW7gzxrrA0LjhchwSYfsUZgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776817965; c=relaxed/simple;
	bh=lwhpGMqxIEBExeODsinJdwdIIPKJoJrL3AlkOug02z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SrbvmIFqwtESen6gpeQ/0eSi5SAcS4hklvNrZSEsZnHxUhmROO2koMpUqlqAca2Wsbgc8Sg6h+2w3mNFqktaAaLut8X0FXdosomiJGwnYSnXHvNHNXR1SRWVRUt1IJlcsG4X0Svt6tr99xHhFXUyhGTMdNACTjfDx7AIbSkurGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=CgYG5p2U; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c6df0b9bbso2432141c88.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 17:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1776817964; x=1777422764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLEffq/KmF5N2hbyrZmLE4zdinUJ9bGrO17RsFPNg3g=;
        b=CgYG5p2UwsuSQAn6wXiZovPgRIbVmOOO5sUgCpWotehT/E/kQ0s4TmCTENvLeMtb9W
         3+ck9fGZaDGtEyOHcmtpWtf6Gf7S9OSgreImiMaY6PFdVOTMRCsaUKyT/RtXBkaVwl2v
         R8e36Zx50pl1Q63oXGAjRquBryWEqP8mOoK/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776817964; x=1777422764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLEffq/KmF5N2hbyrZmLE4zdinUJ9bGrO17RsFPNg3g=;
        b=JtrZGABbPkiXBZykhdVWjy1o8V6WXtpyTop2R89xN7Aahg45wZZfGClpb8pi5HB9ya
         2jkQZVl6/1cwAO31aRGSVHxhlG86Uridjqj9uMC3c2HMui5pjq/dkWBZ7iVS641yrr4g
         +POtLhB5bQm7814XyF0NvNsAtj5qWl6+wP+I+hOPcEpVbxAehNEFHrt+Dr7GK2kt7Rfw
         4FDhuexKj6q0f5AHyrPal0IO2T/4Yw93yQm/qu1ZPCOIzDwG8J5eBRb6GaE+biLNirL1
         9du/JLObAf8Gy438dL7MR4YXQGNAUE0OdA7OKEtLSi6BMXpvqrP9/NdUfoWwZjNz781q
         A3Vg==
X-Forwarded-Encrypted: i=1; AFNElJ9nriVgCTzkRG9FovkSbkc8K0M81tfUfoP9o6A/vvbqlESzqFkcUE+6hKoupsWc44ESDx12tXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0LVsd8Xjo7OtySCEnzK7eWqk7Es6tIAhiAxjW6n39P15jaQCN
	0/Pq9kl6lqtEuAX0AuHl51LhwY82qSeWPPBcdAmwJGHYb5PA5dDRdG8yeeQqkYc1AMc=
X-Gm-Gg: AeBDietiOEEx25Y+/i0gFtTOQAqgwahc7nbHVOzKAqY5aOOO98gb+PPZTRyJmKj86r+
	z3uiJ5WMDJ36S9vsGTS/T6/BkdhuTkm/R9lcdAnfAlK2iaTIym9lrkPQW253IZ1yMWoOqNrcKN+
	Alp5UhOKCzI7HtN1iB+DRG3HJTZX6ysx0zpMMWX1pxY91YGyiUptxM4dhWhKwlZEsosm6U+pebB
	gW0eCM3PzcDu+BNrcKcyiaHLnYxAmoAEjLzkPNkFs2RBrKajOwFn1CjqEwbgp5mt6VzSrN45Qm3
	PlnLyFfFmqFkZqdKW5Yp+l+nC1SCxbzc/PT3Ap3wkdfmHwYyAaeWfgdnp2pp9tseVkdpjRaU32f
	P35yQsucWY2ts3yzmkN52+9okyW6tZKOLCD7+IfYMJ0lqndcxWtJHzgttr3BFFu4EshBC/uPZbL
	4iYIgwEEuUWHWxgMdrDZ9TXKX1sy5sVIg1srpTVVCHVEFON358
X-Received: by 2002:a05:7022:458d:b0:128:d51a:5161 with SMTP id a92af1059eb24-12c73fa2244mr10513913c88.27.1776817963615;
        Tue, 21 Apr 2026 17:32:43 -0700 (PDT)
Received: from fedora ([179.105.152.38])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c749c422csm21693851c88.3.2026.04.21.17.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 17:32:43 -0700 (PDT)
From: Anderson Nascimento <anderson@allelesecurity.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steve Dickson <steved@redhat.com>
Cc: Anderson Nascimento <anderson@allelesecurity.com>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rxrpc: fix missing validation of ticket length in
Date: Tue, 21 Apr 2026 21:32:05 -0300
Message-ID: <20260422003206.1017863-1-anderson@allelesecurity.com>
X-Mailer: git-send-email 2.53.0
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280279-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2B01440E0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In rxrpc_preparse(), there are two paths for parsing key payloads: the
XDR path (for large payloads) and the non-XDR path (for payloads <= 28
bytes). While the XDR path (rxrpc_preparse_xdr_rxkad()) correctly
validates the ticket length against AFSTOKEN_RK_TIX_MAX, the non-XDR
path fails to do so.

This allows an unprivileged user to provide a very large ticket length.
When this key is later read via rxrpc_read(), the total
token size (toksize) calculation results in a value that exceeds
AFSTOKEN_LENGTH_MAX, triggering a WARN_ON().

[ 2001.302904] WARNING: CPU: 2 PID: 2108 at net/rxrpc/key.c:778 rxrpc_read+0x109/0x5c0 [rxrpc]

Fix this by adding a check in the non-XDR parsing path of rxrpc_preparse()
to ensure the ticket length does not exceed AFSTOKEN_RK_TIX_MAX,
bringing it into parity with the XDR parsing logic.

Fixes: 8a7a3eb4ddbe ("KEYS: RxRPC: Use key preparsing")
Fixes: 84924aac08a4 ("rxrpc: Fix checker warning")
Reported-by: Anderson Nascimento <anderson@allelesecurity.com>
Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
---
 net/rxrpc/key.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index 6301d79ee35a..5ebb06d87cdd 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -502,6 +502,10 @@ static int rxrpc_preparse(struct key_preparsed_payload *prep)
 	if (v1->security_index != RXRPC_SECURITY_RXKAD)
 		goto error;
 
+	ret = -EKEYREJECTED;
+	if(v1->ticket_length > AFSTOKEN_RK_TIX_MAX)
+		goto error;
+
 	plen = sizeof(*token->kad) + v1->ticket_length;
 	prep->quotalen += plen + sizeof(*token);
 
-- 
2.53.0


