Return-Path: <netdev+bounces-258935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPmsADZZk2k73wEAu9opvQ
	(envelope-from <netdev+bounces-258935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 18:51:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5018B146CCC
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 18:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DE0F303B4D3
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9010E2D838C;
	Mon, 16 Feb 2026 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEmjYkNO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6584A2D594F
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771264224; cv=none; b=CZYwS18e1mbmjAl0dHOPDa7sCh1ipSFyF5jxRrMD9FMEiVmidnPJ3+y8XfFzpWSX54LzDU1xGk/F5cQAiH44KArMYDnx+dOStgOHEDvddpN3d6e7eirscSsQT0OJhzdbC5yRcxQ5f/2nOconByZfs0K9Ub7mO2g273P3/oyJxfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771264224; c=relaxed/simple;
	bh=OhLlJdfub68wsqiuIcNAysh6DESAcagCg9V9R9ZGezM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cw+FBA+NVIEigRwmWmzKPoJDC66lmFNMGYCuoM5CLE2HbeHC7UasBR/AnsqSWoRqSRXgTo1qD9UYolNRZ8oJodB3zT/+23PQstLq+0hcIYdzDghTZ0MJxY/ZG+chZfNMOjcs3/b1vJJQBhTzyNHXG6QYAqlxJUoXGm7QgfGmTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEmjYkNO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aae146b604so25339805ad.3
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 09:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771264223; x=1771869023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWXugJ7pkozWruS9u5HwQMOEsQfsdrcSGiRojbS23TY=;
        b=DEmjYkNOzuoRlD7uEvKB/4bqRkwGWX2XMIF2n/bWc99bIRedxWdSKjiLIDGfTihhI6
         JgsvIFhE/ZzpczFIlPrgjXs+5RBNxzLonyCqkMNELEjae77AZRd0UP42y4CK4xiTRmTC
         pNct2TIt8LkYP8vTgaYDw5xo4ZXTDE6nhv5amwJzHWfJUQo4wVAjgBFpSINXXs+cdpfm
         BnOQkXS/VYYonJVIk7cZMMWpEtFFazshfesaOynpuw6Rs2fkIDhAqnlKutHnAKGEvOST
         rsx/X/n+KQgMR5mR1+NJIzN4+2+CPqALp96idgmdyX5ZhTaOWLaFZKgrkh5jzpAu8euY
         5TNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771264223; x=1771869023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LWXugJ7pkozWruS9u5HwQMOEsQfsdrcSGiRojbS23TY=;
        b=FP6nFcc3AXTkHyklb8oJ5pHVC6hjOIF2uH7KFghVx0M/sVJgUf5k35Ca1F1YiEZZhF
         YOzZf0f6K1oj5lIvu0lQ6w0e3F6S9X3Uwx1Pno7sBokVae+790E8M2ossjRuSNhPTQuI
         DPBpMBPV0jPn0Uyi4aOZJDuKUCs4SEa2s0eN9XwDBMg9KnUvQJcctnDTKMts0sssx9pM
         cWRRxnhjNjAT5UJE559f8MOEBqLwZPYc61HMJzjZbWSOvENhY98IUGqtFBIfsQu/yrxc
         Wy4ifBL+CK1xcAzcDo10VE+wdvnWGLpUn9rrPOWcyQePwlT6XmpZ/qews3SYic4h3xkT
         fuuQ==
X-Gm-Message-State: AOJu0Yz1W6NFdI6bNqruU7gNtXyCKVl6RUfJ7htxOJYmSIiOGxjEdllb
	44gCACdlnhjAC/X3WyZhtSa83odtLzz45b3cirr3KcMhy4jU/A4yB79d
X-Gm-Gg: AZuq6aIBYUOy+kwqqjoBPqCHZd5ht1OVVSWgqABvJ0NyOOqGB1fgOtyC4zjIsydJT1s
	7tFJC3ahBWH0ZKVzh/EGBnrKRq45fpn1KDNJE70Ts8LeSD0nmR/qCZFcgStTrooNkFl3Y+uxisr
	sJIIHLBacxVgVpeqjLXuQz7M/lzCd3oUfVRUbW92AWPHXzOm2vVOUI2Ldj1MKPQOl0Wq5y6sxNO
	gTCTKYvccC9/DIpsjdpriB1Jc45bvhSsxj5Ijk8vV+sLTfTnR6z9WfEHtMF05s59LxCL5eagjQN
	q1x7kUAmZi3zPT6bBPtkcCQadxhmaZUiDJvMeM7oLYUFzJ3MUw1DtnaoV1aXUF8qNivYsoL3Ny5
	8kNtB6RHZObSz1eJw3LdVrs8MGGQQsd6wLXEC3UTmLZGUctFRZ9dfSofeDw7VZ+fB5M46KKG163
	4Cd1mPgmLxMNms7zRlhgMr2AXFShzTGiqrJC5GYoGXNPwftWhTIWJMFdm+6NE9jluQGYiM
X-Received: by 2002:a17:903:380b:b0:2aa:e6c8:2c70 with SMTP id d9443c01a7336-2ab4d0b78e8mr112766415ad.60.1771264222781;
        Mon, 16 Feb 2026 09:50:22 -0800 (PST)
Received: from sean-All-Series.. (1-160-221-65.dynamic-ip.hinet.net. [1.160.221.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5c58sm80759155ad.59.2026.02.16.09.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 09:50:22 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v2 1/2] nfs: fix unused variable warnings
Date: Tue, 17 Feb 2026 01:49:49 +0800
Message-Id: <20260216174950.455244-2-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216174950.455244-1-seanwascoding@gmail.com>
References: <20260216174950.455244-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-258935-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5018B146CCC
X-Rspamd-Action: no action

Add __maybe_unused to variables only used in specific configurations
to silence compiler warnings found during RISC-V builds.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
v2:
- Split the original treewide patch into subsystem-specific commits.
- Added more detailed commit descriptions to satisfy checkpatch.

 fs/nfs/flexfilelayout/flexfilelayout.c    | 2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 3 ++-
 fs/nfs/nfs4proc.c                         | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 9056f05a67dc..de9e8bad6af2 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1502,7 +1502,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 {
 	struct nfs4_ff_layout_mirror *mirror;
 	u32 status = *op_status;
-	int err;
+	int err __maybe_unused;
 
 	if (status == 0) {
 		switch (error) {
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index c2d8a13a9dbd..3fb8dba0abf5 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -53,7 +53,8 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	u32 mp_count;
 	u32 version_count;
 	__be32 *p;
-	int i, ret = -ENOMEM;
+	int i;
+	int ret __maybe_unused = -ENOMEM;
 
 	/* set up xdr stream */
 	scratch = folio_alloc(gfp_flags, 0);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 180229320731..f76c23cdc888 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9241,7 +9241,7 @@ static int _nfs4_proc_create_session(struct nfs_client *clp,
 int nfs4_proc_create_session(struct nfs_client *clp, const struct cred *cred)
 {
 	int status;
-	unsigned *ptr;
+	unsigned *ptr __maybe_unused;
 	struct nfs4_session *session = clp->cl_session;
 	struct nfs4_add_xprt_data xprtdata = {
 		.clp = clp,
-- 
2.34.1


