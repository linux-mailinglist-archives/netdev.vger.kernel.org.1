Return-Path: <netdev+bounces-260596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EEHMLjYnWk0SQQAu9opvQ
	(envelope-from <netdev+bounces-260596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:58:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6407B18A2E9
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73DDD30895A4
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034AB3A9634;
	Tue, 24 Feb 2026 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwYJIlxL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D13A9DA5
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952105; cv=none; b=YbUqeBzZklqUbVX0otDgrOAcfmprzJmDB6X+i2Y786IyCGhgEQbYYbOSRuEULyfzVB0LaE9ved7xrg+8jJvDtQR4NoM35Q6qPOST8cBsFoQP7KrdpGfGqetvMM5pQNK9ZQHLe0ycWSDcgVOKpCCg1Jeu/A3E4FBD0cJUQaTL+X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952105; c=relaxed/simple;
	bh=YQW0EfAeLICvyMNg/tfBC2TK594tWmLxtymR/cKwzGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lWHgYY8w+X4T0g4qReWhYkDBg3kRIlwz5pBusJ/N+PcD+GLaVVc7094XjMlBhUQH70/uwn5scM+jPjn6kWkPIcPmk2WRooWZCJ1oB+2ZGr/z5py525SFk8YFU7a1qDwPXut+2d9f1HOISGOw1cucJhIkH2593mCaKSggUeFJsfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwYJIlxL; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8249aca0affso3064429b3a.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 08:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771952104; x=1772556904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qm9aAVKRhdXbmvZ9eNzRctppVAHInh8i2MIXKl/+Wg=;
        b=mwYJIlxLKjYKko/wvpn5zNTqn2jXpvmo24X3KL/Sly2GOmvJgmanjwa6FRfv8AmIxA
         GobsqqCl1Uca57eQb2CS74RpHbkc51PYcdApnoLaSgo/nJnFEmn19oWv9o4ndS6b1FuZ
         BDQqQ5wBiRfNnFSAHnJ5/dqNJWRWR76YUdn7nXRdcz3035bktqpMAcd3kdsDNqX18O2Z
         7npt+V0pXaHV5Aa5Tbyqwxs37WYK8zUeKj9jSbTyKD6hYdmc92WjEDNGe9E9tgok0H0z
         HZEjlyQetw0rlq+L/aEsKdLeBVnrfamPuPhGVkB2MjDPA6gbPWORuWkhyYFyhkmL/Ynp
         mgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952104; x=1772556904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+qm9aAVKRhdXbmvZ9eNzRctppVAHInh8i2MIXKl/+Wg=;
        b=SnI2uIMci2pyvApASAOZjy1HZ/EvosvbHNq1/G4vOXT+FVnZ1YvQecbk/L5xOkudB6
         wyWLPNbiznk2lNSwEo9czdyWSb6vEaFTMxEBNumfapT89DmFMMij8pIm0TnOS3fcbuWB
         RmIin4Aimc+z6JfmzW0Br9+3bXS+M9qtSKOCmmNnM2in5fjKTLkD+6/5sXag/dKeSoZh
         nrqkV5ib1NOBJUcg8Q9L0mV8V4LTJ+B2LyEKj3c1yd6fZj61VugRPXzRWDWBCpj2a6/5
         a/8x88p5uGpszUl9AZsftuV+RtSG1dp2dd8EhkAsqACr1hoerab8EbUAqsCAB0IRUIis
         UxYA==
X-Gm-Message-State: AOJu0YygY9xNCRLb1s8HWH6yg08mlwnK8IsNouQNpWF6MV/SYfZ6uLNI
	C9ojzVPY3D81nYFmvvBm3BqlXRi7414DgAM5l4AUMd+niMCxdj8+Qjc3
X-Gm-Gg: AZuq6aIie7eql+gqRzYpN56YeqMsuXKkaOFnnpvmFqAhUDjRhtKaYEuKpEL/N8xOX5S
	yNEDJ1AXtrf/FplAHf5aaFWT4qmqhrChdG8cMs0Tqsh1BEM8O7ztZY9FZcPiavEDT2kr/CS+9lL
	PdnPxRBinbJ+MwvKkRi7xZx2u9AlItWcnpz2EZCimciccvilDS/h29E/NjFz4FlZbB5m78/6kxx
	8pF1AwKUcZu78WOoOzqL1FHjTNX1RbWoGfIw5KNEU1h8It0S1md9Zr9vVPAxQCvkxBBaXoWsecw
	P6lqCotKkmt5D+JDdQ0fszeJ5WVO+kT2nYgDzeMYlJd6jp9QtytQxeNnYEEj1vZTvEhOzSGE75Z
	z/bghXWPrDaiHCBKjtbDhi/aBVJ3hGnDq7dInE73XQfOgY5CVCzrZce0u2ChCYEBVBO9KAxqaBi
	rqufjZVGzcnREqppVpwFkwsx4+1z3oLzgUbiu95hV+LCyc4aUjx8S24zDdVDIfjGyFvoCkfA+3F
	w==
X-Received: by 2002:a05:6a21:6d9a:b0:35f:b96d:af11 with SMTP id adf61e73a8af0-39545e3c7a7mr11945453637.5.1771952103875;
        Tue, 24 Feb 2026 08:55:03 -0800 (PST)
Received: from sean-All-Series.. (59-115-199-112.dynamic-ip.hinet.net. [59.115.199.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7256f32sm12364083a12.27.2026.02.24.08.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:55:03 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v3 1/2] nfs: fix unused variable warning when CONFIG_SUNRPC_DEBUG is disabled
Date: Wed, 25 Feb 2026 00:54:34 +0800
Message-Id: <20260224165435.17648-2-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224165435.17648-1-seanwascoding@gmail.com>
References: <20260224165435.17648-1-seanwascoding@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260596-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6407B18A2E9
X-Rspamd-Action: no action

When CONFIG_SUNRPC_DEBUG is disabled, the dprintk() macro expands to
an empty do-while loop. This causes variables used solely within
dprintk() calls to appear unused to the compiler, triggering
-Wunused-variable warnings.

Fix this by adding __maybe_unused to the affected variables. This
ensures the code builds cleanly across different configurations,
including RISC-V, ARM, and ARM64 allmodconfig, as verified in the
mailing list discussion.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
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


