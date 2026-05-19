Return-Path: <netdev+bounces-289228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEUGAFe0C2q2LAUAu9opvQ
	(envelope-from <netdev+bounces-289228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:52:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 919CF575C49
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13D47302D501
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E441A26982C;
	Tue, 19 May 2026 00:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD57G5qW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A63A1B5
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151947; cv=none; b=sq9rYVbOEzCbWLgnqt/hEi0HrkMLO58LhB/SwPRo1IDfBl4X8KvB133mWmNgyP0fMpYnDP0ScZtds6cNuOVGdBLb1k4+gPBt+pPRHdKA7xVX/rL/QcN4C5RIWBSnl+qEkyvFlu4x8nBMxYvz/Zd5+grBFj9D597B8AjZpTDPhDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151947; c=relaxed/simple;
	bh=8WR9rCQI8pYKIwDYraHrHjYIExw2j9LSvcpKQg2e6KU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OQDXf0a7hYl3yRQ/HacmoobzTW+nj7xuJsgd4zTEQdPR3b3czBwuArQcC5yb2stNhUdTv/nPOm49CojCQ2zQ1TYacef/SAmrIav6oFDxzSdO9bd3rhoeRcvuvAmTHSEY9LkRdRIa0FxxYAXrmaRJY0KHQRZ0nl4sVcJQqREmR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eD57G5qW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-365d8e43759so1733055a91.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 17:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779151945; x=1779756745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/pD9nTHCsUwMY/2ZvH2eEJmq55Tr5vZPtGAv1sHO/wQ=;
        b=eD57G5qWHjI7bto21FBFhIad4ZzZQBRThwy/3k8aRkIBtsZGdOpjX8+deCRRMakq3t
         CQ6RrRBoqidAaCx+ztHMCtPAbyLdqD1aYxH+sK/sPI0r+SNoxaJwvL11bigxnPKIZ3l4
         4pQMa4353Z8JzTgQg57oeUZ4EXgc3VWXfoMUlOlVYXKKNkngMQxsqWKPCjalD3z8DKn7
         9mJyyjAvsr+yK+muWQf6m6SRAdQGgp8XG42pgpfEGNXRsxDarlQunEVKgi+XMQB+VF0+
         dEW7Sg2Dy/6gm7EVQtNWRvxuoFNd1cxmJXBjTItyfDi+5VwXmAvPr7wG/skQLyGWszaY
         elWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151945; x=1779756745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pD9nTHCsUwMY/2ZvH2eEJmq55Tr5vZPtGAv1sHO/wQ=;
        b=gYeLF8OMQz1DxZzLOif3ZIOHjsHS5cgGicg+ZE57+Al/AF7Rt9CWf2E9g0HYUZCGxq
         P/UMGwPYr+odQupO3RiwLS5tQ83yDss1zl8vLyp+6xaoO1V74UCMipulfLXb1kzuVUGb
         2Zkh7+4JH6gT/JmID9UeF0CC9Pyl1EwsmYhCZaprfT2GIg+xNry7hLlWW1LSOigfJl5d
         OKOgUanZrwJuSW4OC7kvbGNpnv1B+fByrbO7rhUuqnF8PDWHxbSZiQsfgSwjx6mPjQiN
         Gf63q+3xBiz6AMz9IPEaz+shPamozNjzjg0L8goZhsDBf6ohsKyGuSrUN0dFc7QdrGOU
         Qb+A==
X-Forwarded-Encrypted: i=1; AFNElJ81OfThJiMRdV8eCNtruAEgOtp7SvC3BuEUYOWJUBosyCW9LWZ6cpgrHhyABveQaIOEoZsdZnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+9UqRqcT8X/CDM1rk6uyMHrzwzDOkv8i5kLKiaAZjWa2w88B
	BDgrJl3ASQS4QashVW10bmBHlNVS5zen+zfI7W2Va2XQCbhqNYXjUFDe
X-Gm-Gg: Acq92OELNbwk69xUtltirG48McMFWgo9GJtzlZ5Kh5Kc5LLSnNFXWgRx2krWraikcV5
	bWMwEjJpiX/fMCiKaQf62WGhBQ0rrrhY0rv1cFcgqpYC2cYDu/xzeLSDx+RGs0mbfzR0ZnuW36v
	PQAaUJiswnRpLjbM+z5ZEF3VrlvDKe0SY1Jvt3mcuuPAQkeI/DlL0sHuuJiy2Spn/7Ny+0D9MWJ
	iYmXUtCm/nSgVdbzl1bOS5m96v9eWN86Kl61OBmJnItgIe15qTBKDuYxHAlAVRIfEDJOSMKwqJ5
	YksXBZfEhhbuA7t1uviAj0EhMKLVV5aZhvVR0FW2jm1lP3mOOql7RFcOmkaCxXXT5e0KNC/FtMq
	Z0ZIqrdRrS8juHBijo6kiNSCMHiSnQ2LIM2BLMbxQ7eDmmL/ThzYMTT0Da/76V+wkoVjDBgc33n
	qtPKQ5BGQfveVynEyXgEqDBg3JGGEmM5R9dvQIy4NQjKj920hkQxiZ/m3As1h53o9upkXC44Z/0
	OVz1/sysS6Q6nGYu4k1uAGmpnCkBAnax1Q=
X-Received: by 2002:a17:90a:c10e:b0:368:977e:2bf8 with SMTP id 98e67ed59e1d1-36923603c63mr18107714a91.10.1779151944807;
        Mon, 18 May 2026 17:52:24 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bdc4c2cda4sm74177405ad.58.2026.05.18.17.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:52:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list),
	linux-s390@vger.kernel.org (open list:SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS)
Subject: [PATCH] smc: Use flexible array for SMCD connections
Date: Mon, 18 May 2026 17:52:06 -0700
Message-ID: <20260519005206.628071-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-289228-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 919CF575C49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Store the per-DMB connection pointers in the SMCD device allocation
instead of allocating a separate connection array.

This keeps the connection table tied to the SMCD device lifetime and
simplifies the allocation and cleanup paths.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 include/net/smc.h |  2 +-
 net/smc/smc_ism.c | 10 ++--------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/net/smc.h b/include/net/smc.h
index bfdc4c41f019..a2bc3ab88075 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -40,7 +40,6 @@ struct smcd_dev {
 	struct dibs_dev *dibs;
 	struct list_head list;
 	spinlock_t lock;
-	struct smc_connection **conn;
 	struct list_head vlan;
 	struct workqueue_struct *event_wq;
 	u8 pnetid[SMC_MAX_PNETID_LEN];
@@ -50,6 +49,7 @@ struct smcd_dev {
 	atomic_t lgr_cnt;
 	wait_queue_head_t lgrs_deleted;
 	u8 going_away : 1;
+	struct smc_connection *conn[];
 };
 
 #define SMC_HS_CTRL_NAME_MAX 16
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index e0dba2c7b6e3..bde938c5eb39 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -467,17 +467,14 @@ static struct smcd_dev *smcd_alloc_dev(const char *name, int max_dmbs)
 {
 	struct smcd_dev *smcd;
 
-	smcd = kzalloc_obj(*smcd);
+	smcd = kzalloc_flex(*smcd, conn, max_dmbs);
 	if (!smcd)
 		return NULL;
-	smcd->conn = kzalloc_objs(struct smc_connection *, max_dmbs);
-	if (!smcd->conn)
-		goto free_smcd;
 
 	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
 						 WQ_MEM_RECLAIM, name);
 	if (!smcd->event_wq)
-		goto free_conn;
+		goto free_smcd;
 
 	spin_lock_init(&smcd->lock);
 	spin_lock_init(&smcd->lgr_lock);
@@ -486,8 +483,6 @@ static struct smcd_dev *smcd_alloc_dev(const char *name, int max_dmbs)
 	init_waitqueue_head(&smcd->lgrs_deleted);
 	return smcd;
 
-free_conn:
-	kfree(smcd->conn);
 free_smcd:
 	kfree(smcd);
 	return NULL;
@@ -557,7 +552,6 @@ static void smcd_unregister_dev(struct dibs_dev *dibs)
 	list_del_init(&smcd->list);
 	mutex_unlock(&smcd_dev_list.mutex);
 	destroy_workqueue(smcd->event_wq);
-	kfree(smcd->conn);
 	kfree(smcd);
 }
 
-- 
2.54.0


