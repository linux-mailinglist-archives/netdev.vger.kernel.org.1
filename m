Return-Path: <netdev+bounces-273266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCCfOuqlymmx+gUAu9opvQ
	(envelope-from <netdev+bounces-273266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:33:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9058535ED9C
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBD7D300B44A
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964E7386576;
	Mon, 30 Mar 2026 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeZfhOar"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C1270EC3
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888402; cv=none; b=j8s9S/jxQHeO2MKwcGBTzOW/3IgPuGMMldp2iLwGzjDkvUOqdCKhxF/mCM54yzVxLRtOT5JrPUGTcz+G9ZZ2U6PlAypurz74mYX/ZIV2diLEjcwvU2wytpxeZ0GsN9Rj58oFD0iU1MudrBEF2eDQ9YcDPZ9noB8m0VqLHN/Xfv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888402; c=relaxed/simple;
	bh=bGbFMyNnpvCVl+J0fK0MN9STuZl4qNUJD/+cYmD4OpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzFqEwL2CtxTDz2VD64YsSSDyZXZ1ognUhzgtMcqlF9qn+WN2xxSxriRSiHnW30f/X4GJqIaR8VmN6F5sxTLMADBGHW0+H/yj0dnak68flNQCImWqVc9ImfID0NwHSNHt3306DLyaCcWAzKCVfV9wZOygFuYanUZRDMcynn48F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeZfhOar; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82748257f5fso3082366b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774888401; x=1775493201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8MhflspkR5aGjRme5EkFXDYWe0+axu7ca+z2U/EdobE=;
        b=NeZfhOarwK6GEC8IqRuS5PmzQhLLx9Tup3nFB7zj4xMez+K75TIFUEq0xveereSNHR
         4su2/rT6ED326uONP4oFMpE2UAS5FaFsz7OLuL92lUX57zIzgeSvJfkL7RQRX1RlWpsU
         FkNBxHvmtjCbYko11BVepk6Qyxj06jAulx+vNRbwdU4mjnqeSzmlTdKne4bbQkPtsJOM
         ZnwtDwKChm/e+j6WzGHuMuxON2pOxd/uksr1r+hOkr3WUdfLMhOMEShhFwUAM8w0ZdHn
         hxd2e2gwhV7Q8kZynI6txCJWdsP2mvy9z50ui8ahlMKHHsRysnJh4dvnhem5rwmS8o7K
         XxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774888401; x=1775493201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MhflspkR5aGjRme5EkFXDYWe0+axu7ca+z2U/EdobE=;
        b=cTxTvSGKyvjbZoD5KN0anmLtsnLXWMMn/n0XKxOiN+ZItuQZB7mq81CEFJ3Wjos+0t
         YwWaRZz8xH+5PQdKWcJSooS3mZHuub0GKzyPjgCOmYv2WNyCEWXWouYSCdzsDHSTHmWk
         k+oktx5qk6So7QaF1f3+cFrQVoNs9LZ2Q66ozAGl9OkGf6ZERVHhiHvyn48wDfCZFLMA
         S+g8IqjKMoW1S+ShlhYcDT6g+iDzbUH5lAFh+cq+W3qwDJNZ8XWSH+vBvdWC9jGwOYuv
         q5pAnwEDLqoQt/ZzgE2b1thqLk+0Tt0GXolvuOgVq4dhar034TegmWjoTpIsYNdpp7+P
         74AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH4dLuB7T+/vrRxnNe8x+wKpEiuAUPFiEc7wmF/phQAyymCDAXbWHhuWLKYipWW1L+FwpYjew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8lPsdN2efyp7DraeHwYSR4I8R+9ZrJ3vCb9t6ThNRP9tqGBAX
	QUB8/4/9pzBk7QWheDyQ8kvZI7xfwrq3sDufTXTdRbUvCvmY0UY4i+XC
X-Gm-Gg: ATEYQzzWpdIZHwF5lomPOYBngGd9LFcTePMtHfJQCMe4cOtCeOJcgmRajn3BELb6OAu
	Y69VeX52iU1SU6PfIEvKhyyyZUtvL6mCou7TRP8NFXyNCaxIe0JBSZxDRDz/J0k3ZlIBiw2rvJ6
	6tNLZd7AE45xBMNPoy11O5w2AEoxzyUQhQKlkIXYtyWFRBMY9eCXd5R3z55NtPSv6e+jzP9tWJf
	wp8Lp9U1GPFYYltNbZ3eVtAqYNGF5FYJzhdhzmkN1S3iXcYlze+vj6SQJyo0T9oGdYniPxJaM7A
	jVeoWc1+X7ApnbKfDZP1hSe1StiCTMa5Aaw/iNHmA5OVdeVc78OYQ7Yt5LuRgp46c4Eqjv0hexL
	HppAXZ+qE937eihYYdgcnMdMzsyU87ciz+L066WB72KsuJ/80uweWREsBKaQgOGveDrPQ2o07YN
	JIcy/0pZUw5g/aUbSiJgW8eBMKWWvW66dPyi+4ruKsiH8hd0vr/xLfASv5cXzFbnycyn3T0jbL5
	WPIkGbo1CzN
X-Received: by 2002:a05:6a00:17a8:b0:824:3ef6:a815 with SMTP id d2e1a72fcca58-82cd623571bmr198850b3a.8.1774888400531;
        Mon, 30 Mar 2026 09:33:20 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc6e9sm9137762b3a.46.2026.03.30.09.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 09:33:19 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Allison Henderson <allison.henderson@oracle.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] rds: ib: reject FRMR registration before IB connection is established
Date: Tue, 31 Mar 2026 00:32:38 +0800
Message-ID: <20260330163237.2752440-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-273266-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9058535ED9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rds_ib_get_mr() extracts the rds_ib_connection from conn->c_transport_data
and passes it to rds_ib_reg_frmr() for FRWR memory registration. On a
fresh outgoing connection, ic is allocated in rds_ib_conn_alloc() with
i_cm_id = NULL because the connection worker has not yet called
rds_ib_conn_path_connect() to create the rdma_cm_id. When sendmsg() with
RDS_CMSG_RDMA_MAP is called on such a connection, the sendmsg path parses
the control message before any connection establishment, allowing
rds_ib_post_reg_frmr() to dereference ic->i_cm_id->qp and crash the
kernel.

The existing guard in rds_ib_reg_frmr() only checks for !ic (added in
commit 9e630bcb7701), which does not catch this case since ic is allocated
early and is always non-NULL once the connection object exists.

 KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
 RIP: 0010:rds_ib_post_reg_frmr+0x50e/0x920
 Call Trace:
  rds_ib_post_reg_frmr (net/rds/ib_frmr.c:167)
  rds_ib_map_frmr (net/rds/ib_frmr.c:252)
  rds_ib_reg_frmr (net/rds/ib_frmr.c:430)
  rds_ib_get_mr (net/rds/ib_rdma.c:615)
  __rds_rdma_map (net/rds/rdma.c:295)
  rds_cmsg_rdma_map (net/rds/rdma.c:860)
  rds_sendmsg (net/rds/send.c:1363)
  ____sys_sendmsg
  do_syscall_64

Add a check in rds_ib_get_mr() that verifies ic, i_cm_id, and qp are all
non-NULL before proceeding with FRMR registration, mirroring the guard
already present in rds_ib_post_inv(). Return -ENODEV when the connection
is not ready, which the existing error handling in rds_cmsg_send() converts
to -EAGAIN for userspace retry and triggers rds_conn_connect_if_down() to
start the connection worker.

Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/rds/ib_rdma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
index 077f7041df155..2cfec252eeac2 100644
--- a/net/rds/ib_rdma.c
+++ b/net/rds/ib_rdma.c
@@ -604,8 +604,13 @@ void *rds_ib_get_mr(struct scatterlist *sg, unsigned long nents,
 		return ibmr;
 	}
 
-	if (conn)
+	if (conn) {
 		ic = conn->c_transport_data;
+		if (!ic || !ic->i_cm_id || !ic->i_cm_id->qp) {
+			ret = -ENODEV;
+			goto out;
+		}
+	}
 
 	if (!rds_ibdev->mr_8k_pool || !rds_ibdev->mr_1m_pool) {
 		ret = -ENODEV;
-- 
2.43.0


