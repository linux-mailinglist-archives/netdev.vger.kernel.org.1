Return-Path: <netdev+bounces-286690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGHlIj/rAWpHmQEAu9opvQ
	(envelope-from <netdev+bounces-286690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:44:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 96377510746
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 155653016D2D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4A73FFAAA;
	Mon, 11 May 2026 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/WCly3B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0594E3FE66F
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510074; cv=none; b=hJl2VmygAegjKiIObgrwc1sXGHqBoVgxnTcQh5Zw14zThYd5T38Gvstme0nGWmD6FtkY35N8qUmF7Q5t0DXKHpcq5/AX48eGQHTmgO7ysKht8RyS+krJ9b7ZPFdEVUm0gtPa8RUzkukgmTg3xBZnfn4qQOs+fJXbjU8suV3BCns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510074; c=relaxed/simple;
	bh=SLCjylkoYyrSymgTADQUnZN5X5pHLMpZcZL0BMK5TuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXZa9r6vttOxEhYf3m5pKBr4Hh18HSgcHDPAEn2bfzGtLIaGuz31SaNySY6Pbjc/LUehtOOdg0WctLnmggq2TWdaIt/IG5pBzGTirmgivqWNgQ9lNWL6y1RJTdguPQBm4GSI+qsW4xdtOxVMb7otcw5k6ze3hLIemKnk00g5ohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/WCly3B; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e5ad864a6so44829941cf.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510071; x=1779114871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KS/XEaKHIMFF8jDxzt8KXTwiFVllSXPL3p6YrwJsG/Q=;
        b=J/WCly3B7JLxicixynYiCWpTtpaneFRMbAl+9aWqJ9vMOcIMtUgGEf4Iji4ZlS/tr/
         R2kRuxP0WFnLm1BarlPszdS7FuXwzUrOwM8f/XjoUCuYVYEOvMcg5DMKhh8kDCg4vl3L
         xTpoBMghkSK5J0TbTu5ptROEUVYxVZEJXcWkvAv08DQzytY1HRSYRgKgWQ+XbPuPPWqA
         yTDLyNdLcLxkjXNDIwglLztupKvP0cDS3Q2kHQnSQ8GHNA7TQma9RqvGcUS/Ub3TD8PP
         6gzS8G26RLusqmoW0YRpNG4jyhwlkJDa0g9OTv0GnRwULubFjQ8HTHKrXNUVv3hC6lFw
         1eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510071; x=1779114871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KS/XEaKHIMFF8jDxzt8KXTwiFVllSXPL3p6YrwJsG/Q=;
        b=MXv6OeJHPZeVraoN79FfZCGeEm33zMOL/hHXdGyMt5UhCQwoEysBw9uwtX+k5k9GTR
         sh+dsaYLmvTWFIxvq5g9IWuLgQSBRo6U3h4bqYvpyu0lthHTsXL87pf7i6dgiS1TC+1B
         2xuKy1jYjCbI8G30e77W2nRYMMDjde40B+EjoF4BLD/1NYKm5IPChMN5oxbXEKHiUQjj
         42GQFxI9b6O4j/9zlFdgmen9r/7YN2DI3Uyd3NUA5PZ6JQYv9rhDvn3pXpda0s9Nam+D
         3PDHkapJpaXFXQ4OTKG4I2kkADm7zleQagGD0cRibIFl/y6Ir6lUyrCwCfsZ+Qn9igLS
         4sbw==
X-Forwarded-Encrypted: i=1; AFNElJ94wq5eH0CO3ZVNajH3CYyPpDczmT7T8z7o3xtrFxJI/HALv02oebIOnO527k0o/UQKaOCYb20=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb0GG6QoxLslJIDW9LgAae/no9v0RkeN+Wh6P2C2HkJeVMOS7Q
	HviXwopJvkG8chkMvbaoSYyz4XM5R8e2a38DbRSHpDkI5Go9dbWsea5g
X-Gm-Gg: Acq92OFFqW1vx6nsENXhuFN0vcv/oteUqKKJr21cJ8vrJc8pcn5V1kdkmOhZv7lhmxo
	+ztBX7Utw3A+HU0JonzN+V+xpW40RgVTvpByu6ntzSFqnINhCF0vxBbg8M57pnmG5vHaH0UwmeF
	B51Jo0yDCK3XVhioSEjl34WfdgOSnOSPcxndbVmG9rZZT0lmDubg5rljophfWSfjjGk7GEbNCHS
	Y2e2QtFWHnjv9Sx3Jq8KnJ02OCPhZCcQQR+0pblbJoTlgV+aIZ2xmQ3Oki2E3dwsEOiuOrXDBqQ
	LlNJ/vSW/FH5sv8KAwfuOu9D4GM8ZsMEoZijL3dW2sl6LVqvBEBesXkJBsRQjHe99wfKdiK0Fjt
	VKyTZetYieotyFKleN5FbABN9j41V+u9lJ9kEc0Y0d1x4RFvOz8uQAUR/PToutliKofuwFQDKSS
	1g2MUHC8VVqqRRKsohYi/pVf3besAmDHMG0RFL23MywgIkqfVtJCPnODJYLIQRwf2yMbJRo3ZiK
	My6sUayichKDOR5Ns9PnDMij1HnaiCJMezL7UDzDEY=
X-Received: by 2002:a05:622a:13d3:b0:50d:3e1e:7998 with SMTP id d75a77b69052e-51461f9dd67mr340927431cf.37.1778510070473;
        Mon, 11 May 2026 07:34:30 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83aa2bsm90605371cf.28.2026.05.11.07.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:34:29 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	=?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mat Martineau <martineau@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Aaron Esau <git@aaronesau.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH 4/4] Bluetooth: hci_sync: pin conn across hci_acl_create_conn_sync
Date: Mon, 11 May 2026 10:34:04 -0400
Message-ID: <a586369f30357a4efe549f567f0629ba5ee0e7f9.1778506829.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778506829.git.michael.bommarito@gmail.com>
References: <cover.1778506829.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 96377510746
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286690-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,v0yd.nl,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iki.fi,aaronesau.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.939];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

hci_acl_create_conn_sync() shares the TOCTOU pattern with the
three sibling cmd_sync callbacks just fixed: the work item's
void *data is interpreted as a struct hci_conn pointer, validated
with hci_conn_valid() at entry, then immediately written
(conn->state, conn->out, conn->role, conn->attempt++) followed by
a memcpy(conn->dev_class, ie->data.dev_class, 3). If the TOCTOU
race fires the memcpy lands on a freed slot; the three dev_class
bytes are sourced from a remote BR/EDR inquiry response, so a
successful exploit can land attacker-chosen bytes into the heap
object that reused conn's slot.

A KASAN slab-use-after-free splat in cache kmalloc-8k at
conn->state confirms the bug on linux-next tip commit bee6ea30c487
("Add linux-next specific files for 20260421") with the synthetic
harness driving the conn->state write.

The existing queue site at hci_connect_acl_sync() passed a NULL
destroy callback, so the conn was never pinned for the cmd_sync
workqueue dispatch. Introduce create_acl_conn_complete() to balance
the conn pin and convert the queue site to the
hci_cmd_sync_queue_conn_once() helper. The dequeue-on-cancel path
in hci_cancel_connect_sync() now looks up the entry with the same
destroy callback, keeping the hci_cmd_sync_lookup_entry() triple
match consistent.

Prior art: Pauli Virtanen's PATCH v2 8/8 at
https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/.

Fixes: 45340097ce6e ("Bluetooth: hci_conn: Only do ACL connections sequentially")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/bluetooth/hci_sync.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 47ce9ba63fe2..9a133de16f63 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6994,12 +6994,21 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 					conn->conn_timeout, NULL);
 }
 
+static void create_acl_conn_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_conn *conn = data;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	hci_conn_put(conn);
+}
+
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_acl_create_conn_sync, conn,
-				      NULL);
+	err = hci_cmd_sync_queue_conn_once(hdev, hci_acl_create_conn_sync, conn,
+					   create_acl_conn_complete);
 	return (err == -EEXIST) ? 0 : err;
 }
 
@@ -7054,7 +7063,8 @@ int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	case ACL_LINK:
 		return !hci_cmd_sync_dequeue_once(hdev,
 						  hci_acl_create_conn_sync,
-						  conn, NULL);
+						  conn,
+						  create_acl_conn_complete);
 	case LE_LINK:
 		return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_conn_sync,
 						  conn, create_le_conn_complete);
-- 
2.53.0


