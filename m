Return-Path: <netdev+bounces-304981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hMDkD6WNS2qtVQEAu9opvQ
	(envelope-from <netdev+bounces-304981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:12:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD5370FB3B
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:12:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b="P1ITyr/w";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304981-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304981-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2A0E300BBB2
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 11:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E2F3FB7C1;
	Mon,  6 Jul 2026 11:12:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3A3F65EF
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 11:12:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336352; cv=none; b=azIODZeC2WEQmr46dwE8r22gUOd4xvXeqQ9wiCylHQ5RldAaIjBZFz6lRlj6fbqK2RYcKdvKCFk++jWqhTES0t8hebjbGB+6wUfRfINDKgjRclRu3iuFpOtW2l/v9XkyKXhurrRCRgqYdQuipfBIuITVf14kTfFfj8rCijDuO04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336352; c=relaxed/simple;
	bh=v6VNb2kA3dX/6UZSsX1QTZQrVcfCyJaycbGUQAGD1Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqSb1EpgZV8FqZVmhRU2337Ir2ofj1A2vUwiCJklyG1/+7XS7w7KKh66O/PoS3IAPZNkcKxcwRtoCSCKzoRev3xzrDeCUv8bwT8xtWkwYg9SAT905nlMtRsoCTZEVWm5mfO9Nxli3LikuBvoaKf1jcSlO+PWTFzyYKRl3Dn8EGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=P1ITyr/w; arc=none smtp.client-ip=209.85.222.178
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e67555e24so127909885a.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 04:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1783336350; x=1783941150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c80RNcEdDYH5aFuHZOlETLwAydyaWG6HsrRsklQ+JMU=;
        b=P1ITyr/wi8I0RbYBcUNNOuRSMs9EsAkt3BH+slYltZ63mVFsdgeMEDEccVKtIYZvCV
         TMvoLMV3CiJjx+dbILpkBOlsYckbRc0wowagyjMEezJGGW1BFMnwerKBG0tjp18tKJ7B
         FDPWpKGlAtTY+d4bds9rDXc8yn44bsoX0S6bf/6CaOqow1Z6zVIX/wJL6/vpZzPwQaHl
         HVxpClpA5svdYBOgqQepNvGGM7Q21VR4va3hHVGtxNMfw63sBKIWwUZP5BYQcjzQyNN3
         4mZ9sh+uDmINgZloX4MWNKVDeeIrdomYWXitH0TH7sgbSu1REpEtTr9FCXDbdbev6S9K
         fvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336350; x=1783941150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c80RNcEdDYH5aFuHZOlETLwAydyaWG6HsrRsklQ+JMU=;
        b=f6lX3beXpWb3gj1dfe7QgQAJJkd/PG28iK8ylOxVIG41Kca989KSj0GwHdPbXUC6zn
         guCKf2ERwd9cdbE11f5Aq8KGFeCVMw5dQhLjvHF37ma93j9r5XGKZ5pk3Dv/5RGhtvRW
         i8mIT/GTlDDd7V9LDrfCMfzvnuVESEidpJwcr8CnEbYTlAGcB6rcBuHVY8zhy3PKrO5d
         MlXFf6VvBHolZofeN6zGKOmEWvG87n4Q4C2BcQivcKpApJihM+gAlcPac1AvDbHbIVIS
         UIgXxqwCkSbRRvt4Q5dgoA4gD6vdysnRAO4GIZ+G4ESSgNJ8MYx2BXonD9dda6W48BOs
         S/LQ==
X-Forwarded-Encrypted: i=1; AHgh+RqIT/FgbhIW3+OawCQyAxHGKpNbFBqnTtYbFjzhC896zfU2UMmDUK7eo2MEqOOG+tazdEEWuig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//mXmn83i3YykoRWc6YAhB6ri+mnkz68RD5yx61HQN5tMdfW/
	wbTf82LuF1CFCOtsVnEA7f5jVnl+Id4kg/enu1yj5nwqDiHw4LEBPHRu6vB3crUeEh0=
X-Gm-Gg: AfdE7cmJFNp+SLg2BGbPbbJNOZ+17mYzYSoCjp1HhYpZy8eGpPoXPLgA5+w5QD4M+A6
	u7cTSH5w/ZVZ9tafcHuFUPgCWcOpnTOz//3SCT5HiDBCKRuSmF4FkWZpEYgmvH1vKTT4+UyauES
	WWY2KSDbXHVfOloZKaxqbCFeJftz3W1s6iy+erTWvrjkC6zxQ6qR1izQdvSXaQ9byTOW5Cfd0rV
	iRHhrNyuv0NavXK5/pr2OQKXC5YAt7vNKLOuKiYNAjj76uz8rHb6BGsU9C55AsZ7mGmgNTXwlSN
	Kf2zSY6o0xZnv2D4Jp2hoDvR128WsUNHojvuEHSXTK9UXqhX5h05U7X9yEvoheR8XeHn8XFvFU+
	SGwLxLt8E9OZrU8wFgWVHXG4VZLqjRHKp+njS9DBEkxiZeZjNXpfT6T1Ov2kt0iUvvTWjwHmv/4
	ORgO0qPamB5WBG9fdGzQ==
X-Received: by 2002:a05:620a:1a20:b0:92e:4595:fde9 with SMTP id af79cd13be357-92ebb553528mr7548485a.38.1783336349931;
        Mon, 06 Jul 2026 04:12:29 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-92e90ba41fesm926453285a.17.2026.07.06.04.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 04:12:29 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Lee <david.lee@trailofbits.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] packet: avoid re-registering fanout hook after device unregister
Date: Mon,  6 Jul 2026 11:12:23 +0000
Message-ID: <20260706111226.309506-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304981-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[david.lee@trailofbits.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:david.lee@trailofbits.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dominik.czarnota@trailofbits.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david.lee@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBD5370FB3B

packet_set_ring() temporarily detaches a socket from packet delivery while
reconfiguring its ring. It records the previous running state, clears
po->num, unregisters the protocol hook when needed, drops po->bind_lock,
and later restores po->num and re-registers the hook from the saved
was_running value.

That unlocked window can race with NETDEV_UNREGISTER. The notifier can
observe the socket as not running, skip __unregister_prot_hook(), and
invalidate the per-socket binding by setting po->ifindex to -1 and clearing
po->prot_hook.dev. A one-member fanout group can still retain its shared
fanout hook device pointer. When packet_set_ring() resumes, re-registering
solely from the stale was_running state can re-add the fanout hook after
the device has been unregistered.

Treat po->ifindex == -1 as an invalidated binding after reacquiring
po->bind_lock. Restore po->num as before, but do not re-register the hook
if device unregister already detached the socket.

Fixes: dc99f600698d ("packet: Add fanout support.")
Reported-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
Assisted-by: Codex:gpt-5
---
Changes in v2:
- Add Fixes and Reported-by tags.
- Fix the incorrect Signed-off-by tag from v1.

Trail of Bits has a PoC that achieves local privilege escalation using this
bug on a custom kernel config with CONFIG_LIST_HARDENED disabled, which can
be shared further if needed.

 net/packet/af_packet.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4561,7 +4561,11 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 	spin_lock(&po->bind_lock);
 	WRITE_ONCE(po->num, num);
-	if (was_running)
+	/*
+	 * NETDEV_UNREGISTER may have invalidated the binding while bind_lock
+	 * was dropped above.  Do not re-add a fanout hook to a dead device.
+	 */
+	if (was_running && READ_ONCE(po->ifindex) != -1)
 		register_prot_hook(sk);
 
 	spin_unlock(&po->bind_lock);
-- 
2.43.0

