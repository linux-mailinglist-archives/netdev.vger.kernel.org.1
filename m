Return-Path: <netdev+bounces-286688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YgVJDlHqAWpamQEAu9opvQ
	(envelope-from <netdev+bounces-286688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:40:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A80CA510585
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6786308BD5A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7383FE65F;
	Mon, 11 May 2026 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCJwHMhH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09C23FD14F
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510072; cv=none; b=bCPvKearZVL628DAYh1106VsVHhFeWreTC0C8cUdYSSz5oOOHLw929J52pBGeZqCx7WoD3rMQVvzG4vasuWE0S0rxeplDB+2MvVmgNJ1gMuT8zw7XZFRxCWsq2zLJ9PDVzxa6E0iNB47c3HDvSm4UQadcKjIBRYF73rBd+BILH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510072; c=relaxed/simple;
	bh=iSrkQyeRofMbSPxTLYOsO6qzNQE4SqSEjA5gq66gbDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJnwQ1zCdE65fYwwW/f5PJD1pvSodERYcXW8R0s2wju3YEuxWsdwHoAgPs37ozVThC2lE0cnLQ1AoJUAQnss5rUkqiRiKt+OUIEQVo9reT74m5s22MPXl/fY8q1QNWQwKPhGJFa6CcVgqXZVf5yGa+H5CfF7NgKSN2h011B/oBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCJwHMhH; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-512f09ecc67so29698131cf.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510068; x=1779114868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L12bZ1vidxYuUv1RmDgLjzPTzLUWYys5d8sestRhEVQ=;
        b=cCJwHMhH1reIR8S7TozaulsbLDWRMhDdyGIV6VTHrUzXDpVT7csg+37DztuIvDGIpU
         u/+DUzI9fqhwIpk++v1R+b84b6hISpFt+863EOjSydfMbuRIzlt3V+G9VCD1+NTIR4AA
         4JJnsXJ4+emkPZpLtlP1lkg3xgdP8gYBlOfIhaqCb3bbme5w2T4141C8jJevGrmPobH3
         p5HDYE3BpyRVff6NIgewEJNPQkkp1VWSqvjw6MHxHyNnTQRqjj8I/FoZqbn5evSleuk/
         8eSxojHyYxmoaHBjwF2PJGEEtP/C3ThxHGY3hsGlPwDVKiK6Z0cISuX10w0o1JAk/Y77
         gt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510068; x=1779114868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L12bZ1vidxYuUv1RmDgLjzPTzLUWYys5d8sestRhEVQ=;
        b=Q9mTLQBXJ38cdh4LhCNvEDD4zP42XOW49dfFHBXvpmeSap1GOtiVaQ8m8aRvSsO/FP
         zoSYiR6GWEHsOgqvhi+cKHjT8haoi28ODpBu5pu4icDFvj+jocBEYIpxuyRrzAUMJ4Fm
         fbMcgtorEmsdLxf0OaROn+YZvUsdkgCsXTKWffccjnvDQaNslouftMCJDLOVF9GHQY19
         9UfnqbZpNxM1ehOA8eGNvF03FA8uHeGCyliIKHIWzBDeepi4wNGB33Ec9kLQnMtd4/q4
         wOHlg3t1e5MdWLkGSgc7Bpa9CgbDpv7l5FstFxScJgW8KIt9iBZrZcUzP68PL2ZNCtMj
         cO/g==
X-Forwarded-Encrypted: i=1; AFNElJ9bGPO5oGzXycAL8HYAhs8HOp7LySWny21zsS8ON55FL6KLUh6Tpf6DAYisKWtjk5EMBwg8iqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4X3JTn/7HYH92s0bckKpyz6dom6kiGpLYdg1sWXsUxHFiRIRq
	JzZY2ZmLo94zPuHMCB/w5umTDIAtrkG8ZPLyo561Jg9dWoUhd51R79x2
X-Gm-Gg: Acq92OG22loPpk6wv8cZ+4t8yDtQceBsODsnXmsSR1ADEtu7YF0KqYwzNiPCIPmtNVe
	XKC4rmvRiE2eGSQ5Nd75WF8pPhjE7mmIJ+9bQWaxxorVBte/SF63eQQI8aDg/h1QB2QH4aOf3E7
	MWGe/J84P7RmhuiAFzBaSjIbL4BLJMxiAGQR/slVozxQMOpY/4pkf+JDzg95/UWqOCAO8pt9xtG
	f0xu/rd/ZqFYHxW47u3dMBiUsJI0o34YHc8M8lLTxuIEguZRz6r7Gjxu7p9ybhs+XnjkdjRS/LT
	xiVzFhGusROjuXznhRKVE1zQYacknnfW+X4deynPZEQcHwmjx9ZrqeQxL/n4qCMSvhx4bKf2pyq
	fzLMHSf7aTB3yuHtQqLxV+Dv2PTLTi0xMCXAZk9ODHk1yLQHc8MWO+KxDjyFqiy3j3nROK7FH13
	wZRXsipS9/JAqkeKXg7BEfOWeKiXyXa042SuVozpEhcTbEYb1egmRRrjDYD7/Txs1HqqsE9YYyp
	gBF1vYkpNbFyP7zJdH3TyYV1111+n9PGkPWOtlrzTk=
X-Received: by 2002:a05:622a:540c:b0:50e:63b4:9b9f with SMTP id d75a77b69052e-514621de9b8mr341952601cf.55.1778510067705;
        Mon, 11 May 2026 07:34:27 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83aa2bsm90605371cf.28.2026.05.11.07.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:34:27 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mat Martineau <martineau@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Aaron Esau <git@aaronesau.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH 2/4] Bluetooth: hci_sync: pin conn across hci_le_pa_create_sync
Date: Mon, 11 May 2026 10:34:02 -0400
Message-ID: <56cb0a32170c0b2df8986d5afa7691e3d1fda094.1778506829.git.michael.bommarito@gmail.com>
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
X-Rspamd-Queue-Id: A80CA510585
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286688-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iki.fi,aaronesau.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.926];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

hci_le_pa_create_sync() exhibits the same TOCTOU pattern as
hci_le_create_conn_sync(): the cmd_sync callback receives a struct
hci_conn pointer via void *data, calls hci_conn_valid() at entry,
and then dereferences conn->sync_handle, sets a bit on conn->flags,
reads conn->dst / conn->dst_type / conn->iso_qos / conn->sid /
conn->conn_timeout, and blocks waiting for HCI_EV_LE_PA_SYNC_ESTABLISHED.
The wait can run for conn->conn_timeout milliseconds (typically
multiple seconds for periodic-advertising-sync), giving
hci_disconn_complete_evt() a wide window to retire the conn out
from under the callback.

A KASAN slab-use-after-free splat ("Read of size 2 at addr ... The
buggy address is located 52 bytes inside of freed 8192-byte
region", cache kmalloc-8k) confirms the bug on linux-next tip
commit bee6ea30c487 ("Add linux-next specific files for 20260421").
Offset 52 corresponds to conn->sync_handle.

Convert hci_connect_pa_sync() to the hci_cmd_sync_queue_conn_once()
helper introduced in the previous patch, and balance the conn pin
in create_pa_complete()'s -ECANCELED short-circuit.

Prior art: Pauli Virtanen's PATCH v2 8/8 at
https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/.

Fixes: 6d0417e4e1cf ("Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/bluetooth/hci_sync.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b20e07474257..43779375209b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7089,7 +7089,7 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
 
 	hci_dev_lock(hdev);
 
@@ -7113,6 +7113,8 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 
 unlock:
 	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
@@ -7251,8 +7253,8 @@ int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
-				      create_pa_complete);
+	err = hci_cmd_sync_queue_conn_once(hdev, hci_le_pa_create_sync, conn,
+					   create_pa_complete);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.53.0


