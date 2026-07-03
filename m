Return-Path: <netdev+bounces-304331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4mDPLeI/R2o3UwAAu9opvQ
	(envelope-from <netdev+bounces-304331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 06:51:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D6A6FE7DE
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 06:51:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Z6h6enFZ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304331-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304331-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5DA630055FB
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 04:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF1632B9B5;
	Fri,  3 Jul 2026 04:51:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091D432AAA0
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 04:51:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783054299; cv=none; b=a4oD2aur73B5W65NSrS3/stDhiuFbtbplfuRWYz2G631uy6pnDAUeGRs5yAmgHC31B3cDJ949vVoNDCcI2trQngEfM2gq7ZalrFUwQI4R76SeV4nqlHV5gEKLt68zMaoRgQmoD2V/o6Bzr0tzb8KyWSmWW+PJNzzCQQWzXqzaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783054299; c=relaxed/simple;
	bh=2iRP72x2mSftqmGmXZJMv5jLBQGTfZOb65AvOqE3su4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbKlugTRbjrQNvgiVK+Z55xNvdWLalOXTTP1sOQnCSEn+TgIhQOhrw+I71zcM/ZbAC0jl9QyVFhS+A6ZqFAx8L72f7dwKFzLGGEdPgI3i//Tv8iSUnEcF5cIYVDsVUIpFIbEokjnp1nEWH02zbqXKe8J+51KQU7z8cuoeSDMSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6h6enFZ; arc=none smtp.client-ip=209.85.215.182
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9a20f70263so116874a12.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 21:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783054289; x=1783659089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs4q6Awdw+1WsQdVj2MS9r8yavqNppIDcymWk9Cxfpo=;
        b=Z6h6enFZmqHr0ZmViqJdt+4UakR0mQRimcs1vSpgubMo6t5JR+yyKo2LOAhf0+mBq8
         32JdwpshDKNL3cGcZMiJfzHk5Gyv9KrVexB/zMc8wWuRCa0cbCXBHd+2Oc53UXxqw3w+
         vFA3O9zcmXBOeTYizB+hfw8eIWNrF+79D92KMqaY5ZN3kHSv7rCGg+m+Jaa1I2bSgUey
         FtjFsbI1SWtZPewyElQAovcUnrR7+TK3FUJoa3WHihOs6r9NRxZhid95jqgmAc9Do429
         GiEseq5QI9PdT7Jl7HW2h5EDqqnOH7RYKcuTVw/TFmCgGJDT59e+0goAgAmmZBSnqfxh
         R6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783054289; x=1783659089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xs4q6Awdw+1WsQdVj2MS9r8yavqNppIDcymWk9Cxfpo=;
        b=IV8WkvngnMCQezRkg3fIXVVcCRbXM25r7R0MFwCokjxxZY1QoTHIvh1d0MmWOJlae2
         8DKAZFD5zNkOsrpu8YZXe4GNh57tRoZx5JmsUMQ8aIjPkcSLbaw/pecw+72E+rGOvJ1e
         c8ecQFpCCU8nYWivQRDqFvXEDaWXaikFk0170b6t21aLOTpAIAUlwzyOxGLLQRPQUil3
         1iXjNplutMyvC5AQDPEW6nLq5ZWaK+y+aAMFfs9C9OpmuWDVDxmYNqpegM8xjIbnBr0G
         Dbi7dwijMe9w/rJaTrG4aXD1K/I/fqCp3+rxAgqzMNTsTh95KeQ+u0OsDf0jLr/GPgQN
         YY8w==
X-Gm-Message-State: AOJu0Yw6wVJ3DFTOreABXS4r+9jAvp68llvWyaqrgv577RcmqE3lesSW
	OhIhxhehyv6mZWCK6A7HouI7ZhgL3d3c1pjwa3H9yMzYJ9bF0XJaYox9sK66ZaOY
X-Gm-Gg: AfdE7cnF/uENIzUmMzaeKRBa2BUFAJjkGIt6xW5irJrg8hcU6JBkL5pIJsdAxhO3ATi
	bpqk42MwGAfumDBZOyZOvw7KpRSWJE/PAPx1FZIsCNhkx/HKtBYsrULbgxsFMyQPR5BFsnq5ci5
	tjWaMcHp0Ik/e0iTdRTlt4gaYRG0woJtHtyceONaL+zPZK5OtUd6hAD2FxCm+LUbnIRO0/yMBJP
	QsKqVAxLQiIe6uRGGoTARwLiEJpoMuh7QufYHUu5fRn8AbSg5C2+ITbZd1tCEWpbpJKvZQwvjUO
	fpiiPsax8i/BkPiWYimrh8vI5+EvzHFQAF0o86ZWmEG2/7H+vJ5G5pcp6/PO4drSjPzVXvdV1GM
	vhOw9rj0TRaZWW6wDA+RFgyWdmESUfOlvBedUX5LkwqpbmKtSu/g3EyB/X9dpM2ou3OQgH6Y9HY
	S7bR7LdnwyfC588giHuS7trudK4noO
X-Received: by 2002:a05:6a20:3ca1:b0:3bf:6c27:387 with SMTP id adf61e73a8af0-3c01ca9b18dmr2890221637.25.1783054289352;
        Thu, 02 Jul 2026 21:51:29 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e920d7ffasm2027837a12.22.2026.07.02.21.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 21:51:28 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com
Cc: achender@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andy.grover@oracle.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	zcliangcn@gmail.com,
	dstsmallbird@foxmail.com,
	bronzed_45_vested@icloud.com,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] net: rds: reject oversized TCP receive messages
Date: Fri,  3 Jul 2026 12:51:09 +0800
Message-ID: <c83365078ea649d7ab2d9c198a445469bffb2550.1782850818.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1782850818.git.bronzed_45_vested@icloud.com>
References: <cover.1782850818.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-304331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,oracle.com,gmail.com,foxmail.com,icloud.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andy.grover@oracle.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:dstsmallbird@foxmail.com,m:bronzed_45_vested@icloud.com,m:enjou1224z@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[enjou1224z@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[enjou1224z@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,icloud.com:mid,icloud.com:email,foxmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2D6A6FE7DE

From: Wyatt Feng <bronzed_45_vested@icloud.com>

RDS/TCP trusts the wire h_len value once the 48-byte RDS header has
been assembled. A peer can advertise a length larger than
RDS_MAX_MSG_SIZE and force unbounded receive-side reassembly growth by
streaming payload into ti_skb_list until memory is exhausted.

Validate h_len against the existing RDS_MAX_MSG_SIZE limit before any
payload is queued. If the header is oversized, tear down the partial
incoming message, stop tcp_read_sock() immediately, and drop the
connection as a protocol error.

This keeps the sender-side and receiver-side message size contract
consistent and fixes the resource exhaustion bug in the TCP receive
path.

Fixes: 70041088e3b9 ("RDS: Add TCP transport to RDS")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <dstsmallbird@foxmail.com>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
 net/rds/tcp_recv.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/rds/tcp_recv.c b/net/rds/tcp_recv.c
index ffe843ca219c..2044b8551b4f 100644
--- a/net/rds/tcp_recv.c
+++ b/net/rds/tcp_recv.c
@@ -205,9 +205,26 @@ static int rds_tcp_data_recv(read_descriptor_t *desc, struct sk_buff *skb,
 			offset += to_copy;
 
 			if (tc->t_tinc_hdr_rem == 0) {
+				u32 h_len;
+
+				h_len = be32_to_cpu(tinc->ti_inc.i_hdr.h_len);
+				if (h_len > RDS_MAX_MSG_SIZE) {
+					tc->t_tinc_hdr_rem = sizeof(struct rds_header);
+					tc->t_tinc_data_rem = 0;
+					tc->t_tinc = NULL;
+					rds_inc_put(&tinc->ti_inc);
+					tinc = NULL;
+					desc->count = 0;
+					desc->error = -EMSGSIZE;
+					rds_conn_path_error(cp,
+						"incoming message too large: %u bytes\n",
+						h_len);
+					left = 0;
+					goto out;
+				}
+
 				/* could be 0 for a 0 len message */
-				tc->t_tinc_data_rem =
-					be32_to_cpu(tinc->ti_inc.i_hdr.h_len);
+				tc->t_tinc_data_rem = h_len;
 				tinc->ti_inc.i_rx_lat_trace[RDS_MSG_RX_START] =
 					local_clock();
 			}
-- 
2.47.3

