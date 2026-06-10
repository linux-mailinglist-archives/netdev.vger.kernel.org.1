Return-Path: <netdev+bounces-297525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l2z3EV8fKWogRAMAu9opvQ
	(envelope-from <netdev+bounces-297525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:25:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EFE6671F7
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:25:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RGawjTvh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297525-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297525-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8282331F9368
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBEA394780;
	Wed, 10 Jun 2026 08:17:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A43A5422
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:17:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079446; cv=none; b=Qqmr4p09Ovdr+hiraPQQJ4Fa0EmWV4o7nNLRQy16UazSOGrJGn1C5KMGiE0V3E8bor+TKCq21xKnpzI46x/kjLWc+9ojhnyC2d47BEYHZAYFAKuIRb5CRg8l9NopkMumoYp3FEUNNVBAle2RPca6WdkALLBdL7CepM6cld2gM8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079446; c=relaxed/simple;
	bh=/1WlT6A0jrrBng2OsyVNSwYFBDu7D3Fdbm/ZHj0eyik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMO3fhV2yL1OvDMCE1MM562WTgwNT2u25c3ICzCq9e5DlA8G4guya7IzN12GEx0kY4cpjgBl3O2iivnpMA94ScLZKxClBVeWd/NDGiiUkd64SXV7e1g3f/P9pq9Zo3zfZjsO2mw/MmQNa7aLcFzLaL3KZWQYrUZTgTFVrVhc9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGawjTvh; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84275887a3fso4648880b3a.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079442; x=1781684242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a6XIekyaK7oSHiR1vFLaniVYpHryv3YEOxStMQ5ewHw=;
        b=RGawjTvhdqfeEmQSZxSWUQwxpuwqWf1QYu+q9CQNyVw1hypoTE3jEgkkJW60mb1FhS
         8ptQyOjBtul5xknaLekBLSgCxMGDRDN7yhGBFkdxOeIYrB+IJ7H7LWhnKDG+5EvA9Tds
         spXASutOS05sNAVjCXX6mmmhrsmwgJP9rO++5qmGGGUb/fmHaqJ/vbCg5lYwjG+Wc2h2
         Wi6IyieuK/C5nLaLONT2hac+qtaj2ckzdvLNwnQWL8gTZHIBUt3FPocwRDn62kElcJH9
         k8JVcwCL5BBPGW/Lm0X0xzc4k64JzqoqO4tSwgLyVQz0GCb+X9PqZ7475XT2s44kwiez
         5nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079442; x=1781684242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6XIekyaK7oSHiR1vFLaniVYpHryv3YEOxStMQ5ewHw=;
        b=kAsC6ekGrAsgw4Ky6IzRrnviaMWtL3yCVwIEDaKdb93VS7e3sq6C4eRVwWhC1c68t/
         IQTUEep5rCFdus/HfP01CXFXBQ3VPJYKXTvb+DzpBQYQHi8pcrDlDZvM950a5qa7Xsh2
         Y2jaMIW8liNVw/03vle2SCAEgjE/jJID0azHkFkEwScuch+wYNzLqWlAtQDZ1MvbpQ9o
         JvGcNJGenJpQKJ99xwsbkpW8IlKkEoSFw4+t1qGec6pjwvRjCpSFFmSOXL/FI6p4u+Nz
         YODe7EIL7tCW/BEfiA931Y9bikxMvaRqasPbNJu1lBSLYKtsOXopE3x49cK6hCLeUAU2
         jICA==
X-Forwarded-Encrypted: i=1; AFNElJ8LbCqtMpZ6XAXtVsj42eHLSqcvO85Qp8TwjtyaRNYWCy6EcMuEwCtpB13jqysYSL7R0YpnRWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNgUHOZmXpIrFrDNnIGIRRHMbbye7DNDGXM8hoEcA0UFIMSRFl
	Or5WNaWavLKzDbPuXpzySoLi2LF5ICJP8BSl4LvxaKZknU9npBUIAJW6
X-Gm-Gg: Acq92OFsyIhhAZNhST2+FMP+ml9E1Ja0WbuXV3SotfGhf6A1C2PLkRTbBxGm6AjX7hQ
	Fmw2KohCYEhXZlUhUk3vk8VRDN3UJOnw7S2QG6XV4QjNnlf8lL9vceKlV5ImTzUWgvQdSoqqRe/
	o1LmgQqYBWQEe4121NLrKEPMkE0QTMy9ucA/RevwFSH4Xg3RoucUuJWLMTbQhap+/pwFTbzVqyq
	kq51Bj8OacS96jxS+KctQAtt51//XeWhIZZXhmBtdPbcD4efHARRZiukByHKyb8r/EnTIyhfekL
	/6dLnRkashWqQYo78nP0qxCoKxooDlYzALe9AB9iRQEKUIuwyTDxG2tmumpbXP/ebOR0PYes7NB
	sdVT7WGEkyN1hFeaIaZIIliHGdXZDJJjdHNw0zAxzr4Prgj5enqW0fc6fYOf2yx69TYAXeJ6Z2Q
	XsUQDwHsrsAKxd+4cMUp+OX0bqEZe/k6wfsqsK2lB5cKRY7gy1da+a3jt55eghpp4q1+DJj4zeg
	qUlJY8VGF2IYbJm8g9iBZcCJ9LuA55PRziL
X-Received: by 2002:a05:6a00:138c:b0:842:3d8d:babb with SMTP id d2e1a72fcca58-842b6660648mr19475903b3a.2.1781079442078;
        Wed, 10 Jun 2026 01:17:22 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282916b10sm23929773b3a.58.2026.06.10.01.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:17:21 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: krzk@kernel.org
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	681739313@139.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] nfc: nci: Fix use-after-free on conn_info in nci_tx_work()
Date: Wed, 10 Jun 2026 17:16:57 +0900
Message-ID: <20260610081657.686636-1-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,139.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-297525-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:sanghyun.park.cnu@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:681739313@139.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sanghyunparkcnu@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sanghyunparkcnu@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanghyunparkcnu@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6EFE6671F7

nci_tx_work() looks up conn_info from conn_info_list and keeps using
that pointer while sending queued data. nci_core_conn_close_rsp_packet()
runs on the separate rx_wq and can remove and free the same conn_info,
so the tx worker can dereference freed memory.

Race:

  CPU0 (tx_wq)                         CPU1 (rx_wq)
  ============                         ============
  nci_tx_work()
    conn_info = nci_get_conn_info_by_conn_id()
                                       nci_core_conn_close_rsp_packet()
                                         list_del(&conn_info->list)
                                         devm_kfree(conn_info)
    atomic_read(&conn_info->credits_cnt)
    // UAF: conn_info was freed by CPU1

Protect conn_info_list with a dedicated conn_lock while nci_tx_work()
uses conn_info and while nci_core_conn_close_rsp_packet() removes and
frees it. This makes close wait for any in-flight tx worker before
freeing the entry, and makes later tx workers observe that the entry is
already gone.

Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
v2:
  - Replace flush-only fix with conn_lock protection
v1: https://patchwork.kernel.org/project/netdevbpf/patch/CAOrxSK5UmFFfzdRG+P89+E+Rvg_1DmOvTs+M7353Q8=hkPXmSg@mail.gmail.com/

 include/net/nfc/nci_core.h | 1 +
 net/nfc/nci/core.c         | 9 +++++++--
 net/nfc/nci/rsp.c          | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index e066bdbc807..22b245bc17c 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -227,6 +227,7 @@ struct nci_dev {
 	struct sk_buff_head	tx_q;
 
 	struct mutex		req_lock;
+	struct mutex		conn_lock;
 	struct completion	req_completion;
 	__u32			req_status;
 	__u32			req_result;
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 058d4eb530f..a24b9703115 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1277,6 +1277,7 @@ int nci_register_device(struct nci_dev *ndev)
 	timer_setup(&ndev->data_timer, nci_data_timer, 0);
 
 	mutex_init(&ndev->req_lock);
+	mutex_init(&ndev->conn_lock);
 	INIT_LIST_HEAD(&ndev->conn_info_list);
 
 	rc = nfc_register_device(ndev->nfc_dev);
@@ -1512,9 +1513,10 @@ static void nci_tx_work(struct work_struct *work)
 	struct nci_conn_info *conn_info;
 	struct sk_buff *skb;
 
+	mutex_lock(&ndev->conn_lock);
 	conn_info = nci_get_conn_info_by_conn_id(ndev, ndev->cur_conn_id);
 	if (!conn_info)
-		return;
+		goto unlock;
 
 	pr_debug("credits_cnt %d\n", atomic_read(&conn_info->credits_cnt));
 
@@ -1522,7 +1524,7 @@ static void nci_tx_work(struct work_struct *work)
 	while (atomic_read(&conn_info->credits_cnt)) {
 		skb = skb_dequeue(&ndev->tx_q);
 		if (!skb)
-			return;
+			goto unlock;
 		kcov_remote_start_common(skb_get_kcov_handle(skb));
 
 		/* Check if data flow control is used */
@@ -1541,6 +1543,9 @@ static void nci_tx_work(struct work_struct *work)
 			  jiffies + msecs_to_jiffies(NCI_DATA_TIMEOUT));
 		kcov_remote_stop();
 	}
+
+unlock:
+	mutex_unlock(&ndev->conn_lock);
 }
 
 /* ----- NCI RX worker thread (data & control) ----- */
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index b911ab78bed..dfebf1ed945 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -330,6 +330,7 @@ static void nci_core_conn_close_rsp_packet(struct nci_dev *ndev,
 
 	pr_debug("status 0x%x\n", status);
 	if (status == NCI_STATUS_OK) {
+		mutex_lock(&ndev->conn_lock);
 		conn_info = nci_get_conn_info_by_conn_id(ndev,
 							 ndev->cur_conn_id);
 		if (conn_info) {
@@ -338,6 +339,7 @@ static void nci_core_conn_close_rsp_packet(struct nci_dev *ndev,
 				ndev->rf_conn_info = NULL;
 			devm_kfree(&ndev->nfc_dev->dev, conn_info);
 		}
+		mutex_unlock(&ndev->conn_lock);
 	}
 	nci_req_complete(ndev, status);
 }
-- 
2.48.1

