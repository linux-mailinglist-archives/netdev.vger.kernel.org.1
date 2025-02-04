Return-Path: <netdev+bounces-162341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDB4A26935
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 02:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D372C163C97
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6E025765;
	Tue,  4 Feb 2025 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XStiF7wu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1125A629
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630843; cv=none; b=id9Sk0fsiv8bE3iUC+dVrHVFkTSMcDUkasmC5YGAUguG62cyCGZ9SJGYpWdyQTuNSHDnR6mEsR0RVEtJxYpJSuk2X4ErEqquHIFLtGrbrNVwaINUJLDhogXSDXOmrfn9haVkAxwVmxlZpXEKDsrGTVVM8tU1hYtXBgWMpgBoR3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630843; c=relaxed/simple;
	bh=+5KFGTo9JUmFlBPqrDaDhkKoPImfp084alANDYfLkOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jjk05AX0DY2hK09yj6iiQiPxNbvajr3j0VQufePy6SBj5MnosEc9ZrNJLs2mXIP60IdgmBEIQI9rr0atnuM3GLD6HHweGSXlf/zG+wZulbaMEO3+q7L/NPnrtpz0Up9kKKZuAT8eQrxumNqDL9W6wAtWIEWk36IMz1a7qZXQAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XStiF7wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB61C4CEE0;
	Tue,  4 Feb 2025 01:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738630842;
	bh=+5KFGTo9JUmFlBPqrDaDhkKoPImfp084alANDYfLkOo=;
	h=From:To:Cc:Subject:Date:From;
	b=XStiF7wuoZL18BcpP3BP7q1GlPP53WmDOaJjfXP3LEzo4jpnDAMo1fnfqj+LtckkP
	 JgTiM3IrdhUcAbuIgRtX7bHvU8IZAp7zPtrJ+clWvq+mTbZ8xl6+JKBcmgc/ZSDNa7
	 NJAfQIUV2DJxA5yF/gtLDDrifOr0RCiAWqTpP7bC4mT+Gdul9oqaZf3Rm3LQZGZXNe
	 HIearq6H4r8e6ExPbP+duGKsF9OSusY0On5Ot90AbuDtdrnR3Vj+T96ly/HPdPL4WB
	 7NKKdez+brCmCC2aE5FO+5cLb70LLam2iT+Pyjl9O31zg/fQvY7E/Q2gSFBuzISjFp
	 mIXluC29i1BrA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Alexander Duyck <alexanderduyck@meta.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] eth: fbnic: add MAC address TCAM to debugfs
Date: Mon,  3 Feb 2025 17:00:37 -0800
Message-ID: <20250204010038.1404268-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Duyck <alexanderduyck@meta.com>

Add read only access to the 32-entry MAC address TCAM via debugfs.
BMC filtering shares the same table so this is quite useful
to access during debug. See next commit for an example output.

Signed-off-by: Alexander Duyck <alexanderduyck@meta.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
index 59951b5abdb7..ac80981f67c0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -10,6 +10,40 @@
 
 static struct dentry *fbnic_dbg_root;
 
+static void fbnic_dbg_desc_break(struct seq_file *s, int i)
+{
+	while (i--)
+		seq_putc(s, '-');
+
+	seq_putc(s, '\n');
+}
+
+static int fbnic_dbg_mac_addr_show(struct seq_file *s, void *v)
+{
+	struct fbnic_dev *fbd = s->private;
+	char hdr[80];
+	int i;
+
+	/* Generate Header */
+	snprintf(hdr, sizeof(hdr), "%3s %s %-17s %s\n",
+		 "Idx", "S", "TCAM Bitmap", "Addr/Mask");
+	seq_puts(s, hdr);
+	fbnic_dbg_desc_break(s, strnlen(hdr, sizeof(hdr)));
+
+	for (i = 0; i < FBNIC_RPC_TCAM_MACDA_NUM_ENTRIES; i++) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
+
+		seq_printf(s, "%02d  %d %64pb %pm\n",
+			   i, mac_addr->state, mac_addr->act_tcam,
+			   mac_addr->value.addr8);
+		seq_printf(s, "                        %pm\n",
+			   mac_addr->mask.addr8);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_mac_addr);
+
 static int fbnic_dbg_pcie_stats_show(struct seq_file *s, void *v)
 {
 	struct fbnic_dev *fbd = s->private;
@@ -48,6 +82,8 @@ void fbnic_dbg_fbd_init(struct fbnic_dev *fbd)
 	fbd->dbg_fbd = debugfs_create_dir(name, fbnic_dbg_root);
 	debugfs_create_file("pcie_stats", 0400, fbd->dbg_fbd, fbd,
 			    &fbnic_dbg_pcie_stats_fops);
+	debugfs_create_file("mac_addr", 0400, fbd->dbg_fbd, fbd,
+			    &fbnic_dbg_mac_addr_fops);
 }
 
 void fbnic_dbg_fbd_exit(struct fbnic_dev *fbd)
-- 
2.48.1


