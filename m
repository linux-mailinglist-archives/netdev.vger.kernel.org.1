Return-Path: <netdev+bounces-274247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJwQC9F1zWnYdgYAu9opvQ
	(envelope-from <netdev+bounces-274247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 21:45:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE11537FED4
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 21:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 576FA304EF20
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 19:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3051FBEA8;
	Wed,  1 Apr 2026 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ps3qzglP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A72A2264D3
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775072717; cv=none; b=I5jH97OqwWTRsWCGuyO4NrjZ3cr35FbpSMiCnmj+gHA4QsY5LiAw0mOSa3ozHrwX8qeQPCp4/sIXdze/zogIr3D3Mlua64JATwexk0vKIor3KR6oB4EPd3f8lgX9cRqPlNm9fo8d/S0JgDEweRBbss6ClYMTtCC7S8WfRrd7ozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775072717; c=relaxed/simple;
	bh=K/C5RiQvezMqdjxGdHvqhiMKDBfTwXMlVebggJpqfAs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WkOrQDtynOYKSbqUofBlEeLIX5PNxhHlUyz0nHTNyPGwEdksn9Q1uMj+BReFFsPwwPMVLqw1qaen7NBhDtCu0XiIq8uOvkfWMkJxkFSkjYA2B+fgwaD7rJoS4UKBFnB4ypQ/56XeDaVmAV9lCp5w2nwQpEv0yW8L38PW6TeXWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ps3qzglP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76bd4feb9fso31452a12.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775072716; x=1775677516; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQP2C+IMjyjgMW+B1RfW1hGccxvNm+Zehoy+ZU6LGwk=;
        b=ps3qzglPPNEW6X3kEK9aHtJLjcRtzbBShJ5mppRqmkxfw7rbA824yZW+JFBXMAIMZe
         HxQrqv4XE4MhtythxGenHykvB9Z5wZ6KnZlHvczyXNTFqqdXFvmkrAySvqgXZFlFtTBF
         uRCElbFKKkNYKecubBGMwPcYbh+yeX0iCQLFmxKjQpN+WU9gV6BhowDl1TiIknoKTw+0
         A/j+W08qoWTCJY3MJC7keKclapnOGl5rXJAR5w/tpyEWxY5pOzkHLOGGrYvjkNZtp7OE
         51t7c9a82hUsA/cK4Y6HUEKdWrwGMCLkA8Bqx3GD5W2dju/9HZgJIfIOaRCe/84iE52i
         olXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775072716; x=1775677516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQP2C+IMjyjgMW+B1RfW1hGccxvNm+Zehoy+ZU6LGwk=;
        b=Q4cfHlcctapCodl6pf8/XIxDb6nr35BJ1oC9GcypOU4Komb1cKvnSQNoX5ln1jZhgy
         LNR5SYzc7trmiCOPmbHjvPP0mL+bRxPXpTu0BTLTrBwDu+lLhHczh1BBJ9DDpB44pBTH
         5anLqhyeu92O63VwjSPowQST0a7e4/SiN/hoa1LklD/xcKue3dPQmEvxVAJD02GH53je
         K7Dgu1L7Eoq4L+DvsBFB1q7dPqaIcPwibm6fJK+w+dea/2Wm2no1I/v9AZn/6VMbMWuG
         IZ+jm2xuXXRx6i85XyDoLyBGl6w4w60CsjvIkRs3AVyP7nQ/1CaUxm12owk4oFx7ANR2
         BZxA==
X-Forwarded-Encrypted: i=1; AJvYcCWv8j/MlDZw+DQWP8lXi41TgVkJYk/UOMjDcKy2QXayfOO3bEz7J2UGRw8O+OKScDnytYECo40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFwSEN2MwvcGWIkPDMOir3JfaYX0LW3TbMvhylJB/o3ptg7Nc
	c9vI/5h50dhuUjNDmokLqUNB1ki6f+DYImgqkzIuYXIUjXwXodDIovcONm4qbCdRAtIcyKT8JXW
	Glg==
X-Received: from pfbik7.prod.google.com ([2002:a05:6a00:8d07:b0:82c:da3b:301])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2343:b0:81c:446d:6bd0
 with SMTP id d2e1a72fcca58-82cfb88acbemr798432b3a.23.1775072715637; Wed, 01
 Apr 2026 12:45:15 -0700 (PDT)
Date: Wed,  1 Apr 2026 19:44:59 +0000
In-Reply-To: <20260401194501.2269200-1-praan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401194501.2269200-1-praan@google.com>
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260401194501.2269200-4-praan@google.com>
Subject: [RFC PATCH 3/4] nfs: make nfs_page pin-aware
From: Pranjal Shrivastava <praan@google.com>
To: trond.myklebust@hammerspace.com, anna@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, chuck.lever@oracle.com, jlayton@kernel.org, tom@talpey.com, 
	okorniev@redhat.com, neil@brown.name, dai.ngo@oracle.com, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274247-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE11537FED4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The migration to iov_iter_extract_pages() for Direct I/O introduces
page pinning (GUP) instead of standard page referencing. To handle this
correctly, nfs_page must track whether it holds a pin or a standard
reference.

Add a new flag, PG_PINNED, to struct nfs_page. Update the creation
path (nfs_page_create_from_page) to accept a 'pinned' boolean and
set the flag accordingly. If the page is pinned, we skip the standard
get_page() as the pin itself acts as a reference.

Update nfs_clear_request() to use unpin_user_page() instead of
put_page() when the PG_PINNED flag is set. This ensures that memory
remains safely locked for DMA and that kernel page accounting stays
consistent. Ensure subrequests inherit the pin status from their
parent request.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/direct.c          |  4 ++--
 fs/nfs/pagelist.c        | 18 +++++++++++++-----
 include/linux/nfs_page.h |  2 ++
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 48d89716193a..c8429b430181 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -370,7 +370,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 			struct nfs_page *req;
 			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
 			/* XXX do we need to do the eof zeroing found in async_filler? */
-			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
+			req = nfs_page_create_from_page(dreq->ctx, pagevec[i], false,
 							pgbase, pos, req_len);
 			if (IS_ERR(req)) {
 				result = PTR_ERR(req);
@@ -898,7 +898,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			struct nfs_page *req;
 			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
 
-			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
+			req = nfs_page_create_from_page(dreq->ctx, pagevec[i], false,
 							pgbase, pos, req_len);
 			if (IS_ERR(req)) {
 				result = PTR_ERR(req);
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index a9373de891c9..72d3da0fb654 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -413,11 +413,14 @@ static void nfs_page_assign_folio(struct nfs_page *req, struct folio *folio)
 	}
 }
 
-static void nfs_page_assign_page(struct nfs_page *req, struct page *page)
+static void nfs_page_assign_page(struct nfs_page *req, struct page *page, bool pinned)
 {
 	if (page != NULL) {
 		req->wb_page = page;
-		get_page(page);
+		if (pinned)
+			set_bit(PG_PINNED, &req->wb_flags);
+		else
+			get_page(page);
 	}
 }
 
@@ -435,6 +438,7 @@ static void nfs_page_assign_page(struct nfs_page *req, struct page *page)
  */
 struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
 					   struct page *page,
+					   bool pinned,
 					   unsigned int pgbase, loff_t offset,
 					   unsigned int count)
 {
@@ -446,7 +450,7 @@ struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
 	ret = nfs_page_create(l_ctx, pgbase, offset >> PAGE_SHIFT,
 			      offset_in_page(offset), count);
 	if (!IS_ERR(ret)) {
-		nfs_page_assign_page(ret, page);
+		nfs_page_assign_page(ret, page, pinned);
 		nfs_page_group_init(ret, NULL);
 	}
 	nfs_put_lock_context(l_ctx);
@@ -500,7 +504,8 @@ nfs_create_subreq(struct nfs_page *req,
 		if (folio)
 			nfs_page_assign_folio(ret, folio);
 		else
-			nfs_page_assign_page(ret, page);
+			nfs_page_assign_page(ret, page,
+					     test_bit(PG_PINNED, &req->wb_flags));
 		/* find the last request */
 		for (last = req->wb_head;
 		     last->wb_this_page != req->wb_head;
@@ -556,7 +561,10 @@ static void nfs_clear_request(struct nfs_page *req)
 		req->wb_folio = NULL;
 		clear_bit(PG_FOLIO, &req->wb_flags);
 	} else if (page != NULL) {
-		put_page(page);
+		if (test_and_clear_bit(PG_PINNED, &req->wb_flags))
+			unpin_user_page(page);
+		else
+			put_page(page);
 		req->wb_page = NULL;
 	}
 	if (l_ctx != NULL) {
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index afe1d8f09d89..cae67540a2ae 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -37,6 +37,7 @@ enum {
 	PG_REMOVE,		/* page group sync bit in write path */
 	PG_CONTENDED1,		/* Is someone waiting for a lock? */
 	PG_CONTENDED2,		/* Is someone waiting for a lock? */
+	PG_PINNED,		/* page is pinned by GUP */
 };
 
 struct nfs_inode;
@@ -124,6 +125,7 @@ struct nfs_pageio_descriptor {
 
 extern struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
 						  struct page *page,
+						  bool pinned,
 						  unsigned int pgbase,
 						  loff_t offset,
 						  unsigned int count);
-- 
2.53.0.1185.g05d4b7b318-goog


