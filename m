Return-Path: <netdev+bounces-258929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCVjFC5Nk2mi3AEAu9opvQ
	(envelope-from <netdev+bounces-258929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 18:00:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C479D14686A
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 18:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3214301DED0
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F1429B204;
	Mon, 16 Feb 2026 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3d21Hcp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA01DE885
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771261225; cv=none; b=mkhyyFw71K+UXZ0oaGQPQVDbNVO7bk1W1UGRIT0o164/tYLu0HaXCMY7gmh8J0ZEer/re2exJ3Vk1O8FFMCaJktCagewBSrqzEqxk3Jf6VVBeOTbUiE4iREYFwAVcuJykdfrxUx1i3R1PKx2jAl5uprLdjsiyeiPSYdNHX2YJ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771261225; c=relaxed/simple;
	bh=9gRLJcy79or1/WKvApiFk44TE/4+RkpzZaCO0pyJipg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y5F7IJp6wfIEJeWPZ/pZAln3lOxil0ppjh9rfDu/7haY3bweX5Qkul8Ne93ZRaNxJJ6MmLsmUyy3DK2ARRr6N9Cfh229KBaYwuavDNJbDzy6i1O4c8O+MZey9FWPiHFw16s6LRZVPNqnZXJ397rmRkrgeAMqQ0OD+ScW7zOsuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3d21Hcp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824a3509a12so1928511b3a.2
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 09:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771261224; x=1771866024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O6RL6PqLI4urJjmYITsxktReGvY/7dE5J3r1kbbY2fw=;
        b=a3d21HcpXgsAvb6B2mbIFGgxKxohcoF7s4y+MXCGYiQvynPUx+f1c+INhQgD8+lyc8
         GcHTfxnLvBT87RbY3Xx8nZ8NYfsUBisnZba0BY27JF7Ki44++J7fYNZLa0fH9MOT3KnW
         uAUSQtuvnq14mhfM+lFchFNAL0LlvucfUCdi8CeuO4HqOzBcPnY0sWSqo715HDCjZCUZ
         TVfhuJAHq6O8FwTJFB6wJt9CUuDIACJkvDE6UvY9+u3a1shM6htePax/k97b/k7b8Tre
         wmvPaiVq7HpDv8PIWIXCULFNk2IYlhQ2OIesanCU9n8L7d/Uog3+Se3AGfs519Tu/6e/
         syCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771261224; x=1771866024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6RL6PqLI4urJjmYITsxktReGvY/7dE5J3r1kbbY2fw=;
        b=trhcQWcCyEK1jp/eo7xTd/XsEtLjgDKmla6/gj624rm1pB4Drmk3EDP859EfcC7ttM
         0Y0Mye0+voj94Ql7GpCsD7Lpy0+438ux2fMDpFoBmC35lvMd9tAOCf1HBlPTU56UqGkY
         /W8xkmcznAWo5uuzIibUQZwxaLam4TvMbtJEfmTskZZPnljiP9B7Ioq9fwcbDEVl7VLJ
         zukW4/BIfYvgKCm1QC1cO8RSNgB1nOOI7w3nUZI0ACxZ+b7uQpvtBpSOHlxdYGOu8QgU
         vitDQvDIYnImntO9LMk1nRpqIHtk2eBMs7oe8NmU/1RdtGGJU+J4+Z5p7U4xV8x8RBSk
         1m5A==
X-Gm-Message-State: AOJu0YwhuIR/y4/bcv9lsOqpS2PNjpURR1pRwY7TFPbFiPigpKpom1V0
	MUUc5Lxx3sH+H8NcHJJ9G5ZWwhMbZFY07P8Gs9S2LBZxU1NmiwNMfmvQ
X-Gm-Gg: AZuq6aJXHd7P4FxEsbPq+CesI3qLGFkNq2oiL0yaGPJsM/fbeDv8kiqJrQgllpjBqDw
	yNmeQmlglPNwciVvX/5OyS2/GfvtkMtzvRJL9T0wglS4/xo98ndCfr/Z5W4YQshStCpPrVf7IQm
	Vq3qfzT2L58FX66uEGJSUx3SebUv3W9G23Vh3v9Ee7ksXGZdO7ryYNXywybQzfU8qMuk7fnLl6n
	VzHW8BajgRJ6r0rYsmFUL0qjSdBQNalFvI6hbzoHYEezLOxuJZnePE7/Cx2wlx+u48hpnRAiLYX
	BXCH0r3FOGLFaxIWBE/M9hGhHj+P3LIfnXUY8S2u0JYK4vUSjZMIICdFIihSCNGL949wuDo9BhP
	LXF2QD38uD5DtPIrJ/S4B+KX6KQaViFQpXYWbHmkxSkR4VBRS29fPkC5y7njtcQS7uga03tROxN
	1oCSw4B9smmo+GctJUYTfy5iWOWEKb5CYfb0r7XUvqFRbPm1nc8KO6dj7uK0mDe7a8cMdb
X-Received: by 2002:a05:6a00:a111:b0:81b:13c5:b6b2 with SMTP id d2e1a72fcca58-824c95c1151mr9294051b3a.33.1771261223326;
        Mon, 16 Feb 2026 09:00:23 -0800 (PST)
Received: from sean-All-Series.. (1-160-221-65.dynamic-ip.hinet.net. [1.160.221.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a431f2sm11940512b3a.22.2026.02.16.09.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 09:00:22 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH] treewide: fix unused variable and format-truncation warnings
Date: Tue, 17 Feb 2026 01:00:04 +0800
Message-Id: <20260216170004.448754-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-258929-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C479D14686A
X-Rspamd-Action: no action

Address several compiler warnings across NFS and MACB drivers to
enable a cleaner build:

- nfs: add __maybe_unused to 'err' in flexfilelayout.c
- nfs: add __maybe_unused to 'ret' in flexfilelayoutdev.c
- nfs: add __maybe_unused to 'ptr' in nfs4proc.c
- macb: use precision specifier in snprintf to ensure string fits
  within ETH_GSTRING_LEN (32 bytes) in macb_main.c

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c  | 4 ++--
 fs/nfs/flexfilelayout/flexfilelayout.c    | 2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 3 ++-
 fs/nfs/nfs4proc.c                         | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 43cd013bb70e..26f9ccadd9f6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3159,8 +3159,8 @@ static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 			for (i = 0; i < QUEUE_STATS_LEN; i++, p += ETH_GSTRING_LEN) {
-				snprintf(stat_string, ETH_GSTRING_LEN, "q%d_%s",
-						q, queue_statistics[i].stat_string);
+				snprintf(stat_string, ETH_GSTRING_LEN, "q%u_%.19s",
+					 q, queue_statistics[i].stat_string);
 				memcpy(p, stat_string, ETH_GSTRING_LEN);
 			}
 		}
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


